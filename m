Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC554B1547
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 19:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbiBJSc5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 13:32:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbiBJScz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 13:32:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2597E192
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 10:32:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE010B826A8
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 18:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A94C004E1;
        Thu, 10 Feb 2022 18:32:50 +0000 (UTC)
Date:   Thu, 10 Feb 2022 18:32:46 +0000
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
Subject: Re: [PATCH v11 06/40] arm64/sme: Provide ABI documentation for SME
Message-ID: <YgVaTounTtunlGU6@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-7-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:35PM +0000, Mark Brown wrote:
> diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
> new file mode 100644
> index 000000000000..15df3157c592
> --- /dev/null
> +++ b/Documentation/arm64/sme.rst
[...]
> +3.  Sharing of streaming and non-streaming mode SVE state
> +---------------------------------------------------------
> +
> +It is implementation defined which if any parts of the SVE state are shared
> +between streaming and non-streaming modes.  When switching between modes
> +via software interfaces such as ptrace if no register content is provided as
> +part of switching no state will be assumed to be shared and everything will
> +be zeroed.

Is there anything other than ptrace() here? I read the sigreturn() case
below but did not say anything about changing PSTATE.SM via the
sigcontext. I guess it's similar to ptrace().

> +4.  System call behaviour
> +-------------------------
> +
> +* On syscall PSTATE.ZA is preserved, if PSTATE.ZA==1 then the contents of the
> +  ZA matrix are preserved.

Sorry if this was discussed. What is the rationale for preserving the ZA
registers on syscall? We don't do this for the top part of the Z
registers.

> +* On syscall PSTATE.SM will be cleared and the SVE registers will be handled
> +  as normal.

What does that mean? Is this as per the sve.rst doc (unspecified but
zeroed in practice)?

> +* Neither the SVE registers nor ZA are used to pass arguments to or receive
> +  results from any syscall.
> +
> +* On creation fork() or clone() the newly created process will have PSTATE.SM
> +  and PSTATE.ZA cleared.

This looks slightly inconsistent with the first bullet point on ZA being
preserved on syscalls. Why do these differ?

[...]
> +References
> +==========
> +
> +[1] arch/arm64/include/uapi/asm/sigcontext.h
> +    AArch64 Linux signal ABI definitions
> +
> +[2] arch/arm64/include/uapi/asm/ptrace.h
> +    AArch64 Linux ptrace ABI definitions
> +
> +[3] Documentation/arm64/cpu-feature-registers.rst
> +
> +[4] ARM IHI0055C
> +    http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055c/IHI0055C_beta_aapcs64.pdf
> +    http://infocenter.arm.com/help/topic/com.arm.doc.subset.swdev.abi/index.html
> +    Procedure Call Standard for the ARM 64-bit Architecture (AArch64)

The second link no longer works. I also couldn't find any reference to
[4] but there's a lot of text to scan, so I may have missed it.

-- 
Catalin
