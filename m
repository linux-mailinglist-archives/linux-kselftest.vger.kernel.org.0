Return-Path: <linux-kselftest+bounces-43088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3488CBD7B0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C4019219CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EB230EF74;
	Tue, 14 Oct 2025 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aVyOhzFX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="93A0Pupj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047F30DEB2;
	Tue, 14 Oct 2025 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424562; cv=none; b=MTa0Nz/Xduj1orGJhAUBuJ8DKRzvBQGR9c9s1EhVOgKPwvZdRyjLkJheFvwogTTsq4iTbnyuqv1kvx/xsUQ6Z5mhdEkMy0RK7zn743a9ZJVyOcML/BMHfCKWtTxP7N4uXshR8XuNdHRjBg3C1tPhfE5XV76BbcY+HC075iPbTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424562; c=relaxed/simple;
	bh=gCxoA74I68jSl8hq9TPM97UMjmPrbJiPbnyKM8TAfkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LONsTJu/5xX1BCUW1+Y+Xc095YBsuN8P+oVHqDJXfb3jN2mpImnw1pHRevdHxwjqyW7/Ushm/fxzW8o0y6b0Gx29QBduimBD+l2HCdGrJinoCfpfUfqQ+AlMBdhWFR3QDLMXFiGyV2vfILmN1Wkim4odYta0m3lHkPl/shTN8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aVyOhzFX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=93A0Pupj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKFAR6pTteHeDNIXFD4VW70Ndlry08cGog9KlECLSuA=;
	b=aVyOhzFXfn/6Sklao9CQTvk+ikFPSP4E5e/x6X5/aBK51XERII6rwWaFWRIesuf/7Ibp3c
	62Tw9JYip6pMrX0T3+URNjJGAaQBYlfmFq5pv51B2dPnOkfVxHORFeAC/e+EYmtNHlwDsr
	Sz2uirxiPJjjbaJsUKltc2Xc4W+kfvXKE15yEPbPp0Oa9lyQfH8DiHM/zWIjJg3WvtK1h7
	g+reIaFCIYAktmc8/yQ3aJyGTfOB44Z4nCNEsCCvD+EsOrOFptllWOJ82C0Ag0+5nQTGkn
	u52+hbuCIjZhi2xP5c/9Nbv9b3DxAMICkbq92UtL4FmdSgpuDVvcXV78yzPhWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKFAR6pTteHeDNIXFD4VW70Ndlry08cGog9KlECLSuA=;
	b=93A0PupjU1m7nesioE1Tos0VwbAOr8oarXvpNc0kvfhHfw8TFUheof84DChW+FjWzqxT5a
	/bxDRXuuXaEXQ+AA==
Date: Tue, 14 Oct 2025 08:48:53 +0200
Subject: [PATCH v4 07/35] powerpc/vdso: Explicitly include asm/cputable.h
 and asm/feature-fixups.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-7-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=1151;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gCxoA74I68jSl8hq9TPM97UMjmPrbJiPbnyKM8TAfkA=;
 b=ErSbWsbptiRFVQ2OuvWgIME8FbDtQqeR4bNDjcvIjX2tlqGeRUrUzaTyzk7W7+t5o6pzk/8s6
 bo01/vvS+uqAaz+1E3Td/IRTqKtYfwcyvWspCGwnull2AOGyPml55aO
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The usage of ASM_FTR_IFCLR(CPU_TR_ARCH_31) requires asm/cputable.h and
asm/feature-fixups.h. Currently these headers are included transitively,
but that transitive inclusion is about to go away.

Explicitly include the headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/powerpc/include/asm/vdso/processor.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
index c1f3d7aaf3ee970699fa73731412137631da347b..4c6802c3a58083efc01b4759dbdaa3612903df6a 100644
--- a/arch/powerpc/include/asm/vdso/processor.h
+++ b/arch/powerpc/include/asm/vdso/processor.h
@@ -4,6 +4,9 @@
 
 #ifndef __ASSEMBLER__
 
+#include <asm/cputable.h>
+#include <asm/feature-fixups.h>
+
 /* Macros for adjusting thread priority (hardware multi-threading) */
 #ifdef CONFIG_PPC64
 #define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")

-- 
2.51.0


