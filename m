Return-Path: <linux-kselftest+bounces-34488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F386AD22BC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C713E1887FBA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9CF20E6F9;
	Mon,  9 Jun 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk7f97wK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E0207DF7;
	Mon,  9 Jun 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483840; cv=none; b=Jcd24fB8l+dLFhf6BaY6q7Z8b97Hgb0VSs62qrpbcfLC611N+UZ2dw+rAalIroqLi2Ubu3NxBEZqBdVLbyR7Keel7/juaD+7MKlsZtrsT/wFH9QwxHdT4DqFhS4MYwFlRKLkN942dFbdtczdpfRHmcdQYVa8iSWnSHq7raLbceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483840; c=relaxed/simple;
	bh=dUr9fbBYnK9U//jQ+GxgQ2ptP0b04ydOP1yvclyTkg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atvTVhsT9wnyuUNVYhH4axPF7ug/xrIZryM/yaiOPefRK1iIOKMzuRVXLd6RDWe+cf0X8UyFE8JhlzgSWD3hp2jBKWCf31s6jtMLJjscNDg6c7Djxn/Oop0kSUd76ZL8Sq2pitOCtzhUCkMCN+zGo5fD3ZXoU4UPe33wTtYXuGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk7f97wK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C83AC4CEEB;
	Mon,  9 Jun 2025 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749483840;
	bh=dUr9fbBYnK9U//jQ+GxgQ2ptP0b04ydOP1yvclyTkg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lk7f97wKxu94/wlyuKasXM1hTREHKY/GkC5ULdl3pQ1Wvrco6Pj2hMrEmZXuJfoGy
	 txUYIIRp7oWe339UGVzYmv/L8hkzWAo2Z9iKZN9pHaD6hSL7ud6E1PBgQby7DktJz3
	 /ZT8pRi+rVcuvkoE7kmJr7Yy37fnunMrTkPXKADoKXH2JhI6k/AdtGz99iBMzFqHyz
	 ss6TqnIK4eqPcnpcVciW8v4C9X1XfI/paZlmqaQzAU9SV0rJhJ0V36KHmZAxA3wHkm
	 HNGz/oAbjfoh1piQ8LTsWBXw6QNPS1yAMaPHo7D4/A9qcnMmwFsJnu8VyZp3ttT7O5
	 m9eRW1FEtcQ2A==
Date: Mon, 9 Jun 2025 16:43:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Christian Brauner <brauner@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: Provide vfork()
Message-ID: <4a4ef323-25e9-4bb5-bde4-9ad740693246@sirena.org.uk>
References: <20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org>
 <20250609-arm64-gcs-vfork-exit-v1-1-baad0f085747@kernel.org>
 <df6f5620-5986-4080-bb00-c7bee856bf66@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W3PoFoJBg17Z0HiP"
Content-Disposition: inline
In-Reply-To: <df6f5620-5986-4080-bb00-c7bee856bf66@t-8ch.de>
X-Cookie: Restaurant package, not for resale.


--W3PoFoJBg17Z0HiP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 05:34:33PM +0200, Thomas Wei=DFschuh wrote:
> On 2025-06-09 16:08:56+0100, Mark Brown wrote:

> > +#ifndef sys_vfork

> This ifndef is not necessary here.
> No architecture has a special version.

Ah, I was adding it defensively in case it was needed in future.

> > +static __attribute__((unused))
> > +pid_t sys_vfork(void)
> > +{
> > +#ifdef __NR_vfork

> For consistency:
> #if defined(__NR_vfork)

Are you sure?  I'm seeing an awful lot of #ifdef __NR_foo instances in
sys.h - it looks like the idiom is to use that unless it either needs an
additional condition (with || or &&) or is an elif.

--W3PoFoJBg17Z0HiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhHAToACgkQJNaLcl1U
h9Cb1gf/aGZPrO5RgRNjsY5LMdV3U7tfXkLGGF5tbdPIvxxy9J+B+H8Lr/OKF+QA
juIPb1wUYZ0eojfiI9JfA+jSuNBpnYxdjMBQkWxDeRHj+ilkNbA6jCDUQjCQJqxq
r+rBnVw0PxbXBqRZYuMISUZo3eiaK3sTeeD+nVe6UmUiOGFHnIqnJP0/iiMUobtw
exIZ4tQXGAttFhHv0yZhlkZ87miA3dA2amH63gC3ekoJUZXjIFx5bs/30c6oAMJD
NhicK4OfDsRIZ7d4OxKmw5cn40qXvaWwKcWg2ZvEov7suuLiyl4pwY8hP9kIYs4G
eSXUXn5w6QbJKzZYdkpmeaM07D5D7A==
=un9N
-----END PGP SIGNATURE-----

--W3PoFoJBg17Z0HiP--

