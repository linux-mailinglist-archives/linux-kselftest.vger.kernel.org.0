Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590E74BDBBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Feb 2022 18:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379075AbiBUP5x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Feb 2022 10:57:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBUP5w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Feb 2022 10:57:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AFF25C4A
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 07:57:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A7D9B8123F
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 15:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C24BC340E9;
        Mon, 21 Feb 2022 15:57:23 +0000 (UTC)
Date:   Mon, 21 Feb 2022 15:57:20 +0000
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
Subject: Re: [PATCH v11 11/40] arm64/sme: Identify supported SME vector
 lengths at boot
Message-ID: <YhO2YJ1mliDYjy67@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-12-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-12-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:40PM +0000, Mark Brown wrote:
> @@ -977,6 +984,14 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  		vec_init_vq_map(ARM64_VEC_SVE);
>  	}
>  
> +	if (id_aa64pfr1_sme(info->reg_id_aa64pfr1)) {
> +		init_cpu_ftr_reg(SYS_SMCR_EL1, info->reg_smcr);
> +		if (IS_ENABLED(CONFIG_ARM64_SME)) {
> +			sme_kernel_enable(NULL);
> +			vec_init_vq_map(ARM64_VEC_SME);
> +		}
> +	}

Why do we need to call sme_kernel_enable() here? It's called again later
via the cpufeature framework. I guess you need the CPACR_EL1 setup but
we don't seem to do this for SVE.

-- 
Catalin
