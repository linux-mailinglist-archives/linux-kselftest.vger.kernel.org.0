Return-Path: <linux-kselftest+bounces-45947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E43C6CA65
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 04:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B01A9351189
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 03:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188728B7D7;
	Wed, 19 Nov 2025 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xte0D359"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C4F9D9
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523949; cv=none; b=OuBz87p2bmyoGy6+tWg1M/HPbS3GCq9ffMbiE/ja2aS30kOb6G+RNJuzcsXts2dSIkJBGVUs4946gJX56G0RdFBcvjb2tWNBOSzYgzsNJxEmJxjdf4XsXX6/MOPBSktGTrvfwUIr2LPm0vz3ARChNjJBWRaac0DyfcAsQElgyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523949; c=relaxed/simple;
	bh=sgzLbTawbknBk+VC8ZRMoEhL2SHuJV0moh8G8JEaFZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tceMkwoU+jP6rzYM0R8mamyW7hOpsxZYm+0g7MQLxGHcaqFr4Uz2wbabt5BrARcggPB336FipPzLpZEb26tT8MNvYI1fcQfEC90gy7tHVieEcXk1jNpAG62mgaiUQsgeh/CqichgjlQkA06lOrygVeet+7wijjN4ytN07pEPMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xte0D359; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b89c1ce9cfso6231802b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 19:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763523947; x=1764128747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/c8ZWcrZhP5kCv1lwdSuj3WsC9yEjqsVc1H6PC8zNc=;
        b=Xte0D359kH+3RlaKDsIC/55dzJeTjI/kf/2UfX/vEOhh/YfihKN4ruoAMXlpL+ysw2
         NS4juf8DssA9Y2BAU2beq9WjtWTdnQS/TCIYoUa8yQPEisa41brvEkiqC+KbuRvTSdn1
         M3YnUxRG17z2oBYMyjweRhQ1duN5kifZDXffEx7Jorp3kWCvXp1sDbJw5DN5+yww8KFR
         wyc+sCYa0DG/tdGiGnYt0Sm8preL2k15Su2FyPww4ckdcw7oHpFAKLv9HGbt67YF7y47
         PxMoZ6iE1mQ2BmeI6OmIEzoNp4s9MQibLeKaw5dyOlN7Oql7a+g+S5NyQ0J6xI+zH+K1
         UcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763523947; x=1764128747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/c8ZWcrZhP5kCv1lwdSuj3WsC9yEjqsVc1H6PC8zNc=;
        b=fALxehRRqpxcLm4saJRS1GyoJr2YTlhxnUn0h9l0mC4EVVgJZm/4SNtIV6ZH4qEVZL
         +3LX6Vxt/hmnGq+tlcctxlgryBM9y8tf1E2x8CR5B4Afk+xY0rXBSsW0IVdWdo30c5cc
         1dYsSFxFTsikxi4w8U+NOqDp6s162+lR3eNbP47mZTh1aCrxIeZeDCIOsYfrkz72dRD8
         fWz5vLKMoPhzFzdRziouMLdkfm5yowV8Oq1wsLIg2X1Oc9PLvV3QVHVGx3VOQYz7n2G2
         Emne4or2MmiAqD8Uuj8FxR2rgmAgLpS0wvoQnJh/yZelWN6hGPATPMQDrcjsKNm3WT6Y
         EVsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpkYz34C+V1eOX5aA65HKyCTRcbrmtl/AeSccMjkOKZR8Rqqz9SWWgl+/s7L4e3x9e8hWcYjsrHeo+SUHxjeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFTUtn+lSBkdy/SqcYC4vyqz2KeOa/qmSikiRdRWb2YlES3di
	dJZcea4KMdUb3JWhNj6PyQ0etGiFYTB62DPZAlI5OS2kXfFbylwXn88kN4hu34JRyniy6lmyHaN
	eQw==
X-Google-Smtp-Source: AGHT+IH8txoKjzYlkTk+8BvdZ2AqydQ/0aEKJny2PNqnKCqmAWPIRIMlXoOXJHzxKvAo9Ujq02WX+XxlUQ==
X-Received: from pfbdo18.prod.google.com ([2002:a05:6a00:4a12:b0:7b9:caf4:7c91])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:982:b0:7b2:2d85:ae59
 with SMTP id d2e1a72fcca58-7ba39ecfa9dmr18571079b3a.11.1763523946998; Tue, 18
 Nov 2025 19:45:46 -0800 (PST)
Date: Wed, 19 Nov 2025 11:45:41 +0800
In-Reply-To: <202508251051.E222C34D2F@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202508251051.E222C34D2F@keescook>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119034541.334982-1-wakel@google.com>
Subject: [PATCH v2] selftests/seccomp: Check for feature support before testing
From: Wake Liu <wakel@google.com>
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit introduces checks for seccomp filter flag support to the
seccomp selftests.

By default, the tests will fail if modern seccomp features are not
present, ensuring that the tests validate the latest seccomp functionality.

For environments that need to run these tests on older kernels, a backward
compatibility mode can be enabled by setting the `SECCOMP_BACKWARD_COMPAT`
environment variable to `1`. In this mode, if a feature is not supported,
the test will log a message instead of failing.

This addresses the feedback from Kees Cook to keep the default behavior
strict while allowing for backward compatibility testing.

Changes in v2:
  - Address feedback from Kees Cook.
  - Instead of making backward compatibility the default, make it opt-in
    via the `SECCOMP_BACKWARD_COMPAT` environment variable.
  - By default, the test now performs strict checking of seccomp features.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 135 ++++++++++++++++--
 1 file changed, 122 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..574fdd102eb5 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -13,12 +13,14 @@
  * we need to use the kernel's siginfo.h file and trick glibc
  * into accepting it.
  */
+#if defined(__GLIBC__) && defined(__GLIBC_PREREQ)
 #if !__GLIBC_PREREQ(2, 26)
 # include <asm/siginfo.h>
 # define __have_siginfo_t 1
 # define __have_sigval_t 1
 # define __have_sigevent_t 1
 #endif
+#endif
 
 #include <errno.h>
 #include <linux/filter.h>
@@ -309,6 +311,26 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
 }
 #endif
 
+int seccomp_flag_supported(int flag)
+{
+	/*
+	 * Probes if a seccomp filter flag is supported by the kernel.
+	 *
+	 * When an unsupported flag is passed to seccomp(SECCOMP_SET_MODE_FILTER, ...),
+	 * the kernel returns EINVAL.
+	 *
+	 * When a supported flag is passed, the kernel proceeds to validate the
+	 * filter program pointer. By passing NULL for the filter program,
+	 * the kernel attempts to dereference a bad address, resulting in EFAULT.
+	 *
+	 * Therefore, checking for EFAULT indicates that the flag itself was
+	 * recognized and supported by the kernel.
+	 */
+	if (seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL) == -1 && errno == EFAULT)
+		return 1;
+	return 0;
+}
+
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
@@ -2426,6 +2448,7 @@ TEST(detect_seccomp_filter_flags)
 	unsigned int flag, all_flags, exclusive_mask;
 	int i;
 	long ret;
+	char *compat_mode = getenv("SECCOMP_BACKWARD_COMPAT");
 
 	/* Test detection of individual known-good filter flags */
 	for (i = 0, all_flags = 0; i < ARRAY_SIZE(flags); i++) {
@@ -2445,13 +2468,21 @@ TEST(detect_seccomp_filter_flags)
 		ASSERT_NE(ENOSYS, errno) {
 			TH_LOG("Kernel does not support seccomp syscall!");
 		}
-		EXPECT_EQ(-1, ret);
-		EXPECT_EQ(EFAULT, errno) {
-			TH_LOG("Failed to detect that a known-good filter flag (0x%X) is supported!",
-			       flag);
-		}
 
-		all_flags |= flag;
+		if (compat_mode && strcmp(compat_mode, "1") == 0) {
+			if (seccomp_flag_supported(flag))
+				all_flags |= flag;
+			else
+				TH_LOG("Filter flag (0x%X) is not found to be supported!",
+				       flag);
+		} else {
+			EXPECT_EQ(-1, ret);
+			EXPECT_EQ(EFAULT, errno) {
+				TH_LOG("Failed to detect filter flag, (0x%X) is supported!",
+				       flag);
+			}
+			all_flags |= flag;
+		}
 	}
 
 	/*
@@ -2467,10 +2498,18 @@ TEST(detect_seccomp_filter_flags)
 		flag |= exclusive[i];
 
 		ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
-		EXPECT_EQ(-1, ret);
-		EXPECT_EQ(EFAULT, errno) {
-			TH_LOG("Failed to detect that all known-good filter flags (0x%X) are supported!",
-			       flag);
+		if (compat_mode && strcmp(compat_mode, "1") == 0) {
+			if (ret == -1 && errno == EINVAL)
+				TH_LOG("Combined filter flags (0x%X) are not supported!",
+				       flag);
+			else
+				EXPECT_EQ(EFAULT, errno);
+		} else {
+			EXPECT_EQ(-1, ret);
+			EXPECT_EQ(EFAULT, errno) {
+				TH_LOG("Failed to detect filter flags (0x%X) are supported!",
+				       flag);
+			}
 		}
 	}
 
@@ -2879,6 +2918,12 @@ TEST_F(TSYNC, two_siblings_with_one_divergence)
 
 TEST_F(TSYNC, two_siblings_with_one_divergence_no_tid_in_err)
 {
+	/* Depends on 5189149 (seccomp: allow TSYNC and USER_NOTIF together) */
+	if (!seccomp_flag_supported(SECCOMP_FILTER_FLAG_TSYNC_ESRCH)) {
+		SKIP(return, "Kernel does not support SECCOMP_FILTER_FLAG_TSYNC_ESRCH");
+		return;
+	}
+
 	long ret, flags;
 	void *status;
 
@@ -3484,6 +3529,11 @@ TEST(user_notification_basic)
 
 TEST(user_notification_with_tsync)
 {
+	/* Depends on 5189149 (seccomp: allow TSYNC and USER_NOTIF together) */
+	if (!seccomp_flag_supported(SECCOMP_FILTER_FLAG_TSYNC_ESRCH)) {
+		SKIP(return, "Kernel does not support SECCOMP_FILTER_FLAG_TSYNC_ESRCH");
+		return;
+	}
 	int ret;
 	unsigned int flags;
 
@@ -3979,6 +4029,14 @@ TEST(user_notification_filter_empty)
 
 TEST(user_ioctl_notification_filter_empty)
 {
+	/* Depends on 95036a7 (seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV
+	 * when all users have exited)
+	 */
+	if (!ksft_min_kernel_version(6, 11)) {
+		SKIP(return, "Kernel version < 6.11");
+		return;
+	}
+
 	pid_t pid;
 	long ret;
 	int status, p[2];
@@ -4132,6 +4190,12 @@ int get_next_fd(int prev_fd)
 
 TEST(user_notification_addfd)
 {
+	/* Depends on 0ae71c7 (seccomp: Support atomic "addfd + send reply") */
+	if (!ksft_min_kernel_version(5, 14)) {
+		SKIP(return, "Kernel version < 5.14");
+		return;
+	}
+
 	pid_t pid;
 	long ret;
 	int status, listener, memfd, fd, nextfd;
@@ -4294,6 +4358,12 @@ TEST(user_notification_addfd)
 
 TEST(user_notification_addfd_rlimit)
 {
+	/* Depends on 7cf97b1 (seccomp: Introduce addfd ioctl to seccomp user notifier) */
+	if (!ksft_min_kernel_version(5, 9)) {
+		SKIP(return, "Kernel version < 5.9");
+		return;
+	}
+
 	pid_t pid;
 	long ret;
 	int status, listener, memfd;
@@ -4339,9 +4409,12 @@ TEST(user_notification_addfd_rlimit)
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
 	EXPECT_EQ(errno, EMFILE);
 
-	addfd.flags = SECCOMP_ADDFD_FLAG_SEND;
-	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
-	EXPECT_EQ(errno, EMFILE);
+	/* Depends on 0ae71c7 (seccomp: Support atomic "addfd + send reply") */
+	if (ksft_min_kernel_version(5, 14)) {
+		addfd.flags = SECCOMP_ADDFD_FLAG_SEND;
+		EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+		EXPECT_EQ(errno, EMFILE);
+	}
 
 	addfd.newfd = 100;
 	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
@@ -4369,6 +4442,12 @@ TEST(user_notification_addfd_rlimit)
 
 TEST(user_notification_sync)
 {
+	/* Depends on 48a1084 (seccomp: add the synchronous mode for seccomp_unotify) */
+	if (!ksft_min_kernel_version(6, 6)) {
+		SKIP(return, "Kernel version < 6.6");
+		return;
+	}
+
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 	int status, listener;
@@ -4533,6 +4612,12 @@ static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
 
 TEST(user_notification_fifo)
 {
+	/* Depends on 4cbf6f6 (seccomp: Use FIFO semantics to order notifications) */
+	if (!ksft_min_kernel_version(5, 19)) {
+		SKIP(return, "Kernel version < 5.19");
+		return;
+	}
+
 	struct seccomp_notif_resp resp = {};
 	struct seccomp_notif req = {};
 	int i, status, listener;
@@ -4636,6 +4721,12 @@ static long get_proc_syscall(struct __test_metadata *_metadata, int pid)
 /* Ensure non-fatal signals prior to receive are unmodified */
 TEST(user_notification_wait_killable_pre_notification)
 {
+	/* Depends on c2aa2df (seccomp: Add wait_killable semantic to seccomp user notifier) */
+	if (!ksft_min_kernel_version(5, 19)) {
+		SKIP(return, "Kernel version < 5.19");
+		return;
+	}
+
 	struct sigaction new_action = {
 		.sa_handler = signal_handler,
 	};
@@ -4706,6 +4797,12 @@ TEST(user_notification_wait_killable_pre_notification)
 /* Ensure non-fatal signals after receive are blocked */
 TEST(user_notification_wait_killable)
 {
+	/* Depends on c2aa2df (seccomp: Add wait_killable semantic to seccomp user notifier) */
+	if (!ksft_min_kernel_version(5, 19)) {
+		SKIP(return, "Kernel version < 5.19");
+		return;
+	}
+
 	struct sigaction new_action = {
 		.sa_handler = signal_handler,
 	};
@@ -4785,6 +4882,12 @@ TEST(user_notification_wait_killable)
 /* Ensure fatal signals after receive are not blocked */
 TEST(user_notification_wait_killable_fatal)
 {
+	/* Depends on c2aa2df (seccomp: Add wait_killable semantic to seccomp user notifier) */
+	if (!ksft_min_kernel_version(5, 19)) {
+		SKIP(return, "Kernel version < 5.19");
+		return;
+	}
+
 	struct seccomp_notif req = {};
 	int listener, status;
 	pid_t pid;
@@ -4993,6 +5096,12 @@ static void *tsync_vs_dead_thread_leader_sibling(void *_args)
  */
 TEST(tsync_vs_dead_thread_leader)
 {
+	/* Depends on bfafe5e (seccomp: release task filters when the task exits) */
+	if (!ksft_min_kernel_version(6, 11)) {
+		SKIP(return, "Kernel version < 6.11");
+		return;
+	}
+
 	int status;
 	pid_t pid;
 	long ret;
-- 
2.52.0.rc1.455.g30608eb744-goog


