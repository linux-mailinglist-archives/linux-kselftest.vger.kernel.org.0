Return-Path: <linux-kselftest+bounces-39614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60103B309E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A0F1D0020F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 23:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA8286D50;
	Thu, 21 Aug 2025 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcyop3vU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFDC22CBD9;
	Thu, 21 Aug 2025 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818046; cv=none; b=VUluXdm2z5yRue6KkbnndbgJhZ/HO41YCS4n0FzXlpwSzQMbjEFgQd1l5RdccqvBL+HzqgiejznJzqshYAV7FccoAQNxtew72c02Bs8PQIJLf4Wi+h0enPzGVFdM0p0wbFMJaCDmMQB6Dh7guBvgZUUfcGSXu370TPUvm/Y+zLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818046; c=relaxed/simple;
	bh=+Fd4hex0v5A2Jp8km47dNwNpIjquGOCRML4KaiRjcms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKFp6NMUrWhNtqutHFNFTOmpWwntt34pVu9QJT/Aie4EWmJ8L5nB1Uvd3oQ+dW5pEC7bn/7p3YZUJFsegkssKv4u/AsmrU5/d95Gr7JunmFVruB1eXTbbW/F+iN07KRJT2fSWsz0+frA0PuqA7vh9uZilO6TNx0ujIaQSP0qKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gcyop3vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42098C4CEEB;
	Thu, 21 Aug 2025 23:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755818044;
	bh=+Fd4hex0v5A2Jp8km47dNwNpIjquGOCRML4KaiRjcms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gcyop3vUYz9QId350sMm0ZlAUM2Bs/MFkuVigXbACaCwMIscE82rjkJmclwZ0OkvQ
	 bOTU/I3kifjCxleGmqbZEQxHjyNIF1GRjQY5/zSGLuB/8459vQRKQYpJlGA1fTs6LF
	 y3Nt5aiPalMRTrm/bYoTTDoS6TKqitHu0KJSzewzovbxnYmJoCY1fpr3ODez2n9qK9
	 rJQU3eiCzzMUUb2Kk5yNfa8bobj7fyq9xE2Y/X9UpqxbVGlgthCwonDc3eHlTb15Di
	 HYJpmhPFf82UxxJOSZq8s8SaYXvTpv5SZr83tGJT72HfwHijEkDC5RMhNQBAdzEaJo
	 HTOiVeP0egqHA==
Date: Fri, 22 Aug 2025 00:14:00 +0100
From: Mark Brown <broonie@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, shuah@kernel.org,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/alsa: remove 0/NULL global variable assignment
Message-ID: <5e9d15e2-d77f-4540-8528-0a7c60d7f92f@sirena.org.uk>
References: <20250821200132.1218850-1-zlatistiv@gmail.com>
 <9c310ab7-0f0b-412f-8df7-71730a2d2caa@sirena.org.uk>
 <CAHjv_as7m7UbSLAPU6hX_=tAvLZYR_7Q=1n+Xq-nW-6OJ237PA@mail.gmail.com>
 <f7ff446f-2a9e-49dc-af7a-6e4c76803471@sirena.org.uk>
 <uzfke2ry3rhdirqpdb2bdjkoemj4rgtfwsio7yf5la7p3p2ait@6umacnfdeto2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fpvv84RzATYdGRRa"
Content-Disposition: inline
In-Reply-To: <uzfke2ry3rhdirqpdb2bdjkoemj4rgtfwsio7yf5la7p3p2ait@6umacnfdeto2>
X-Cookie: Warp 7 -- It's a law we can live with.


--fpvv84RzATYdGRRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 22, 2025 at 01:57:05AM +0300, Nikola Z. Ivanov wrote:
> On Thu, Aug 21, 2025 at 10:30:50PM +0100, Mark Brown wrote:

> > Do you have a reference there, note that these are just plain non-static
> > variables?  I wouldn't trust checkpatch for anything that isn't kernel
> > code (and even there it's got issues).

> This is what it says in the C99/C11/C18/C23 drafts I found:

...

> Since as you said checkpatch.pl is mostly intended for kernel code
> (which I was not aware of) this patch is probably not desired.
> In case it still is I can add quote to the draft and link it in the patch.

No, it's fine - thanks for checking the reference.  I suspected this
might be something specific to how the kernel is linked:

Reviewed-by: Mark Brown <broonie@kernel.org>

--fpvv84RzATYdGRRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAminqDcACgkQJNaLcl1U
h9BdCgf/TfI3HsI809BC+afmSmWtLf0s3lTuAF0GOKUDNAB5r8rYhxWVTiYOiiDQ
Wbr6b2ESocsiL6w7ZwqMsO3y80XRxU/FNTIWZuJlQV4J6eLnFoj3XQPE1LBAW/3z
Xo+vmTVeIf3UZ81+f1tr8feL/m4Nno2sdWEY5Cg1OA9ToX9i/clLFRME4GsV+CpV
E9OMqsbcRq44Q+o/bgf17RyVFj5wxnS/Rxj4hdxka14xPXMFpwwEYh7F+H7aNsne
eCM16uieEqa5hQeyf26ZB1pHT7K+17s9/2A3wJ7j1/Zv5jevH479yW1eKnFiTf/Y
PtxUT5D2fDcvbh2Mc65o+aMnhFA3hg==
=Uoem
-----END PGP SIGNATURE-----

--fpvv84RzATYdGRRa--

