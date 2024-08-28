Return-Path: <linux-kselftest+bounces-16522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8113596251B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 12:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40793287249
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5938C16BE1F;
	Wed, 28 Aug 2024 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FllT6QMJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0616B72B;
	Wed, 28 Aug 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841612; cv=none; b=fjgMXxmr03kQSIiwmWJNeYYf5Kh2xYs6tzLL2HRQ+18JtMJWE7wZn0COGUDcB/BRO/Y05fiR/4BcdxEBuDglngal4NcsjDZhvOnPfHLjJ8Q2noAMfwP5A/RZQ2ujD093I4dRlFJ9pUgXWGUe3Br3aGH2i6A06+xgg5BvFZNxpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841612; c=relaxed/simple;
	bh=H5IjUwWse/haHmSCGq79BGxavYcQ/Drfu0Yk8XfnecE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXCB6eKzjaAL7TP++vghDWStXzTObV8eqAoyygP8CgxTZIlvyjKeXKEBRsa0zD6IqbEMISIZRuUjxhs13Y0ehABtJeHRbwBQzyYZczZIOY1WD12Ker4+cTvZa35uF57tXNJ13KWZ3fRdaGIn6HHFxCELBdDPYwHKbcHnXA1TN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FllT6QMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8D6C4E68D;
	Wed, 28 Aug 2024 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724841611;
	bh=H5IjUwWse/haHmSCGq79BGxavYcQ/Drfu0Yk8XfnecE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FllT6QMJ9YnL8td6xjXct3RqQvRWJDf96rJpW7OfdWiEH63natvIGOlaEG+xXt9+a
	 X7Lfa6B6R70rCjm4MmOgHFfYEu/tfvaOBtmDrlWLT4CuYd58RQzQPFLCrLJGyOVqrA
	 7ZRA8s5zvMjNytt50ZauQi4b9r3VAkGpMnVrHd5oeNLDZ8ICGCFT/JFnvMotfwMm7U
	 dp4+lNR0lHw2w5+6lksc84LjsKasEbatAU5use3AiH4gZRArwP9V5cfZs89IUUShip
	 T4OBPUfbzJIJyymlB3/AUecGUJ1AekJ039WdFR1KBXZqm3samh/casStWARGA6RSzT
	 9Vba5Myy7K1Fw==
Date: Wed, 28 Aug 2024 11:40:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	will@kernel.org, ryan.roberts@arm.com, Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/arm64: Fix build warnings for abi
Message-ID: <6e5588d9-c22c-4a94-afce-1274c888403e@sirena.org.uk>
References: <20240827051851.3738533-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XJSQIi2bG6dqQ0AB"
Content-Disposition: inline
In-Reply-To: <20240827051851.3738533-1-dev.jain@arm.com>
X-Cookie: You are number 6!  Who is number one?


--XJSQIi2bG6dqQ0AB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:48:51AM +0530, Dev Jain wrote:

> -		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
> +		ksft_exit_fail_perror("PTRACE_TRACEME");
> =20
>  	if (raise(SIGSTOP))
> -		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
> +		ksft_exit_fail_perror("raise(SIGSTOP)");

The idea with these is to include the error code as well so adding the
%s would be better.

>  	for (i =3D 9; i < ARRAY_SIZE(gpr_in); i++) {
>  		if (gpr_in[i] !=3D gpr_out[i]) {
> -			ksft_print_msg("%s SVE VL %d mismatch in GPR %d: %llx !=3D %llx\n",
> +			ksft_print_msg("%s SVE VL %d mismatch in GPR %d: %lx !=3D %lx\n",
>  				       cfg->name, sve_vl, i,
>  				       gpr_in[i], gpr_out[i]);
>  			errors++;

This is a different pattern of warning, it'd be easier to review if each
patch only followed one pattern.  There's no code overlap between the
changes.

--XJSQIi2bG6dqQ0AB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbO/oUACgkQJNaLcl1U
h9BQRAf/bRC2C1yCVRoReHGP3gTuJo7Erre/YiM/cIdFf2OZ1zBKsIgsfmgas6uI
jt1GyhSV3A3452d31aqjW1beLMldt9gtLw/r1rOb/M0mj2KMeRgCUG+95+40ukPO
DBVER2YFtruuPPClHgsTMBATIgdMBSDV6E2sfCmMILP2zBFKRzTlVVZnmMNhp8u0
hDuzWrlyLTQfUGFGsaHygyKfXOb1OACvnthkXEm62HG6L3ICHW6BuddVNbn6FJQa
D16+7w+SgZaFuDH/OmjLCJVdXKzLVxTtJNpoX9qGX97C+CBb78/GTlHiAMQABUyJ
/BYHLqsHDhiT/yovbQASoeT9VPn5Fw==
=kvpf
-----END PGP SIGNATURE-----

--XJSQIi2bG6dqQ0AB--

