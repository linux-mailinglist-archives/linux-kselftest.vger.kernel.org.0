Return-Path: <linux-kselftest+bounces-14555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7D394328A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 16:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5D6B262E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FAE1BBBD3;
	Wed, 31 Jul 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="thja6tMy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB2186E4F;
	Wed, 31 Jul 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437944; cv=none; b=EhDWB1TtEHSY/fCapQHBQEi+Aa7a+ZSXF4OO3RA/jP4my1oQs+zrj1aad/sLuTVR/oPKIidcmhBlMjL6cU3nIAn8Za+cMxRi5gEqwuw+KG+oQhMu1s0Ucj/AEl1HGYY8Yp1iTIPuP38w37H4YOhJSbnky3bX8m/DbO1itjHW+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437944; c=relaxed/simple;
	bh=G0SUxC1G8UKkcrNjMPfp4DfwcRvmGOvQQHEzv+X3sgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti28aWFLc/rAsACkMYN9IJWbkLv01dcwgsg0kB/AQ3ocAp4xVlKBIl1bTJZjKy8QkqwswxMAGFHhkYrLesPsjHdhFLIw9iPMioORBju1ccxX37a0CSSzOKPGnN1gxuxl+zuBVF5EyxngRTkKcu4aZFAPWVMo+EyKsgUeXFEqMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=thja6tMy; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WYwGM4NnZz9sjZ;
	Wed, 31 Jul 2024 16:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722437931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgSn0z1/NA0/gQBgFUj6VIEvjR2OUfBqvPIzl8DJV1s=;
	b=thja6tMykuLqTRrbRjmpYHMjjkpPsQzNZQcUqg44DfoSY0BTA76LZYOr5PrN9Uv7PZRo1z
	vHINpfE/SzF/ogJxNpbyr0lzetQo+4n7htLeYdG8l+agb3PhbzbGvSJb8aNB5/RY8BcKLJ
	xyePYI8FIvsh04u/ct4tmXu1DMANlgMvJo75mOGA8nwETs/eRyOz2A8pIk/gwTTHjmNtYG
	IjCnw+UjNwmzUkhoeiIu6Jr/71TpCBxwSnRvRqRpPP4lYfhkoSB20iUSCXiHblJrkL+Pnu
	BDq/pXwaJJ7yQILh0ExuyzDFILaVs7B1oR3teJp00hgtw5ANu3eblFCkfV6OoA==
Date: Thu, 1 Aug 2024 00:58:42 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: openat2: don't print total number of tests
 and then skip
Message-ID: <20240731.145750-musky.jailer.washed.charter-3gbj12e1twc@cyphar.com>
References: <20240731133951.404933-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qkfgmkgav4jyrb6b"
Content-Disposition: inline
In-Reply-To: <20240731133951.404933-1-usama.anjum@collabora.com>
X-Rspamd-Queue-Id: 4WYwGM4NnZz9sjZ


--qkfgmkgav4jyrb6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-31, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> Don't print that 88 sub-tests are going to be executed, but then skip.
> This is against TAP compliance. Instead check pre-requisites first
> before printing total number of tests.
>=20
> Old non-tap compliant output:
>   TAP version 13
>   1..88
>   ok 2 # SKIP all tests require euid =3D=3D 0
>   # Planned tests !=3D run tests (88 !=3D 1)
>   # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>=20
> New and correct output:
>   TAP version 13
>   1..0 # SKIP all tests require euid =3D=3D 0
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Remove simplifying if condition lines
> - Update the patch message

Feel free to take my

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> ---
>  tools/testing/selftests/openat2/resolve_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testi=
ng/selftests/openat2/resolve_test.c
> index bbafad440893c..85a4c64ee950d 100644
> --- a/tools/testing/selftests/openat2/resolve_test.c
> +++ b/tools/testing/selftests/openat2/resolve_test.c
> @@ -508,12 +508,13 @@ void test_openat2_opath_tests(void)
>  int main(int argc, char **argv)
>  {
>  	ksft_print_header();
> -	ksft_set_plan(NUM_TESTS);
> =20
>  	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
>  	if (geteuid() !=3D 0)
>  		ksft_exit_skip("all tests require euid =3D=3D 0\n");
> =20
> +	ksft_set_plan(NUM_TESTS);
> +
>  	test_openat2_opath_tests();
> =20
>  	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
> --=20
> 2.39.2
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--qkfgmkgav4jyrb6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZqpRHgAKCRAol/rSt+lE
bxmMAP907FsjWBb5NU4KU1NShiIRSuUw+b24sOqt2XLx9lbhJQD/XDOJQnSNTmmK
UvItrEPmh3NeBsOqVpyP8kLUoDmlXAo=
=D8Np
-----END PGP SIGNATURE-----

--qkfgmkgav4jyrb6b--

