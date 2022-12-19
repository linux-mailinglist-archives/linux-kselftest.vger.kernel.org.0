Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3332650886
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 09:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiLSIWZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 03:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiLSIWX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 03:22:23 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A5A7649
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 00:22:19 -0800 (PST)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NbCJp3S8vzHqNm;
        Mon, 19 Dec 2022 16:18:34 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 16:22:16 +0800
Subject: Re: [PATCH v3 13/21] arm64/sme: Add hwcaps for SME 2 and 2.1 features
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
 <20221111215026.813348-14-broonie@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <0dbcf013-4791-50ca-3a94-7ff8b67d4b03@huawei.com>
Date:   Mon, 19 Dec 2022 16:22:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20221111215026.813348-14-broonie@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/11/12 5:50, Mark Brown wrote:
> In order to allow userspace to discover the presence of the new SME features
> add hwcaps for them.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/arm64/elf_hwcaps.rst  | 18 ++++++++++++++++++
>  arch/arm64/include/asm/hwcap.h      |  6 ++++++
>  arch/arm64/include/uapi/asm/hwcap.h |  6 ++++++
>  arch/arm64/kernel/cpufeature.c      | 13 +++++++++++++
>  arch/arm64/kernel/cpuinfo.c         |  6 ++++++
>  5 files changed, 49 insertions(+)
> 
> diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> index 6fed84f935df..29a3dd1b8f5a 100644
> --- a/Documentation/arm64/elf_hwcaps.rst
> +++ b/Documentation/arm64/elf_hwcaps.rst
> @@ -284,6 +284,24 @@ HWCAP2_RPRFM
>  HWCAP2_SVE2P1
>      Functionality implied by ID_AA64ZFR0_EL1.SVEver == 0b0010.
>  
> +HWCAP2_SME2
> +    Functionality implied by ID_AA64SMFR0_EL1.SMEver == 0b0001.
> +
> +HWCAP2_SME2P1
> +    Functionality implied by ID_AA64SMFR0_EL1.SMEver == 0b0010.
> +
> +HWCAP2_SMEI16I32
> +    Functionality implied by ID_AA64SMFR0_EL1.I16I32 == 0b0101
> +
> +HWCAP2_SMEBI32I32
> +    Functionality implied by ID_AA64SMFR0_EL1.I32I32 == 0b1

s/I32I32/BI32I32/ ?

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 5b0d79f026aa..efb980ea7653 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c

> @@ -2839,11 +2847,16 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>  #ifdef CONFIG_ARM64_SME
>  	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_SME_SHIFT, 4, FTR_UNSIGNED, ID_AA64PFR1_EL1_SME_IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
>  	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_FA64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_FA64_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
> +	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_SMEver_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_EL1_SMEver_SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
> +	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_SMEver_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_EL1_SMEver_SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
>  	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_I16I64_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_EL1_I16I64_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
>  	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_F64F64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_F64F64_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
> +	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_F64F64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_B16B16_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),

The *field* assignment looks wrong due to a copy-paste mistake.

s/ID_AA64SMFR0_EL1_F64F64_SHIFT/ID_AA64SMFR0_EL1_B16B16_SHIFT/ ?

> +	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_F64F64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_F16F16_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),

ditto

>  	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_I8I32_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_EL1_I8I32_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
>  	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_F16F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_F16F32_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
>  	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_B16F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_B16F32_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
> +	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_B16F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_EL1_BI32I32_IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),

ditto

and seems that HWCAP2_SMEI16I32 is missed.
