Return-Path: <linux-kselftest+bounces-32319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F2AA8F42
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184EC16D5C0
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CF91F873B;
	Mon,  5 May 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P9XeLr8g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wpxsbT6A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794911F5849;
	Mon,  5 May 2025 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436793; cv=none; b=bwvPku+gw51UE83QHUB/d362RIu2/6FIOvm1Lc3ywTOXJs7Q31shqYt+sWU9RVTNhOE8oqzj6cmbghjQntlose373iTvRrtmN1eiPCxMLUNSs8dGz0zfkKWVlZ6q2dm/HXCejpZxA3tMyEuqK+0Vyq7zQ0CRyA9ZtM4o5lVf2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436793; c=relaxed/simple;
	bh=J9hKPnnc2A0cweqLzbgQ20+H2ZBdLzJrRKeSWwaEXh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McI/eGdRdK4uJWxRpuh0HuGaCVAo35M1oWYNvYbUQk518gAGyFm2CezMEco9WKQPO1t2irTcXLnTfX6ltENImCkZ1cRqUYx7gUYEUIhBzjMRFvBwCGcmS00XH5R0Sfb/c2vglRqf0vf7euPgL6ibLWRafEvMwe0Jn8EC+tKWX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P9XeLr8g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wpxsbT6A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746436790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z70zMxE+h3XzbWkN3rpdJuxDTk7yXimHYHKQ9cAetLs=;
	b=P9XeLr8gVGDGxkzlOCm2R7utGhoHE68eF9WmTpD7UfFiBq3WwhuKxC5utB1JkpBAf0ikwp
	ETkWD0QdicZexAgjIglP7cQMcc77m411+4Fpc2rDbLoSj66JdB3Tq4OsxIjpdBmLCvfYTd
	OV1G3o2veuJ0Og3KryT6W/hyndhD5cCDKYLgQKtfJsEmvzbFmik9kbg0C43UnQ2okuUCIu
	qIOiI945w0XsoaWF5bd3lPypPwof7aP2cK4/5yHz2tpq20IGNvuEHqhZiypLtT7zCJtUdH
	8tyQLLSPJS5ymhBaIIoO3zWIOfh3IiQZVEkOoHWz+Vry/YL/ofIO+1aAMJQVLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746436790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z70zMxE+h3XzbWkN3rpdJuxDTk7yXimHYHKQ9cAetLs=;
	b=wpxsbT6AqMsIuSckCafDfsI4oW14R7JwykteIvnuvogcnQC9iJbI+8QIK6DRa+UjBD+1Gm
	80x296ecD3d6x5AQ==
Date: Mon, 05 May 2025 11:19:36 +0200
Subject: [PATCH v2 2/8] selftests: vDSO: clock_getres: Drop unused include
 of err.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-selftests-vdso-fixes-v2-2-3bc86e42f242@linutronix.de>
References: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
In-Reply-To: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436782; l=788;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=J9hKPnnc2A0cweqLzbgQ20+H2ZBdLzJrRKeSWwaEXh8=;
 b=lMdwDzQC4zbF2jZyog/m9ojphWYBpipNryaQDBfFSqfhbJdx7Q2ehlxsX5fIL5U5ZL5mkRX1e
 y3gSGl55j+yAIObWSLoVMLyvwkwydlw6/elbSu38Mt37l1SwKVtkrAr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nothing from err.h is used.

Drop the include.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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


