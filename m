Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF345214A8F
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jul 2020 08:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgGEGMq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Jul 2020 02:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGEGMj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Jul 2020 02:12:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E2C08C5DE
        for <linux-kselftest@vger.kernel.org>; Sat,  4 Jul 2020 23:12:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z3so6357132pfn.12
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Jul 2020 23:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3E0uLB2FTHGittSE2WW+VBNudtR2vmOtGreRUF/f/08=;
        b=dYnMuSbB17n9OLZDtK7z/14x0Xb0QPfd20H+TekXxuK3S2XhAXgecX1iQGY+4FZpLf
         IonmjGnoInvwbHuSEkJhm+VL9ApHm67nbCAaIG7R3fTJg66Y3BbgJap4ghLslERBhKUF
         WV7aPcWwNf0czNLJSHCY3sCIoQhaOyNMfA3XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3E0uLB2FTHGittSE2WW+VBNudtR2vmOtGreRUF/f/08=;
        b=jLqVzbJ0uC3+mUFpuTaDR4tHMmFWlyArsTd8Jj/CoY/TAMp1WIXBMj8Saf8yDh6VMy
         nAT133dxFn5W7N9UwFINxfGJ7cWQN187wO7YEHe77GOgKN+5vzVbuPDJTeQwYRWPzbn0
         ltyp01KPYmKXWCPfD8xnJRPJzLvbqANjaAvpMUZneWfh/gRDTp22AZVsq4/+bfKLZH+9
         TjdD4rVbCgN7y1VGtxslNO9dyyOF2Ph/3zbm/yWLgX0/n6ulQE2OMEv/F+sUIcV/rUWt
         bXII+n23F9ay2wbumfJBTDw1WQT7uae+v1CIQWpqMPHUksfQ9s/YDM/o9wQlsKl7f9v6
         VeSQ==
X-Gm-Message-State: AOAM530GRPPLel1MaRcnOr/1FKDJMtmjIXmM31OOJSssE00QfF+/qy6o
        XyaVBG9+8i5AJfy+fQ09NIgwUA==
X-Google-Smtp-Source: ABdhPJxCPU1z+SvR3EFcNeiEW/8U1XFg952c7+MC2aV7TWlUYQ4rWpe49hTsCPFiUu/4LX3XoaRT7A==
X-Received: by 2002:a63:7c5e:: with SMTP id l30mr35179751pgn.276.1593929558913;
        Sat, 04 Jul 2020 23:12:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g135sm16340876pfb.41.2020.07.04.23.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 23:12:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] selftests/seccomp: Refactor to use fixture variants
Date:   Sat,  4 Jul 2020 23:12:31 -0700
Message-Id: <20200705061232.4151319-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200705061232.4151319-1-keescook@chromium.org>
References: <20200705061232.4151319-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that the selftest harness has variants, use them to eliminate a
bunch of copy/paste duplication.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 199 ++++--------------
 1 file changed, 42 insertions(+), 157 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 6439c031a85d..966dec340ea8 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1541,6 +1541,7 @@ pid_t setup_trace_fixture(struct __test_metadata *_metadata,
 
 	return tracer_pid;
 }
+
 void teardown_trace_fixture(struct __test_metadata *_metadata,
 			    pid_t tracer)
 {
@@ -1820,7 +1821,7 @@ void change_syscall(struct __test_metadata *_metadata,
 	EXPECT_EQ(0, ret);
 }
 
-void tracer_syscall(struct __test_metadata *_metadata, pid_t tracee,
+void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
 		    int status, void *args)
 {
 	int ret;
@@ -1897,6 +1898,24 @@ FIXTURE(TRACE_syscall) {
 	pid_t tracer, mytid, mypid, parent;
 };
 
+FIXTURE_VARIANT(TRACE_syscall) {
+	/*
+	 * All of the SECCOMP_RET_TRACE behaviors can be tested with either
+	 * SECCOMP_RET_TRACE+PTRACE_CONT or plain ptrace()+PTRACE_SYSCALL.
+	 * This indicates if we should use SECCOMP_RET_TRACE (false), or
+	 * ptrace (true).
+	 */
+	bool use_ptrace;
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
 FIXTURE_SETUP(TRACE_syscall)
 {
 	struct sock_filter filter[] = {
@@ -1912,12 +1931,11 @@ FIXTURE_SETUP(TRACE_syscall)
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1005),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
-
-	memset(&self->prog, 0, sizeof(self->prog));
-	self->prog.filter = malloc(sizeof(filter));
-	ASSERT_NE(NULL, self->prog.filter);
-	memcpy(self->prog.filter, filter, sizeof(filter));
-	self->prog.len = (unsigned short)ARRAY_SIZE(filter);
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	long ret;
 
 	/* Prepare some testable syscall results. */
 	self->mytid = syscall(__NR_gettid);
@@ -1935,60 +1953,28 @@ FIXTURE_SETUP(TRACE_syscall)
 	ASSERT_NE(self->parent, self->mypid);
 
 	/* Launch tracer. */
-	self->tracer = setup_trace_fixture(_metadata, tracer_syscall, NULL,
-					   false);
-}
-
-FIXTURE_TEARDOWN(TRACE_syscall)
-{
-	teardown_trace_fixture(_metadata, self->tracer);
-	if (self->prog.filter)
-		free(self->prog.filter);
-}
+	self->tracer = setup_trace_fixture(_metadata,
+					   variant->use_ptrace ? tracer_ptrace
+							       : tracer_seccomp,
+					   NULL, variant->use_ptrace);
 
-TEST_F(TRACE_syscall, ptrace_syscall_redirected)
-{
-	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
-	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
-					   true);
-
-	/* Tracer will redirect getpid to getppid. */
-	EXPECT_NE(self->mypid, syscall(__NR_getpid));
-}
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret);
 
-TEST_F(TRACE_syscall, ptrace_syscall_errno)
-{
-	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
-	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
-					   true);
+	if (variant->use_ptrace)
+		return;
 
-	/* Tracer should skip the open syscall, resulting in ESRCH. */
-	EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+	ASSERT_EQ(0, ret);
 }
 
-TEST_F(TRACE_syscall, ptrace_syscall_faked)
+FIXTURE_TEARDOWN(TRACE_syscall)
 {
-	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
 	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
-					   true);
-
-	/* Tracer should skip the gettid syscall, resulting fake pid. */
-	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
 }
 
 TEST_F(TRACE_syscall, syscall_allowed)
 {
-	long ret;
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
 	/* getppid works as expected (no changes). */
 	EXPECT_EQ(self->parent, syscall(__NR_getppid));
 	EXPECT_NE(self->mypid, syscall(__NR_getppid));
@@ -1996,14 +1982,6 @@ TEST_F(TRACE_syscall, syscall_allowed)
 
 TEST_F(TRACE_syscall, syscall_redirected)
 {
-	long ret;
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
 	/* getpid has been redirected to getppid as expected. */
 	EXPECT_EQ(self->parent, syscall(__NR_getpid));
 	EXPECT_NE(self->mypid, syscall(__NR_getpid));
@@ -2011,33 +1989,17 @@ TEST_F(TRACE_syscall, syscall_redirected)
 
 TEST_F(TRACE_syscall, syscall_errno)
 {
-	long ret;
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* openat has been skipped and an errno return. */
+	/* Tracer should skip the open syscall, resulting in ESRCH. */
 	EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
 }
 
 TEST_F(TRACE_syscall, syscall_faked)
 {
-	long ret;
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* gettid has been skipped and an altered return value stored. */
+	/* Tracer skips the gettid syscall and store altered return value. */
 	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
 }
 
-TEST_F(TRACE_syscall, skip_after_RET_TRACE)
+TEST_F(TRACE_syscall, skip_after)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
@@ -2052,14 +2014,7 @@ TEST_F(TRACE_syscall, skip_after_RET_TRACE)
 	};
 	long ret;
 
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install fixture filter. */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install "errno on getppid" filter. */
+	/* Install additional "errno on getppid" filter. */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
 	ASSERT_EQ(0, ret);
 
@@ -2069,7 +2024,7 @@ TEST_F(TRACE_syscall, skip_after_RET_TRACE)
 	EXPECT_EQ(EPERM, errno);
 }
 
-TEST_F_SIGNAL(TRACE_syscall, kill_after_RET_TRACE, SIGSYS)
+TEST_F_SIGNAL(TRACE_syscall, kill_after, SIGSYS)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
@@ -2084,77 +2039,7 @@ TEST_F_SIGNAL(TRACE_syscall, kill_after_RET_TRACE, SIGSYS)
 	};
 	long ret;
 
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install fixture filter. */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install "death on getppid" filter. */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Tracer will redirect getpid to getppid, and we should die. */
-	EXPECT_NE(self->mypid, syscall(__NR_getpid));
-}
-
-TEST_F(TRACE_syscall, skip_after_ptrace)
-{
-	struct sock_filter filter[] = {
-		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
-			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | EPERM),
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
-	};
-	struct sock_fprog prog = {
-		.len = (unsigned short)ARRAY_SIZE(filter),
-		.filter = filter,
-	};
-	long ret;
-
-	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
-	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
-					   true);
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install "errno on getppid" filter. */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Tracer will redirect getpid to getppid, and we should see EPERM. */
-	EXPECT_EQ(-1, syscall(__NR_getpid));
-	EXPECT_EQ(EPERM, errno);
-}
-
-TEST_F_SIGNAL(TRACE_syscall, kill_after_ptrace, SIGSYS)
-{
-	struct sock_filter filter[] = {
-		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
-			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
-	};
-	struct sock_fprog prog = {
-		.len = (unsigned short)ARRAY_SIZE(filter),
-		.filter = filter,
-	};
-	long ret;
-
-	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
-	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
-					   true);
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install "death on getppid" filter. */
+	/* Install additional "death on getppid" filter. */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
 	ASSERT_EQ(0, ret);
 
-- 
2.25.1

