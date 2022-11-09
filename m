Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20ED623190
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 18:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKIRfS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 12:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKIRfR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 12:35:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982A71277E
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Nov 2022 09:35:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3483961BF3
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Nov 2022 17:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5CDC433C1;
        Wed,  9 Nov 2022 17:35:14 +0000 (UTC)
Date:   Wed, 9 Nov 2022 17:35:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 5/6] arm64/hwcap: Add support for SVE 2.1
Message-ID: <Y2vkz2sD+9Siyrok@arm.com>
References: <20221017152520.1039165-1-broonie@kernel.org>
 <20221017152520.1039165-6-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017152520.1039165-6-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 17, 2022 at 04:25:19PM +0100, Mark Brown wrote:
> FEAT_SVE2p1 introduces a number of new SVE instructions. Since there is no
> new architectural state added kernel support is simply a new hwcap which
> lets userspace know that the feature is supported.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/arm64/elf_hwcaps.rst  | 3 +++
>  Documentation/arm64/sve.rst         | 1 +
>  arch/arm64/include/asm/hwcap.h      | 1 +
>  arch/arm64/include/uapi/asm/hwcap.h | 1 +
>  arch/arm64/kernel/cpufeature.c      | 1 +
>  arch/arm64/kernel/cpuinfo.c         | 1 +
>  arch/arm64/tools/sysreg             | 1 +
>  7 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> index a82b2cdff680..6fed84f935df 100644
> --- a/Documentation/arm64/elf_hwcaps.rst
> +++ b/Documentation/arm64/elf_hwcaps.rst
> @@ -281,6 +281,9 @@ HWCAP2_CSSC
>  HWCAP2_RPRFM
>      Functionality implied by ID_AA64ISAR2_EL1.RPRFM == 0b0001.
>  
> +HWCAP2_SVE2P1
> +    Functionality implied by ID_AA64ZFR0_EL1.SVEver == 0b0010.

It looks like our architect ran out of meaningful names. I guess we
should just follow them in the kernel.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
