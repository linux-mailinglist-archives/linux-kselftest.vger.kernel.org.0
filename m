Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B0A261D52
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Sep 2020 21:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbgIHTfY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Sep 2020 15:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbgIHTfV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Sep 2020 15:35:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573FBC061573
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Sep 2020 12:35:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gf14so115586pjb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Sep 2020 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KkDZg3VV1HdvEiBzqX2Tjp4l2OG193wQyuNHUKkANCM=;
        b=Sv0bAwttxSrG0qmrp6ftBKOLotwQE/22D6+XQmxRBtEzI3bojDkBOgC4JsptF2nHdn
         OhVk7OWZ5/AAyBfDfC2LKcPgkcupENV1d3U2I6lUxTeklWe9ATScFJ9E/Mu+wca0DL18
         7JpNGRZ246Ov7qM4/ODCYiAai0k1ahLrg5+uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KkDZg3VV1HdvEiBzqX2Tjp4l2OG193wQyuNHUKkANCM=;
        b=XVWyUR8pvfqoRWK3VxC8uYkqTeTC6Kbk/A78Y2gQIyNB7spo8VmTixGsIGkpPsjj10
         GACkOgDlj8BSByirDVGmaJudFDemksprrBH3ng5QEtx+YGR/1C8xtGM4XJi42H0+0AeS
         PJ4ts5tF3SdSwOmLSYWXBPwmWdhVoKHfnX9z+rDp7G7dapAIMqB31nwwG75MdcQAPBOt
         WGPGQkpatJGf/bD36Y0J6ehZetQY7bWB3n//0xgLzPBe55Jf6LaSzpULX5VMQvZuTO9U
         2dS5pSdvGtzu4g/6gGgzxde494qj+9peOCneTl9rUkfQYzFA8eQNFOVloFYWUrdnpxwW
         TRjw==
X-Gm-Message-State: AOAM531dOwRPv7xzaeLJfLGgOiXnbINbAPUEMZbFlClZeNeNiBK+/txA
        rNo/3T5iCucj3HnzTLRe8ooPAw==
X-Google-Smtp-Source: ABdhPJzfxO/MrSvpIlwT014cjCzE+EasUA+SQPtTAxClTSLDi4kt5bict7t1NG6YEtwKb1+9VHQsEA==
X-Received: by 2002:a17:90a:3184:: with SMTP id j4mr377600pjb.78.1599593720861;
        Tue, 08 Sep 2020 12:35:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w206sm220680pfc.1.2020.09.08.12.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:35:19 -0700 (PDT)
Date:   Tue, 8 Sep 2020 12:35:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Add test for unknown SECCOMP_RET kill
 behavior
Message-ID: <202009081232.92206075F7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While we testing for the behavior of unknown seccomp filter return
values, there was no test for how it acted in a thread group. Add
a test in the thread group tests for this.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
(This is going via the seccomp tree.)
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 43 ++++++++++++++++---
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 7a6d40286a42..bfb382580493 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -774,8 +774,15 @@ void *kill_thread(void *data)
 	return (void *)SIBLING_EXIT_UNKILLED;
 }
 
+enum kill_t {
+	KILL_THREAD,
+	KILL_PROCESS,
+	RET_UNKNOWN
+};
+
 /* Prepare a thread that will kill itself or both of us. */
-void kill_thread_or_group(struct __test_metadata *_metadata, bool kill_process)
+void kill_thread_or_group(struct __test_metadata *_metadata,
+			  enum kill_t kill_how)
 {
 	pthread_t thread;
 	void *status;
@@ -791,11 +798,12 @@ void kill_thread_or_group(struct __test_metadata *_metadata, bool kill_process)
 		.len = (unsigned short)ARRAY_SIZE(filter_thread),
 		.filter = filter_thread,
 	};
+	int kill = kill_how == KILL_PROCESS ? SECCOMP_RET_KILL_PROCESS : 0xAAAAAAAAA;
 	struct sock_filter filter_process[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
 		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL_PROCESS),
+		BPF_STMT(BPF_RET|BPF_K, kill),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
 	struct sock_fprog prog_process = {
@@ -808,13 +816,15 @@ void kill_thread_or_group(struct __test_metadata *_metadata, bool kill_process)
 	}
 
 	ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0,
-			     kill_process ? &prog_process : &prog_thread));
+			     kill_how == KILL_THREAD ? &prog_thread
+						     : &prog_process));
 
 	/*
 	 * Add the KILL_THREAD rule again to make sure that the KILL_PROCESS
 	 * flag cannot be downgraded by a new filter.
 	 */
-	ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog_thread));
+	if (kill_how == KILL_PROCESS)
+		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog_thread));
 
 	/* Start a thread that will exit immediately. */
 	ASSERT_EQ(0, pthread_create(&thread, NULL, kill_thread, (void *)false));
@@ -842,7 +852,7 @@ TEST(KILL_thread)
 	child_pid = fork();
 	ASSERT_LE(0, child_pid);
 	if (child_pid == 0) {
-		kill_thread_or_group(_metadata, false);
+		kill_thread_or_group(_metadata, KILL_THREAD);
 		_exit(38);
 	}
 
@@ -861,7 +871,7 @@ TEST(KILL_process)
 	child_pid = fork();
 	ASSERT_LE(0, child_pid);
 	if (child_pid == 0) {
-		kill_thread_or_group(_metadata, true);
+		kill_thread_or_group(_metadata, KILL_PROCESS);
 		_exit(38);
 	}
 
@@ -872,6 +882,27 @@ TEST(KILL_process)
 	ASSERT_EQ(SIGSYS, WTERMSIG(status));
 }
 
+TEST(KILL_unknown)
+{
+	int status;
+	pid_t child_pid;
+
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+	if (child_pid == 0) {
+		kill_thread_or_group(_metadata, RET_UNKNOWN);
+		_exit(38);
+	}
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+
+	/* If the entire process was killed, we'll see SIGSYS. */
+	EXPECT_TRUE(WIFSIGNALED(status)) {
+		TH_LOG("Unknown SECCOMP_RET is only killing the thread?");
+	}
+	ASSERT_EQ(SIGSYS, WTERMSIG(status));
+}
+
 /* TODO(wad) add 64-bit versus 32-bit arg tests. */
 TEST(arg_out_of_range)
 {
-- 
2.25.1


-- 
Kees Cook
