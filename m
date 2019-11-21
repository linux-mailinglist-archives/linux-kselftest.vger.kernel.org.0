Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 949DE10577E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 17:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUQxI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 11:53:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42710 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUQxI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 11:53:08 -0500
Received: from zn.tnic (p200300EC2F0F070070C4546F98AAB214.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:700:70c4:546f:98aa:b214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96D451EC0CFA;
        Thu, 21 Nov 2019 17:53:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574355186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wPL1BxjICNOSRaX+U/Ou4Te4AiCGCtaWl/woUTXZ9Us=;
        b=Es5mTW8srEVQypAWslBSyMpOwm+f1DTk3cslWQz0ZXffswx0adwUl/Gh7uyrSWxeIt9i4j
        K0HSxm4zObHPOfNe548FBtPXpixEVzo9WIeXTGeOkc5Hcy4le/fX6lFqOdPBqA3PHFrSc+
        ye1rE0wWl2Cq6Mwis3wwRmhkHL21lI4=
Date:   Thu, 21 Nov 2019 17:52:58 +0100
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
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v3 12/19] x86/vmx: Introduce VMX_FEATURES_*
Message-ID: <20191121165250.GK6540@zn.tnic>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-13-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191119031240.7779-13-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 18, 2019 at 07:12:33PM -0800, Sean Christopherson wrote:
> Add a VMX specific variant of X86_FEATURE_* flags, which will eventually
> supplant the synthetic VMX flags defined in cpufeatures word 8.  Use the
> Intel-defined layouts for the major VMX execution controls so that their
> word entries can be directly populated from their respective MSRs, and
> so that the VMX_FEATURE_* flags can be used to define the existing bit
> definitions in asm/vmx.h, i.e. force developers to define a VMX_FEATURE
> flag when adding support for a new hardware feature.
> 
> The majority of Intel's (and compatible CPU's) VMX capabilities are
> enumerated via MSRs and not CPUID, i.e. querying /proc/cpuinfo doesn't
> naturally provide any insight into the virtualization capabilities of
> VMX enabled CPUs.  Commit e38e05a85828d ("x86: extended "flags" to show
> virtualization HW feature in /proc/cpuinfo") attempted to address the
> issue by synthesizing select VMX features into a Linux-defined word in
> cpufeatures.
> 
> The synthetic cpufeatures approach has several flaws:
> 
>   - The set of synthesized VMX flags has become extremely stale with
>     respect to the full set of VMX features, e.g. only one new flag
>     (EPT A/D) has been added in the the decade since the introduction of
>     the synthetic VMX features.  Failure to keep the VMX flags up to
>     date is likely due to the lack of a mechanism that forces developers
>     to consider whether or not a new feature is worth reporting.
> 
>   - The synthetic flags may incorrectly be misinterpreted as affecting
>     kernel behavior, i.e. KVM, the kernel's sole consumer of VMX,
>     completely ignores the synthetic flags.
> 
>   - New CPU vendors that support VMX have duplicated the hideous code
>     that propagates VMX features from MSRs to cpufeatures.  Bringing the
>     synthetic VMX flags up to date would exacerbate the copy+paste
>     trainwreck.
> 
> Define separate VMX_FEATURE flags to set the stage for enumerating VMX
> capabilities outside of the cpu_has() framework, and for adding
> functional usage of VMX_FEATURE_* to help ensure the features reported
> via /proc/cpuinfo is up to date with respect to kernel recognition of
> VMX capabilities.

That's all fine and good but who's going to use those feature bits?
Or are we reporting them just for the sake of it? Because if only
that, then it is not worth the effort. Sure, I don't mind extending
the framework so that you can use cpu_has() for VMX features but the
/proc/cpuinfo angle is not clear to me.

Especially since you're hiding most of them with the "" prepended in the
define comment.

> Note, the displayed names 'vnmi', 'tpr_shadow' and 'flexpriority' are
> retained for backwards compatibility with the existing ABI.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  MAINTAINERS                        |  2 +-
>  arch/x86/include/asm/processor.h   |  1 +
>  arch/x86/include/asm/vmxfeatures.h | 81 ++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/include/asm/vmxfeatures.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df711965c377..6b736e78ee9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9009,7 +9009,7 @@ F:	arch/x86/include/uapi/asm/svm.h
>  F:	arch/x86/include/asm/kvm*
>  F:	arch/x86/include/asm/pvclock-abi.h
>  F:	arch/x86/include/asm/svm.h
> -F:	arch/x86/include/asm/vmx.h
> +F:	arch/x86/include/asm/vmx*.h
>  F:	arch/x86/kernel/kvm.c
>  F:	arch/x86/kernel/kvmclock.c
>  
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index b4e29d8b9e5a..772de8917430 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -25,6 +25,7 @@ struct vm86;
>  #include <asm/special_insns.h>
>  #include <asm/fpu/types.h>
>  #include <asm/unwind_hints.h>
> +#include <asm/vmxfeatures.h>
>  
>  #include <linux/personality.h>
>  #include <linux/cache.h>
> diff --git a/arch/x86/include/asm/vmxfeatures.h b/arch/x86/include/asm/vmxfeatures.h
> new file mode 100644
> index 000000000000..aea39b9f1587
> --- /dev/null
> +++ b/arch/x86/include/asm/vmxfeatures.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_VMXFEATURES_H
> +#define _ASM_X86_VMXFEATURES_H
> +
> +/*
> + * Note: If the comment begins with a quoted string, that string is used
> + * in /proc/cpuinfo instead of the macro name.  If the string is "",
> + * this feature bit is not displayed in /proc/cpuinfo at all.
> + */
> +
> +/* Pin-Based VM-Execution Controls, EPT/VPID, APIC and VM-Functions, word 0 */
> +#define VMX_FEATURE_INTR_EXITING	( 0*32+  0) /* "" VM-Exit on vectored interrupts */
> +#define VMX_FEATURE_NMI_EXITING		( 0*32+  3) /* "" VM-Exit on NMIs */
> +#define VMX_FEATURE_VIRTUAL_NMIS	( 0*32+  5) /* "vnmi" NMI virtualization */
> +#define VMX_FEATURE_PREEMPTION_TIMER	( 0*32+  6) /* VMX Preemption Timer */

You really wanna have "preemption_timer" in /proc/cpuinfo? That should
at least say vmx-something, if it should be visible there at all.

> +#define VMX_FEATURE_POSTED_INTR		( 0*32+  7) /* Posted Interrupts */

Same here.

In general, the questions stand for all those feature bits which will be
visible in /proc/cpuinfo.

1. Which to show and why?

2. Who's going to use them?

3. If show and dumping them together with the other feature flags, have
their name be proper (vmx-prefixed etc).

> +/* EPT/VPID features, scattered to bits 16-23 */
> +#define VMX_FEATURE_INVVPID	        ( 0*32+ 16) /* INVVPID is supported */
> +#define VMX_FEATURE_EPT_EXECUTE_ONLY	( 0*32+ 17) /* "ept_x_only" EPT entries can be execute only */
> +#define VMX_FEATURE_EPT_AD      	( 0*32+ 18) /* EPT Accessed/Dirty bits */
> +#define VMX_FEATURE_EPT_1GB      	( 0*32+ 19) /* 1GB EPT pages */
			      ^^^^^^^^^^^^

There are some spaces that need to be converted to tabs here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
