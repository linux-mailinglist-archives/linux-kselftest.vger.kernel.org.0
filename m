Return-Path: <linux-kselftest+bounces-34490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BE6AD2384
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DEC16C126
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF692192F1;
	Mon,  9 Jun 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHR/8xs4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EEE70830;
	Mon,  9 Jun 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485786; cv=none; b=NhuD4MvKt8fILWwHEBVU/yInCj5e2kFnI+QnIAvHG8Ftuim66wd7chXeHLr+2a3GnfIClReJZN6xhn31rp2JCymO216HRHNJqYppiGvzoFuwCXDKSVPuAhX4gztfo1y4KR2J8BdLYpR+PkyILW0VcOD841ldgTtnSZBLLtiv6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485786; c=relaxed/simple;
	bh=0Vp/ybtUmvqDAk8ouELGJxXOC+x1dnWsKmvYB1FmtWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB98Hw/fTzLmOSkNaEHl9izR9rS/TmsyIMIpUos8taaL5wO10/lsuPZFB9cpMLLcZkBZw4PXYwqbb8pI4YoTC3di1GLMOpsdeCSVNlz/RIFMKyisQ20EenIR7srlgSCgVCF9n3lJ4JcStlHZnapaFKbPVGa98VmwLm+Co1BExOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHR/8xs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B4AC4CEEB;
	Mon,  9 Jun 2025 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749485785;
	bh=0Vp/ybtUmvqDAk8ouELGJxXOC+x1dnWsKmvYB1FmtWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHR/8xs4ofdkREOpNBkqIiHP7U0gNcmE0VYwkCCEH6RFVcQqzRljmAKvvygVd4mUz
	 /E8UGkLrwLeq1WhGKwNY8E0H1hipb0HTyLl0xgN+AwqVdUHsa6hrXX+J625gnAA/3b
	 MAxm4YAjVn0y7k/Wnf7iHy+EdL/faXkCukFzigO0L5vehcuSt5+uDm4hqvjbNY3Uqk
	 J/saMj0TYuXLzfVoYxmA0P7tniEt6u0hnxs/QRjQAFd2254HdJw6PN4XbYKcYmtQnc
	 Xyt4uIBc8jWeAK9XLl/Qie+hjsTtGtOcDmFeGg6uKYEdcM6c2p3dNFk+rMgbXbBgjS
	 6qISON0mj18HA==
Date: Mon, 9 Jun 2025 17:16:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Christian Brauner <brauner@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: Provide vfork()
Message-ID: <96c9c762-a99a-48e7-ae80-f85e5d7fffa4@sirena.org.uk>
References: <20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org>
 <20250609-arm64-gcs-vfork-exit-v1-1-baad0f085747@kernel.org>
 <df6f5620-5986-4080-bb00-c7bee856bf66@t-8ch.de>
 <4a4ef323-25e9-4bb5-bde4-9ad740693246@sirena.org.uk>
 <d4fb291c-e329-4fb6-839f-01cb17afc933@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1r6BJNpIVNQ3zS+q"
Content-Disposition: inline
In-Reply-To: <d4fb291c-e329-4fb6-839f-01cb17afc933@t-8ch.de>
X-Cookie: Restaurant package, not for resale.


--1r6BJNpIVNQ3zS+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 05:51:19PM +0200, Thomas Wei=DFschuh wrote:
> On 2025-06-09 16:43:55+0100, Mark Brown wrote:
> > On Mon, Jun 09, 2025 at 05:34:33PM +0200, Thomas Wei=DFschuh wrote:

> > > For consistency:
> > > #if defined(__NR_vfork)

> > Are you sure?  I'm seeing an awful lot of #ifdef __NR_foo instances in
> > sys.h - it looks like the idiom is to use that unless it either needs an
> > additional condition (with || or &&) or is an elif.

> In sys.h, indeed. These have mostly grown historically, newer ones use
> #if defined() together with #elif defined().

There aren't actually any of the newer ones in sys.h!  I guess I'll add
a patch doing the style change...

--1r6BJNpIVNQ3zS+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhHCNQACgkQJNaLcl1U
h9DvuAf+JkWvU5J1GSwFzryfv78HIWWIkYo8PGPmF7KtNZ4wcP9u1P460442kLSp
AMb44ctrxhniN549Qv0+z2p89HZQ24S6Ynzoy727lJfsDhioz3UXAnw2y4fDhkEy
B6+USQ3g8wjuAwE3qcMCZ3wP7P268nhL+q2UZ0IM8ndCyACeS5bt2R4t1oMFUm38
nkLv8tZni/UOvDToE9I/OISzqcDC9APHQg9TISAbgWzY1kpvAhV304rQFM3AKSZ/
wSos8whvDJZxqQWtMbESM/EoPCfW/0dQK86CbP2VLbw1dn0mGqr3+E24cZdVJIDS
1izY49es8UnR6OlpPVxxiEzc0BUcFA==
=r/RE
-----END PGP SIGNATURE-----

--1r6BJNpIVNQ3zS+q--

