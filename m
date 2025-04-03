Return-Path: <linux-kselftest+bounces-30060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BACA7A3A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 15:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3598C3B479F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3811222561;
	Thu,  3 Apr 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWZ/znVs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04135942
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743686808; cv=none; b=rN1alNRwrQ5fYnaRcsxs2mLTljxpSHIv2GQ4lJDpWdTaq5FlJnSpFrCReutCmAZ7z/rcdwc4FrR8FBseg4w8z4xHHEYguOPCyh0CiE5MOoqEJLFxs1jiPQG+gsjcWzZeMhN7iVaOLlj7099ojKdvJim8fkQoUmW/cVzXwg7QjUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743686808; c=relaxed/simple;
	bh=t7QhbUBDRsUmmolPKLfJEw5a0E1gvQOVxhO6maRT7rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElecTUZx3bBZtRyc7QHmqsF/Bvu1G8PTGN9F1KGYJ3GfIUc2XN7+me5YjRqSHYO12hWbaeWSmoP5fhWgzutXoOp7I4EeQ/HE3Wnlp/diE1yUiJgMzUBWWk0inOJNDOJ+doB1Xb+XN4iF0PJDbuXeoHDJLcEpw3GD/dGLuuwl5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWZ/znVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE3DC4CEE3;
	Thu,  3 Apr 2025 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743686808;
	bh=t7QhbUBDRsUmmolPKLfJEw5a0E1gvQOVxhO6maRT7rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWZ/znVs/GOnafxivM27M2KENGFbM6Pdu2mJZ1JoR+cqwvuex6Okq2MkjtS6hcqXb
	 lGkxujaAjEIO43Qef63pMVaJ5b+sbSxqpuo3NTUM9kvMJ5r514UEYhUEclRuEuCWrb
	 SVcfiUa3kN2IVqjxV5/XarYUVW5iG1xpWaALbOSWuTLWb2KzAGpoNo4C4PRL2s4N6+
	 oiRc23VbRgt2VgdDnNBn6PDb1oZDuLZeiMcnOLH7+ISwejvajUQaUm8ccQp2xb7qJe
	 25YwkDKB5xunoiNz9UU8RvaulTI1M6+TEMQ3xAHYFoAw68u/3G71MkzebGBCi50IO5
	 fCLEptFJyx0SA==
Date: Thu, 3 Apr 2025 14:26:44 +0100
From: Mark Brown <broonie@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
Message-ID: <d9d9fa47-c926-4479-a0c9-fb6c0713b244@sirena.org.uk>
References: <20250402103655.3e0c62d7@kernel.org>
 <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
 <CABVgOSmSU=i9WvUHFERY--Pgqg3Hr_LxgA9HJ_5aG4F-FgKhzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tWywZ8FmLb69mtEM"
Content-Disposition: inline
In-Reply-To: <CABVgOSmSU=i9WvUHFERY--Pgqg3Hr_LxgA9HJ_5aG4F-FgKhzA@mail.gmail.com>
X-Cookie: Logic is the chastity belt of the mind!


--tWywZ8FmLb69mtEM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2025 at 02:19:40PM +0800, David Gow wrote:

> That being said, there are a _lot_ of Cirrus FW tests (over 5000 by my
> count when all of the parameterised ones are taken into account), so
> this can still trigger the default 5-minute kunit.py timeout. And
> because its split up over a lot of smaller suites, it doesn't really
> make sense to mark all of those tests/suites as slow (though some of
> them might merit it). If that's causing issues for people, maybe that
> could be a good reason to remove them from KUNIT_ALL_TESTS, though
> personally, I suspect the better answer might be to move it behind a
> config option which can then be excluded from the default .kunitconfig
> if necessary, as in [2]. (Or just increase the default timeut.)

I've not heard anyone mention hitting the timeouts, though now I run
interactively I do see that the Cirrus stuff is a good proportion of the
runtime for --alltests.  We could potentially add a config option,
though it'd need to end up in the config file so it gets turned on and
we'd still run into any timeout issues.  There's a tension with people
expecting --alltests to actually run all the tests as well...

--tWywZ8FmLb69mtEM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfujJAACgkQJNaLcl1U
h9DkIwf+OoT+Cz7cFXL5amjK5vDtfa6svvqCAYKnF4aGditlCF4v1DniRSXgnO0Y
LQ2f5Qkr94rf/BfCeCGk+Ab5Frn59GY95/DWs+2LvzZxhp14CGByMpaUEeo+07NB
vmvMqZrdwZUmw8kGqtpC5B4rCspLpAhQMPPyEwxVDdoSuVQ0sn78D3kU0Bh9uiug
98T728gTpj7+sx7CIqQ/gKrJFuCb8m5gDYvHhjN0CA1igZC1421xrfKt4ZBdug3V
26S9eQEY8xNTHZZRPdsN65D73I0fV2vbAvc/nmFnBMmrDgr+y61PWMKbu9xTy6PR
IUEQKNVFBYYcdINaaafueEvLLvm4vA==
=MWgl
-----END PGP SIGNATURE-----

--tWywZ8FmLb69mtEM--

