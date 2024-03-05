Return-Path: <linux-kselftest+bounces-5927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB40B8722DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 16:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606F4283626
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241991272D6;
	Tue,  5 Mar 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqD4YlfY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8501126F1F;
	Tue,  5 Mar 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652771; cv=none; b=n81aPxEOKqyUCrBiufYf/xhYCju44L8/3pGTth28gcdAqxdyoiid+BZmomf+XDQXevO0F0HMth0w09HT6eD2ntHJACQKtUE5Ywwu3pTeZS9SU+9wkY8BL7NduLn2ak4AsEvzoqRdL0c2544MbJuo/V6vPdQzMvH3uhrZOqx0t6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652771; c=relaxed/simple;
	bh=H4WKXO6HRBiCO+Jm9cr0kkJOy4F8udfhngxHNNpjHJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0pzLT0Aa4OXn8UC/kn4FxYsOhBt3VSPPBgznTxeoRnmCkk7362Bc/r6NDCtunCku5SAVYGNf8/7KJn9nOW0YXLyXBqlf1pxo2XvZTZIQGfyPKxfA1bsgRxnOdfW0B5dNxskalR7xl8hvZAJO+nB386N6NWVQCZalFap/xaSUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqD4YlfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6520C433F1;
	Tue,  5 Mar 2024 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709652770;
	bh=H4WKXO6HRBiCO+Jm9cr0kkJOy4F8udfhngxHNNpjHJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqD4YlfY7IpEXvGZ8UgwTFpEOZlZXAXICdaUzn/gFSnHUdAZc+RwtBMFppFXWg96i
	 V9bPAh30pzAdrigUBAy/ZcK2aXV8ye77tYx91ZvW9+86QEOi/cv0aHIVtENmltKVaS
	 Z8NhOlzUYHIk4BoNZtBu4syIVaCZB+qLLwrlRuaz1EVsXcp3vys6OpAiHeKbuyZBpm
	 8d1OpqIFOeShzAUdOMWf/J2n7LySJv/SFE8+W/hj4X84CnvSBwnRkjI2TFnP9TGlDg
	 AuFDPV2vqDMFUePugPd/T1mmrHY1YLK9W4noaNsucvhUq5mnkjIwVeEFuNWggwAwLS
	 4f5aacXcfCYQQ==
Date: Tue, 5 Mar 2024 15:32:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, ivan.orlov0322@gmail.com, perex@perex.cz,
	tiwai@suse.com, shuah@kernel.org, jglisse@redhat.com,
	akpm@linux-foundation.org, keescook@chromium.org,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH net-next] selftests: avoid using SKIP(exit()) in harness
 fixure setup
Message-ID: <e89d52e4-9510-47fb-a632-94bc01c3e74f@sirena.org.uk>
References: <20240304233621.646054-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6/TVXBM12eZLqI3t"
Content-Disposition: inline
In-Reply-To: <20240304233621.646054-1-kuba@kernel.org>
X-Cookie: Ahead warp factor one, Mr. Sulu.


--6/TVXBM12eZLqI3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 03:36:20PM -0800, Jakub Kicinski wrote:
> selftest harness uses various exit codes to signal test
> results. Avoid calling exit() directly, otherwise tests
> may get broken by harness refactoring (like the commit
> under Fixes). SKIP() will instruct the harness that the
> test shouldn't run, it used to not be the case, but that
> has been fixed. So just return, no need to exit.
>=20
> Note that for hmm-tests this actually changes the result
> from pass to skip. Which seems fair, the test is skipped,
> after all.

Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>

This fixes at least the pcmtest-driver suite.

--6/TVXBM12eZLqI3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXnOxwACgkQJNaLcl1U
h9AzHgf8CS2NurGGG34xASpGL/e5wwpiuCpZF4zkh6Kixza35RYYIn81k2gVvrYP
lbsfY3vaG3KSz8mxAyZKthtfXJkdS0sg6qa2m12LapPhczwMWardH5znv3Sti5G1
7JJNz9t1WBKd1P9Cv5R+1RUR9Iq5Jeus/Te+yRuSlBJuOj0HZz81zSZKy9QlstfC
mWcJO+JKLm+tsnKB7CsYc8adHIP85scDGFp/to6k4Mo0okSkvslyTxW7Ew9ZDUXd
L4J2j/DHHJFmJMMk7TgbsNaJMrk4ZccfVJI7ZHBgFSONwi/QrmfD4DPv6j+ARlJz
5HX+/Stgl8tZX3fr91jPNzBgMczkBw==
=2N6s
-----END PGP SIGNATURE-----

--6/TVXBM12eZLqI3t--

