Return-Path: <linux-kselftest+bounces-43103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD227BD7BDA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93AF44F6934
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47DA311963;
	Tue, 14 Oct 2025 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vOoxNAOI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XzDMbTmh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874831063B;
	Tue, 14 Oct 2025 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424572; cv=none; b=FlRlrnIcfMHy1k6ikhlqDbhYzK9sGjahEIgmsKP1ZuSkFNKM9TFFRJDLM3XlcYYI7R9aGTR8/Gjox8Qiv7Jn15e+IfQNov6uLsTqVxmapWzFGXk4CsJYh2m3ldXsdcF9JiLwmJR0ejAexPyQ8+fefG9wDP02mqdB9O48fc2mcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424572; c=relaxed/simple;
	bh=54fVsevF6wJL94FjT3o2LBMAQrSAU/5OtqL2hTA5L+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uLaWHm6W3hTNKjsR44TN0a5uy+sJ5lpjeW2AJkYBTJ1DTs8AkwUCnYH6owKZI9pk9WZJEW0UKYW3iMiX9ZonFr+o2bs6/EKJHbVA8JLfdC5r8XFcAxqQ3bepVJ9Y+T7BmPWlQgn/fn5CiSGsdOib6PoR3wXju2gaYMh5l3rWjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vOoxNAOI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XzDMbTmh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OR5Q4ZuRkIA741qF/DuLi5z3bNd2XCtlxY+P3oghy5c=;
	b=vOoxNAOIOkPtLK2Gs2EYlcx/T6V88XBROauQuxOTsSOXMK+Y6kzwIhvy3/jWrpuW1S5lPL
	KBWnjfyE/3pB1N3+E4p2688vm8zCGlXWQtVNJuwi6uhImcIWrYDEDnNPclgYn/zrMrtQD5
	A5SVuO0oGy/cG1FCJG1PZFdcYkEeVa8F7dUdCjNXAUHkfmW9OfEyCWK2cmK9jBh+O+owMN
	ZEK3i0NzNgFW1fqzXEyzFPnWYxtZgsrQeTAyOM8EFqvBlmR78Ix2og97ttYKm8IOe5Ko8r
	56SV0Si0lDhUd3A/tjT/8NOXC4la0FxXrcXaPBDI8x/+F9N+japSZF3p+b6RlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OR5Q4ZuRkIA741qF/DuLi5z3bNd2XCtlxY+P3oghy5c=;
	b=XzDMbTmhdTy1yfzkEoPt+uhA82Qn3qiMel7AQ2xO4ZQVzR0alYnKUK/WSBjO4f7wYsr5fh
	qGk1gFKLI1Lk2hBw==
Date: Tue, 14 Oct 2025 08:49:15 +0200
Subject: [PATCH v4 29/35] sparc64: vdso: Move syscall fallbacks into header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-29-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=5844;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=54fVsevF6wJL94FjT3o2LBMAQrSAU/5OtqL2hTA5L+g=;
 b=ZffNKFwKaA+stbCVpIgoFsS3FlacbBDVNHcY87CY59NC3DdJDgUnlHzLWFA4unTTem27rYS0G
 laK7Y+RNIFCDAfCFvkTo8l5vng9UhFy1zbfTZv61v/2XhG2a6rBz7jc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic vDSO libraries expected the syscall fallbacks in
asm/vdso/gettimeofday.h. To prepare the adoption of the generic library,
move the existing functions there.

While at it, rename them so they match what the generic library expects.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/vdso/gettimeofday.h | 50 +++++++++++++++++++++++++++++
 arch/sparc/vdso/vclock_gettime.c           | 51 ++----------------------------
 2 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/arch/sparc/include/asm/vdso/gettimeofday.h b/arch/sparc/include/asm/vdso/gettimeofday.h
index 31f6505d3ab5dde9e02eca6da9182e5fb91031c4..429dc080568f59145cc0bc696060adeb60ac177a 100644
--- a/arch/sparc/include/asm/vdso/gettimeofday.h
+++ b/arch/sparc/include/asm/vdso/gettimeofday.h
@@ -6,6 +6,9 @@
 #ifndef _ASM_SPARC_VDSO_GETTIMEOFDAY_H
 #define _ASM_SPARC_VDSO_GETTIMEOFDAY_H
 
+#include <uapi/linux/time.h>
+#include <uapi/linux/unistd.h>
+
 #include <linux/types.h>
 #include <asm/vvar.h>
 
@@ -75,4 +78,51 @@ static __always_inline u64 __arch_get_hw_counter(struct vvar_data *vvar)
 		return vread_tick();
 }
 
+#ifdef	CONFIG_SPARC64
+#define SYSCALL_STRING							\
+	"ta	0x6d;"							\
+	"bcs,a	1f;"							\
+	" sub	%%g0, %%o0, %%o0;"					\
+	"1:"
+#else
+#define SYSCALL_STRING							\
+	"ta	0x10;"							\
+	"bcs,a	1f;"							\
+	" sub	%%g0, %%o0, %%o0;"					\
+	"1:"
+#endif
+
+#define SYSCALL_CLOBBERS						\
+	"f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",			\
+	"f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",		\
+	"f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",		\
+	"f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",		\
+	"f32", "f34", "f36", "f38", "f40", "f42", "f44", "f46",		\
+	"f48", "f50", "f52", "f54", "f56", "f58", "f60", "f62",		\
+	"cc", "memory"
+
+static __always_inline
+long clock_gettime_fallback(clockid_t clock, struct __kernel_old_timespec *ts)
+{
+	register long num __asm__("g1") = __NR_clock_gettime;
+	register long o0 __asm__("o0") = clock;
+	register long o1 __asm__("o1") = (long) ts;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+
+static __always_inline
+long gettimeofday_fallback(struct __kernel_old_timeval *tv, struct timezone *tz)
+{
+	register long num __asm__("g1") = __NR_gettimeofday;
+	register long o0 __asm__("o0") = (long) tv;
+	register long o1 __asm__("o1") = (long) tz;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+
 #endif /* _ASM_SPARC_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 16ac80982a00b9f965453b89a0cc111312baa9b2..e768c0b84b3420deab2f74335892d40a5b515ee7 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -13,38 +13,13 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/time.h>
 #include <linux/string.h>
 #include <asm/io.h>
-#include <asm/unistd.h>
 #include <asm/timex.h>
 #include <asm/clocksource.h>
 #include <asm/vdso/gettimeofday.h>
 #include <asm/vvar.h>
 
-#ifdef	CONFIG_SPARC64
-#define SYSCALL_STRING							\
-	"ta	0x6d;"							\
-	"bcs,a	1f;"							\
-	" sub	%%g0, %%o0, %%o0;"					\
-	"1:"
-#else
-#define SYSCALL_STRING							\
-	"ta	0x10;"							\
-	"bcs,a	1f;"							\
-	" sub	%%g0, %%o0, %%o0;"					\
-	"1:"
-#endif
-
-#define SYSCALL_CLOBBERS						\
-	"f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",			\
-	"f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",		\
-	"f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",		\
-	"f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",		\
-	"f32", "f34", "f36", "f38", "f40", "f42", "f44", "f46",		\
-	"f48", "f50", "f52", "f54", "f56", "f58", "f60", "f62",		\
-	"cc", "memory"
-
 /*
  * Compute the vvar page's address in the process address space, and return it
  * as a pointer to the vvar_data.
@@ -64,28 +39,6 @@ notrace static __always_inline struct vvar_data *get_vvar_data(void)
 	return (struct vvar_data *) ret;
 }
 
-notrace static long vdso_fallback_gettime(long clock, struct __kernel_old_timespec *ts)
-{
-	register long num __asm__("g1") = __NR_clock_gettime;
-	register long o0 __asm__("o0") = clock;
-	register long o1 __asm__("o1") = (long) ts;
-
-	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
-			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
-	return o0;
-}
-
-notrace static long vdso_fallback_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
-{
-	register long num __asm__("g1") = __NR_gettimeofday;
-	register long o0 __asm__("o0") = (long) tv;
-	register long o1 __asm__("o1") = (long) tz;
-
-	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
-			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
-	return o0;
-}
-
 notrace static __always_inline u64 vgetsns(struct vvar_data *vvar)
 {
 	u64 v;
@@ -184,7 +137,7 @@ __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 	/*
 	 * Unknown clock ID ? Fall back to the syscall.
 	 */
-	return vdso_fallback_gettime(clock, ts);
+	return clock_gettime_fallback(clock, ts);
 }
 int
 clock_gettime(clockid_t, struct __kernel_old_timespec *)
@@ -220,7 +173,7 @@ __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 		}
 		return 0;
 	}
-	return vdso_fallback_gettimeofday(tv, tz);
+	return gettimeofday_fallback(tv, tz);
 }
 int
 gettimeofday(struct __kernel_old_timeval *, struct timezone *)

-- 
2.51.0


