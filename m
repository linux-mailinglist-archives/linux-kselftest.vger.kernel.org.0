Return-Path: <linux-kselftest+bounces-47769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDF1CD3022
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D9E83003D86
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287130E0D9;
	Sat, 20 Dec 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bB2N/bAe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22230B501;
	Sat, 20 Dec 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238971; cv=none; b=mNFaFT6iuMAKDNnE7XkYrnRsgQCFxt178wPNKM6QJt386V4HUlGLdDwiuVNuT6OQ0bTBiHn3v0AvPa7zb+3110YsB5sUazE/iap4cxNVijLSBflrVdABY9Up2Jsda9t95YybraAjDPx51i/i5WRysxfHULQwIQSN5Vw5x7d4B4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238971; c=relaxed/simple;
	bh=V9dIG7YK9Ou8S/4MV3BTMVP/Ykb1X0h2FaHI7fKlKlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hjpf74dRJ7ggM0QUuSalA3cX8Z1YFZZwaDW9i6OY1VRjIQB3F7tOvQNsG1XUJpdTZElRS/gyFQlrmUoyjMor3Z+1Z36IUvGPj0IAxZzCbRVWGLduWk/oqArOUSPFq9Kzf6GN7rSztQQn5xKElnHkrYXJYePnKu6BEkQeRvGbUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bB2N/bAe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238958;
	bh=V9dIG7YK9Ou8S/4MV3BTMVP/Ykb1X0h2FaHI7fKlKlI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bB2N/bAejkRlZQkqls5NtStb9mRLUxj5eQ9CxXL+zgZYD7vT7I75+mFDWrzviSrH8
	 inS5OuhlQd3cefjhOqWOupfMs4+/6atoh7AIMGN5lIBYbIlqoUFrtIjwW6Uv39mg07
	 Hn9bfKGoBH/Iy39TD/WY8nFwl+uZZ2cI28f7E1rM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:55 +0100
Subject: [PATCH v3 11/14] tools/nolibc: remove time conversions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-11-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=6527;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=V9dIG7YK9Ou8S/4MV3BTMVP/Ykb1X0h2FaHI7fKlKlI=;
 b=zen9Ey/7hUSaoMyhtoYninwoA1hbnN0xn905lPCQ3/G9pT6MAorgMOd0fMgLsxcFZCAJf44CK
 rt5WCPSqZ4ABd9CQu5lfv5VXNTBc8KS9QJh4eMa0eIxeIXPEWBlCGh+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Now that 'struct timespec' and 'struct __kernel_timespec' are
compatible, the conversions are not necessary anymore.
The same holds true for 'struct itimerspec' and 'struct
__kernel_itimerspec'.

Remove the conversions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys/timerfd.h | 20 ++----------
 tools/include/nolibc/time.h        | 64 ++++----------------------------------
 2 files changed, 8 insertions(+), 76 deletions(-)

diff --git a/tools/include/nolibc/sys/timerfd.h b/tools/include/nolibc/sys/timerfd.h
index 66f779553d31..616fcfb416a9 100644
--- a/tools/include/nolibc/sys/timerfd.h
+++ b/tools/include/nolibc/sys/timerfd.h
@@ -33,13 +33,7 @@ static __attribute__((unused))
 int sys_timerfd_gettime(int fd, struct itimerspec *curr_value)
 {
 #if defined(__NR_timerfd_gettime64)
-	struct __kernel_itimerspec kcurr_value;
-	int ret;
-
-	ret = my_syscall2(__NR_timerfd_gettime64, fd, &kcurr_value);
-	__nolibc_timespec_kernel_to_user(&kcurr_value.it_interval, &curr_value->it_interval);
-	__nolibc_timespec_kernel_to_user(&kcurr_value.it_value, &curr_value->it_value);
-	return ret;
+	return my_syscall2(__NR_timerfd_gettime64, fd, curr_value);
 #else
 	return my_syscall2(__NR_timerfd_gettime, fd, curr_value);
 #endif
@@ -57,17 +51,7 @@ int sys_timerfd_settime(int fd, int flags,
 			const struct itimerspec *new_value, struct itimerspec *old_value)
 {
 #if defined(__NR_timerfd_settime64)
-	struct __kernel_itimerspec knew_value, kold_value;
-	int ret;
-
-	__nolibc_timespec_user_to_kernel(&new_value->it_value, &knew_value.it_value);
-	__nolibc_timespec_user_to_kernel(&new_value->it_interval, &knew_value.it_interval);
-	ret = my_syscall4(__NR_timerfd_settime64, fd, flags, &knew_value, &kold_value);
-	if (old_value) {
-		__nolibc_timespec_kernel_to_user(&kold_value.it_interval, &old_value->it_interval);
-		__nolibc_timespec_kernel_to_user(&kold_value.it_value, &old_value->it_value);
-	}
-	return ret;
+	return my_syscall4(__NR_timerfd_settime64, fd, flags, new_value, old_value);
 #else
 	return my_syscall4(__NR_timerfd_settime, fd, flags, new_value, old_value);
 #endif
diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index 45df9b09d7b6..ab67f209c99f 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -18,20 +18,6 @@
 #include <linux/signal.h>
 #include <linux/time.h>
 
-static __inline__
-void __nolibc_timespec_user_to_kernel(const struct timespec *ts, struct __kernel_timespec *kts)
-{
-	kts->tv_sec = ts->tv_sec;
-	kts->tv_nsec = ts->tv_nsec;
-}
-
-static __inline__
-void __nolibc_timespec_kernel_to_user(const struct __kernel_timespec *kts, struct timespec *ts)
-{
-	ts->tv_sec = kts->tv_sec;
-	ts->tv_nsec = kts->tv_nsec;
-}
-
 /*
  * int clock_getres(clockid_t clockid, struct timespec *res);
  * int clock_gettime(clockid_t clockid, struct timespec *tp);
@@ -44,13 +30,7 @@ static __attribute__((unused))
 int sys_clock_getres(clockid_t clockid, struct timespec *res)
 {
 #if defined(__NR_clock_getres_time64)
-	struct __kernel_timespec kres;
-	int ret;
-
-	ret = my_syscall2(__NR_clock_getres_time64, clockid, &kres);
-	if (res)
-		__nolibc_timespec_kernel_to_user(&kres, res);
-	return ret;
+	return my_syscall2(__NR_clock_getres_time64, clockid, res);
 #else
 	return my_syscall2(__NR_clock_getres, clockid, res);
 #endif
@@ -66,13 +46,7 @@ static __attribute__((unused))
 int sys_clock_gettime(clockid_t clockid, struct timespec *tp)
 {
 #if defined(__NR_clock_gettime64)
-	struct __kernel_timespec ktp;
-	int ret;
-
-	ret = my_syscall2(__NR_clock_gettime64, clockid, &ktp);
-	if (tp)
-		__nolibc_timespec_kernel_to_user(&ktp, tp);
-	return ret;
+	return my_syscall2(__NR_clock_gettime64, clockid, tp);
 #else
 	return my_syscall2(__NR_clock_gettime, clockid, tp);
 #endif
@@ -88,10 +62,7 @@ static __attribute__((unused))
 int sys_clock_settime(clockid_t clockid, struct timespec *tp)
 {
 #if defined(__NR_clock_settime64)
-	struct __kernel_timespec ktp;
-
-	__nolibc_timespec_user_to_kernel(tp, &ktp);
-	return my_syscall2(__NR_clock_settime64, clockid, &ktp);
+	return my_syscall2(__NR_clock_settime64, clockid, tp);
 #else
 	return my_syscall2(__NR_clock_settime, clockid, tp);
 #endif
@@ -108,14 +79,7 @@ int sys_clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqt
 			struct timespec *rmtp)
 {
 #if defined(__NR_clock_nanosleep_time64)
-	struct __kernel_timespec krqtp, krmtp;
-	int ret;
-
-	__nolibc_timespec_user_to_kernel(rqtp, &krqtp);
-	ret = my_syscall4(__NR_clock_nanosleep_time64, clockid, flags, &krqtp, &krmtp);
-	if (rmtp)
-		__nolibc_timespec_kernel_to_user(&krmtp, rmtp);
-	return ret;
+	return my_syscall4(__NR_clock_nanosleep_time64, clockid, flags, rqtp, rmtp);
 #else
 	return my_syscall4(__NR_clock_nanosleep, clockid, flags, rqtp, rmtp);
 #endif
@@ -190,13 +154,7 @@ static __attribute__((unused))
 int sys_timer_gettime(timer_t timerid, struct itimerspec *curr_value)
 {
 #if defined(__NR_timer_gettime64)
-	struct __kernel_itimerspec kcurr_value;
-	int ret;
-
-	ret = my_syscall2(__NR_timer_gettime64, timerid, &kcurr_value);
-	__nolibc_timespec_kernel_to_user(&kcurr_value.it_interval, &curr_value->it_interval);
-	__nolibc_timespec_kernel_to_user(&kcurr_value.it_value, &curr_value->it_value);
-	return ret;
+	return my_syscall2(__NR_timer_gettime64, timerid, curr_value);
 #else
 	return my_syscall2(__NR_timer_gettime, timerid, curr_value);
 #endif
@@ -213,17 +171,7 @@ int sys_timer_settime(timer_t timerid, int flags,
 		      const struct itimerspec *new_value, struct itimerspec *old_value)
 {
 #if defined(__NR_timer_settime64)
-	struct __kernel_itimerspec knew_value, kold_value;
-	int ret;
-
-	__nolibc_timespec_user_to_kernel(&new_value->it_value, &knew_value.it_value);
-	__nolibc_timespec_user_to_kernel(&new_value->it_interval, &knew_value.it_interval);
-	ret = my_syscall4(__NR_timer_settime64, timerid, flags, &knew_value, &kold_value);
-	if (old_value) {
-		__nolibc_timespec_kernel_to_user(&kold_value.it_interval, &old_value->it_interval);
-		__nolibc_timespec_kernel_to_user(&kold_value.it_value, &old_value->it_value);
-	}
-	return ret;
+	return my_syscall4(__NR_timer_settime64, timerid, flags, new_value, old_value);
 #else
 	return my_syscall4(__NR_timer_settime, timerid, flags, new_value, old_value);
 #endif

-- 
2.52.0


