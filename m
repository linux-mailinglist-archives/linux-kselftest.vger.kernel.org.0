Return-Path: <linux-kselftest+bounces-22928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCED9E794A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 20:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C56C282F04
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 19:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8791FFC40;
	Fri,  6 Dec 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAuf0RN0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75951FD7A7
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514623; cv=none; b=Z5LzVKu0/2TPYXpzMEOoWctE7Ws6MVDtMmSwDuoRM97J32uJE/EWePo96HIVbCDxxOTtctW/G16IyaGNjBgo6EbZS35lAs1A2MpdXsmJ6rr8FX1PTQ50QcXL59quhS27taCtIyxqyfUXqg5sEhUx5YvEswzu8g1w+3amAo73S0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514623; c=relaxed/simple;
	bh=jDcg682T/gU3pfoauFT4gUn/Tt9EkxiZW0lr20Mpqow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuhXlXNWX4wGXtY0SN5nXS/nR00qq6Oqj/xw2i3v2ONbl4SlRtn2rJgDCK8DmVtD+i4utXOn5rMnHZlVtEU2cq4ZhlC/CTsjvChVvJ5Ny6eaP60TKEdtcrUgnHN78hL5nMgPVsxHH2BtiUxTF2MvXPRwbdueGEMesDb1YxKrkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAuf0RN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12E8C4CEDF;
	Fri,  6 Dec 2024 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733514623;
	bh=jDcg682T/gU3pfoauFT4gUn/Tt9EkxiZW0lr20Mpqow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAuf0RN0oYE3+hK5j5c1yTI6FGJkY62sKnEwPEY662Vj2KqXE3yhm7UzB0knvPeUO
	 kuBLVwzB7NUU0gnCDq6IaU7pEsd9ZzCCALlUTviME02F3OEL5AYOXa8hmc1Wmdg0t7
	 aAVJ08NxcdISK3x6at4Bsgr2OtLJpfsS6ndsypqesX7JzUjsevz6gQkGlULsXnXcvp
	 zD3V2B9kosxjdJGUjQJUpY9PZwFHVhePy3D8amOwFqCZ3ArZKghycIYToIYmeCX4Fp
	 BbWq7PyeWjRcRlMNrynUVoOMtBkvcRp9Kk+8pkFyjNpjxVBxzsKPAMZWP5SIFUgaPF
	 S4GqEHFm7EqOw==
Date: Fri, 6 Dec 2024 19:50:19 +0000
From: Mark Brown <broonie@kernel.org>
To: BiscuitBobby <simeddon@gmail.com>
Cc: shuah@kernel.org, mbenes@suse.cz, Petr Mladek <pmladek@suse.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/lib.mk: Introduce check to validate
 required configs
Message-ID: <d942cddf-1600-48df-8819-7b774ea603fc@sirena.org.uk>
References: <20241205114757.5916-1-simeddon@gmail.com>
 <20241205114757.5916-3-simeddon@gmail.com>
 <6564cc2e-745d-49df-900d-263177c1ea19@sirena.org.uk>
 <CAGd6pzPEUun=t4=DGauX-zGhzMnDJsEcHGwZfH5DZkwmffeC-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TYwMMXzU3CbvZUz+"
Content-Disposition: inline
In-Reply-To: <CAGd6pzPEUun=t4=DGauX-zGhzMnDJsEcHGwZfH5DZkwmffeC-g@mail.gmail.com>
X-Cookie: Sales tax applies.


--TYwMMXzU3CbvZUz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 07, 2024 at 12:50:47AM +0530, BiscuitBobby wrote:
> On Thu, 5 Dec 2024 at 21:05, Mark Brown <broonie@kernel.org> wrote:

> > If people are building the selftests once and then using them
> > with a bunch of kernel builds it might be surprising if some of the
> > binaries vanish.

> I'm not really familiar with packaging selftests, but this patch does not
> remove existing binaries when running tests. If I misunderstood what
> you are referring to, please let me know.

It doesn't remove existing barriers but it's also not obvious that this
isn't just a generic dependency mechanism that should be used for any
old dependency rather than things that would actually break the build,
and it's one config list for both build and runtime checks.  If the
intention is that this should be infrequently used it probably needs to
be a bit clearer that that's the case.  As things stand I'd expect there
to be some confusion about the interaction between this and the existing
system with specifying config fragments.

> > Shouldn't we try the current kernel tree, and for runtime checks
> > /proc/config.gz would be good to check when it's enabled?

> When I looked into this, it seems (according to the config.gz man page)
> that the contents of /proc/config.gz are the same as
> /lib/modules/$(uname -r)/build/.config, but /proc/config.gz is only available if
> the kernel was compiled with CONFIG_IKCONFIG_PROC enabled.

> It does seem like /lib/modules/$(uname -r)/build/scripts is not always available
> though, so will send in a new patch directly checking build/.config
> after checking
> it out on a few more systems.

Indeed, when deploying a kernel for test people don't always deploy
modules onto the target filesystem, there may not be any modules at all
if CONFIG_MODULES is disabled, or people might just not install modules
that do get built if they're not needed on a given platform.

--TYwMMXzU3CbvZUz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdTVXoACgkQJNaLcl1U
h9BJOQf+LoZCZ3H3YmAgKenGEctd+izma7wwBrK4a399G+JKyFEqEXICPy9nKaoS
P1kUmthJcEN5/5v0besAYOnzRld4XI/Nw9D5EZTzBWtfbLmJo3WWFZjEvn4h4QJI
90FcmtbA+CCqrzcS4T8CnzwF0gm9oWiCRvk49K5KLmLA9s+74ZfRLBOpnVw/pwEY
CbkTtk/s5uA0//j1B+jTfKV1dwSsqWdFWD3XXDXkN+f+tGK+j4D7feMMq5fToim0
XZTFBwH+EvOpzpLsHSn2BzHv3Eb6NYLm6+1xCWsPHyNuxrNAJeJbbTzPWMoIVVTG
LEv1xZN43Uc80g6QlIdvEjLs789/MQ==
=Qiyr
-----END PGP SIGNATURE-----

--TYwMMXzU3CbvZUz+--

