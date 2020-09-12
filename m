Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD42679C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Sep 2020 13:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgILLKf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Sep 2020 07:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgILLJ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Sep 2020 07:09:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC65C06138F
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o68so9214480pfg.2
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grGRfF2oc4Mrj7QbeeTIjwfyG+77vtq6pTEp1U/ruko=;
        b=K1BHHo1evlP7HOYg1ZAzFN6YM48ETae3xI7p7rULuTb/67o1w2O4DRWN5Of3sP+nNA
         1hp7xWjAewTidrGnugC/X0nQz1mf/c7PFnmJRbgewvDbBnJaFQM3m/iV9mMms3GpIJPH
         rvw0kaANVUvR5b4Wf+1UIc1c0gKVU9OgmMr6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grGRfF2oc4Mrj7QbeeTIjwfyG+77vtq6pTEp1U/ruko=;
        b=Q1sWQABxZT1yLwSdXyo5t4SUNOiP32sdoeseKfOoRWNaMCC3PyfvJbfExSznxtD8RY
         wbJTmFumz7cY0ozJ5SVHDV/cCJ9LfDYtjBVIkU/3iaqBxTCoClmNs0WmK1f6tT4VTrcx
         svJ92MCclXO/Wg/a4WQQG9T/wutKPfgtCwAvLAwCtocdbp3LK7dhWKpuho+hym6jnhc7
         bgoGUPi0b44X4y3iSn+4dvuiaulgHTJLICby4HZnBF/HFclTmnhr96huI5O5dtncfRWP
         Z3nRd0XTOCQ6H3u1KKsT4hMK2iRqG254qsYWenrbTzxi/cJpxUF+xsUqG3o4oQwT8GnE
         TN0w==
X-Gm-Message-State: AOAM531BgJnlj3QwYu2PxdCOI5zb7MrRMCD6WZ4BgIMla4HLWE8VP80H
        D0lhzBeG2BdH1OuvSrHgv8fUdQ==
X-Google-Smtp-Source: ABdhPJz0lqRrd9ZAIbQNwHdMwokn/e8KIK1qcB2JeErSyyv6PiiwOqirwQ5yiqUysT88RrlcDZ8BVA==
X-Received: by 2002:aa7:8084:0:b029:13f:b82a:1725 with SMTP id v4-20020aa780840000b029013fb82a1725mr3857546pff.9.1599908914782;
        Sat, 12 Sep 2020 04:08:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j20sm4905489pfh.146.2020.09.12.04.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:08:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/15] selftests/seccomp: powerpc: Set syscall return during ptrace syscall exit
Date:   Sat, 12 Sep 2020 04:08:18 -0700
Message-Id: <20200912110820.597135-14-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some archs (like ppc) only support changing the return code during
syscall exit when ptrace is used. As the syscall number might not
be available anymore during syscall exit, it needs to be saved
during syscall enter. Adjust the ptrace tests to do this.

Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Link: https://lore.kernel.org/linux-kselftest/20200911181012.171027-1-cascardo@canonical.com/
Fixes: 58d0a862f573 ("seccomp: add tests for ptrace hole")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 34 +++++++++++--------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index bbab2420d708..26c712c6a575 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1949,12 +1949,19 @@ void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
 
 }
 
+FIXTURE(TRACE_syscall) {
+	struct sock_fprog prog;
+	pid_t tracer, mytid, mypid, parent;
+	long syscall_nr;
+};
+
 void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 		   int status, void *args)
 {
-	int ret, nr;
+	int ret;
 	unsigned long msg;
 	static bool entry;
+	FIXTURE_DATA(TRACE_syscall) *self = args;
 
 	/*
 	 * The traditional way to tell PTRACE_SYSCALL entry/exit
@@ -1968,24 +1975,23 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
 			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
 
-	if (!entry)
-		return;
-
-	nr = get_syscall(_metadata, tracee);
+	/*
+	 * Some architectures only support setting return values during
+	 * syscall exit under ptrace, and on exit the syscall number may
+	 * no longer be available. Therefore, save it here, and call
+	 * "change syscall and set return values" on both entry and exit.
+	 */
+	if (entry)
+		self->syscall_nr = get_syscall(_metadata, tracee);
 
-	if (nr == __NR_getpid)
+	if (self->syscall_nr == __NR_getpid)
 		change_syscall(_metadata, tracee, __NR_getppid, 0);
-	if (nr == __NR_gettid)
+	if (self->syscall_nr == __NR_gettid)
 		change_syscall(_metadata, tracee, -1, 45000);
-	if (nr == __NR_openat)
+	if (self->syscall_nr == __NR_openat)
 		change_syscall(_metadata, tracee, -1, -ESRCH);
 }
 
-FIXTURE(TRACE_syscall) {
-	struct sock_fprog prog;
-	pid_t tracer, mytid, mypid, parent;
-};
-
 FIXTURE_VARIANT(TRACE_syscall) {
 	/*
 	 * All of the SECCOMP_RET_TRACE behaviors can be tested with either
@@ -2044,7 +2050,7 @@ FIXTURE_SETUP(TRACE_syscall)
 	self->tracer = setup_trace_fixture(_metadata,
 					   variant->use_ptrace ? tracer_ptrace
 							       : tracer_seccomp,
-					   NULL, variant->use_ptrace);
+					   self, variant->use_ptrace);
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	ASSERT_EQ(0, ret);
-- 
2.25.1

