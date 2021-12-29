Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F95480E36
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 01:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhL2AVM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 19:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhL2AVL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 19:21:11 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A89C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Dec 2021 16:21:11 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id m15so17104301pgu.11
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Dec 2021 16:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aD2wzsbm+sT+Pa4K7JTUkCGSHzkUiwnjJcSKkt8ynjg=;
        b=M3O6/+qXF1dvEZ248mAgk9TWEITaeZ3wSCPJ6C10EMsVO+UnjNVAKJcYJscAQS5AQQ
         bZusvI0Gu9PJ86nOvionMunXs+5nHy5h1hpnJBUs5YrxLNxarviPh/R8tuh+qGUn7ZFq
         pdxLhPGzqLeh3FDNtg78Dq2PeHrJUzOiCdUW9wQxWuFm32jUYfGNgOAc/xOCTDCzUbWd
         1tCIPF1jNObf9fs0DZEbGBhrSxiTpXbmFNPN+AzLi40Zl+YXHbJq0D6YMf4wEV+w7cAy
         MzfVcfsnzb1lg6EXsq+ljgKNRchsdkuljdwWSuY70TC9rPBaTdtcL+vZqu754xxNOylZ
         frAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aD2wzsbm+sT+Pa4K7JTUkCGSHzkUiwnjJcSKkt8ynjg=;
        b=3b+sid0mzC7a9TA1Y+AWIlOZlugbjOusR4lYDjqnjtbFgI8b4IaT2DOLEArTFCs7zE
         Gs+pQX+GJqOsixHjHdg9omQaBpKGD/UsIK9MiD8H8cjAxkO26S00YOiS3tdYBrOnSsem
         Md2X5IVAmqQCCf3+NqspWnEEST9shAT+3ZjdKl88uTcmqCZpMZkNDkTYjKYuJ19ozn0t
         C6MYTwEkw0X3aGSm1H872C1d7lYt0tgWNKKoiOOH6gz4mEo8EEyTEX1hvUhlLDQPIExf
         b62jwE9ob2EgaeACD5byM8ThHLvlv/uBsN5lCsrbn2O6SINx5TMpS/0wnGG8JTglco98
         DUWg==
X-Gm-Message-State: AOAM531D47BjUCvpfuVnCY+qdA25rQ2ePVSFJ3vTWTHoFmOwRAioCepY
        G2M+748sLuitnJre3BrP6b5djg==
X-Google-Smtp-Source: ABdhPJzlkjKWY+MvibfWkquu9G315yJkccaVhTBEilXVPiunaBfLgrCsBANyxjYVuAuXX4tcjw7hnw==
X-Received: by 2002:a62:6dc4:0:b0:4ac:fd66:b746 with SMTP id i187-20020a626dc4000000b004acfd66b746mr24382311pfc.17.1640737270757;
        Tue, 28 Dec 2021 16:21:10 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v16sm19267142pjh.57.2021.12.28.16.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 16:21:10 -0800 (PST)
Date:   Wed, 29 Dec 2021 00:21:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jing Liu <jing2.liu@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, guang.zeng@intel.com,
        wei.w.wang@intel.com, yang.zhong@intel.com
Subject: Re: [PATCH v3 16/22] kvm: x86: Add XCR0 support for Intel AMX
Message-ID: <Ycup8opdHrjCIy1V@google.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-17-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222124052.644626-17-jing2.liu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 22, 2021, Jing Liu wrote:
> Two XCR0 bits are defined for AMX to support XSAVE mechanism. Bit 17
> is for tilecfg and bit 18 is for tiledata.
> 
> The value of XCR0[17:18] is always either 00b or 11b.

Is that an SDM requirement, or an arbitrary Linux/KVM requirement?

> Also, SDM
> recommends that only 64-bit operating systems enable Intel AMX by
> setting XCR0[18:17]. If a 32-bit guest tries to set dynamic bits, it

This is wrong.  It has nothing to do with 32-bit guests.  The restriction is on
32-bit _host kernels_, which I'm guessing never set the tile bits in _host_ XCR0.

> fails to pass vcpu->arch.guest_supported_xcr0 check and gets a #GP.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> ---
>  arch/x86/kvm/x86.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a48a89f73027..c558c098979a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -210,7 +210,7 @@ static struct kvm_user_return_msrs __percpu *user_return_msrs;
>  #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
>  				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
>  				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
> -				| XFEATURE_MASK_PKRU)
> +				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
>  
>  u64 __read_mostly host_efer;
>  EXPORT_SYMBOL_GPL(host_efer);
> @@ -990,6 +990,12 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
>  		if ((xcr0 & XFEATURE_MASK_AVX512) != XFEATURE_MASK_AVX512)
>  			return 1;
>  	}
> +
> +#ifdef CONFIG_X86_64

Drop the #ifdef, it adds no meaningful value and requires the reader to think
far harder than they should have.  Yes, it's technically dead code for 32-bit KVM,
but no one cares about performance of 32-bit KVM, and in any case it's extremely
unlikely this will be anything but noise.

> +	if ((xcr0 & XFEATURE_MASK_XTILE) &&
> +	    ((xcr0 & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE))
> +		return 1;
> +#endif
>  	vcpu->arch.xcr0 = xcr0;
>  
>  	if ((xcr0 ^ old_xcr0) & XFEATURE_MASK_EXTEND)
> -- 
> 2.27.0
> 
