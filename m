Return-Path: <linux-kselftest+bounces-21688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FFC9C2016
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9DF28139F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6A81F4702;
	Fri,  8 Nov 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYyEOHZe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3816438DC8
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078664; cv=none; b=TlLF2FebVgq2obBaCWbzFwXGeMmolZldsQTs1eWpxMS3hCa2LtzwoUxwNqJeEHsbXynTPo+88oyxoSH/9tomKbLxOEsd7WR5caP0bzrrkAv50czpKjLPW9t2PT12NrSXRdWqp1tQ1KKI4TuX3EqmV1laSthtyMSkk3jtghe4Jds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078664; c=relaxed/simple;
	bh=kRHyiXPlUV0rDJPiJ+QPZIN6o61K+Ssat5hWggNGNbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugwrJlfr3DyHkjJZOc8pK4sE1Yfot8MpkgqKyy1CdjhZIUN/u4KmHATPxeST/VWTPNDCMok/KnLNKwWfOggzKF4bN32/Jj7K9V75vhlgvket68oYIy00TY4X9DKgJK/SI1u29q88359pCymtx/podvY2RGROytBkjXBpaILCdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYyEOHZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F735C4CECD;
	Fri,  8 Nov 2024 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731078663;
	bh=kRHyiXPlUV0rDJPiJ+QPZIN6o61K+Ssat5hWggNGNbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYyEOHZe5xcTPRc262BdXBn+HMK1sM8gSDJv5f5G5QRLHoT5E5mi6ne/5RzaBg1Vj
	 30dBuWT67zxVcCvzAJ7MBVIaMH3vjw/iqlTaMgi+3EVeQQQBzDCvWju9Uj6LSrf2SL
	 SaQJysakf1QU0P8EfyuX3hj29QoY/J5ZuHTIpxMXwVsbCL5EcUEbGtlwVuWIu5EySI
	 hZMg+S2u3+62HueJcrHycFnaQxwSEKRdovev0nU+iDU/wfcLJjSOEsINkBbpTK9TOE
	 gnpmi32Rdp3tee2QRl3OyWT6dsDsmLJoEHJQdmz6xI5GYG6c924wRZxidCFK2hxclT
	 7TPy1cQ/C+G+A==
Date: Fri, 8 Nov 2024 15:10:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] kselftest/arm64: Fix printf() warning in the arm64
 MTE prctl() test
Message-ID: <4bbc179b-73b6-46d7-b414-f3b14079b489@sirena.org.uk>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
 <20241108134920.1233992-3-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pJb4DIpSwzrlDqsz"
Content-Disposition: inline
In-Reply-To: <20241108134920.1233992-3-catalin.marinas@arm.com>
X-Cookie: Do not overtax your powers.


--pJb4DIpSwzrlDqsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 01:49:18PM +0000, Catalin Marinas wrote:
> While prctl() returns an 'int', the PR_MTE_TCF_MASK is defined as
> unsigned long which results in the larger type following a bitwise 'and'
> operation. Cast the printf() argument to 'int'.

>  	} else {
>  		ksft_print_msg("Got %x, expected %x\n",
> -			       (ret & PR_MTE_TCF_MASK), mask);
> +			       (int)(ret & PR_MTE_TCF_MASK), mask);

Shouldn't we just use a %lx here?  Casts tend to be suspicious...

--pJb4DIpSwzrlDqsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuKgIACgkQJNaLcl1U
h9BeCgf+LP7c17wm3e9XZFV8CJeh3pUUe86mTATYwELGkms9ZoIHXvUwrqhphujX
iRNj8QOet2g1IOFpITbCfKW0fuZy5gTqDkl4T+VPPZFTKGKgHS+whjTEm/lyWbdr
/34+n6666fezdZmGI8kdXJ5KOXV16T42uI2e6jtFLakuK+ks6eTJ1DW+91YuX/CA
jaXBJ/FW0kOG9EMijuWITzemyGf0Hkcq+zsMsT6ahiZA54PttKWx8T5BwpX9s9O+
t984Z7vC/RiwYp+b0LdVKXQjnt8rC9NvfgCdEIExA7+2y474VEKOwE4sZ1doPLk+
pG13Zhc3yNSWzvtPhZmv7LbM2PQUdg==
=OliD
-----END PGP SIGNATURE-----

--pJb4DIpSwzrlDqsz--

