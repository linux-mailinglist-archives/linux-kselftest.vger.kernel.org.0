Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39F84BDED8
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Feb 2022 18:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiBUQ7Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Feb 2022 11:59:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350922AbiBUQ7Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Feb 2022 11:59:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96E322BCE
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 08:58:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8155DB815A9
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 16:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34152C340E9;
        Mon, 21 Feb 2022 16:58:47 +0000 (UTC)
Date:   Mon, 21 Feb 2022 16:58:43 +0000
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
Subject: Re: [PATCH v11 14/40] arm64/sme: Implement support for TPIDR2
Message-ID: <YhPEw/+yGWtWcfMF@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-15-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-15-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:43PM +0000, Mark Brown wrote:
> The Scalable Matrix Extension introduces support for a new thread specific
> data register TPIDR2 intended for use by libc. The kernel must save the
> value of TPIDR2 on context switch and should ensure that all new threads
> start off with a default value of 0. Add a field to the thread_struct to
> store TPIDR2 and context switch it with the other thread specific data.
> 
> In case there are future extensions which also use TPIDR2 we introduce
> system_supports_tpidr2() and use that rather than system_supports_sme()
> for TPIDR2 handling.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

I think this matches the ABI per the documentation (and the subsequent
discussion we had).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
