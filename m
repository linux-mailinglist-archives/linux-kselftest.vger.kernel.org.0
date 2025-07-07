Return-Path: <linux-kselftest+bounces-36717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94AAFB960
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2818B165038
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FE023C8CE;
	Mon,  7 Jul 2025 16:58:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDA922F14C;
	Mon,  7 Jul 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907527; cv=none; b=L/KDoV7w+FKCENjbGcY4qm4dt5ROtjI3xVAyJgURkPuEVy6kjhYrkdyvQfXkm+zKhzNWyA+aRi/e7yDjloKFOnWJdhZzb0f04UrnzcI8KQdUCoGvqc/3PyT64n5W+4NLb8fUXLgnf4l0/MsWfMkmOsbKHEE46ArQ+1FXasDW/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907527; c=relaxed/simple;
	bh=lY8irBtYxVyHLKyGJiGCmG2opDnFdh+FVadST8BlZQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9qEnBkmBICLba01InyRfnsQy+uf79kyAM8PfOhSOEiCCbu+65F7gkACZXaerHIqE7C2t5tFQtZ3ByM1M3OWEoYOyt76YUiAG/h/xupqdsAxAzMPZ+QuxBv9PA3an57zlNAFw+7lgotj1+ajNoEwz4qbYwe1l0L0OZf2Qy+SEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 405C6168F;
	Mon,  7 Jul 2025 09:58:32 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 093CC3F66E;
	Mon,  7 Jul 2025 09:58:40 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:58:38 +0100
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
Subject: Re: [PATCH v3 07/22] perf: arm_pmuv3: Generalize counter bitmasks
Message-ID: <aGv8vgrZTET0aXjQ@J2N7QTR9R3>
References: <20250626200459.1153955-1-coltonlewis@google.com>
 <20250626200459.1153955-8-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626200459.1153955-8-coltonlewis@google.com>

On Thu, Jun 26, 2025 at 08:04:43PM +0000, Colton Lewis wrote:
> The OVSR bitmasks are valid for enable and interrupt registers as well as
> overflow registers. Generalize the names.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

FWIW, this looks fine to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/arm_pmuv3.c       |  4 ++--
>  include/linux/perf/arm_pmuv3.h | 14 +++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 6358de6c9fab..3bc016afea34 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -513,7 +513,7 @@ static u64 armv8pmu_pmcr_n_read(void)
>  
>  static int armv8pmu_has_overflowed(u64 pmovsr)
>  {
> -	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
> +	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
>  }
>  
>  static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
> @@ -749,7 +749,7 @@ static u64 armv8pmu_getreset_flags(void)
>  	value = read_pmovsclr();
>  
>  	/* Write to clear flags */
> -	value &= ARMV8_PMU_OVERFLOWED_MASK;
> +	value &= ARMV8_PMU_CNT_MASK_ALL;
>  	write_pmovsclr(value);
>  
>  	return value;
> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
> index d698efba28a2..fd2a34b4a64d 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -224,14 +224,14 @@
>  				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
>  
>  /*
> - * PMOVSR: counters overflow flag status reg
> + * Counter bitmask layouts for overflow, enable, and interrupts
>   */
> -#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
> -#define ARMV8_PMU_OVSR_C		BIT(31)
> -#define ARMV8_PMU_OVSR_F		BIT_ULL(32) /* arm64 only */
> -/* Mask for writable bits is both P and C fields */
> -#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C | \
> -					ARMV8_PMU_OVSR_F)
> +#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
> +#define ARMV8_PMU_CNT_MASK_C		BIT(31)
> +#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
> +#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
> +					 ARMV8_PMU_CNT_MASK_C | \
> +					 ARMV8_PMU_CNT_MASK_F)
>  
>  /*
>   * PMXEVTYPER: Event selection reg
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

