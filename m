Return-Path: <linux-kselftest+bounces-44921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B7AC3A119
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35DD8348547
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBFB31DD97;
	Thu,  6 Nov 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sCapkKIo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JglCIafv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9D31B108;
	Thu,  6 Nov 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423354; cv=none; b=t79Z5+oLKGjZYLHHBTD7+CJcxRrfYXTURpJoQz1tNzH55h0CU38Ualtc8tg6f9a3aWUbGsj8UU4DFeeN11Ne/xB2uQZPQd5zYyF14s61Cdk64AjOmP39sMcBbYSrpQ1K4M26ucar0oSn1vJ5VTRrP48RT1FD0iAEYGxI4XrkXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423354; c=relaxed/simple;
	bh=T690CgHOC0+pGW9MJ3oWsROYo+v+vkE9Ah57C6iq4Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IpUvtulDSaGjuwWvomtH4/hUt0d8SwxiPCZoR/kkHRnbZ5q0D6ZGS7oLAYFejzIgZgFGFGD8MdkoAa2RQPrkWKNMNGgSw3+wRl9+2A+h+tEmAGvm2qhT4MgiIdMp+m+FLQP6gi5eLOWz9IEqZmWGlRYRuJZ1xjvwY5OvFCXkkwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sCapkKIo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JglCIafv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762423347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1o80+pTTZok9t083p85VuG7odpUuHMCDXyiNCCOOgcQ=;
	b=sCapkKIoouYdkRP7+9ZuTz2+na3lZc6flKNFXoHWi20wk1AMBFYMNb+ByBtP3G+QoXt9Xr
	la/djSdZjttD9BQ9vfrqBQRTZV3+qlTMKgw2Fua/t5HAK393VGvESGIL4oKMC73PT4zfRk
	63GITbQ0ejzbksNK09fQmXSvG8odapaQ9iDof7VnYHJo0W+L7yT0maXl5HfQ6A0ztgWArl
	zKbx1TUf23cTpxT7xseMVPEO6Hv10+ZsV77Rhw4iDb7NyNN52TLLCXF2eDj60FgLjXRng8
	t+biPNeryT6zzPSq9zmm7m9l+aBE4MERb/XE0I1X5O4E16F1W/iFNXVjBrZeOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762423347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1o80+pTTZok9t083p85VuG7odpUuHMCDXyiNCCOOgcQ=;
	b=JglCIafv0KCjy21QSmmkOyD4a53cdE4hoFoxlRR2yYhzJsdi4eJHovVs4jjp4OivLX06qE
	tGvA5Kikye1HjBCw==
Date: Thu, 06 Nov 2025 11:02:20 +0100
Subject: [PATCH v5 27/34] sparc64: vdso: Move hardware counter read into
 header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-vdso-sparc64-generic-2-v5-27-97ff2b6542f7@linutronix.de>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
In-Reply-To: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
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
 Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762423327; l=5859;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=T690CgHOC0+pGW9MJ3oWsROYo+v+vkE9Ah57C6iq4Fo=;
 b=6P3U+kHM0Yq1NrlRtnvnMF9b65o8BVW/UIbecHp87PtehJgSculNMNRCIZqsZsb2qr1DnwuLQ
 VhSJ5wDmEXnCDUHbeQpSyIDt4d/CM3N0sm1FMhhzzqEJWUCKucdF7BF
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic vDSO libraries expected the architecture glue around hardware
counter reading in asm/vdso/gettimeofday.h. To prepare the adoption of the
generic library, move the existing functions there.

While at it, perform some trivial alignment with the generic vDSO library:
* Drop 'notrace', as the functions are __always_inline anyways
* Use the same parameter types
* Use the same function names

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/vdso/gettimeofday.h | 78 ++++++++++++++++++++++++++++++
 arch/sparc/vdso/vclock_gettime.c           | 70 ++-------------------------
 2 files changed, 82 insertions(+), 66 deletions(-)

diff --git a/arch/sparc/include/asm/vdso/gettimeofday.h b/arch/sparc/include/asm/vdso/gettimeofday.h
new file mode 100644
index 0000000000000000000000000000000000000000..31f6505d3ab5dde9e02eca6da9182e5fb91031c4
--- /dev/null
+++ b/arch/sparc/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2006 Andi Kleen, SUSE Labs.
+ */
+
+#ifndef _ASM_SPARC_VDSO_GETTIMEOFDAY_H
+#define _ASM_SPARC_VDSO_GETTIMEOFDAY_H
+
+#include <linux/types.h>
+#include <asm/vvar.h>
+
+#ifdef	CONFIG_SPARC64
+static __always_inline u64 vdso_shift_ns(u64 val, u32 amt)
+{
+	return val >> amt;
+}
+
+static __always_inline u64 vread_tick(void)
+{
+	u64	ret;
+
+	__asm__ __volatile__("rd %%tick, %0" : "=r" (ret));
+	return ret;
+}
+
+static __always_inline u64 vread_tick_stick(void)
+{
+	u64	ret;
+
+	__asm__ __volatile__("rd %%asr24, %0" : "=r" (ret));
+	return ret;
+}
+#else
+static __always_inline u64 vdso_shift_ns(u64 val, u32 amt)
+{
+	u64 ret;
+
+	__asm__ __volatile__("sllx %H1, 32, %%g1\n\t"
+			     "srl %L1, 0, %L1\n\t"
+			     "or %%g1, %L1, %%g1\n\t"
+			     "srlx %%g1, %2, %L0\n\t"
+			     "srlx %L0, 32, %H0"
+			     : "=r" (ret)
+			     : "r" (val), "r" (amt)
+			     : "g1");
+	return ret;
+}
+
+static __always_inline u64 vread_tick(void)
+{
+	register unsigned long long ret asm("o4");
+
+	__asm__ __volatile__("rd %%tick, %L0\n\t"
+			     "srlx %L0, 32, %H0"
+			     : "=r" (ret));
+	return ret;
+}
+
+static __always_inline u64 vread_tick_stick(void)
+{
+	register unsigned long long ret asm("o4");
+
+	__asm__ __volatile__("rd %%asr24, %L0\n\t"
+			     "srlx %L0, 32, %H0"
+			     : "=r" (ret));
+	return ret;
+}
+#endif
+
+static __always_inline u64 __arch_get_hw_counter(struct vvar_data *vvar)
+{
+	if (likely(vvar->vclock_mode == VCLOCK_STICK))
+		return vread_tick_stick();
+	else
+		return vread_tick();
+}
+
+#endif /* _ASM_SPARC_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 643608bffe13d904c5f77edd585b2e58277491fb..16ac80982a00b9f965453b89a0cc111312baa9b2 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -19,6 +19,7 @@
 #include <asm/unistd.h>
 #include <asm/timex.h>
 #include <asm/clocksource.h>
+#include <asm/vdso/gettimeofday.h>
 #include <asm/vvar.h>
 
 #ifdef	CONFIG_SPARC64
@@ -85,73 +86,10 @@ notrace static long vdso_fallback_gettimeofday(struct __kernel_old_timeval *tv,
 	return o0;
 }
 
-#ifdef	CONFIG_SPARC64
-notrace static __always_inline u64 __shr64(u64 val, int amt)
-{
-	return val >> amt;
-}
-
-notrace static __always_inline u64 vread_tick(void)
-{
-	u64	ret;
-
-	__asm__ __volatile__("rd %%tick, %0" : "=r" (ret));
-	return ret;
-}
-
-notrace static __always_inline u64 vread_tick_stick(void)
-{
-	u64	ret;
-
-	__asm__ __volatile__("rd %%asr24, %0" : "=r" (ret));
-	return ret;
-}
-#else
-notrace static __always_inline u64 __shr64(u64 val, int amt)
-{
-	u64 ret;
-
-	__asm__ __volatile__("sllx %H1, 32, %%g1\n\t"
-			     "srl %L1, 0, %L1\n\t"
-			     "or %%g1, %L1, %%g1\n\t"
-			     "srlx %%g1, %2, %L0\n\t"
-			     "srlx %L0, 32, %H0"
-			     : "=r" (ret)
-			     : "r" (val), "r" (amt)
-			     : "g1");
-	return ret;
-}
-
-notrace static __always_inline u64 vread_tick(void)
-{
-	register unsigned long long ret asm("o4");
-
-	__asm__ __volatile__("rd %%tick, %L0\n\t"
-			     "srlx %L0, 32, %H0"
-			     : "=r" (ret));
-	return ret;
-}
-
-notrace static __always_inline u64 vread_tick_stick(void)
-{
-	register unsigned long long ret asm("o4");
-
-	__asm__ __volatile__("rd %%asr24, %L0\n\t"
-			     "srlx %L0, 32, %H0"
-			     : "=r" (ret));
-	return ret;
-}
-#endif
-
 notrace static __always_inline u64 vgetsns(struct vvar_data *vvar)
 {
 	u64 v;
-	u64 cycles;
-
-	if (likely(vvar->vclock_mode == VCLOCK_STICK))
-		cycles = vread_tick_stick();
-	else
-		cycles = vread_tick();
+	u64 cycles = __arch_get_hw_counter(vvar);
 
 	v = (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
 	return v * vvar->clock.mult;
@@ -168,7 +106,7 @@ notrace static __always_inline int do_realtime(struct vvar_data *vvar,
 		ts->tv_sec = vvar->wall_time_sec;
 		ns = vvar->wall_time_snsec;
 		ns += vgetsns(vvar);
-		ns = __shr64(ns, vvar->clock.shift);
+		ns = vdso_shift_ns(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
@@ -188,7 +126,7 @@ notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
 		ts->tv_sec = vvar->monotonic_time_sec;
 		ns = vvar->monotonic_time_snsec;
 		ns += vgetsns(vvar);
-		ns = __shr64(ns, vvar->clock.shift);
+		ns = vdso_shift_ns(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);

-- 
2.51.0


