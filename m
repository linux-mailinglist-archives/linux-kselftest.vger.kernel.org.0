Return-Path: <linux-kselftest+bounces-45560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BEBC588E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AB294FDEC2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D06D357736;
	Thu, 13 Nov 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zc1CGpYF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5E9lBFkD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C33563F5;
	Thu, 13 Nov 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047877; cv=none; b=ae3M+gAFzNNgZRaPaTx3I+heaOxjGPSY9DhtYA64m0P+MLjqQWFtZAVUlKnEr5xH5+/AjU15y4obbC7o6XDNKlFl/YMPbIU4m+XsU6GsePxIUUwYug1mDquA3tdX2aPCa+9qGVQnolCfnewx88D8XGYBR0dBdFK5urMuogYZtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047877; c=relaxed/simple;
	bh=d+jX5oKg97wnWczmWgj4ARbemuOMARMiBHxW0i+sU3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaCv20Op8ZC9++KiDQxk3sXN9G13MAGzjK48Esv21ZSW4WSX8f6YUxCpey+xcKczaphOOznEGIL9E8DsZrukJ5QfWDDgf0HaAJFDuLaLVMG6N+QWRKW8XIgm/yFivqdEOLfvX5+dNnI2SQkxitT2bZEvoKWSpXXM6LUfkhHK85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zc1CGpYF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5E9lBFkD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZUBlUZ3/0PUhBjY+iwfE/jHgMYfdPz62xyEz521tm0=;
	b=zc1CGpYFhBQhS6kq4Z+p8nOJeXc0VGW3pPjOquyHYzUkvii8ZW5MeMkaPrprq00y0A1+Kt
	Y0c62U7gkOeVSDzRhwfxHp++7WvTuMp0uo4LsoDGRVxZD82H4lo5dJ5n7WhrcfpbD8AAKP
	lGx4/WKhNErBPgSUSBDjqaqfCnuNLZ5HfuQpzppjqtVI9Q/gM5N0fgcayZ2YK8I5HyELEl
	lVBHBYi8tq5TPXRzQJ2BOOC9fDxOh18+g7KeZunfWolrH5iY81z0FXwgWNkfWDHlaGs2gC
	XRcdGy61AbChhqTnjZ39MvB0kspIv9X/Ix7rUjKhdePE2rIEhQwZYLLjSDsd5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZUBlUZ3/0PUhBjY+iwfE/jHgMYfdPz62xyEz521tm0=;
	b=5E9lBFkDQ4NLY9F72pO5pQjy+piLJWOjPNmmSAQtDkaD7PtMErdtETxWsLs7MXVggZmsNu
	HukfX+PLqKmxkGDw==
Date: Thu, 13 Nov 2025 16:30:26 +0100
Subject: [PATCH v2 10/14] selftests: vDSO: vdso_test_correctness: Make
 ts_leq() and tv_leq() more generic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-10-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=2424;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=d+jX5oKg97wnWczmWgj4ARbemuOMARMiBHxW0i+sU3s=;
 b=DV+oLaXPHH2fankJOmmKso1BzTDgBddBnbib+sWJ50fgl6vvYRKwkl6xHvgr2bfPUwBS1tspO
 rDWhgSbnMEjDsi3iQuObWq5U/d69rYalDpjM7dwhEo5Qtqzxm9qwhM6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Upcoming changes will shuffle around the timespec and timeval types.
To keep ts_leq() and tv_leq() working with all of those types, transform
them into macros.

Also drop ts64_leq() as it can now be replaced by the regular ts_leq().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 .../testing/selftests/vDSO/vdso_test_correctness.c | 47 ++++++++++------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 66cd1d4c19872e78c0e608f5e0fb5215cf902b50..5a127fc93e7368cbe8d9fb4a4482a6a735ffd46c 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -213,30 +213,27 @@ static void test_getcpu(void)
 	}
 }
 
-static bool ts_leq(const struct timespec *a, const struct timespec *b)
-{
-	if (a->tv_sec != b->tv_sec)
-		return a->tv_sec < b->tv_sec;
-	else
-		return a->tv_nsec <= b->tv_nsec;
-}
-
-static bool ts64_leq(const struct __kernel_timespec *a,
-		     const struct __kernel_timespec *b)
-{
-	if (a->tv_sec != b->tv_sec)
-		return a->tv_sec < b->tv_sec;
-	else
-		return a->tv_nsec <= b->tv_nsec;
-}
-
-static bool tv_leq(const struct timeval *a, const struct timeval *b)
-{
-	if (a->tv_sec != b->tv_sec)
-		return a->tv_sec < b->tv_sec;
-	else
-		return a->tv_usec <= b->tv_usec;
-}
+#define ts_leq(_a, _b)	({				\
+	bool _ret;					\
+							\
+	if ((_a)->tv_sec != (_b)->tv_sec)		\
+		_ret = (_a)->tv_sec < (_b)->tv_sec;	\
+	else						\
+		_ret = (_a)->tv_nsec <= (_b)->tv_nsec;	\
+							\
+	_ret;						\
+})
+
+#define tv_leq(_a, _b)	({				\
+	bool _ret;					\
+							\
+	if ((_a)->tv_sec != (_b)->tv_sec)		\
+		_ret = (_a)->tv_sec < (_b)->tv_sec;	\
+	else						\
+		_ret = (_a)->tv_usec <= (_b)->tv_usec;	\
+							\
+	_ret;						\
+})
 
 static char const * const clocknames[] = {
 	[0] = "CLOCK_REALTIME",
@@ -352,7 +349,7 @@ static void test_one_clock_gettime64(int clock, const char *name)
 	       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
 	       (unsigned long long)end.tv_sec, end.tv_nsec);
 
-	if (!ts64_leq(&start, &vdso) || !ts64_leq(&vdso, &end)) {
+	if (!ts_leq(&start, &vdso) || !ts_leq(&vdso, &end)) {
 		printf("[FAIL]\tTimes are out of sequence\n");
 		nerrs++;
 		return;

-- 
2.51.0


