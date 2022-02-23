Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0AD4C1736
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiBWPll (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242267AbiBWPlX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:41:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBED5BDE5C
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 07:40:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C17EB820C4
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 15:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1019CC340E7;
        Wed, 23 Feb 2022 15:40:40 +0000 (UTC)
Date:   Wed, 23 Feb 2022 15:40:37 +0000
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
Subject: Re: [PATCH v11 28/40] KVM: arm64: Handle SME host state when running
 guests
Message-ID: <YhZVdRLF7RMBbfjG@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-29-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-29-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:57PM +0000, Mark Brown wrote:
> While we don't currently support SME in guests we do currently support it
> for the host system so we need to take care of SME's impact, including
> the floating point register state, when running guests. Simiarly to SVE
> we need to manage the traps in CPACR_RL1, what is new is the handling of
> streaming mode and ZA.
> 
> Normally we defer any handling of the floating point register state until
> the guest first uses it however if the system is in streaming mode FPSIMD
> and SVE operations may generate SME traps which we would need to distinguish
> from actual attempts by the guest to use SME. Rather than do this for the
> time being if we are in streaming mode when entering the guest we force
> the floating point state to be saved immediately and exit streaming mode,
> meaning that the guest won't generate SME traps for supported operations.
> 
> We could handle ZA in the access trap similarly to the FPSIMD/SVE state
> without the disruption caused by streaming mode but for simplicity
> handle it the same way as streaming mode for now.
> 
> This will be revisited when we support SME for guests (hopefully before SME
> hardware becomes available), for now it will only incur additional cost on
> systems with SME and even there only if streaming mode or ZA are enabled.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
