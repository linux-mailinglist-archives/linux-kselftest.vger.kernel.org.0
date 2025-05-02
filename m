Return-Path: <linux-kselftest+bounces-32186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BE6AA7249
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68BB4C3890
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706012550AA;
	Fri,  2 May 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvQMwo4/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rc4wcqgI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C4252914;
	Fri,  2 May 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189626; cv=none; b=dFwbhCmvb69beMW0N2L4fV22Sa0BEkLtZWvrqEf0FhdCCG11Z8ic82AF6PaXv55S/jNTCLZfnuLS4K/+Wj65Cp/W774RDeJJt4czvt6G6ZeZ5UalnlbWb5/tIu2n+Ruw9RWpGO0uSJY2qfcACE1suRqBSBBs03qp/TJtNKTulU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189626; c=relaxed/simple;
	bh=RzpzpcH8lMGoa8l/hmWhs/3Tg1kxHgkzpUmRXeGCMGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr10X4XzZrYfskvjHT2Ca4N29uaBr31K/hj6BsABdLNowzVspr1k8bRbqfHvXjBKZcRom9NFJVF7ivm2FYTfcJ0vjC3TO4d0dlR7XBfxlN/GhOxRkPTIKzh6iY2Xaq+ug9ypIXjrP5mE9l4DEOTw2/3782gy4oPB2PbFW6mEB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvQMwo4/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rc4wcqgI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746189623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFnVoUa9JUVJmX/esXUe9lcBfyp+FOEohB9uLRfqc5U=;
	b=vvQMwo4/Zpl0BJQDRDYHhTz4ESh34P+iRl7iYU8mwX/uxrvPPeJJFHa/cWfULXgs4Pb3xR
	RE6J1e2i1D9hAeNHoyQgLkygZ6UAtKJRQLsLf8agLwBNA7alr/BBc1hDIedx1FBeRGfwsQ
	ljm7H/8eSl8BlyPhgzFA95n6ldW0FGbSkEAS8x+C88SpqkGnrQxgzam87WaTRo/C4TmkuS
	hcdlewkTH63iCjJ5e0EQuKEc8R+7oxlE9WuvQEPT7ZRlZMhzk3a67y137CvkvzpFHdKoQd
	A+6SO/yHOqAON9IsvSz4/EzlBR88onorIf73lnweJ19jCwadRBavU1rQ1vbepA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746189623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFnVoUa9JUVJmX/esXUe9lcBfyp+FOEohB9uLRfqc5U=;
	b=rc4wcqgITaxWavhjmgf0CkC7sCOGuHbzLyw7fKxofGlAELQ2dV5NASXVRRSC0PLSZn/Kyw
	nzqMBVonXwxihyAg==
Date: Fri, 02 May 2025 14:40:14 +0200
Subject: [PATCH 2/7] selftests: vDSO: clock_getres: Drop unused include of
 err.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-selftests-vdso-fixes-v1-2-fb5d640a4f78@linutronix.de>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746189620; l=725;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=RzpzpcH8lMGoa8l/hmWhs/3Tg1kxHgkzpUmRXeGCMGM=;
 b=HpnSm9hCXbUPbzxahKsAjnU3XSF+nXighm7KZoQA4vPi8lp/na+NIWSxrrEN6HVOxF5x223kP
 LXR8KmdKlvBBQ19rc+cjya1uknOo73z3ADDwDy5m1KG3a78/7fgRSEi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nothing from err.h is used.

Drop the include.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
index 38d46a8bf7cba7a9b4a9b13b5eb17aa207972bd0..b5d5f59f725a703c357dfca91bfe170aaaeb42fa 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -13,7 +13,6 @@
 
 #define _GNU_SOURCE
 #include <elf.h>
-#include <err.h>
 #include <fcntl.h>
 #include <stdint.h>
 #include <stdio.h>

-- 
2.49.0


