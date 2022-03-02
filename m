Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D324CAB2A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 18:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiCBRKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 12:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiCBRKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 12:10:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D53BBC9
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 09:09:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E6836195A
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 17:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D45C004E1;
        Wed,  2 Mar 2022 17:09:35 +0000 (UTC)
Date:   Wed, 2 Mar 2022 17:09:32 +0000
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
Subject: Re: [PATCH v12 20/40] arm64/sme: Implement streaming SVE signal
 handling
Message-ID: <Yh+kzH88WFFNde4r@arm.com>
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-21-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225165923.1474372-21-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 25, 2022 at 04:59:03PM +0000, Mark Brown wrote:
> When in streaming mode we have the same set of SVE registers as we do in
> regular SVE mode with the exception of FFR and the use of the SME vector
> length. Provide signal handling for these registers by taking one of the
> reserved words in the SVE signal context as a flags field and defining a
> flag which is set for streaming mode. When the flag is set the vector
> length is set to the streaming mode vector length and we save and
> restore streaming mode data. We support entering or leaving streaming
> mode based on the value of the flag but do not support changing the
> vector length, this is not currently supported SVE signal handling.
> 
> We could instead allocate a separate record in the signal frame for the
> streaming mode SVE context but this inflates the size of the maximal signal
> frame required and adds complication when validating signal frames from
> userspace, especially given the current structure of the code.
> 
> Any implementation of support for streaming mode vectors in signals will
> have some potential for causing issues for applications that attempt to
> handle SVE vectors in signals, use streaming mode but do not understand
> streaming mode in their signal handling code, it is hard to identify a
> case that is clearly better than any other - they all have cases where
> they could cause unexpected register corruption or faults.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
