Return-Path: <linux-kselftest+bounces-43092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF54BD7AF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 754934F1FAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C10830F7ED;
	Tue, 14 Oct 2025 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rfMwjvHi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k8agpUdv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67930EF6F;
	Tue, 14 Oct 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424565; cv=none; b=pHYYOBZVDmtdkVyYEOJIyvMVRRjA+F/F88l5eKDEMLpt5UjKcCbBP48x76EjPr9hq6rOs3LRUmH1veOEc2k56HqDUUun8d17c6KOL1WzcpQpDT3J7vwjUVSnjRZ6T7Lwm2l6YXmzRDLxUXkqB3aCE4+JrSi7uQyOSH6XPHSKOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424565; c=relaxed/simple;
	bh=u5qksLE0CkeBqNMjOIpIJvowjU2FK+BsJIgAtLa3Fdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1Xy946RrJFDKh80ORWOpq7tbx217AtTxTmUqgHWtp7KZXcPw6pQXbokLBJlr+uiEEW6uziLIX8qarUPcTsEEaAHNYR1MYFD/q04Pm6EOfV/Kj8saYS8uht8zKw+9SLwd7DasnheNuk2tKFBksT5kN8m7FqRL3cc40mAVRXzOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rfMwjvHi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k8agpUdv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHcQizXKIlU8rlwocB6TkeD1z+OIKxCXmz4FFDxeMJA=;
	b=rfMwjvHiXLLKBfbd5Hi1KvgltEOk0S9hNfM4iMd3RUxcWrgyPEBPiTGP6aYMz5bQ6H8fuK
	Ep700u+el7YO35AyghPEF1+2CBzA4HhbqphquXPBVCNfoQDXRYsY9m/Nb1Y2V/RSAdjnGN
	26L3THpgI/5iVmlSE/KePSK3iF5EXBoioWpP9fVGbkeRXK3B4EvXFTEgzE62eCROB7S9Qd
	vDxi/YlyUzI8kdVkv8kn2BqnwfsIP2kPz4r3s6lP/60vafXp+vkqh14lR0F9wvKXh10jD8
	1CA/1Dy4Le8M6oOpPzka9Ekh3BspQ87Fknwt92ica0Uvn3gZlV2tUMtbhmDXsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHcQizXKIlU8rlwocB6TkeD1z+OIKxCXmz4FFDxeMJA=;
	b=k8agpUdvlNxyd9nfs+FaO1y9Tx+/TQhz9qLADDuqki0NfFcFoDtdUYoFQKeWQs/7yt3QIA
	dVe2AV5afWRwWtDg==
Date: Tue, 14 Oct 2025 08:49:01 +0200
Subject: [PATCH v4 15/35] vdso/datapage: Trim down unnecessary includes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-15-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=1543;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=u5qksLE0CkeBqNMjOIpIJvowjU2FK+BsJIgAtLa3Fdo=;
 b=z026hBZ2HtDLHuWaxMdbVFCLc/D3LUEMANbPZGuvoMuL+cNIQ5xvOrpQtaAMhaGw8wc/aIjlx
 6gc491Lpy/nC/qgGWdiKXaRmSOlYHkhypp0FdizYVOlfkJKWp2u9+GL
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vdso/datapage.h includes a lot of headers which are not strictly necessary.
Some of those headers include architecture-specific vDSO headers which
prevent the usage of vdso/datapage.h in kernel code on architectures
without an vDSO. This would be useful however to write generic code using
IS_ENABLED(), for example in drivers/char/random.c.

Remove the unnecessary includes.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 include/vdso/datapage.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 752856b36a3abf82b849451e5d5233b1067b86f2..9021b9580be229b2001dd17bfbdc236ebda1cee7 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -4,24 +4,16 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/compiler.h>
+#include <linux/types.h>
+
 #include <uapi/linux/bits.h>
 #include <uapi/linux/time.h>
-#include <uapi/linux/types.h>
-#include <uapi/asm-generic/errno-base.h>
 
 #include <vdso/align.h>
 #include <vdso/bits.h>
 #include <vdso/cache.h>
-#include <vdso/clocksource.h>
-#include <vdso/ktime.h>
-#include <vdso/limits.h>
-#include <vdso/math64.h>
 #include <vdso/page.h>
-#include <vdso/processor.h>
 #include <vdso/time.h>
-#include <vdso/time32.h>
-#include <vdso/time64.h>
 
 #ifdef CONFIG_ARCH_HAS_VDSO_TIME_DATA
 #include <asm/vdso/time_data.h>

-- 
2.51.0


