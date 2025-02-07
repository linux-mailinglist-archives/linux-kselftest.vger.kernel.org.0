Return-Path: <linux-kselftest+bounces-26020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FFDA2CB8D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E358C188A081
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D71DC05F;
	Fri,  7 Feb 2025 18:37:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D431DC185;
	Fri,  7 Feb 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953458; cv=none; b=sFCZ3yF+of8vrs1rZAFIcKaiV1TxEsJG5OdVz5YXv6Y2DZnZEsiTdzz4xFHJ+ywCendcf2oxVXl+hy761EigmJQ4BfuZ9PJN0ghqb5BZcGVAg2V7fNFrWwgzBPYjvITNYLvU9uf4rMWjS8Qb0q/7h8cerZ3Q7Cq5Ut95DEnrGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953458; c=relaxed/simple;
	bh=JwTcOEBYfr1rCDshZukmpO+Xyd0QO7FH1iQT2eblRcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESqmDzSGgti7T7WNRccX/ZB4DiZLHdTegT1MJL8KXnwzfglM7WPYGWWG9pT+R1tWJ7pIGtUT4XfmHr8r3yaGDP1QeotKe91Jbj8eAQQV/VJHF9fpAMcbh95rY+mj/SS8MnNJF6OjyleAazU7QtJAghiRXFwYn4c1BnFXWL9g0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D278113E;
	Fri,  7 Feb 2025 10:37:58 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27E173F63F;
	Fri,  7 Feb 2025 10:37:33 -0800 (PST)
Date: Fri, 7 Feb 2025 18:37:27 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 3/5] arm64/hwcap: Describe 2024 dpISA extensions to
 userspace
Message-ID: <Z6ZS51BLkfFLl-5Y@J2N7QTR9R3>
References: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
 <20250107-arm64-2024-dpisa-v5-3-7578da51fc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-arm64-2024-dpisa-v5-3-7578da51fc3d@kernel.org>

On Tue, Jan 07, 2025 at 10:59:43PM +0000, Mark Brown wrote:
> The 2024 dpISA introduces a number of architecture features all of which
> only add new instructions so only require the addition of hwcaps and ID
> register visibility.

While working on SME fixes atop v6.14-rc1, I found this patch breaks the
build spectacularly with CONFIG_ARM64_SME is enabled (splat at the end
of this mail), due to some missing definitions.

From a quick scan, there are some other missing bits too. For example
these two caps are defined in terms of ID_AA64FPFR0_EL1 fields:

> +HWCAP_F8MM8
> +    Functionality implied by ID_AA64FPFR0_EL1.F8MM8 == 0b0001.
> +
> +HWCAP_F8MM4
> +    Functionality implied by ID_AA64FPFR0_EL1.F8MM4 == 0b0001.

> +#define KERNEL_HWCAP_F8MM8		__khwcap_feature(F8MM8)
> +#define KERNEL_HWCAP_F8MM4		__khwcap_feature(F8MM4)

> +#define HWCAP_F8MM8		(1UL << 35)
> +#define HWCAP_F8MM4		(1UL << 36)

... and we expose the ID register bits to userspace:

> @@ -381,6 +396,8 @@ static const struct arm64_ftr_bits ftr_id_aa64fpfr0[] = {
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8FMA_SHIFT, 1, 0),
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP4_SHIFT, 1, 0),
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP2_SHIFT, 1, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8MM8_SHIFT, 1, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8MM4_SHIFT, 1, 0),
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E4M3_SHIFT, 1, 0),
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E5M2_SHIFT, 1, 0),

... but there's no corresponding arm64_elf_hwcaps additions to actually
expose the hwcaps.

There are *SME* variants in arm64_elf_hwcaps:

> @@ -3163,6 +3187,13 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>  	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8FMA),
>  	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP4),
>  	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP2),
> +	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
> +	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),

... but those KERNEL_HWCAP_SME_* values are never defined, and neither
are the UAPI equivalents.

We need to fix that quick, in case we need to shuffle values.

> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index d79e88fccdfce427507e7a34c5959ce6309cbd12..b08ea3dd5e210626102b83edc3be4efcc9225fc6 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -145,6 +145,21 @@ static const char *const hwcap_str[] = {
>  	[KERNEL_HWCAP_SME_SF8DP4]	= "smesf8dp4",
>  	[KERNEL_HWCAP_SME_SF8DP2]	= "smesf8dp2",
>  	[KERNEL_HWCAP_POE]		= "poe",
> +	[KERNEL_HWCAP_CMPBR]		= "cmpbr",
> +	[KERNEL_HWCAP_FPRCVT]		= "fprcvt",
> +	[KERNEL_HWCAP_F8MM8]		= "f8mm8",
> +	[KERNEL_HWCAP_F8MM4]		= "f8mm4",
> +	[KERNEL_HWCAP_SVE_F16MM]	= "svef16mm",
> +	[KERNEL_HWCAP_SVE_ELTPERM]	= "sveeltperm",
> +	[KERNEL_HWCAP_SVE_AES2]		= "sveaes2",
> +	[KERNEL_HWCAP_SVE_BFSCALE]	= "svebfscale",
> +	[KERNEL_HWCAP_SVE2P2]		= "sve2p2",
> +	[KERNEL_HWCAP_SME2P2]		= "sme2p2",
> +	[KERNEL_HWCAP_SME_SBITPERM]	= "smesbitperm",
> +	[KERNEL_HWCAP_SME_AES]		= "smeaes",
> +	[KERNEL_HWCAP_SME_SFEXPA]	= "smesfexpa",
> +	[KERNEL_HWCAP_SME_STMOP]	= "smestmop",
> +	[KERNEL_HWCAP_SME_SMOP4]	= "smesmop4",
>  };

Likewise they're missing from the strings table here.

The full splat I got was:

| [mark@lakrids:~/src/linux]% usekorg 14.2.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- arch/arm64/
|   CALL    scripts/checksyscalls.sh
|   CC      arch/arm64/kernel/cpufeature.o
| arch/arm64/kernel/cpufeature.c:3183:61: error: 'KERNEL_HWCAP_SME_SF8MM8' undeclared here (not in a function); did you mean 'KERNEL_HWCAP_SME_SF8FMA'?
|  3183 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
|       |                                                             ^~~~~~~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3013:26: note: in definition of macro '__HWCAP_CAP'
|  3013 |                 .hwcap = cap,                                                   \
|       |                          ^~~
| arch/arm64/kernel/cpufeature.c:3183:9: note: in expansion of macro 'HWCAP_CAP'
|  3183 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
|       |         ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3183:19: error: 'ID_AA64SMFR0_EL1_SF8MM8_SHIFT' undeclared here (not in a function); did you mean 'ID_AA64SMFR0_EL1_SF8FMA_SHIFT'?
|  3183 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
|       |                   ^~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:154:30: note: in definition of macro '__ARM64_CPUID_FIELDS'
|   154 |                 .field_pos = reg##_##field##_SHIFT,                     \
|       |                              ^~~
| arch/arm64/kernel/cpufeature.c:3007:17: note: in expansion of macro 'ARM64_CPUID_FIELDS'
|  3007 |                 ARM64_CPUID_FIELDS(reg, field, min_value)
|       |                 ^~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3018:17: note: in expansion of macro 'HWCAP_CPUID_MATCH'
|  3018 |                 HWCAP_CPUID_MATCH(reg, field, min_value)                \
|       |                 ^~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3183:9: note: in expansion of macro 'HWCAP_CAP'
|  3183 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
|       |         ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3183:19: error: 'ID_AA64SMFR0_EL1_SF8MM8_WIDTH' undeclared here (not in a function); did you mean 'ID_AA64SMFR0_EL1_SF8FMA_WIDTH'?
|  3183 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
|       |                   ^~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:155:32: note: in definition of macro '__ARM64_CPUID_FIELDS'
|   155 |                 .field_width = reg##_##field##_WIDTH,                   \
|       |                                ^~~
| arch/arm64/kernel/cpufeature.c:3007:17: note: in expansion of macro 'ARM64_CPUID_FIELDS'
|  3007 |                 ARM64_CPUID_FIELDS(reg, field, min_value)
|       |                 ^~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3018:17: note: in expansion of macro 'HWCAP_CPUID_MATCH'
|  3018 |                 HWCAP_CPUID_MATCH(reg, field, min_value)                \
|       |                 ^~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3183:9: note: in expansion of macro 'HWCAP_CAP'
|  3183 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
|       |         ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3183:19: error: 'ID_AA64SMFR0_EL1_SF8MM8_SIGNED' undeclared here (not in a function); did you mean 'ID_AA64SMFR0_EL1_SF8FMA_SIGNED'?
|  3183 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
|       |                   ^~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:156:25: note: in definition of macro '__ARM64_CPUID_FIELDS'
|   156 |                 .sign = reg##_##field##_SIGNED,                         \
|       |                         ^~~
| arch/arm64/kernel/cpufeature.c:3007:17: note: in expansion of macro 'ARM64_CPUID_FIELDS'
|  3007 |                 ARM64_CPUID_FIELDS(reg, field, min_value)
|       |                 ^~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3018:17: note: in expansion of macro 'HWCAP_CPUID_MATCH'
|  3018 |                 HWCAP_CPUID_MATCH(reg, field, min_value)                \
|       |                 ^~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3183:9: note: in expansion of macro 'HWCAP_CAP'
|  3183 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
|       |         ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3183:19: error: 'ID_AA64SMFR0_EL1_SF8MM8_IMP' undeclared here (not in a function); did you mean 'ID_AA64SMFR0_EL1_SF8FMA_IMP'?
|  3183 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
|       |                   ^~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:157:36: note: in definition of macro '__ARM64_CPUID_FIELDS'
|   157 |                 .min_field_value = min_value,                           \
|       |                                    ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:169:30: note: in expansion of macro 'SYS_FIELD_VALUE'
|   169 |                              SYS_FIELD_VALUE(reg, field, min_value),    \
|       |                              ^~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3007:17: note: in expansion of macro 'ARM64_CPUID_FIELDS'
|  3007 |                 ARM64_CPUID_FIELDS(reg, field, min_value)
|       |                 ^~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3018:17: note: in expansion of macro 'HWCAP_CPUID_MATCH'
|  3018 |                 HWCAP_CPUID_MATCH(reg, field, min_value)                \
|       |                 ^~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3183:9: note: in expansion of macro 'HWCAP_CAP'
|  3183 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
|       |         ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3184:61: error: 'KERNEL_HWCAP_SME_SF8MM4' undeclared here (not in a function); did you mean 'KERNEL_HWCAP_SME_SF8DP4'?
|  3184 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
|       |                                                             ^~~~~~~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3013:26: note: in definition of macro '__HWCAP_CAP'
|  3013 |                 .hwcap = cap,                                                   \
|       |                          ^~~
| arch/arm64/kernel/cpufeature.c:3184:9: note: in expansion of macro 'HWCAP_CAP'
|  3184 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
|       |         ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3184:19: error: 'ID_AA64SMFR0_EL1_SF8MM4_SHIFT' undeclared here (not in a function); did you mean 'ID_AA64SMFR0_EL1_SF8FMA_SHIFT'?
|  3184 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
|       |                   ^~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:154:30: note: in definition of macro '__ARM64_CPUID_FIELDS'
|   154 |                 .field_pos = reg##_##field##_SHIFT,                     \
|       |                              ^~~
| arch/arm64/kernel/cpufeature.c:3007:17: note: in expansion of macro 'ARM64_CPUID_FIELDS'
|  3007 |                 ARM64_CPUID_FIELDS(reg, field, min_value)
|       |                 ^~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3018:17: note: in expansion of macro 'HWCAP_CPUID_MATCH'
|  3018 |                 HWCAP_CPUID_MATCH(reg, field, min_value)                \
|       |                 ^~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3184:9: note: in expansion of macro 'HWCAP_CAP'
|  3184 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
|       |         ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3184:19: error: 'ID_AA64SMFR0_EL1_SF8MM4_WIDTH' undeclared here (not in a function); did you mean 'ID_AA64SMFR0_EL1_SF8FMA_WIDTH'?
|  3184 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
|       |                   ^~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:155:32: note: in definition of macro '__ARM64_CPUID_FIELDS'
|   155 |                 .field_width = reg##_##field##_WIDTH,                   \
|       |                                ^~~
| arch/arm64/kernel/cpufeature.c:3007:17: note: in expansion of macro 'ARM64_CPUID_FIELDS'
|  3007 |                 ARM64_CPUID_FIELDS(reg, field, min_value)
|       |                 ^~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3018:17: note: in expansion of macro 'HWCAP_CPUID_MATCH'
|  3018 |                 HWCAP_CPUID_MATCH(reg, field, min_value)                \
|       |                 ^~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3184:9: note: in expansion of macro 'HWCAP_CAP'
|  3184 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
|       |         ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3184:19: error: 'ID_AA64SMFR0_EL1_SF8MM4_SIGNED' undeclared here (not in a function); did you mean 'ID_AA64SMFR0_EL1_SF8DP4_SIGNED'?
|  3184 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
|       |                   ^~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:156:25: note: in definition of macro '__ARM64_CPUID_FIELDS'
|   156 |                 .sign = reg##_##field##_SIGNED,                         \
|       |                         ^~~
| arch/arm64/kernel/cpufeature.c:3007:17: note: in expansion of macro 'ARM64_CPUID_FIELDS'
|  3007 |                 ARM64_CPUID_FIELDS(reg, field, min_value)
|       |                 ^~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3018:17: note: in expansion of macro 'HWCAP_CPUID_MATCH'
|  3018 |                 HWCAP_CPUID_MATCH(reg, field, min_value)                \
|       |                 ^~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3184:9: note: in expansion of macro 'HWCAP_CAP'
|  3184 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
|       |         ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3184:19: error: 'ID_AA64SMFR0_EL1_SF8MM4_IMP' undeclared here (not in a function); did you mean 'ID_AA64SMFR0_EL1_SF8DP4_IMP'?
|  3184 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
|       |                   ^~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:157:36: note: in definition of macro '__ARM64_CPUID_FIELDS'
|   157 |                 .min_field_value = min_value,                           \
|       |                                    ^~~~~~~~~
| arch/arm64/kernel/cpufeature.c:169:30: note: in expansion of macro 'SYS_FIELD_VALUE'
|   169 |                              SYS_FIELD_VALUE(reg, field, min_value),    \
|       |                              ^~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3007:17: note: in expansion of macro 'ARM64_CPUID_FIELDS'
|  3007 |                 ARM64_CPUID_FIELDS(reg, field, min_value)
|       |                 ^~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3018:17: note: in expansion of macro 'HWCAP_CPUID_MATCH'
|  3018 |                 HWCAP_CPUID_MATCH(reg, field, min_value)                \
|       |                 ^~~~~~~~~~~~~~~~~
| arch/arm64/kernel/cpufeature.c:3184:9: note: in expansion of macro 'HWCAP_CAP'
|  3184 |         HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
|       |         ^~~~~~~~~
| make[4]: *** [scripts/Makefile.build:207: arch/arm64/kernel/cpufeature.o] Error 1
| make[3]: *** [scripts/Makefile.build:465: arch/arm64/kernel] Error 2
| make[2]: *** [scripts/Makefile.build:465: arch/arm64] Error 2
| make[1]: *** [/home/mark/src/linux/Makefile:1994: .] Error 2
| make: *** [Makefile:251: __sub-make] Error 2

Mark.

