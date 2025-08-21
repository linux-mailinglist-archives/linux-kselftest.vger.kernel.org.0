Return-Path: <linux-kselftest+bounces-39535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C6DB30105
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 19:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D58E1BC571E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DB23115B8;
	Thu, 21 Aug 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbbRsU2F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0C3090D4;
	Thu, 21 Aug 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797095; cv=none; b=WhKaLkVB3ITauhcPnoSZf7Gkd+wFm5yiGcKbvPpPsduC05GSsWO9VJL4honbNpZcLoK19Q+TmG6cL/0fF/hwmd4Qko4CuanUG7+awcl9pi84sDr4nsYMgAEBcWrWzGjeI/Bnect9IL83z3aWL3HkmjJyVHHAPtzIQwhVJVfq4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797095; c=relaxed/simple;
	bh=3/dQIN/6bQs5cMkEYR2kGWQIOG8oSziPJNK6u+M3TKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aewWZlSrak2KaGmosByqd/Ni3DRw61o5MQo7iC+xjMvxlT08u2jPmTxZ0yVVTriCixqudmJHTOr84fNHrILNaoaeCR/6tCb1dbNBNYWzrdTWhNJvsMst66N6klMRjJCJj62thN5phXSj/QUGlhMywGsxsUqlHDAhZ5XYINo14W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbbRsU2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB0EC4CEEB;
	Thu, 21 Aug 2025 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797094;
	bh=3/dQIN/6bQs5cMkEYR2kGWQIOG8oSziPJNK6u+M3TKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbbRsU2FbjHzWD8HhM2bCrBS0hMiRzteNS9o3F40QEvuuGSIZ0EhnGRscZ8uDMONG
	 IL5cT9ZTjmrSovM0Conzjx4X7ZkmqUyrKXrGjDq51s6e93LQ0IZkRdngZTBfFdeahN
	 rF9N8MCZ2RChmIK1IH4hQo+LkEzbQ/NrrK98DOpPaEZnjlHMyMZSEMPMhU4NDp/UfS
	 Ae2nl/nJe2VGlaS74QhlNI2cnUGMclBz/OFMYysAMvO0HCU0ysVMSzrNG4usoHO4fr
	 72fy4rgAhRmcnp/m2cBscXutwTuRKhmxinX3AcXrc38HnD4FFiiL/rbXP8+/PQDTO+
	 6BQRSXmOsuong==
Date: Thu, 21 Aug 2025 18:24:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftest/arm64/gcs: Use nolibc's getauxval()
Message-ID: <d5a26257-769e-4ad4-8d6c-723529b66aec@sirena.org.uk>
References: <20250821-nolibc-gcs-fixes-v1-0-88519836c915@weissschuh.net>
 <20250821-nolibc-gcs-fixes-v1-2-88519836c915@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aTcioaIg2uzKW47S"
Content-Disposition: inline
In-Reply-To: <20250821-nolibc-gcs-fixes-v1-2-88519836c915@weissschuh.net>
X-Cookie: Warp 7 -- It's a law we can live with.


--aTcioaIg2uzKW47S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 05:13:03PM +0200, Thomas Wei=DFschuh wrote:
> Nolibc now does have getauxval(), use it.

Reviewed-by: Mark Brown <broonie@kernel.org>

--aTcioaIg2uzKW47S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAminVmEACgkQJNaLcl1U
h9AVxQf6A1M5k78zL2oHUCa1XHXmZ2SNKsaRCAl+dwv0NAAGZVrcPpptgN6brFHI
2wmu+akQQ4ySojXlKtQZ9N1huH8OhNU3KB+OdPQTQkz7rI6u9LN47eZNRDW3I6cd
X//TqDY3s0/a+nYkBDvWWEW4/BicZ2NP0BQiafY0JjioM7Oz5H3TjXwRDsDP44/2
WmcsLUmySNoCcAP85z8m7X2t9btxDKFvcg9VadNJKSeOH1DFhRaoPMODtosGzzv/
4hdiBqn+n1m25AdceKsRDCyOjcBJjvKz7a7LwTCJBtt2swGrLU/zZ9VhSuSUYv3N
PQd9ZCJsh3vYd7SKImd3L5vEL2TX5w==
=DLpa
-----END PGP SIGNATURE-----

--aTcioaIg2uzKW47S--

