Return-Path: <linux-kselftest+bounces-13728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7333931584
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 15:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C8C282759
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D018C356;
	Mon, 15 Jul 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPjIYudq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DA189F59;
	Mon, 15 Jul 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049530; cv=none; b=leHcVZKM2d9WhxUluwzTTVgQE8+EoAM8eb7dZEu5qwguqYbQJpBXedHEmh4rv076O8Lw8Cy00x4cVyBlVqbzW08P4r0b/0T/iST1nd9EbGwmw9jAMdpBtyvNk9W1dc8fNacD05qDXmpgZc25CxqY7rgLb7ppI/cKHaT9lKRWsPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049530; c=relaxed/simple;
	bh=ixZV+2ApSfi0Qt1a6E91BrmEdKnPzSgIHP2rtlQgCtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z19YTiW6eMeu9Lql9fE22FTaYAfkrcjnv8af1Vkvi+RjaYwq2HvzOk3ApnsAa7qhGKoqhSyX/bfokgosVgKfN60XUulShS+G0FQPSst/qASNM9e/b1nRJqPTEAWL8FUGLM81pFlbd+Kh5mUds3wGlWTxDnBpYQTRrfoIw2hxBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPjIYudq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B13C32782;
	Mon, 15 Jul 2024 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721049529;
	bh=ixZV+2ApSfi0Qt1a6E91BrmEdKnPzSgIHP2rtlQgCtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPjIYudqUcR1vXo+cJRaLVgtOPefovG5Y1Hf5NwAgvvhHZERpZUTx1Mg/3cg4Xp6k
	 nZxUOQBg3lJapM2IwVFsCeQn1O4SM6qRV++uHngWGX/3PzGxiplVFvj2CK0NMHFHk6
	 X5THhQ8GhIF+skJwx+jk0mFh1BjLTYGgdBZDCJhXqgHnj/g5JgDmvMntTaZDiKD9or
	 xS1ZqvfaIHPtN2qg5TNfgJ9OLgU9SRgCBk5DT27G54uz/MEOWInMuGNCZu2ilKpxAl
	 t2Ms+wvYOYKUbO7n0+79BEMKO7R6Au7Kxsk0xnLUIo14BsTyzR6lDrNY671yd/XaJv
	 cRu3wYdrfmF4g==
Date: Mon, 15 Jul 2024 14:18:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Use card name rather than number in test
 names
Message-ID: <652d6fef-9e63-4c3c-b61b-8a47d6eadaf1@sirena.org.uk>
References: <20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org>
 <7cd921b3-fed9-4b0c-9ba8-381e45ef4218@perex.cz>
 <b3fdbb63-067b-4ff4-8fd8-1c2455a553a5@sirena.org.uk>
 <877cdrt3zc.wl-tiwai@suse.de>
 <e4962ea0-3f03-43b5-b773-68abe1d73cc9@perex.cz>
 <bb42afb8-48a7-4daf-b28b-b82bd5c77d57@sirena.org.uk>
 <c1be6bec-90f5-4bb3-b6b0-8524095fc490@perex.cz>
 <31e73e81-e60f-4d0b-b0ac-118f1dc72610@sirena.org.uk>
 <87plrhssa4.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcf5+ogDXnD1HO4r"
Content-Disposition: inline
In-Reply-To: <87plrhssa4.wl-tiwai@suse.de>
X-Cookie: You'll be sorry...


--pcf5+ogDXnD1HO4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 13, 2024 at 08:46:43AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Sure, but the genesis of this patch is that probe order isn't
> > sufficiently stable and we want to avoid names based on it...  using the
> > ID will be more likely to work out stable than just pure probe order but
> > it's still got the same issue.

> Are you trying to solve the issue with two cards of the same driver,
> which are swapped sometimes at the probe time?  Or the mixture of
> different cards that are swapped?

The one I'm running into personally is due to the load order of the
sound card drivers themselves, but it seems good to try to address the
issue in general especially with ASoC where you're waiting for multiple
drivers for individual components in the card.  That means that even for
a single driver the ordering might not be stable.

> In the latter case, id should work well.  The id is primarily created
> from the (short)name string, and the suffix is added only when
> conflicting.

Yeah, it's more stable but there's still a potential issue.

> OTOH, if the former is the problem, using longname won't help,
> either, rather it can be confusing.  I noticed that the test output
> truncates the name string, hence both cards look identical in the
> actual output (except for the card listing at the beginning).

Interesting - I was mainly developing on a system with multiple HDA
cards and was getting fairly clearly unique names.

--pcf5+ogDXnD1HO4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaVIbQACgkQJNaLcl1U
h9D/SQf7B6L3K9ySU/Pt7rCsrL47juqKartR7TU57qKWjQ7cOb8+sLbpOBy/qv2C
gvqQNK2z8OZ9/c3/1bsNxMDCFbF8gQCasBrr0Bwtwax62lQWXaKKFbY6zwryvOCK
GQ5vy2GajBk4Hb1Wsw46f0iDshrVUv8SBqIpLn6tfOloiKDvg3BdDZNxKlhMYej4
UcqZseDVteqJ3z05u/c2amxaGSLGSW4iYe46iJyXBdGxFyQogfzJNudMdfWmEAxo
YuQNRRz9FzOekMPFgPpGJ8TUJz2yTk6O784nH+/2qBLJ8mzbcKHRn1OgA973/KlQ
YDK0VuynCVIg9mW8hKHSaim9UITSCA==
=ctoL
-----END PGP SIGNATURE-----

--pcf5+ogDXnD1HO4r--

