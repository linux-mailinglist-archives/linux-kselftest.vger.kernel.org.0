Return-Path: <linux-kselftest+bounces-23184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F40239ED30A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 18:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F34D1881FE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3941D934B;
	Wed, 11 Dec 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsVvqMfz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7271D24634B;
	Wed, 11 Dec 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936754; cv=none; b=eDSadfNmPKdy+d9l3Aew0AxH4MsnVEA5tVK0ma2KpzGGr2nNYV9mycNLEXHepUcayTE4Ci6/q6q4HMTU2izp/CThiZWig6zvyGKocvjXCqB6xthA26QF3MvIaswHxWoKFgyDYAz4AOEk0GquCu2lurLUASWuYLQ//R1NSrjm/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936754; c=relaxed/simple;
	bh=biHnKyaLcB/cKm1iMB9cDtlUFOs54YUahLAFVhWIcvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9d7JM+E5FlfI/8LdCbkfau9frlOtv62dPXcIdpJ4eWl7nqqauKk6HC3GtN0b+ZzPnqManX9293sKImJ2hxdbAo7cjAHj79kbDVjGaf6oPfaTukzye8Kztw2sDS929lsTXUjgBsW8gith+rhqBhu/SVpEljiMaTuN/n0Qo/r/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsVvqMfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB87C4CED2;
	Wed, 11 Dec 2024 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733936754;
	bh=biHnKyaLcB/cKm1iMB9cDtlUFOs54YUahLAFVhWIcvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsVvqMfzP7pDDl2W5FpIh7iUHdlU/NtfmXLXAi3cbj6q/Qj8KnWb+feFfTGY5zTC7
	 pGJWA8RQnTo9hLzZjITF3qq2nKD4v/lWDPF4gygaKJfI1jVzB51hiQEbcsPgk65BBj
	 OpkzI2kK76Lct51wk9rXU5TeTpfEdkKYiSteoDlvjD6Ec3pyAd7dYxihZb0GZogzjH
	 GbGcxlcFaVFZqsL0eAdvMuWW0NlY8Bd12pNuw+Ks8D6S1lHXV5BX9tjRjJpfLCl2FC
	 ZNiF4QpuTgg+MpFR6qo7cnZu3BeeXZvoh8vm3q6XpPyKu8EX0L9Jd39kihr8YcJDNX
	 AXgGb5hFRBgTg==
Date: Wed, 11 Dec 2024 18:05:49 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Rob Herring <robh@kernel.org>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/4] drivers: base: test: Drop "devm" from
 platform-device-test names
Message-ID: <uxpnt2u2vnoh2ienawlz5e2gbwseacb5eyldnomz2sal6u2224@wjwrfgicoez7>
References: <20241210191353.533801-1-briannorris@chromium.org>
 <20241210191353.533801-4-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="g2bqkszblmg3snrk"
Content-Disposition: inline
In-Reply-To: <20241210191353.533801-4-briannorris@chromium.org>


--g2bqkszblmg3snrk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4] drivers: base: test: Drop "devm" from
 platform-device-test names
MIME-Version: 1.0

Hi,

On Tue, Dec 10, 2024 at 11:13:32AM -0800, Brian Norris wrote:
> This is a reasonably-helpful base for generic platform_device tests, and
> I'd like to add more tests that aren't specifically about "devm"
> functions. Drop the devm namings for the suite, for clarity.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>=20
>  drivers/base/test/platform-device-test.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test=
/platform-device-test.c
> index ea05b8785743..fd871bb9e143 100644
> --- a/drivers/base/test/platform-device-test.c
> +++ b/drivers/base/test/platform-device-test.c
> @@ -15,7 +15,7 @@ struct test_priv {
>  	struct device *dev;
>  };
> =20
> -static int platform_device_devm_init(struct kunit *test)
> +static int platform_device_init(struct kunit *test)
>  {
>  	struct test_priv *priv;
> =20
> @@ -203,7 +203,7 @@ static void probed_platform_device_devm_register_get_=
unregister_with_devm_test(s
>  	platform_driver_unregister(&fake_driver);
>  }
> =20
> -static struct kunit_case platform_device_devm_tests[] =3D {
> +static struct kunit_case platform_device_tests[] =3D {
>  	KUNIT_CASE(platform_device_devm_register_unregister_test),
>  	KUNIT_CASE(platform_device_devm_register_get_unregister_with_devm_test),
>  	KUNIT_CASE(probed_platform_device_devm_register_unregister_test),
> @@ -211,13 +211,13 @@ static struct kunit_case platform_device_devm_tests=
[] =3D {
>  	{}
>  };
> =20
> -static struct kunit_suite platform_device_devm_test_suite =3D {
> -	.name =3D "platform-device-devm",
> -	.init =3D platform_device_devm_init,
> -	.test_cases =3D platform_device_devm_tests,
> +static struct kunit_suite platform_device_test_suite =3D {
> +	.name =3D "platform-device",
> +	.init =3D platform_device_init,
> +	.test_cases =3D platform_device_tests,
>  };

The rest of the patches look ok to me, but it still seems like it tests
something different (ie, devm actions) so I don't see why we should
group them in the same test suite.

Maxime

--g2bqkszblmg3snrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ1nGaAAKCRAnX84Zoj2+
djNvAYDwHF8ELl/lFhHbbTC9fFi04VFfGcbYlKSqriNTKQS+zCxYaU7eTvxJbI2S
SN/KjN4Bfij+TSRunnYKb5HHczbNM0xl/eNjxixZYJA6MIvqzKiYiNZCSISfkGt+
HzlGRcuv7Q==
=gx7G
-----END PGP SIGNATURE-----

--g2bqkszblmg3snrk--

