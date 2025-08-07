Return-Path: <linux-kselftest+bounces-38493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43742B1DD74
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 21:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E261962807A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B0B21D5BB;
	Thu,  7 Aug 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeNm/SBM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D11C860A;
	Thu,  7 Aug 2025 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754594587; cv=none; b=X/z3bR7xSlzCiVzq2t6JahpuHYczG7yvLBs7v4Tv5D4KHRtekEsYNPgXZMIjohicYRKxZMW8fgKXoChgADn2cPbrp7pKnPsIxNTmq2TZQJXVWGrMAi7of5wy41kfCXsX17r2nx9WUG5cOrSdYT7lzRPk0zd8xkjzkBEL0CXGRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754594587; c=relaxed/simple;
	bh=bO0vADNCneshUIVHVe/hVO5ZsIGpYnBPeUVMpWJqGAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCFADVIFqa7FxMNlUWOQGtI2y80wAJCZ0LUsO40QvM+5MYWQkuKt9Baslbq4x/VYAnwyjFHKAMhMJNbp3CIYIIwZbxNIqvOu4kzV50TAPYPj/PN30tsLZzxtxby6KG9JyXoIgFUfO0Gr+p7i9yBkS1ChcAwCLAf2kaXPE15VYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeNm/SBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF7CC4CEEB;
	Thu,  7 Aug 2025 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754594586;
	bh=bO0vADNCneshUIVHVe/hVO5ZsIGpYnBPeUVMpWJqGAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GeNm/SBMZx67YSIsEMyUKUL7FL7ui9baKhJ5p6Pm9dJFfoOvs+EbdM7/34+mZPMxJ
	 sSEnTwpUbnrKNbQsCzQxPrY/6dqg296Bn/QbB+NsgOp0b14lbHpil6CzWTcAWBGLnk
	 LUEu+oQpGX8cQBGSTQKP6bDEHvk3juv854a+pcioXZEV3U/5h1+SIH5R2O+0DRVoky
	 lWuEF/31rVyOBY7yJGPBF5M5WU3HI0TgpqxfLkLpEVuUfZNQagTVb5HW/Rfx23Zmli
	 SG93Y+FZvwDqOPENpT7c3BxufBcmJx6qvm8WnqQdAG6dC7RZDuMjHX0aCCbhYQoOcS
	 bWMSIB921g9oQ==
Date: Thu, 7 Aug 2025 20:23:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: arm64: Check fread return value in exec_target
Message-ID: <a72e8741-a63a-487e-838e-daeed3458c0f@sirena.org.uk>
References: <20250807154950.24105-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lDXe6O6YHA3QjJr+"
Content-Disposition: inline
In-Reply-To: <20250807154950.24105-1-reddybalavignesh9979@gmail.com>
X-Cookie: Real Users hate Real Programmers.


--lDXe6O6YHA3QjJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 09:19:47PM +0530, Bala-Vignesh-Reddy wrote:

> Fix -Wunused-result warning generated when compiled with gcc 13.3.0,
> by checking fread's return value and handling errors, preventing
> potential failures when reading from stdin.
>=20
> Fixes compiler warning:
> warning: ignoring return value of 'fread' declared with attribute
> 'warn_unused_result' [-Wunused-result]

> --- a/tools/testing/selftests/arm64/pauth/exec_target.c
> +++ b/tools/testing/selftests/arm64/pauth/exec_target.c
> @@ -13,7 +13,12 @@ int main(void)

> -	fread(&val, sizeof(size_t), 1, stdin);
> +	size_t size =3D fread(&val, sizeof(size_t), 1, stdin);
> +
> +	if (size !=3D 1) {
> +		fprintf(stderr, "Could not read input from stdin\n");
> +		return -1;
> +	}

It doesn't really matter but it'd be nicer to return a standard value
=66rom main(), EXIT_FAILURE is probably a good choice.  Exit values are in
the range 0..255.

--lDXe6O6YHA3QjJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiU/RUACgkQJNaLcl1U
h9AyyQf+Mg0LhcTpLXab7BZn+ejV6G4bsn2lcC2nLCXOkHWLPMlKyO26ip+/7+Gd
BfeJ1PFXe4q6YNENah0xOEL1n3kCUXNYUJXmiat+FSAEgqIMYA3KZr/NNiZovIll
zAbTQj0795xW27sGvS3rXXv5eoCr0IiqCgUsT+VSw1FQLEWYf3KF0ZQCGLzF73+E
qHBrCqsUURH7dYANOMOmIood/LECtoeHxkiv0f5WLXegHany/MV0XWOL85Qfw6lL
t0I5zJfiNL47WXJcc8MksVS1o9JFxtx9r2B+son/rzJiVthlyW3B93DnaiEld48I
VkRyo+Wc4JMtxadU6wOjINGD8if2sQ==
=s09D
-----END PGP SIGNATURE-----

--lDXe6O6YHA3QjJr+--

