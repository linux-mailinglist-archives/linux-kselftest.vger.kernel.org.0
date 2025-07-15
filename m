Return-Path: <linux-kselftest+bounces-37391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 482BCB069D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 01:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1C61C2066D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 23:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1742D3A93;
	Tue, 15 Jul 2025 23:22:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D6F7261D;
	Tue, 15 Jul 2025 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621744; cv=none; b=u5l8VzG8J+28OwBiL+2dSVDJ2zRMDqU4lmROETeoN7C8kGNwB/nq7gw6JQVJyLaLgCY/z3qiadwfzS5QTGHGmGWqxUpv4ryeqzF0rLMwIj/dTZnvo+gJbj0cP2y7+0fWg9k9pHrZrBgVeYGIE2UVbWv8BVH4HxnpGNpJy1R4z+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621744; c=relaxed/simple;
	bh=x67+Hru3euykHmBuyLooA2lRlilf1qyeV+pefGwKg6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwLNMyXU1yQU9DCvOy5/6PkYU017X1TQZp1onCjveRUTy37R6OiclWrzS/ZwqwUwYUAgiuftX0OcTb1918gPjLjO+Kmif4nBXLBXXa+YJZSE3zjhuuhgh+ttSz6oqyVYY2WxPMiZZ1ul37Oh1p5zM9iskEzJFvJx7cAJ4fZ8u88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0045C12FC;
	Tue, 15 Jul 2025 16:22:12 -0700 (PDT)
Received: from [10.57.0.241] (unknown [10.57.0.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D9533F66E;
	Tue, 15 Jul 2025 16:22:17 -0700 (PDT)
Message-ID: <153b5191-c585-433e-9cf5-1ed19b9a7f5c@arm.com>
Date: Wed, 16 Jul 2025 00:22:16 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/23] arm64: cpufeature: Add cpucap for HPMN0
Content-Language: en-GB
To: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250714225917.1396543-1-coltonlewis@google.com>
 <20250714225917.1396543-2-coltonlewis@google.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250714225917.1396543-2-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/07/2025 23:58, Colton Lewis wrote:
> Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
> counters reserved for the guest.
> 
> This required changing HPMN0 to an UnsignedEnum in tools/sysreg
> because otherwise not all the appropriate macros are generated to add
> it to arm64_cpu_capabilities_arm64_features.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm64/kernel/cpufeature.c | 8 ++++++++
>   arch/arm64/tools/cpucaps       | 1 +
>   arch/arm64/tools/sysreg        | 6 +++---
>   3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index b34044e20128..f38d7b5294ec 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -548,6 +548,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>   };
>   
>   static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_HPMN0_SHIFT, 4, 0),

This doesn't have to be FTR_STRICT. The kernel can deal with 
differences, by skipping to use HPMN0. We anyway rely on the
system wide cap for using the feature.

Otherwise,

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


>   	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
> @@ -2896,6 +2897,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.matches = has_cpuid_feature,
>   		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, FGT, FGT2)
>   	},
> +	{
> +		.desc = "HPMN0",
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.capability = ARM64_HAS_HPMN0,
> +		.matches = has_cpuid_feature,
> +		ARM64_CPUID_FIELDS(ID_AA64DFR0_EL1, HPMN0, IMP)
> +	},
>   #ifdef CONFIG_ARM64_SME
>   	{
>   		.desc = "Scalable Matrix Extension",
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 10effd4cff6b..5b196ba21629 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -39,6 +39,7 @@ HAS_GIC_CPUIF_SYSREGS
>   HAS_GIC_PRIO_MASKING
>   HAS_GIC_PRIO_RELAXED_SYNC
>   HAS_HCR_NV1
> +HAS_HPMN0
>   HAS_HCX
>   HAS_LDAPR
>   HAS_LPA2
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 8a8cf6874298..d29742481754 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1531,9 +1531,9 @@ EndEnum
>   EndSysreg
>   
>   Sysreg	ID_AA64DFR0_EL1	3	0	0	5	0
> -Enum	63:60	HPMN0
> -	0b0000	UNPREDICTABLE
> -	0b0001	DEF
> +UnsignedEnum	63:60	HPMN0
> +	0b0000	NI
> +	0b0001	IMP
>   EndEnum
>   UnsignedEnum	59:56	ExtTrcBuff
>   	0b0000	NI


