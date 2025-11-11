Return-Path: <linux-kselftest+bounces-45298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE8C4D320
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014851890A27
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4F7354ACE;
	Tue, 11 Nov 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pDbXbcOO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NPEeB1Mn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EC3546F9;
	Tue, 11 Nov 2025 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858204; cv=none; b=biqC7xhwAmRqYmFM5zMyqJ2i2dy51nodH/3L6VXzSCx6U8ECKpVkV6VGE9IUDdNpxtSsSYRIJodrF+RFDcgYkiXPEjwcP4irBhp25ur6yhwtpJikRHABuvJw61DCKCkoGLVMJSUVooLR7KtCzBuf7prOyLPapuvTTpiWOFFFnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858204; c=relaxed/simple;
	bh=5Hn+l/oBMVRfdyJe6BkNTEVt5vhJRrf/zIY7pQXzK90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOkMoGSRgte/RtDEdXBx3cI7V+7iYg9CQvOZkotbnvmZeuk/XCqRIe/w4FUCMlGkmaxCw80/OHAUR27apDI7bNAZAYgKwkC16ofpjGYN0CvNWHF0mTLjNjm1zKnrijZZit0Kl9XS+kEW/YQDK0jVrsN5dyTZE45YwiaWX1AP6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pDbXbcOO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NPEeB1Mn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/vqzdI5QT7M45iFthhBxx7Jy0esRcYVB8/VtVM6c2g=;
	b=pDbXbcOO87U8I4+64jjIX8+6wYSCh196Wkc+kjunLlwbR+Ct4TMJOfv2/+IF3kh3b4BoMN
	yhoHPng6wfiU5NHPO6FGdIZ7Jg/4nEmNnp6ZJXA3rrEhs0MVuOJwUD2ZuxBMGWLkBSa/Ys
	i8mlKev4VvP9GRV1dly7G7krjEqDNVEOpympd/x/s7sGv3xQbLszW4qjq8wkQuchmJtpTK
	NmtTbwCQXA2TR6oAoM5CG0N84TqrwWyC22nTKzeGIo5KgZSxLSghzuhmhXGRSNqjmlY/Hh
	FW1VJC03gqrgj/DSv8CyBLhBLDeOhikxoCmzozVdYrvWaSyUHuoGHQ5aidwtZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/vqzdI5QT7M45iFthhBxx7Jy0esRcYVB8/VtVM6c2g=;
	b=NPEeB1Mn7uYlkqPrCET8xCKB+9U0s8X854nxZWesU461x4ULkCNZQuIBXa7sqqdtEsadjc
	5anfP7/Ltq7wGqAQ==
Date: Tue, 11 Nov 2025 11:49:49 +0100
Subject: [PATCH 03/10] selftests: vDSO: vdso_test_abi: Use types from
 vdso_types.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251111-vdso-test-types-v1-3-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
In-Reply-To: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=3846;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5Hn+l/oBMVRfdyJe6BkNTEVt5vhJRrf/zIY7pQXzK90=;
 b=cdYgdYHgXwWfYyhKQvFSC72qvkltTbhFOFvdBOZbbWNJQ5N2f+H6XR9rHTHzL1VCwfamIZIO2
 YdZd2dEf6sPAPKiNX5AahxKoWneupJREznmg4iwvK1QXKBuw3KwpPQR
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The libc types are not necessarily compatible with the vDSO functions.

Use the dedicated types from vdso_types.h instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 31 ++++++++--------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 238d609a457a281d802734b40d6a2c35ba7f6d72..bb5a5534ae7e8a46d7e68a561684c29a752b866d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -11,9 +11,7 @@
 #include <stdint.h>
 #include <elf.h>
 #include <stdio.h>
-#include <time.h>
 #include <sys/auxv.h>
-#include <sys/time.h>
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -21,23 +19,12 @@
 #include "../kselftest.h"
 #include "vdso_config.h"
 #include "vdso_call.h"
+#include "vdso_types.h"
 #include "parse_vdso.h"
 
 static const char *version;
 static const char **name;
 
-/* The same as struct __kernel_timespec */
-struct vdso_timespec64 {
-	uint64_t tv_sec;
-	uint64_t tv_nsec;
-};
-
-typedef long (*vdso_gettimeofday_t)(struct timeval *tv, struct timezone *tz);
-typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
-typedef long (*vdso_clock_gettime64_t)(clockid_t clk_id, struct vdso_timespec64 *ts);
-typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
-typedef time_t (*vdso_time_t)(time_t *t);
-
 static const char * const vdso_clock_name[] = {
 	[CLOCK_REALTIME]		= "CLOCK_REALTIME",
 	[CLOCK_MONOTONIC]		= "CLOCK_MONOTONIC",
@@ -65,7 +52,7 @@ static void vdso_test_gettimeofday(void)
 		return;
 	}
 
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	long ret = VDSO_CALL(vdso_gettimeofday, 2, &tv, 0);
 
 	if (ret == 0) {
@@ -77,7 +64,7 @@ static void vdso_test_gettimeofday(void)
 	}
 }
 
-static void vdso_test_clock_gettime64(clockid_t clk_id)
+static void vdso_test_clock_gettime64(__kernel_clockid_t clk_id)
 {
 	/* Find clock_gettime64. */
 	vdso_clock_gettime64_t vdso_clock_gettime64 =
@@ -90,7 +77,7 @@ static void vdso_test_clock_gettime64(clockid_t clk_id)
 		return;
 	}
 
-	struct vdso_timespec64 ts;
+	struct __kernel_timespec ts;
 	long ret = VDSO_CALL(vdso_clock_gettime64, 2, clk_id, &ts);
 
 	if (ret == 0) {
@@ -104,7 +91,7 @@ static void vdso_test_clock_gettime64(clockid_t clk_id)
 	}
 }
 
-static void vdso_test_clock_gettime(clockid_t clk_id)
+static void vdso_test_clock_gettime(__kernel_clockid_t clk_id)
 {
 	/* Find clock_gettime. */
 	vdso_clock_gettime_t vdso_clock_gettime =
@@ -117,7 +104,7 @@ static void vdso_test_clock_gettime(clockid_t clk_id)
 		return;
 	}
 
-	struct timespec ts;
+	struct __kernel_old_timespec ts;
 	long ret = VDSO_CALL(vdso_clock_gettime, 2, clk_id, &ts);
 
 	if (ret == 0) {
@@ -154,7 +141,7 @@ static void vdso_test_time(void)
 	}
 }
 
-static void vdso_test_clock_getres(clockid_t clk_id)
+static void vdso_test_clock_getres(__kernel_clockid_t clk_id)
 {
 	int clock_getres_fail = 0;
 
@@ -169,7 +156,7 @@ static void vdso_test_clock_getres(clockid_t clk_id)
 		return;
 	}
 
-	struct timespec ts, sys_ts;
+	struct __kernel_old_timespec ts, sys_ts;
 	long ret = VDSO_CALL(vdso_clock_getres, 2, clk_id, &ts);
 
 	if (ret == 0) {
@@ -200,7 +187,7 @@ static void vdso_test_clock_getres(clockid_t clk_id)
  * This function calls vdso_test_clock_gettime and vdso_test_clock_getres
  * with different values for clock_id.
  */
-static inline void vdso_test_clock(clockid_t clock_id)
+static inline void vdso_test_clock(__kernel_clockid_t clock_id)
 {
 	ksft_print_msg("clock_id: %s\n", vdso_clock_name[clock_id]);
 

-- 
2.51.0


