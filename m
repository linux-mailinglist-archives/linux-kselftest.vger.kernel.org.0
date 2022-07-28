Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6325843E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Jul 2022 18:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiG1QNS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Jul 2022 12:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiG1QNF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Jul 2022 12:13:05 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A7E6E2F9;
        Thu, 28 Jul 2022 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QX9Hvrhq1tv4fuik2gar58r4BELAfbzt39ubLuFRRa0=; b=Ifec17vWKOORU7KJ0UJ0qxyM7V
        BfbF1rc539Oq5wXb9QGSZDhcZIxZrMfngNDwDuR4D+GSRfUyIo8Fe/Xaqkfn5Cs1wzUc6F3ZVHwwe
        mtO12JyefeJ7YdQmoOuRZQCqE572PizMAdBqXJ8mUOd5jCCSuS+GTUt1Nw+l1+FkON8j4UXVeCl96
        6MU8fzYK9ecQS31LIlcFNfz+XChPvIfmAgZ+xlR2xC4fOR27U3A0wrrIkHf0K8Defjfv0PnUtg7tI
        mmj+4hZuc8EF5rXHdTzBcy4JvZ+MN536BLqZ7b5+38+RKCN49IC8+cCL7wNRdpdz12jaiiAvRoNli
        9P6xh4NA==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oH67S-00A3YA-MD; Thu, 28 Jul 2022 18:12:14 +0200
Date:   Thu, 28 Jul 2022 15:11:55 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH] drm/tests: Split up test cases in
 igt_check_drm_format_min_pitch
Message-ID: <20220728161155.tzjalvrxaezk556t@mail.igalia.com>
References: <20220717184336.1197723-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cycfpb3jug72cn35"
Content-Disposition: inline
In-Reply-To: <20220717184336.1197723-1-mairacanal@riseup.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--cycfpb3jug72cn35
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07/17, Ma=EDra Canal wrote:
> The igt_check_drm_format_min_pitch() function had a lot of
> KUNIT_EXPECT_* calls, all of which ended up allocating and initializing
> various test assertion structures on the stack.
>=20
> This behavior was producing -Wframe-larger-than warnings on PowerPC, i386,
> and MIPS architectures, such as:
>=20
> drivers/gpu/drm/tests/drm_format_test.c: In function 'igt_check_drm_forma=
t_min_pitch':
> drivers/gpu/drm/tests/drm_format_test.c:271:1: error: the frame size of
> 3712 bytes is larger than 2048 bytes
>=20
> So, the igt_check_drm_format_min_pitch() test case was split into three
> smaller functions: one testing single plane formats, one testing multiple
> planes formats, and the other testing tiled formats.
>=20
Hi Ma=EDra,

Could you add a Fixes tag to indicate the commit that introduces the
issue?

Thanks,

Melissa

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ma=EDra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/tests/drm_format_test.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_format_test.c b/drivers/gpu/drm/te=
sts/drm_format_test.c
> index 056cb8599d6d..28f2b8f88818 100644
> --- a/drivers/gpu/drm/tests/drm_format_test.c
> +++ b/drivers/gpu/drm/tests/drm_format_test.c
> @@ -91,7 +91,7 @@ static void igt_check_drm_format_block_height(struct ku=
nit *test)
>  	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, -1));
>  }
> =20
> -static void igt_check_drm_format_min_pitch(struct kunit *test)
> +static void igt_check_drm_format_min_pitch_for_single_plane(struct kunit=
 *test)
>  {
>  	const struct drm_format_info *info =3D NULL;
> =20
> @@ -175,6 +175,11 @@ static void igt_check_drm_format_min_pitch(struct ku=
nit *test)
>  			(uint64_t)UINT_MAX * 4);
>  	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)=
),
>  			(uint64_t)(UINT_MAX - 1) * 4);
> +}
> +
> +static void igt_check_drm_format_min_pitch_for_multiple_planes(struct ku=
nit *test)
> +{
> +	const struct drm_format_info *info =3D NULL;
> =20
>  	/* Test 2 planes format */
>  	info =3D drm_format_info(DRM_FORMAT_NV12);
> @@ -249,6 +254,11 @@ static void igt_check_drm_format_min_pitch(struct ku=
nit *test)
>  			(uint64_t)(UINT_MAX - 1) / 2);
>  	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, (UINT_MAX - 1)=
 / 2),
>  			(uint64_t)(UINT_MAX - 1) / 2);
> +}
> +
> +static void igt_check_drm_format_min_pitch_for_tiled_format(struct kunit=
 *test)
> +{
> +	const struct drm_format_info *info =3D NULL;
> =20
>  	/* Test tiled format */
>  	info =3D drm_format_info(DRM_FORMAT_X0L2);
> @@ -273,7 +283,9 @@ static void igt_check_drm_format_min_pitch(struct kun=
it *test)
>  static struct kunit_case drm_format_tests[] =3D {
>  	KUNIT_CASE(igt_check_drm_format_block_width),
>  	KUNIT_CASE(igt_check_drm_format_block_height),
> -	KUNIT_CASE(igt_check_drm_format_min_pitch),
> +	KUNIT_CASE(igt_check_drm_format_min_pitch_for_single_plane),
> +	KUNIT_CASE(igt_check_drm_format_min_pitch_for_multiple_planes),
> +	KUNIT_CASE(igt_check_drm_format_min_pitch_for_tiled_format),
>  	{ }
>  };
> =20
> --=20
> 2.36.1
>=20

--cycfpb3jug72cn35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmLitTIACgkQwqF3j0dL
ehwt4A/+IqGJpHDAaqlrXh3uSs6Sz5+Ca8yyh0YOHdzqDY64qUdT1DYXohXpy7MV
fmgbtKGJL5erww3V5Jqg01+zpV1Q9MaC02Nb1txXqBreI1k8c1ALkB/m1Mlj6nLl
UavoEhVhxA5utbETxtATCoEq3C/LxC65hZ6LPdwj2kQQaPOOHEccpuPC3CYTu9do
qRblunLb6+VKPxdSmUFVwK2Ocshg1Efoa3ZJ9AipJjVmOQUSzXI644hr9l6biPOF
a/5aS8R08FL7QhQQU9lzNU2zUeJuPSXdXDcUnZ3vkcOFR5bXejdedlMcK/SPbJbA
4W5u6fNjE5PBer3AZDyc33xWUNUbc7kevBJj2oiqAGikQ6gLwJxTnQo8vRHwHoW0
psyGiheXTlpMo4CPBmsHvGDSDSo8eQ6GNiyoXdMNC6LMal++ly/DgH7nMlhA83SS
G2QwCvmHVgpR3BJ/R7voFcFoMn9DpTnwjvcAZqoXribwbOA9CIEhV0zVejlBbGoR
HoassarpIU+B+I/c6i19qXt+crD4MW2x3W+X7hbrFTuOvE30QGtpFqP3CLBPUj3E
ySNjplYAP3ZrK6ZGERzPThNavFDQB4ZzSUUclTRo0KxFqY2kNZfbc3ZVeg71UriN
mPtuXUUC9tb7xsRRVaKCoJcRyur/nSG0RKce7dSUbdI5OdPVsHg=
=OvDL
-----END PGP SIGNATURE-----

--cycfpb3jug72cn35--
