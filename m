Return-Path: <linux-kselftest+bounces-21680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C799C1FB6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6261C21A77
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AD21F4FA2;
	Fri,  8 Nov 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlFekRhq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF31803A
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077614; cv=none; b=TfD2/5yEVA6XtrjxEfjQ4SXhKH88etZ6VuoLujv/MMvMeLrLVOZyzha4EiCwwSZPdoLFo69PlnZf8la/yTMPxSSJwzmiYCOCsmaOew84PicWu4TjVnpT3W62cjCLkV7QRHaZXibkQRvFLl1TIUTuCSLbepCM9lSAKFZeivQSxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077614; c=relaxed/simple;
	bh=7FYaU4FCXmhYjzpZo5YkfLyjPElVMZd2EEcZuyqFuTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqtKCS95SWW5CUjZCYjdxhYdEXjYg2d6nLlKUaFKecYaWW9/JzdqLVoFqBZuWkg7VS90jjGmk4526u/FQkUlTyk3QaL8O7JBVwUDaqxfeu7BWxCFimU2R7BNAcgqswq8bp6PiMgh2/5ejexoNTfIBRJYSq81fVERcX3wLFBdy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlFekRhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67071C4CECF;
	Fri,  8 Nov 2024 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731077613;
	bh=7FYaU4FCXmhYjzpZo5YkfLyjPElVMZd2EEcZuyqFuTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlFekRhq6I6wB60c160O1nElWFaN14ychQ07e8bNDVaWQ8VQT+VUzzjKyZiqle3VX
	 wRgsXtsfIWyHimefzVvDvHTrqT7EjHyZc8yfPbG4CRo8rdqyGKQv4/dE+N10AQzVXJ
	 hdc+NP9EAqARi8/fL9Ix0OVLQbMbIzjP8L/hrour3EOVwUmlQD5M0vAZna68G7QJm8
	 Uuyrus8i+WxX21ninQNZpaDTEAi85LwI0N1q1z8Gqq8vrkWg4VECCKyqz0QbJ0CMH8
	 xP2MPAuoj6y2q+t0GmXWu2DPNgVlVCnOJsPEm33sUdOBR9+tXftVYb5PsjLePU4GqQ
	 /eN1JojyVg4TA==
Date: Fri, 8 Nov 2024 14:53:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] kselftest/arm64: Fix compilation of SME instructions
 in the arm64 fp tests
Message-ID: <15526a78-b9ad-46d2-b451-013dd3b8356b@sirena.org.uk>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
 <20241108134920.1233992-5-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FPsmg5krTeqmJNjw"
Content-Disposition: inline
In-Reply-To: <20241108134920.1233992-5-catalin.marinas@arm.com>
X-Cookie: Do not overtax your powers.


--FPsmg5krTeqmJNjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 01:49:20PM +0000, Catalin Marinas wrote:

> SMSTOP/SMSTART require the SME arch extension for the assembler. Add
> '.arch_extension sme' to za-test.S and zt-test.S.

I've got an alternative, more idiomatic fix for this running through my
testing - SME is still relatively recent so we can't rely on people's
toolchains having it and we should use a .inst instead.  The issue was
that the toolchain I'm using locally appears to default to a full fat
version of the architecture and happily assembled the SMSTART even
though we don't have a .inst macro for it like we do with SMSTOP (which
is why that didn't error).  We only have SMSTART SM and SMSTART ZA.

--FPsmg5krTeqmJNjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuJegACgkQJNaLcl1U
h9C4twf/dV0Mfyo15G5UeUI5nLI4lpOQljXMqJb2khJTZHeg0BYqBhOzBdaYXyWn
/pd2xNbUrI6X86KqkT4ZTkGL9nsftGxpIbA0I0Maf0OskafPQSnJIeIQ6GS7n5Y5
IE3yPP4dmuHOThUOWxAHLL/ZxTfbMHDwEjLLjGwJzk2PIVP7gZA5MPmvt3yk5zNQ
QYPxxYjv6ee0zGSULgpChRuvHiqTjtm1aXf3bLtkNGE71Zb0KNecxwLRvBwkwmyK
rj9QEEM+fZHKJ7wHTI2C/4rLDadSIuvImnyBOfaeFIVUm6LzZZcrsEYn5IOkUp/D
HhEyl4G1SiazCXYm2I3j8LqT1zmieg==
=p8wV
-----END PGP SIGNATURE-----

--FPsmg5krTeqmJNjw--

