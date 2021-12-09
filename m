Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B932246F34C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 19:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhLISpM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 13:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLISpM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 13:45:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C776C061746
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 10:41:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3DD42CE27AF
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 18:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CC0C004DD;
        Thu,  9 Dec 2021 18:41:31 +0000 (UTC)
Date:   Thu, 9 Dec 2021 18:41:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 13/37] arm64/sme: Basic enumeration support
Message-ID: <YbJN1ujpDP1RG1Ll@arm.com>
References: <20211115152835.3212149-1-broonie@kernel.org>
 <20211115152835.3212149-14-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115152835.3212149-14-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 15, 2021 at 03:28:11PM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> index 7b23b16f21ce..6f8ca04b6566 100644
> --- a/arch/arm64/include/uapi/asm/hwcap.h
> +++ b/arch/arm64/include/uapi/asm/hwcap.h
> @@ -76,5 +76,13 @@
>  #define HWCAP2_BTI		(1 << 17)
>  #define HWCAP2_MTE		(1 << 18)
>  #define HWCAP2_ECV		(1 << 19)
> +#define HWCAP2_SME		(1 << 20)
> +#define HWCAP2_SME_I16I64	(1 << 21)
> +#define HWCAP2_SME_F64F64	(1 << 22)
> +#define HWCAP2_SME_I8I32	(1 << 23)
> +#define HWCAP2_SME_F16F32	(1 << 24)
> +#define HWCAP2_SME_B16F32	(1 << 25)
> +#define HWCAP2_SME_F32F32	(1 << 26)
> +#define HWCAP2_SME_FA64		(1 << 27)

At this pace we'll need HWCAP3 pretty soon (since we only allocated
32-bit in each). I wonder whether we could instead not bother at all and
just provide user-space emulation for ID_AA64SMFR0_EL1.

>  #endif /* _UAPI__ASM_HWCAP_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 81824c7ea74f..3cf60819c354 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -246,6 +246,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SME_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MPAMFRAC_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_RASFRAC_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_MTE),
> @@ -278,6 +279,24 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
>  	ARM64_FTR_END,
>  };
>  
> +static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
> +		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_FA64_SHIFT, 1, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
> +		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_I16I64_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
> +		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_F64F64_SHIFT, 1, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
> +		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_I8I32_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
> +		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_F16F32_SHIFT, 1, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
> +		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_B16F32_SHIFT, 1, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
> +		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_F32F32_SHIFT, 1, 0),
> +	ARM64_FTR_END,
> +};
> +
>  static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ECV_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_FGT_SHIFT, 4, 0),
> @@ -628,6 +647,7 @@ static const struct __ftr_reg_entry {
>  	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64PFR1_EL1, ftr_id_aa64pfr1,
>  			       &id_aa64pfr1_override),
>  	ARM64_FTR_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0),
> +	ARM64_FTR_REG(SYS_ID_AA64SMFR0_EL1, ftr_id_aa64smfr0),
>  
>  	/* Op1 = 0, CRn = 0, CRm = 5 */
>  	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
> @@ -939,6 +959,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
>  	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
>  	init_cpu_ftr_reg(SYS_ID_AA64ZFR0_EL1, info->reg_id_aa64zfr0);
> +	init_cpu_ftr_reg(SYS_ID_AA64SMFR0_EL1, info->reg_id_aa64smfr0);
>  
>  	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
>  		init_32bit_cpu_features(&info->aarch32);
> @@ -2370,6 +2391,30 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_cpuid_feature,
>  		.min_field_value = 1,
>  	},
> +#ifdef CONFIG_ARM64_SME
> +	{
> +		.desc = "Scalable Matrix Extension",
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.capability = ARM64_SME,
> +		.sys_reg = SYS_ID_AA64PFR1_EL1,
> +		.sign = FTR_UNSIGNED,
> +		.field_pos = ID_AA64PFR1_SME_SHIFT,
> +		.min_field_value = ID_AA64PFR1_SME,
> +		.matches = has_cpuid_feature,
> +		.cpu_enable = sme_kernel_enable,
> +	},
> +	{
> +		.desc = "FA64",
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.capability = ARM64_SME_FA64,
> +		.sys_reg = SYS_ID_AA64SMFR0_EL1,
> +		.sign = FTR_UNSIGNED,
> +		.field_pos = ID_AA64SMFR0_FA64_SHIFT,
> +		.min_field_value = ID_AA64SMFR0_FA64,
> +		.matches = has_feature_flag,
> +		.cpu_enable = fa64_kernel_enable,
> +	},

I'll comment here rather than the patch introducing has_feature_flag():
an alternative would be to add a .field_width option and in
feature_matches() use cpuid_feature_extract_field_width() directly. All
the arm64_ftr_bits entries already have a width, so just generalise it
for arm64_cpu_capabilities.

-- 
Catalin
