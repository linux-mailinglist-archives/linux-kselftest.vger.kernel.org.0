Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896A0118647
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2019 12:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLJL2M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Dec 2019 06:28:12 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:57272 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJL2M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Dec 2019 06:28:12 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 47XHqY5VslzQl9M;
        Tue, 10 Dec 2019 12:28:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id ORbApr3hLJrD; Tue, 10 Dec 2019 12:28:05 +0100 (CET)
Date:   Tue, 10 Dec 2019 22:27:50 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] selftests: fix spelling mistake "chainged" ->
 "chained"
Message-ID: <20191210112750.5rfck3gnmobabhak@yavin.dot.cyphar.com>
References: <20191210112455.171482-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l7rai3c6jadzkxag"
Content-Disposition: inline
In-Reply-To: <20191210112455.171482-1-colin.king@canonical.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--l7rai3c6jadzkxag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-10, Colin King <colin.king@canonical.com> wrote:
> There is a spelling mistake in a literal string, fix it.

Yup, makes sense.

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
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

--l7rai3c6jadzkxag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXe+BLwAKCRCdlLljIbnQ
EubTAP9OptH6VWy5DMeb7HaGfXTnyuPkThnwOMh7lvkzgNvH4AEAtBUbCf5wSGnb
yzCFDvF52CMUSP7Tzg5KEduILkkf+A4=
=9MTh
-----END PGP SIGNATURE-----

--l7rai3c6jadzkxag--
