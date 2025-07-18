Return-Path: <linux-kselftest+bounces-37562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F4B0A4BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 15:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1C75A3762
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9ED2DBF78;
	Fri, 18 Jul 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSHIa+Mr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147282C08BB;
	Fri, 18 Jul 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843850; cv=none; b=otpCtaWkDSXuwpQGtfETqHzzMCHn7vpo30KQF9Um8eYWyqrj1hYJaMv5H8cfq306GrkZZ65aBgQG4PNLQt/27GTruAu0TacM87LNAjRW0JNP2AK8DoJ8cNqopGVUYLIBJ+3F4jOW7SoSh62ijBDHaZcBrptQpiEGxuwUDzLORYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843850; c=relaxed/simple;
	bh=e9JV0Z0iQk3JJlBwUijpHfs6OkBiHHnta1gSH+W9zOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4cNNy1iQbLnNATt4KxTKtj9IG2Zhl9rd7ci+oBA/SHW2T5SW4fUF4xQ8oImpC2R/jJY/aSudbc54c9gc/yZdvp/csqTaOBlRpxYLsJaHvtvBjWKZzexpC9hYBaOhIbZb/0NYFzgdmhdifAWo/C+Rcvk2rkl+0gR8vdX5/+Akbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSHIa+Mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E41C4CEEB;
	Fri, 18 Jul 2025 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752843849;
	bh=e9JV0Z0iQk3JJlBwUijpHfs6OkBiHHnta1gSH+W9zOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSHIa+MrlwXDsebHQMAOBrcdcgNNRuFu1OTjumS8fxdFBEiWA23QLsWePa1HP1jXa
	 DP7rD2arOXkIYe04ayLXrk6t48TKPhah+qrfUQk4ky4F4LbYRccQTgZL/kXp3nQJYB
	 nrJLucASNeNNY+00+8mINN6UNjKqm5BId8c4coJWxb2glH/Jf36YSDoPuBM+WSroOr
	 n4i8t1jm9SduQegLb6spa4A1/MFx1Gu+g8rrZJhbtALp3VA5PnisWIVkS3OfF1re3r
	 AMqmvtywhenvyRLdeSc0OM7qWEwqaMFUvF5JgNdpEgu+srMur2jwIhNPEyXJW5TR2q
	 5vV09+6vxMu3A==
Date: Fri, 18 Jul 2025 14:04:00 +0100
From: Lee Jones <lee@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Allison Randal <allison@lohutok.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 05/13] arm: Handle KCOV __init vs inline mismatches
Message-ID: <20250718130400.GB11056@google.com>
References: <20250717231756.make.423-kees@kernel.org>
 <20250717232519.2984886-5-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717232519.2984886-5-kees@kernel.org>

On Thu, 17 Jul 2025, Kees Cook wrote:

> When KCOV is enabled all functions get instrumented, unless
> the __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions, we have to
> handle differences in how GCC's inline optimizations get resolved. For
> arm this exposed several places where __init annotations were missing
> but ended up being "accidentally correct". Fix these cases and force
> several functions to be inline with __always_inline.
> 
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> ---
>  include/linux/mfd/dbx500-prcmu.h  | 2 +-

Acked-by: Lee Jones <lee@kernel.org>

>  arch/arm/mm/cache-feroceon-l2.c   | 2 +-
>  arch/arm/mm/cache-tauros2.c       | 2 +-
>  drivers/clocksource/timer-orion.c | 2 +-
>  drivers/soc/ti/pm33xx.c           | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
> index 98567623c9df..828362b7860c 100644
> --- a/include/linux/mfd/dbx500-prcmu.h
> +++ b/include/linux/mfd/dbx500-prcmu.h
> @@ -213,7 +213,7 @@ struct prcmu_fw_version {
>  
>  #if defined(CONFIG_UX500_SOC_DB8500)
>  
> -static inline void prcmu_early_init(void)
> +static inline void __init prcmu_early_init(void)
>  {
>  	db8500_prcmu_early_init();
>  }
> diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
> index 25dbd84a1aaf..2bfefb252ffd 100644
> --- a/arch/arm/mm/cache-feroceon-l2.c
> +++ b/arch/arm/mm/cache-feroceon-l2.c
> @@ -295,7 +295,7 @@ static inline u32 read_extra_features(void)
>  	return u;
>  }
>  
> -static inline void write_extra_features(u32 u)
> +static inline void __init write_extra_features(u32 u)
>  {
>  	__asm__("mcr p15, 1, %0, c15, c1, 0" : : "r" (u));
>  }
> diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
> index b1e1aba602f7..bfe166ccace0 100644
> --- a/arch/arm/mm/cache-tauros2.c
> +++ b/arch/arm/mm/cache-tauros2.c
> @@ -177,7 +177,7 @@ static inline void __init write_actlr(u32 actlr)
>  	__asm__("mcr p15, 0, %0, c1, c0, 1\n" : : "r" (actlr));
>  }
>  
> -static void enable_extra_feature(unsigned int features)
> +static void __init enable_extra_feature(unsigned int features)
>  {
>  	u32 u;
>  
> diff --git a/drivers/clocksource/timer-orion.c b/drivers/clocksource/timer-orion.c
> index 49e86cb70a7a..61f1e27fc41e 100644
> --- a/drivers/clocksource/timer-orion.c
> +++ b/drivers/clocksource/timer-orion.c
> @@ -43,7 +43,7 @@ static struct delay_timer orion_delay_timer = {
>  	.read_current_timer = orion_read_timer,
>  };
>  
> -static void orion_delay_timer_init(unsigned long rate)
> +static void __init orion_delay_timer_init(unsigned long rate)
>  {
>  	orion_delay_timer.freq = rate;
>  	register_current_timer_delay(&orion_delay_timer);
> diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
> index dfdff186c805..dc52a2197d24 100644
> --- a/drivers/soc/ti/pm33xx.c
> +++ b/drivers/soc/ti/pm33xx.c
> @@ -145,7 +145,7 @@ static int am33xx_do_sram_idle(u32 wfi_flags)
>  	return pm_ops->cpu_suspend(am33xx_do_wfi_sram, wfi_flags);
>  }
>  
> -static int __init am43xx_map_gic(void)
> +static int am43xx_map_gic(void)
>  {
>  	gic_dist_base = ioremap(AM43XX_GIC_DIST_BASE, SZ_4K);
>  
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]

