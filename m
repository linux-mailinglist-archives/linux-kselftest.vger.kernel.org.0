Return-Path: <linux-kselftest+bounces-31419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D33BA98F68
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2842017F7A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6B28CF59;
	Wed, 23 Apr 2025 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LACa2Hac";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uh0cm7Yr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D128B50B;
	Wed, 23 Apr 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420510; cv=none; b=SNLx/p8Lot52tu2aDUOEGL3JV+ogMlx2faqNXfTxAxEey2fAQqavUnDtkEGyW5Qan0p6q/Ex+bpR27BQKNRRuvJzZUDFpvxmstdid/gZCk06QVZitwxH68UBDBWvYr00vhvIWxmB3Pa3I6GYdhj2edj1WSx2OX0D9pey/24bDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420510; c=relaxed/simple;
	bh=9H7RvcZBbPXMLyb8mShjwm8voZBm+v2g1s9nr5SlohY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNudxdocjTXmNUqbKK4VeVA1IRu/NKaTBFvxM/DaHANQEJKjqsNR/LTqTRI9Z18YtDA4GWB6zdF9glYHHQpOqoJLtSnhE4mczY7n56zjAvC+IE9pU6I/c4/2YwukzxStmXss7RUTYyIG2gQMm0S1lwWPjFzJFRIim7u4IUI0YrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LACa2Hac; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uh0cm7Yr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LJq/1nYP1KELL7mieiK61zxyQg8oMgPrLAC0XbiP+U=;
	b=LACa2HacTg7b77RB4Hjmw+H0sYfMhOg8++SGo5kl66M3s36tmRaIoc1oyG85P5xlBEqDb8
	zS1yCCLb+Oi/BvnhnTKsB7xPOlGmP0k62u0TjbwuHeiJ+EP9CDrRT2z6t3h1DB32v9nJNv
	xnIKmygAmH0cRubyPwi1uKq4hmxa1WpCDASEzuINCepmFl9sG42x5IriWB5yiXp8SElHlw
	LJTbzU2A6K3/Wk4tDQvDd8Bh78uJ5P9yAs7Fj5Jy2rGYNdDgm4IfLgQi2QhRwcXghD0OvS
	PXHijcMRtWkXCJZftJO8Besccc76TsPrlpN5NxFyhbzEHENP4EpnptAPQoaU+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LJq/1nYP1KELL7mieiK61zxyQg8oMgPrLAC0XbiP+U=;
	b=uh0cm7YrVbka2k6daoLX7zp5xGP3XNyYICMIV5SPr2oG7kM7ual2hwnehqb/Jq+kkm0ASN
	sIMBJ05MINnQyfAQ==
Date: Wed, 23 Apr 2025 17:01:44 +0200
Subject: [PATCH 14/15] tools/nolibc: implement fall back to
 sys_clock_gettime() in gettimeofday()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-14-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=1427;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=9H7RvcZBbPXMLyb8mShjwm8voZBm+v2g1s9nr5SlohY=;
 b=L0hARfzpKl6uaBdYMbEWUUcsXXRJExqRq/vNnj/2y97EkeP8dop9x00sMP/8+Q2c3cbMxPgN7
 cJdVZYpdIFVAsFkB8kPYglBrM2OsKfoIyHjRylK1ElkVsr6iXJT9pDP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Newer architectures (like riscv32) do not implement sys_gettimeofday().
In those cases fall back to sys_clock_gettime().
While that does not support the timezone argument of sys_gettimeofday(),
specifying this argument invokes undefined behaviour, so it's safe to ignore.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys/time.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys/time.h b/tools/include/nolibc/sys/time.h
index 1d326c05ee627b6bdb7d2777cbb11eea385f2407..e949844bf642a4ffd8a95d95752d4b9c37d71ac5 100644
--- a/tools/include/nolibc/sys/time.h
+++ b/tools/include/nolibc/sys/time.h
@@ -10,6 +10,8 @@
 #include "../arch.h"
 #include "../sys.h"
 
+static int sys_clock_gettime(clockid_t clockid, struct timespec *tp);
+
 /*
  * int gettimeofday(struct timeval *tv, struct timezone *tz);
  */
@@ -20,7 +22,18 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 #ifdef __NR_gettimeofday
 	return my_syscall2(__NR_gettimeofday, tv, tz);
 #else
-	return __nolibc_enosys(__func__, tv, tz);
+	(void) tz; /* Non-NULL tz is undefined behaviour */
+
+	struct timespec tp;
+	int ret;
+
+	ret = sys_clock_gettime(CLOCK_REALTIME, &tp);
+	if (!ret && tv) {
+		tv->tv_sec = tp.tv_sec;
+		tv->tv_usec = tp.tv_nsec / 1000;
+	}
+
+	return ret;
 #endif
 }
 

-- 
2.49.0


