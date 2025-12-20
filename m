Return-Path: <linux-kselftest+bounces-47774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B4CD305B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30E8E304A7E5
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DDF30F921;
	Sat, 20 Dec 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oE7eomrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1830ACEE;
	Sat, 20 Dec 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238972; cv=none; b=EbRMaO38lr7SuTEE5uaxU+Hawj74D6GWimTWAKND6oLPmSEa1PjxOdhPSYqUYBEtnbudHS1xJ0/bEmNNEZVMs9VZr9OBKb1DO5+VocY2LgwBJ/qvUm7A2mMmc3Nws0RDdNffM8flrx/A7Uw1T7kKhfR+6Q3/CD+NSuWjtU1KcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238972; c=relaxed/simple;
	bh=zQ0VkWw6yM4/fD1Ihp8MUJmTQ6FCOtXiqjFpq2+1nu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4q1NL4g9xNyx6RnQJ+idnj/UfjyuHhS6YRKTSZ12fnLSUCJ9jn4z62FhhjOQU3WXT/+3N4Lis/UJiaP/Ir0RDSAlCK8Z/Rq8oPEXCvGQQv0wJ1peI4tt6Y/ehI/LQt3f5KUbICLEqLVbv+GJRfGWGP5f7bPxblR9upaV6P+Il8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oE7eomrG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=zQ0VkWw6yM4/fD1Ihp8MUJmTQ6FCOtXiqjFpq2+1nu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oE7eomrGGaA4hffT15Vq5c4hs8yE7eBWPwMzh8D6GuvuEMt03H97OZRzseYFttqmS
	 q9sx1rfllBifigytik8YLa83JP8um4GUyczkZ7edsI33f1psXnaRkmHnpj65vr9ZFY
	 LikHX7wfzj+8YighPhg8LVOSkn+IUkTibZ7Npf4E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:49 +0100
Subject: [PATCH v3 05/14] tools/nolibc: prefer explicit 64-bit time-related
 system calls
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-5-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=8519;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zQ0VkWw6yM4/fD1Ihp8MUJmTQ6FCOtXiqjFpq2+1nu4=;
 b=ZLOtbFGWOOrYZkJjRrxyBucFvTnA+1Xgw2Kj4JefP/Iw3LZmG/8tUh+IUZhv0Ggw7N9W8KX+u
 Xczo5o1a1c4Bwm047MWBtH2R4AjtKzhr1IpTNwKXNqO9P7fwP22xt98
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Make sure to always use the 64-bit safe system calls
in preparation for 64-bit time_t on 32-bit architectures.

Also prevent issues on kernels which disable CONFIG_COMPAT_32BIT_TIME
and therefore don't provide the 32-bit system calls anymore.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/poll.h        | 10 +++++-----
 tools/include/nolibc/sys/select.h  | 10 +++++-----
 tools/include/nolibc/sys/timerfd.h | 12 ++++++------
 tools/include/nolibc/time.h        | 36 ++++++++++++++++++------------------
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/tools/include/nolibc/poll.h b/tools/include/nolibc/poll.h
index 5b4fa339fbb5..e854c94647b1 100644
--- a/tools/include/nolibc/poll.h
+++ b/tools/include/nolibc/poll.h
@@ -23,22 +23,22 @@
 static __attribute__((unused))
 int sys_poll(struct pollfd *fds, int nfds, int timeout)
 {
-#if defined(__NR_ppoll)
-	struct __kernel_old_timespec t;
+#if defined(__NR_ppoll_time64)
+	struct __kernel_timespec t;
 
 	if (timeout >= 0) {
 		t.tv_sec  = timeout / 1000;
 		t.tv_nsec = (timeout % 1000) * 1000000;
 	}
-	return my_syscall5(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
+	return my_syscall5(__NR_ppoll_time64, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
 #else
-	struct __kernel_timespec t;
+	struct __kernel_old_timespec t;
 
 	if (timeout >= 0) {
 		t.tv_sec  = timeout / 1000;
 		t.tv_nsec = (timeout % 1000) * 1000000;
 	}
-	return my_syscall5(__NR_ppoll_time64, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
+	return my_syscall5(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
 #endif
 }
 
diff --git a/tools/include/nolibc/sys/select.h b/tools/include/nolibc/sys/select.h
index 50b77dace7ef..f8870ad49687 100644
--- a/tools/include/nolibc/sys/select.h
+++ b/tools/include/nolibc/sys/select.h
@@ -63,22 +63,22 @@ typedef struct {
 static __attribute__((unused))
 int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
 {
-#if defined(__NR_pselect6)
-	struct __kernel_old_timespec t;
+#if defined(__NR_pselect6_time64)
+	struct __kernel_timespec t;
 
 	if (timeout) {
 		t.tv_sec  = timeout->tv_sec;
 		t.tv_nsec = timeout->tv_usec * 1000;
 	}
-	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
+	return my_syscall6(__NR_pselect6_time64, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
 #else
-	struct __kernel_timespec t;
+	struct __kernel_old_timespec t;
 
 	if (timeout) {
 		t.tv_sec  = timeout->tv_sec;
 		t.tv_nsec = timeout->tv_usec * 1000;
 	}
-	return my_syscall6(__NR_pselect6_time64, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
+	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
 #endif
 }
 
diff --git a/tools/include/nolibc/sys/timerfd.h b/tools/include/nolibc/sys/timerfd.h
index 5dd61030c991..66f779553d31 100644
--- a/tools/include/nolibc/sys/timerfd.h
+++ b/tools/include/nolibc/sys/timerfd.h
@@ -32,9 +32,7 @@ int timerfd_create(int clockid, int flags)
 static __attribute__((unused))
 int sys_timerfd_gettime(int fd, struct itimerspec *curr_value)
 {
-#if defined(__NR_timerfd_gettime)
-	return my_syscall2(__NR_timerfd_gettime, fd, curr_value);
-#else
+#if defined(__NR_timerfd_gettime64)
 	struct __kernel_itimerspec kcurr_value;
 	int ret;
 
@@ -42,6 +40,8 @@ int sys_timerfd_gettime(int fd, struct itimerspec *curr_value)
 	__nolibc_timespec_kernel_to_user(&kcurr_value.it_interval, &curr_value->it_interval);
 	__nolibc_timespec_kernel_to_user(&kcurr_value.it_value, &curr_value->it_value);
 	return ret;
+#else
+	return my_syscall2(__NR_timerfd_gettime, fd, curr_value);
 #endif
 }
 
@@ -56,9 +56,7 @@ static __attribute__((unused))
 int sys_timerfd_settime(int fd, int flags,
 			const struct itimerspec *new_value, struct itimerspec *old_value)
 {
-#if defined(__NR_timerfd_settime)
-	return my_syscall4(__NR_timerfd_settime, fd, flags, new_value, old_value);
-#else
+#if defined(__NR_timerfd_settime64)
 	struct __kernel_itimerspec knew_value, kold_value;
 	int ret;
 
@@ -70,6 +68,8 @@ int sys_timerfd_settime(int fd, int flags,
 		__nolibc_timespec_kernel_to_user(&kold_value.it_value, &old_value->it_value);
 	}
 	return ret;
+#else
+	return my_syscall4(__NR_timerfd_settime, fd, flags, new_value, old_value);
 #endif
 }
 
diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index 48e78f8becf9..45df9b09d7b6 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -43,9 +43,7 @@ void __nolibc_timespec_kernel_to_user(const struct __kernel_timespec *kts, struc
 static __attribute__((unused))
 int sys_clock_getres(clockid_t clockid, struct timespec *res)
 {
-#if defined(__NR_clock_getres)
-	return my_syscall2(__NR_clock_getres, clockid, res);
-#else
+#if defined(__NR_clock_getres_time64)
 	struct __kernel_timespec kres;
 	int ret;
 
@@ -53,6 +51,8 @@ int sys_clock_getres(clockid_t clockid, struct timespec *res)
 	if (res)
 		__nolibc_timespec_kernel_to_user(&kres, res);
 	return ret;
+#else
+	return my_syscall2(__NR_clock_getres, clockid, res);
 #endif
 }
 
@@ -65,9 +65,7 @@ int clock_getres(clockid_t clockid, struct timespec *res)
 static __attribute__((unused))
 int sys_clock_gettime(clockid_t clockid, struct timespec *tp)
 {
-#if defined(__NR_clock_gettime)
-	return my_syscall2(__NR_clock_gettime, clockid, tp);
-#else
+#if defined(__NR_clock_gettime64)
 	struct __kernel_timespec ktp;
 	int ret;
 
@@ -75,6 +73,8 @@ int sys_clock_gettime(clockid_t clockid, struct timespec *tp)
 	if (tp)
 		__nolibc_timespec_kernel_to_user(&ktp, tp);
 	return ret;
+#else
+	return my_syscall2(__NR_clock_gettime, clockid, tp);
 #endif
 }
 
@@ -87,13 +87,13 @@ int clock_gettime(clockid_t clockid, struct timespec *tp)
 static __attribute__((unused))
 int sys_clock_settime(clockid_t clockid, struct timespec *tp)
 {
-#if defined(__NR_clock_settime)
-	return my_syscall2(__NR_clock_settime, clockid, tp);
-#else
+#if defined(__NR_clock_settime64)
 	struct __kernel_timespec ktp;
 
 	__nolibc_timespec_user_to_kernel(tp, &ktp);
 	return my_syscall2(__NR_clock_settime64, clockid, &ktp);
+#else
+	return my_syscall2(__NR_clock_settime, clockid, tp);
 #endif
 }
 
@@ -107,9 +107,7 @@ static __attribute__((unused))
 int sys_clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqtp,
 			struct timespec *rmtp)
 {
-#if defined(__NR_clock_nanosleep)
-	return my_syscall4(__NR_clock_nanosleep, clockid, flags, rqtp, rmtp);
-#else
+#if defined(__NR_clock_nanosleep_time64)
 	struct __kernel_timespec krqtp, krmtp;
 	int ret;
 
@@ -118,6 +116,8 @@ int sys_clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqt
 	if (rmtp)
 		__nolibc_timespec_kernel_to_user(&krmtp, rmtp);
 	return ret;
+#else
+	return my_syscall4(__NR_clock_nanosleep, clockid, flags, rqtp, rmtp);
 #endif
 }
 
@@ -189,9 +189,7 @@ int timer_delete(timer_t timerid)
 static __attribute__((unused))
 int sys_timer_gettime(timer_t timerid, struct itimerspec *curr_value)
 {
-#if defined(__NR_timer_gettime)
-	return my_syscall2(__NR_timer_gettime, timerid, curr_value);
-#else
+#if defined(__NR_timer_gettime64)
 	struct __kernel_itimerspec kcurr_value;
 	int ret;
 
@@ -199,6 +197,8 @@ int sys_timer_gettime(timer_t timerid, struct itimerspec *curr_value)
 	__nolibc_timespec_kernel_to_user(&kcurr_value.it_interval, &curr_value->it_interval);
 	__nolibc_timespec_kernel_to_user(&kcurr_value.it_value, &curr_value->it_value);
 	return ret;
+#else
+	return my_syscall2(__NR_timer_gettime, timerid, curr_value);
 #endif
 }
 
@@ -212,9 +212,7 @@ static __attribute__((unused))
 int sys_timer_settime(timer_t timerid, int flags,
 		      const struct itimerspec *new_value, struct itimerspec *old_value)
 {
-#if defined(__NR_timer_settime)
-	return my_syscall4(__NR_timer_settime, timerid, flags, new_value, old_value);
-#else
+#if defined(__NR_timer_settime64)
 	struct __kernel_itimerspec knew_value, kold_value;
 	int ret;
 
@@ -226,6 +224,8 @@ int sys_timer_settime(timer_t timerid, int flags,
 		__nolibc_timespec_kernel_to_user(&kold_value.it_value, &old_value->it_value);
 	}
 	return ret;
+#else
+	return my_syscall4(__NR_timer_settime, timerid, flags, new_value, old_value);
 #endif
 }
 

-- 
2.52.0


