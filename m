Return-Path: <linux-kselftest+bounces-33574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA5FAC1B68
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A4D57A19FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A5271459;
	Fri, 23 May 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV5smsW4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191E25C71A;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975182; cv=none; b=tlk27HtkGJ7yi4j7c+TLSGLJ3QHdFJIKL/bybfSyZIDn2d/hytE3igF29vYX52f/dz+e+3H9pKk1NLNIOXatkZymkX9mFe76CljIzDva/AmMnsrBFRH3NqlpQZAIFlW7RASPSZpRBmrk7huvp3qhBFEDIGJ7vN2TYEYTykNpFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975182; c=relaxed/simple;
	bh=iIpy4amE1B5BG/MZ7yXJlvvMYB45pyKPopqbUBpww1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HsxDAwvOtPWQh9R7Daj7xhqChleNM45vC+J3CDPBKPYtf7K3NBbV3g/RLVnRJH4IB6I6FY7aH6dv44KKd7xiqIkAGrYxEgSWLLkvnOJav7K0HymSI8i5cZg/qtu0woKN9H3GfBezZqdpP1tE85jrFxc0yr1mGr/vuQ9gzg48FFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HV5smsW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AFFC4CEF7;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975181;
	bh=iIpy4amE1B5BG/MZ7yXJlvvMYB45pyKPopqbUBpww1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HV5smsW43Wblu3m/90Z637zq9GffyBGUQm2lcmxUfUaR4zx1tdFjg1IjBqTG1DSkY
	 WEc692tI4XPAArmlbU5ttf0ws3mGJ3n5WGEPBjCDQd1zpB7O2Qk+muLgGDg/AjoyRH
	 pHwV/rss0oksLyip+O+6bxr2uBHEA0KnenL/hBRpM5/zt0Vf86uDjR9hrsYTFhxONV
	 Y5DuYaBXSlULt7Sjin5UKE5ok0tFkNc+Yr8kPcVVChr4jWfJ6jlSH4RL2qtd03lBiw
	 /GiRIjYMDHZiO+8lBSUiysUXMFIK7BDjrbWbrnItcAgxNL4FI1C+4YKBbM47WE+vjz
	 LZlja9YXJ7h4g==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	loongarch@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 10/14] loongarch: Handle KCOV __init vs inline mismatches
Date: Thu, 22 May 2025 21:39:20 -0700
Message-Id: <20250523043935.2009972-10-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523043251.it.550-kees@kernel.org>
References: <20250523043251.it.550-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2628; i=kees@kernel.org; h=from:subject; bh=iIpy4amE1B5BG/MZ7yXJlvvMYB45pyKPopqbUBpww1w=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6v3+VfPjOsGqOxm/1bvmH5mG/Ft0U++yRurxzx1V/U zZvk/rWjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAyAQ35zcDFKQATaW1g+Ml48vdNhQVZP3ef 1vDeKb/8WEj5y1q51xFz4zb0fft1+b4Pwz+7by/d73JzG/y39znK9F1H85Za25GAJ4ue8zB4rrl /awETAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When KCOV is enabled all functions get instrumented, unless
the __no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions, we have to
handle differences in how GCC's inline optimizations get resolved. For
loongarch this exposed several places where __init annotations were
missing but ended up being "accidentally correct". Fix these cases and
force one function to be inline with __always_inline.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: <loongarch@lists.linux.dev>
---
 arch/loongarch/include/asm/smp.h | 2 +-
 arch/loongarch/kernel/time.c     | 2 +-
 arch/loongarch/mm/ioremap.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index ad0bd234a0f1..88e19d8a11f4 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -39,7 +39,7 @@ int loongson_cpu_disable(void);
 void loongson_cpu_die(unsigned int cpu);
 #endif
 
-static inline void plat_smp_setup(void)
+static __always_inline void plat_smp_setup(void)
 {
 	loongson_smp_setup();
 }
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index bc75a3a69fc8..367906b10f81 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -102,7 +102,7 @@ static int constant_timer_next_event(unsigned long delta, struct clock_event_dev
 	return 0;
 }
 
-static unsigned long __init get_loops_per_jiffy(void)
+static unsigned long get_loops_per_jiffy(void)
 {
 	unsigned long lpj = (unsigned long)const_clock_freq;
 
diff --git a/arch/loongarch/mm/ioremap.c b/arch/loongarch/mm/ioremap.c
index 70ca73019811..df949a3d0f34 100644
--- a/arch/loongarch/mm/ioremap.c
+++ b/arch/loongarch/mm/ioremap.c
@@ -16,12 +16,12 @@ void __init early_iounmap(void __iomem *addr, unsigned long size)
 
 }
 
-void *early_memremap_ro(resource_size_t phys_addr, unsigned long size)
+void * __init early_memremap_ro(resource_size_t phys_addr, unsigned long size)
 {
 	return early_memremap(phys_addr, size);
 }
 
-void *early_memremap_prot(resource_size_t phys_addr, unsigned long size,
+void * __init early_memremap_prot(resource_size_t phys_addr, unsigned long size,
 		    unsigned long prot_val)
 {
 	return early_memremap(phys_addr, size);
-- 
2.34.1


