Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE94B1684
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 20:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiBJTqD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 14:46:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBJTqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 14:46:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C5BE49
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 11:46:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF7C5B8272B
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 19:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B65C004E1;
        Thu, 10 Feb 2022 19:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644522356;
        bh=2/d36OBbSBxlblWgpunNGQoCjUN3lbA5kTgumqeqpPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFbJvvg04LiXsdxqp6J+MMjRBfSHyXxF5SVtvHBUdfAm7Tj4ATmmEzAHLmTBxRgPG
         hZ6h65hQbrjz/1OZL+FLZ88/UQFYsgpDS9ZpSQJJQlYuLj4Mvad8D2YkkQVOtZrd+7
         M5RIbw4bhYAaFRYrbLF7buIt+7Sbv48m+xefrr6EEVj5dlWQ3gluyjQAzol45/adwO
         nJhEDnOU3gxFUV3QG2E00X0r7mDzhnFVVz6cyJd+uJpbg/nn7y3tXbEHOvA4glITdS
         YTCo4xt963J3T4ojxuVhxKp6lsstxLHYdvg8895QDpEqO4TnHDHjU3/vPHheFjxNUp
         D8md5Wf4M+yWA==
Date:   Thu, 10 Feb 2022 19:45:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <YgVrbc4fFrA0Vjh2@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
 <YgVaTounTtunlGU6@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ucqnplsdaKjxWywi"
Content-Disposition: inline
In-Reply-To: <YgVaTounTtunlGU6@arm.com>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ucqnplsdaKjxWywi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 10, 2022 at 06:32:46PM +0000, Catalin Marinas wrote:
> On Mon, Feb 07, 2022 at 03:20:35PM +0000, Mark Brown wrote:

> > +It is implementation defined which if any parts of the SVE state are shared
> > +between streaming and non-streaming modes.  When switching between modes
> > +via software interfaces such as ptrace if no register content is provided as
> > +part of switching no state will be assumed to be shared and everything will
> > +be zeroed.

> Is there anything other than ptrace() here? I read the sigreturn() case
> below but did not say anything about changing PSTATE.SM via the
> sigcontext. I guess it's similar to ptrace().

The signal handling code requires that register data be provided to
restore with either form of SVE data, this falls out of the existing
requirement that register data be provided for SVE.

> > +4.  System call behaviour
> > +-------------------------

> > +* On syscall PSTATE.ZA is preserved, if PSTATE.ZA==1 then the contents of the
> > +  ZA matrix are preserved.

> Sorry if this was discussed. What is the rationale for preserving the ZA
> registers on syscall? We don't do this for the top part of the Z
> registers.

In both cases it's mirroring the expected PCS which is that for normal
functions they must be called with streaming mode disabled, the high
bits of Z may be changed and there is a lazy saving scheme for ZA.  The
handling of the Z registers falls out of a combination of the fact that
the low bits are shared with the V registers and a desire to
interoperate with binaries that are only aware of FPSIMD.

See:

  https://github.com/rsandifo-arm/abi-aa/blob/sme-aapcs64/aapcs64/aapcs64.rst

for the PCS (it's an open pull request on the AAPCS), if we disable ZA
we should really cooperate with the lazy save scheme for ZA in section
6.5 which would involve writing to userspace buffers.  Given that we
need to support preserving ZA for cases where userspace is preempted
it's not really much effort to do that, if userspace doesn't want the
cost it can disable ZA before doing a syscall and it means that syscalls
don't push userspace code that would otherwise not do anything with ZA
to have problems interoperating with the lazy saving scheme.

If we don't preserve ZA then userspace will be forced to save it when
enabled which increases overall costs, if we do preserve ZA then it's no
more expensive for the kernel to save it than userspace, we avoid the
cost of restoring in the case where return directly to userspace without
context switching and if we do future work to save more lazily then we
may be able to avoid some of the saves.

> > +  as normal.

> What does that mean? Is this as per the sve.rst doc (unspecified but
> zeroed in practice)?

Yes, we will exit streaming mode and proceed as per sve.rst and the rest
of the ABI.

> > +* Neither the SVE registers nor ZA are used to pass arguments to or receive
> > +  results from any syscall.
> > +
> > +* On creation fork() or clone() the newly created process will have PSTATE.SM
> > +  and PSTATE.ZA cleared.

> This looks slightly inconsistent with the first bullet point on ZA being
> preserved on syscalls. Why do these differ?

Largely just because it's more complicated to implement copying the ZA
backing store for this and it seemed more likely that someone would be
surprised by a new process getting stuck carrying a potentially large
copy of ZA around that it was unaware of than that someone would
actually want that to happen.  It's not a particularly strongly held
opinon.

> > +[4] ARM IHI0055C
> > +    http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055c/IHI0055C_beta_aapcs64.pdf
> > +    http://infocenter.arm.com/help/topic/com.arm.doc.subset.swdev.abi/index.html
> > +    Procedure Call Standard for the ARM 64-bit Architecture (AArch64)

> The second link no longer works. I also couldn't find any reference to
> [4] but there's a lot of text to scan, so I may have missed it.

We don't referenced it, it's just carried over from SVE.

--ucqnplsdaKjxWywi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIFa2wACgkQJNaLcl1U
h9AJwgf/Ypezgo+N1Oozlkua7rL21V3dADz3wxpSkFNz+XMGuu4D9jB5MQMFQ2wt
T9nTi48TNkn+0KIronwPWFZU8HJgScMUdTMCbc5vH1zbcmwvl6yo81kFZvLV3WTv
Wnic6YqHhO8DDI3yEv+4qb9VzrcMHJ3CfJmBdZHMChHl0kZtebtOr8OOv/VdTQ7g
bVKliNO14tPkP1n46GnuCX9E9PTyf00wXxBsPJSJN6xJka79shXNS1QiamJtskb+
fsYYtmlLcOMvX0pV3ECRlUsN2RrjRfAR67/AD47A2Bu5izFbrn6t2+1NwNi8RLgJ
isjUK1vyHHxXlcogPQqvcLCHK0+QTw==
=4wmD
-----END PGP SIGNATURE-----

--ucqnplsdaKjxWywi--
