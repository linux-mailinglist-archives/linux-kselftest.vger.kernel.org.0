Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E583A4BEAAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Feb 2022 20:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiBUTFD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Feb 2022 14:05:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBUTFC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Feb 2022 14:05:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81AB13D0A
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 11:04:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43CDE60A27
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 19:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CF7C340E9;
        Mon, 21 Feb 2022 19:04:34 +0000 (UTC)
Date:   Mon, 21 Feb 2022 19:04:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v11 10/40] arm64/sme: Basic enumeration support
Message-ID: <YhPiPwilGYsd663m@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-11-broonie@kernel.org>
 <YhOihgeVRTztfDqv@arm.com>
 <20220221160706.GK2692478@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221160706.GK2692478@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 21, 2022 at 04:07:06PM +0000, Szabolcs Nagy wrote:
> The 02/21/2022 14:32, Catalin Marinas wrote:
> > On Mon, Feb 07, 2022 at 03:20:39PM +0000, Mark Brown wrote:
> > > diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> > > index b72ff17d600a..5626cf208000 100644
> > > --- a/Documentation/arm64/elf_hwcaps.rst
> > > +++ b/Documentation/arm64/elf_hwcaps.rst
> > > @@ -259,6 +259,39 @@ HWCAP2_RPRES
> > >  
> > >      Functionality implied by ID_AA64ISAR2_EL1.RPRES == 0b0001.
> > >  
> > > +HWCAP2_SME
> > > +
> > > +    Functionality implied by ID_AA64PFR1_EL1.SME == 0b0001, as described
> > > +    by Documentation/arm64/sme.rst.
> > > +
> > > +HWCAP2_SME_I16I64
> > > +
> > > +    Functionality implied by ID_AA64SMFR0_EL1.I16I64 == 0b1111.
> > > +
> > > +HWCAP2_SME_F64F64
> > > +
> > > +    Functionality implied by ID_AA64SMFR0_EL1.F64F64 == 0b1.
> > > +
> > > +HWCAP2_SME_I8I32
> > > +
> > > +    Functionality implied by ID_AA64SMFR0_EL1.I8I32 == 0b1111.
> > > +
> > > +HWCAP2_SME_F16F32
> > > +
> > > +    Functionality implied by ID_AA64SMFR0_EL1.F16F32 == 0b1.
> > > +
> > > +HWCAP2_SME_B16F32
> > > +
> > > +    Functionality implied by ID_AA64SMFR0_EL1.B16F32 == 0b1.
> > > +
> > > +HWCAP2_SME_F32F32
> > > +
> > > +    Functionality implied by ID_AA64SMFR0_EL1.F32F32 == 0b1.
> > > +
> > > +HWCAP2_SME_FA64
> > > +
> > > +    Functionality implied by ID_AA64SMFR0_EL1.FA64 == 0b1.
> > 
> > More of a question for the libc people: should we drop the fine-grained
> > HWCAP corresponding to the new ID_AA64SMFR0_EL1 register (only keep
> > HWCAP2_SME) and get the user space to use the MRS emulation? Would any
> > ifunc resolver be affected?
> 
> good question.
> 
> within glibc HWCAP2_SME is enough (to decide if we need to
> deal with additional register state and the lazy ZA save
> scheme) but i guess user code that actually uses sme would
> need the details (including in ifunc resolvers in principle).
> 
> since we have mrs, there is no strict need for hwcaps.
> if ifunc resolvers using this info are not widespread then
> the mrs emulation overhead is acceptable, but i suspect
> hwcaps are nicer to use.

I presume the ifunc resolvers only run once, so the overhead won't be
noticed. Anyway, happy to keep the new HWCAP2 if they are useful.

> do we have a plan after hwcap2 bits run out? :)

HWCAP3 or we free up the top 32-bit in both HWCAP and HWCAP2 ranges. We
did not extend into those upper bits because of the ILP32 discussions at
the time.

-- 
Catalin
