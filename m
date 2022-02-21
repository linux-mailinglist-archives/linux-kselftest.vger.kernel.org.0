Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB454BEA94
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Feb 2022 20:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiBUTZb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Feb 2022 14:25:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiBUTZa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Feb 2022 14:25:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D0C65BA
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 11:25:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B87A860C91
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 19:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FC6C340F1;
        Mon, 21 Feb 2022 19:25:02 +0000 (UTC)
Date:   Mon, 21 Feb 2022 19:24:59 +0000
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
Subject: Re: [PATCH v11 10/40] arm64/sme: Basic enumeration support
Message-ID: <YhPnCx+Rajjverjc@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-11-broonie@kernel.org>
 <YhOihgeVRTztfDqv@arm.com>
 <YhOpL54V9RAthj24@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhOpL54V9RAthj24@sirena.org.uk>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 21, 2022 at 03:01:03PM +0000, Mark Brown wrote:
> On Mon, Feb 21, 2022 at 02:32:38PM +0000, Catalin Marinas wrote:
> > On Mon, Feb 07, 2022 at 03:20:39PM +0000, Mark Brown wrote:
> > > +/*
> > > + * This must be called after sme_kernel_enable(), we rely on the
> > > + * feature table being sorted to ensure this.
> > > + */
> > > +void fa64_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
> > > +{
> > > +	/* Allow use of FA64 */
> > > +	write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_FA64_MASK,
> > > +		       SYS_SMCR_EL1);
> > > +}
> > > +
> > > +#endif /* CONFIG_ARM64_SVE */
> 
> > I think instead of worrying about the order, we could check the
> > sanitised register value in sme_kernel_enable() and set the FA64 bit.
> 
> There's going to be a ordering/clarity issue whatever way round we do it
> - the FA64 feature bit is in a different feature register to the main
> SME feature bitfield and it's not as abundantly clear as might be ideal 
> that it will have been sanitised when we're getting callbacks for the
> main SME feature, there's an awful lot of sharp edges with this code.
> Having things this way round felt more idiomatic to me.

You may want to add a comment in the cpu_feature[] array that it should
be placed after SME.

> > Also to me 'fa64_kernel_enable' somehow implies that the kernel cares
> > about FA64 for itself but AFAICT we never run the kernel in streaming
> > mode.
> 
> We do run the kernel in streaming mode - entering the kernel through a
> syscall or preemption will not change the streaming mode state, and we
> need to be in streaming mode in order to save or restore the register
> state for streaming mode.  In particular we need FA64 enabled for EL1 in
> order to context switch FFR when in streaming mode, without it we'll
> generate an exception when we execute the rdffr or wrffr.  We don't do
> any real floating point work in streaming mode but we absolutely need to
> run in streaming mode and only exit streaming mode when restoring a
> context where it is disabled, when using floating point in the kernel or
> when idling the CPU.

So, IIUC, for Linux it is mandatory that FEAT_SME_FA64 is supported,
otherwise we won't be able to enable SME. Does the architecture say
this feature as optional? Which A64 instructions are not available if
FA64 is disabled? I hope it's only the SVE ones but I thought we can
still do load/store of the state even with FA64 disabled.

Anyway, if we can't even context switch without FA64 while in streaming
mode, I think we should move the check in the main SME .matches function
and enable it in sme_kernel_enable(), no need for an additional feature.

I think we should also update booting.rst to require that the FA64 is
enabled at EL2 and EL3.

-- 
Catalin
