Return-Path: <linux-kselftest+bounces-41706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E251B7FD34
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B62A543767
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498EA2E543B;
	Wed, 17 Sep 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="25tRyX7M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QLiWyBdR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB882E1EE2;
	Wed, 17 Sep 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117730; cv=none; b=mQ9P9Sogk3DG0KKCIOQ0YToe19yQchBlKRsga5R067LOEAxoayuaBftaiQ6yBrsp3B9URt73frqO4cyn8z/OzRmPC4lRHlmxpcG2EqDuR8V7MX7LswpRY1qGUs0HwCXIXBx5m9kMHVTxerwlfBHgFe8Cv1IvRYa1iWg4gOD3mnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117730; c=relaxed/simple;
	bh=eZ1dDq0MfGenTPjQNZP07/Jb7BnP3IgLLLQRjIR+5Yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ic6RMSkyrfEOFgIoc23i+16F4kodSCoFF1sz4cNmtaGcSh1al7p4NMSDPEKpDZAZa+2VdBgaLWXIVGkhdgcUO6ABPDV51zU8PZHz6YimiGhwggqYOt+42jnoGFBIULqfumLBoL8P/BwJdSToyJl1NWd1AqbXKKq5DkFniP5eJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=25tRyX7M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QLiWyBdR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUFFv50bhb2+00GyqpEZHNIfyXG+VUi75AZvpEX7DOM=;
	b=25tRyX7MK/yc1747HtA5vxS6y/LfwSpeLcAuZtpf5RG1mH6HSA7Z0CBkKx6h4fLVKJgG+i
	gzs16Dj7Oqh9qL5b96kEPaap7sNRCNVH32um1VNUGmpCBrHGyNZJ08QXkjiFDFodmkVlWZ
	mLVIQdB3q+8PyoCtB0JUkIUaLBgWQOhXbNTf2n7PiIstBuyjhPlTNoLHpETAnszd3ptqXF
	m/8ZmT5IACI4nY9JYHML4/CLRtkqfsnuWbFAw6zEh8PTj3C9IOyorjp3uEvd+hXJYMIUlx
	2st4cCerZ5AEWNevtqdyZ5hdb45mvcnwOp5xPWnAHgbTGM778njcXb/bqWJ7HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUFFv50bhb2+00GyqpEZHNIfyXG+VUi75AZvpEX7DOM=;
	b=QLiWyBdR2rg3zkPbtErOOuSNp2bFt7wDVXrC/RZUHhbaL4Nb+7QmKT2gwUZVr4UAiKIiOg
	LkjjO8SrN5k4YjAg==
Date: Wed, 17 Sep 2025 16:00:21 +0200
Subject: [PATCH v3 19/36] random: vDSO: only access vDSO datapage after
 random_init()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-19-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=2363;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=eZ1dDq0MfGenTPjQNZP07/Jb7BnP3IgLLLQRjIR+5Yw=;
 b=ulpG5t+QjFlzrCh0/hSQNTxQqa9rMe5B8ib8Z7QwM7aJKgiEMuj9UWYwV+0f5PlWBhjJFPUE3
 925uYZxoSJiBEVKqLWte5Jf7eE+g+uEwfp8mMAfyQm4a+qXjG1JHGH6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Upcoming changes to the generic vDSO library will mean that the vDSO
datapage will not yet be usable during early boot.

Introduce a static key which prevents early accesses.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/char/random.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 73c53a4fb949bfd2ed723fa3cec3fe0d066a7fa3..8970645463ceae0dadb75825a3cb0df3ef1e982e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -88,6 +88,11 @@ static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct fasync_struct *fasync;
 static ATOMIC_NOTIFIER_HEAD(random_ready_notifier);
+#ifdef CONFIG_VDSO_GETRANDOM
+static DEFINE_STATIC_KEY_FALSE(random_vdso_is_ready);
+#else
+DECLARE_STATIC_KEY_FALSE(random_vdso_is_ready);
+#endif
 
 /* Control how we warn userspace. */
 static struct ratelimit_state urandom_warning =
@@ -252,6 +257,9 @@ static void random_vdso_update_generation(unsigned long next_gen)
 	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
 		return;
 
+	if (!static_branch_likely(&random_vdso_is_ready))
+		return;
+
 	/* base_crng.generation's invalid value is ULONG_MAX, while
 	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
 	 * former to arrive at the latter. Use smp_store_release so that this
@@ -274,6 +282,9 @@ static void random_vdso_set_ready(void)
 	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
 		return;
 
+	if (!static_branch_likely(&random_vdso_is_ready))
+		return;
+
 	WRITE_ONCE(vdso_k_rng_data->is_ready, true);
 }
 
@@ -925,6 +936,9 @@ void __init random_init(void)
 	_mix_pool_bytes(&entropy, sizeof(entropy));
 	add_latent_entropy();
 
+	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+		static_branch_enable(&random_vdso_is_ready);
+
 	/*
 	 * If we were initialized by the cpu or bootloader before jump labels
 	 * or workqueues are initialized, then we should enable the static
@@ -934,8 +948,10 @@ void __init random_init(void)
 		crng_set_ready(NULL);
 
 	/* Reseed if already seeded by earlier phases. */
-	if (crng_ready())
+	if (crng_ready()) {
 		crng_reseed(NULL);
+		random_vdso_set_ready();
+	}
 
 	WARN_ON(register_pm_notifier(&pm_notifier));
 

-- 
2.51.0


