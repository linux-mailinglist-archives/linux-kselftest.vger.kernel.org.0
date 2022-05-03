Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E27519276
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 01:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244395AbiECXz7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 19:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiECXz6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 19:55:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C92D1F1
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 16:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09A3617F0
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 23:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A132C385B1;
        Tue,  3 May 2022 23:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651621944;
        bh=SWm5tsQRoZWKFpiKOc/x2fsplpE56+E6NZ0o7bJAmkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdU9Y8o+nSYI2fDTTzPb/0eeyA8P8n2t8XwH/ZL/A2L6LMYHC+lrpim5HoQ8TUboM
         eLQGxYwWYZUl425X46i71rLAc79vcKmTfV3g2AtY+gHVKbmnwysBYfJSdGitKnTepk
         EGP0TBaahqrdZ2tG8DmXoADa7177s/1wWGJZLoVMAOHgxGNM1K25aUQ/9orsmnbxVM
         JfWAE+E+xMU2ZYp+qg+3BlWH3cRDl1KikjaV5QTIgtXBl0sbJrrl8Hewj1kk8AW+FM
         TQukq0DQKpYUpxkwnPxYyVTsjUM2S+ldxRIrLx7frcs0onjGBPaU6CRxvVaE4zD0jX
         eCWQ3z+FHNCWQ==
Date:   Wed, 4 May 2022 00:52:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Alan Hayward <alan.hayward@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>
Subject: Re: [PATCH v14 00/39] arm64/sme: Initial support for the Scalable
 Matrix Extension
Message-ID: <YnHANG5cM0CS9ffm@sirena.org.uk>
References: <20220419112247.711548-1-broonie@kernel.org>
 <YnGrbEt3oBBTly7u@qian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Frr2wg0Yl14gtCx1"
Content-Disposition: inline
In-Reply-To: <YnGrbEt3oBBTly7u@qian>
X-Cookie: <Culus-> libc6 is not essential :|
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Frr2wg0Yl14gtCx1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2022 at 06:23:40PM -0400, Qian Cai wrote:
> On Tue, Apr 19, 2022 at 12:22:08PM +0100, Mark Brown wrote:
> > This series provides initial support for the ARMv9 Scalable Matrix
> > Extension (SME).  SME takes the approach used for vectors in SVE and
> > extends this to provide architectural support for matrix operations.  A
> > more detailed overview can be found in [1].
>=20
> Set CONFIG_ARM64_SME=3Dn fixed a warning while running libhugetlbfs tests.
>=20
>         /*
>          * There are several places where we assume that the order value =
is sane
>          * so bail out early if the request is out of bound.
>          */
>         if (unlikely(order >=3D MAX_ORDER)) {
>                 WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
>                 return NULL;
>         }

Ugh, right.  These variable sized register sets really don't map
entirely cleanly onto the ptrace interface but now you point it
out what the code has there is going to give a rather larger
number than is sensible.  Not fully checked but does the below
fix things?

Thanks for your testing with this stuff, it's been really
helpful.

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 47d8a7472171..08c1cb43cf33 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1447,8 +1447,8 @@ static const struct user_regset aarch64_regsets[] =3D=
 {
 	},
 	[REGSET_ZA] =3D { /* SME ZA */
 		.core_note_type =3D NT_ARM_ZA,
-		.n =3D DIV_ROUND_UP(ZA_PT_ZA_SIZE(SVE_VQ_MAX), SVE_VQ_BYTES),
-		.size =3D SVE_VQ_BYTES,
+		.n =3D 1,
+		.size =3D ZA_PT_SIZE(SVE_VQ_MAX),
 		.align =3D SVE_VQ_BYTES,
 		.regset_get =3D za_get,
 		.set =3D za_set,

--Frr2wg0Yl14gtCx1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJxwDMACgkQJNaLcl1U
h9CQsgf/Q4m/iGl8z+mHVPV4t0ivYDXAhsjtBBB7OiPYEhpKxAjxNwbQkSUHmT4u
1Kuv7QBOrp6c+61UQodXcZ3FGTWr/rXqLoRtMEjkVnxxOi4oeeyj65DqsX/WgsH4
yYMtVGGn5ztDOnyX9pYm131Nv0HHObduTAzoSA/SwGFeRhjuuxCiGdoXTnq9foOv
1mflaITdoUCJPHp0gLo3rksyckeMdf6jI0iPs7haJVd8EifLC4/h65P2//YzU8er
LF1CX/sOpOjpHnxMt+EyEIjCMj2eSjdjcJvNrfonaYVR4V3V9rRyCExWHiGdhfsq
Y7Y/mCO5ndmsxPekSdBnlUf5/ksNDQ==
=TMQ4
-----END PGP SIGNATURE-----

--Frr2wg0Yl14gtCx1--
