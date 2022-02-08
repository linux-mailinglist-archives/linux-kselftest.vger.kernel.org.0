Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD24ADE5A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 17:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351959AbiBHQ3r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 11:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiBHQ3r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 11:29:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E78C061576
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 08:29:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F90661707
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 16:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D110C340E9;
        Tue,  8 Feb 2022 16:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337785;
        bh=+5Zu36w3Z7l8aK82NgoCsT/t+kuTmdRMQt5D0ZAJBMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4DR/H1wqwak6irFSXmGw+vNSINk7ar41kFh7cZotPij1MMinQNEv8LXyJPxRAScb
         /6myfP0y33b6uDhNjpkORwhUDiZIsD7mPy7E4FAaK5jWwetoC69RztqKaVATftr/P+
         7vGuQke/gzTjfOne0ktSL+M16ufNgFhETvVUI0c9evHXlmT6qPjqbjifokC4Z/mGEC
         kChXNHcr7TRH3dG8drmtjY5e2AxOMdXiHqB5spM43IF1vMYA4d95l8qNcT1kuud9Ph
         ORlU5wDGvwJ8ibuvnozIZEBTKulGk25RpZsIjONZy2iz5ugLeTO10OkM/R5qVTcnRa
         eHo+kt8rAiHgg==
Date:   Tue, 8 Feb 2022 16:29:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
Subject: Re: [PATCH v11 35/40] kselftest/arm64: signal: Handle ZA signal
 context in core code
Message-ID: <YgKaczaZ0viHb/YN@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-36-broonie@kernel.org>
 <c69632e7-45d1-b29f-79a9-1724cbb0a30b@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hDl71TpnNMq68KTE"
Content-Disposition: inline
In-Reply-To: <c69632e7-45d1-b29f-79a9-1724cbb0a30b@linuxfoundation.org>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--hDl71TpnNMq68KTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 07, 2022 at 06:01:49PM -0700, Shuah Khan wrote:
> On 2/7/22 8:21 AM, Mark Brown wrote:

> > +		case ZA_MAGIC:
> > +			if (flags & ZA_CTX)
> > +				*err =3D "Multiple ZA_MAGIC";
>=20
> Is this considered an error?

Yes.

> > @@ -165,6 +198,9 @@ bool validate_reserved(ucontext_t *uc, size_t resv_=
sz, char **err)
> >   		if (flags & SVE_CTX)
> >   			if (!validate_sve_context(sve, err))
> >   				return false;
> > +		if (flags & ZA_CTX)
> > +			if (!validate_za_context(za, err))

> If validate_za_context() finds an error, the above "Multiple ZA_MAGIC" wi=
ll
> be overwritten? Is that the intent?

Both are errors.

--hDl71TpnNMq68KTE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICmnIACgkQJNaLcl1U
h9A89Qf/bcWFc2MLnS6lvBGeighVtkeAqCfWm9YihdqQjIThY5aJ/fW6K8RQY409
QkDbHUYvra9/O4gXHqcsFIYVy3pKSEUa1Kq4FJ0cSbAPEm8q0pF5LHYmjmO7GO0P
W2mTrEAv8pOhTNESQknhFBUWPSX6dlz204grYPCpZcTV6bSyf0YqK7yNcu4eSxY2
Tbfinmr8oigfvgZkXsMxtEvat9XPrWVCdhA63VaN1iPS8UblN7870cqUMziLlcpH
0HFiEE9rz9+5IJPDZ4qL6aAfNRI1iGompzji4fq0J7EA47PuyTk4NdVFoIYM9zN/
rC4/4/JM1h5ZoMejHTJjyZAXiQYtJA==
=XzJM
-----END PGP SIGNATURE-----

--hDl71TpnNMq68KTE--
