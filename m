Return-Path: <linux-kselftest+bounces-36693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4723DAFB600
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60CD4A7E29
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0365B2D97AC;
	Mon,  7 Jul 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LUYFMkNm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rzIMMVmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558B42D94B8;
	Mon,  7 Jul 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898228; cv=none; b=Jy4mbGlM5ZM2QRHrUeff5YZrTjV4Bz88Wn0OAc2gk83e4jIL55d6jSVRMO0YzxvFMzUX/pivym+vnugZt+F+fxPxCAeKj0J/6nk6xQ17Sd5dYQJFbjuA334z2g9LLQ/30xZlv+0aeZ6Mj37Mvu+WWoMeKU0LfAms/VQTxsWUcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898228; c=relaxed/simple;
	bh=Q/F9vDKfu7XaTh9AflpJQNkYDtIxfJAukiznBldYvG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0o9qLrQVqWePGyXlYRV3bUbWx30fLD6xXm5s8IrjBHCCT0/jvm4vSRA8nPJvrTGOCpPUDMupvhsE9rGU7U8m/3XUffYOaHH77tdoVvM/D799L1G7/ehsCF9zlT6tjqEQpBu0DMiunI4PXrOaJlGwalJAJfs57Bih93iXnCDyP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LUYFMkNm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rzIMMVmd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751898225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBqbw4PdzPyuPrlKENbYISEQyRJfwMczckSvk7p27gQ=;
	b=LUYFMkNmXmW3U3cAaVQgV+PDog/MWpXTZ4sYpfiSQ5GGO5sxXQPVtryHmmOv3/ZUDka6d/
	h3T7h1qw0uw1KqPHx+o9nZLubYjhdSfuXRN30Om0h0/onXqX4q4CpJwpKAAdL0CoplRTZl
	vjTzZDtMEatZLFkCaPgif8wrGOhzr/T+4HsUCuT3TE4HiHOZ6P/sHLUcBENUwacOA6y7rG
	ihoXUjib8FBxRux5Nwz+MNNeqLicLn1FtNukJ9HyeKekzCL4gh4qlM3WNj8K8CHH1u+7WS
	T1a+jN5Wmr9HVAgKXY+hKRLvEy0TG2JfQC7RmVY0ns9fJNQRlCTIfHN4IuBFkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751898225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBqbw4PdzPyuPrlKENbYISEQyRJfwMczckSvk7p27gQ=;
	b=rzIMMVmdpHRaCpBXp/yd4hUcGqNGHD35D89zrqJqbs1O0rg5JyqRH88mBG0NDzYY2mRjJS
	VexDff3jNemMPCBA==
Date: Mon, 07 Jul 2025 16:23:41 +0200
Subject: [PATCH 3/5] selftests: vDSO: vdso_test_abi: Use explicit indices
 for name array
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-vdso-tests-fixes-v1-3-545be9781b0c@linutronix.de>
References: <20250707-vdso-tests-fixes-v1-0-545be9781b0c@linutronix.de>
In-Reply-To: <20250707-vdso-tests-fixes-v1-0-545be9781b0c@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751898221; l=2009;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Q/F9vDKfu7XaTh9AflpJQNkYDtIxfJAukiznBldYvG8=;
 b=Hfyp7uArTsKNdw/eAkznj4+Nbrpg6i3gVqiH0gxgaznGYdjJYnEap6NVjBcZMv70pCCshFTJw
 XIoV1qq/AskBPCejOiY2VbUV2FKAgKGOCTLNLSR+KourOx1IR6Hy2qH
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
index 407817e929d89ee434191e336da0e6f18b989a71..96d0dd3677b357876e92f6d2d962d43d642e9bee 100644
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
+	[/* CLOCK_SGI_CYCLE */ 10]	= "CLOCK_SGI_CYCLE",
+	[CLOCK_TAI]			= "CLOCK_TAI",
 };
 
 static void vdso_test_gettimeofday(void)

-- 
2.50.0


