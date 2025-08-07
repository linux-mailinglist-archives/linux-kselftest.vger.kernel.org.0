Return-Path: <linux-kselftest+bounces-38488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E34DFB1DC9F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 19:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD53188FB6A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCC1DB546;
	Thu,  7 Aug 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J//AvZZE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD31A0712
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588781; cv=none; b=rncXheh0jCmkDVxe1r17N7PwPsqcFVsBpmGs4to7hafIA2eaYsf0FV+JDUDWzBqSfIueG1HYkraPpirlXgQZpY9m2M3xMjLVrb6xPW9+q+OnMYS0jOMcXIDlvg+CscLORZ55BNCSLxJsU/OdnIF5SE6QpzjH1ghDxb0ZsG6NkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588781; c=relaxed/simple;
	bh=Uq3iiNUU91g4FQyKlsdBmM5MGVUlLCvmUTwzVzeS5m4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V6OtGBjkjIYsardpmZ8iHH/LWts2oYGFxFYB37B6Qv/7gT6daBUqjj6KFaStbSAM2bO4w407ca06AeJ12p9h/5WW/G8If75SHp9ae3C97V0WEkjbDP96xM3Ic2tEfaRAEJBKf13EaxJk3B13pe+LUY+gKqxW80tNYidP2JS4ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J//AvZZE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31eac278794so1261303a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754588779; x=1755193579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HcLjrOeqCd02Abu900eKiNp/ETH9Nin2wL4rT1C33Uc=;
        b=J//AvZZEJXTa8GGXdPyNl6KeQd0LEgrzxnFZW3Sm6sm9TPcoPEsJ8J6qTDCOzmT5Dx
         sKIAAR6Irar6VNpyveYuHkitULpD95EiHIzc6L2/qGtkHRiYXExhdLRUY3tWBk5RX4GW
         u7loULwp6GdvOjhqvv6Z0D1cSainGMnwkh1DkYp1DSMGgSx8REUwtF7BU0V/2JO4Z7z9
         67BcNj3GISt9p0Z4cFskxSWRZ7lTWdO4KNoySKLi1cBa0RRkE+Y4GpzbTFqFVeNGqNgl
         ycgVr4Xw6a5T03LgW0/6tokNMQ/bQyfoP6036U+67aeTjM7pTmUdUElqU3ydVxcoqp03
         /VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754588779; x=1755193579;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcLjrOeqCd02Abu900eKiNp/ETH9Nin2wL4rT1C33Uc=;
        b=IXo0dbMmYUjj5Knjr6GJ4rONO+w1P+Mpxlzik02bQIWBAt22wz9iaX1Glghk3I168z
         MzNhO4txLqKUko39l/8YFFyGqggJ405fs7GRdwgDjEdnCCHqvt79vEH4zuN7PTP4NUqO
         SSN3p0s6ubLh57s4Qh2NT/78Y+88IZaRQuHf4VRgGePxTWTuEol6lrLneL0P2BAYpntx
         g/nsCzXuXtVBpDsVkOSHboO4zBwUE8URLOwauc9AcCDcp3ZluAbt4kAq/px4sXNMUj1K
         j93IbXENw/d+FBOGnsiN7n4rLtaWCTEVvXtSeP7WcxmQ9ROda3F376G8pC96of8sH6gJ
         pjkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3r2WrGVRlyS5k5qMwEzuE6sWcXokS1s9o9ZO1NrhEdnx0wiraG82C2w+yQZZDsC/z4YFTdTLFQJmUXzr5jm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4DNakgbO9j3GpOOSFW44qqhGHYGIdFDmylYwPFnbZ9T/32Cu/
	eGt8G8mQQFLHsxNXNgD7W3Hjz8/i1femXfqkQ6u+738yinKeHHdEoY0U+fihSb35Mr9GjywPsWJ
	97A==
X-Google-Smtp-Source: AGHT+IH1TzamuhyocWAYv+jV0O95ZvaImp1W99Xp6lTkB1S1QMyzi0Kp+GJq5+BauORZKHrne7YiZLn0Zg==
X-Received: from pjbsk13.prod.google.com ([2002:a17:90b:2dcd:b0:321:78e7:57fb])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55ce:b0:320:ff84:ceb5
 with SMTP id 98e67ed59e1d1-32182692d5emr600569a91.16.1754588779321; Thu, 07
 Aug 2025 10:46:19 -0700 (PDT)
Date: Fri,  8 Aug 2025 01:46:13 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807174613.1895006-1-wakel@google.com>
Subject: [PATCH] selftests/seccomp: improve backwards compatibility for older kernels
From: Wake Liu <wakel@google.com>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: wakel@google.com
Content-Type: text/plain; charset="UTF-8"

This commit introduces checks for kernel version and seccomp filter flag
support to the seccomp selftests. It also includes conditional header
inclusions using __GLIBC_PREREQ.

Some tests were gated by kernel version, and adjustments were made for
flags introduced after kernel 5.4. This ensures the selftests can run
and pass correctly on kernel versions 5.4 and later, preventing failures
due to features not present in older kernels.

The use of __GLIBC_PREREQ ensures proper compilation and functionality
across different glibc versions in a mainline Linux kernel context.
While it might appear redundant in specific build environments due to
global overrides, it is crucial for upstream correctness and portability.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 108 ++++++++++++++++--
 1 file changed, 99 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 61acbd45ffaa..9b660cff5a4a 100644
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
@@ -300,6 +302,26 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
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
@@ -2436,13 +2458,12 @@ TEST(detect_seccomp_filter_flags)
 		ASSERT_NE(ENOSYS, errno) {
 			TH_LOG("Kernel does not support seccomp syscall!");
 		}
-		EXPECT_EQ(-1, ret);
-		EXPECT_EQ(EFAULT, errno) {
-			TH_LOG("Failed to detect that a known-good filter flag (0x%X) is supported!",
-			       flag);
-		}
 
-		all_flags |= flag;
+		if (seccomp_flag_supported(flag))
+			all_flags |= flag;
+		else
+			TH_LOG("Filter flag (0x%X) is not found to be supported!",
+			       flag);
 	}
 
 	/*
@@ -2870,6 +2891,12 @@ TEST_F(TSYNC, two_siblings_with_one_divergence)
 
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
 
@@ -3475,6 +3502,11 @@ TEST(user_notification_basic)
 
 TEST(user_notification_with_tsync)
 {
+	/* Depends on 5189149 (seccomp: allow TSYNC and USER_NOTIF together) */
+	if (!seccomp_flag_supported(SECCOMP_FILTER_FLAG_TSYNC_ESRCH)) {
+		SKIP(return, "Kernel does not support SECCOMP_FILTER_FLAG_TSYNC_ESRCH");
+		return;
+	}
 	int ret;
 	unsigned int flags;
 
@@ -3966,6 +3998,13 @@ TEST(user_notification_filter_empty)
 
 TEST(user_ioctl_notification_filter_empty)
 {
+	/* Depends on 95036a7 (seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV
+	 * when all users have exited) */
+	if (!ksft_min_kernel_version(6, 11)) {
+		SKIP(return, "Kernel version < 6.11");
+		return;
+	}
+
 	pid_t pid;
 	long ret;
 	int status, p[2];
@@ -4119,6 +4158,12 @@ int get_next_fd(int prev_fd)
 
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
@@ -4281,6 +4326,12 @@ TEST(user_notification_addfd)
 
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
@@ -4326,9 +4377,12 @@ TEST(user_notification_addfd_rlimit)
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
@@ -4356,6 +4410,12 @@ TEST(user_notification_addfd_rlimit)
 
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
@@ -4520,6 +4580,12 @@ static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
 
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
@@ -4623,6 +4689,12 @@ static long get_proc_syscall(struct __test_metadata *_metadata, int pid)
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
@@ -4693,6 +4765,12 @@ TEST(user_notification_wait_killable_pre_notification)
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
@@ -4772,6 +4850,12 @@ TEST(user_notification_wait_killable)
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
@@ -4854,6 +4938,12 @@ static void *tsync_vs_dead_thread_leader_sibling(void *_args)
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
2.50.1.703.g449372360f-goog


