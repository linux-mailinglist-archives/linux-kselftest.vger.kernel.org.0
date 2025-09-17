Return-Path: <linux-kselftest+bounces-41707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76592B7FCAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1696C520EAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D1F2E6CC3;
	Wed, 17 Sep 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OU0D+c42";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odwIPgAF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67B2E2DCB;
	Wed, 17 Sep 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117731; cv=none; b=ZlJpB7yZ6+l5PuTq9ALCxzADjOEKVRFiQoTkW3TPMK6NAzqEORT84Pi1ztdtFkqnTqCWcGtvUwrbZT9f6IqteA+T1Zv8z5+7RXRs+m6EqduMax/DOBNaVM2pfAwtbopaDRI/qF/U2D+OlmzS+vJg0v8FTCc9an/m5royG99uLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117731; c=relaxed/simple;
	bh=ApSzf9ILh/EhcOJI2zAI91ndmrTsGMpy2DZqXgLt548=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dhxk59ete1SzQefXhqEQQhWwNLnzE67KiViXVK3Ph5Q87TWsCMKwL1hbbbUWhe6kpU8YV+bVMfxvuO4yeyRAifh8criBN/aMpBTgYEfcNZON1pw08NWa5PxPvX2g+OALhyEFpbMEN/0Qs0kv2dhlN0+7NsROq+yi8A11jvtUo0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OU0D+c42; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odwIPgAF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kN/1z541eD5r45O9HbiVCy9Hf0r9nA9EQTfNLTZ91CE=;
	b=OU0D+c42NlGykjDU6oGCfr2xibvn6mC2df40bLfNviSDptLpM54CoQW1K4tc7Lu1nQ801B
	AI45uOJkKyvDXc2zqv9iHI7xOfg7RG6NyQ2aVNacyQK4mRDO92YPUaA2ZD5oknUUB0Hlm8
	whOgK6f+UE+l9PeFnQ9xwpTtymjNJ54BoECq4rEifHc2A+IFQnRCR9/cMmMwd9pNiQPx4u
	Hxg8TYMc4WZR3ZmpmwgiWbwAFaSyu1YnEP7XKnx4Wv8IlSK8fA6l8l6oxvzfFWOSYQ+VjR
	69db/jFjlz8/6AnHtXn+reY40PAw1OKp4IRNt2sCz1YwBTayGnG0Km/UPbgDyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kN/1z541eD5r45O9HbiVCy9Hf0r9nA9EQTfNLTZ91CE=;
	b=odwIPgAFfAeSJScaPPohX4KB03R5GVAZP3L6MCWqTrN7xKE//eHoqZGIqzKAZ6Gns9YHoG
	+PtSg2Nov56e6wAA==
Date: Wed, 17 Sep 2025 16:00:22 +0200
Subject: [PATCH v3 20/36] s390/time: Set up vDSO datapage later
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-20-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=1209;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ApSzf9ILh/EhcOJI2zAI91ndmrTsGMpy2DZqXgLt548=;
 b=rk9HBKG5f+HFQaqZDuujtGjpLv/GgbgrC1EVImtnQuWZjiDVeNK5bd37f1aF/d+7HVb1kWLY9
 WmbXr35zIgkAfpyY0L1FyO/JqumrYumQ1JDF0/aprcY0YCrgSGDN6EO
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Upcoming changes to the generic vDSO library will mean that the vDSO
datapage will not yet be usable during time_early_init().

Move the initialization to time_init() which is called later. This is
valid as the value of tod_clock_base.tod does not change during the
lifetime of the machine and the vDSO datapage is only used much later.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/s390/kernel/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 63517b85f4c930b799235c381d9d6b263fff5431..6b948b9e61fe674bbc842a0143dd35a26b91a860 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -78,8 +78,6 @@ void __init time_early_init(void)
 	struct ptff_qto qto;
 	struct ptff_qui qui;
 
-	vdso_k_time_data->arch_data.tod_delta = tod_clock_base.tod;
-
 	if (!test_facility(28))
 		return;
 
@@ -248,6 +246,8 @@ struct clocksource * __init clocksource_default_clock(void)
  */
 void __init time_init(void)
 {
+	vdso_k_time_data->arch_data.tod_delta = tod_clock_base.tod;
+
 	/* Reset time synchronization interfaces. */
 	stp_reset();
 

-- 
2.51.0


