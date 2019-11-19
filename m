Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2FF101299
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 05:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfKSEmC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 23:42:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:26569 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfKSEmC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 23:42:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 20:42:01 -0800
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="200217249"
Received: from khuang2-desk.sh.intel.com ([10.251.27.252])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 20:41:54 -0800
Message-ID: <17a1831a3a72fb87ce2a35689e07ff517c4bdf99.camel@linux.intel.com>
Subject: Re: [PATCH v3 04/19] x86/intel: Initialize IA32_FEATURE_CONTROL MSR
 at boot
From:   Kai Huang <kai.huang@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Tue, 19 Nov 2019 17:41:49 +1300
In-Reply-To: <20191119031240.7779-5-sean.j.christopherson@intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
         <20191119031240.7779-5-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2019-11-18 at 19:12 -0800, Sean Christopherson wrote:
> Opportunistically initialize IA32_FEATURE_CONTROL MSR to enable VMX when
> the MSR is left unlocked by BIOS.  Configuring IA32_FEATURE_CONTROL at
> boot time paves the way for similar enabling of other features, e.g.
> Software Guard Extensions (SGX).
> 
> Temporarily leave equivalent KVM code in place in order to avoid
> introducing a regression on Centaur and Zhaoxin CPUs, e.g. removing
> KVM's code would leave the MSR unlocked on those CPUs and would break
> existing functionality if people are loading kvm_intel on Centaur and/or
> Zhaoxin.  Defer enablement of the boot-time configuration on Centaur and
> Zhaoxin to future patches to aid bisection.
> 
> Note, Local Machine Check Exceptions (LMCE) are also supported by the
> kernel and enabled via IA32_FEATURE_CONTROL, but the kernel currently
> uses LMCE if and and only if the feature is explicitly enabled by BIOS.
> Keep the current behavior to avoid introducing bugs, future patches can
> opt in to opportunistic enabling if it's deemed desirable to do so.
> 
> Always lock IA32_FEATURE_CONTROL if it exists, even if the CPU doesn't
> support VMX, so that other existing and future kernel code that queries
> IA32_FEATURE_CONTROL can assume it's locked.
> 
> Start from a clean slate when constructing the value to write to
> IA32_FEATURE_CONTROL, i.e. ignore whatever value BIOS left in the MSR so
> as not to enable random features or fault on the WRMSR.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/Kconfig.cpu                  |  4 +++
>  arch/x86/kernel/cpu/Makefile          |  1 +
>  arch/x86/kernel/cpu/cpu.h             |  4 +++
>  arch/x86/kernel/cpu/feature_control.c | 35 +++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/intel.c           |  2 ++
>  5 files changed, 46 insertions(+)
>  create mode 100644 arch/x86/kernel/cpu/feature_control.c
> 
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index af9c967782f6..aafc14a0abf7 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -387,6 +387,10 @@ config X86_DEBUGCTLMSR
>  	def_bool y
>  	depends on !(MK6 || MWINCHIPC6 || MWINCHIP3D || MCYRIXIII || M586MMX ||
> M586TSC || M586 || M486SX || M486) && !UML
>  
> +config X86_FEATURE_CONTROL_MSR
> +	def_bool y
> +	depends on CPU_SUP_INTEL
> +
>  menuconfig PROCESSOR_SELECT
>  	bool "Supported processor vendors" if EXPERT
>  	---help---
> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> index 890f60083eca..84e35e762f76 100644
> --- a/arch/x86/kernel/cpu/Makefile
> +++ b/arch/x86/kernel/cpu/Makefile
> @@ -29,6 +29,7 @@ obj-y			+= umwait.o
>  obj-$(CONFIG_PROC_FS)	+= proc.o
>  obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
>  
> +obj-$(CONFIG_X86_FEATURE_CONTROL_MSR) += feature_control.o
>  ifdef CONFIG_CPU_SUP_INTEL
>  obj-y			+= intel.o intel_pconfig.o tsx.o
>  obj-$(CONFIG_PM)	+= intel_epb.o
> diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
> index 38ab6e115eac..a58e80866a3f 100644
> --- a/arch/x86/kernel/cpu/cpu.h
> +++ b/arch/x86/kernel/cpu/cpu.h
> @@ -80,4 +80,8 @@ extern void x86_spec_ctrl_setup_ap(void);
>  
>  extern u64 x86_read_arch_cap_msr(void);
>  
> +#ifdef CONFIG_X86_FEATURE_CONTROL_MSR
> +void init_feature_control_msr(struct cpuinfo_x86 *c);
> +#endif
> +
>  #endif /* ARCH_X86_CPU_H */
> diff --git a/arch/x86/kernel/cpu/feature_control.c
> b/arch/x86/kernel/cpu/feature_control.c
> new file mode 100644
> index 000000000000..33c9444dda52
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/feature_control.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/tboot.h>
> +
> +#include <asm/cpufeature.h>
> +#include <asm/msr-index.h>
> +#include <asm/processor.h>
> +
> +void init_feature_control_msr(struct cpuinfo_x86 *c)
> +{
> +	u64 msr;
> +
> +	if (rdmsrl_safe(MSR_IA32_FEATURE_CONTROL, &msr))
> +		return;
> +
> +	if (msr & FEAT_CTL_LOCKED)
> +		return;
> +
> +	/*
> +	 * Ignore whatever value BIOS left in the MSR to avoid enabling random
> +	 * features or faulting on the WRMSR.
> +	 */
> +	msr = FEAT_CTL_LOCKED;
> +
> +	/*
> +	 * Enable VMX if and only if the kernel may do VMXON at some point,
> +	 * i.e. KVM is enabled, to avoid unnecessarily adding an attack vector
> +	 * for the kernel, e.g. using VMX to hide malicious code.
> +	 */
> +	if (cpu_has(c, X86_FEATURE_VMX) && IS_ENABLED(CONFIG_KVM)) {
> +		msr |= FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
> +		if (tboot_enabled())
> +			msr |= FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
> +	}

Why not also take this chance to enable SGX? Or it will come with SGX patch
series?

> +	wrmsrl(MSR_IA32_FEATURE_CONTROL, msr);
> +}
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 4a900804a023..b7c6ed0b40b6 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -755,6 +755,8 @@ static void init_intel(struct cpuinfo_x86 *c)
>  	/* Work around errata */
>  	srat_detect_node(c);
>  
> +	init_feature_control_msr(c);

Will this compile if you disable CONFIG_X86_FEATURE_CONTROL_MSR?

Provide an empty one in cpu.h if the config is not enabled?

Thanks,
-Kai
> +
>  	if (cpu_has(c, X86_FEATURE_VMX))
>  		detect_vmx_virtcap(c);
>  

