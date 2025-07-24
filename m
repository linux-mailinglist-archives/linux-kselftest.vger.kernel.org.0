Return-Path: <linux-kselftest+bounces-37924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D75B100A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C10188D193
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8758124DCEC;
	Thu, 24 Jul 2025 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hoHPxti6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hv4wH9T/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAAF231A55;
	Thu, 24 Jul 2025 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338445; cv=none; b=LLTHuVLd3y6uNDczVtkK7KbPnyHh5MUBL7X4m7IkJX/PsZNiZARV6ySYs3qbLXNJiiZ8XFuIEln4oQIZEOKY/vIbJDl2ggxyoGerCV+MHsm+HFiQJOfmaQoUJCg6s1A88kZjrO12sw+MGLmbsDnck6pYRPs+LBR0vV+DD5oSX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338445; c=relaxed/simple;
	bh=Ngyyb+Tb2Eq2g4xCY2ap8PjPAMUoe2Wil/Ab9l88uDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qw2xeSTkGj4WsjyVE0Dh5wx7Df52gNjoJy5S0QhWaehkCRSbBAB3aHQnjHWZ/0IZ314gRtrhl7568iy+L/h8DHFkLKzlx5B9/5tTqrKpIuG2ORa1RfHv6L5StzG1xv7I+MGHGS97R6CuRfthDRexIft5QdCV+sc7Jz75nPakEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hoHPxti6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hv4wH9T/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753338441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDoH1wg/PXmaaRjwmjbwG1Ox0g1S4AGQYYgSu/bm36Q=;
	b=hoHPxti6xWghs/4iSPakHAhs5ytl5mu5e3AUvT5E+goq4jw5taN8SRJYIdjmFb+NuBFAPG
	+bdpF/hmQRKpMOJDnvEpFny6Av+nXpYLiYbKkRok9+ouLkQQqxqQ2gjNtJl+TTu8uAAh5w
	o6OZchOyL/vOJKPn62BfJFblb6NZ9enIo2Frexhdi4MCOS1BuLs0Ss43MABOyhPe4vljKf
	7M/Ryi+N0ru060+UDyAFzAP57ARaVWIlw198Dhr8/+j6asioax8YDAAVMdtKQkgDvRw9F+
	ppycfknKnP5n+GGFfrvTV05msmML/SF/7fWwycuEp2ACZNPd3TuEAiKm/OyPRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753338441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDoH1wg/PXmaaRjwmjbwG1Ox0g1S4AGQYYgSu/bm36Q=;
	b=hv4wH9T/7rTYUuBJ8Cn+fXg9HK336y8Cl5fmiLv7ZAjG4RrKejqCJLeSxSfJ6fvqCuLEGQ
	QMciuRTZGyiKNjDQ==
Date: Thu, 24 Jul 2025 08:27:04 +0200
Subject: [PATCH RFC 14/14] sparc64: vdso: Implement clock_getres()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-vdso-sparc64-generic-2-v1-14-e376a3bd24d1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753338429; l=4460;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Ngyyb+Tb2Eq2g4xCY2ap8PjPAMUoe2Wil/Ab9l88uDQ=;
 b=Wr0CvII1bGW5SRNtGmC5x73uJkqoTveXSmCV2xzurSitnGs43Ir5aJ5Pn9mQx7POoAq6EQI62
 M+1YS7TDRZaD5J5hqXBRw3Re4pba/byoypPSg3jIUpmJN7QDFxg3Ox0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add a vDSO fastpath for clock_getres().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/include/asm/vdso/gettimeofday.h | 42 +++++++++++++++++++++++++++++-
 arch/sparc/vdso/vclock_gettime.c           | 16 ++++++++++++
 arch/sparc/vdso/vdso.lds.S                 |  2 ++
 arch/sparc/vdso/vdso32/vdso32.lds.S        |  2 ++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/vdso/gettimeofday.h b/arch/sparc/include/asm/vdso/gettimeofday.h
index a35875fba45470ba961a7df3ae52bc17d2a4a4a0..ccd2bda0a0c42ec826eb0464b7a41f98b4cea993 100644
--- a/arch/sparc/include/asm/vdso/gettimeofday.h
+++ b/arch/sparc/include/asm/vdso/gettimeofday.h
@@ -16,6 +16,8 @@
 
 #include <linux/types.h>
 
+#define VDSO_HAS_CLOCK_GETRES		1
+
 #ifdef	CONFIG_SPARC64
 static __always_inline u64 vread_tick(void)
 {
@@ -125,7 +127,45 @@ long clock_gettime32_fallback(clockid_t clock, struct old_timespec32 *ts)
 			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
 	return o0;
 }
-#endif
+
+static __always_inline
+long clock_getres_fallback(clockid_t clock, struct __kernel_timespec *ts)
+{
+	register long num __asm__("g1") = __NR_clock_getres_time64;
+	register long o0 __asm__("o0") = clock;
+	register long o1 __asm__("o1") = (long) ts;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+
+static __always_inline
+long clock_getres32_fallback(clockid_t clock, struct old_timespec32 *ts)
+{
+	register long num __asm__("g1") = __NR_clock_getres;
+	register long o0 __asm__("o0") = clock;
+	register long o1 __asm__("o1") = (long) ts;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+#else /* !CONFIG_SPARC64 */
+
+static __always_inline
+long clock_getres_fallback(clockid_t clock, struct __kernel_timespec *ts)
+{
+	register long num __asm__("g1") = __NR_clock_getres;
+	register long o0 __asm__("o0") = clock;
+	register long o1 __asm__("o1") = (long) ts;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+
+#endif /* CONFIG_SPARC64 */
 
 static __always_inline
 long gettimeofday_fallback(struct __kernel_old_timeval *tv, struct timezone *tz)
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 1d9859392e4cfd285349cf9155ca1fc25d3a7b41..3cadf94e6cee5392586755e97f629092d4bcab1e 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -38,6 +38,14 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 int clock_gettime(clockid_t, struct __kernel_timespec *)
 	__weak __alias(__vdso_clock_gettime);
 
+int __vdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock, res);
+}
+
+int clock_getres(clockid_t, struct __kernel_timespec *)
+	__weak __alias(__vdso_clock_getres);
+
 #else
 
 int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
@@ -56,4 +64,12 @@ int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
 int clock_gettime64(clockid_t, struct __kernel_timespec *)
 	__weak __alias(__vdso_clock_gettime64);
 
+int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock, res);
+}
+
+int clock_getres(clockid_t, struct old_timespec32 *)
+	__weak __alias(__vdso_clock_getres);
+
 #endif
diff --git a/arch/sparc/vdso/vdso.lds.S b/arch/sparc/vdso/vdso.lds.S
index f3caa29a331c58175b67ea60d7ac15cd467fe5ff..67c64a3adfa94f61356ce11081df442c18d6d8d5 100644
--- a/arch/sparc/vdso/vdso.lds.S
+++ b/arch/sparc/vdso/vdso.lds.S
@@ -20,6 +20,8 @@ VERSION {
 		__vdso_clock_gettime;
 		gettimeofday;
 		__vdso_gettimeofday;
+		clock_getres;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/sparc/vdso/vdso32/vdso32.lds.S b/arch/sparc/vdso/vdso32/vdso32.lds.S
index a14e4f77e6f2222b855df27cc7a0d0a4f98bd4ac..d09b1893ee1411f450df935335e6fe8d8c8b2632 100644
--- a/arch/sparc/vdso/vdso32/vdso32.lds.S
+++ b/arch/sparc/vdso/vdso32/vdso32.lds.S
@@ -21,6 +21,8 @@ VERSION {
 		__vdso_clock_gettime64;
 		gettimeofday;
 		__vdso_gettimeofday;
+		clock_getres;
+		__vdso_clock_getres;
 	local: *;
 	};
 }

-- 
2.50.1


