Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1310658A0A3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Aug 2022 20:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbiHDSlV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Aug 2022 14:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiHDSlU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Aug 2022 14:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4858A1D0E0
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Aug 2022 11:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8EB261568
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Aug 2022 18:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC2AC433D6;
        Thu,  4 Aug 2022 18:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659638479;
        bh=jg4q84W9v0wgYEAjiQAH79WQmYSw0lmd+IHamTwgS1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGHWjTTsGDHRnxUepbnvNeUxlnOlD/6N0y6QlzWxUGan4MC1bWHC2DPKdVZvIs+CS
         1ikQewUfVA0rySNymLbPqi9h+ibWGQ+RG+06bjwKU4VJHHxNFH3AwGVibysrZ0lmaf
         b5QN7gJ1p8Qh1NL0FRRmpvQBR87E1a1C8vtRpkU8q+VWiQoUU22B/mdjSnXoE8Y1AZ
         QdMDi7gYyZ1OvsSGKP2D4RoIZthdiSBEq5lIjJvwYBjMiapxBdNvGcukqF4ECo+xxN
         8hpiAOkb87c/OL+HUV0QTHZE6ePYDGHR14rEDyTCShuggFDejQ8TwvVZI6BMvZMDqU
         gcAsyKZdL3Nog==
Date:   Thu, 4 Aug 2022 19:41:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Enumerate SME rather than SVE vector
 lengths for za_regs
Message-ID: <YuwSysdGFPvj978m@sirena.org.uk>
References: <20220804182606.255728-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M+7+sdrxlD3LZzJV"
Content-Disposition: inline
In-Reply-To: <20220804182606.255728-1-broonie@kernel.org>
X-Cookie: Did I say 2?  I lied.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--M+7+sdrxlD3LZzJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 04, 2022 at 07:26:06PM +0100, Mark Brown wrote:
> The za_regs signal test was enumerating the SVE vector lengths rather than
> the SVE vector lengths through cut'n'paste error when determining what to

*sigh*  SME.

> test. Enumerate the SME vector lengths instead.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/signal/testcases/za_regs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/t=
ools/testing/selftests/arm64/signal/testcases/za_regs.c
> index b94e4f99fcac..9f1dd70289be 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
> +++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
> @@ -22,10 +22,10 @@ static bool sme_get_vls(struct tdescr *td)
>  	int vq, vl;
> =20
>  	/*
> -	 * Enumerate up to SVE_VQ_MAX vector lengths
> +	 * Enumerate up to SME_VQ_MAX vector lengths
>  	 */
>  	for (vq =3D SVE_VQ_MAX; vq > 0; --vq) {
> -		vl =3D prctl(PR_SVE_SET_VL, vq * 16);
> +		vl =3D prctl(PR_SME_SET_VL, vq * 16);
>  		if (vl =3D=3D -1)
>  			return false;
> =20
> --=20
> 2.30.2
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--M+7+sdrxlD3LZzJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLsEskACgkQJNaLcl1U
h9CLhQf7BN3gckegu33FHIUmt6NXXcZeVdticgk5TWcex/r9x/Imsc+mk0Aiiyq/
a00zWVNLx2ujdl0VgrGXdRfvbLLXDdNA/RY3iGAgqKAfv/WjMMQdroKXUxaYgQ/w
q5QzpBsRIuLXpqlJ3l0zWn+R20N/ptPMorZLxoz3zlIaTKpglmnRzR4m/gokbZsZ
Idr5KUlzbqizfJHKGMSEUYssEKqNcXP86bq4dqZFvQzZJpubDzvlG7yNN2fK/kHq
PARDXrW88/NMSO8Cz6cvNAtkF7MAKNffO92602sqfZVJBqU0tmrkMZ03yQfLJ+r6
Tx3UOK2WPnggvLWK7E/uahQlNSVfKg==
=mDqB
-----END PGP SIGNATURE-----

--M+7+sdrxlD3LZzJV--
