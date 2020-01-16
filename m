Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A113DE4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 16:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgAPPJy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 10:09:54 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:64330 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPJy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 10:09:54 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 47z70J0Yx2zQlFb;
        Thu, 16 Jan 2020 16:09:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id zHYqyGJhpaAN; Thu, 16 Jan 2020 16:09:48 +0100 (CET)
Date:   Fri, 17 Jan 2020 02:09:28 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: fix spelling mistaked "chaigned" -> "chained"
Message-ID: <20200116150928.jimqz3gjppoirokc@yavin>
References: <20200116092903.52690-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="whi5vyhgqsw2uity"
Content-Disposition: inline
In-Reply-To: <20200116092903.52690-1-colin.king@canonical.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--whi5vyhgqsw2uity
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-16, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in a literal string, fix it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Yup, sure.

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> ---
>  tools/testing/selftests/openat2/resolve_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testi=
ng/selftests/openat2/resolve_test.c
> index 7a94b1da8e7b..bbafad440893 100644
> --- a/tools/testing/selftests/openat2/resolve_test.c
> +++ b/tools/testing/selftests/openat2/resolve_test.c
> @@ -230,7 +230,7 @@ void test_openat2_opath_tests(void)
>  		{ .name =3D "[in_root] garbage link to /root",
>  		  .path =3D "cheeky/garbageself",	.how.resolve =3D RESOLVE_IN_ROOT,
>  		  .out.path =3D "root",		.pass =3D true },
> -		{ .name =3D "[in_root] chainged garbage links to /root",
> +		{ .name =3D "[in_root] chained garbage links to /root",
>  		  .path =3D "abscheeky/garbageself", .how.resolve =3D RESOLVE_IN_ROOT,
>  		  .out.path =3D "root",		.pass =3D true },
>  		{ .name =3D "[in_root] relative path to 'root'",
> --=20
> 2.24.0
>=20


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--whi5vyhgqsw2uity
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXiB8owAKCRCdlLljIbnQ
EgelAQCi7ehRRjMXxgaesk3ZbZTuR2HRlfXzCU49y/hQWWZbpAD+J2chJFoEBKQ2
tl0+P3uEiMVf47pvNnprKM/+N7nnjwA=
=pquf
-----END PGP SIGNATURE-----

--whi5vyhgqsw2uity--
