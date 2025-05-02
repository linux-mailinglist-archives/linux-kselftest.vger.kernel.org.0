Return-Path: <linux-kselftest+bounces-32184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EDCAA7246
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE614C3840
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97C253949;
	Fri,  2 May 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGktqbLi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SO3Ht/BQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7419251782;
	Fri,  2 May 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189625; cv=none; b=cKI0vWWyEwqP2vxHxHOgdQeWsXxyEjJNiziRR8hI7xoWnzVt73CnY/5lHI1EA2zEumPYR74zEQPOgWj7OtutfitHMZwEgLzVOGC8YSCbLQFfO0FOkMQPrUygm0Jv8k7jXw29gnuNSXBXPr+//3D9xQ2KPLKD7a7sPOmuoSXVgJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189625; c=relaxed/simple;
	bh=f6HuqdSvAKGVPOqVzQm172RnAOk9GhXCrG/e/TsGahU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qwN4LCuilK7KLrbwlGORujENYmEzF/y/pDs5gCYxdjBZtcVmMY/7Jm+kMv2oT6usImNEcxl/OfJJf2Ka4mZGiNbW25NoPFZjeXb9GCcjc3hfWmCGg2AyLwBGAfI7xQ1vXOj1qaxA09AW2k+Lp+qM+qCYJBqKWi5262Srro02Ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGktqbLi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SO3Ht/BQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746189622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pDznLHNB3dpQYFIiF9hhdtTNUe2lHroDW4Mp9Gw5PGg=;
	b=QGktqbLiim9nJtm35O64haJj4hUt7LU59uJKsgN+3hQUfEQR9LHICrXRGPgmSwBDwSxsbe
	O6ra1TXa3h8UaUsK2g0lmJEnSJFwfQF05NQRZLZpfwmIaJ9RsQdo8n05tFNr0rxPb+uZ2f
	1lxBMcxmbyLUsRqsfzEiZ0PvWJHK3fBxB9gUZFZVpxOwguxX8xp3T8VfLNviLUkD11PjRU
	uCBIfD9YsTQLVIjqqtjmFEIJSzwY7diONhElU42yeVpXeHaPbirZdv0ntuuHBgrHOh8Yfc
	Q8TkiR5PNGVzMmYmVYDxuyLQNeffHIGb4saUv0iRuib9Y5zhV4JSXlCoeE0Sog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746189622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pDznLHNB3dpQYFIiF9hhdtTNUe2lHroDW4Mp9Gw5PGg=;
	b=SO3Ht/BQxTTSEyYfehtEwnuO6YMFzOEO2Ts7H2kwKgsk9I2W2ZQtzJFIs/5m+ShAz+FtKb
	4vB2GHjuUj1MKyBA==
Subject: [PATCH 0/7] selftests: vDSO: Some cleanups and fixes
Date: Fri, 02 May 2025 14:40:12 +0200
Message-Id: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACy9FGgC/x3L0QpAQBBG4VfRXJti2cSryIXsv0wJ7UhK3t3k8
 vR1HlIkgVKXPZRwicq+WZR5RtMybjNYgjW5wvmidhUr1nhCT+Ur6M5RbigHN6GpS3Pfkq1Hwg9
 29sP7fkGwvLtmAAAA
X-Change-ID: 20250423-selftests-vdso-fixes-d2ce74142359
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746189620; l=1230;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=f6HuqdSvAKGVPOqVzQm172RnAOk9GhXCrG/e/TsGahU=;
 b=eqBpzSpZychCvlL1jyLuS1MmVqY+r/HQcSFY8U/3khmGZ+yulcZJieXAvrUmlt+IFLiGwamzT
 EVdag3GP4FiB/gxKQhgRMkoR6/QBfszj81+bM7ORs+Mw9eO40rTNcSk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Fixes and cleanups for various issues in the vDSO selftests.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (7):
      selftests: vDSO: chacha: Correctly skip test if necessary
      selftests: vDSO: clock_getres: Drop unused include of err.h
      selftests: vDSO: vdso_test_correctness: Fix -Wold-style-definitions
      selftests: vDSO: vdso_test_getrandom: Drop unused include of linux/compiler.h
      selftests: vDSO: vdso_test_getrandom: Drop some dead code
      selftests: vDSO: vdso_test_getrandom: Always print TAP header
      selftests: vDSO: vdso_config: Avoid -Wunused-variables

 tools/testing/selftests/vDSO/vdso_config.h            |  2 ++
 tools/testing/selftests/vDSO/vdso_test_chacha.c       |  3 ++-
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c |  1 -
 tools/testing/selftests/vDSO/vdso_test_correctness.c  |  2 +-
 tools/testing/selftests/vDSO/vdso_test_getrandom.c    | 18 +++++-------------
 5 files changed, 10 insertions(+), 16 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250423-selftests-vdso-fixes-d2ce74142359

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


