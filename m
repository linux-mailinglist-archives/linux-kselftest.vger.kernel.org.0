Return-Path: <linux-kselftest+bounces-27602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686B7A45D88
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF62E1736A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67E221545;
	Wed, 26 Feb 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cz89Id9c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J3vBFrZE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9DA21C18D;
	Wed, 26 Feb 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570321; cv=none; b=JjsQQVga16kb95RMAVClgBZ+PyUfH3U8MVeC8Jl+u76OA0gVg1KT8LYyzM+VLDeP3vWgDtGv7MYchNBxLU5jMeg31IaJd+MrFL0/5vnx7iu8K8m439Yx8d+DZsxtJ3FegK6YUORdRdM7MTGmKOIZjyYalrcSoK/PBHmLzj8Ucug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570321; c=relaxed/simple;
	bh=WWyAjd0lBF4CXtwQtc/ysMPL9nKJJ2TfKtJWs4lpBX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VABNOFry8B+1879UlQRKhyzZ0PtGxYDeMHeKbeYiPgARru5nHdU2zlybEfgulUNKmLxnq861DPDY9obuZEP8CdiijvSzciQFS53aR4Ugki5bsx/NlFHTBHPuczR5nwpx43CGwpzloe+1XuLaMGhTsAZV/o30NZVNW+849jEo29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cz89Id9c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J3vBFrZE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmfOckZ/ezvQbsI8oO+Ny3Ym1fUd+U8v8PjgJTjlhxI=;
	b=Cz89Id9c4ksgUOgosrPPNmwyzc5OKRgE9qa1PugTJjc1cFpW9PuK8csLf7OB3IAY/+atTy
	hI/yr4MQ+kKIXKXRiQ9AXIENDMON68EnXvSPnTwm5lA67ZNS4fuGaWhEHisG4puxEmWpw6
	LYUJzBPLthSFjGItdaAbEG+l8Q1kVSLGzofdX0MT9B7MLBVKiFFNZrCLmMWN+vyZwGJuOe
	1MjWYMlTR6L67MoeHJySswLdQGCnAix3nrNitijKTktwZ0TXNUmrd9tYwvM7FqUdYEET62
	4dJp098YriaYtQbVR5ZexqGvMNUXybnnuHIOZeqMhJXt442czFbaSrEJEX+3/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmfOckZ/ezvQbsI8oO+Ny3Ym1fUd+U8v8PjgJTjlhxI=;
	b=J3vBFrZE7Gqbw7nLy2FHLopfTbyhb8kHRu8GOflxPHt+K1mwDynfrmzJHe3nRahi4IoVcJ
	KzHPP2kN6U0BEbAQ==
Date: Wed, 26 Feb 2025 12:44:53 +0100
Subject: [PATCH v2 14/16] selftests: vDSO: vdso_test_gettimeofday: Clean up
 includes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-14-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=803;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WWyAjd0lBF4CXtwQtc/ysMPL9nKJJ2TfKtJWs4lpBX4=;
 b=+fuDixwMNSldXS0xZq4UG3e35Jkdqz3L8iCNemrw4+F22qokhU7Kj+KsVf+lfrLCvsyk+iW2X
 qeJLhMVLb+GDidiqgXjdZQ56hlRiXdMtCfRrci9t2Lx+m5fYoikviHj
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some unnecessary headers are included, remove them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index e31b18ffae338c1576449b54ca7f84d9816d2ecb..636a56ccf8e4e7943ca446fe3fad6897598ca77f 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -10,8 +10,6 @@
  * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, too.
  */
 
-#include <stdint.h>
-#include <elf.h>
 #include <stdio.h>
 #include <sys/auxv.h>
 #include <sys/time.h>

-- 
2.48.1


