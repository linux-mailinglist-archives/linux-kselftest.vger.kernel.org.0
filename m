Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF44BED94
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Feb 2022 00:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiBUXLJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Feb 2022 18:11:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiBUXLI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Feb 2022 18:11:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE9245A3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 15:10:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58715B8125F
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 23:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD54C340E9;
        Mon, 21 Feb 2022 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645485041;
        bh=EaCFmyj92yIHZt8ga8lxHrIMPHnSGppjxbLZdcRWHjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPhjkiXz0bRhpakWpXGED8Nce1NMUlFHc64t8sK2JfPApp6Yg8c6huQ4DrBUKHoDQ
         4bmJaAWbz2F7/fYHwd6wOk9VI4AUZGa5LTOX8Tu1Upnih7LQ0EpEcrY408HED40bC5
         owMSkFsmNt0l5XvR8lzNmlo7nKMP1yly35Iqhrx/Y7Y1iL9AG/piKNbPVZ8RyvFOzg
         eREcEHvuko3xGvEq9dD6r+Helo/Qld1EuVCGdgLWCrbO5bsN/YhCcliJejD11KE3DM
         IJTMKx68BjiBZ8EycQEDFPCsJ9iEPe1W/RrZLKOxLhWEn1JxQzzb7bPfZFovB8EQd9
         luehRVLLNlrIQ==
Date:   Mon, 21 Feb 2022 23:10:34 +0000
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
Subject: Re: [PATCH v11 10/40] arm64/sme: Basic enumeration support
Message-ID: <YhQb6r0mVSYDHowo@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-11-broonie@kernel.org>
 <YhOihgeVRTztfDqv@arm.com>
 <YhOpL54V9RAthj24@sirena.org.uk>
 <YhPnCx+Rajjverjc@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="48wViOh+9i5jEWHn"
Content-Disposition: inline
In-Reply-To: <YhPnCx+Rajjverjc@arm.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--48wViOh+9i5jEWHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2022 at 07:24:59PM +0000, Catalin Marinas wrote:
> On Mon, Feb 21, 2022 at 03:01:03PM +0000, Mark Brown wrote:

> > There's going to be a ordering/clarity issue whatever way round we do it
> > - the FA64 feature bit is in a different feature register to the main
> > SME feature bitfield and it's not as abundantly clear as might be ideal=
=20
> > that it will have been sanitised when we're getting callbacks for the
> > main SME feature, there's an awful lot of sharp edges with this code.
> > Having things this way round felt more idiomatic to me.

> You may want to add a comment in the cpu_feature[] array that it should
> be placed after SME.

Sure.

> > We do run the kernel in streaming mode - entering the kernel through a
> > syscall or preemption will not change the streaming mode state, and we
> > need to be in streaming mode in order to save or restore the register
> > state for streaming mode.  In particular we need FA64 enabled for EL1 in
> > order to context switch FFR when in streaming mode, without it we'll
> > generate an exception when we execute the rdffr or wrffr.  We don't do
> > any real floating point work in streaming mode but we absolutely need to
> > run in streaming mode and only exit streaming mode when restoring a
> > context where it is disabled, when using floating point in the kernel or
> > when idling the CPU.

> So, IIUC, for Linux it is mandatory that FEAT_SME_FA64 is supported,
> otherwise we won't be able to enable SME. Does the architecture say

The feature is not mandatory and we do not require it for Linux.  It is
expected that many implementations will choose to not support FA64.

The only impact it has on the kernel is that if it's present then we
need to enable it for each EL and then context switch FFR in streaming
mode, the code is there to do that conditionally already.  We'd also
have to take it into account if we were to run streaming mode algorithms
in the kernel but if we ever do so that's just an additional feature
check when choosing to run such code.

> this feature as optional? Which A64 instructions are not available if
> FA64 is disabled? I hope it's only the SVE ones but I thought we can
> still do load/store of the state even with FA64 disabled.

There's a rather large subset of mostly FPSIMD and some SVE instructions
(including those for accessing FFR which is why we don't need to context
switch it in streaming mode), you can see a full list in appendix F1 of
the SME specification.

This is actually a bit awkward for not disabling streaming mode when we
do a syscall since the disabled instructions include the FPSMID mov
vector, vector instruction which we currently use to zero the high bits
of the Z registers.  That issue goes away if the optimisations I've got
for relaxed flushing of the non-shared SVE state that we discussed in
relation to syscall-abi get merged, though it'd still be there if we add
a sysctl to force flushing.  This is a solvable problem though, even if
we have to use a less efficient sequence to flush in streaming mode.

> Anyway, if we can't even context switch without FA64 while in streaming
> mode, I think we should move the check in the main SME .matches function
> and enable it in sme_kernel_enable(), no need for an additional feature.

Given that it's optional and we need to check for it at runtime in order
to context switch it seems sensible to use the cpufeature infrastructure
for the detection.

> I think we should also update booting.rst to require that the FA64 is
> enabled at EL2 and EL3.

That's there already since d198c77b7fab13d4 ("arm64: Document boot
requirements for FEAT_SME_FA64").

--48wViOh+9i5jEWHn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIUG+kACgkQJNaLcl1U
h9BhMQf8CnriLH/a22qJzNtNpVX1j4OrAuBxd+ph0uM4jfN7qcbEke+OwdiTq7aP
d069yVSc9c+g3sIuEoUFhHwxRTrCTlxwD4Mm7rn441ojgROzASL3e7Lp3k8W+R1V
YduvbIE+HfZaUqzLcn9cwBSphJerRI/AFvNlCzRrCLJc632DFwqIqVe4XBbX8jmj
RBgVOoOqomjwtIvI+S3WeLHOctKgOkxDI/gdB165+knDZ2kGB+8Ngdz7ql1++Csz
4kZc/DLGV0ic8NRxxo/Jqzm6bp+/HsCMsrL5o2ppGxCWnrPah/JVnXq0BxRrE2+7
GfR6MlPOOPhRSEWkmle6QcUR/w8tLA==
=aLg+
-----END PGP SIGNATURE-----

--48wViOh+9i5jEWHn--
