Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350354B15A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 19:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiBJS5f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 13:57:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiBJS5f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 13:57:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCBD10B7
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 10:57:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8A60B82721
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 18:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D286C004E1;
        Thu, 10 Feb 2022 18:57:30 +0000 (UTC)
Date:   Thu, 10 Feb 2022 18:57:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v11 08/40] arm64/sme: Manually encode SME instructions
Message-ID: <YgVgFq/mkPeABSyv@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-9-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-9-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:37PM +0000, Mark Brown wrote:
> As with SVE rather than impose ambitious toolchain requirements for SME
> we manually encode the few instructions which we require in order to
> perform the work the kernel needs to do. The instructions used to save
> and restore context are provided as assembler macros while those for
> entering and leaving streaming mode are done in asm volatile blocks
> since they are expected to be used from C.
> 
> We could do the SMSTART and SMSTOP operations with read/modify/write
> cycles on SVCR but using the aliases provided for individual field
> accesses should be slightly faster. These instructions are aliases for
> MSR but since our minimum toolchain requirements are old enough to mean
> that we can't use the sX_X_cX_cX_X form and they always use xzr rather
> than taking a value like write_sysreg_s() wants we just use .inst.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimd.h       | 25 +++++++++++++
>  arch/arm64/include/asm/fpsimdmacros.h | 53 +++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index cb24385e3632..c90f7f99a768 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -249,6 +249,31 @@ static inline void sve_setup(void) { }
>  
>  #endif /* ! CONFIG_ARM64_SVE */
>  
> +#ifdef CONFIG_ARM64_SME
> +
> +static inline void sme_smstart_sm(void)
> +{
> +	asm volatile(".inst 0xd503437f");
> +}
> +
> +static inline void sme_smstop_sm(void)
> +{
> +	asm volatile(".inst 0xd503427f");
> +}
> +
> +static inline void sme_smstop(void)
> +{
> +	asm volatile(".inst 0xd503467f");
> +}

I think you can use xzr with __msr_s. It would be more consistent if we
had some sysregs defined to be used with __msr_s.

-- 
Catalin
