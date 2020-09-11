Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3F8266817
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 20:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgIKSKf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Sep 2020 14:10:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50958 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgIKSKf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Sep 2020 14:10:35 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1kGnVI-0001Y9-HA; Fri, 11 Sep 2020 18:10:33 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, cascardo@canonical.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@google.com>
Subject: [PATCH v2] selftests/seccomp: fix ptrace tests on powerpc
Date:   Fri, 11 Sep 2020 15:10:12 -0300
Message-Id: <20200911181012.171027-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As pointed out by Michael Ellerman, the ptrace ABI on powerpc does not
allow or require the return code to be set on syscall entry when
skipping the syscall. It will always return ENOSYS and the return code
must be set on syscall exit.

This code does that, behaving more similarly to strace. It still sets
the return code on entry, which is overridden on powerpc, and it will
always repeat the same on exit. Also, on powerpc, the errno is not
inverted, and depends on ccr.so being set.

This has been tested on powerpc and amd64.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kees Cook <keescook@google.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 81 ++++++++++++-------
 1 file changed, 53 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 7a6d40286a42..0ddc0846e9c0 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1837,15 +1837,24 @@ void change_syscall(struct __test_metadata *_metadata,
 #endif
 
 	/* If syscall is skipped, change return value. */
-	if (syscall == -1)
+	if (syscall == -1) {
 #ifdef SYSCALL_NUM_RET_SHARE_REG
 		TH_LOG("Can't modify syscall return on this architecture");
-
 #elif defined(__xtensa__)
 		regs.SYSCALL_RET(regs) = result;
+#elif defined(__powerpc__)
+		/* Error is signaled by CR0 SO bit and error code is positive. */
+		if (result < 0) {
+			regs.SYSCALL_RET = -result;
+			regs.ccr |= 0x10000000;
+		} else {
+			regs.SYSCALL_RET = result;
+			regs.ccr &= ~0x10000000;
+		}
 #else
 		regs.SYSCALL_RET = result;
 #endif
+	}
 
 #ifdef HAVE_GETREGS
 	ret = ptrace(PTRACE_SETREGS, tracee, 0, &regs);
@@ -1897,12 +1906,44 @@ void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
 
 }
 
+FIXTURE(TRACE_syscall) {
+	struct sock_fprog prog;
+	pid_t tracer, mytid, mypid, parent;
+};
+
+FIXTURE_VARIANT(TRACE_syscall) {
+	/*
+	 * All of the SECCOMP_RET_TRACE behaviors can be tested with either
+	 * SECCOMP_RET_TRACE+PTRACE_CONT or plain ptrace()+PTRACE_SYSCALL.
+	 * This indicates if we should use SECCOMP_RET_TRACE (false), or
+	 * ptrace (true).
+	 */
+	bool use_ptrace;
+
+	/*
+	 * Some archs (like ppc) only support changing the return code during
+	 * syscall exit when ptrace is used.  As the syscall number might not
+	 * be available anymore during syscall exit, it needs to be saved
+	 * during syscall enter.
+	 */
+	int syscall_nr;
+};
+
+FIXTURE_VARIANT_ADD(TRACE_syscall, ptrace) {
+	.use_ptrace = true,
+};
+
+FIXTURE_VARIANT_ADD(TRACE_syscall, seccomp) {
+	.use_ptrace = false,
+};
+
 void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 		   int status, void *args)
 {
 	int ret, nr;
 	unsigned long msg;
 	static bool entry;
+	FIXTURE_VARIANT(TRACE_syscall) * variant = args;
 
 	/*
 	 * The traditional way to tell PTRACE_SYSCALL entry/exit
@@ -1916,10 +1957,15 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
 			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
 
-	if (!entry)
+	if (!entry && !variant)
 		return;
 
-	nr = get_syscall(_metadata, tracee);
+	if (entry)
+		nr = get_syscall(_metadata, tracee);
+	else if (variant)
+		nr = variant->syscall_nr;
+	if (variant)
+		variant->syscall_nr = nr;
 
 	if (nr == __NR_getpid)
 		change_syscall(_metadata, tracee, __NR_getppid, 0);
@@ -1929,29 +1975,6 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 		change_syscall(_metadata, tracee, -1, -ESRCH);
 }
 
-FIXTURE(TRACE_syscall) {
-	struct sock_fprog prog;
-	pid_t tracer, mytid, mypid, parent;
-};
-
-FIXTURE_VARIANT(TRACE_syscall) {
-	/*
-	 * All of the SECCOMP_RET_TRACE behaviors can be tested with either
-	 * SECCOMP_RET_TRACE+PTRACE_CONT or plain ptrace()+PTRACE_SYSCALL.
-	 * This indicates if we should use SECCOMP_RET_TRACE (false), or
-	 * ptrace (true).
-	 */
-	bool use_ptrace;
-};
-
-FIXTURE_VARIANT_ADD(TRACE_syscall, ptrace) {
-	.use_ptrace = true,
-};
-
-FIXTURE_VARIANT_ADD(TRACE_syscall, seccomp) {
-	.use_ptrace = false,
-};
-
 FIXTURE_SETUP(TRACE_syscall)
 {
 	struct sock_filter filter[] = {
@@ -1992,7 +2015,9 @@ FIXTURE_SETUP(TRACE_syscall)
 	self->tracer = setup_trace_fixture(_metadata,
 					   variant->use_ptrace ? tracer_ptrace
 							       : tracer_seccomp,
-					   NULL, variant->use_ptrace);
+					   variant->use_ptrace ? (void *) variant
+							       : NULL,
+					   variant->use_ptrace);
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	ASSERT_EQ(0, ret);
-- 
2.25.1

