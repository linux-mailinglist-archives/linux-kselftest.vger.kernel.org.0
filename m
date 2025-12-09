Return-Path: <linux-kselftest+bounces-47343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0641FCB1426
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 23:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1438C3011438
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 22:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359E27FD62;
	Tue,  9 Dec 2025 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE/ZjdtP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874E26E70E;
	Tue,  9 Dec 2025 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765317649; cv=none; b=mz42y35+TSmmuAi/HOhKcBlGDSc8js4tdKFPvPw5gXlEQDLSZy0o3OpnFa1Cy5k/GafO25FjwkpXCjyNLTLQrViDTlDXczZ1J387U8riYebn59OjU8rFuuGqeCLFX4xJTsnm5gxZyea9opiFtz2whPOcXI0TpeEl1MaONKqTFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765317649; c=relaxed/simple;
	bh=najPzs8LYqpcbLVewNTZ9DCSClDe9lHdNLzwaQhA54E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzbblbAFEh5iVmG6hEYVLADqgMCzZlsaiUTFB//n4bkxRtWjch+xR3+k3swerOko/yK1HZf4wYY40fQ+fnzrCyF4j3vZ9HPyl32JF8tMJRn35YCJC5ZtjNwu7xd/iwHTbQ6OkSqnjFhtWNUQO/3uzZj5TAsuihouXV72a1JJiqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE/ZjdtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2D3C4CEF5;
	Tue,  9 Dec 2025 22:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765317648;
	bh=najPzs8LYqpcbLVewNTZ9DCSClDe9lHdNLzwaQhA54E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CE/ZjdtPRs9rqbGD+S9DbYpCi/RdsPfmWXx3GEwbjcr3jPddlTbo5HemszHqS9FMB
	 /URO/MU+8Q5yPEF5fjERYGyEw9CZD2IGY9hTC/5h+M4BEa7g6nfj8xbwgpMci9tHAF
	 a9VI/96XXwggpqtURd08bniSHXarcxoOJYhEm7a8zmM1XcGG73UcC/tlHDNsJARxgx
	 rsISbY/jH4SU6DcLCv0UgeCIFL3rcoTcv7Y1/BfxguWNtGlfktTUA/EDJ/EUdL+X+x
	 2Gu/M9cvBDnsZTq2zj4jKn7+/w0hi4Uh+BxrtbJ1kAh3vGdtBe7ENgC28Ph4+2ZYRe
	 KRcOy74UxjoUg==
Date: Tue, 9 Dec 2025 14:00:47 -0800
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
Subject: Re: [PATCH v5 18/24] KVM: arm64: Enforce PMU event filter at
 vcpu_load()
Message-ID: <aTicD5hlKhZ3rkIn@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-19-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-19-coltonlewis@google.com>

On Tue, Dec 09, 2025 at 08:51:15PM +0000, Colton Lewis wrote:
> The KVM API for event filtering says that counters do not count when
> blocked by the event filter. To enforce that, the event filter must be
> rechecked on every load since it might have changed since the last
> time the guest wrote a value. If the event is filtered, exclude
> counting at all exception levels before writing the hardware.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm64/kvm/pmu-direct.c | 44 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 71977d24f489a..8d0d6d1a0d851 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -221,6 +221,49 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
>  	return nr_host_cnt_max;
>  }
>  
> +/**
> + * kvm_pmu_apply_event_filter()
> + * @vcpu: Pointer to vcpu struct
> + *
> + * To uphold the guarantee of the KVM PMU event filter, we must ensure
> + * no counter counts if the event is filtered. Accomplish this by
> + * filtering all exception levels if the event is filtered.
> + */
> +static void kvm_pmu_apply_event_filter(struct kvm_vcpu *vcpu)
> +{
> +	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
> +	u64 evtyper_set = ARMV8_PMU_EXCLUDE_EL0 |
> +		ARMV8_PMU_EXCLUDE_EL1;
> +	u64 evtyper_clr = ARMV8_PMU_INCLUDE_EL2;
> +	u8 i;
> +	u64 val;
> +	u64 evsel;
> +
> +	if (!pmu)
> +		return;
> +
> +	for (i = 0; i < pmu->hpmn_max; i++) {
> +		val = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i);
> +		evsel = val & kvm_pmu_event_mask(vcpu->kvm);
> +
> +		if (vcpu->kvm->arch.pmu_filter &&
> +		    !test_bit(evsel, vcpu->kvm->arch.pmu_filter))
> +			val |= evtyper_set;
> +
> +		val &= ~evtyper_clr;
> +		write_pmevtypern(i, val);
> +	}
> +
> +	val = __vcpu_sys_reg(vcpu, PMCCFILTR_EL0);
> +
> +	if (vcpu->kvm->arch.pmu_filter &&
> +	    !test_bit(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, vcpu->kvm->arch.pmu_filter))
> +		val |= evtyper_set;
> +
> +	val &= ~evtyper_clr;
> +	write_pmccfiltr(val);
> +}

This doesn't work for nested. I agree that the hardware value of
PMEVTYPERn_EL0 needs to be under KVM control, but depending on whether
or not we're in a hyp context the meaning of the EL1 filtering bit
changes. Have a look at kvm_pmu_create_perf_event().

Thanks,
Oliver

