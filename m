Return-Path: <linux-kselftest+bounces-12996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802DD91DB42
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 11:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F201C21A32
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3AE84D04;
	Mon,  1 Jul 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="pYwFDWas"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BE84FDF;
	Mon,  1 Jul 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825312; cv=none; b=hURZtuBxNzreWHaLXYh508xi1H/Gq8Bex2c6CLisTO1TT2mhveKO4nF2f/NJjlFqHI98N4USVBwLSeFJ+AOL+p+mPCrFQcdGSMQpAXuB8dl6rKqpqErAvRPrsewm4FxqmfnTkILOgWodC+gB5QD1IYhyGM7DlfztpK1SWGFgEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825312; c=relaxed/simple;
	bh=EXNMgrTiEPpQEAXGI28JpwhOg3RrTVpofGQB0ZCOThM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sssmpbkAQS4Hu/GRVRn1eGGXNafcxzSJnp1+yq8iTzTdLtPxlQ6agUNjB8QMP/9Cj8oYp0Zmj8ru0bAFok1Uci42167VCrVV3iSjCRmD8y8eKkAlYiDJ+qE1IeQ0Jl7B1ohBglr8Hr1fewN/eU/jOzrzPrSoIvPZ9mCrwcTbU2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=pYwFDWas; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WCL3Y69kfz9scS;
	Mon,  1 Jul 2024 11:15:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1719825305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+QZIagZ7OIN+OXgwfZRx/CoBfAQFQoz16267s73MDs=;
	b=pYwFDWasuVUv2oq5EADkqN8xdmyWO1Ksa+jbTDgxQBgyW36GGZfo3SVqgJn8NlrtOjT+3B
	MmF3NGRLL5CFQELInQnWKIeI/NiKK9DOx3RqVDHqNjIC7WsGgqR1m58eALH8RT5mNTSL+0
	GHTajev72Wy2CnjyTKVEeMblP6r4fFyipplHzHLHvd6YLmv5fIkY3mFjivTHe55Sd8gnHB
	SoA015X2UfHjNRzt34d0RVh3uM30ks6VDJkRgjzyWfOGRcReoqjA/J+GYRbs0z1t/A+w5I
	38d3me6jtRY9FaarJWI4bsN83RxqCH8lc4Ly2EOIYOyA5L2VMIE/mICllU1/EA==
Date: Mon, 1 Jul 2024 02:14:54 -0700
From: Aleksa Sarai <cyphar@cyphar.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, kernel@collabora.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: openat2: don't print total number of tests
 and then skip
Message-ID: <20240701.085146-junky.rubs.mossy.crews-uyuNIdHgWxb@cyphar.com>
References: <20240522214647.3568788-1-usama.anjum@collabora.com>
 <1fc06a15-f06e-4db1-ace5-b9d52250d0df@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="seca4cj23snjpkde"
Content-Disposition: inline
In-Reply-To: <1fc06a15-f06e-4db1-ace5-b9d52250d0df@collabora.com>


--seca4cj23snjpkde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-01, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> Adding more people for review
>=20
> On 5/23/24 2:46 AM, Muhammad Usama Anjum wrote:
> > Don't print that 88 sub-tests are going to be executed. But then skip.
> > The error is printed that executed test was only 1 while 88 should have
> > run:
> >=20
> > Old output:
> >   TAP version 13
> >   1..88
> >   ok 2 # SKIP all tests require euid =3D=3D 0
> >   # Planned tests !=3D run tests (88 !=3D 1)
> >   # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> >=20
> > New and correct output:
> >   TAP version 13
> >   1..0 # SKIP all tests require euid =3D=3D 0
> >=20
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> >  tools/testing/selftests/openat2/resolve_test.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/tes=
ting/selftests/openat2/resolve_test.c
> > index bbafad440893c..5472ec478d227 100644
> > --- a/tools/testing/selftests/openat2/resolve_test.c
> > +++ b/tools/testing/selftests/openat2/resolve_test.c
> > @@ -508,12 +508,13 @@ void test_openat2_opath_tests(void)
> >  int main(int argc, char **argv)
> >  {
> >  	ksft_print_header();
> > -	ksft_set_plan(NUM_TESTS);
> > =20
> >  	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
> > -	if (geteuid() !=3D 0)
> > +	if (geteuid())

This change isn't necessary, !=3D 0 makes what we're checking clearer.

> >  		ksft_exit_skip("all tests require euid =3D=3D 0\n");
> > =20
> > +	ksft_set_plan(NUM_TESTS);
> > +
> >  	test_openat2_opath_tests();
> > =20
> >  	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
>=20
> --=20
> BR,
> Muhammad Usama Anjum

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--seca4cj23snjpkde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZoJzjgAKCRAol/rSt+lE
bxhiAQCCSg+NVT9wtQ5TWZos7rAeoiAPbTt6VZEfxt5Ib3xwOwEAh6BegHRFZA0d
OVTVzTsB+2YtqxW8oIxQQVxJoD8dhQo=
=iOwh
-----END PGP SIGNATURE-----

--seca4cj23snjpkde--

