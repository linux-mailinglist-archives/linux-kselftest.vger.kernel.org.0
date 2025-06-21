Return-Path: <linux-kselftest+bounces-35532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4DAE26CE
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 03:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405443BCAFC
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86F282FA;
	Sat, 21 Jun 2025 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lcs+3a2Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644F1F5E6
	for <linux-kselftest@vger.kernel.org>; Sat, 21 Jun 2025 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750468033; cv=none; b=SUGWQth8PByuooJ3H3UgHSQrU85BJuU8Oh1u2Oz2ai9TrXCRtrISX5mgcr/Itv/DrUhhdwhCzNXQRIWc4UhKRvKNmzeVtdaEr+Tgm2PjN52IuCQL2SZhRUup2gjpIuvUlUNjpiNqwBf5VvlFP2QymelXM2kzGpgAXGdk4VBMLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750468033; c=relaxed/simple;
	bh=pzLOXtwqX+R5ZkDJnNjc7FQ6HyDYUogvPcm4PoBIA2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVFer1sILjLus58raqElskBPBP/7ZhhlpdqknTJW8zA6fY+fTtHJ4k+HHfL/OpIiM6AAK9GKPxlyfl5Sq7EyTGDokR33/m0Rw16i8E6AXOPA/eaCXaekYvGMLU5DhUXa8P+k5rIyverfdzoA+XxdtVEgIXAq39WFbNW2mC/mIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lcs+3a2Z; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 20 Jun 2025 18:06:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750468018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9bGMpSO4WqiAydjTYI1BvmIFHA6ViKMaNDWLEKT1C0=;
	b=lcs+3a2ZLhflGQHKJ+gTgO7tBN917ZPbJW/VqGm5qDtkba9vGMlVsl2g4UsIib1GPpDr4G
	Qz0ka4yuqWFfIVF8ZG1dVxusdCKjloC/kN1XPEVs7C6tPFt7GQ6bMeuvijVPunIWZecPoH
	tkaZ/VVRFsn3eo+FUkZ0KJuGDM0AJ7I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 07/23] perf: arm_pmuv3: Introduce method to partition
 the PMU
Message-ID: <aFYFqrYRsmCi6oii@linux.dev>
References: <20250620221326.1261128-1-coltonlewis@google.com>
 <20250620221326.1261128-8-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620221326.1261128-8-coltonlewis@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 20, 2025 at 10:13:07PM +0000, Colton Lewis wrote:
> For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
> counters into two ranges where counters 0..HPMN-1 are accessible by
> EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
> EL2.
> 
> Create module parameters partition_pmu and reserved_guest_counters to
> reserve a number of counters for the guest. These numbers are set at
> boot because the perf subsystem assumes the number of counters will
> not change after the PMU is probed.
> 
> Introduce the function armv8pmu_partition() to modify the PMU driver's
> cntr_mask of available counters to exclude the counters being reserved
> for the guest and record reserved_guest_counters as the maximum
> allowable value for HPMN.
> 
> Due to the difficulty this feature would create for the driver running
> at EL1 on the host, partitioning is only allowed in VHE mode. Working
> on nVHE mode would require a hypercall for every counter access in the
> driver because the counters reserved for the host by HPMN are only
> accessible to EL2.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm/include/asm/arm_pmuv3.h   | 10 ++++
>  arch/arm64/include/asm/arm_pmuv3.h |  5 ++
>  drivers/perf/arm_pmuv3.c           | 95 +++++++++++++++++++++++++++++-
>  include/linux/perf/arm_pmu.h       |  1 +
>  4 files changed, 109 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
> index 2ec0e5e83fc9..9dc43242538c 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -228,6 +228,11 @@ static inline bool kvm_set_pmuserenr(u64 val)
>  
>  static inline void kvm_vcpu_pmu_resync_el0(void) {}
>  
> +static inline bool has_vhe(void)
> +{
> +	return false;
> +}
> +

This has nothing to do with PMUv3, I'm a bit surprised to see you're
touching 32-bit ARM. Can you just gate the whole partitioning thing on
arm64?

> +static bool partition_pmu __read_mostly;
> +static u8 reserved_guest_counters __read_mostly;
> +
> +module_param(partition_pmu, bool, 0);
> +MODULE_PARM_DESC(partition_pmu,
> +		 "Partition the PMU into host and guest VM counters [y/n]");
> +
> +module_param(reserved_guest_counters, byte, 0);
> +MODULE_PARM_DESC(reserved_guest_counters,
> +		 "How many counters to reserve for guest VMs [0-$NR_COUNTERS]");
> +

This is confusing and not what we discussed offline.

Please use a single parameter that describes the number of counters used
by the *host*. This affects the *host* PMU driver, KVM can discover (and
use) the leftovers.

If the single module parameter goes unspecified the user did not ask for
PMU partitioning.

> +/**
> + * armv8pmu_reservation_is_valid() - Determine if reservation is allowed
> + * @guest_counters: Number of host counters to reserve
> + *
> + * Determine if the number of host counters in the argument is
> + * allowed. It is allowed if it will produce a valid value for
> + * register field MDCR_EL2.HPMN.
> + *
> + * Return: True if reservation allowed, false otherwise
> + */
> +static bool armv8pmu_reservation_is_valid(u8 guest_counters)
> +{
> +	return guest_counters <= armv8pmu_pmcr_n_read();
> +}
> +
> +/**
> + * armv8pmu_partition_supported() - Determine if partitioning is possible
> + *
> + * Partitioning is only supported in VHE mode (with PMUv3, assumed
> + * since we are in the PMUv3 driver)
> + *
> + * Return: True if partitioning is possible, false otherwise
> + */
> +static bool armv8pmu_partition_supported(void)
> +{
> +	return has_vhe();
> +}
> +
> +/**
> + * armv8pmu_partition() - Partition the PMU
> + * @pmu: Pointer to pmu being partitioned
> + * @guest_counters: Number of host counters to reserve
> + *
> + * Partition the given PMU by taking a number of host counters to
> + * reserve and, if it is a valid reservation, recording the
> + * corresponding HPMN value in the hpmn field of the PMU and clearing
> + * the guest-reserved counters from the counter mask.
> + *
> + * Passing 0 for @guest_counters has the effect of disabling partitioning.
> + *
> + * Return: 0 on success, -ERROR otherwise
> + */
> +static int armv8pmu_partition(struct arm_pmu *pmu, u8 guest_counters)
> +{
> +	u8 nr_counters;
> +	u8 hpmn;
> +
> +	if (!armv8pmu_reservation_is_valid(guest_counters))
> +		return -EINVAL;
> +
> +	nr_counters = armv8pmu_pmcr_n_read();
> +	hpmn = guest_counters;
> +
> +	pmu->hpmn_max = hpmn;

I'm not sure the host driver needs this for anything, KVM just needs to
know what's potentially in use by the host.

> +	/* Inform host driver of available counters */

... said the driver to itself :)

Thanks,
Oliver

