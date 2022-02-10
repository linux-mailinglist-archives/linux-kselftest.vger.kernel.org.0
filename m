Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A16C4B1552
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 19:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242663AbiBJSgE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 13:36:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343495AbiBJSgD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 13:36:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4277E25C3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 10:36:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4A84B82656
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 18:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923F0C004E1;
        Thu, 10 Feb 2022 18:35:57 +0000 (UTC)
Date:   Thu, 10 Feb 2022 18:35:54 +0000
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
Subject: Re: [PATCH v11 07/40] arm64/sme: System register and exception
 syndrome definitions
Message-ID: <YgVbCsIAGCl5FPeV@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-8-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-8-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:36PM +0000, Mark Brown wrote:
> The arm64 Scalable Matrix Extension (SME) adds some new system registers,
> fields in existing system registers and exception syndromes. This patch
> adds definitions for these for use in future patches implementing support
> for this extension.
> 
> Since SME will be the first user of FEAT_HCX in the kernel also include
> the definitions for enumerating it and the HCRX system register it adds.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

I can't claim I verified that the new definitions match the bits in the
spec. I trust you on this, so:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
