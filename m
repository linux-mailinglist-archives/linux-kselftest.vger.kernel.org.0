Return-Path: <linux-kselftest+bounces-43090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E5FBD7ABD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D46D34E8646
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353F530F52D;
	Tue, 14 Oct 2025 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J6ASblZ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KDPYZ7hT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7F30E82B;
	Tue, 14 Oct 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424564; cv=none; b=aHvspBAsujwg2WIgpjxOtamyLMERQ6fcHxOMs5Zt45vVY1BFyz9dcDioooVI9mTh7Of1mGKajG6gW+LchQuFWNkdjE//8QiPW5T8a/hZp+lmO0jf97ObKKMG/Dd8alpv4rdDuviAGFqX7Oc3GB+EkQtEedRFWwyKvOLa6f7kHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424564; c=relaxed/simple;
	bh=zvq1hf5MGNIYhzE4YabXwYr2K6c63l5kL3/cxd5Yi1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K37v+1hnrtXHMFVUHG0CgCkS6htAWdtaA6ACNEPJPC/QFFCGRtG2R+X5sEQtdA+p+1+c+4pOkTTR5wYCwCVOsUJ/61CVONVrCrIZ9rjOahIE9n6nstBFIiEEZH5c2rjOof83PdcnuvRmKqSZUl3Jfvix6Wq6NnApDkg23iwTS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J6ASblZ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KDPYZ7hT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cixBlqzeA1rYEei235pjO9MOZJgcYixfO+t17HjPi8A=;
	b=J6ASblZ8vjwo39NfIJgOM+gNTgdDnpOKVqOX5vBbmGRoDYl9WVDQA7hB+DYEzIXDIPRMez
	kWZSbwetFBqoPczy1TfVwXCuIJ+TqNX0dRcgw6hZ3MfMOkQol46oPrcfyJCZGboCXo121X
	/GQL7pmVyjjBWyuW9kK1ten6UIS3xmGwwFiipKl3C30BIlzolYLUH4JlBhsEakbFWHoipc
	fOzagVLVT1zGXgvPCiCPlRzjL/x3JZZe8hMr6uxyVXkZ7yMwFHcWe9JozuE2dhp/M4p3yf
	iwKNKXI8S4YPMNqVMtG9DZ1VK1TopvkPMxYxY5hZNRcWUHlEnfIBjXMVxj8Wug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cixBlqzeA1rYEei235pjO9MOZJgcYixfO+t17HjPi8A=;
	b=KDPYZ7hTQ3JNeF0bd5VOQK/E1hHZhbwaOJB2MeYUeMoHVzeHUmhKVAXRdfXqH4xXzcp2Vc
	iUw+tygWKDCKH2CQ==
Date: Tue, 14 Oct 2025 08:49:03 +0200
Subject: [PATCH v4 17/35] random: vDSO: remove ifdeffery
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-17-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=2338;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=zvq1hf5MGNIYhzE4YabXwYr2K6c63l5kL3/cxd5Yi1s=;
 b=jRbkDBE0o+BQaejRO65g2d43oNK7OlrXtV4xh4rN1FCKlO3D0Oes4+yIlEiwSZJqWYjAIS1Zp
 d3a4wDA89OlD0NWPrNvFBOj3o7S3NoMmUktSbFMap+Vn29Su70Q9JWo
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Ifdeffery in C source files is discouraged.

Use IS_ENABLED() instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/char/random.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3860ddd9527930780d5c13cd4742fbc3c27acc42..b0b88c6f6a1afcdb770e39b7a64cb3408e33bd2c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -56,9 +56,7 @@
 #include <linux/sched/isolation.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
-#ifdef CONFIG_VDSO_GETRANDOM
 #include <vdso/datapage.h>
-#endif
 #include <asm/archrandom.h>
 #include <asm/processor.h>
 #include <asm/irq.h>
@@ -274,7 +272,7 @@ static void crng_reseed(struct work_struct *work)
 	if (next_gen == ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
-#ifdef CONFIG_VDSO_GETRANDOM
+
 	/* base_crng.generation's invalid value is ULONG_MAX, while
 	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
 	 * former to arrive at the latter. Use smp_store_release so that this
@@ -288,8 +286,9 @@ static void crng_reseed(struct work_struct *work)
 	 * because the vDSO side only checks whether the value changed, without
 	 * actually using or interpreting the value.
 	 */
-	smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen + 1);
-#endif
+	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+		smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen + 1);
+
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -742,9 +741,8 @@ static void __cold _credit_init_bits(size_t bits)
 		if (static_key_initialized && system_unbound_wq)
 			queue_work(system_unbound_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
-#ifdef CONFIG_VDSO_GETRANDOM
-		WRITE_ONCE(vdso_k_rng_data->is_ready, true);
-#endif
+		if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+			WRITE_ONCE(vdso_k_rng_data->is_ready, true);
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");

-- 
2.51.0


