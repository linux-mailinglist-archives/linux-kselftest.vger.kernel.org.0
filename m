Return-Path: <linux-kselftest+bounces-36709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68227AFB841
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 18:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED0817B5C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2635321FF57;
	Mon,  7 Jul 2025 16:05:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564042049;
	Mon,  7 Jul 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904316; cv=none; b=RbG84uTMBYXHPhdZ/HKPsZwMSvLZowcm02c6ysmPS95o+nfnyz5LH3FsQqi3snjJd8wqkM1UNe5xBfuh3tRiK1m4zmPlFjIka49xk5qjBxcicen55AmCFmtPoOw7wrtbvh/1RwZVZWpJPi1XTApKBd+vo6mxY+8Lr621SwQWdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904316; c=relaxed/simple;
	bh=RtFr/cqQgHAVjVm38k71NKvlszLoElaLqQn9+ycjRsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGYaVxp1iOD1+mdNmHZxK0sHgOcOF/9Kx51NH9WPc6F93ko/lPzknHdPEyqa7jEzJaRXlMs1Cimn64hRAIJgmL9M35y1cUyLRlVt+zpo02hxurHyt5eXEzt7GSwXN5/aPKNcDibbuRBGo2DR/pkTPqXXioGn7mD02fUd7yk9QHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8501C168F;
	Mon,  7 Jul 2025 09:05:00 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 426BA3F694;
	Mon,  7 Jul 2025 09:05:09 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:05:00 +0100
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
Subject: Re: [PATCH v3 01/22] arm64: cpufeature: Add cpucap for HPMN0
Message-ID: <aGvwLIAN8rhxtA_V@J2N7QTR9R3>
References: <20250626200459.1153955-1-coltonlewis@google.com>
 <20250626200459.1153955-2-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626200459.1153955-2-coltonlewis@google.com>

On Thu, Jun 26, 2025 at 08:04:37PM +0000, Colton Lewis wrote:
> Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
> counters reserved for the guest.
> 
> This required changing HPMN0 to an UnsignedEnum in tools/sysreg
> because otherwise not all the appropriate macros are generated to add
> it to arm64_cpu_capabilities_arm64_features.

I agree it's appropriate to mark ID_AA64DFR0_EL1.HPMN0 as an
UnsignedEnum. It follows the usual ID scheme per ARM DDI 0487 L.a
section D24.1.3, and zero means not present, so it must be unsigned.

Likewise, the value renames (UNPREDICTABLE => NI and DEF => IMP) look
fine to me.

> Signed-off-by: Colton Lewis <coltonlewis@google.com>

I have one minor nit below, but either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  arch/arm64/kernel/cpufeature.c | 8 ++++++++
>  arch/arm64/tools/cpucaps       | 1 +
>  arch/arm64/tools/sysreg        | 6 +++---
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index b34044e20128..73a7dac4b6f6 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -548,6 +548,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_HPMN0_SHIFT, 4, 0),
>  	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
> @@ -2896,6 +2897,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_cpuid_feature,
>  		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, FGT, FGT2)
>  	},
> +	{
> +		.desc = "FEAT_HPMN0",

Minor nit, but we can drop the "FEAT_" prefix here, for consistency with
other features (e.g. E0PD, FPMR).

Mark.

> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.capability = ARM64_HAS_HPMN0,
> +		.matches = has_cpuid_feature,
> +		ARM64_CPUID_FIELDS(ID_AA64DFR0_EL1, HPMN0, IMP)
> +	},
>  #ifdef CONFIG_ARM64_SME
>  	{
>  		.desc = "Scalable Matrix Extension",
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 10effd4cff6b..5b196ba21629 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -39,6 +39,7 @@ HAS_GIC_CPUIF_SYSREGS
>  HAS_GIC_PRIO_MASKING
>  HAS_GIC_PRIO_RELAXED_SYNC
>  HAS_HCR_NV1
> +HAS_HPMN0
>  HAS_HCX
>  HAS_LDAPR
>  HAS_LPA2
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 8a8cf6874298..d29742481754 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1531,9 +1531,9 @@ EndEnum
>  EndSysreg
>  
>  Sysreg	ID_AA64DFR0_EL1	3	0	0	5	0
> -Enum	63:60	HPMN0
> -	0b0000	UNPREDICTABLE
> -	0b0001	DEF
> +UnsignedEnum	63:60	HPMN0
> +	0b0000	NI
> +	0b0001	IMP
>  EndEnum
>  UnsignedEnum	59:56	ExtTrcBuff
>  	0b0000	NI
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

