Return-Path: <linux-kselftest+bounces-41696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B9B7FC53
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E2D1B20855
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CC72D46A4;
	Wed, 17 Sep 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JHj9kqTt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="81FXpCMg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D629A301;
	Wed, 17 Sep 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117722; cv=none; b=XlnTiovm7Q94ETUkpV4FFvsbIlhYGeARMvLMKQeQMIvEQzcLjgmw4RFzqm8Yllk9hb1pLtTxgf3PjkaL4Kkc86aafn6ZTDYKPCbDxw/LG+HxSlkFSqi1dN3sWqjLUUxdGlNQ2fjvv2U9ECCmfTwCorXOpSF9DtqpN/qMXGv6Lcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117722; c=relaxed/simple;
	bh=XJIvS4hKYyCqGnzGQlj96dz+6puKI0zqLs0UVC+sM+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuAeCHaferMFJGpzMfUBBnT7z+Y+3tWStPz9/xeVObXlBPowsmsxAJwNg6zZnimCvwoRrq0nmsd6tNm28LEJT6pnec1NKwOlpZEdX/v2F+XUZ3vCzbPcMcb5vS3kykYN5x09SEWu4T3EYgXF41yFfGvL34r9Od8Kk4YGBZMn+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHj9kqTt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=81FXpCMg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zQyKMAlqw8k3oqLgK6HtkrvF0ImRnltnSaL5sRLX+4=;
	b=JHj9kqTtZUFR3cWtZY7gPuXUU4CZ8futrwVBF9VzSwCF9pwAqfTgfGRu5VY91f6YPkVHxj
	I1lUUcTAwC4zA+F3XH4bE3yNMDgkJMd/mXBDYCs0TrfRLIm55KYb2ksEw4GOK9W0SdLKhh
	Dte28l3FBpdZTEQAop0pJZ2godqgvTg88RZirXvVHounWHiXl0kVUXT/32p4XiGsjs0z8s
	L3gmpMBaI8LqEVSkuBAO9rQWdqHvZBlK0cuC9VdJovudmiZ02nEwV8emU20m0bcUxtTGX+
	DNOcP9OH4NDQd7CJ0TyT49B4owDKUz4QnJ9QL7gohlj3zc3jvgfi6D/9EruIvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zQyKMAlqw8k3oqLgK6HtkrvF0ImRnltnSaL5sRLX+4=;
	b=81FXpCMgBi24Rq9naMMQLcwodP8iwpiqu9R1BvVCorLiJIpQEXibH2WRSP4Im0EPJ2w1Y7
	ewD/ziPkjhzMBwCg==
Date: Wed, 17 Sep 2025 16:00:11 +0200
Subject: [PATCH v3 09/36] MIPS: vdso: Add include guard to asm/vdso/vdso.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-9-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=970;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XJIvS4hKYyCqGnzGQlj96dz+6puKI0zqLs0UVC+sM+Q=;
 b=RnyqXMeVjWK5cddJ4pHNKPevtWEjEUBFIi+DE8KaR4t2hdbY6GgqJCStBSmqEIe87u5wkUb9D
 0tjQCoweyBhC9WS6hPpQSgu4UexdyVUa/S3+kMAjO3svskGqbmKVNb3
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

An upcomming patch will lead to the header file being included multiple
times from the same source file.

Add an include guard so this is possible.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/include/asm/vdso/vdso.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/vdso/vdso.h b/arch/mips/include/asm/vdso/vdso.h
index acd0efcd3d93ef7e71107302a40d24b4b51aae99..558d361bbf80afcdc61538543feced2f8a3c0347 100644
--- a/arch/mips/include/asm/vdso/vdso.h
+++ b/arch/mips/include/asm/vdso/vdso.h
@@ -4,6 +4,9 @@
  * Author: Alex Smith <alex.smith@imgtec.com>
  */
 
+#ifndef __ASM_VDSO_VDSO_H
+#define __ASM_VDSO_VDSO_H
+
 #include <asm/sgidefs.h>
 #include <vdso/page.h>
 
@@ -70,3 +73,5 @@ static inline void __iomem *get_gic(const struct vdso_time_data *data)
 #endif /* CONFIG_CLKSRC_MIPS_GIC */
 
 #endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_VDSO_H */

-- 
2.51.0


