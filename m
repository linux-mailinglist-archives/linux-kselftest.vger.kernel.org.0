Return-Path: <linux-kselftest+bounces-36711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F11AFB874
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 18:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D924A267C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EC22128B;
	Mon,  7 Jul 2025 16:13:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BFA21B9E1;
	Mon,  7 Jul 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904799; cv=none; b=m6N1paO4MxCa9/6ksWJRFR16rblHbYH+D0gmJXio6BnBTivfQvUkt8KGe8oeM333+v4QeWZyZazOQL7d/tLhGp7BjvyjRx36IDEGb+f9s4orYxOoCfgEBVD9CagWhOInod7HxjPlKSYTJUODEUFDh0tbCWff8cUfZ0WLv9Vjp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904799; c=relaxed/simple;
	bh=RSfPX5OlM5EPwWYG9glTngNgWsvp+E2YSiuIqQJ6RuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENM7xmgD+6rK28VsN//au7Vdbu21KQ+rwENQSWqXdsF0215aKeUTyvJDudHm7FojiXmImy7konIlwwGr+Xd4s+E1UzbQq0sf5rAZefkcRR8DVfobn5MOc1iwuhH7ESvIK0EYS60XPcK4E5oFP3mZVXXdhoC++KsV9+vt/MaCNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30B30168F;
	Mon,  7 Jul 2025 09:13:04 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E71B83F694;
	Mon,  7 Jul 2025 09:13:12 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:13:10 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 04/22] KVM: arm64: Cleanup PMU includes
Message-ID: <aGvyFiyEEsMrhN0i@J2N7QTR9R3>
References: <20250626200459.1153955-1-coltonlewis@google.com>
 <20250626200459.1153955-5-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626200459.1153955-5-coltonlewis@google.com>

On Thu, Jun 26, 2025 at 08:04:40PM +0000, Colton Lewis wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> Reorganize these tangled headers.

In prior versions of this series, there was some earlier text explaining that
there was a circular header dependency. In v2:

  https://lore.kernel.org/linux-arm-kernel/20250620221326.1261128-6-coltonlewis@google.com/

... it said:

| asm/kvm_host.h includes asm/arm_pmu.h which includes perf/arm_pmuv3.h
| which includes asm/arm_pmuv3.h which includes asm/kvm_host.h This
| causes compilation problems why trying to use anything defined in any
| of the headers in any other headers.

Was there some reason for dropping that? It's a bit odd to start without a
problem statement.

> 
> * Respect the move defining the interface between KVM and PMU in its
>   own header asm/kvm_pmu.h
> 
> * Define an empty struct arm_pmu so it is defined for those interface
>   functions when compiling with CONFIG_KVM but not CONFIG_ARM_PMU

Which functions in particular are those? What prevents them from depending on
CONFIG_ARM_PMU?

Mark.

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm64/include/asm/arm_pmuv3.h      |  2 +-
>  arch/arm64/include/asm/kvm_host.h       | 15 +--------------
>  arch/arm64/include/asm/kvm_pmu.h        | 15 +++++++++++++++
>  arch/arm64/kvm/debug.c                  |  1 +
>  arch/arm64/kvm/hyp/include/hyp/switch.h |  1 +
>  arch/arm64/kvm/pmu.c                    |  2 ++
>  arch/arm64/kvm/sys_regs.c               |  1 +
>  include/linux/perf/arm_pmu.h            |  5 +++++
>  virt/kvm/kvm_main.c                     |  1 +
>  9 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
> index 8a777dec8d88..32c003a7b810 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -6,7 +6,7 @@
>  #ifndef __ASM_PMUV3_H
>  #define __ASM_PMUV3_H
>  
> -#include <asm/kvm_host.h>
> +#include <asm/kvm_pmu.h>
>  
>  #include <asm/cpufeature.h>
>  #include <asm/sysreg.h>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 27ed26bd4381..2df76689381a 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -14,6 +14,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/bitmap.h>
>  #include <linux/types.h>
> +#include <linux/irq_work.h>
>  #include <linux/jump_label.h>
>  #include <linux/kvm_types.h>
>  #include <linux/maple_tree.h>
> @@ -1487,25 +1488,11 @@ void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu);
>  void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
>  void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
>  
> -static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
> -{
> -	return (!has_vhe() && attr->exclude_host);
> -}
> -
>  #ifdef CONFIG_KVM
> -void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
> -void kvm_clr_pmu_events(u64 clr);
> -bool kvm_set_pmuserenr(u64 val);
>  void kvm_enable_trbe(void);
>  void kvm_disable_trbe(void);
>  void kvm_tracing_set_el1_configuration(u64 trfcr_while_in_guest);
>  #else
> -static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
> -static inline void kvm_clr_pmu_events(u64 clr) {}
> -static inline bool kvm_set_pmuserenr(u64 val)
> -{
> -	return false;
> -}
>  static inline void kvm_enable_trbe(void) {}
>  static inline void kvm_disable_trbe(void) {}
>  static inline void kvm_tracing_set_el1_configuration(u64 trfcr_while_in_guest) {}
> diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
> index baf028d19dfc..ad3247b46838 100644
> --- a/arch/arm64/include/asm/kvm_pmu.h
> +++ b/arch/arm64/include/asm/kvm_pmu.h
> @@ -11,9 +11,15 @@
>  #include <linux/kvm_types.h>
>  #include <linux/perf_event.h>
>  #include <linux/perf/arm_pmuv3.h>
> +#include <linux/perf/arm_pmu.h>
>  
>  #define KVM_ARMV8_PMU_MAX_COUNTERS	32
>  
> +#define kvm_pmu_counter_deferred(attr)			\
> +	({						\
> +		!has_vhe() && (attr)->exclude_host;	\
> +	})
> +
>  #if IS_ENABLED(CONFIG_HW_PERF_EVENTS) && IS_ENABLED(CONFIG_KVM)
>  struct kvm_pmc {
>  	u8 idx;	/* index into the pmu->pmc array */
> @@ -68,6 +74,9 @@ int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu,
>  int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu);
>  
>  struct kvm_pmu_events *kvm_get_pmu_events(void);
> +void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
> +void kvm_clr_pmu_events(u64 clr);
> +bool kvm_set_pmuserenr(u64 val);
>  void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
>  void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
>  void kvm_vcpu_pmu_resync_el0(void);
> @@ -161,6 +170,12 @@ static inline u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
>  
>  #define kvm_vcpu_has_pmu(vcpu)		({ false; })
>  static inline void kvm_pmu_update_vcpu_events(struct kvm_vcpu *vcpu) {}
> +static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
> +static inline void kvm_clr_pmu_events(u64 clr) {}
> +static inline bool kvm_set_pmuserenr(u64 val)
> +{
> +	return false;
> +}
>  static inline void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu) {}
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 1a7dab333f55..a554c3e368dc 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/kvm_host.h>
>  #include <linux/hw_breakpoint.h>
> +#include <linux/perf/arm_pmuv3.h>
>  
>  #include <asm/debug-monitors.h>
>  #include <asm/kvm_asm.h>
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index 7599844908c0..825b81749972 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -14,6 +14,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/types.h>
>  #include <linux/jump_label.h>
> +#include <linux/perf/arm_pmuv3.h>
>  #include <uapi/linux/psci.h>
>  
>  #include <asm/barrier.h>
> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
> index 6b48a3d16d0d..8bfc6b0a85f6 100644
> --- a/arch/arm64/kvm/pmu.c
> +++ b/arch/arm64/kvm/pmu.c
> @@ -8,6 +8,8 @@
>  #include <linux/perf/arm_pmu.h>
>  #include <linux/perf/arm_pmuv3.h>
>  
> +#include <asm/kvm_pmu.h>
> +
>  static DEFINE_PER_CPU(struct kvm_pmu_events, kvm_pmu_events);
>  
>  /*
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 99fdbe174202..eaff6d63ef77 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -18,6 +18,7 @@
>  #include <linux/printk.h>
>  #include <linux/uaccess.h>
>  #include <linux/irqchip/arm-gic-v3.h>
> +#include <linux/perf/arm_pmuv3.h>
>  
>  #include <asm/arm_pmuv3.h>
>  #include <asm/cacheflush.h>
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 6dc5e0cd76ca..fb382bcd4f4b 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -187,6 +187,11 @@ void armpmu_free_irq(int irq, int cpu);
>  
>  #define ARMV8_PMU_PDEV_NAME "armv8-pmu"
>  
> +#else
> +
> +struct arm_pmu {
> +};
> +
>  #endif /* CONFIG_ARM_PMU */
>  
>  #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e2f6344256ce..25259fcf3115 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -48,6 +48,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/kthread.h>
>  #include <linux/suspend.h>
> +#include <linux/perf_event.h>
>  
>  #include <asm/processor.h>
>  #include <asm/ioctl.h>
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

