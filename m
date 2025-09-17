Return-Path: <linux-kselftest+bounces-41722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215BAB7FDEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C8B540A49
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14712F068C;
	Wed, 17 Sep 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WyIEv5kN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Ov3WBkd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3142F6166;
	Wed, 17 Sep 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117746; cv=none; b=egr/h6HdGQbbSZdvBzJVmrdcUnVjlcRgvfozJKu+NHoHCJ4O1wMM/Bd6Kw1X2y7AZjLvgjJ/ZhQf0odt6Uh5NVqvphYD7muWuniFdK+HmTp4AmV6x2SP+baMM1Qz7dhcgdXGqhOXlMpMEAp/5rut32Mcw5d7E82g5ihc8Jk5PBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117746; c=relaxed/simple;
	bh=z6rw8gc2i+vXaJlg660yiQKhkDkj7a8Qr+J2EFiBq9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tADFljqh7Qcf17mptWbebcx+XHuHdv0/5uyMIiEEpXqVIUTh6y0xe+bf7DaYlsN4JNbB7wKL5ZuqPs4rLV8dcvVH5IzmEQQ+jpPv+Oc0uVAOX5N6tA9eobxzM5EUrEBFsbG7ZpMOFzvGAU6JK6Zo1k/mVAc7jZmxKcsy2TsD1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WyIEv5kN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Ov3WBkd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXWzH3AvD69Q8lI5Y0llzQzfFSEhsuV9TmtXsx0N6Y8=;
	b=WyIEv5kNEj9kmZtWOWeZFCCCY1bKbOwpQLdESGYzHr8aG+JimbdpiPhO+pYGXJ5hXnUmOC
	nkDWFRp/Km9ncq1IUzarC6zSat13sCZFinKSZ6TJ4igvoAyZwcGPLFjc/X4xEPTO3btvvw
	ndMOpmuthbyZu7XIQM7yN5qCw+OiSniKzriW2W3IWdIhqreAChd7jTIp3RkgAMQEdnfo13
	Usp5z0uaapjAvRcSpMy6GjR0JEgkmOnr1+EedQA31VYdmhXb4xyImRuvHYPXAnOTtmZv3/
	OfordU9WHIWzFvZehPLEXkZGw/8cjzTTQnZtmNk7vyesWkqywAm3i6Q42mHY5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXWzH3AvD69Q8lI5Y0llzQzfFSEhsuV9TmtXsx0N6Y8=;
	b=1Ov3WBkd4ndEaUkbAYesP5lZZeKZBCW6v/dv4t+5HpDa4vpaLTKURbGvN8xeVceJNb0Lkn
	HSsYPzwckq71LeCA==
Date: Wed, 17 Sep 2025 16:00:38 +0200
Subject: [PATCH v3 36/36] clocksource: drop include of asm/clocksource.h
 from linux/clocksource.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-36-3679b1bc8ee8@linutronix.de>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
In-Reply-To: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=681;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=z6rw8gc2i+vXaJlg660yiQKhkDkj7a8Qr+J2EFiBq9A=;
 b=RhaONrS37dhEX8d1wSADLLwBV5kdoZ8JXoywKJrRNnTRBnqPjh/4TWSHyfP00DxiPUP9Nzz7Y
 EkydccSCII3B3rLLld2L+tAc2+T/EDPK/KlwsHTX3SAToBbrIuL3HqZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The same inclusion is already satisfied by vdso/clocksource.h.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/clocksource.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 12d853b1883265cb47d93e33d8370e3957e7e695..afa03e9fb6f6c978099b33c07ec853b7a82fde84 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -25,10 +25,6 @@ struct clocksource_base;
 struct clocksource;
 struct module;
 
-#if defined(CONFIG_GENERIC_GETTIMEOFDAY)
-#include <asm/clocksource.h>
-#endif
-
 #include <vdso/clocksource.h>
 
 /**

-- 
2.51.0


