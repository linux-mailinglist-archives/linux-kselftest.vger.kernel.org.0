Return-Path: <linux-kselftest+bounces-29647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEFDA6DD7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 15:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BB5167534
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E08526136C;
	Mon, 24 Mar 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeiKvLJ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5325F974
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828035; cv=none; b=bkJ1YHEJTJnnjMqom9sXKYkW1eVd9GWex61xyp3LUfMOYa0QIFmAlOiNtadV4JIQVIedBGcj9x/qy5S2saaN5Pey/IkGHs8cJqg0ZrIoY6+u26VaddfmjLMzpCtd5lY2LAeUGiolLTuUt9xmhgz9oabEuHBC/yusECmgfK40ZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828035; c=relaxed/simple;
	bh=VXjWCYi/FucuhzSs5PTSDrkPnV147MkSBxHinUM3cYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr5ztEMsW+3LdcumX8V0l7AfoRjG/dNF8yRZjxrqjTezLBDiA8D+ox3FT6zHZhkluARB8nPbmDP/0SJEeSiJRwyY4ZEr9ybbzMrFwYICK+q3L5ED0dZOmy4iptWigyDH1nbbYIVOlAaBrsBrj20apGGZnB8QF/01lcAQh9PdLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WeiKvLJ7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a823036so45969605e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742828031; x=1743432831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UP3A7AzTUdDx2k3cc0G/GBxzIeo6h3cZdgbt8xy+hJE=;
        b=WeiKvLJ7bLaHc9ecae9xVfdvvuVRvQURjFVs3P3KWp4pczEEEyT5Sen//mrsG5zDty
         2ENi7AgLrjm3d8iavTWrZWC3U0W5JLGWpAqEB/ielJozGMlAPlUgjzbUxdxp6gs52OLQ
         TRWbRHKa+/tATeUEzdf3TuYQcs1DWF4a+OrMoyGQISqxxHAHcffeb2E8k0blgK08mjGg
         MFM6OUiGcqEFWqvvMapMBQ5G/Umo8Jr/W0G51WWKO8HPJvCQ2ALRHHgM7S3F9bvfrb49
         vzkeUeWHenwoOhTDAONyKH8yI7nUO8dZNMDdFMeNRmcJisXg46eC17sJdpF5vgWRexj5
         JGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828031; x=1743432831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UP3A7AzTUdDx2k3cc0G/GBxzIeo6h3cZdgbt8xy+hJE=;
        b=OHJ3jc6SYVNXSkQ8gpoPCkqjlbSC6CQ1rJoO6pFl2DL6iQL9NW7Hn9EKhBMs3c6Pia
         jFpn4QufAqBtvjtd3wSmerDjK4SsbM5jhAybgvOMSymOTnvcy/kRRC/cmacN/rSoqj/J
         osXTMEThSrYSCPaBOXYzbecf+CLiT++V9a7+sGTqe8gPENLsHWFQOQeJsf/OzEOK/BP4
         Lw9dlreaVTQL0mBgYIx8fjd03h1EKNEZ/dR67V4lHamts9iYGFOVeI/I1MruSw6y3p9y
         5mTwfrXGWyp1LCLVsGZ3xs37tJxO92Bu2+wosTRqPawYeTmwyRM5n1b7bXPxC6FnPogO
         RNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUePSUXiPAIBAqLsfDqJd9HnnhlRYnVlWgnEYrCC3FhyOFKrEKl4n2WKQvUupKOBu5fl6WF05ytLbgJVpClskU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVdHlHQgaRXhrN/Pc36ERip8vA0vZ91+KFvNV0+Mb88qZzB68
	sopfI+C0feCHRBBkoJn021n7q2YtiGFdjvsPuN71PzTSgE5IoaFZ88Rt+R4ZsqQ=
X-Gm-Gg: ASbGnctjo8uP/RuXJkqqVh2eYackj0/5oremwrx1oCX84YvdUn8EjB3LHUG/Q1sLeW6
	J/gnfkWLOm2GqfqtMwVb4UDYNg1lFzRetI+EAzN/vWQdx8EMzkAHEdimwUeQXcKHqbrvlUHXypG
	WknFhoteGLVQhk5z1fLPs1J9C96bRo+w6QBlD5sp0gUtt2E5/VYuOBB19Qh/VRmOj0dVjOoOCRb
	ynjqpQlmg9k1sPlDdB9F9mzikZZqjK09/pILXetpwQJGMGvxSczIbiHnF3EXvd2C23aYTFmH0P0
	RJopIadWBOAEdiQm6lNz4K3b5e6Mon+sMUKZUGYr1P9Hjz5GHlvx/w==
X-Google-Smtp-Source: AGHT+IERD/lwgktHe1Gj0uOoU3mqIfghEPMcgOZyKwvdtvQ2ECRJ6/LWjoGQZyKkvoSi7h0+Iw8HAg==
X-Received: by 2002:a05:600c:4503:b0:43c:fa24:873e with SMTP id 5b1f17b1804b1-43d509f4fc0mr119622315e9.13.1742828031427;
        Mon, 24 Mar 2025 07:53:51 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.90.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd27980sm124839625e9.21.2025.03.24.07.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 07:53:51 -0700 (PDT)
Message-ID: <d018f56a-15c3-4739-b8f4-aea863006765@linaro.org>
Date: Mon, 24 Mar 2025 14:53:49 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/8] KVM: arm64: Introduce module param to
 partition the PMU
To: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250213180317.3205285-1-coltonlewis@google.com>
 <20250213180317.3205285-6-coltonlewis@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250213180317.3205285-6-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/02/2025 6:03 pm, Colton Lewis wrote:
> For PMUv3, the register MDCR_EL2.HPMN partitiones the PMU counters
> into two ranges where counters 0..HPMN-1 are accessible by EL1 and, if
> allowed, EL0 while counters HPMN..N are only accessible by EL2.
> 
> Introduce a module parameter in KVM to set this register. The name
> reserved_host_counters reflects the intent to reserve some counters
> for the host so the guest may eventually be allowed direct access to a
> subset of PMU functionality for increased performance.
> 
> Track HPMN and whether the pmu is partitioned in struct arm_pmu
> because both KVM and the PMUv3 driver will need to know that to handle
> guests correctly.
> 
> Due to the difficulty this feature would create for the driver running
> at EL1 on the host, partitioning is only allowed in VHE mode. Working
> on nVHE mode would require a hypercall for every register access
> because the counters reserved for the host by HPMN are now only
> accessible to EL2.
> 
> The parameter is only configurable at boot time. Making the parameter
> configurable on a running system is dangerous due to the difficulty of
> knowing for sure no counters are in use anywhere so it is safe to
> reporgram HPMN.
> 

Hi Colton,

For some high level feedback for the RFC, it probably makes sense to 
include the other half of the feature at the same time. I think there is 
a risk that it requires something slightly different than what's here 
and there ends up being some churn.

Other than that I think it looks ok apart from some minor code review nits.

I was also thinking about how BRBE interacts with this. Alex has done 
some analysis that finds that it's difficult to use BRBE in guests with 
virtualized counters due to the fact that BRBE freezes on any counter 
overflow, rather than just guest ones. That leaves the guest with branch 
blackout windows in the delay between a host counter overflowing and the 
interrupt being taken and BRBE being restarted.

But with HPMN, BRBE does allow freeze on overflow of only one partition 
or the other (or both, but I don't think we'd want that) e.g.:

  RNXCWF: If EL2 is implemented, a BRBE freeze event occurs when all of
  the following are true:

  * BRBCR_EL1.FZP is 1.
  * Generation of Branch records is not paused.
  * PMOVSCLR_EL0[(MDCR_EL2.HPMN-1):0] is nonzero.
  * The PE is in a BRBE Non-prohibited region.

Unfortunately that means we could only let guests use BRBE with a 
partitioned PMU, which would massively reduce flexibility if hosts have 
to lose counters just so the guest can use BRBE.

I don't know if this is a stupid idea, but instead of having a fixed 
number for the partition, wouldn't it be nice if we could trap and 
increment HPMN on the first guest use of a counter, then decrement it on 
guest exit depending on what's still in use? The host would always 
assign its counters from the top down, and guests go bottom up if they 
want PMU passthrough. Maybe it's too complicated or won't work for 
various reasons, but because of BRBE the counter partitioning changes go 
from an optimization to almost a necessity.

> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm64/include/asm/kvm_pmu.h |  4 +++
>   arch/arm64/kvm/Makefile          |  2 +-
>   arch/arm64/kvm/debug.c           |  9 ++++--
>   arch/arm64/kvm/pmu-part.c        | 47 ++++++++++++++++++++++++++++++++
>   arch/arm64/kvm/pmu.c             |  2 ++
>   include/linux/perf/arm_pmu.h     |  2 ++
>   6 files changed, 62 insertions(+), 4 deletions(-)
>   create mode 100644 arch/arm64/kvm/pmu-part.c
> 
> diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
> index 613cddbdbdd8..174b7f376d95 100644
> --- a/arch/arm64/include/asm/kvm_pmu.h
> +++ b/arch/arm64/include/asm/kvm_pmu.h
> @@ -22,6 +22,10 @@ bool kvm_set_pmuserenr(u64 val);
>   void kvm_vcpu_pmu_resync_el0(void);
>   void kvm_host_pmu_init(struct arm_pmu *pmu);
>   
> +u8 kvm_pmu_get_reserved_counters(void);
> +u8 kvm_pmu_hpmn(u8 nr_counters);
> +void kvm_pmu_partition(struct arm_pmu *pmu);
> +
>   #else
>   
>   static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 3cf7adb2b503..065a6b804c84 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -25,7 +25,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
>   	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
>   	 vgic/vgic-its.o vgic/vgic-debug.o
>   
> -kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
> +kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu-part.o pmu.o
>   kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
>   kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
>   
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 7fb1d9e7180f..b5ac5a213877 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -31,15 +31,18 @@
>    */
>   static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>   {
> +	u8 counters = *host_data_ptr(nr_event_counters);
> +	u8 hpmn = kvm_pmu_hpmn(counters);
> +
>   	preempt_disable();
>   

Would you not need to use vcpu->cpu here to access host_data? The 
preempt_disable() after the access seems suspicious. I think you'll end 
up with the same issue as here:

https://lore.kernel.org/kvmarm/5edb7c69-f548-4651-8b63-1643c5b13dac@linaro.org/

>   	/*
>   	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>   	 * to disable guest access to the profiling and trace buffers
>   	 */
> -	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
> -					 *host_data_ptr(nr_event_counters));
> -	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
> +	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, hpmn);
> +	vcpu->arch.mdcr_el2 |= (MDCR_EL2_HPMD |
> +				MDCR_EL2_TPM |
>   				MDCR_EL2_TPMS |
>   				MDCR_EL2_TTRF |
>   				MDCR_EL2_TPMCR |
> diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
> new file mode 100644
> index 000000000000..e74fecc67e37
> --- /dev/null
> +++ b/arch/arm64/kvm/pmu-part.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Google LLC
> + * Author: Colton Lewis <coltonlewis@google.com>
> + */
> +
> +#include <linux/kvm_host.h>
> +#include <linux/perf/arm_pmu.h>
> +
> +#include <asm/kvm_pmu.h>
> +
> +static u8 reserved_host_counters __read_mostly;
> +
> +module_param(reserved_host_counters, byte, 0);
> +MODULE_PARM_DESC(reserved_host_counters,
> +		 "Partition the PMU into host and guest counters");
> +
> +u8 kvm_pmu_get_reserved_counters(void)
> +{
> +	return reserved_host_counters;
> +}
> +
> +u8 kvm_pmu_hpmn(u8 nr_counters)
> +{
> +	if (reserved_host_counters >= nr_counters) {
> +		if (this_cpu_has_cap(ARM64_HAS_HPMN0))
> +			return 0;
> +
> +		return 1;
> +	}
> +
> +	return nr_counters - reserved_host_counters;
> +}
> +
> +void kvm_pmu_partition(struct arm_pmu *pmu)
> +{
> +	u8 nr_counters = *host_data_ptr(nr_event_counters);
> +	u8 hpmn = kvm_pmu_hpmn(nr_counters);
> +
> +	if (hpmn < nr_counters) {
> +		pmu->hpmn = hpmn;
> +		pmu->partitioned = true;

Looks like Rob's point about pmu->partitioned being duplicate data 
stands again. On the previous version you mentioned that saving it was 
to avoid reading PMCR.N, but now it's not based on PMCR.N anymore.

Thanks
James


