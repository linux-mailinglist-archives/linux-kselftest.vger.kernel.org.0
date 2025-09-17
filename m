Return-Path: <linux-kselftest+bounces-41717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B4B7FDA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58555452AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402E42F0685;
	Wed, 17 Sep 2025 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gqM+v9f6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N1thyuhb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010E2ECD3A;
	Wed, 17 Sep 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117741; cv=none; b=YvBHrqvMKX2DgKctCpYKcMj+LctINzOhUTh/p1uAwjS/jU1G2NC1juqnQ7FevWRphV6plhxHy5pIG7bDpHSHKoYH75D+GEJESnGb5YSfIIb6cSMD+ZBvEeusSrHcObBPLEZJ8IZvW7w5xI+ThiUvdcikyptFHq7FlHSW0JF1QYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117741; c=relaxed/simple;
	bh=W3Gq92ehVoqjipEhukWFy/O5j4kKgL6JHT3M1VUfxs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlhTBhH2VYjffkNx8gYqxHbNYSsSw4WFxylVb89qyb8xabDU8FANffT124U194PoFcWPVrePX1M28hJqoRT7ZnSCSwSH/AmsFXwMwAAwfTLXCE2LeItQ1wDsS4TKwH6zREytG0h7IVnK/4KhpPT/c+RwlmEs0qCZY2oIH9o3VuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gqM+v9f6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N1thyuhb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DhA7HJ8bSiCtmLwjuEAGG4saVXDBqHPKx+e9XGDNdY=;
	b=gqM+v9f6QL9AuLgNqkYY9OGvmWz5lAdrXhO3BP4LFs66sFeZiVe8p0DuBg/wPovx+l9LzS
	jndagPsoVkUZ4ErniWt2UBHP3ALDa6LDPYJu7oMdQp3GCFkRnfsoeS7efcDv9EPh0NHCfb
	n3Vci2XSDba0CVoPiLVL9Gd/Rr+Nl6Fo48ZLCjobl7VsrKmNTc64iGf+cRAPJNs0HNxt6Y
	jM4tx8L4thM3cq2e02OwRq73U4RWalFlfBRycffPf7caM2zsHizdfgUYZG+Lxm1StUYHjF
	FP/B8K450SUDFYoXhSldqypgUOskk6hYEdB63ZdNE2nqKqg6/DDkX6IOp2QxaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DhA7HJ8bSiCtmLwjuEAGG4saVXDBqHPKx+e9XGDNdY=;
	b=N1thyuhbCws7l80qSuO0oYzjnJ3crb0kV6go9zD4JubbQtWBM2FraRI2EUoL4DA+fSDO8J
	3SDNYbfN/bYLxSBQ==
Date: Wed, 17 Sep 2025 16:00:32 +0200
Subject: [PATCH v3 30/36] sparc64: vdso: Introduce vdso/processor.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-30-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=4619;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=W3Gq92ehVoqjipEhukWFy/O5j4kKgL6JHT3M1VUfxs8=;
 b=ENmbZGjm89C5vPxpgJfzZDJ5gDNJ3DSyeF1YlcCsl1wOFoSYW+jY6FlcGQYTXmcP/lJDscWV8
 OzrQcmGB9C7AImuqVqCBS4LWPpi/D55n2GXxE4MHlTiyaqB1qXHKKNW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic vDSO library expects a vdso/processor.h with an definition of
cpu_relax().

Split out cpu_relax() into this dedicated header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/include/asm/processor.h      |  3 +++
 arch/sparc/include/asm/processor_32.h   |  2 --
 arch/sparc/include/asm/processor_64.h   | 25 --------------------
 arch/sparc/include/asm/vdso/processor.h | 41 +++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/arch/sparc/include/asm/processor.h b/arch/sparc/include/asm/processor.h
index 18295ea625dd7271617c15caa003a173099dd4d0..e34de956519aaca0e9bf82a22000d9096f868968 100644
--- a/arch/sparc/include/asm/processor.h
+++ b/arch/sparc/include/asm/processor.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_PROCESSOR_H
 #define ___ASM_SPARC_PROCESSOR_H
+
+#include <asm/vdso/processor.h>
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/processor_64.h>
 #else
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index ba8b70ffec085feb17de9050f37de98e0039f7c3..a074d313f4f80621c1bc42733529c6d9450b1275 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -91,8 +91,6 @@ unsigned long __get_wchan(struct task_struct *);
 extern struct task_struct *last_task_used_math;
 int do_mathemu(struct pt_regs *regs, struct task_struct *fpt);
 
-#define cpu_relax()	barrier()
-
 extern void (*sparc_idle)(void);
 
 #endif
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index 0a0d5c3d184c751d232a00e73357c0e345695a94..3de65ad6d78592013b1d1158a58497f3821d003c 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -182,31 +182,6 @@ unsigned long __get_wchan(struct task_struct *task);
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->tpc)
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->u_regs[UREG_FP])
 
-/* Please see the commentary in asm/backoff.h for a description of
- * what these instructions are doing and how they have been chosen.
- * To make a long story short, we are trying to yield the current cpu
- * strand during busy loops.
- */
-#ifdef	BUILD_VDSO
-#define	cpu_relax()	asm volatile("\n99:\n\t"			\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     ::: "memory")
-#else /* ! BUILD_VDSO */
-#define cpu_relax()	asm volatile("\n99:\n\t"			\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     ".section	.pause_3insn_patch,\"ax\"\n\t"\
-				     ".word	99b\n\t"		\
-				     "wr	%%g0, 128, %%asr27\n\t"	\
-				     "nop\n\t"				\
-				     "nop\n\t"				\
-				     ".previous"			\
-				     ::: "memory")
-#endif
-
 /* Prefetch support.  This is tuned for UltraSPARC-III and later.
  * UltraSPARC-I will treat these as nops, and UltraSPARC-II has
  * a shallower prefetch queue than later chips.
diff --git a/arch/sparc/include/asm/vdso/processor.h b/arch/sparc/include/asm/vdso/processor.h
new file mode 100644
index 0000000000000000000000000000000000000000..f7a9adc807f7c9a0444afa51aeb47649a9bdb079
--- /dev/null
+++ b/arch/sparc/include/asm/vdso/processor.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_SPARC_VDSO_PROCESSOR_H
+#define _ASM_SPARC_VDSO_PROCESSOR_H
+
+#include <linux/compiler.h>
+
+#if defined(__arch64__)
+
+/* Please see the commentary in asm/backoff.h for a description of
+ * what these instructions are doing and how they have been chosen.
+ * To make a long story short, we are trying to yield the current cpu
+ * strand during busy loops.
+ */
+#ifdef	BUILD_VDSO
+#define	cpu_relax()	asm volatile("\n99:\n\t"			\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     ::: "memory")
+#else /* ! BUILD_VDSO */
+#define cpu_relax()	asm volatile("\n99:\n\t"			\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     ".section	.pause_3insn_patch,\"ax\"\n\t"\
+				     ".word	99b\n\t"		\
+				     "wr	%%g0, 128, %%asr27\n\t"	\
+				     "nop\n\t"				\
+				     "nop\n\t"				\
+				     ".previous"			\
+				     ::: "memory")
+#endif /* BUILD_VDSO */
+
+#else /* ! __arch64__ */
+
+#define cpu_relax()	barrier()
+
+#endif /* __arch64__ */
+
+#endif /* _ASM_SPARC_VDSO_PROCESSOR_H */

-- 
2.51.0


