Return-Path: <linux-kselftest+bounces-33572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1F4AC1B78
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784D9A42DBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870F2701D6;
	Fri, 23 May 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUwE0i0m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDEB2566FC;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975182; cv=none; b=bd3LfDMxjnf+C2vevDyX8c205WigWUWYbwgAwVMhsIVr4tLtht4591nGEijQ1TFCNkB6MaoKsMN59cediP8wQgEA5bJFluNcVpq4cKK2rg45E18uEHy9blvuALCePdXw8DKc+/WSi1cT3i7QkuQhZImJR/xELO56Y1n0Tf5M//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975182; c=relaxed/simple;
	bh=ukIvmUzCX4cqw7NZIKavKwcJ5OLiJ4po8qig+DsNSjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ta1ZM/OJ/sRxDYwVI42jhPqmSGuGbKOAYr1xCxNPgwzI29CPMU0YXRSgEa/hKTYP5NCfDv4SZDSygdhLcCtqVfSemaNTRsjpJYxn0YbB97Tejdv1YM3xrw4Rndq4raTA5X2p1vOY0Yqk2BeofRot1KcVPoRD3+um/h/02miXSyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUwE0i0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420A4C4CEF3;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975181;
	bh=ukIvmUzCX4cqw7NZIKavKwcJ5OLiJ4po8qig+DsNSjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUwE0i0mzO0Zz+j7Us+A/yzvLL8wesT1b29aGk+XzYhm3jnxB0QmFL1bW3NDq2VBF
	 mM/v6TzQA3enBRrrnZE8Gxfnke3DBVYhp8AJ54Jc49RzwDSVZJ2g2twPNnbe9bKjny
	 WgMEbYki7U05FMp8iUIvdHvsYvY8fEkcjZxwO6cTEVw5NeusAprtjcombRsjl98E56
	 Z7OsPJA2T4UOircixEEDM0HVPN8rL+TqdWgfWY8HXgPYU27uI1LsGRnihkuFz2JiQ1
	 qTyO+NKnSW1jgPs/kwVYKXqqXGF2jO1cR+P0Cx0S7RMCBY+Zt1y19Z/2Tf8HdBUg5d
	 55EgoqgS825Zg==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Allison Randal <allison@lohutok.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v2 05/14] arm: Handle KCOV __init vs inline mismatches
Date: Thu, 22 May 2025 21:39:15 -0700
Message-Id: <20250523043935.2009972-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523043251.it.550-kees@kernel.org>
References: <20250523043251.it.550-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3494; i=kees@kernel.org; h=from:subject; bh=ukIvmUzCX4cqw7NZIKavKwcJ5OLiJ4po8qig+DsNSjY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6v3/+eOy6cc/2RIGpN/7obJr+t2bVlidcXIkfP8xQ1 a3nOnpNqKOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAiy0QYGTon/Tmgw7nhdvo/ wRdnq6bd8LbuWrrlwoINcV8Xz6/XsQln+KeoVfztP/+eh4En7ucZ6kupZIYzLLs4sX6mv1rXt5y ayWwA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When KCOV is enabled all functions get instrumented, unless
the __no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions, we have to
handle differences in how GCC's inline optimizations get resolved. For
arm this exposed several places where __init annotations were missing
but ended up being "accidentally correct". Fix these cases and force
several functions to be inline with __always_inline.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Allison Randal <allison@lohutok.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 include/linux/mfd/dbx500-prcmu.h  | 2 +-
 arch/arm/mm/cache-feroceon-l2.c   | 2 +-
 arch/arm/mm/cache-tauros2.c       | 2 +-
 drivers/clocksource/timer-orion.c | 2 +-
 drivers/soc/ti/pm33xx.c           | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index 98567623c9df..828362b7860c 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -213,7 +213,7 @@ struct prcmu_fw_version {
 
 #if defined(CONFIG_UX500_SOC_DB8500)
 
-static inline void prcmu_early_init(void)
+static inline void __init prcmu_early_init(void)
 {
 	db8500_prcmu_early_init();
 }
diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 25dbd84a1aaf..2bfefb252ffd 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -295,7 +295,7 @@ static inline u32 read_extra_features(void)
 	return u;
 }
 
-static inline void write_extra_features(u32 u)
+static inline void __init write_extra_features(u32 u)
 {
 	__asm__("mcr p15, 1, %0, c15, c1, 0" : : "r" (u));
 }
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index b1e1aba602f7..bfe166ccace0 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -177,7 +177,7 @@ static inline void __init write_actlr(u32 actlr)
 	__asm__("mcr p15, 0, %0, c1, c0, 1\n" : : "r" (actlr));
 }
 
-static void enable_extra_feature(unsigned int features)
+static void __init enable_extra_feature(unsigned int features)
 {
 	u32 u;
 
diff --git a/drivers/clocksource/timer-orion.c b/drivers/clocksource/timer-orion.c
index 49e86cb70a7a..61f1e27fc41e 100644
--- a/drivers/clocksource/timer-orion.c
+++ b/drivers/clocksource/timer-orion.c
@@ -43,7 +43,7 @@ static struct delay_timer orion_delay_timer = {
 	.read_current_timer = orion_read_timer,
 };
 
-static void orion_delay_timer_init(unsigned long rate)
+static void __init orion_delay_timer_init(unsigned long rate)
 {
 	orion_delay_timer.freq = rate;
 	register_current_timer_delay(&orion_delay_timer);
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index dfdff186c805..dc52a2197d24 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -145,7 +145,7 @@ static int am33xx_do_sram_idle(u32 wfi_flags)
 	return pm_ops->cpu_suspend(am33xx_do_wfi_sram, wfi_flags);
 }
 
-static int __init am43xx_map_gic(void)
+static int am43xx_map_gic(void)
 {
 	gic_dist_base = ioremap(AM43XX_GIC_DIST_BASE, SZ_4K);
 
-- 
2.34.1


