Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11034CAA2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 17:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiCBQaV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 11:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiCBQaU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 11:30:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0012B0D20
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 08:29:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE21261803
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 16:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA5AC340ED;
        Wed,  2 Mar 2022 16:29:32 +0000 (UTC)
Date:   Wed, 2 Mar 2022 16:29:29 +0000
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
Subject: Re: [PATCH v12 10/40] arm64/sme: Basic enumeration support
Message-ID: <Yh+bafhTeVpJct3M@arm.com>
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-11-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225165923.1474372-11-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 25, 2022 at 04:58:53PM +0000, Mark Brown wrote:
> +HWCAP2_SME
> +
> +    Functionality implied by ID_AA64PFR1_EL1.SME == 0b0001, as described
> +    by Documentation/arm64/sme.rst.
> +
> +HWCAP2_SME_I16I64
> +
> +    Functionality implied by ID_AA64SMFR0_EL1.I16I64 == 0b1111.
> +
> +HWCAP2_SME_F64F64
> +
> +    Functionality implied by ID_AA64SMFR0_EL1.F64F64 == 0b1.
> +
> +HWCAP2_SME_I8I32
> +
> +    Functionality implied by ID_AA64SMFR0_EL1.I8I32 == 0b1111.
> +
> +HWCAP2_SME_F16F32
> +
> +    Functionality implied by ID_AA64SMFR0_EL1.F16F32 == 0b1.
> +
> +HWCAP2_SME_B16F32
> +
> +    Functionality implied by ID_AA64SMFR0_EL1.B16F32 == 0b1.
> +
> +HWCAP2_SME_F32F32
> +
> +    Functionality implied by ID_AA64SMFR0_EL1.F32F32 == 0b1.
> +
> +HWCAP2_SME_FA64
> +
> +    Functionality implied by ID_AA64SMFR0_EL1.FA64 == 0b1.

Without any strong opinion only exposing MRS emulation for these, I
guess we go ahead with adding all these new HWCAPs.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
