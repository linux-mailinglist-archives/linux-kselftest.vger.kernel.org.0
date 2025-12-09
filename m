Return-Path: <linux-kselftest+bounces-47344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9C7CB1448
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 23:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E9B309B76D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 22:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71422DC79B;
	Tue,  9 Dec 2025 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em8ivC6c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684882C236B;
	Tue,  9 Dec 2025 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765318015; cv=none; b=kzJVrQHygOxk6aiN936HGCF0yuKinxwOZM7304t/0KbYnSWtEF58ulcqdXD5QJcJzsO8SAWf48qtbN7fHp3Qk35YQDsYgdmjLJPScAAuyqcI1VxHVtfcElY1af7bvoTNM5OZQHJE0frODWvE37MM/Wu6PXUPz4PO1pCUcIi2/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765318015; c=relaxed/simple;
	bh=hJlyVUcqwe/6I5rw8HcTwWNqs3JR5pxz8OctmF8nuHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioPswIG23+/5dRfoTtfdycB0zjQdEAfP2Cd9RnFSxhnHwrPwkVdz2n7wxdZECbLoJghMaEYookC6R7N+ocZNHYziw2X/3pOIX9uPGCyusjB8FwjF3A95lowHdGzH1aPYTwTi5wYCGtdek/B3N4Kbk7OpkUM0G6+tfYy9TmDs95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em8ivC6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC2BC4CEF5;
	Tue,  9 Dec 2025 22:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765318015;
	bh=hJlyVUcqwe/6I5rw8HcTwWNqs3JR5pxz8OctmF8nuHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Em8ivC6cdTSKDYgeEVhdAvnJtZvxHovwnqqy4edM8a1JYCcXWTSmWGTRxGNjRUa9H
	 S3k7L+RcEKd7ztjWq17ETvXgbZCmP+XH8GsI1z1s6OPWlXMi1QShYGw7WGZdnkLUAu
	 U2ChGGJzz9FUb9m4VqcIrYo+2jsJ3ZsQz84un5mp1WZMxYjTa6IBkNqPoSSs+9zi5e
	 /HROCoKUbOBd85CXFw+uvxQ7eHNLM40dAF5ZdUc7S665pdG8Q0tzMk0AlMMtFH5gyH
	 ZWjYFDEQmeZZOimoUOWtNnOwElSn/sP09OAnaDJc/twYOZOr+NJpser5835S75zblY
	 6fkwt+14oY2VA==
Date: Tue, 9 Dec 2025 14:06:53 -0800
From: Oliver Upton <oupton@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 19/24] KVM: arm64: Implement lazy PMU context swaps
Message-ID: <aTidfRwYLYwTfmK_@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-20-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-20-coltonlewis@google.com>

On Tue, Dec 09, 2025 at 08:51:16PM +0000, Colton Lewis wrote:
> +enum vcpu_pmu_register_access {
> +	VCPU_PMU_ACCESS_UNSET,
> +	VCPU_PMU_ACCESS_VIRTUAL,
> +	VCPU_PMU_ACCESS_PHYSICAL,
> +};

This is confusing. Even when the guest is accessing registers directly
on the CPU I'd still call that "hardware assisted virtualization" and
not "physical".

> +#endif /* _ASM_ARM64_KVM_TYPES_H */
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 0ab89c91e19cb..c2cf6b308ec60 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -34,7 +34,7 @@ static int cpu_has_spe(u64 dfr0)
>   *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
>   *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
>   */
> -static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
> +void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>  {
>  	int hpmn = kvm_pmu_hpmn(vcpu);
>  
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index bde79ec1a1836..ea288a712bb5d 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -963,6 +963,8 @@ static bool kvm_hyp_handle_pmu_regs(struct kvm_vcpu *vcpu)
>  	if (ret)
>  		__kvm_skip_instr(vcpu);
>  
> +	kvm_pmu_set_physical_access(vcpu);
> +
>  	return ret;
>  }
>  
> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 8d0d6d1a0d851..c5767e2ebc651 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -73,6 +73,7 @@ bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
>  	u8 hpmn = vcpu->kvm->arch.nr_pmu_counters;
>  
>  	return kvm_vcpu_pmu_is_partitioned(vcpu) &&
> +		vcpu->arch.pmu.access == VCPU_PMU_ACCESS_PHYSICAL &&
>  		cpus_have_final_cap(ARM64_HAS_FGT) &&
>  		(hpmn != 0 || cpus_have_final_cap(ARM64_HAS_HPMN0));
>  }
> @@ -92,6 +93,26 @@ u64 kvm_pmu_fgt2_bits(void)
>  		| HDFGRTR2_EL2_nPMICNTR_EL0;
>  }
>  
> +/**
> + * kvm_pmu_set_physical_access()
> + * @vcpu: Pointer to vcpu struct
> + *
> + * Reconfigure the guest for physical access of PMU hardware if
> + * allowed. This means reconfiguring mdcr_el2 and loading the vCPU
> + * state onto hardware.
> + *
> + */
> +
> +void kvm_pmu_set_physical_access(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)
> +	    && vcpu->arch.pmu.access == VCPU_PMU_ACCESS_VIRTUAL) {
> +		vcpu->arch.pmu.access = VCPU_PMU_ACCESS_PHYSICAL;
> +		kvm_arm_setup_mdcr_el2(vcpu);
> +		kvm_pmu_load(vcpu);
> +	}

It isn't immediately obvious how this guards against preemption.

Also, the general approach for these context-loading situations is to do
a full load/put on the vCPU rather than a directed load.

> +static void kvm_pmu_register_init(struct kvm_vcpu *vcpu)
> +{
> +	if (vcpu->arch.pmu.access == VCPU_PMU_ACCESS_UNSET)
> +		vcpu->arch.pmu.access = VCPU_PMU_ACCESS_VIRTUAL;

This is confusing. The zero value of the enum should be consistent with
the "unloaded" state.

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index f2ae761625a66..d73218706b834 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1197,6 +1197,8 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  		p->regval = __vcpu_sys_reg(vcpu, reg);
>  	}
>  
> +	kvm_pmu_set_physical_access(vcpu);
> +
>  	return true;
>  }
>  
> @@ -1302,6 +1304,8 @@ static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  		p->regval = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
>  	}
>  
> +	kvm_pmu_set_physical_access(vcpu);
> +
>  	return true;
>  }

Aren't there a ton of other registers the guest may access before
these two? Having generic PMU register accessors would allow you to
manage residence of PMU registers from a single spot.

Thanks,
Oliver

