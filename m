Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E92C11CC62
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfLLLis (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 06:38:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39910 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfLLLir (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 06:38:47 -0500
Received: from zn.tnic (p200300EC2F0A5A00E16017ED12C324A2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:e160:17ed:12c3:24a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 059671EC0CFA;
        Thu, 12 Dec 2019 12:38:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576150725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lSxg8sEo/qHcrTTV7xsznBqZ37511sRSzuZcoxtxA7c=;
        b=ANZQmyBLbXJFDuXy5kxhF37n5crNGZPa0/yEYWL1of9SpEHdSmzJ2yTP6ZM3/kB8BrEnUh
        30OeOgWwE0rrb7Y1QKQvbpBY+7nTLDuWG8Zg9WS2ayWrWBfPsFN084MafuGj80q9/em7wz
        5SIuz6G5WB3FApx5ShHRRpR38JsdnKY=
Date:   Thu, 12 Dec 2019 12:38:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v4 10/19] x86/cpu: Detect VMX features on Intel, Centaur
 and Zhaoxin CPUs
Message-ID: <20191212113838.GD4991@zn.tnic>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-11-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191128014016.4389-11-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 27, 2019 at 05:40:07PM -0800, Sean Christopherson wrote:
> diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
> index a46c9e46f937..93268bde662a 100644
> --- a/arch/x86/kernel/cpu/feat_ctl.c
> +++ b/arch/x86/kernel/cpu/feat_ctl.c
> @@ -4,6 +4,72 @@
>  #include <asm/cpufeature.h>
>  #include <asm/msr-index.h>
>  #include <asm/processor.h>
> +#include <asm/vmx.h>
> +
> +#ifdef CONFIG_X86_VMX_FEATURE_NAMES
> +enum vmx_feature_leafs {
> +	MISC_FEATURES = 0,
> +	PRIMARY_PROC_CTLS,
> +	SECONDARY_PROC_CTLS,
> +	NR_VMX_FEATURE_WORDS,
> +};
> +
> +#define F(x) BIT(VMX_FEATURE_##x & 0x1f)

Eww, this F-thing has been always bugging me, especially if it means
something a little different each time:

arch/x86/crypto/blowfish-x86_64-asm_64.S:59:#define F() \
arch/x86/kernel/cpu/feat_ctl.c:17:#define F(x) BIT(VMX_FEATURE_##x & 0x1f)
arch/x86/kvm/cpuid.c:65:#define F(x) bit(X86_FEATURE_##x)
arch/x86/kvm/emulate.c:4393:#define F(_f, _e) { .flags = (_f) | Fastop, .u.fastop = (_e) }
arch/x86/kvm/svm.c:5927:#define F(x) bit(X86_FEATURE_##x)

I guess you can call yours VMX_F() or so, just so that it's name is
something different.

> +static void init_vmx_capabilities(struct cpuinfo_x86 *c)
> +{
> +	u32 supported, funcs, ept, vpid, ign;
> +
> +	BUILD_BUG_ON(NVMXINTS != NR_VMX_FEATURE_WORDS);
> +
> +	/*
> +	 * The high bits contain the allowed-1 settings, i.e. features that can
> +	 * be turned on.  The low bits contain the allowed-0 settings, i.e.
> +	 * features that can be turned off.  Ignore the allowed-0 settings,
> +	 * if a feature can be turned on then it's supported.
> +	 */
> +	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, ign, supported);
> +	c->vmx_capability[PRIMARY_PROC_CTLS] = supported;
> +
> +	rdmsr_safe(MSR_IA32_VMX_PROCBASED_CTLS2, &ign, &supported);
> +	c->vmx_capability[SECONDARY_PROC_CTLS] = supported;
> +
> +	rdmsr(MSR_IA32_VMX_PINBASED_CTLS, ign, supported);
> +	rdmsr_safe(MSR_IA32_VMX_VMFUNC, &ign, &funcs);
> +
> +	/*
> +	 * Except for EPT+VPID, which enumerates support for both in a single
> +	 * MSR, low for EPT, high for VPID.
> +	 */
> +	rdmsr_safe(MSR_IA32_VMX_EPT_VPID_CAP, &ept, &vpid);

Right, so this is a garden variety of rdmsr() and rdmsr_safe() and
the safe variant's retval needs to be checked, strictly speaking. It
probably doesn't matter here since you'll get 0s if it fails, which
means feature not supported, so all good.

But I guess you can still use rdmsr_safe() everywhere just so it doesn't
cause head scratching in the future, when one looks at that code.

> +#endif /* CONFIG_X86_VMX_FEATURE_NAMES */
>  
>  #undef pr_fmt
>  #define pr_fmt(fmt)	"x86/cpu: " fmt
> @@ -50,5 +116,9 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
>  		pr_err_once("VMX (%s TXT) disabled by BIOS\n",
>  			    tboot ? "inside" : "outside");
>  		clear_cpu_cap(c, X86_FEATURE_VMX);
> +	} else {
> +#ifdef CONFIG_X86_VMX_FEATURE_NAMES
> +		init_vmx_capabilities(c);
> +#endif

Can't say that I'm happy about all that ifdeffery but I guess we need
to perpetuate this since X86_FEATURE_NAMES is there for embedded. In
practice, probably no one disables it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
