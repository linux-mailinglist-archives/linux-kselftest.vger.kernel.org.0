Return-Path: <linux-kselftest+bounces-20822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E759B350B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 16:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6851F21CB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7847D1DE3AA;
	Mon, 28 Oct 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSfqeO5D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C11DE2D6;
	Mon, 28 Oct 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129892; cv=none; b=Ukp5Wvp6+mGAsk8YjAO3CX7BwY/5PxW0b3zaZvQMHQO7psBnDfFyzfAm9B+0YWQIo6bxVZwJVRzNXWVDQkCI/S06sBTtveGyDF+TxFixI4uHVEcg89vfIxN+Jd/h2vnhQD19d/3kYTszDLehq1JmwtDVsmtzEoleE07z/c5ZCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129892; c=relaxed/simple;
	bh=mpanH/RWOt6jLt75EsDkjLmF7diSzO5Zc5R74hVVK3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqSInfabOykMnx1Wwd33GO+pgXudnS4WuxY689oL4qFC6Z/miUV2dkZFW7KTeAY0wXuZFuwvP2i76DZjtsWkauiKbaW3c1mqpwFug6fA7kWicG+sh/VNhyHrnfpkqEiB82nqoP+NkU6QGBORNk+hoKzIN1aKW5WfiAPy7Wf/HwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSfqeO5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE5CC4CEE4;
	Mon, 28 Oct 2024 15:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730129891;
	bh=mpanH/RWOt6jLt75EsDkjLmF7diSzO5Zc5R74hVVK3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSfqeO5DgLutgeOAsan21AgHmQaNB3PavNFf5zVhKjB5mzhdvwix65XNleZfMfyZp
	 UOlHwo7EpgePECjRES+XACp9GDQeTQNPwo7QfhthwNGJEBbx6BoGj9GxxlubSANJ+j
	 74T+gLLpQfOWPOPCxesJSJsylIn0f+xlwNjxO5D50ftOwCCD0aHwtojQvoDI0nRvJU
	 Mk6NZe3jvf3Hx7GasCfgPACdjofRf0awBrfyuzBb/ngtohZqLLeeSPqElIDsxUx2wp
	 1C/ECszxo/bYgqXJH/dvrwM6kJYWS66FVCJ8bK6AmTwYu6e2Fn2IjB6K73vCKbJ5Q9
	 HdQZZTlGpYhNQ==
Date: Mon, 28 Oct 2024 15:38:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] kselftest/arm64: Test floating point signal context
 restore in fp-stress
Message-ID: <3f3f3807-a363-4847-a543-c97f2f405ce2@sirena.org.uk>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
 <Zx-fEtzrpxrL4N3_@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mzPAUqQv9GMuniFg"
Content-Disposition: inline
In-Reply-To: <Zx-fEtzrpxrL4N3_@J2N7QTR9R3>
X-Cookie: Remember the... the... uhh.....


--mzPAUqQv9GMuniFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 02:26:44PM +0000, Mark Rutland wrote:

> 1) We only singal the tasks once a second. Dave's original shell test
>    script hammered this constantly, and it makes a substantial impact
>    actually triggering a bug.

>    Without these patches, I hacked the fp-stress.c main loop to trigger
>    a signal every ~1ms (by reducing the epoll_wait() timeout to 1 and
>    scaling the overall timeout to 10000 accordingly), and those changes
>    make the tests reliably trigger the "Bad SVCR" splats within a few
>    seconds after a few hundred signals, even if only using the SIGUSR2
>    tickle handlers.

>    Can we change the fp-stress.c main loop to signal threads more often?

Yeah, the once a second number was kind of pulled out of thin air (IIRC
I originally picked that for UI purposes and then added the signalling
later without specific purpose, I wasn't particularly referencing the
shell scripts here since I never used them much).  I don't see any
reason not to raise the rate, we do need it to be low enough to allow
the main loops of the test programs to make reasonable progress so
miliseconds feels like it might be a bit aggressive for a fully loaded
FVP configuration.  That'd be a separate patch anyway.

> 2) The SIGUSR2 tickle handlers are left behind.=20

>    Given they're unused, it'd be nice to clean them up.

I don't see an urgent need to remove them, like the SIGUSR1 handlers
previously they're not doing any harm sitting there and could come in
handy when debugging things - the programs get a reasonable amount of
use standalone.

--mzPAUqQv9GMuniFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcfr94ACgkQJNaLcl1U
h9Bt8Qf7BLploh05661KJyynNHiasO8b4194O/dwPlAmnt36eJcyNZyCIueWYCqT
CURcNmLPc/fJDDdvxKJXYexiXR37hdlXQqCSt8XrJSuN6fTRKyaLRFSo+vT1iwTx
3+C5JfP3CyV/0rYSpTf/eTrydoMmi8D4nIQrv3ku/R6SienpKbiDw0yl7utB7Drd
sp27NmviihfB8TO4/KPEqc6BWZC0D6C5v5g8PWDIevJYTrVuwXpe+/oWHRoHmgov
7HlOszL2j/Wfj1tNWd78aWfBUvx55GLxfD6+C+KNtzLpJOSa95vd20OswejobhLS
VRdWMegRkT77RmlnRdfU46K04sLC7g==
=w85r
-----END PGP SIGNATURE-----

--mzPAUqQv9GMuniFg--

