Return-Path: <linux-kselftest+bounces-44668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7793AC2D376
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 17:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B292434AEA1
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6530DEDE;
	Mon,  3 Nov 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7nsttJ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822327FB0E;
	Mon,  3 Nov 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188390; cv=none; b=smZtsFi1ufAgonXzJtVtpygl5sg6VwLma2sBWEh7hmwggda4py6nTH4u1gkjuPJ1XKu7txmbRKnviq84XRp7IeDAurhtod1cPvEEqP/6ZhkOW0AWPsuxS4t3FCC/l4jpdp6X/Xsg0lZlGHQbDghmG1dIkjh2gwsLJdLaZ5rlf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188390; c=relaxed/simple;
	bh=bQoQlcYHevM+fEbYlxaZHeDzoToJ/H9DsSpcxx2O4mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCqzGsXseJVF3G2yv85qVtjE7HC0axcY7YIbBknh/ooTYzyGVC9m2ByuuiYF2kAAckxBYFZzSAvYuaD9IlwNh9gnNzRr/w8kbXTEWSF3I8K2h8cru8vQFMjaj58AROujfU2mkzATR7LgPiWTrdkQvWpM0daNAWWuSqmIBcjDc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7nsttJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F82C4CEFD;
	Mon,  3 Nov 2025 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188390;
	bh=bQoQlcYHevM+fEbYlxaZHeDzoToJ/H9DsSpcxx2O4mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7nsttJ5wpufBxgZ9zN/oBF3lPwKV2Js7ZlalsYPDvqnBqXao784dbn3VhiGOKMdL
	 RI7i/xgC1l/Bz4BRmjwKmq7uz/QznxWKVaJ3ABHOMRRERMywkusS7kdYoE1JP6ZnBY
	 JIQdngWur6Rp09hAlyfRUyRoElss3L1XblKaO68JWV0AFmDItmGtzdGwOXw1dpgLJR
	 NbtUi3GZq96yicFFSNVOTsgDU+tX6LTbL5ObLy7Hm9/Ug7JbuX4vendjj0qS75ScHa
	 9K82muTkdTaFXcrCY6cfUKdTmsJ4fsPxxBdb79XA+ryLLgKVm+qOsjt/lIayM9wfnj
	 6tVxLclq9s5SA==
Date: Mon, 3 Nov 2025 16:46:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 3/9] KVM: arm64: kselftest: set_id_regs: add test for
 FEAT_LSUI
Message-ID: <aQjcYwHstanefv5L@finisterre.sirena.org.uk>
References: <20251103163224.818353-1-yeoreum.yun@arm.com>
 <20251103163224.818353-4-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n1neAWNWhZ8UixfX"
Content-Disposition: inline
In-Reply-To: <20251103163224.818353-4-yeoreum.yun@arm.com>
X-Cookie: If in doubt, mumble.


--n1neAWNWhZ8UixfX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2025 at 04:32:18PM +0000, Yeoreum Yun wrote:
> Add test coverage for FEAT_LSUI.

Ah, sorry - I see the set_id_regs change I asked for in my previous
reply is here actually!  Usually the selftests patches go at the end of
the series after all the functional changes so it didn't look like there
were any for the series.

>  static const struct reg_ftr_bits ftr_id_aa64isar3_el1[] = {
>  	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, FPRCVT, 0),
> +	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, LSUI, 0),
>  	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, LSFE, 0),
>  	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, FAMINMAX, 0),
>  	REG_FTR_END,

Reviewed-by: Mark Brown <broonie@kernel.org>

--n1neAWNWhZ8UixfX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkI3GIACgkQJNaLcl1U
h9BSBQf+LLF5rxdT9uo9B8kyXYNRb+JQM8zxCcNQeqrEg0FpYzyyCldSnKZHqq3a
C2L100Zn5WXFzUsmwztAxkDPDhfpXdPp+B6A7IZJXpLHX33tXSC1cMoHmgGustOd
vw4RjrvTdLKKxIj2lsOyxJAXHKK4h+9JIc0uN0msMm5Jy+2dlVv8EaF1jc0nUxjY
rHh8DdgOCh0GwEBG/AnEOWeH2TUsgjxMlVT9MZ7KYoIhIErPUjTxZELb86quh9g2
CwR0PD4SN0NMfRPcI0JQV1CX3wU59f3actJXifMs4yFlqvzlKm8B3DkDzHz6S54w
XXSOpO06mXKEcprPaUq3qYEX/6NQkA==
=pmiJ
-----END PGP SIGNATURE-----

--n1neAWNWhZ8UixfX--

