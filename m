Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E94C512FB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 11:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiD1Jt5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Apr 2022 05:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiD1JWp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Apr 2022 05:22:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F76D963
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 02:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC159B82C3F
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 09:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700BEC385A0;
        Thu, 28 Apr 2022 09:19:26 +0000 (UTC)
Date:   Thu, 28 Apr 2022 10:19:22 +0100
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
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v14 04/39] arm64/sme: Provide ABI documentation for SME
Message-ID: <YmpcGpSYpoiprngy@arm.com>
References: <20220419112247.711548-1-broonie@kernel.org>
 <20220419112247.711548-5-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419112247.711548-5-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 19, 2022 at 12:22:12PM +0100, Mark Brown wrote:
> +* There are a number of optional SME features, presence of these is reported
> +  through AT_HWCAP2 through:
> +
> +	HWCAP2_SME_I16I64
> +	HWCAP2_SME_F64F64
> +	HWCAP2_SME_I8I32
> +	HWCAP2_SME_F16F32
> +	HWCAP2_SME_B16F32
> +	HWCAP2_SME_F32F32
> +	HWCAP2_SME_FA64

Marc pointed out that in combination with FEAT_WFxT, we used all the
HWCAP2 bits (32). While we are ok for now, we'll soon need to look into
what to do when the next features turn up. Some options:

1. Only provide HWCAP2_SME and let the ID_AA64SMFR0_EL1 features be
   probed via MRS emulation. It doesn't solve the problem but it buys us
   a bit of time.

2. Don't bother with any new HWCAPs, just rely on MRS emulation (we have
   HWCAP_CPUID advertising this).

3. Start using the upper 32-bit of HWCAP and HWCAP2 (we initially didn't
   go into these as there was a slight chance of merging ILP32). Does
   the libc rely on the upper bits for anything? Or does it just assume
   a 32-bit HWCAPs layout?

4. Introduce HWCAP3.

Szabolcs, any thoughts?

Thanks.

-- 
Catalin
