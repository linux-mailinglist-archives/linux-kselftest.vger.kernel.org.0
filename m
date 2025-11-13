Return-Path: <linux-kselftest+bounces-45558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF79C58946
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F11BA4FD33A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919E33570C5;
	Thu, 13 Nov 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dBYRxnC1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="75K4JQ27"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AF3563C1;
	Thu, 13 Nov 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047876; cv=none; b=UJB28vZ7pEt5n0wslka4UYCnKIo5nIBIYnXHMO1XKQc4L9Mtroak5LVGSRrtFiRwsDMe29+5heiQGKF7L7Lv+GFPQ8uH5N5i10mWxMF9CfFVK03WTcnDxKfh1qPBB+vkfYDR6om0mMQakR5B/F+cYP7rsLgZ/9gRmtGKITBLzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047876; c=relaxed/simple;
	bh=c3bcEv9BGvQQcgu0BIsu5QL478np+U0x8j+cvLcIwpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMu6ub4PFcbzAsVNpE+0Bj+cP3bjg/pwGSsgkw9tOScoGgZzxzPhQFbtJyT0C+mO1GupFg9iEDUadOYc0R6o6F98hmXkw92K0sL//oQdCCIx+xuF7XLcwuI+oaPwOFTjLYBswhlxDbPXp5LmFlJZ8FuFHDLKbblJ3idGOXeW1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dBYRxnC1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=75K4JQ27; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAHC9l+o6T0gxY6CoNDjUFoohSMI8Y+G6cyys+oqSBg=;
	b=dBYRxnC1SqDTHunxBpGJnGQQWtRcGIVQeqZ93j+6uB1RCL9I9dZ7eJoykpDcDs43MuEZUY
	7eKZxtq+FIXy3rcTtBo8nnggcpnduHA6AnqoL98j8KwDW8Xv7XGyArV7jk7fsDOeWAUEWr
	aemupMAtDHfUJprQczkPtZnaWHZ53187E1jL4Gs7tg+6VfxLM2iYxJNB14/JMHmvDOnQFB
	ir/eybiRkCT1MI/dtgkhzkc7HFgaU9GLdbKP/Ay14GKcFrFPwK5FbGT7J5tIDdRC/HY8Mi
	tF9o/pq1fwGvFVnxJf9ciLp8SYmZn8ldK8JY069082pf1KBji3A/9c205c+0kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAHC9l+o6T0gxY6CoNDjUFoohSMI8Y+G6cyys+oqSBg=;
	b=75K4JQ27L/aNYUD0TTf2Jf9/p7gKRqlM4K/0NyIxo/yRCBGLagXz6F+0AtOaR7oWxG87cl
	C21uZMf0i9XCggCA==
Date: Thu, 13 Nov 2025 16:30:22 +0100
Subject: [PATCH v2 06/14] selftests: vDSO: vdso_test_abi: Use types from
 vdso_types.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-6-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=3866;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=c3bcEv9BGvQQcgu0BIsu5QL478np+U0x8j+cvLcIwpM=;
 b=Y1IAzIaHM0kehHikC703SGQOWzfjBr/Pids/gLeT+AWMexkB96jRzSmiwS4jVPwFV9t3mqGAt
 1RRLs6PN5kEBV0ZICw9PX0fqAOfAVKc5jYZ58eYJqomF7FITXLBKZ6a
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The libc types are not necessarily compatible with the vDSO functions.

Use the dedicated types from vdso_types.h instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 32 +++++++++-------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 238d609a457a281d802734b40d6a2c35ba7f6d72..7826d9c10ccaf313dc003e8959d9eb84b2cda874 100644
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
 
@@ -169,7 +156,8 @@ static void vdso_test_clock_getres(clockid_t clk_id)
 		return;
 	}
 
-	struct timespec ts, sys_ts;
+	struct __kernel_old_timespec ts;
+	struct timespec sys_ts;
 	long ret = VDSO_CALL(vdso_clock_getres, 2, clk_id, &ts);
 
 	if (ret == 0) {
@@ -200,7 +188,7 @@ static void vdso_test_clock_getres(clockid_t clk_id)
  * This function calls vdso_test_clock_gettime and vdso_test_clock_getres
  * with different values for clock_id.
  */
-static inline void vdso_test_clock(clockid_t clock_id)
+static inline void vdso_test_clock(__kernel_clockid_t clock_id)
 {
 	ksft_print_msg("clock_id: %s\n", vdso_clock_name[clock_id]);
 

-- 
2.51.0


