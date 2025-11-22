Return-Path: <linux-kselftest+bounces-46322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A1C7D449
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFE3E353779
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B77D2C033C;
	Sat, 22 Nov 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fi1qAUhK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755E27054C;
	Sat, 22 Nov 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830795; cv=none; b=MmGnDMz7ent5TXr4t+n7shKYBrCr8Ut+b2oTeqQq8wcn36IT2Ks4+HoBBNxCva+SctBGsgUPkB3R9ffNh2oSPWdh6xxcFj1XpfKtAdDL3tl6aHGSluFx8/PKrrTkjY3i35NAiF9GMikads3uQC29mSB6dVIP0pkcx+uNBGCUVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830795; c=relaxed/simple;
	bh=dGVCEDJxREG493qX1+ElpZCtsb7NtbI9/rcSZtj2REU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJ6lVE4ki9mwpLgNsl7uugME9lxNmpr5YGnoaItEjKQxHRPs07DJt1w0HjLnJHSw+BuXbN3pSP0QbOMHmBkjnBfOyPi+PlEQCci7eUONvB6b+roB11LMkn0YXt81hppXqxiIoD+Kkc7fVcQJWKifmYsmDyBU5yQxxNdHraPC24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fi1qAUhK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830791;
	bh=dGVCEDJxREG493qX1+ElpZCtsb7NtbI9/rcSZtj2REU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fi1qAUhKINZAiT1Jt9SxGzuhtICtzS+p1mwYuPsj0nFuDu4IQsZFbklqtFTLvBc3L
	 HMHoLJE0WP8qDpnFJvZRdtt9ZtEp/Df2RsKtuMILTgCHso9cQrWlNZ/ZNO+4P4iH3o
	 RA+qAJQhcTNVj4lxhqp8KpWjAB7K0xboDzS1BQ9g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:11 +0100
Subject: [PATCH v2 05/13] tools/nolibc: prefer explicit 64-bit time-related
 system calls
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-5-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=8483;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dGVCEDJxREG493qX1+ElpZCtsb7NtbI9/rcSZtj2REU=;
 b=Feb5lMep6GeYqnbn6g7aGStUXJdC8awIxhxLDcxCRMAX6D2KJIHuSUOmktNCbjDZ4yLj3J3uC
 q2sA8FYZ4ckDkNB3eYbxo9c6fqgk9yQOG6/WBspDwKLiqpcolJLGygs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Make sure to always use the 64-bit safe system calls
in preparation for 64-bit time_t on 32-bit architectures.

Also prevent issues on kernels which disable CONFIG_COMPAT_32BIT_TIME
and therefore don't provide the 32-bit system calls anymore.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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


