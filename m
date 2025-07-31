Return-Path: <linux-kselftest+bounces-38092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4721EB16D09
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 10:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BC55A7BDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BB229E0F7;
	Thu, 31 Jul 2025 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b2mIt17m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+/qHeegM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390291D618A;
	Thu, 31 Jul 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948838; cv=none; b=NEM0og9DzBIY1gotFoM0OUM+o7Oh2MQV2KjmT78vrIr+Z3PX+Tmo9QKH8+hA1kR7Y/ZdyAe54xY5Jw9zhNHU63HGbX+ojWSZoJ+dT+XiRjfg+4McQBvwByR8qoyc1JExxetJmCe5M6z4j7iNBS3Fz0Ki3PbydGMcEi6VDD4uedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948838; c=relaxed/simple;
	bh=DBUeK/4dDW5SXf8gO8QdhDIFDH7Wnd/tHULKDXvAky8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=REGseukdXKwKcaD2ZfbSzzY+m2UUpE/uLuj3/rcjk9cr+spoOLlbdLXbpSjnxdY2O/2lGkIK/gOpHDheWxLdRaFgBqhzAycgsn/A81N8iv0zNn5kdik+n0Sm2PAi3umvNDSBP93eEaXV5gPBYP+52btUYxjilZBY6izRQDcGvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b2mIt17m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+/qHeegM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753948835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BNHMhINxT5Tv/ptu2C4YxSku3R5B++ATlQ6WV7AbeBc=;
	b=b2mIt17mPRxyiPw8tYCru7BQ058UpOJMwAR/aG0UqSueAd5eHuAcYW2l2V8dIFC02eme2U
	JAc4MJNN9+TkmSgjMfGisDJBdrLzEEa1WmhLjbZRhVohD08V3MoSpamS/od/KebkaZmkf/
	gYJD24uxneMRK/3TJjtVRsiD+3/9Pgw6D7GDd8Wjs3cZ9jIvHMLwWoHH0Nwv/0iU/hRNPh
	4UEMfz2I3K7iKGdxAaA2GoR/mk7wh5PjlZuQ4uREHry7qVKMdNZ3VE8IJ1LcZ3s9at8EJe
	qJtGG9sdBupeuxmt2+Y4TUKEmhKc21WsLJ7qdhqlTkVdrP8BE31Ncc1aECAIMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753948835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BNHMhINxT5Tv/ptu2C4YxSku3R5B++ATlQ6WV7AbeBc=;
	b=+/qHeegMEERC4UNhtcVZpdtyYCaGnz4bVXcCCaNmxRywWYtomzoIlcmJw36q8rQO7+3lK6
	uXPpGcs8sa5WpSCQ==
Date: Thu, 31 Jul 2025 10:00:31 +0200
Subject: [PATCH] tools/nolibc: fix error return value of clock_nanosleep()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-nolibc-clock_nanosleep-ret-v1-1-9e4af7855e61@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJ8ii2gC/x3MUQqDMAwA0KtIvg3UFnHuKmOMNkYXVlJpZQji3
 S1+vp93QOEsXODZHJD5L0WSVnRtA/T1ujDKVA3W2N4MrkNNUQIhxUS/j3pNJTKvmHnDYJy340j
 m4WaowZp5lv3OX+/zvAADCqxubAAAAA==
X-Change-ID: 20250731-nolibc-clock_nanosleep-ret-b03a299c083f
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753948832; l=2601;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DBUeK/4dDW5SXf8gO8QdhDIFDH7Wnd/tHULKDXvAky8=;
 b=ku4WxUNfx5YtCiHfhqj+aDU1gCfp54Jw5l1UCUpujELwhPvX9qlZ083SJ5TToPJ5MGTGNJIaY
 xhkb6pxKFJUBee5szAs/w9LT1Cv1srq0vBRDFEySGubSPkABy8MmiZj
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

clock_nanosleep() returns a positive error value. Unlike other libc
functions it *does not* return -1 nor set errno.

Fix the return value and also adapt nanosleep().

Fixes: 7c02bc4088af ("tools/nolibc: add support for clock_nanosleep() and nanosleep()")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/time.h                  | 5 +++--
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index d02bc44d2643a5e39afa808841f7175bfab5ff7e..e9c1b976791a65c0d73268bebbcfd4f2a57a47ee 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -133,7 +133,8 @@ static __attribute__((unused))
 int clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqtp,
 		    struct timespec *rmtp)
 {
-	return __sysret(sys_clock_nanosleep(clockid, flags, rqtp, rmtp));
+	/* Directly return a positive error number */
+	return -sys_clock_nanosleep(clockid, flags, rqtp, rmtp);
 }
 
 static __inline__
@@ -145,7 +146,7 @@ double difftime(time_t time1, time_t time2)
 static __inline__
 int nanosleep(const struct timespec *rqtp, struct timespec *rmtp)
 {
-	return clock_nanosleep(CLOCK_REALTIME, 0, rqtp, rmtp);
+	return __sysret(sys_clock_nanosleep(CLOCK_REALTIME, 0, rqtp, rmtp));
 }
 
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a297ee0d6d0754dfcd9f9e5609d42c7442dabc4e..cc4d730ac4656fb5944d50be9477a3dfefb00aa0 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1334,6 +1334,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
 		CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(argv0), -1, ENOTDIR); break;
+		CASE_TEST(clock_nanosleep);   ts.tv_nsec = -1; EXPECT_EQ(1, EINVAL, clock_nanosleep(CLOCK_REALTIME, 0, &ts, NULL)); break;
 		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
 		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
 		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;

---
base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
change-id: 20250731-nolibc-clock_nanosleep-ret-b03a299c083f

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


