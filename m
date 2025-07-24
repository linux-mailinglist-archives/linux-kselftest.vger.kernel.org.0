Return-Path: <linux-kselftest+bounces-37915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D753B10089
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E8D1C27F98
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A615F223DD0;
	Thu, 24 Jul 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFnIiI9D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t3hBHo6H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E21C695;
	Thu, 24 Jul 2025 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338439; cv=none; b=k0XBj4CD9BUZVIc9k2FKAbz5HSnshN04q7lOghBSKOPfGSikEYfkrovjE5EwNB4HZ1g1VQMYZVQmmSs5rlz5RtEuYpn3OSqXN0sk7nsJIocDyTKIclKvpxs1oCQzd6K+ZQhzOUWBsjGMrQGKQAUttdsoOCnNu2q4iOa17ZYmyBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338439; c=relaxed/simple;
	bh=k/nPJAjUKIhC7FRH3VxxRQilHjAFMTFYDsd8wCU/6XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihTzZpHV8Qy2w9B1poq/nv6iBMrJsMy3WbqGBqy70+VjV1cmF4I0od4fefvA602hRoeKzodBQyVokUex2+Vfzc/koztwO6/Mf0uW1XLDoHeg9fSt4P9sdgKBrXNqOAsqXhtMvCCTJQJvhSMTVjOn6kIwfC2lK+YyEtlKAy5PaFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFnIiI9D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t3hBHo6H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753338435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRLN5QVsD5Cl07ObXFJ9FPXm5naCS7IwqH1uESlW1I0=;
	b=ZFnIiI9DPoyRVIdnDsrh8lXbAwesXJnnK8Q2WmfRR5DCa8pPh25cZ04aZwPx+xsYasjlTo
	HenBd2vHCoRXo+0cE1GHpUnWJRBnMh9oOaK+LpPHfoix0EETEuLSzjp3jYEWuAVMBF+3pj
	epWB5/HhguyheZK6AHUJ7ATIg/ss3ktGUVBIS+sZaw8M59OyoFtCtdxhtCHQ3ljJS2/Sgj
	1tlxkiMmr2ab6CZmsqoWrRfSflNwVa12m1vhJdZtozVIDDm/Fp9CdM/qFW4lY2wbEEb5KE
	yoH2O+IpLEU2AEqdFWuM5MBbxf5Bmf4fW/D3kKwAYSMWbdq5l2pBa/4qX5niXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753338435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRLN5QVsD5Cl07ObXFJ9FPXm5naCS7IwqH1uESlW1I0=;
	b=t3hBHo6HKaRyAvDXgnmaqdkWnW0YcL4ttwj5Sc/5XMpoqXcrsXRu+JBpcpHO0PCXKj2QrU
	yyv3VUsvksb7iIDQ==
Date: Thu, 24 Jul 2025 08:26:52 +0200
Subject: [PATCH RFC 02/14] sparc64: time: Remove architecture-specific
 clocksource data
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-vdso-sparc64-generic-2-v1-2-e376a3bd24d1@linutronix.de>
References: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
In-Reply-To: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753338429; l=3057;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=k/nPJAjUKIhC7FRH3VxxRQilHjAFMTFYDsd8wCU/6XA=;
 b=FO6m4o3mOdV4bVHGbxRYX9Jp4pNtcQtDUmY8bvwF7uY/gH9rqmI4III0ZOGc9yHgburO1FP0p
 LS6kxyEx9IVBCV0nNJ4lB0rHwNdQRVbdpT2BsXMZwbRq7VCRa1RtH7M
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is a dedicated field in 'struct clocksource' for the vDSO clock mode.

Use that field and get rid of 'select ARCH_CLOCKSOURCE_DATA'.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/Kconfig                   | 1 -
 arch/sparc/include/asm/clocksource.h | 4 ----
 arch/sparc/kernel/time_64.c          | 7 ++++---
 arch/sparc/kernel/vdso.c             | 2 +-
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0f88123925a4f9f95b1b8336ff80798dacd243f5..742d1ad7fb9483b11d6d5aac607bf24815b7a237 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -102,7 +102,6 @@ config SPARC64
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select GENERIC_TIME_VSYSCALL
-	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
diff --git a/arch/sparc/include/asm/clocksource.h b/arch/sparc/include/asm/clocksource.h
index d63ef224befebd68637d0be5d19c5cbf657d590d..81c59fdeb02e814ffac81397611ee63d684d64b1 100644
--- a/arch/sparc/include/asm/clocksource.h
+++ b/arch/sparc/include/asm/clocksource.h
@@ -10,8 +10,4 @@
 #define VCLOCK_TICK   1  /* Use %tick.  */
 #define VCLOCK_STICK  2  /* Use %stick. */
 
-struct arch_clocksource_data {
-	int vclock_mode;
-};
-
 #endif /* _ASM_SPARC_CLOCKSOURCE_H */
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index b32f27f929d1ab49a5aa05cde60d3b88e90928ba..0077286b1f67ffc6b63c78709fbd66aaa3f3bedc 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -48,6 +48,7 @@
 #include <linux/uaccess.h>
 #include <asm/irq_regs.h>
 #include <asm/cacheflush.h>
+#include <asm/clocksource.h>
 
 #include "entry.h"
 #include "kernel.h"
@@ -838,14 +839,14 @@ void __init time_init_early(void)
 	if (tlb_type == spitfire) {
 		if (is_hummingbird()) {
 			init_tick_ops(&hbtick_operations);
-			clocksource_tick.archdata.vclock_mode = VCLOCK_NONE;
+			clocksource_tick.vdso_clock_mode = VCLOCK_NONE;
 		} else {
 			init_tick_ops(&tick_operations);
-			clocksource_tick.archdata.vclock_mode = VCLOCK_TICK;
+			clocksource_tick.vdso_clock_mode = VCLOCK_TICK;
 		}
 	} else {
 		init_tick_ops(&stick_operations);
-		clocksource_tick.archdata.vclock_mode = VCLOCK_STICK;
+		clocksource_tick.vdso_clock_mode = VCLOCK_STICK;
 	}
 }
 
diff --git a/arch/sparc/kernel/vdso.c b/arch/sparc/kernel/vdso.c
index 0e27437eb97bff16aba53b1634c7e9fa7db20b46..a79937998a13b9142cc887dcaf6488571f9557eb 100644
--- a/arch/sparc/kernel/vdso.c
+++ b/arch/sparc/kernel/vdso.c
@@ -29,7 +29,7 @@ void update_vsyscall(struct timekeeper *tk)
 		return;
 
 	vvar_write_begin(vdata);
-	vdata->vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
+	vdata->vclock_mode = tk->tkr_mono.clock->vdso_clock_mode;
 	vdata->clock.cycle_last = tk->tkr_mono.cycle_last;
 	vdata->clock.mask = tk->tkr_mono.mask;
 	vdata->clock.mult = tk->tkr_mono.mult;

-- 
2.50.1


