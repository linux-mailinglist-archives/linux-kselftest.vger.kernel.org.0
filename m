Return-Path: <linux-kselftest+bounces-23315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0049F0BC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 13:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D482827CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770B01DF268;
	Fri, 13 Dec 2024 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h20qHjUa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474761A08A6;
	Fri, 13 Dec 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091200; cv=none; b=pjYCgIIYIv+BK7ne0allwnK04vWn2qaQVtAWtk2Kq4Lt/+u+iSznVkXSL/Tjz0sv2g4krToDoVYpcfKZObtR5m1BJdBg27/x+LmkVIt4SiX4yeNCe9N+zYBI6enyMED31G8im0Ecf8fEix1sBIL0wNS8plig7Ssrf+7llPyoS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091200; c=relaxed/simple;
	bh=u0Sb066jR4i3kqSYmXzuGtO7rP72CJmz06cNlBH0hcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czMnj5Qk2zlBGVhaHDadCnA8VQmibzfK0EQAXsRtgQTxDEeLJ5mVXQZqq0mrhX7Ik24s+nJuoytLPVgpBtBR/dE5Rc0ZxywOmqoeIPbWRw3jSyB93mi85KIneQ57MLdiDHCJuEGpAZxPJg60IC3NYK7dpXilEv/x1miJsIndLKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h20qHjUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE4CC4CED0;
	Fri, 13 Dec 2024 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734091199;
	bh=u0Sb066jR4i3kqSYmXzuGtO7rP72CJmz06cNlBH0hcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h20qHjUaqsqR+9NToxHdTB+ZXljbPxXf5x7esKb1rptLnC+k0tAuDX7BDYy/Rxs9b
	 FIe28TYqmNsuONipa9+1Oo3lnfvmxFU72y3DX+ExlO6j4WUtqg87z92VUp+jk4dqU1
	 6FgmsVHGzERI2i50vy56E8dSWPmeC9VyLuDabda/AkdOjtKKXRrNczr9A3/UOQ2suK
	 qdaHx+6l4ZmUZWjKKgemuVKveceuqNHwgjyaKy0nBcXEQapF7xo+0iQGdgliiJdnvv
	 lLw93Pcd6XH4nmnOJZCsRQ++NngErwz1vQCOMmSVD+vL1zT+UkpUen/2ME8sC+h5k5
	 AboVCEqYCSlBA==
Date: Fri, 13 Dec 2024 12:59:57 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] drivers: base: test: Add ...find_device_by...(...
 NULL) tests
Message-ID: <20241213-athletic-strong-bumblebee-bfabf1@houat>
References: <20241212003201.2098123-1-briannorris@chromium.org>
 <20241212003201.2098123-4-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7snr6qwlmjeebc3w"
Content-Disposition: inline
In-Reply-To: <20241212003201.2098123-4-briannorris@chromium.org>


--7snr6qwlmjeebc3w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] drivers: base: test: Add ...find_device_by...(...
 NULL) tests
MIME-Version: 1.0

Hi,

On Wed, Dec 11, 2024 at 04:31:41PM -0800, Brian Norris wrote:
> We recently updated these device_match*() (and therefore, various
> *find_device_by*()) functions to return a consistent 'false' value when
> trying to match a NULL handle. Add tests for this.
>=20
> This provides regression-testing coverage for the sorts of bugs that
> underly commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device
> only if one actually exists").
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>=20
> Changes in v2:
>  * Keep "devm" and "match" tests in separate suites
>=20
>  drivers/base/test/platform-device-test.c | 42 +++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test=
/platform-device-test.c
> index ea05b8785743..c8d4b0a385f2 100644
> --- a/drivers/base/test/platform-device-test.c
> +++ b/drivers/base/test/platform-device-test.c
> @@ -3,6 +3,8 @@
>  #include <kunit/resource.h>
> =20
>  #include <linux/device.h>
> +#include <linux/device/bus.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> =20
>  #define DEVICE_NAME "test"
> @@ -217,7 +219,45 @@ static struct kunit_suite platform_device_devm_test_=
suite =3D {
>  	.test_cases =3D platform_device_devm_tests,
>  };
> =20
> -kunit_test_suite(platform_device_devm_test_suite);
> +static void platform_device_find_by_null_test(struct kunit *test)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev =3D platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +	ret =3D platform_device_add(pdev);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

I *think* you have a bug there: if platform_device_add fails,
KUNIT_ASSERT will stop the test execution and thus you will leak the
platform_device you just allocated.

You need to call platform_device_put in such a case, but if
platform_device_add succeeds then you need to call
platform_device_unregister instead.

It would be better to use kunit_platform_device_alloc and
kunit_platform_device_add that already deal with this.

The rest looks good to me, once fixed:
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--7snr6qwlmjeebc3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ1whtgAKCRAnX84Zoj2+
drgVAYC25+nvuEysmbcasOB2RjIFmcZ9PldsACXyDBDoeJeXBpB3YhMh6Vw90BIG
EQQ03CABgKbWgKqxNLrM68+yaHDG9u7bdRhZDyRHxPS9jx20dAxOJSsQ1J3uB8Kq
pc2gSDAyqw==
=sA+0
-----END PGP SIGNATURE-----

--7snr6qwlmjeebc3w--

