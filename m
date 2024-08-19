Return-Path: <linux-kselftest+bounces-15659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4857D956F7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76DE1F22280
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C668C13BAC6;
	Mon, 19 Aug 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AupYeBNZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2011130A47
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083178; cv=none; b=stlZkrdPhp+dvcaKH7+/HLHfuaELCL6Qek/ENmcXloOyldA5altHTBDJmoVPjlMUQdjx/29h4fgmfphYLaFga719rNmolUQ8DD7DkYy/dp6u3bb8ormNNP28wMTnv3v+Kn412YgIPUjDR2psexOqSIuwYU4/nSi9A1TczLYo/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083178; c=relaxed/simple;
	bh=NvxVMNy1i+eBt6Uz0p+6BDx+Fa+DzaDmaZ9SQt5IoTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqG4Z5oibEB/sCjnbHJxlRpcjxcFguizwThiw1MRjxVhSCa64VruIMViCCd+p40uXsZ1FVmIymRP9ZBnuOTWUxClj6WebOqEy23c0HzmPmqyTH9IN+Okc6I5F6h3DCGBKz6L/+9cyFzPvDAM9+WScKoAJ9XDcta3O8ii8E7fqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AupYeBNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC54C4AF11;
	Mon, 19 Aug 2024 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724083178;
	bh=NvxVMNy1i+eBt6Uz0p+6BDx+Fa+DzaDmaZ9SQt5IoTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AupYeBNZzKISeFu1+rknCXskOMSqHbTa/L70b2GAwLKYlz1jccd0PAAp4nmZ77FGJ
	 RlNrFjQPR+xOc/j6e1nz7CpK6JywcYWPw267V3MlLmtxwvdZwEBmLK/4faGjBxwfBf
	 xCujISYIFWCkWJSdzwqa9Ndk4WBEWsEyIKomqzRMpjb0xH9ytNMnWbn3kPADe/VCCt
	 TttBcIv9+Z57rMal6siks6GScNJqcf2Y6SNFnWMSxFHtZN86pvTXx8HLn5OZh7wycR
	 qtxYbG2QDPK9gkOLhZaX44HPbVQUyFiEc6/ElNwxx4IhL3di27Y6sLcIkvFDeTNbpW
	 t4tGlbTYDoO8w==
Date: Mon, 19 Aug 2024 16:59:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2] kselftest/arm64: signal: fix/refactor SVE vector
 length enumeration
Message-ID: <fa160130-d5c2-435c-be0e-33aea3a05965@sirena.org.uk>
References: <20240819125721.2918606-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Usba5uJBm9t4ThhO"
Content-Disposition: inline
In-Reply-To: <20240819125721.2918606-1-andre.przywara@arm.com>
X-Cookie: Interchangeable parts won't.


--Usba5uJBm9t4ThhO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2024 at 01:57:21PM +0100, Andre Przywara wrote:
> Currently a number of SVE/SME related tests have almost identical
> functions to enumerate all supported vector lengths. However over time
> the copy&pasted code has diverged, allowing some bugs to creep in:
> - fake_sigreturn_sme_change_vl reports a failure, not a SKIP if only
>   one vector length is supported (but the SVE version is fine)
> - fake_sigreturn_sme_change_vl tries to set the SVE vector length, not
>   the SME one (but the other SME tests are fine)
> - za_no_regs keeps iterating forever if only one vector length is
>   supported (but za_regs is correct)

Reviewed-by: Mark Brown <broonie@kernel.org>

--Usba5uJBm9t4ThhO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbDa+UACgkQJNaLcl1U
h9AUJQf/fON2X+g4DS4rDZdx7hvg7q/9J2W3KLYd0UIiaAjDr87xfAEJsuUSOLlG
PN/MG0W+PXnfGiXCuJxeqHSp0F05+sCVuQiSFqgU9em0W992HkkAl+XgdpAaSxbJ
hyNvgafIWD9eT5yy12do2jWNs4gWUFyD2LT/KYMsBBdoiMi8BgwRK7L9SSLQZF5Q
q8O7oRM2rjgmlEnj5TGiCwLKvGoLedyMx4lkxiv/xZOf+fo2auCcu36Ocd+JvTwU
LzStz2gnIFXpXMRqqsZGjlvhdu18lZ351rSia9Upho8YFagnfIHt6YT1RF1bbfRN
yyIj70zFxQN3uPYaf1pK31A9YosFOw==
=DQGm
-----END PGP SIGNATURE-----

--Usba5uJBm9t4ThhO--

