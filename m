Return-Path: <linux-kselftest+bounces-37561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3030B0A4AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 15:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE9D17565A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 13:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B0D2DBF66;
	Fri, 18 Jul 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OHanrKrF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF52248AE;
	Fri, 18 Jul 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843611; cv=none; b=mgkEbYxemDKKoMM7IOOYYo/6vpg7XAG5DdH3QK8mbc/WDpSO3cDfDgp1hDdUyY75+NsFY9Nr3Y11CKvaiELCGJhFJbySN+1Sbf8tyn9K1yNdaXWCaVsKwbF3kFRqjDAKaf57gOcL9iTIjyW8J0thAMs3AIFW0R3afZLa2gXANYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843611; c=relaxed/simple;
	bh=IZbkQ3xfBnJRR8mLGXwqgyZgLY0IodQhcv+PYEmI1VU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2wPUhTXXpzvuFtt2FHcSOCjocNGNl0fvCMzEAjREQN74WTimqtGeRHwrLyCQeKkiuSa20ApsfrE6UgmuEGVZF/0r4HkdIlCg3N8Aomrr6e1tuW8zW7KvT5o/RWUMeavxjcm+vgoJPPaLC+gWzQgup5vScS4+rOSBVMyhkX3Xp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OHanrKrF; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56ICwse5714132;
	Fri, 18 Jul 2025 07:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752843534;
	bh=yUsTOiGa3kRqTBNBK7IpA6+SLe5En1zTCsg3sQMTpbs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=OHanrKrF/DefV8Mrb2bedfmKNAHbxsndAxEdnsJc3QfgJwi0t0OhX/DoJ34XNSKbE
	 QG4IiVhyMWz1oJ7LSIU8MRdFM2mHXgWlPXYYQt+M5v29Vs42rIAhwdGHdOc+Yq+x8h
	 k4rmecN1GBT/hi5iA7VJxtc+syPyT8ExdGH5x+s4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56ICwsg43508025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 18 Jul 2025 07:58:54 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 18
 Jul 2025 07:58:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 18 Jul 2025 07:58:53 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56ICwraF3541832;
	Fri, 18 Jul 2025 07:58:53 -0500
Date: Fri, 18 Jul 2025 07:58:53 -0500
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
        Ingo
 Molnar <mingo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor
	<nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>,
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
Subject: Re: [PATCH v3 05/13] arm: Handle KCOV __init vs inline mismatches
Message-ID: <20250718125853.75g4nv2dnbkklud6@leggings>
References: <20250717231756.make.423-kees@kernel.org>
 <20250717232519.2984886-5-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250717232519.2984886-5-kees@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:25-20250717, Kees Cook wrote:
> When KCOV is enabled all functions get instrumented, unless
> the __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions, we have to
> handle differences in how GCC's inline optimizations get resolved. For
> arm this exposed several places where __init annotations were missing
> but ended up being "accidentally correct". Fix these cases and force
> several functions to be inline with __always_inline.
> 

[..]

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

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

