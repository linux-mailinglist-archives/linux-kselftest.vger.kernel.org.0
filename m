Return-Path: <linux-kselftest+bounces-31774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7CDA9F0FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180F97AD4B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447F26E16B;
	Mon, 28 Apr 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STan5fOm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4KUMdBLW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CF26B2B2;
	Mon, 28 Apr 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844016; cv=none; b=SkaCgoieH3vWvI89/yvksVcxFG1gqJ1UCvk0kYlAKMeZh78ibdP1Lgq9rgdOZEHkXhJ15O7PBHBzEklDF3RNBBFMg/gbkmEM2IyJKRU1BAlFCQnqoxLhq9q5PZXDhAyRHE8x/5uCdVBi7OPbVZu2NVba7aTK9JAEoFcwJGulJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844016; c=relaxed/simple;
	bh=jKHlhI6seUzGayl/WwMKF7slaauY7Kha0rOhKN4hhUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OxXMXLxSwXwcDC1TxYm5q9DoXIK5mnei9JEXE4eGWV0KaUtx7mzE+yU6rM7cXxucSnLnrcLOtmiXg1TX9JDbLphCw/duGepsXM1qdjPSKZsD5U6dWGxYjUQ3EW8XSvJha72AhYpFGUTID0vGbJTttqW9ue1lOgRPGGMXaTNv1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=STan5fOm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4KUMdBLW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJY1+QnNRvenV8jVIlAdmBrCNcOSvyEzDjb7yrCveqk=;
	b=STan5fOmfwSgFxwl0wQzWsoiGXQBHLi/kfz9XCRgrMX+mSEYajInjaAAQsfhiGQ62R/9Vr
	I/eVJNQF0fz148bFulweQixFtHTDW7PK1wrfpjBG9NcmXgSAln7NyoITYl8o7gP0N4PQXM
	eFpTQ97yL7kBvIlPcfsMotsAj32+GBZ/1bPObnANnOFfWZjS1jI5cdGMdPJXgkXSkh+Bkz
	bHTm3oz+5YSrZRjYHcji3EirkAsQDL2txCsVhXHHPwzXothpQrNfEVmpNjYkHYkBH1knJ7
	LxyGCP42XUXNTNnjA0DjELyQBXSiibIz4hUBaeRSQBWPyb6nms3joveE9e+ddg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJY1+QnNRvenV8jVIlAdmBrCNcOSvyEzDjb7yrCveqk=;
	b=4KUMdBLWhIZ14RzkaEUcamr7WcUsO9/yNDKJiBVwcYi9n7yoUgzD2tjVhOWBEXmn5I2N2q
	nMSMv+VY2e3cAHDA==
Date: Mon, 28 Apr 2025 14:40:09 +0200
Subject: [PATCH v2 08/15] tools/nolibc: add clock_getres(), clock_gettime()
 and clock_settime()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-8-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=5433;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jKHlhI6seUzGayl/WwMKF7slaauY7Kha0rOhKN4hhUw=;
 b=1W4a9hlCjoJBmbnvzVr2VhZu95BOacur60q0nz3/vifeerJJUbiknxrIUyHCKMzUmsNrS8PN9
 PBidkH5apqkB8NhOnAKQ2wGJ/6nVv+oHBO6+5e3ywbVfoSM3HbbTJDU
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/time.h                  | 92 ++++++++++++++++++++++++++++
 tools/include/nolibc/types.h                 |  2 +
 tools/testing/selftests/nolibc/nolibc-test.c |  5 ++
 3 files changed, 99 insertions(+)

diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index 9502f9aaf62110ec8ee113fcf08dd47de40e924c..7e0b7eac0b7c31910a48ebb9755d5004e5da1a69 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -15,6 +15,98 @@
 #include "types.h"
 #include "sys.h"
 
+#include <linux/time.h>
+
+static __inline__
+void __nolibc_timespec_user_to_kernel(const struct timespec *ts, struct __kernel_timespec *kts)
+{
+	kts->tv_sec = ts->tv_sec;
+	kts->tv_nsec = ts->tv_nsec;
+}
+
+static __inline__
+void __nolibc_timespec_kernel_to_user(const struct __kernel_timespec *kts, struct timespec *ts)
+{
+	ts->tv_sec = kts->tv_sec;
+	ts->tv_nsec = kts->tv_nsec;
+}
+
+/*
+ * int clock_getres(clockid_t clockid, struct timespec *res);
+ * int clock_gettime(clockid_t clockid, struct timespec *tp);
+ * int clock_settime(clockid_t clockid, const struct timespec *tp);
+ */
+
+static __attribute__((unused))
+int sys_clock_getres(clockid_t clockid, struct timespec *res)
+{
+#if defined(__NR_clock_getres)
+	return my_syscall2(__NR_clock_getres, clockid, res);
+#elif defined(__NR_clock_getres_time64)
+	struct __kernel_timespec kres;
+	int ret;
+
+	ret = my_syscall2(__NR_clock_getres_time64, clockid, &kres);
+	if (res)
+		__nolibc_timespec_kernel_to_user(&kres, res);
+	return ret;
+#else
+	return __nolibc_enosys(__func__, clockid, res);
+#endif
+}
+
+static __attribute__((unused))
+int clock_getres(clockid_t clockid, struct timespec *res)
+{
+	return __sysret(sys_clock_getres(clockid, res));
+}
+
+static __attribute__((unused))
+int sys_clock_gettime(clockid_t clockid, struct timespec *tp)
+{
+#if defined(__NR_clock_gettime)
+	return my_syscall2(__NR_clock_gettime, clockid, tp);
+#elif defined(__NR_clock_gettime64)
+	struct __kernel_timespec ktp;
+	int ret;
+
+	ret = my_syscall2(__NR_clock_gettime64, clockid, &ktp);
+	if (tp)
+		__nolibc_timespec_kernel_to_user(&ktp, tp);
+	return ret;
+#else
+	return __nolibc_enosys(__func__, clockid, tp);
+#endif
+}
+
+static __attribute__((unused))
+int clock_gettime(clockid_t clockid, struct timespec *tp)
+{
+	return __sysret(sys_clock_gettime(clockid, tp));
+}
+
+static __attribute__((unused))
+int sys_clock_settime(clockid_t clockid, struct timespec *tp)
+{
+#if defined(__NR_clock_settime)
+	return my_syscall2(__NR_clock_settime, clockid, tp);
+#elif defined(__NR_clock_settime64)
+	struct __kernel_timespec ktp;
+
+	__nolibc_timespec_user_to_kernel(tp, &ktp);
+	return my_syscall2(__NR_clock_settime64, clockid, &ktp);
+#else
+	return __nolibc_enosys(__func__, clockid, tp);
+#endif
+}
+
+static __attribute__((unused))
+int clock_settime(clockid_t clockid, struct timespec *tp)
+{
+	return __sysret(sys_clock_settime(clockid, tp));
+}
+
+
 static __attribute__((unused))
 time_t time(time_t *tptr)
 {
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index fe97953d16572db3e4c18cdc8921c6a991d64f94..8eb48d98667f5fe65bb8a974f613fd1fd17ae11e 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -201,6 +201,8 @@ struct stat {
 	union { time_t st_ctime; struct timespec st_ctim; }; /* time of last status change */
 };
 
+typedef __kernel_clockid_t clockid_t;
+
 /* WARNING, it only deals with the 4096 first majors and 256 first minors */
 #define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
 #define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 10db118b8b111ec17f713d57240f193c7b18c70f..9b8aa41a547b1735014c5a7541e426f4e08c7f90 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -38,6 +38,7 @@
 #include <stdarg.h>
 #include <stddef.h>
 #include <stdint.h>
+#include <time.h>
 #include <unistd.h>
 #include <limits.h>
 #include <ctype.h>
@@ -1081,6 +1082,7 @@ int run_syscall(int min, int max)
 {
 	struct timeval tv;
 	struct timezone tz;
+	struct timespec ts;
 	struct stat stat_buf;
 	int euid0;
 	int proc;
@@ -1114,6 +1116,9 @@ int run_syscall(int min, int max)
 		switch (test + __LINE__ + 1) {
 		CASE_TEST(access);            EXPECT_SYSZR(proc, access("/proc/self", R_OK)); break;
 		CASE_TEST(access_bad);        EXPECT_SYSER(proc, access("/proc/self", W_OK), -1, EPERM); break;
+		CASE_TEST(clock_getres);      EXPECT_SYSZR(1, clock_getres(CLOCK_MONOTONIC, &ts)); break;
+		CASE_TEST(clock_gettime);     EXPECT_SYSZR(1, clock_gettime(CLOCK_MONOTONIC, &ts)); break;
+		CASE_TEST(clock_settime);     EXPECT_SYSER(1, clock_settime(CLOCK_MONOTONIC, &ts), -1, EINVAL); break;
 		CASE_TEST(getpid);            EXPECT_SYSNE(1, getpid(), -1); break;
 		CASE_TEST(getppid);           EXPECT_SYSNE(1, getppid(), -1); break;
 		CASE_TEST(gettid);            EXPECT_SYSNE(has_gettid, gettid(), -1); break;

-- 
2.49.0


