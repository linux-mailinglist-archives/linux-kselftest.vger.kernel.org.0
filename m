Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E79F20F9C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jun 2020 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgF3QsS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jun 2020 12:48:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52875 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgF3QsR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jun 2020 12:48:17 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1jqJQc-0001jJ-S7; Tue, 30 Jun 2020 16:48:15 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@google.com>
Subject: [PATCH] selftests/seccomp: fix ptrace tests on powerpc
Date:   Tue, 30 Jun 2020 13:47:39 -0300
Message-Id: <20200630164739.1268222-1-cascardo@canonical.com>
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
 tools/testing/selftests/seccomp/seccomp_bpf.c | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 252140a52553..b90a9190ba88 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1738,6 +1738,14 @@ void change_syscall(struct __test_metadata *_metadata,
 		TH_LOG("Can't modify syscall return on this architecture");
 #else
 		regs.SYSCALL_RET = result;
+# if defined(__powerpc__)
+		if (result < 0) {
+			regs.SYSCALL_RET = -result;
+			regs.ccr |= 0x10000000;
+		} else {
+			regs.ccr &= ~0x10000000;
+		}
+# endif
 #endif
 
 #ifdef HAVE_GETREGS
@@ -1796,6 +1804,7 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	int ret, nr;
 	unsigned long msg;
 	static bool entry;
+	int *syscall_nr = args;
 
 	/*
 	 * The traditional way to tell PTRACE_SYSCALL entry/exit
@@ -1809,10 +1818,15 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
 			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
 
-	if (!entry)
+	if (!entry && !syscall_nr)
 		return;
 
-	nr = get_syscall(_metadata, tracee);
+	if (entry)
+		nr = get_syscall(_metadata, tracee);
+	else
+		nr = *syscall_nr;
+	if (syscall_nr)
+		*syscall_nr = nr;
 
 	if (nr == __NR_getpid)
 		change_syscall(_metadata, tracee, __NR_getppid, 0);
@@ -1889,9 +1903,10 @@ TEST_F(TRACE_syscall, ptrace_syscall_redirected)
 
 TEST_F(TRACE_syscall, ptrace_syscall_errno)
 {
+	int syscall_nr = -1;
 	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
 	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
+	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, &syscall_nr,
 					   true);
 
 	/* Tracer should skip the open syscall, resulting in ESRCH. */
@@ -1900,9 +1915,10 @@ TEST_F(TRACE_syscall, ptrace_syscall_errno)
 
 TEST_F(TRACE_syscall, ptrace_syscall_faked)
 {
+	int syscall_nr = -1;
 	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
 	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
+	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, &syscall_nr,
 					   true);
 
 	/* Tracer should skip the gettid syscall, resulting fake pid. */
-- 
2.25.1

