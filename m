Return-Path: <linux-kselftest+bounces-41691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6CFB7FB31
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8D662004D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1B72877E7;
	Wed, 17 Sep 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WHYnPho1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TVYdGpoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ECD23183F;
	Wed, 17 Sep 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117719; cv=none; b=Rt7JLNgS0X515v3GfpQqyxfbzTG5P+zD7uohqZBTa02zTLW4var5Xkg+ORy1ewG+SRRUE9dJYFIlFfO90Sk15YQiiX0GQ0xfJb22WbismhaEEoSuRfxiWEwpafo8FypvSmicLQ1SQupc9TCv6ff2aZz7+GILNq8Buuu7afL7b3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117719; c=relaxed/simple;
	bh=KXRCejb0NgpV0MbZE6TVVMP7UCeEr1qQ9jIjqhoS2Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SR3MEnnybF8I3UzzKV5gnf6kUCSIYtprWSnxItVR5gNv7Sv0JAR1xbVqC9Mfqpyj18qbsGx4043XnDDdJvIjrvrspr03M2LKbqoUJTG7q2Yr0Ai1zz/iAxHenXGauZVSRbW+G6uRWvvr1/JS45+eP7wzYWxxuzL27HKU/L8jZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WHYnPho1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TVYdGpoP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lG79bLh+cxA30eAnxMz9ar91cT1e7icm6tLjmp9egkI=;
	b=WHYnPho16WVmazVJ1lvT3HGDsshx9Il8OAkuEolbruZh4Ny0d4KSgQPTrq7enPUrIyvXCC
	3mu46hnoLdcaOP6QXEzeP1/bOShp0opEtnwHpLE4Ndyjl68sHzseUiFuPNf92OMy+MpkqN
	CCbaS1Kk+k1/yjWNxoCeytp07WVbQXoU1AO8yNsQNSF9p9UR/0fwSixfLh6WpfSXW793AS
	Jx9IDy/pNxy4UHsFERSUkcPCeuU3F4aa1Wb6xHVE9K4O34Q2+jaT+jI7c5msj0EChcPEhT
	G3xIwG10Gv9auSwUQ9Sgt5PJtZsYqgS0BuDBCHnDO/Nsp4vdNWxcoUFz/UGJBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lG79bLh+cxA30eAnxMz9ar91cT1e7icm6tLjmp9egkI=;
	b=TVYdGpoP0Rd1x9/Emq1moJrVednuB/6nvs8Ir5jF43pXIjfVt5hmggh0Aj4OSHkxBL15c9
	bnL5C6l7HCoFH+Ag==
Date: Wed, 17 Sep 2025 16:00:04 +0200
Subject: [PATCH v3 02/36] arm64: vDSO: getrandom: Explicitly include
 asm/alternative.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-2-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=936;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=KXRCejb0NgpV0MbZE6TVVMP7UCeEr1qQ9jIjqhoS2Nc=;
 b=mYQ1H32ThBFXyyewa3im0FkaoCNjktKf+s/th6KEedWb5FldnJ5Cb2QFQ45WStq25QjVihVSQ
 OBAwVUiLvrNAFsA6CI/2VHgC+d6ew7CGbaw2FV6OhhoxxUG+0o2HKdf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The call to alternative_has_cap_likely(ARM64_HAS_FPSIMD) requires symbols
from asm/alternative.h. Currently this header is included transitively, but
that transitive inclusion is about to go away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/kernel/vdso/vgetrandom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/vdso/vgetrandom.c b/arch/arm64/kernel/vdso/vgetrandom.c
index 832fe195292b34e2029f593ea170347c98e06dac..0aef124c90899dc0c8956b0f32f54992aa3acf0b 100644
--- a/arch/arm64/kernel/vdso/vgetrandom.c
+++ b/arch/arm64/kernel/vdso/vgetrandom.c
@@ -2,6 +2,8 @@
 
 #include <uapi/asm-generic/errno.h>
 
+#include <asm/alternative.h>
+
 typeof(__cvdso_getrandom) __kernel_getrandom;
 
 ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)

-- 
2.51.0


