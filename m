Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AB9270BB1
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Sep 2020 10:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgISIG5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Sep 2020 04:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgISIGu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Sep 2020 04:06:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA624C0613D2
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Sep 2020 01:06:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so4421129pjb.0
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Sep 2020 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrLryApnJ9OrHIHAcwmpSGY4TxWSaJUHtyhtfo3Txxc=;
        b=jgNwfK9rxr13QjIMA849prWXlVCgyfZx2+W0ylmX0aAIoJx1/qaNXA3wOcHdeOJlUp
         2s3/qxs3FuB9H4lpwpHPrlrdp8/Q81BN9i8c12BTmQjY+cDMr1EtxTC2UPe4acoCa3T5
         NgH4X89TkMDe7v6pAN1GmhBpZYl1R92hWMTxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrLryApnJ9OrHIHAcwmpSGY4TxWSaJUHtyhtfo3Txxc=;
        b=mK7Me2YTZ8A78sku4hftprqR/ZHABSUsuvcceuqeHDrOXN2UzfMCQlbf1VE9F+WEOq
         Qqs6ITxXmt7gHcL4lZk2VbWpTZZunNL64qBTVp5XXPBoYOWJKnBAF24PbsMolkyLh69j
         K9ifoxviabsbOBXpM6gp2yUkf3RzDcpgBeEi409NDrVwaCxcRHszekDZG4Fx0rRSkTKL
         TPlvsEqbr8HoN+2EVqVFThAfx1m4GUSHXVtyOzu5KY093/OkrKLy/pmSJtR/j9RK1yDY
         M9Zdec2r2hAQFRsJkQN1YIV7Wnsk7/y3KYvHHQnLHDK8vX2GQq/ze58GvQk5ZHsovDUB
         Cm+g==
X-Gm-Message-State: AOAM532DG8VBvdahi92QZLrAHhxe7b/YPOXSvhiWP1PrS5AHXrHU8du4
        dtJ5cHTHa+7OuRHq7nJNMCw55w==
X-Google-Smtp-Source: ABdhPJxzGPHSPF8+6O/bh2fwfZiDgn7d7ypRGUb1tocspyrduFRi0uPCbZiKy5aQ8tiKYFmJtWgo5A==
X-Received: by 2002:a17:902:9041:b029:d0:cc02:8540 with SMTP id w1-20020a1709029041b02900d0cc028540mr35396678plz.41.1600502809446;
        Sat, 19 Sep 2020 01:06:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m5sm4824996pjn.19.2020.09.19.01.06.44
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
Subject: [PATCH v2 1/4] selftests/seccomp: Record syscall during ptrace entry
Date:   Sat, 19 Sep 2020 01:06:34 -0700
Message-Id: <20200919080637.259478-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200919080637.259478-1-keescook@chromium.org>
References: <20200919080637.259478-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for performing actions during ptrace syscall exit, save
the syscall number during ptrace syscall entry. Some architectures do
no have the syscall number available during ptrace syscall exit.

Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Link: https://lore.kernel.org/linux-kselftest/20200911181012.171027-1-cascardo@canonical.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 40 +++++++++++++------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index bc0fb463c709..c0311b4c736b 100644
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
@@ -1968,24 +1975,31 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
 			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
 
-	if (!entry)
+	/*
+	 * Some architectures only support setting return values during
+	 * syscall exit under ptrace, and on exit the syscall number may
+	 * no longer be available. Therefore, save the initial sycall
+	 * number here, so it can be examined during both entry and exit
+	 * phases.
+	 */
+	if (entry)
+		self->syscall_nr = get_syscall(_metadata, tracee);
+	else
 		return;
 
-	nr = get_syscall(_metadata, tracee);
-
-	if (nr == __NR_getpid)
+	switch (self->syscall_nr) {
+	case __NR_getpid:
 		change_syscall(_metadata, tracee, __NR_getppid, 0);
-	if (nr == __NR_gettid)
+		break;
+	case __NR_gettid:
 		change_syscall(_metadata, tracee, -1, 45000);
-	if (nr == __NR_openat)
+		break;
+	case __NR_openat:
 		change_syscall(_metadata, tracee, -1, -ESRCH);
+		break;
+	}
 }
 
-FIXTURE(TRACE_syscall) {
-	struct sock_fprog prog;
-	pid_t tracer, mytid, mypid, parent;
-};
-
 FIXTURE_VARIANT(TRACE_syscall) {
 	/*
 	 * All of the SECCOMP_RET_TRACE behaviors can be tested with either
@@ -2044,7 +2058,7 @@ FIXTURE_SETUP(TRACE_syscall)
 	self->tracer = setup_trace_fixture(_metadata,
 					   variant->use_ptrace ? tracer_ptrace
 							       : tracer_seccomp,
-					   NULL, variant->use_ptrace);
+					   self, variant->use_ptrace);
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	ASSERT_EQ(0, ret);
-- 
2.25.1

