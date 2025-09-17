Return-Path: <linux-kselftest+bounces-41716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0BB7FDD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0B3545163
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848292EE608;
	Wed, 17 Sep 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l6CZrt3m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZSQ43HTk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B72EC081;
	Wed, 17 Sep 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117740; cv=none; b=J71pGMf9etVTaQmICQCzENvkKt/mktv0aqRiJmli8AiWV3GWMuRY7du26WXyqeNzMxVqDSvDMSOjNmOlP2/QJA4la2Aa1P9Rq0j5Pokjh/y6GHgjNhUVuBGwUOkWvsxavYdH0dIfdL3Rf+ozn5okdc//6MikW225bnhhGB+zjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117740; c=relaxed/simple;
	bh=QuvYyH7tg7ricAibVz21CQKEZ7poFH7t7TCI4sCE65g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGqdvNUiBz6w9j5IQ727AjynZM6xGablYCgXVwHyiVH/ISsHwnhS5QAMSblfpp2A1FPlVxQlb0mYUQqmIko4NOpWnRx+dB+KQGCRAFvsX3zZVGBChZCyMrX43mu8pRytqqMu3Amafe2c7xHpAtgSRFMlxu7Mi3bI2HTbH1s6nVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l6CZrt3m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZSQ43HTk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suvqYi7Eu2JdAj7tYa8WTDy2PVdaNF+ln8JKAwtH8xQ=;
	b=l6CZrt3mnOqHbyA1WnTplf8msmo7gFEPPS97FEUD+KlVHXHYFfINOVevXdA51GZABMgMNA
	4L1F3bwZRZcNxEwBWLwUvS70v3Up6+g1EKAOrefBsHeobwoDz+7sGfWc93RH4nrJtVqoNh
	a0XkG/B+3yPsMUdmpIiivAbZhHcKXMG0J3Y4IuwMLiN3E8+tQ1GzYHharSUqvk++jzV9Jz
	LzP5lSEHEbwr6DWZk5FQH1Q5ud59siGQ6CEG/D3rfLdJ+FL2xIewDyfjNnJ+miMSPWYetX
	kuB7Oq0V41+XreTUZknuEVIgi8VlfwvchC7y1Usj1GoH34jUM/F+fQQl5Ku0mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suvqYi7Eu2JdAj7tYa8WTDy2PVdaNF+ln8JKAwtH8xQ=;
	b=ZSQ43HTkVQ5+vgm7v3N7BTaiCwJneqVWn1QBhcYIOxmQwRAp7xKJ8LOrwKXGlEHkrHNmqW
	97vg65aooEhsIHDw==
Date: Wed, 17 Sep 2025 16:00:29 +0200
Subject: [PATCH v3 27/36] sparc64: vdso: Replace code patching with runtime
 conditional
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-27-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=11901;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QuvYyH7tg7ricAibVz21CQKEZ7poFH7t7TCI4sCE65g=;
 b=29aTe3V1FEMhfA/jKmZFPOJqs+8Ll9AuYwdFe4/5NhKEdR3kpzajudcEscptnk+0HAzINPdbp
 NqXPjGmVqYOAoECvGOuot9wK0911QjR4KXjPPsKmXlYxQYEovY6KMYG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The patching logic is unnecessarily complicated and stands in the way of
the adoption of the generic vDSO framework.

Replace it by a simple runtime switch, similar to other architectures.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87ecu9tfhw.ffs@tglx/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/vclock_gettime.c    | 112 +-------------------
 arch/sparc/vdso/vdso.lds.S          |   2 -
 arch/sparc/vdso/vdso32/vdso32.lds.S |   2 -
 arch/sparc/vdso/vma.c               | 204 ------------------------------------
 4 files changed, 4 insertions(+), 316 deletions(-)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 79607804ea1b0f321215a9c4b5ead1edeb912e64..643608bffe13d904c5f77edd585b2e58277491fb 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -148,17 +148,11 @@ notrace static __always_inline u64 vgetsns(struct vvar_data *vvar)
 	u64 v;
 	u64 cycles;
 
-	cycles = vread_tick();
-	v = (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
-	return v * vvar->clock.mult;
-}
-
-notrace static __always_inline u64 vgetsns_stick(struct vvar_data *vvar)
-{
-	u64 v;
-	u64 cycles;
+	if (likely(vvar->vclock_mode == VCLOCK_STICK))
+		cycles = vread_tick_stick();
+	else
+		cycles = vread_tick();
 
-	cycles = vread_tick_stick();
 	v = (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
 	return v * vvar->clock.mult;
 }
@@ -183,26 +177,6 @@ notrace static __always_inline int do_realtime(struct vvar_data *vvar,
 	return 0;
 }
 
-notrace static __always_inline int do_realtime_stick(struct vvar_data *vvar,
-						     struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-	u64 ns;
-
-	do {
-		seq = vvar_read_begin(vvar);
-		ts->tv_sec = vvar->wall_time_sec;
-		ns = vvar->wall_time_snsec;
-		ns += vgetsns_stick(vvar);
-		ns = __shr64(ns, vvar->clock.shift);
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
-
 notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
 						struct __kernel_old_timespec *ts)
 {
@@ -223,26 +197,6 @@ notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
 	return 0;
 }
 
-notrace static __always_inline int do_monotonic_stick(struct vvar_data *vvar,
-						      struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-	u64 ns;
-
-	do {
-		seq = vvar_read_begin(vvar);
-		ts->tv_sec = vvar->monotonic_time_sec;
-		ns = vvar->monotonic_time_snsec;
-		ns += vgetsns_stick(vvar);
-		ns = __shr64(ns, vvar->clock.shift);
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
-
 notrace static int do_realtime_coarse(struct vvar_data *vvar,
 				      struct __kernel_old_timespec *ts)
 {
@@ -298,31 +252,6 @@ int
 clock_gettime(clockid_t, struct __kernel_old_timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-notrace int
-__vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_timespec *ts)
-{
-	struct vvar_data *vvd = get_vvar_data();
-
-	switch (clock) {
-	case CLOCK_REALTIME:
-		if (unlikely(vvd->vclock_mode == VCLOCK_NONE))
-			break;
-		return do_realtime_stick(vvd, ts);
-	case CLOCK_MONOTONIC:
-		if (unlikely(vvd->vclock_mode == VCLOCK_NONE))
-			break;
-		return do_monotonic_stick(vvd, ts);
-	case CLOCK_REALTIME_COARSE:
-		return do_realtime_coarse(vvd, ts);
-	case CLOCK_MONOTONIC_COARSE:
-		return do_monotonic_coarse(vvd, ts);
-	}
-	/*
-	 * Unknown clock ID ? Fall back to the syscall.
-	 */
-	return vdso_fallback_gettime(clock, ts);
-}
-
 notrace int
 __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
@@ -358,36 +287,3 @@ __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 int
 gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
-
-notrace int
-__vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *tz)
-{
-	struct vvar_data *vvd = get_vvar_data();
-
-	if (likely(vvd->vclock_mode != VCLOCK_NONE)) {
-		if (likely(tv != NULL)) {
-			union tstv_t {
-				struct __kernel_old_timespec ts;
-				struct __kernel_old_timeval tv;
-			} *tstv = (union tstv_t *) tv;
-			do_realtime_stick(vvd, &tstv->ts);
-			/*
-			 * Assign before dividing to ensure that the division is
-			 * done in the type of tv_usec, not tv_nsec.
-			 *
-			 * There cannot be > 1 billion usec in a second:
-			 * do_realtime() has already distributed such overflow
-			 * into tv_sec.  So we can assign it to an int safely.
-			 */
-			tstv->tv.tv_usec = tstv->ts.tv_nsec;
-			tstv->tv.tv_usec /= 1000;
-		}
-		if (unlikely(tz != NULL)) {
-			/* Avoid memcpy. Some old compilers fail to inline it */
-			tz->tz_minuteswest = vvd->tz_minuteswest;
-			tz->tz_dsttime = vvd->tz_dsttime;
-		}
-		return 0;
-	}
-	return vdso_fallback_gettimeofday(tv, tz);
-}
diff --git a/arch/sparc/vdso/vdso.lds.S b/arch/sparc/vdso/vdso.lds.S
index 629ab6900df7156fc18b450dc3bbfba1bbd20e65..f3caa29a331c58175b67ea60d7ac15cd467fe5ff 100644
--- a/arch/sparc/vdso/vdso.lds.S
+++ b/arch/sparc/vdso/vdso.lds.S
@@ -18,10 +18,8 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
-		__vdso_clock_gettime_stick;
 		gettimeofday;
 		__vdso_gettimeofday;
-		__vdso_gettimeofday_stick;
 	local: *;
 	};
 }
diff --git a/arch/sparc/vdso/vdso32/vdso32.lds.S b/arch/sparc/vdso/vdso32/vdso32.lds.S
index 218930fdff03d598d74a991657c109c3b15ce752..53575ee154c492f9503efdd8f995ac2a035203c7 100644
--- a/arch/sparc/vdso/vdso32/vdso32.lds.S
+++ b/arch/sparc/vdso/vdso32/vdso32.lds.S
@@ -17,10 +17,8 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
-		__vdso_clock_gettime_stick;
 		gettimeofday;
 		__vdso_gettimeofday;
-		__vdso_gettimeofday_stick;
 	local: *;
 	};
 }
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index bab7a59575e882d911c5d1b0903f45cec353aef0..582d84e2e5ba8932f39948bb0ca2678fc8f06a10 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -42,203 +42,6 @@ static struct vm_special_mapping vdso_mapping32 = {
 
 struct vvar_data *vvar_data;
 
-struct vdso_elfinfo32 {
-	Elf32_Ehdr	*hdr;
-	Elf32_Sym	*dynsym;
-	unsigned long	dynsymsize;
-	const char	*dynstr;
-	unsigned long	text;
-};
-
-struct vdso_elfinfo64 {
-	Elf64_Ehdr	*hdr;
-	Elf64_Sym	*dynsym;
-	unsigned long	dynsymsize;
-	const char	*dynstr;
-	unsigned long	text;
-};
-
-struct vdso_elfinfo {
-	union {
-		struct vdso_elfinfo32 elf32;
-		struct vdso_elfinfo64 elf64;
-	} u;
-};
-
-static void *one_section64(struct vdso_elfinfo64 *e, const char *name,
-			   unsigned long *size)
-{
-	const char *snames;
-	Elf64_Shdr *shdrs;
-	unsigned int i;
-
-	shdrs = (void *)e->hdr + e->hdr->e_shoff;
-	snames = (void *)e->hdr + shdrs[e->hdr->e_shstrndx].sh_offset;
-	for (i = 1; i < e->hdr->e_shnum; i++) {
-		if (!strcmp(snames+shdrs[i].sh_name, name)) {
-			if (size)
-				*size = shdrs[i].sh_size;
-			return (void *)e->hdr + shdrs[i].sh_offset;
-		}
-	}
-	return NULL;
-}
-
-static int find_sections64(const struct vdso_image *image, struct vdso_elfinfo *_e)
-{
-	struct vdso_elfinfo64 *e = &_e->u.elf64;
-
-	e->hdr = image->data;
-	e->dynsym = one_section64(e, ".dynsym", &e->dynsymsize);
-	e->dynstr = one_section64(e, ".dynstr", NULL);
-
-	if (!e->dynsym || !e->dynstr) {
-		pr_err("VDSO64: Missing symbol sections.\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-static Elf64_Sym *find_sym64(const struct vdso_elfinfo64 *e, const char *name)
-{
-	unsigned int i;
-
-	for (i = 0; i < (e->dynsymsize / sizeof(Elf64_Sym)); i++) {
-		Elf64_Sym *s = &e->dynsym[i];
-		if (s->st_name == 0)
-			continue;
-		if (!strcmp(e->dynstr + s->st_name, name))
-			return s;
-	}
-	return NULL;
-}
-
-static int patchsym64(struct vdso_elfinfo *_e, const char *orig,
-		      const char *new)
-{
-	struct vdso_elfinfo64 *e = &_e->u.elf64;
-	Elf64_Sym *osym = find_sym64(e, orig);
-	Elf64_Sym *nsym = find_sym64(e, new);
-
-	if (!nsym || !osym) {
-		pr_err("VDSO64: Missing symbols.\n");
-		return -ENODEV;
-	}
-	osym->st_value = nsym->st_value;
-	osym->st_size = nsym->st_size;
-	osym->st_info = nsym->st_info;
-	osym->st_other = nsym->st_other;
-	osym->st_shndx = nsym->st_shndx;
-
-	return 0;
-}
-
-static void *one_section32(struct vdso_elfinfo32 *e, const char *name,
-			   unsigned long *size)
-{
-	const char *snames;
-	Elf32_Shdr *shdrs;
-	unsigned int i;
-
-	shdrs = (void *)e->hdr + e->hdr->e_shoff;
-	snames = (void *)e->hdr + shdrs[e->hdr->e_shstrndx].sh_offset;
-	for (i = 1; i < e->hdr->e_shnum; i++) {
-		if (!strcmp(snames+shdrs[i].sh_name, name)) {
-			if (size)
-				*size = shdrs[i].sh_size;
-			return (void *)e->hdr + shdrs[i].sh_offset;
-		}
-	}
-	return NULL;
-}
-
-static int find_sections32(const struct vdso_image *image, struct vdso_elfinfo *_e)
-{
-	struct vdso_elfinfo32 *e = &_e->u.elf32;
-
-	e->hdr = image->data;
-	e->dynsym = one_section32(e, ".dynsym", &e->dynsymsize);
-	e->dynstr = one_section32(e, ".dynstr", NULL);
-
-	if (!e->dynsym || !e->dynstr) {
-		pr_err("VDSO32: Missing symbol sections.\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-static Elf32_Sym *find_sym32(const struct vdso_elfinfo32 *e, const char *name)
-{
-	unsigned int i;
-
-	for (i = 0; i < (e->dynsymsize / sizeof(Elf32_Sym)); i++) {
-		Elf32_Sym *s = &e->dynsym[i];
-		if (s->st_name == 0)
-			continue;
-		if (!strcmp(e->dynstr + s->st_name, name))
-			return s;
-	}
-	return NULL;
-}
-
-static int patchsym32(struct vdso_elfinfo *_e, const char *orig,
-		      const char *new)
-{
-	struct vdso_elfinfo32 *e = &_e->u.elf32;
-	Elf32_Sym *osym = find_sym32(e, orig);
-	Elf32_Sym *nsym = find_sym32(e, new);
-
-	if (!nsym || !osym) {
-		pr_err("VDSO32: Missing symbols.\n");
-		return -ENODEV;
-	}
-	osym->st_value = nsym->st_value;
-	osym->st_size = nsym->st_size;
-	osym->st_info = nsym->st_info;
-	osym->st_other = nsym->st_other;
-	osym->st_shndx = nsym->st_shndx;
-
-	return 0;
-}
-
-static int find_sections(const struct vdso_image *image, struct vdso_elfinfo *e,
-			 bool elf64)
-{
-	if (elf64)
-		return find_sections64(image, e);
-	else
-		return find_sections32(image, e);
-}
-
-static int patch_one_symbol(struct vdso_elfinfo *e, const char *orig,
-			    const char *new_target, bool elf64)
-{
-	if (elf64)
-		return patchsym64(e, orig, new_target);
-	else
-		return patchsym32(e, orig, new_target);
-}
-
-static int stick_patch(const struct vdso_image *image, struct vdso_elfinfo *e, bool elf64)
-{
-	int err;
-
-	err = find_sections(image, e, elf64);
-	if (err)
-		return err;
-
-	err = patch_one_symbol(e,
-			       "__vdso_gettimeofday",
-			       "__vdso_gettimeofday_stick", elf64);
-	if (err)
-		return err;
-
-	return patch_one_symbol(e,
-				"__vdso_clock_gettime",
-				"__vdso_clock_gettime_stick", elf64);
-	return 0;
-}
-
 /*
  * Allocate pages for the vdso and vvar, and copy in the vdso text from the
  * kernel image.
@@ -250,15 +53,8 @@ static int __init init_vdso_image(const struct vdso_image *image,
 	int cnpages = (image->size) / PAGE_SIZE;
 	struct page *dp, **dpp = NULL;
 	struct page *cp, **cpp = NULL;
-	struct vdso_elfinfo ei;
 	int i, dnpages = 0;
 
-	if (tlb_type != spitfire) {
-		int err = stick_patch(image, &ei, elf64);
-		if (err)
-			return err;
-	}
-
 	/*
 	 * First, the vdso text.  This is initialied data, an integral number of
 	 * pages long.

-- 
2.51.0


