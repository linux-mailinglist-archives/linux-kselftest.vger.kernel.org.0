Return-Path: <linux-kselftest+bounces-21694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BAA9C206D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03441C22C2D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80E2071F5;
	Fri,  8 Nov 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfAhkMXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16E2071EF
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079817; cv=none; b=hLowcmaLHVa+yD19qpmaI3tyh0f+d3K2dx0D4xOeWQOtWsdvIvNUp9uKilKSwjHjLYnWMRj3Ec3IN50NqJpWjrfXbrEtEIxWpDb+zx+z8iROe06hK1CNzVEyaWWQQ//FX66xHi60HsFek0CNEGJSaNqQAA2KnZM+15VN2gfch3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079817; c=relaxed/simple;
	bh=inazZ1XGpUpzm+m8llnixvOmgECsY/Q+xQOk3gPRIL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEhIyQQYxY5CHbU0MMMfVqgCnmbtPy7Po/JsVZuOVWh5EBf73kQV8RGoQRWDDHVHZ6HSUjIoVwKeb2R71cOmwm60ecaGOUiq9VmcPyvCv6oAx5Nn+ftlikqzwwZvqY9kISnNOwBbE4CJlxVyUSvmjLZtIMydPEbiRlcD6DXv33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfAhkMXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF10EC4CECD;
	Fri,  8 Nov 2024 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731079816;
	bh=inazZ1XGpUpzm+m8llnixvOmgECsY/Q+xQOk3gPRIL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfAhkMXJGuap/ysnOh2CcJgwSRApYDZs9s1QwFf29kgWIrntIRTavwgxc0KkNjkle
	 +mO6HN8Szm97DijjkvFJCCtcnSkBVMDTlLApiv+ptRp5BU5Rt/YjX3gGR/FpO+QC8y
	 HfQr6vzLk5cbvZZXSfGLoGHgEDykd5DzfjB4vzCZKgW4G9+8ayBD+cO7X/yIqJfdAN
	 aHywv4HgvaVYNvB/CJAsxf54bb6bEnzcKRLJ/XFfLkVijd5gAonYOYDwIlB9AYhu5P
	 KZb+3eSuvu8tlCdNfZ48iQ48L5/rm+zj1XDAqx6eJpgcQVjzJtfD6zXNhm1eDBenhS
	 LW84AB8J8f84g==
Date: Fri, 8 Nov 2024 15:30:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] kselftest/arm64: Fix printf() warning in the arm64
 MTE prctl() test
Message-ID: <6a1669e8-1654-461d-8709-3cbcaff7da67@sirena.org.uk>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
 <20241108134920.1233992-3-catalin.marinas@arm.com>
 <4bbc179b-73b6-46d7-b414-f3b14079b489@sirena.org.uk>
 <Zy4telEzvU1DGih1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+86Hz4tydrtIHA1e"
Content-Disposition: inline
In-Reply-To: <Zy4telEzvU1DGih1@arm.com>
X-Cookie: Do not overtax your powers.


--+86Hz4tydrtIHA1e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 03:25:46PM +0000, Catalin Marinas wrote:
> On Fri, Nov 08, 2024 at 03:10:59PM +0000, Mark Brown wrote:

> > > -			       (ret & PR_MTE_TCF_MASK), mask);
> > > +			       (int)(ret & PR_MTE_TCF_MASK), mask);

> > Shouldn't we just use a %lx here?  Casts tend to be suspicious...

> It's more like the ret is actually 32-bit and should stay like that when
> bits are masked out. But the bitwise op 'upgrades' it to a long (in
> hindsight, we should not have used UL for the TCF bits and mask).

Hrm, right.  Possibly put the cast on PR_MTE_TCF_MASK rather than on the
expression as a whole then?

--+86Hz4tydrtIHA1e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuLoIACgkQJNaLcl1U
h9DUygf/TRppmL0lvUaKjiWmpFhnNbIRe4orT2O9q408hf4BiVR0nJdcKx8tOuhQ
dxLLohe4E2fEXQ9aE9yd2uVvNfMypUvfDp5ygLiWHi39u6et1suiFl5Q6KNYE42f
frtC/C8LQ3FVxV78gZ2kNsRKZc3bnkdmUsDUr7hGaRc1WY5wx7QFFptPal7S8Uz7
7//6PR02DDEkKKlszS8ivuBcv1Rkdw8j/QkwSKCipT+4kDtGUz5N/vEXsw7PWUNL
N38e99YJ273KxF3RDs4ZKLLyZs+E6rCecV2qWn3l/gZokF4mLpUuL5a2htxtyATZ
CjY7E27Dxva3m6lLK2FcLxzVvLJlmg==
=6M2V
-----END PGP SIGNATURE-----

--+86Hz4tydrtIHA1e--

