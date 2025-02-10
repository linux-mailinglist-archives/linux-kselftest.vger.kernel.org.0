Return-Path: <linux-kselftest+bounces-26150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B58A2E583
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 08:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32021888577
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDD11B0F21;
	Mon, 10 Feb 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vE+uFLIC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9419DF99
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173090; cv=none; b=cZ8z1Y2/0HZSIeC0quJuDuqCLTrunBcj2zKdOV/GGkzet4yGr4KlYIVPmWIYLNucV0SdBeQQnoPtbIP/MK0SlhowWUZmqEdXvzXcaem1SVNQd/G+/kSJ81ctHRujXnq1vmaQcv57NScVDSgUA+JV1dH1urSymSSIXzN4iRcCVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173090; c=relaxed/simple;
	bh=TaXGkoKUS8R+zFSCLF80h16FwvqPvX+aex6ojMA0n/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjuaMtj59MRcuW2QYVF8rcx850WuJYVXpjUAfSBoTa6HHZEmBzYVnFJtYcF4MncDeb2nspn4MkIYU1cc/pWxyU9MruKD00peZNaCheasX5R/1UHPjyjzS7FovQFfx8Ca+04Il6tWCU+DdVYQNvUGaSXhd9ur/kY2jXbdWPQEnjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vE+uFLIC; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 9 Feb 2025 23:37:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739173074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOcYg4xLzinXROvIPIR5xsQLZpAtozt5q5hAITBaMhs=;
	b=vE+uFLICHjimFS+ICMuI/HAxyfSAu4mZ77bZ828qh8f1L3qfRfmo59IMZeBXvGqrssiFNy
	fCDND8KVpd50CISMkA7uHWCg7qYodaAjGO7IKKFCD9XIxPUn6IH9CRdkFsXbLsLOLX8lhP
	OfDwEiCmz/G8voMwdIN56pm3FuFnd8I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] KVM: arm64: Make guests see only counters
 they can access
Message-ID: <Z6msyUG0HWM2EImQ@linux.dev>
References: <20250208020111.2068239-1-coltonlewis@google.com>
 <20250208020111.2068239-5-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208020111.2068239-5-coltonlewis@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 08, 2025 at 02:01:11AM +0000, Colton Lewis wrote:
> The ARM architecture specifies that when MDCR_EL2.HPMN is set, EL1 and
> EL0, which includes KVM guests, should read that value for PMCR.N.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm64/kvm/debug.c                                  | 3 +--
>  arch/arm64/kvm/pmu-emul.c                               | 8 +++++++-
>  tools/testing/selftests/kvm/arm64/vpmu_counter_access.c | 2 +-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 0e4c805e7e89..7c04db00bf6c 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -36,8 +36,7 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>  	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>  	 * to disable guest access to the profiling and trace buffers
>  	 */
> -	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
> -					 *host_data_ptr(nr_event_counters));
> +	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, read_mdcr());

Please avoid unnecessary accesses to MDCR_EL2 at all costs. This is a
guaranteed trap to EL2 with nested virt.

>  	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
>  				MDCR_EL2_TPMS |
>  				MDCR_EL2_TTRF |
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index 6c5950b9ceac..052ce8c721fe 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -993,12 +993,18 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
>  u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
>  {
>  	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
> +	u8 limit;
> +
> +	if (arm_pmu->partitioned)
> +		limit = arm_pmu->hpmn - 1;
> +	else
> +		limit = ARMV8_PMU_MAX_GENERAL_COUNTERS;
>  
>  	/*
>  	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
>  	 * Ignore those and return only the general-purpose counters.
>  	 */
> -	return bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
> +	return bitmap_weight(arm_pmu->cntr_mask, limit);
>  }

This isn't necessary and is likely to regress the existing behavior.

When the architecture says the lower ELs should see PMCR_EL0.N have the
same value as MDCR_EL2.HPMN, what it really means is direct reads from
hardware will return the value.

So my expectation would be that a VM using the partitioned PMU
implementation would never reach any of the *emulated* PMU handlers, as
we would've disabled the associated traps.

The partitioned PMU will not replace the emulated vPMU implementation in
KVM, so it'd be good to refactor what we have today to make room for
your work. I think that'd be along the lines of:

 - Shared code for event filter enforcement and handling of the vPMU
   overflow IRQ.

 - Emulated PMU implementation that provides trap handlers for all PMUv3
   registers and backs into host perf

 - Partitioned PMU implementation that doesn't rely on traps and instead
   saves / restores a portion of the PMU that contains the guest
   context.

These should be done in separate files, i.e. I do not want to see a
bunch of inline handling to cope with emulated v. partitioned PMUs.

>  static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
> diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> index f16b3b27e32e..b5bc18b7528d 100644
> --- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> +++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> @@ -609,7 +609,7 @@ static void run_pmregs_validity_test(uint64_t pmcr_n)
>   */
>  static void run_error_test(uint64_t pmcr_n)
>  {
> -	pr_debug("Error test with pmcr_n %lu (larger than the host)\n", pmcr_n);
> +	pr_debug("Error test with pmcr_n %lu (larger than the host allows)\n", pmcr_n);

NBD for an RFC, but in the future please do selftests changes in a
separate patch.

-- 
Thanks,
Oliver

