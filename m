Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9972D1FF4F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 16:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgFROlR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 10:41:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:24819 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgFROlP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 10:41:15 -0400
IronPort-SDR: 5qHgtSZnSnamiQvDEAeTF11jtv9HUs+28PzhQbZjAYfmNf+b0b8u9n7CieSMe9lqeVtBgATLhO
 sYh0+GTnCyZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="130991885"
X-IronPort-AV: E=Sophos;i="5.75,526,1589266800"; 
   d="scan'208";a="130991885"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 07:41:11 -0700
IronPort-SDR: jqIabIwAQ3v6Gt37K8Vc1ybzA+mx9gmrW8OLBOMAVcVmb1iaSBAIanmkVCJc3Eds4bvpjLGV/2
 zf9hq49K6rpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="277643425"
Received: from mcrum-mobl1.amr.corp.intel.com (HELO [10.255.0.127]) ([10.255.0.127])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2020 07:41:06 -0700
Subject: Re: [PATCH 4/4] X86: Use KVM CR pin MSRs
To:     John Andersen <john.s.andersen@intel.com>, corbet@lwn.net,
        pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, shuah@kernel.org,
        sean.j.christopherson@intel.com, liran.alon@oracle.com,
        drjones@redhat.com, rick.p.edgecombe@intel.com,
        kristen@linux.intel.com
Cc:     vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, mchehab+huawei@kernel.org,
        gregkh@linuxfoundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com,
        mike.kravetz@oracle.com, oneukum@suse.com, luto@kernel.org,
        peterz@infradead.org, fenghua.yu@intel.com,
        reinette.chatre@intel.com, vineela.tummalapalli@intel.com,
        dave.hansen@linux.intel.com, arjan@linux.intel.com,
        caoj.fnst@cn.fujitsu.com, bhe@redhat.com, nivedita@alum.mit.edu,
        keescook@chromium.org, dan.j.williams@intel.com,
        eric.auger@redhat.com, aaronlewis@google.com, peterx@redhat.com,
        makarandsonare@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20200617190757.27081-1-john.s.andersen@intel.com>
 <20200617190757.27081-5-john.s.andersen@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <b5d791f9-1708-9715-e03d-4618d1b27d05@intel.com>
Date:   Thu, 18 Jun 2020 07:41:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617190757.27081-5-john.s.andersen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/17/20 12:07 PM, John Andersen wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 89386f6f3ab6..54fb2b5ab8fc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3926,6 +3926,17 @@
>  			[KNL] Number of legacy pty's. Overwrites compiled-in
>  			default number.
>  
> +	pv_cr_pin	[SECURITY,X86]
> +			Enable paravirtualized control register pinning. When
> +			running paravirutalized under KVM, request that KVM not
> +			allow the guest to disable kernel protection features
> +			set in CPU control registers. Specifying this option
> +			will disable kexec (and crashkernel). If kexec support
> +			has not been compiled into the kernel and host KVM
> +			supports paravirtualized control register pinning, it
> +			will be active by default without the need to specify
> +			this parameter.

I'm writing this last in my review.  I guess I should have read this
first.  You'll see later in my review how this confused me.  This
behavior needs to be documented elsewhere.  Code comments would be best.

Let's say kexec is config'd off.  This feature is enabled by default and
crashes the kernel in early boot.  I have no way to disable this fancy
new feature.  Is that what we want?

I also think that instead of having to *enable* this explicitly when
kexec is present, maybe we should have a "disable_kexec" parameter.  If
kexec is configured out or disabled on the command-line, then you can
turn CR pinning on.

If someone fails to kexec() because of this feature, there's no way in
hell they'll ever track down "pv_cr_pin" on the command-line as the
cause.  The might have a chance of finding disable_kexec, though.

Wouldn't it also be nice to add a single printk() the first time a kexec
fails because of this feature being present?

>  	quiet		[KNL] Disable most log messages
>  
>  	r128=		[HW,DRM]
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 67f6a40b5e93..bc0b27483001 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -800,6 +800,7 @@ config KVM_GUEST
>  	bool "KVM Guest support (including kvmclock)"
>  	depends on PARAVIRT
>  	select PARAVIRT_CLOCK
> +	select PARAVIRT_CR_PIN
>  	select ARCH_CPUIDLE_HALTPOLL
>  	default y
>  	---help---
> @@ -835,6 +836,15 @@ config PARAVIRT_TIME_ACCOUNTING
>  config PARAVIRT_CLOCK
>  	bool
>  
> +config PARAVIRT_CR_PIN
> +       bool "Paravirtual bit pinning for CR0 and CR4"
> +       depends on KVM_GUEST
> +       help
> +         Select this option to have the virtualised guest request that the
> +         hypervisor disallow it from disabling protections set in control
> +         registers. The hypervisor will prevent exploits from disabling
> +         features such as SMEP, SMAP, UMIP, and WP.

I'm confused.  Does this add support for ""Paravirtual bit pinning", or
actually tell the guest to request pinning by default?

It says "Select this option to have the virtualised guest request...",
which makes it sound like it affects the default rather than the
availability of the option.


> +#ifdef CONFIG_PARAVIRT_CR_PIN
> +void __init kvm_paravirt_cr_pinning_init(void);
> +void kvm_setup_paravirt_cr_pinning(unsigned long cr0_pinned_bits,
> +				   unsigned long cr4_pinned_bits);
> +#else
> +static inline void kvm_paravirt_cr_pinning_init(void)
> +{
> +	return;
> +}
> +
> +static inline void kvm_setup_paravirt_cr_pinning(unsigned long cr0_pinned_bits,
> +						 unsigned long cr4_pinned_bits)
> +{
> +	return;
> +}
> +#endif /* CONFIG_PARAVIRT_CR_PIN */

For stuff like this that isn't the least bit performance sensitive, I
usually don't bother with header stubs.  Just do the function
declaration and then check the config option in the .c code.  It saves
#ifdef noise in the header.

>  #endif /* _ASM_X86_KVM_PARA_H */
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 921e67086a00..ee17223b1fa8 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -21,6 +21,7 @@
>  #include <linux/smp.h>
>  #include <linux/io.h>
>  #include <linux/syscore_ops.h>
> +#include <linux/kvm_para.h>
>  
>  #include <asm/stackprotector.h>
>  #include <asm/perf_event.h>
> @@ -416,6 +417,8 @@ static void __init setup_cr_pinning(void)
>  	mask = (X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP);
>  	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & mask;
>  	static_key_enable(&cr_pinning.key);
> +
> +	kvm_setup_paravirt_cr_pinning(X86_CR0_WP, cr4_pinned_bits);
>  }
>  
>  /*
> @@ -1551,6 +1554,8 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
>  	mtrr_ap_init();
>  	validate_apic_and_package_id(c);
>  	x86_spec_ctrl_setup_ap();
> +
> +	kvm_setup_paravirt_cr_pinning(X86_CR0_WP, cr4_pinned_bits);
>  }

WP looks like it get special handling here.  But, why it is special goes
unmentioned in the changelog or comments.

Why is it special?

> +#ifdef CONFIG_PARAVIRT_CR_PIN
> +static int kvm_paravirt_cr_pinning_enabled __ro_after_init;
> +
> +void __init kvm_paravirt_cr_pinning_init(void)
> +{
> +#ifdef CONFIG_KEXEC_CORE
> +	if (!cmdline_find_option_bool(boot_command_line, "pv_cr_pin"))
> +		return;
> +
> +	/* Paravirtualized CR pinning is currently incompatible with kexec */
> +	kexec_load_disabled = 1;
> +#endif
> +
> +	kvm_paravirt_cr_pinning_enabled = 1;
> +}

This is why we don't like #ifdefs in .c files.  The CONFIG_KEXEC_CORE
one really makes this unreadable.

This is really confusing because it says, if "CONFIG_KEXEC_CORE" is off,
don't bother with looking for "pv_cr_pin" on the command-line before
setting kvm_paravirt_cr_pinning_enabled=1.  That doesn't make any sense
to me.

> +void kvm_setup_paravirt_cr_pinning(unsigned long cr0_pinned_bits,
> +				   unsigned long cr4_pinned_bits)
> +{
> +	u64 mask;
> +
> +	if (!kvm_paravirt_cr_pinning_enabled)
> +		return;
> +
> +	if (!kvm_para_has_feature(KVM_FEATURE_CR_PIN))
> +		return;

So, if we compiled this whole mess in and got the new command-line
parameter and we got all the way here and the host doesn't support it,
we silently return?

Seems like it would at least deserve a pr_info().

> +	rdmsrl(MSR_KVM_CR0_PIN_ALLOWED, mask);
> +	wrmsrl(MSR_KVM_CR0_PINNED_HIGH, cr0_pinned_bits & mask);
> +
> +	rdmsrl(MSR_KVM_CR4_PIN_ALLOWED, mask);
> +	wrmsrl(MSR_KVM_CR4_PINNED_HIGH, cr4_pinned_bits & mask);
> +}
> +#endif
> +
>  #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
>  
>  static void kvm_disable_host_haltpoll(void *i)
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d9c678b37a9b..ed3bcc85d40d 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -27,6 +27,9 @@
>  #include <asm/apic.h>
>  #include <asm/bios_ebda.h>
>  #include <asm/bugs.h>
> +#include <asm/kasan.h>
> +#include <asm/cmdline.h>
> +
>  #include <asm/cpu.h>
>  #include <asm/efi.h>
>  #include <asm/gart.h>
> @@ -502,6 +505,11 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> +	if (cmdline_find_option_bool(boot_command_line, "pv_cr_pin")) {
> +		pr_info("Ignoring crashkernel since pv_cr_pin present in cmdline\n");
> +		return;
> +	}

Isn't it a bit mean to ignore crashkernel if the kernel has
CONFIG_PARAVIRT_CR_PIN=n?


