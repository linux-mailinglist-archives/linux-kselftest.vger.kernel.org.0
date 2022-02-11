Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEF04B2B31
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 18:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiBKRC2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 12:02:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiBKRC1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 12:02:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720933B3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 09:02:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A3DAB82AD0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 17:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3804C340E9;
        Fri, 11 Feb 2022 17:02:19 +0000 (UTC)
Date:   Fri, 11 Feb 2022 17:02:16 +0000
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
Message-ID: <YgaWmP+P7v9b2lLz@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
 <YgVaTounTtunlGU6@arm.com>
 <YgVrbc4fFrA0Vjh2@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgVrbc4fFrA0Vjh2@sirena.org.uk>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 10, 2022 at 07:45:49PM +0000, Mark Brown wrote:
> On Thu, Feb 10, 2022 at 06:32:46PM +0000, Catalin Marinas wrote:
> > On Mon, Feb 07, 2022 at 03:20:35PM +0000, Mark Brown wrote:
> > > +4.  System call behaviour
> > > +-------------------------
> 
> > > +* On syscall PSTATE.ZA is preserved, if PSTATE.ZA==1 then the contents of the
> > > +  ZA matrix are preserved.
> 
> > Sorry if this was discussed. What is the rationale for preserving the ZA
> > registers on syscall? We don't do this for the top part of the Z
> > registers.
> 
> In both cases it's mirroring the expected PCS which is that for normal
> functions they must be called with streaming mode disabled, the high
> bits of Z may be changed and there is a lazy saving scheme for ZA.  The
> handling of the Z registers falls out of a combination of the fact that
> the low bits are shared with the V registers and a desire to
> interoperate with binaries that are only aware of FPSIMD.
> 
> See:
> 
>   https://github.com/rsandifo-arm/abi-aa/blob/sme-aapcs64/aapcs64/aapcs64.rst
> 
> for the PCS (it's an open pull request on the AAPCS), if we disable ZA
> we should really cooperate with the lazy save scheme for ZA in section
> 6.5 which would involve writing to userspace buffers.  Given that we
> need to support preserving ZA for cases where userspace is preempted
> it's not really much effort to do that, if userspace doesn't want the
> cost it can disable ZA before doing a syscall and it means that syscalls
> don't push userspace code that would otherwise not do anything with ZA
> to have problems interoperating with the lazy saving scheme.
> 
> If we don't preserve ZA then userspace will be forced to save it when
> enabled which increases overall costs, if we do preserve ZA then it's no
> more expensive for the kernel to save it than userspace, we avoid the
> cost of restoring in the case where return directly to userspace without
> context switching and if we do future work to save more lazily then we
> may be able to avoid some of the saves.

Thanks for the explanation and the PCS pointer. I guess doing the lazy
saving scheme in the syscall handler is a lot more painful (faults etc.)
and it's a user-only ABI/PCS, so we shouldn't tie the kernel into it.

Given that Linux doesn't plan to use the ZA registers itself, in most
cases it won't need to restore anything. But we still need to save the
ZA registers on context switch in case the thread wakes up on a
different CPU. How often do you reckon would the user do a syscall with
active ZA?

Anyway, I'll go through the other patches and get back to the ABI doc
later, once I understand the kernel implementation better.

> > > +  as normal.
> 
> > What does that mean? Is this as per the sve.rst doc (unspecified but
> > zeroed in practice)?
> 
> Yes, we will exit streaming mode and proceed as per sve.rst and the rest
> of the ABI.

So in this case we consider the syscall interface as non-streaming (as
per the PCS terminology). Should we require that the PSTATE.SM is
cleared by the user as well? Alternatively, we could make it
streaming-compatible and just preserve it. Are there any drawbacks?
kernel_neon_begin() could clear SM if needed.

> > > +* Neither the SVE registers nor ZA are used to pass arguments to or receive
> > > +  results from any syscall.
> > > +
> > > +* On creation fork() or clone() the newly created process will have PSTATE.SM
> > > +  and PSTATE.ZA cleared.
> 
> > This looks slightly inconsistent with the first bullet point on ZA being
> > preserved on syscalls. Why do these differ?
> 
> Largely just because it's more complicated to implement copying the ZA
> backing store for this and it seemed more likely that someone would be
> surprised by a new process getting stuck carrying a potentially large
> copy of ZA around that it was unaware of than that someone would
> actually want that to happen.  It's not a particularly strongly held
> opinon.

If PSTATE.ZA is valid and the user does a fork() (well, implemented as
clone()), normally it expects a nearly identical state in the child.
With clone() if a new thread is created, we likely don't need the
additional ZA state. We got away with having to think about this for
SVE as the state is lost on syscall. Here we risk having a vaguely
defined ABI - fork() is disabled on arm64 for example but we do have
clone() and clone3().

Still thinking about this but maybe we could do something like always
copy the ZA state unless CLONE_VM is passed for example. It is
marginally more precise.

> > > +[4] ARM IHI0055C
> > > +    http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055c/IHI0055C_beta_aapcs64.pdf
> > > +    http://infocenter.arm.com/help/topic/com.arm.doc.subset.swdev.abi/index.html
> > > +    Procedure Call Standard for the ARM 64-bit Architecture (AArch64)
> 
> > The second link no longer works. I also couldn't find any reference to
> > [4] but there's a lot of text to scan, so I may have missed it.
> 
> We don't referenced it, it's just carried over from SVE.

So I guess we can drop them from this doc.

-- 
Catalin
