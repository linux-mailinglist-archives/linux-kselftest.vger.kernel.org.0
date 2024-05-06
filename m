Return-Path: <linux-kselftest+bounces-9500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837138BC4FA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 03:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59C71C20D9F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 01:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DDB3B2A6;
	Mon,  6 May 2024 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2iUXrdj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D96FBF;
	Mon,  6 May 2024 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957453; cv=none; b=JsqmIENJgc07NIfmvtpDgXHGF4SACzlJB8wrMoCz4V+S5bRoGPqbTKRtFuFDtoFB3WYpvOjlFIJGLsN3I//CjDpK0H+PEUZSwjHRyQ3fawzPhZThOW1BH9pVOiwkHT08zfHgOa3z0aCtDRH+Vv4EwWoh0DwiMZIVtvkMM/tudlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957453; c=relaxed/simple;
	bh=e8Ln3dhnFOCI3e1b4liuqloFPVZcVU6YxC+ZZ6X2qfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwc2dZmoys6KuDWifsNGvVNJspsm9+VCeRS8qVpfhX0+Saf3yOU0Rrf2ypiIjR2D30yHCwuETtHz1jHFO/kx3GqElEvMfh0PUcbf9UyoBx1XIwriGBSLPV8PqOhDGyLH7XcG873aBrWAxhEO0T/aixMcQ+bQGTbbN1yLXjqlCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2iUXrdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51546C113CC;
	Mon,  6 May 2024 01:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714957452;
	bh=e8Ln3dhnFOCI3e1b4liuqloFPVZcVU6YxC+ZZ6X2qfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2iUXrdjYuFfvI3JVMZ9QNpg/0z304BZiJsA6YeKcrQM2kpZOR/D5bG5WUXCjltJE
	 akqwSoQL6Y+VmCHr7hpClSmmbqdStLScJ0/LSwyFM0JwgtzVdXSG7U5BeMA7huOMiq
	 dNlxK25C/M9qDvjub7Y3ypov0gq8iwW2ITWisXe7048WfkyLEssZVZItO0bEEwhDgD
	 S6T061Fw+JRFzJKBA/s8HSwj60TmcKm++TzDY0Sj0Tm7/S1HUalyg/vuRm96FPGxBO
	 l5dXV+oPslPV0DNt935OVP7C/BfdLB4FL9+V4Pv2mC1JS+RrUNF1mgsPQRYwpEg/cc
	 XtOPko3qHb4oA==
Date: Mon, 6 May 2024 10:04:10 +0900
From: Mark Brown <broonie@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>, linux-sound@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/alsa: missing a return value in unused
 dump_config_tree()
Message-ID: <ZjgsiqFdWpOWB229@finisterre.sirena.org.uk>
References: <20240505210824.55392-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eNuCm8UHobnPoTER"
Content-Disposition: inline
In-Reply-To: <20240505210824.55392-1-jhubbard@nvidia.com>
X-Cookie: lisp, v.:


--eNuCm8UHobnPoTER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 05, 2024 at 02:08:24PM -0700, John Hubbard wrote:
> dump_config_tree() is declared to return an int, but the compiler cannot
> prove that it always returns any value at all. This leads to a clang
> warning, when building via:

Reviewed-by: Mark Brown <broonie@kernel.org>

--eNuCm8UHobnPoTER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY4LIkACgkQJNaLcl1U
h9CbRwf/RcIfn4u/3939fWwPxWV0FycUfvXIUHgDs6t8+qn0IEQq0/II1u0bb2UY
6suvq54RogqOPDUUct2cI8ZkG4bDuSMWXfrrYGuyuhaVJnqwzkrlZRcEPvNqlbhz
Dg3qcd8EhKiRaGB6hu9qT/IoZU9KI1zb+CJuBwGEqzGEslucHRJcxM24GiDQbrqg
fRLClsJ72OFGWYfp2xBuvfAm26JL1c23SGiqwvDAedif3ulNBkWr71uNeEwkZnzP
53Uh/BN3ZsAYvJbFzL3nOnRXxiPe0ptmXPleak75inzf4ANUcLVNeTd3G4NFB8Vj
oBF6k7BH+b8qSD2N6wrLJJMCiB4LrA==
=Twaw
-----END PGP SIGNATURE-----

--eNuCm8UHobnPoTER--

