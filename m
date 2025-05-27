Return-Path: <linux-kselftest+bounces-33848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0C8AC4DDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 13:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6E917969B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E22225EF89;
	Tue, 27 May 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWmBvgqp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745B25DCE0;
	Tue, 27 May 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748346602; cv=none; b=czgdDptlwc0GOMzzFNueENhLgfibNMp2GLiI7gX/CQeP5gj4dUoaadoUu9KvpY8LzN/HK6SaBprfBinE0wiqm+3PLBYS8DrI838niS6Vgr4fApXHE7sAI3Im8seLrXb2j1vflVYpgYFvGL5BPgkf6T1onxy7AvZ/3EgJ88U57/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748346602; c=relaxed/simple;
	bh=M+WartH7+lxMBGnU5uEQH938CX2L/uK297c839dwtaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raX2yif6pBVz9NiKfCXPDv0SL/51m9V7CvTZft0Y/ae5J/Gsvuu/2vm8IiT4ukG1SW73xlgIFdFOLnx9ZKvgtaiRYBIEAQ6Up10awxEAxoqaItaaJCSiZtUAIoLAA63bw1r+82WyMedaMU2qtg9N+l3162t5Yn7LbeedNXc9eh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWmBvgqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BD2C4CEE9;
	Tue, 27 May 2025 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748346601;
	bh=M+WartH7+lxMBGnU5uEQH938CX2L/uK297c839dwtaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWmBvgqpD741w5lbJwmdDob+G907KJNDwMysIapfRuNAwDVA6tc1BBs4Y7S8NRwt0
	 CMTz+n9j70pB3DFVZABIAphn6T79L2+v+OoD76JNijWi4Pv/FpMWzj8gfvjcCSwfAx
	 E8zNR//SqmHfquaEJkT8BHiNAzjDZ4ZhaQYrKb4SPOhO/+pxRo7M1ooq9+r84/q49d
	 QFknR0I4El8ZPEoyk95Xc6TW8vE3Rsbebo+w5DdzLh/pdkhgz6tmEq0bn+RDzyuMhc
	 fM19wHKELv+XDXpOnNKSg4UUA3s5TEFQLzcM2G5uIc2f6oUxrS2qW3uI0QhYJlY5F4
	 vMV+EFJjyug5w==
Date: Tue, 27 May 2025 12:49:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests/mm: Report unique test names for each cow
 test
Message-ID: <3729c741-fd02-41f9-9668-7575871e7acb@sirena.org.uk>
References: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
 <20250522-selftests-mm-cow-dedupe-v1-3-713cee2fdd6d@kernel.org>
 <3745cced-199a-4c9f-a282-d9587f2edd41@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OW/UBWju3qLilyOF"
Content-Disposition: inline
In-Reply-To: <3745cced-199a-4c9f-a282-d9587f2edd41@lucifer.local>
X-Cookie: New customers only.


--OW/UBWju3qLilyOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 11:08:05AM +0100, Lorenzo Stoakes wrote:
> On Thu, May 22, 2025 at 06:38:52PM +0100, Mark Brown wrote:

> >  	ret =3D setup_comm_pipes(&comm_pipes);
> >  	if (ret) {
> > -		ksft_test_result_fail("pipe() failed\n");
> > +		log_test_result(KAFT_FAIL);
>=20
> Looks like a typo here :) Should be KSFT not KAFT.
>=20
> This is breaking the mm self test build for mm-new, could you fix-patch/r=
espin?
> Thanks!

Ugh, this was masked because it's part of a series and among the
problems with the kselftest build system is the fact that it eats
errors.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--OW/UBWju3qLilyOF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg1puQACgkQJNaLcl1U
h9AqPwgAhfEK//IeybNjibTXbdt3qFtPzEf8yQJEj7kXBXQreZ53y6TcMhnCdfqH
VsY8eXIv0QOEKssUYsxi29Dn4Tbn/mVbUOf2mFc45HTonnYf+ts7Gnsn427qAVsC
qb/DX70AKJs15xjX91x2Vp60y1sc6ul7hUh1mIoZnOg7lIWowm9bfiKmcDoTDpSE
KdiHZ5jIsfxDViZGYS1qbUfrJM6e0hhZU7oejRlO21TXtkmp+QTXcoH9YhSYweNb
J2eMEHSoE4eaKb3eStreywZ8Fvx7gM4W2AZFkelGMoy9UmYyKHKnViqToSBPe20e
+HNgBCmtDJlZz4jOgL+6DgimUYmIaQ==
=MENN
-----END PGP SIGNATURE-----

--OW/UBWju3qLilyOF--

