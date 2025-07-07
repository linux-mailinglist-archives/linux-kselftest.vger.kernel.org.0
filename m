Return-Path: <linux-kselftest+bounces-36691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E649AFB5F6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B921AA700D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B7D2D97A0;
	Mon,  7 Jul 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TjQBPj3C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yn0CjopP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1E42D8DBC;
	Mon,  7 Jul 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898228; cv=none; b=kamJ9vVkIwXpJyDoQY726r3GSkatYKX/ynXjgb5CtEBmuFE+zNlO2ag9gfQ6YIl3nvBCO7cz3GVwBXJH4hi00ici3Xt+Lo0mmAqZTkM2lbY9z20G0JdsoGbsO2NV7BwARC3CdKB0eMV7jSoOW9d/QBdiY9957qSubY+s7JEqU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898228; c=relaxed/simple;
	bh=wrsMm7nGfxkYJnYNEIzYKNcVhA3Pl9itptSW6wHUQ0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNXHPR4APa+1P94760OMERjp/bzQBoOEGeMGWJWYb/P+xXBRXUI+LgN2nF60Icib1mxarwaHha4OCNwS5xU6X9+UEt/OHKra+iF2DluJ212wA8JaD/4dSqp+zx/tec5ThxrKQC9GHC5mDh9Nc1k5XarlQ4JmApvB1f7sdD74J74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TjQBPj3C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yn0CjopP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751898225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwKUprsP1ZjCWus8bQrJ7pofqpc1CikeaR7ZCtEeAIk=;
	b=TjQBPj3CSuR2cpxVZFhlPHV/yo6DyPTax8jUyIQBaso0sWH1Tqd4E+mw7JRn/3K2O5V9aJ
	2b5y5oF8A3jrY12rVEMeKFYw1O9jpl14vPJ+qxkR7XRAxX4qnWfQCmpOptyuIB+F6C6ThP
	KfLDoPf2SrsX2SksVB7lU9C13dauBjLaNPKZojEVycLKwcfriWFkdmiKl5AiDvRLGcaZX2
	nI6xGf5iE7GuuDXdMm/TuRaTEBQhGkVS4xPdXehoPAN6oz9oI4u1rQ6cftBP3w2yoycLcl
	X7YXOYl2D0OA09MweHxmFuSjucLz+vtLEXJxCgfKg4s0jHDr4K6ErLeqsRpSrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751898225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwKUprsP1ZjCWus8bQrJ7pofqpc1CikeaR7ZCtEeAIk=;
	b=yn0CjopPDxq1WuwlNHCQi9SkayUg0GS3PXN+6aP6t0yScpIF6H94Ydaq3d4I5l8M+G++Oy
	aEPRTRbaqUmTHJBw==
Date: Mon, 07 Jul 2025 16:23:40 +0200
Subject: [PATCH 2/5] selftests: vDSO: vdso_test_abi: Drop clock
 availability tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-vdso-tests-fixes-v1-2-545be9781b0c@linutronix.de>
References: <20250707-vdso-tests-fixes-v1-0-545be9781b0c@linutronix.de>
In-Reply-To: <20250707-vdso-tests-fixes-v1-0-545be9781b0c@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751898221; l=1517;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wrsMm7nGfxkYJnYNEIzYKNcVhA3Pl9itptSW6wHUQ0Y=;
 b=xpiZWTEmLZvey5rKjg+IaauuVib/yYEkRZt42u6WEuOfS9Cwt+KMOkZOEs/w/wpFVBa8QAK5u
 UnQOw45s+u8CaA+RHzUf3qxPS0oKK1fsNM3NG+dF0u5ofw4MdSLBxhL
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The test uses the kselftest.h framework and declares in its testplan to
always execute 16 testcases. If any of the clockids were not available
the testplan would not be satisfied anymore and the test would fail.
Apparently that never happened, so the clockids are always available.

Remove the pointless checks.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 63eafb5ac0bfa407a527343f4d587e5098454f1f..407817e929d89ee434191e336da0e6f18b989a71 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -198,37 +198,13 @@ int main(int argc, char **argv)
 
 	vdso_test_gettimeofday();
 
-#if _POSIX_TIMERS > 0
-
-#ifdef CLOCK_REALTIME
 	vdso_test_clock(CLOCK_REALTIME);
-#endif
-
-#ifdef CLOCK_BOOTTIME
 	vdso_test_clock(CLOCK_BOOTTIME);
-#endif
-
-#ifdef CLOCK_TAI
 	vdso_test_clock(CLOCK_TAI);
-#endif
-
-#ifdef CLOCK_REALTIME_COARSE
 	vdso_test_clock(CLOCK_REALTIME_COARSE);
-#endif
-
-#ifdef CLOCK_MONOTONIC
 	vdso_test_clock(CLOCK_MONOTONIC);
-#endif
-
-#ifdef CLOCK_MONOTONIC_RAW
 	vdso_test_clock(CLOCK_MONOTONIC_RAW);
-#endif
-
-#ifdef CLOCK_MONOTONIC_COARSE
 	vdso_test_clock(CLOCK_MONOTONIC_COARSE);
-#endif
-
-#endif
 
 	vdso_test_time();
 

-- 
2.50.0


