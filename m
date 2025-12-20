Return-Path: <linux-kselftest+bounces-47775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DD1CD303A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 412383028315
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB1531195B;
	Sat, 20 Dec 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="D1x7qdeC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280330C62D;
	Sat, 20 Dec 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238974; cv=none; b=ZYMFdlfc4DrOINWgVkUnpcJMQz2t53D0DQcW9E8T9Dwto2rRPiubOhKZ5hsnlcBTJufDx0iD3BX3bk2j2bdLu9OzxxsNZ6es2wsATS7zYz26IBlRwsIlWDi4FzGVWuMvQDDGXpIil97sBrzsBxy2VJhmSWBaQ5dDeRDyZXqX9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238974; c=relaxed/simple;
	bh=AkKGdffRJhoV8i1ps7+8e6eSUsB3GUo6tcvXELLJVvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdU6+YXpOF69pBmgD1M3AJnJ0O/9FpSEA6nt9BeF1L0NzrGKwH8I5bZqK07qUb49mk/iwU3BxI7KWO1M/mqZloYsAkqKb+bBW8d4dMCF23kicZjI/JnNDKQFuWIxZZhkIxSnDnkE5qV2xN0wvBMDUaM0/btF+BJVNx8cedKk+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=D1x7qdeC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238958;
	bh=AkKGdffRJhoV8i1ps7+8e6eSUsB3GUo6tcvXELLJVvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D1x7qdeCvFeBAaPcke5FwdqplVTFGvs2xOUzybEhV3wW+rplQQMPJChyyZOlh+lfJ
	 RjIVdKGl9WPQKwQutTeJyaCD7Ci2cpfN1rjwz9MkOw9W8A9HboHBie+hIbIALX4ib+
	 ASP1KfcT5Rg97/qKnMryFXZyV0UDCg1oyj8PVZWs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:58 +0100
Subject: [PATCH v3 14/14] selftests/nolibc: add static assertions around
 time types handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-14-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=4485;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AkKGdffRJhoV8i1ps7+8e6eSUsB3GUo6tcvXELLJVvI=;
 b=rwfcwWYSFfDATp3sBwBy+RN7W4q3KTEFBSxblVEfod7ucPUPIWV+6dj45YIghwwB2ZOKlrucQ
 5Y3XWVcx3YlC2miM2MoEpv+RMi5kJonOA3USYkG9woPApgRyePZGl9A
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The nolibc system call wrappers expect the libc types to be compatible
to the kernel types.

Make sure these expectations hold at compile-time.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys/timerfd.h |  4 ++++
 tools/include/nolibc/time.h        | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/include/nolibc/sys/timerfd.h b/tools/include/nolibc/sys/timerfd.h
index 616fcfb416a9..29fd92bd47d2 100644
--- a/tools/include/nolibc/sys/timerfd.h
+++ b/tools/include/nolibc/sys/timerfd.h
@@ -33,8 +33,10 @@ static __attribute__((unused))
 int sys_timerfd_gettime(int fd, struct itimerspec *curr_value)
 {
 #if defined(__NR_timerfd_gettime64)
+	__nolibc_assert_time64_type(curr_value->it_value.tv_sec);
 	return my_syscall2(__NR_timerfd_gettime64, fd, curr_value);
 #else
+	__nolibc_assert_native_time64();
 	return my_syscall2(__NR_timerfd_gettime, fd, curr_value);
 #endif
 }
@@ -51,8 +53,10 @@ int sys_timerfd_settime(int fd, int flags,
 			const struct itimerspec *new_value, struct itimerspec *old_value)
 {
 #if defined(__NR_timerfd_settime64)
+	__nolibc_assert_time64_type(new_value->it_value.tv_sec);
 	return my_syscall4(__NR_timerfd_settime64, fd, flags, new_value, old_value);
 #else
+	__nolibc_assert_native_time64();
 	return my_syscall4(__NR_timerfd_settime, fd, flags, new_value, old_value);
 #endif
 }
diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index ab67f209c99f..f9257d6a7878 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -18,6 +18,12 @@
 #include <linux/signal.h>
 #include <linux/time.h>
 
+#define __nolibc_assert_time64_type(t) \
+	__nolibc_static_assert(sizeof(t) == 8)
+
+#define __nolibc_assert_native_time64() \
+	__nolibc_assert_time64_type(__kernel_old_time_t)
+
 /*
  * int clock_getres(clockid_t clockid, struct timespec *res);
  * int clock_gettime(clockid_t clockid, struct timespec *tp);
@@ -30,8 +36,10 @@ static __attribute__((unused))
 int sys_clock_getres(clockid_t clockid, struct timespec *res)
 {
 #if defined(__NR_clock_getres_time64)
+	__nolibc_assert_time64_type(res->tv_sec);
 	return my_syscall2(__NR_clock_getres_time64, clockid, res);
 #else
+	__nolibc_assert_native_time64();
 	return my_syscall2(__NR_clock_getres, clockid, res);
 #endif
 }
@@ -46,8 +54,10 @@ static __attribute__((unused))
 int sys_clock_gettime(clockid_t clockid, struct timespec *tp)
 {
 #if defined(__NR_clock_gettime64)
+	__nolibc_assert_time64_type(tp->tv_sec);
 	return my_syscall2(__NR_clock_gettime64, clockid, tp);
 #else
+	__nolibc_assert_native_time64();
 	return my_syscall2(__NR_clock_gettime, clockid, tp);
 #endif
 }
@@ -62,8 +72,10 @@ static __attribute__((unused))
 int sys_clock_settime(clockid_t clockid, struct timespec *tp)
 {
 #if defined(__NR_clock_settime64)
+	__nolibc_assert_time64_type(tp->tv_sec);
 	return my_syscall2(__NR_clock_settime64, clockid, tp);
 #else
+	__nolibc_assert_native_time64();
 	return my_syscall2(__NR_clock_settime, clockid, tp);
 #endif
 }
@@ -79,8 +91,10 @@ int sys_clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqt
 			struct timespec *rmtp)
 {
 #if defined(__NR_clock_nanosleep_time64)
+	__nolibc_assert_time64_type(rqtp->tv_sec);
 	return my_syscall4(__NR_clock_nanosleep_time64, clockid, flags, rqtp, rmtp);
 #else
+	__nolibc_assert_native_time64();
 	return my_syscall4(__NR_clock_nanosleep, clockid, flags, rqtp, rmtp);
 #endif
 }
@@ -154,8 +168,10 @@ static __attribute__((unused))
 int sys_timer_gettime(timer_t timerid, struct itimerspec *curr_value)
 {
 #if defined(__NR_timer_gettime64)
+	__nolibc_assert_time64_type(curr_value->it_value.tv_sec);
 	return my_syscall2(__NR_timer_gettime64, timerid, curr_value);
 #else
+	__nolibc_assert_native_time64();
 	return my_syscall2(__NR_timer_gettime, timerid, curr_value);
 #endif
 }
@@ -171,8 +187,10 @@ int sys_timer_settime(timer_t timerid, int flags,
 		      const struct itimerspec *new_value, struct itimerspec *old_value)
 {
 #if defined(__NR_timer_settime64)
+	__nolibc_assert_time64_type(new_value->it_value.tv_sec);
 	return my_syscall4(__NR_timer_settime64, timerid, flags, new_value, old_value);
 #else
+	__nolibc_assert_native_time64();
 	return my_syscall4(__NR_timer_settime, timerid, flags, new_value, old_value);
 #endif
 }

-- 
2.52.0


