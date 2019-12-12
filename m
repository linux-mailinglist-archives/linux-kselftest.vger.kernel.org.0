Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7245C11CD1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 13:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfLLM0x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 07:26:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47930 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbfLLM0x (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 07:26:53 -0500
Received: from zn.tnic (p200300EC2F0A5A00CC48E6B3BEAE7272.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:cc48:e6b3:beae:7272])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E6341EC0CF2;
        Thu, 12 Dec 2019 13:26:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576153611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4nnUQORr01dv2OD8c5wfMXkKjRS70BcFeDE2vIOENyE=;
        b=GGQjyQxlr2BIjMsm/DkgrYML2PlbdeQ23AAj8AL8zZsLdEGFpqWklMdrOSA1p6kXHl+0TD
        4PVP3GRB/BU+2Op9INl4DrlIzJ+CHVnIuFZKeWSOLRXXKPlcR5QLp51FWpJ2Z1kEbJ5f/a
        PRoHbEAVfhpA3Ic5/DUpTCVH6h3re90=
Date:   Thu, 12 Dec 2019 13:26:46 +0100
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
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
Message-ID: <20191212122646.GE4991@zn.tnic>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191128014016.4389-12-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 27, 2019 at 05:40:08PM -0800, Sean Christopherson wrote:
> Add support for generating VMX feature names in capflags.c and use the
> resulting x86_vmx_flags to print the VMX flags in /proc/cpuinfo.  Don't
> print VMX flags if no bits are set in word 0, which holds Pin Controls.
> Pin Control's INTR and NMI exiting are fundamental pillars of VMX, if
> they are not supported then the CPU is broken, it does not actually
> support VMX, or the kernel wasn't built with support for the target CPU.
> 
> Print the features in a dedicated "vmx flags" line to avoid polluting
> the common "flags" and to avoid having to prefix all flags with "vmx_",
> which results in horrendously long names.
> 
> Keep synthetic VMX flags in cpufeatures to preserve /proc/cpuinfo's ABI
> for those flags.  This means that "flags" and "vmx flags" will have
> duplicate entries for tpr_shadow (virtual_tpr), vnmi (virtual_nmis),
> ept, flexpriority, vpid and ept_ad, but caps the pollution of "flags" at
> those six VMX features.  The vendor specific code that populates the
> synthetic flags will be consolidated in a future patch to futher
								^

further

> +#ifdef CONFIG_X86_VMX_FEATURE_NAMES
> +	if (cpu_has(c, X86_FEATURE_VMX) && c->vmx_capability[0]) {
> +		seq_puts(m, "\nvmx flags\t:");
> +		for (i = 0; i < 32*NVMXINTS; i++) {
> +			if (test_bit(i, (unsigned long *)c->vmx_capability) &&
> +			    x86_vmx_flags[i] != NULL)
> +				seq_printf(m, " %s", x86_vmx_flags[i]);
> +		}
> +	}
> +#endif

Oh well, some could be shorter:

vmx flags       : virtual_nmis preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpriority tsc_offsetting virtual_tpr mtf virt_apic_accesses ept vpid unrestricted_guest ple shadow_vmcs pml mode_based_ept_exec

virtual_nmis		-> vnmis
preemption_timer	-> preempt_tmr
flexpriority		-> flexprio
tsc_offsetting		-> tsc_ofs
virtual_tpr		-> vtpr
virt_apic_accesses	-> vapic
unrestricted_guest	-> unres_guest

and so on. Those are just my examples - I betcha the SDM is more
creative here with abbreviations. But you guys are going to grep for
them. If it were me, I'd save on typing. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
