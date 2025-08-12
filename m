Return-Path: <linux-kselftest+bounces-38757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B2CB21CFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3875F683E2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC52E4243;
	Tue, 12 Aug 2025 05:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJqyebqm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SdZtvLcd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6C2D660E;
	Tue, 12 Aug 2025 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977161; cv=none; b=BpWJJC2asWxtoNEKiXmu6CKMZNkDFaXUBqBA5n1eLJOrdtVQnzaT+qmWK5rupxijD2kWQx7dk9ZQhlFQwzJbhasCPAsbb6XwvNXhw53vvvB3hRy4s9A8V0BCPyQRI11OMZYAN9YAMUzRHZPn7IR+woINjvdD+/dfSICwtaKMhGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977161; c=relaxed/simple;
	bh=zoESJI2UttEP3Pjk/yC1msAGnta0GQeqnqMfkXNXEnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLMxlStP4utc1X8iY89ZtA6ABpq/YuObBso16Ih/uyBvM9cK7XruO7FcKAKWssiTfTr9oy8mC4M4ogDDqT3W/o6Ep4RohLt8eh2TplTMUWg+teXi60C+Vep94WFecey8+zc4orbotcENq6JcTI8LYqpor2xVAfy7Ydjy/LCasEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJqyebqm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SdZtvLcd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NY5A9v6rK026eOqjEvmx1Em9+y80kflzRXRJav0ND5g=;
	b=rJqyebqmc9RyV7bjLidgXnCExpvAwy2tcnfSyZstwkxg5EcIMba9QQBwAoC/QSj3TNn2Sh
	ycU3XeIpWF/omCbxxPV7FsPfaEjb/pemUH4RgW5qEKInzgc/m955p4KiepkmIamO2ekTgc
	1wVy21x/9wzMvbu6RYXGLlr5yTIyGfArmvruvpcvuBUYCQRXNcGsclYCXtt02pOQK2NBoo
	EJArNmgCRLYNgw4Vpir1L6V6jjsnwXQMP+8QVm88ydpqkZFKNSm0gQEIpTgjL9784nsDR1
	/GZIRgawFXPkwFkuGX18kwY4a6sxQ9W0ImPyCdyExgFytfqy6EJWAg7Vur3jGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NY5A9v6rK026eOqjEvmx1Em9+y80kflzRXRJav0ND5g=;
	b=SdZtvLcdLnwhc/upJ6vhr+eJIa9IYQ+Gk+cGt5UEw5nrwXYqw0JUyZ4tb55LHW3DmI9o9R
	ffqEXjkMBOOUCVDQ==
Date: Tue, 12 Aug 2025 07:39:06 +0200
Subject: [PATCH v2 5/8] selftests: vDSO: vdso_test_abi: Use explicit
 indices for name array
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-tests-fixes-v2-5-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
In-Reply-To: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977153; l=2009;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=zoESJI2UttEP3Pjk/yC1msAGnta0GQeqnqMfkXNXEnw=;
 b=7NduNBC3L4bmAv9iUOvgwh4bjBGnEkDmbuhUA7z7Jf3jj+WvNN/hZ00Bc9odVHcZlvVObQvFO
 LhTsKd/ZVXyAWuT4jh9DR7XbSkaTUWcy5FTxCOQmPOSupc1dgwRSnwL
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The array relies on the numeric values of the clock IDs.
When reading the code it is not obvious that the order is correct.

Make the code easier to read by using explicit indices.

While at it make the array static.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index d236dd8305e1e3f41df07e0b7ffd5cfe8aebf826..a9a65f0deef3c32a96d7907620184ca541a3637d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -31,19 +31,19 @@ typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
 typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
 typedef time_t (*vdso_time_t)(time_t *t);
 
-const char *vdso_clock_name[12] = {
-	"CLOCK_REALTIME",
-	"CLOCK_MONOTONIC",
-	"CLOCK_PROCESS_CPUTIME_ID",
-	"CLOCK_THREAD_CPUTIME_ID",
-	"CLOCK_MONOTONIC_RAW",
-	"CLOCK_REALTIME_COARSE",
-	"CLOCK_MONOTONIC_COARSE",
-	"CLOCK_BOOTTIME",
-	"CLOCK_REALTIME_ALARM",
-	"CLOCK_BOOTTIME_ALARM",
-	"CLOCK_SGI_CYCLE",
-	"CLOCK_TAI",
+static const char * const vdso_clock_name[] = {
+	[CLOCK_REALTIME]		= "CLOCK_REALTIME",
+	[CLOCK_MONOTONIC]		= "CLOCK_MONOTONIC",
+	[CLOCK_PROCESS_CPUTIME_ID]	= "CLOCK_PROCESS_CPUTIME_ID",
+	[CLOCK_THREAD_CPUTIME_ID]	= "CLOCK_THREAD_CPUTIME_ID",
+	[CLOCK_MONOTONIC_RAW]		= "CLOCK_MONOTONIC_RAW",
+	[CLOCK_REALTIME_COARSE]		= "CLOCK_REALTIME_COARSE",
+	[CLOCK_MONOTONIC_COARSE]	= "CLOCK_MONOTONIC_COARSE",
+	[CLOCK_BOOTTIME]		= "CLOCK_BOOTTIME",
+	[CLOCK_REALTIME_ALARM]		= "CLOCK_REALTIME_ALARM",
+	[CLOCK_BOOTTIME_ALARM]		= "CLOCK_BOOTTIME_ALARM",
+	[10 /* CLOCK_SGI_CYCLE */]	= "CLOCK_SGI_CYCLE",
+	[CLOCK_TAI]			= "CLOCK_TAI",
 };
 
 static void vdso_test_gettimeofday(void)

-- 
2.50.1


