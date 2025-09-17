Return-Path: <linux-kselftest+bounces-41721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2ADB7FDBB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FF018952CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA30431618F;
	Wed, 17 Sep 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cr3zNqeI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BDv196xN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5E03016F4;
	Wed, 17 Sep 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117745; cv=none; b=McWp+7NM15nIcqps42bohWyrbxjec08BYse/ZgWy4BL3+M2vENYLzwEKoHxJM8TJkbWvnSIDjnQlIgTDtc4gDQzoVpZ483ROiT+IuTRlJj+XaF+4JvKnZAgpaXOLSkNckZOsIDqe3UIZCFKzaHbP8S1wzkY15H9atD9VG4RVaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117745; c=relaxed/simple;
	bh=7DTvdJEMPrLi9B8myWz2Q5sSHlMB2nyXYZiGMiBiOa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=awlOd5maliOcl/BX9c4gGEiPht71goVDp7Hv/QCElCpqnF1NvxgeHFk7GdSbopY0pGcnpaiUuozybstN/Xg6XLgAGkvvaqPdWYjGwKxNseu/G92HbhvQdwDDmIIuSPZC0HRSlCZp2BcgCs2AkEZm5PB/HOa7031rGiYvu8dJxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cr3zNqeI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BDv196xN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POZFrusONajTLFLkFs2HnF8XKauea9T94Z4BB3b6VVw=;
	b=Cr3zNqeICek9+0xDY7i08RqKBKw/aWA2EcdO2i5uHLiyfwY8b7jI+717WRRJnGGE/SX93l
	6SAgskt/O7ONrWQFgtWhaWylwRRw8EPj93FVEu76s/fpGsKM/+0vp8atklOLL9HSOEIAz0
	n5Bvp/3RILx7o06m+GIndas71aapNrmodWWxyow5nx25AQtpXHxhCnMmOab5QPtZaibuEt
	m4Xaxv+ZFGliEotUScLfsgkjuh/zbLy0Btv5J+0HlPiv7Hle8vh1XHkagWyf1Z7oAvf+9a
	H8PUBiS4hSnMY1oFlEh8bnSf+um0JmSO5/Hrpr/PLuGp/Nhr2fzDiO5jYBhR8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POZFrusONajTLFLkFs2HnF8XKauea9T94Z4BB3b6VVw=;
	b=BDv196xNmhytdAKzpD9pOxfCk+prapDzEY4uXr3YUESg0l6dzYA7qW+YI3dx7SOdOOjd68
	H0KOCRnnUKVpYBBA==
Date: Wed, 17 Sep 2025 16:00:37 +0200
Subject: [PATCH v3 35/36] clocksource: remove ARCH_CLOCKSOURCE_DATA
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-35-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=1684;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3DCfFJMQMpzmRW2bTQu93i8t9c0IdnU3shRaXcuZiPA=;
 b=ASDs1ZMlNBaY+M2Dq5Rt6d8L42IVHd2de47pLglR/D8Y8wm7UDodKVbXvNhiaKIYKy3ca0ndh
 vjmeBSKxGFgCD8QPUAIn3kNTIIkpgrCQHBcphwjoz/nYDK6kk+HQNcd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Arnd Bergmann <arnd@arndb.de>

After sparc64, there are no remaining users of ARCH_CLOCKSOURCE_DATA
and it can just be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: John Stultz <jstultz@google.com>
[Thomas: drop sparc64 bits from the patch]
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/clocksource.h | 6 +-----
 kernel/time/Kconfig         | 4 ----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 65b7c41471c390463770c2da13694e58e83b84ea..12d853b1883265cb47d93e33d8370e3957e7e695 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -25,8 +25,7 @@ struct clocksource_base;
 struct clocksource;
 struct module;
 
-#if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
-    defined(CONFIG_GENERIC_GETTIMEOFDAY)
+#if defined(CONFIG_GENERIC_GETTIMEOFDAY)
 #include <asm/clocksource.h>
 #endif
 
@@ -106,9 +105,6 @@ struct clocksource {
 	u64			max_idle_ns;
 	u32			maxadj;
 	u32			uncertainty_margin;
-#ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
-	struct arch_clocksource_data archdata;
-#endif
 	u64			max_cycles;
 	u64			max_raw_delta;
 	const char		*name;
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 7c6a52f7836cef248e0949060b50baa293f446cf..fe33118770978682d0ff6c6e7990896f42703b50 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -9,10 +9,6 @@
 config CLOCKSOURCE_WATCHDOG
 	bool
 
-# Architecture has extra clocksource data
-config ARCH_CLOCKSOURCE_DATA
-	bool
-
 # Architecture has extra clocksource init called from registration
 config ARCH_CLOCKSOURCE_INIT
 	bool

-- 
2.51.0


