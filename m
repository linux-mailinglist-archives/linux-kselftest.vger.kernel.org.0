Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E370516F46C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 01:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgBZAlt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 19:41:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:32514 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgBZAlt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 19:41:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 16:41:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; 
   d="scan'208";a="230289859"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [134.134.177.78]) ([134.134.177.78])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2020 16:41:47 -0800
Subject: Re: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     TonyWWang-oc@zhaoxin.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, bp@alien8.de, bp@suse.de,
        hpa@zytor.com, jacob.jun.pan@linux.intel.com,
        jarkko.sakkinen@linux.intel.com, jmattson@google.com,
        jolsa@redhat.com, joro@8bytes.org, kvm@vger.kernel.org,
        lenb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
        namhyung@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
        rkrcmar@redhat.com, shuah@kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
References: <20191221044513.21680-14-sean.j.christopherson@intel.com>
 <e741196d-52aa-0f5e-8f1e-a37ddf2e5025@intel.com>
 <20200225221234.GL9245@linux.intel.com>
 <1eaf6fbe-0adb-5074-3bc4-1e8327e0cdb3@intel.com>
 <20200225232900.GO9245@linux.intel.com>
 <5434303a-0742-3811-fd14-6445d296c0f0@intel.com>
Organization: Intel Corporation
Message-ID: <ee8e2b4d-9448-48e0-feb9-410059577fe3@intel.com>
Date:   Tue, 25 Feb 2020 16:41:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5434303a-0742-3811-fd14-6445d296c0f0@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/25/2020 3:54 PM, Jacob Keller wrote:
> 
> I reverted the suggested commit and added some prints:
> 
> [   26.056398] X86_FEATURE_MSR_IA32_FEAT_CTL is enabled
> [   26.062426] X86_FEATURE_VMX is enabled
> [   26.066923] kvm: disabled by bios
> 
> So the old code flow is finding KVM to be disabled, but both features
> are set...
> 
> The code that sets this is run first:
> 
>> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_LOCKED is set
>> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_VMX_ENABLED_INSIDE_SMX is unset
>> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX is unset
>> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: MSR locked by bios
>> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: VMX (outside TXT) disabled by BIOS
>> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: disabling X86_FEATURE_VMX
> 
> But somehow... it is still set later...
> 
> So there's something weird going on. Maybe "boot_cpu_has" in the
> vmx_disabled_by_bios is wrong? Hmm.
> 

I added even more pr_warns, giving me the following diff after reverting
the suggested commit:

> 
> 
> diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
> index 0268185bef94..a86619acab80 100644
> --- a/arch/x86/kernel/cpu/feat_ctl.c
> +++ b/arch/x86/kernel/cpu/feat_ctl.c
> @@ -97,13 +97,27 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
>         bool tboot = tboot_enabled();
>         u64 msr;
> 
> +       pr_warn("before X86_FEATURE_MSR_IA32_FEAT_CTL is %s\n",
> +                       cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL) ? "enabled" : "disabled");
> +       pr_warn("before X86_FEATURE_VMX is %s\n",
> +                       cpu_has(c, X86_FEATURE_VMX) ? "enabled" : "disabled");
> +
>         if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr)) {
>                 clear_cpu_cap(c, X86_FEATURE_VMX);
>                 return;
>         }
> 
> -       if (msr & FEAT_CTL_LOCKED)
> +       pr_warn("FEAT_CTL_LOCKED is %s\n",
> +                       msr & FEAT_CTL_LOCKED ? "set" : "unset");
> +       pr_warn("FEAT_CTL_VMX_ENABLED_INSIDE_SMX is %s\n",
> +                       msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX ? "set" : "unset");
> +       pr_warn("FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX is %s\n",
> +                       msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX ? "set" : "unset");
> +
> +       if (msr & FEAT_CTL_LOCKED) {
> +               pr_warn("MSR locked by bios\n");
>                 goto update_caps;
> +       }
> 
>         /*
>          * Ignore whatever value BIOS left in the MSR to avoid enabling random
> @@ -136,10 +150,16 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
>                 if (IS_ENABLED(CONFIG_KVM_INTEL))
>                         pr_err_once("VMX (%s TXT) disabled by BIOS\n",
>                                     tboot ? "inside" : "outside");
> +               pr_warn("disabling X86_FEATURE_VMX\n");
>                 clear_cpu_cap(c, X86_FEATURE_VMX);
>         } else {
>  #ifdef CONFIG_X86_VMX_FEATURE_NAMES
>                 init_vmx_capabilities(c);
>  #endif
>         }
> +
> +       pr_warn("after X86_FEATURE_MSR_IA32_FEAT_CTL is %s\n",
> +                       cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL) ? "enabled" : "disabled");
> +       pr_warn("after X86_FEATURE_VMX is %s\n",
> +                       cpu_has(c, X86_FEATURE_VMX) ? "enabled" : "disabled");
>  }
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a2e18e60c2db..550f8d556251 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2222,6 +2222,16 @@ static __init int vmx_disabled_by_bios(void)
>  {
>         u64 msr;
> 
> +       pr_warn("boot X86_FEATURE_MSR_IA32_FEAT_CTL is %s\n",
> +                       boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ? "enabled" : "disabled");
> +       pr_warn("boot X86_FEATURE_VMX is %s\n",
> +                       boot_cpu_has(X86_FEATURE_VMX) ? "enabled" : "disabled");
> +
> +       pr_warn("this_cpu X86_FEATURE_MSR_IA32_FEAT_CTL is %s\n",
> +                       this_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ? "enabled" : "disabled");
> +       pr_warn("this_cpu X86_FEATURE_VMX is %s\n",
> +                       this_cpu_has(X86_FEATURE_VMX) ? "enabled" : "disabled");
> +
>         rdmsrl(MSR_IA32_FEAT_CTL, msr);
> 
>         if (unlikely(!(msr & FEAT_CTL_LOCKED)))

With this, I see the following output for each CPU, starting with boot CPU:

> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: before X86_FEATURE_MSR_IA32_FEAT_CTL is disabled
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: before X86_FEATURE_VMX is enabled
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_LOCKED is set
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_VMX_ENABLED_INSIDE_SMX is unset
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX is unset
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: MSR locked by bios
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: VMX (outside TXT) disabled by BIOS
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: disabling X86_FEATURE_VMX
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: after X86_FEATURE_MSR_IA32_FEAT_CTL is enabled
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: after X86_FEATURE_VMX is disabled
And for each of the SMP CPUs:

> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: before X86_FEATURE_MSR_IA32_FEAT_CTL is disabled
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: before X86_FEATURE_VMX is enabled
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_LOCKED is set
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_VMX_ENABLED_INSIDE_SMX is unset
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX is unset
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: MSR locked by bios
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: disabling X86_FEATURE_VMX
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: after X86_FEATURE_MSR_IA32_FEAT_CTL is enabled
> Feb 25 16:35:59 jbrandeb-saw1 kernel: x86/cpu: after X86_FEATURE_VMX is disabled

But when we finally go to check kvm:

> Feb 25 16:36:06 jbrandeb-saw1 kernel: boot X86_FEATURE_MSR_IA32_FEAT_CTL is enabled
> Feb 25 16:36:06 jbrandeb-saw1 kernel: boot X86_FEATURE_VMX is enabled
> Feb 25 16:36:06 jbrandeb-saw1 kernel: this_cpu X86_FEATURE_MSR_IA32_FEAT_CTL is enabled
> Feb 25 16:36:06 jbrandeb-saw1 kernel: this_cpu X86_FEATURE_VMX is enabled

I tried checking both boot and this_cpu, just in case.

Somehow the things are being restored/re-enabled. I can't figure out
where this even happens. At a glance it's not even obvious to me where
the original features get set, and nothing seems to obviously set these
flags....

Thanks,
Jake

