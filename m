Return-Path: <linux-kselftest+bounces-33642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07132AC21E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC49172E9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEE922A4F0;
	Fri, 23 May 2025 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pGrh4cl5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86F522AE41;
	Fri, 23 May 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747999236; cv=none; b=Zc2jeWM5T8VQkj9UUjWVkBB/BkMGZFFOaLJsu8+Dr07uoqb+s8LqginWip4/0lAy+yu8mLO+mZNAfLQu0MrHsgN5MgZlTbnsHH8nVuRjfwV1OI0iRr6JWnjrjhYzn2tJzc41OMOetWIBDtrZ8LlH6EAJ4dxEbAGEkXy5cGvK3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747999236; c=relaxed/simple;
	bh=XmeiGBXI70ukFbp2wX31QSqHU/R9FyAhU/P3DDXoibQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYLDUdCtLo2Nmv9UlQIhB+OX16Al9gH4nM+uIdcs3ZhTpwKjBfkBnZaezvoeTwzwUAIvDju7/FrE1DlSOZZduzYioPVdv3YI3LKxioP8o4DUmMYE+I885ELWCH0dFBlqFY3OAj3LT+FVPtOVQy9ni2JGpoK0fQj4rdI74Epvzvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pGrh4cl5; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54NBJc1K2086996;
	Fri, 23 May 2025 06:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747999178;
	bh=G3eBoRI6ajKzQj7PIYgoVul0HEV9Bq6GwjJIxWdrMvs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=pGrh4cl5UNwlzQb/0t74988xZoSrBH7x4348QMBKDmfEIEnMxH8v3P122scZKOLoq
	 WcvICifTw0IpvVBp7SlgqxN1dmooOa4XIXH6VEXHmwzZMIPuwOd/B/40p6zsECZIL9
	 nKV7oX048/6bbOEblbgcqX9fFjhONqR8xG9NOzpE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54NBJcAC023157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 23 May 2025 06:19:38 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 May 2025 06:19:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 May 2025 06:19:37 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54NBJblW1172257;
	Fri, 23 May 2025 06:19:37 -0500
Date: Fri, 23 May 2025 06:19:37 -0500
From: Nishanth Menon <nm@ti.com>
To: Kees Cook <kees@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        Santosh Shilimkar <ssantosh@kernel.org>, Lee Jones
	<lee@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Christoph Hellwig
	<hch@lst.de>, Marco Elver <elver@google.com>,
        Andrey Konovalov
	<andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Ard
 Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan
 Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling
	<morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-doc@vger.kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-kbuild@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: Re: [PATCH v2 05/14] arm: Handle KCOV __init vs inline mismatches
Message-ID: <20250523111937.f2fqhoshqevdoxcl@snowbird>
References: <20250523043251.it.550-kees@kernel.org>
 <20250523043935.2009972-5-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250523043935.2009972-5-kees@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 21:39-20250522, Kees Cook wrote:
> When KCOV is enabled all functions get instrumented, unless
> the __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions, we have to
> handle differences in how GCC's inline optimizations get resolved. For
> arm this exposed several places where __init annotations were missing
> but ended up being "accidentally correct". Fix these cases and force
> several functions to be inline with __always_inline.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
[...]
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
Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

