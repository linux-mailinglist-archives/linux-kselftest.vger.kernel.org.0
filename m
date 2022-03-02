Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEAA4CAAA8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiCBQmT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 11:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiCBQmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 11:42:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E07CF3BC
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 08:41:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D0A661879
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 16:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8683C004E1;
        Wed,  2 Mar 2022 16:41:31 +0000 (UTC)
Date:   Wed, 2 Mar 2022 16:41:27 +0000
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
Subject: Re: [PATCH v12 11/40] arm64/sme: Identify supported SME vector
 lengths at boot
Message-ID: <Yh+eN6XvN5vvtyja@arm.com>
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-12-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225165923.1474372-12-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 25, 2022 at 04:58:54PM +0000, Mark Brown wrote:
> The vector lengths used for SME are controlled through a similar set of
> registers to those for SVE and enumerated using a similar algorithm with
> some slight differences due to the fact that unlike SVE there are no
> restrictions on which combinations of vector lengths can be supported
> nor any mandatory vector lengths which must be implemented.  Add a new
> vector type and implement support for enumerating it.
> 
> One slightly awkward feature is that we need to read the current vector
> length using a different instruction (or enter streaming mode which
> would have the same issue and be higher cost).  Rather than add an ops
> structure we add special cases directly in the otherwise generic
> vec_probe_vqs() function, this is a bit inelegant but it's the only
> place where this is an issue.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
