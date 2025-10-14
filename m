Return-Path: <linux-kselftest+bounces-43108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C19CBD7C10
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77A8334F6FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF983128C2;
	Tue, 14 Oct 2025 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2dWVkuy5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OTTVOlcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94BC30AD14;
	Tue, 14 Oct 2025 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424576; cv=none; b=c1jX1poBmdTDk9EXIdnyddwUlGKx4NfFvkJHYxw1groZNEEbDguy6klD0ehOisZCPBUVrFU8FHuBApXo/tQjwb6c0j4RSyiQPPb6/I9Gqoy9Z7pgqpif7OU77T8aSvsk4Gy2H0161Gp5WVUyhMM/aHRDswhFp/GsKhWm1oUSGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424576; c=relaxed/simple;
	bh=niJ5zV3fOozEUYGk5vpPy390WfaoIhw2fIWLZusJAMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSlbCMNBduBgU4kVJ0q7kFqos9/DR1A5cwgSBsmA/tFnZiqlGaGkoH3xm8DswOlmD3qSVdYme2oWxHAi1xlfWlbXyBEyK2d8UWZEyWQoGMgyeD7nWKvIaGHCQIyKmZAh9KtsuYQRhQSOHxUATOFLN9BhXjM7n3hBQ54INf3jp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2dWVkuy5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OTTVOlcU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0BySyb43wBJ5y5cuP5lO0V/BYHsArDn7KOGMPsnnl4=;
	b=2dWVkuy5mbBzbczud3S31EbAnBQEKlkZRNrzW7RVMScCIwL5Yb3USIiYgh9lQ9AC5b/TkN
	abVUFDx05Xxnqzuu90mH4IGFyrcG6sRnZ5f2HEenUEG4MXfUXhY0dXjxLG5ZF5Mc2lcSrY
	RW2Ahz9GmsWMgcy7k10lxZW5Ha+mwBkXkXdpegdk+29xM8Ep1dHL4LxcTzFMJP6preXrMB
	9WPj0s5sxq08hThUdkcgNkRLmBaGIvtKtvBIdoMwXXZaLU6D3EQgs0aX7siQ4cH3aWdajh
	8o2o206P64l7UMDQ75f7y7okA4RoLK9rSm2PL+mphp7DTETnaMqH4JPw6wAQVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0BySyb43wBJ5y5cuP5lO0V/BYHsArDn7KOGMPsnnl4=;
	b=OTTVOlcUpXwxcOeMGLPPGvCFzA536UqoKrwtPVJ+q3/CZXPUc3zG8c6LD17+Mynw4TPJ37
	nB9JZtEc9lMunPBg==
Date: Tue, 14 Oct 2025 08:49:20 +0200
Subject: [PATCH v4 34/35] sparc64: vdso: Implement clock_gettime64()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-34-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=3381;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=niJ5zV3fOozEUYGk5vpPy390WfaoIhw2fIWLZusJAMg=;
 b=Gatq8X7mwCuaB3UN5QnkwkXD5o1LUo9aufoHXtSJaRS8hCZwIUL9yH0OhKAFUXEBnAe+3skOA
 1vriYaLy0gNB+hSp18W9TVtdiHB2f0QsbMoQFlsFS3o0aBiYI2Biaso
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To be y2038-safe, 32-bit userspace needs to explicitly call the 64-bit safe
time APIs.

Implement clock_gettime64() in the 32-bit vDSO.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/vdso/gettimeofday.h | 20 ++++++++++++++++++--
 arch/sparc/vdso/vclock_gettime.c           |  8 ++++++++
 arch/sparc/vdso/vdso32/vdso32.lds.S        |  2 ++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/vdso/gettimeofday.h b/arch/sparc/include/asm/vdso/gettimeofday.h
index a35875fba45470ba961a7df3ae52bc17d2a4a4a0..b0c80c8a28bb71e16398ab38904ba826457ac71d 100644
--- a/arch/sparc/include/asm/vdso/gettimeofday.h
+++ b/arch/sparc/include/asm/vdso/gettimeofday.h
@@ -101,6 +101,8 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode, const struct vd
 	"f48", "f50", "f52", "f54", "f56", "f58", "f60", "f62",		\
 	"cc", "memory"
 
+#ifdef CONFIG_SPARC64
+
 static __always_inline
 long clock_gettime_fallback(clockid_t clock, struct __kernel_timespec *ts)
 {
@@ -113,7 +115,20 @@ long clock_gettime_fallback(clockid_t clock, struct __kernel_timespec *ts)
 	return o0;
 }
 
-#ifndef CONFIG_SPARC64
+#else /* !CONFIG_SPARC64 */
+
+static __always_inline
+long clock_gettime_fallback(clockid_t clock, struct __kernel_timespec *ts)
+{
+	register long num __asm__("g1") = __NR_clock_gettime64;
+	register long o0 __asm__("o0") = clock;
+	register long o1 __asm__("o1") = (long) ts;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+
 static __always_inline
 long clock_gettime32_fallback(clockid_t clock, struct old_timespec32 *ts)
 {
@@ -125,7 +140,8 @@ long clock_gettime32_fallback(clockid_t clock, struct old_timespec32 *ts)
 			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
 	return o0;
 }
-#endif
+
+#endif /* CONFIG_SPARC64 */
 
 static __always_inline
 long gettimeofday_fallback(struct __kernel_old_timeval *tv, struct timezone *tz)
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 093a7ff4dafce1cf0af5af4c303bef86e159858a..1d9859392e4cfd285349cf9155ca1fc25d3a7b41 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -48,4 +48,12 @@ int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 int clock_gettime(clockid_t, struct old_timespec32 *)
 	__weak __alias(__vdso_clock_gettime);
 
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int clock_gettime64(clockid_t, struct __kernel_timespec *)
+	__weak __alias(__vdso_clock_gettime64);
+
 #endif
diff --git a/arch/sparc/vdso/vdso32/vdso32.lds.S b/arch/sparc/vdso/vdso32/vdso32.lds.S
index 53575ee154c492f9503efdd8f995ac2a035203c7..a14e4f77e6f2222b855df27cc7a0d0a4f98bd4ac 100644
--- a/arch/sparc/vdso/vdso32/vdso32.lds.S
+++ b/arch/sparc/vdso/vdso32/vdso32.lds.S
@@ -17,6 +17,8 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
+		clock_gettime64;
+		__vdso_clock_gettime64;
 		gettimeofday;
 		__vdso_gettimeofday;
 	local: *;

-- 
2.51.0


