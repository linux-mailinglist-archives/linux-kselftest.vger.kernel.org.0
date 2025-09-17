Return-Path: <linux-kselftest+bounces-41705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F7FB7FCF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2918976A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA512E2DFB;
	Wed, 17 Sep 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zYPaSxRJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kDoFxiAS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12D2DEA6A;
	Wed, 17 Sep 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117729; cv=none; b=PplsVYTrSABnhTmPwBmH2jZtQ+Rr36GHMtTizQeozLznoIuUGzEkv/DN0yqFxylmt9NGEiBBgIem1OPcl9Le93J+4fK4S0dTNl6yu2/sZG8LqndZ21kfPFXAetsGskfeiI8VVnkFK2i0v3Q2eLqIetnbeApxtVoxDcbyX6AooBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117729; c=relaxed/simple;
	bh=41FpYFpeNVAvcW9qivCMlMgw50x3JGyoXtMbGlhmuLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJWhXo/TvZx4hw7s3gHsWPDmI3Cxs4vkD5Q1VZtt+PjAEVxl0FUWcU+wDamVjTXgw19rlO0DtNy7gGZAv1Z2BnUVVFxoaIlKb8hiyDD01UEd/l6VXF/H/J0RQXOAnZi+cA2GtuazqEtXsl06yb2P/nIFepJsouZWjz6UpPlcBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zYPaSxRJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kDoFxiAS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAPQS/pmZO3nrOzg2YQNfWuFxc9alVN9Gxa03iD/mGc=;
	b=zYPaSxRJ4lOaU+afME3RUoIP/B6znDwRrzIAWU0sYKrnsdcbokWRrOY1y8J0hNF/nEhEgO
	OI4y/UY6UorlxSs8T/SX0QixHyXnXUVZE4SWpN1RbcjP4UvIzm/A9tM1n2LBpdHTzkFRvI
	a7f8PFLd335AS2kX3tg4fWx/1RZhCOiECJEX3VsijpP9aAApHE9xovZG59KEdIffuyYXF6
	1o4508hgvz1T7kcPPFSpal7F7dWFTdTTdSEYGdWR+7OEJ4X0a74WQo8LxXAQ7baGP8TLFa
	psKrHi2EKwCy7+ZfBzOplstP2PcDplUhX5xgAdJAZ7Kbr+A1igHl6nRLKIb3rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAPQS/pmZO3nrOzg2YQNfWuFxc9alVN9Gxa03iD/mGc=;
	b=kDoFxiASOs9taiBNaPa+dXo9RmH38UVKgGClW3Op3KRfzYWFUSCHXJTOrS8sFu33OXzEQr
	sTvU9eZ2GMOHOJBA==
Date: Wed, 17 Sep 2025 16:00:20 +0200
Subject: [PATCH v3 18/36] random: vDSO: split out datapage update into
 helper functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-18-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=3756;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=41FpYFpeNVAvcW9qivCMlMgw50x3JGyoXtMbGlhmuLI=;
 b=FmTFmc7E4Q0W1Lsek8lGyn15A4bZIxhBBu6p39eFJdEcjGLtHqh9C7BkoOdXyxSBKdbJKgWOB
 s4aaq7e0CyaCb2qY6s4Lk9OZVwjHgIjew5zxD1sUN3HWexfuWuEQKSF
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some upcoming changes will introduce additional callers of them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/char/random.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b0b88c6f6a1afcdb770e39b7a64cb3408e33bd2c..73c53a4fb949bfd2ed723fa3cec3fe0d066a7fa3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -246,6 +246,37 @@ static unsigned int crng_reseed_interval(void)
 /* Used by crng_reseed() and crng_make_state() to extract a new seed from the input pool. */
 static void extract_entropy(void *buf, size_t len);
 
+/* This updates the generation in the vDSO data page */
+static void random_vdso_update_generation(unsigned long next_gen)
+{
+	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+		return;
+
+	/* base_crng.generation's invalid value is ULONG_MAX, while
+	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
+	 * former to arrive at the latter. Use smp_store_release so that this
+	 * is ordered with the write above to base_crng.generation. Pairs with
+	 * the smp_rmb() before the syscall in the vDSO code.
+	 *
+	 * Cast to unsigned long for 32-bit architectures, since atomic 64-bit
+	 * operations are not supported on those architectures. This is safe
+	 * because base_crng.generation is a 32-bit value. On big-endian
+	 * architectures it will be stored in the upper 32 bits, but that's okay
+	 * because the vDSO side only checks whether the value changed, without
+	 * actually using or interpreting the value.
+	 */
+	smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen + 1);
+}
+
+/* This sets is_ready in the vDSO data page */
+static void random_vdso_set_ready(void)
+{
+	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+		return;
+
+	WRITE_ONCE(vdso_k_rng_data->is_ready, true);
+}
+
 /* This extracts a new crng key from the input pool. */
 static void crng_reseed(struct work_struct *work)
 {
@@ -272,22 +303,7 @@ static void crng_reseed(struct work_struct *work)
 	if (next_gen == ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
-
-	/* base_crng.generation's invalid value is ULONG_MAX, while
-	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
-	 * former to arrive at the latter. Use smp_store_release so that this
-	 * is ordered with the write above to base_crng.generation. Pairs with
-	 * the smp_rmb() before the syscall in the vDSO code.
-	 *
-	 * Cast to unsigned long for 32-bit architectures, since atomic 64-bit
-	 * operations are not supported on those architectures. This is safe
-	 * because base_crng.generation is a 32-bit value. On big-endian
-	 * architectures it will be stored in the upper 32 bits, but that's okay
-	 * because the vDSO side only checks whether the value changed, without
-	 * actually using or interpreting the value.
-	 */
-	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
-		smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen + 1);
+	random_vdso_update_generation(next_gen);
 
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
@@ -741,8 +757,7 @@ static void __cold _credit_init_bits(size_t bits)
 		if (static_key_initialized && system_unbound_wq)
 			queue_work(system_unbound_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
-		if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
-			WRITE_ONCE(vdso_k_rng_data->is_ready, true);
+		random_vdso_set_ready();
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");

-- 
2.51.0


