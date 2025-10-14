Return-Path: <linux-kselftest+bounces-43089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF74FBD7AB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACABE4EA758
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72EF30EF97;
	Tue, 14 Oct 2025 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2FwHegJy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CnLafbR6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15BD30E825;
	Tue, 14 Oct 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424563; cv=none; b=PgrFrVOqs2+r1NVH4hiE4cWzHHU7cOJB2jgvZ7hAHi0kAlXinofwCixjpTm2fpt0Ly69RW7J1MDhMplgV59VzrJnf+A61mZI626AWj2sEHTjUIPZDPdguH2HSyltMu1AIl1Uzh/FP4EZ/9IiRRtHBepAp9UldN3bzFkNFpI3V1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424563; c=relaxed/simple;
	bh=at2WHYQMWa0qZ9sRgIO7R8kScM/WkZbDWmC1hAg3nZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBs6zp4dADwPpYwRMBXXvkPVuQO56o9KoET4p0T7SNhMZMnzJyEJ/woo1K7k8tm/VUoIJpQh8qAU/j78npu3D0h3JRU6M7udA2MOo5IbPWNEcP8gaQUFDzAUPg7lbFHxhGJoLopjJ+sZLidv8u02K5+jUb7e7nizyszUD2WGRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2FwHegJy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CnLafbR6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBw5Uw1xTFSkt2IyDChXADePP6hnrVSQHkAiEvYpbaA=;
	b=2FwHegJy/Rjkte4TduRSJbAs+cMMwGf75Su5BQ3nQwYMuUgQc/ZFb29O1oHO3XiztHhlgE
	hBh2Xf5pbRYy8wKzFXKHsECWESL2oy2WfDwMLLN38SkIfwFS2/0SaY9f585WPGpUY00uoE
	LtHSimew7e9dNV+8UDxhStBH89SLP9WiPemgrML2Ipy7jKbRxjTlCqbU9mZsTdYtrRcrvn
	qmt3U4I3P8E4b3rC3GqdRJ185j7puvvT2Yg4/FZ9QgzP/ab784OSiIzwzIcXb1kBqkTsSW
	BcBh04hHzVysesYHplJCwWcVct3pVyZg1iEYU6mVKDT7awpGfXuxJh2VTVTjFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBw5Uw1xTFSkt2IyDChXADePP6hnrVSQHkAiEvYpbaA=;
	b=CnLafbR6tZEtmqiMD+BJ6eF3XSn/rITvzaI4LN0zq/y3QVIGQofCxbN0PIa+D2n98FjqQx
	LTXOMhpiHEI0TLCw==
Date: Tue, 14 Oct 2025 08:49:02 +0200
Subject: [PATCH v4 16/35] random: vDSO: trim vDSO includes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-16-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=781;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=at2WHYQMWa0qZ9sRgIO7R8kScM/WkZbDWmC1hAg3nZ4=;
 b=32+xcT2opZOprGr5piXABwvF8kNqrHO+1idH7DouMTT7RPpPEeYKnLaDcs7R1hf00DtNYoKOl
 /JEmppmcBb8CwRckAXD6Ju01Wg1GAjMDExkRXVvey5FFQFQ5zDjP0rG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These includes are not used, remove them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/char/random.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b8b24b6ed3fe436c8102968392278d5cb5544f06..3860ddd9527930780d5c13cd4742fbc3c27acc42 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -57,9 +57,7 @@
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
 #ifdef CONFIG_VDSO_GETRANDOM
-#include <vdso/getrandom.h>
 #include <vdso/datapage.h>
-#include <vdso/vsyscall.h>
 #endif
 #include <asm/archrandom.h>
 #include <asm/processor.h>

-- 
2.51.0


