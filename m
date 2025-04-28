Return-Path: <linux-kselftest+bounces-31775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFE9A9F103
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BE8460C47
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0EC26FA5A;
	Mon, 28 Apr 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dttleIPn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qiGd4pjF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2526B960;
	Mon, 28 Apr 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844017; cv=none; b=ALYf5FxCjyuPhAPoyKRcghoThXkPKAuOfqRnYV3yLAktpk7g+UgeEeSYh8ZxnlmlA3F0anPE3igPae4pfwFSc9MTbVDsmQByE4vHTFDFK5GluMNvx8UOfOi8OlXF156amN67qxWsxiTmxgE/A3zavAmz7QuMWoSyPoU+Or11HyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844017; c=relaxed/simple;
	bh=r7MpfiNnGdfXFcxKitAEOsdH4MgCqhIf1FBUF/XO6/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUjtF1rNRqUHz4YbN2+iiBqQoUh89mVMESIM8wioBXOvB5d6kJWSR0W1tWsGG/rWW+7YP60PQgnnFk/Xu1NkIj8UMGfmjwZs7L0LhARQYGwss7d+mXOKqq8moJc4zt1vKG9C5YExAqS5WRegEIRselX+6zuHLjOZk/IM7WIDJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dttleIPn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qiGd4pjF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TN3r7fgOPxBE2HHLeJFIdrF/MUglLa7bwqqPumSJmTM=;
	b=dttleIPnkspJoZ6pmr9fsZW8rwyRPfF6a75r06ZyWhUjOolYfe5LiiEw2PTXo2tKGY+I1r
	q72kNZ88ly+MagUBGNeRnb0j5IS0CgMZqIsNtgGEvWWucBVVBHXt/yk1JSYsiJUBd+2UKF
	zoJMKIwCT6jTN1jY9J+CV84cNH/gckRYAenNQcIjbdbp2TLHVjG+tlAO1pHXy0j62kcAmf
	UW9mySovty6SQ7HDpcscNxhQMe5b7vjKnHWK1iMzgVCT/8S7Rh01ovVFN245t1w+FNiYxN
	SSkerfiOw+wSUCZTSZKSnyG5gSdgRi3DeqG9sbtpq5N5Ek7tAg7ciDtY12Aabg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TN3r7fgOPxBE2HHLeJFIdrF/MUglLa7bwqqPumSJmTM=;
	b=qiGd4pjFK7MtvNxMQMxxp12u/o3u5KSPi/0hvgxEDed/YTqxbHTOCi70CaUBF+7fW1izZr
	zayEgeyTwA4F89CA==
Date: Mon, 28 Apr 2025 14:40:10 +0200
Subject: [PATCH v2 09/15] tools/nolibc: add timer functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-9-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=6391;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=r7MpfiNnGdfXFcxKitAEOsdH4MgCqhIf1FBUF/XO6/Y=;
 b=QP9nlx4NsXKJLj2GiDQoEcbUKApPz/Oe5hgr31WfcZ2R6ifFG74nb3Ws3BRhQUspjHBsoO4qq
 5LER7GTxX/cB/cFX/cduibAiLYurw7iPUz0YAf04W324eqFgkZ+DKuE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/time.h                  | 86 ++++++++++++++++++++++++++++
 tools/include/nolibc/types.h                 |  1 +
 tools/testing/selftests/nolibc/nolibc-test.c | 51 +++++++++++++++++
 3 files changed, 138 insertions(+)

diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index 7e0b7eac0b7c31910a48ebb9755d5004e5da1a69..48f602b661b300a0bfbac5a231315fc95727c04e 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -15,6 +15,7 @@
 #include "types.h"
 #include "sys.h"
 
+#include <linux/signal.h>
 #include <linux/time.h>
 
 static __inline__
@@ -120,4 +121,89 @@ time_t time(time_t *tptr)
 	return tv.tv_sec;
 }
 
+
+/*
+ * int timer_create(clockid_t clockid, struct sigevent *evp, timer_t *timerid);
+ * int timer_gettime(timer_t timerid, struct itimerspec *curr_value);
+ * int timer_settime(timer_t timerid, int flags, const struct itimerspec *new_value, struct itimerspec *old_value);
+ */
+
+static __attribute__((unused))
+int sys_timer_create(clockid_t clockid, struct sigevent *evp, timer_t *timerid)
+{
+	return my_syscall3(__NR_timer_create, clockid, evp, timerid);
+}
+
+static __attribute__((unused))
+int timer_create(clockid_t clockid, struct sigevent *evp, timer_t *timerid)
+{
+	return __sysret(sys_timer_create(clockid, evp, timerid));
+}
+
+static __attribute__((unused))
+int sys_timer_delete(timer_t timerid)
+{
+	return my_syscall1(__NR_timer_delete, timerid);
+}
+
+static __attribute__((unused))
+int timer_delete(timer_t timerid)
+{
+	return __sysret(sys_timer_delete(timerid));
+}
+
+static __attribute__((unused))
+int sys_timer_gettime(timer_t timerid, struct itimerspec *curr_value)
+{
+#if defined(__NR_timer_gettime)
+	return my_syscall2(__NR_timer_gettime, timerid, curr_value);
+#elif defined(__NR_timer_gettime64)
+	struct __kernel_itimerspec kcurr_value;
+	int ret;
+
+	ret = my_syscall2(__NR_timer_gettime64, timerid, &kcurr_value);
+	__nolibc_timespec_kernel_to_user(&kcurr_value.it_interval, &curr_value->it_interval);
+	__nolibc_timespec_kernel_to_user(&kcurr_value.it_value, &curr_value->it_value);
+	return ret;
+#else
+	return __nolibc_enosys(__func__, timerid, curr_value);
+#endif
+}
+
+static __attribute__((unused))
+int timer_gettime(timer_t timerid, struct itimerspec *curr_value)
+{
+	return __sysret(sys_timer_gettime(timerid, curr_value));
+}
+
+static __attribute__((unused))
+int sys_timer_settime(timer_t timerid, int flags,
+		      const struct itimerspec *new_value, struct itimerspec *old_value)
+{
+#if defined(__NR_timer_settime)
+	return my_syscall4(__NR_timer_settime, timerid, flags, new_value, old_value);
+#elif defined(__NR_timer_settime64)
+	struct __kernel_itimerspec knew_value, kold_value;
+	int ret;
+
+	__nolibc_timespec_user_to_kernel(&new_value->it_value, &knew_value.it_value);
+	__nolibc_timespec_user_to_kernel(&new_value->it_interval, &knew_value.it_interval);
+	ret = my_syscall4(__NR_timer_settime64, timerid, flags, &knew_value, &kold_value);
+	if (old_value) {
+		__nolibc_timespec_kernel_to_user(&kold_value.it_interval, &old_value->it_interval);
+		__nolibc_timespec_kernel_to_user(&kold_value.it_value, &old_value->it_value);
+	}
+	return ret;
+#else
+	return __nolibc_enosys(__func__, timerid, flags, new_value, old_value);
+#endif
+}
+
+static __attribute__((unused))
+int timer_settime(timer_t timerid, int flags,
+		  const struct itimerspec *new_value, struct itimerspec *old_value)
+{
+	return __sysret(sys_timer_settime(timerid, flags, new_value, old_value));
+}
+
 #endif /* _NOLIBC_TIME_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 8eb48d98667f5fe65bb8a974f613fd1fd17ae11e..2b02d4531427ca071d6e55abac5260a0b0226c40 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -202,6 +202,7 @@ struct stat {
 };
 
 typedef __kernel_clockid_t clockid_t;
+typedef int timer_t;
 
 /* WARNING, it only deals with the 4096 first majors and 256 first minors */
 #define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 9b8aa41a547b1735014c5a7541e426f4e08c7f90..7530b442941f5538cd1d54974e7c8aa435513653 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -905,6 +905,56 @@ int test_stat_timestamps(void)
 	return 0;
 }
 
+int test_timer(void)
+{
+	struct itimerspec timerspec;
+	struct sigevent evp;
+	timer_t timer;
+	int ret;
+
+	evp.sigev_notify = SIGEV_NONE;
+
+	ret = timer_create(CLOCK_MONOTONIC, &evp, &timer);
+	if (ret)
+		return ret;
+
+	timerspec = (struct itimerspec) {
+		.it_value.tv_sec = 1000000,
+	};
+	ret = timer_settime(timer, 0, &timerspec, NULL);
+	if (ret)
+		goto err;
+
+	timerspec = (struct itimerspec) {
+		.it_value.tv_sec = -1,
+		.it_value.tv_nsec = -1,
+		.it_interval.tv_sec = -1,
+		.it_interval.tv_nsec = -1,
+	};
+	ret = timer_gettime(timer, &timerspec);
+	if (ret)
+		goto err;
+
+	errno = EINVAL;
+	ret = -1;
+
+	if (timerspec.it_interval.tv_sec || timerspec.it_interval.tv_nsec)
+		goto err;
+
+	if (timerspec.it_value.tv_sec > 1000000)
+		goto err;
+
+	ret = timer_delete(timer);
+	if (ret)
+		return ret;
+
+	return 0;
+
+err:
+	timer_delete(timer);
+	return ret;
+}
+
 int test_uname(void)
 {
 	struct utsname buf;
@@ -1186,6 +1236,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
+		CASE_TEST(timer);             EXPECT_SYSZR(1, test_timer()); break;
 		CASE_TEST(uname);             EXPECT_SYSZR(proc, test_uname()); break;
 		CASE_TEST(uname_fault);       EXPECT_SYSER(1, uname(NULL), -1, EFAULT); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;

-- 
2.49.0


