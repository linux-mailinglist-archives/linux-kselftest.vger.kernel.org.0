Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3464CAB77
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 18:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243767AbiCBRYN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 12:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbiCBRYM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 12:24:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6444CA31A
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 09:23:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68926B8212A
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 17:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4782EC004E1;
        Wed,  2 Mar 2022 17:23:23 +0000 (UTC)
Date:   Wed, 2 Mar 2022 17:23:19 +0000
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
Subject: Re: [PATCH v12 06/40] arm64/sme: Provide ABI documentation for SME
Message-ID: <Yh+oB9y0Y1qFv18U@arm.com>
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-7-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225165923.1474372-7-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 25, 2022 at 04:58:49PM +0000, Mark Brown wrote:
> +4.  System call behaviour
> +-------------------------
> +
> +* On syscall PSTATE.ZA is preserved, if PSTATE.ZA==1 then the contents of the
> +  ZA matrix are preserved.
> +
> +* On syscall PSTATE.SM will be cleared and the SVE registers will be handled
> +  as normal.
> +
> +* Neither the SVE registers nor ZA are used to pass arguments to or receive
> +  results from any syscall.
> +
> +* On creation fork() or clone() the newly created process will have PSTATE.SM
> +  and PSTATE.ZA cleared.

Nitpick: I'd drop fork() from here as we don't implement the syscall on
arm64 and maybe just use clone() as an example, something like: "On
process creation (e.g. clone()), the newly created ...".

Otherwise the ABI looks fine to me, though I'd like the Szabolcs and
Luis to ack from the glibc/gdb side.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
