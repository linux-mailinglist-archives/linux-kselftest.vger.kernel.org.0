Return-Path: <linux-kselftest+bounces-31413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F998A98F16
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2837B7A8088
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8671228A40A;
	Wed, 23 Apr 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XaAEu4V9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFI1Jg3f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833F288CBD;
	Wed, 23 Apr 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420507; cv=none; b=GfXasYF6fr7A6uLcwG9rH1seFNJCTYa/YVUm7EAqKv6D+pPpUNtl6pNTrIZTRSI3Hxudgt85huIgznMaiIr1F87W70ZZatXgPG7ImLw/raa+dqx2dmyuG/Y29hiJDVLnu4/4upwLZdFaLXzI3aMzSIAgjpMAKzArVLSX12PaF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420507; c=relaxed/simple;
	bh=iitfFCLJTE0y+kJ/Mc8P1qvaU4SXXc5zObH3qT9X+1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0r6Bd7I/YneJSBXmJtH2l6U2dkjhWUSJeYUE7Db35zw89ZHrpB4+Y4stRD0X+tfNb98n0O09iFjX/oM3xtV33xbM/YD/nR2PyeFEV/hv5lSscAliayhW4wM8OfyRwqCJAqqAvYn/d0a9I6C2dMtnWQDSrnDEcSSTi+FhNkFepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XaAEu4V9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFI1Jg3f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPrhwNYWJPbK9qX437sTXCnY+0U3HzpnaSqOnRkeTh0=;
	b=XaAEu4V9YZgTQu4a4CHSovZGUaQKhLGD28HWasyqMXdNQS2eqE5A/NyUYq5o9PGeDHiI55
	KeR9/1UxqYaOgZTRvcdNDTuNNJ7T2HfF4Xzs/BDpOC9JbnBu1BRK0GM+vP8l2195eezkz4
	V37y3iSCgDR6CgTq/mzwdiRHcB8QdNtsn7/xs6hsVqReE5gkS8ulIZ+5AfOsBRStypMTwP
	nEfVHPksruujrY1aKXBXLy1ve6c4zh6mYrxrDaH5imMKoLSEbLxRmqmVtxy4gofBPgHEKv
	5M8QC68Ecq1NRmoBuZ70aV2BA6NqkskSHgbEEDvAWP1aKEGj7fzdPojVrUUfhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPrhwNYWJPbK9qX437sTXCnY+0U3HzpnaSqOnRkeTh0=;
	b=ZFI1Jg3fXWbAI3jUE4sWDct3frbg/ea31yGvPpBJ5wZcCAlav/6faKTBQRaIQTp5+loN9e
	WPIZTIK28vCkhUAQ==
Date: Wed, 23 Apr 2025 17:01:38 +0200
Subject: [PATCH 08/15] tools/nolibc: add clock_getres(), clock_gettime()
 and clock_settime()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-8-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=5397;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iitfFCLJTE0y+kJ/Mc8P1qvaU4SXXc5zObH3qT9X+1I=;
 b=MAWotSyw/VzUjbGFFEAHc7Y1soQZuO763wr4at2EbYXMmbeYCZuK9HtD8AUSPElH/XWemgaV2
 S1QL8fNnYr2C1/fgRTVNs1AmBTDD8kYiM18jixHWd90nsfhTuxcBay6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/time.h                  | 92 ++++++++++++++++++++++++++++
 tools/include/nolibc/types.h                 |  2 +
 tools/testing/selftests/nolibc/nolibc-test.c |  5 ++
 3 files changed, 99 insertions(+)

diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index 84655361b9ad2ce141f9af2759f2b128ae8a83a3..fb330628a59ad8a8b2b01c027b861472888ddee4 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -12,6 +12,98 @@
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
index 32d0929c633bbae29263375c461a0c82baf7f869..08c9fdd1c7991656aabca5dd4dd363da45e00dd8 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -198,6 +198,8 @@ struct stat {
 	union { time_t st_ctime; struct timespec st_ctim; }; /* time of last status change */
 };
 
+typedef __kernel_clockid_t clockid_t;
+
 /* WARNING, it only deals with the 4096 first majors and 256 first minors */
 #define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
 #define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7090e6b7c37e49afe751835bbff6a7af4f4fcf2a..7eb69971667a196cb0855d156e3e18085851de7d 100644
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
@@ -1078,6 +1079,7 @@ int run_syscall(int min, int max)
 {
 	struct timeval tv;
 	struct timezone tz;
+	struct timespec ts;
 	struct stat stat_buf;
 	int euid0;
 	int proc;
@@ -1111,6 +1113,9 @@ int run_syscall(int min, int max)
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


