Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F5C270BB0
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Sep 2020 10:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgISIGz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Sep 2020 04:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgISIGs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Sep 2020 04:06:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2869C0613CF
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Sep 2020 01:06:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j7so4195733plk.11
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Sep 2020 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyn3p1AYDnBnQ4k/sfOfTwMI04kwqjnEmN1ZdkN/y18=;
        b=kD/ryGMRuv0D1dIxpRJqOu8zbrriTOfATRCXuG31vqWqYL2HVA/CmFftKhcfjg6OAh
         THvxy+oxlj4JaretrVlyZCpw90QqgsMbCh+vuxehWF43CuCeGbbZN7GWfX1FUJ/YSiQO
         1VGT4ayJpV2eNOsMs9f2C3di/YcgoPGjIQbfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyn3p1AYDnBnQ4k/sfOfTwMI04kwqjnEmN1ZdkN/y18=;
        b=pGu8FlGJbBnBP8paBKVQj/LTiiAwRQZrc3a4lYisa763NIt+/Wgg6KrCRdRo+c1C4/
         MUWG7muGEqgiNxfpCaFlYLCA0RL+jHJKnXXz366wl7d36X9yaspjJ8d7pv1uKBlb9+S9
         2djTQM1jLSg633M6QJeYdA5Ip1mUarlVbHqdOWYifVdKn0DvxDdwjo4u661I/4IhV48V
         ou+ZDAA7h5VTeFiAblIGau92fSItyAwwSS7Pnw5jUkZGECM0x8i2rmG1TviFFlX0kbhT
         u2maG1dNh7N2gHjATBih1AKl6N6nHFdVc7aNHVZXarhSRpsX6kDsOT/pzi+gy/dTG+ar
         FmOw==
X-Gm-Message-State: AOAM5330EuzRZrHRSpUlYCPExdZaUR/9NlWsssDFqQcfO1Bwoj38tHt5
        XBsaGnl0OyPnspa2AEpJHayXXA==
X-Google-Smtp-Source: ABdhPJzN+n3zupFhcjY/ktmA4F1rjsh5uKf1KCvEnujAg8mfVuhf7wd9EYSQZvOO+dyZ8v3HEcRy+g==
X-Received: by 2002:a17:902:8c89:b029:d2:1724:170d with SMTP id t9-20020a1709028c89b02900d21724170dmr711671plo.84.1600502807435;
        Sat, 19 Sep 2020 01:06:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n12sm5822899pgk.20.2020.09.19.01.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 01:06:45 -0700 (PDT)
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
Subject: [PATCH v2 2/4] selftests/seccomp: Allow syscall nr and ret value to be set separately
Date:   Sat, 19 Sep 2020 01:06:35 -0700
Message-Id: <20200919080637.259478-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200919080637.259478-1-keescook@chromium.org>
References: <20200919080637.259478-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for setting syscall nr and ret values separately, refactor
the helpers to take a pointer to a value, so that a NULL can indicate
"do not change this respective value". This is done to keep the regset
read/write happening once and in one code path.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 59 +++++++++++++++----
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c0311b4c736b..98ce5e8a6398 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1888,27 +1888,47 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 }
 
 /* Architecture-specific syscall changing routine. */
-void change_syscall(struct __test_metadata *_metadata,
-		    pid_t tracee, int syscall, int result)
+void __change_syscall(struct __test_metadata *_metadata,
+		    pid_t tracee, long *syscall, long *ret)
 {
 	ARCH_REGS orig, regs;
 
+	/* Do not get/set registers if we have nothing to do. */
+	if (!syscall && !ret)
+		return;
+
 	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
 		return;
 	}
 	orig = regs;
 
-	SYSCALL_NUM_SET(regs, syscall);
+	if (syscall)
+		SYSCALL_NUM_SET(regs, *syscall);
 
-	/* If syscall is skipped, change return value. */
-	if (syscall == -1)
-		SYSCALL_RET_SET(regs, result);
+	if (ret)
+		SYSCALL_RET_SET(regs, *ret);
 
 	/* Flush any register changes made. */
 	if (memcmp(&orig, &regs, sizeof(orig)) != 0)
 		EXPECT_EQ(0, ARCH_SETREGS(regs));
 }
 
+/* Change only syscall number. */
+void change_syscall_nr(struct __test_metadata *_metadata,
+		       pid_t tracee, long syscall)
+{
+	__change_syscall(_metadata, tracee, &syscall, NULL);
+}
+
+/* Change syscall return value (and set syscall number to -1). */
+void change_syscall_ret(struct __test_metadata *_metadata,
+			pid_t tracee, long ret)
+{
+	long syscall = -1;
+
+	__change_syscall(_metadata, tracee, &syscall, &ret);
+}
+
 void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
 		    int status, void *args)
 {
@@ -1924,17 +1944,17 @@ void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
 	case 0x1002:
 		/* change getpid to getppid. */
 		EXPECT_EQ(__NR_getpid, get_syscall(_metadata, tracee));
-		change_syscall(_metadata, tracee, __NR_getppid, 0);
+		change_syscall_nr(_metadata, tracee, __NR_getppid);
 		break;
 	case 0x1003:
 		/* skip gettid with valid return code. */
 		EXPECT_EQ(__NR_gettid, get_syscall(_metadata, tracee));
-		change_syscall(_metadata, tracee, -1, 45000);
+		change_syscall_ret(_metadata, tracee, 45000);
 		break;
 	case 0x1004:
 		/* skip openat with error. */
 		EXPECT_EQ(__NR_openat, get_syscall(_metadata, tracee));
-		change_syscall(_metadata, tracee, -1, -ESRCH);
+		change_syscall_ret(_metadata, tracee, -ESRCH);
 		break;
 	case 0x1005:
 		/* do nothing (allow getppid) */
@@ -1961,6 +1981,8 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	int ret;
 	unsigned long msg;
 	static bool entry;
+	long syscall_nr_val, syscall_ret_val;
+	long *syscall_nr = NULL, *syscall_ret = NULL;
 	FIXTURE_DATA(TRACE_syscall) *self = args;
 
 	/*
@@ -1987,17 +2009,30 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	else
 		return;
 
+	syscall_nr = &syscall_nr_val;
+	syscall_ret = &syscall_ret_val;
+
+	/* Now handle the actual rewriting cases. */
 	switch (self->syscall_nr) {
 	case __NR_getpid:
-		change_syscall(_metadata, tracee, __NR_getppid, 0);
+		syscall_nr_val = __NR_getppid;
+		/* Never change syscall return for this case. */
+		syscall_ret = NULL;
 		break;
 	case __NR_gettid:
-		change_syscall(_metadata, tracee, -1, 45000);
+		syscall_nr_val = -1;
+		syscall_ret_val = 45000;
 		break;
 	case __NR_openat:
-		change_syscall(_metadata, tracee, -1, -ESRCH);
+		syscall_nr_val = -1;
+		syscall_ret_val = -ESRCH;
 		break;
+	default:
+		/* Unhandled, do nothing. */
+		return;
 	}
+
+	__change_syscall(_metadata, tracee, syscall_nr, syscall_ret);
 }
 
 FIXTURE_VARIANT(TRACE_syscall) {
-- 
2.25.1

