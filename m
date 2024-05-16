Return-Path: <linux-kselftest+bounces-10297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020DF8C7909
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 17:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC8D1F215A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A8614D2BD;
	Thu, 16 May 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgLFeDYv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AEF14D2B7
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872178; cv=none; b=C14fCEQ9SFy/XAJ6xjQ8FnZL7cx74/R2qOjRlYKVRc35Cn5i56uf2/6X/iisl10puBFD5pKm5jNI7waGCWWOYByCN9YfwSXYQk3drYZlQfwRyw5tsQlkxcv73a3ARcJ+Xu8FGUimzoeKSd2SxY0wmW47a0JUmJCLa5Rv2yeyccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872178; c=relaxed/simple;
	bh=4e1CyU3ET7+XSdag+4G5AlXocl1TZNSQXXPxA3htHQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtG4IK1OsoFPk9Wv70O2ZFRj+Hj5nw0uKMoJyv9NoY1U2Qos8/zal3s9lO7tQYO7czsO64sFBbWn8h8PuyQjQM7vVf90IdiaIyU2wXQr6isvEZUU9bhscboT8Ktxq2eqNzLbGLInvJAMbqK4RtWx8/3uWd543AmmVjl8f1xeydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgLFeDYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24560C32786;
	Thu, 16 May 2024 15:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715872177;
	bh=4e1CyU3ET7+XSdag+4G5AlXocl1TZNSQXXPxA3htHQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rgLFeDYvRNVZcTScPZ4q52X1xbDOVtrR8xOASEQHEZrU5dN/zchosf/2+nHrthbrk
	 hX/PBOSEu5XLuHxE/DrrXItIpdXg5tpyb2KuMXU0nZsXY/DwxrXxWjnrafbE5Q3zkd
	 E0RK+z9mWxrX7mCGXz19FGiwdFgdtZCBxDU+CX2RF6v6W2b2anLcX1XkE3hrtbiVf5
	 vq7xdPL75hFGRu4/WiogfkxW2shPUEEMhCR03mOUkRTvx1kGZ4bByvlOJUbSS1emgt
	 5qhcAJpu2fcj0QRoaTAi0suAEBSyyIQEljIygdFXRrcjnZrm62PwJIqEX4aAIbBP7H
	 PFb33m3PLALMg==
Date: Thu, 16 May 2024 16:09:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Edward Liaw <edliaw@google.com>, John Hubbard <jhubbard@nvidia.com>,
	linux-kselftest@vger.kernel.org, torvalds@linux-foundation.org,
	shuah <shuah@kernel.org>
Subject: Re: -D_GNU_SOURCE kselftest breakage in mainline
Message-ID: <d885eba8-8fda-4e36-af5c-38eefd6f0af7@sirena.org.uk>
References: <d33973a1-4d49-473e-99b6-f0a5174458e7@sirena.org.uk>
 <71d1f2bf-2e18-4adb-988f-665675fc803b@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fkl8inbLxXTHkfZP"
Content-Disposition: inline
In-Reply-To: <71d1f2bf-2e18-4adb-988f-665675fc803b@linuxfoundation.org>
X-Cookie: I'm having a MID-WEEK CRISIS!


--Fkl8inbLxXTHkfZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2024 at 08:53:52AM -0600, Shuah Khan wrote:
> On 5/16/24 08:02, Mark Brown wrote:

> > I'm seeing quite a lot of breakage in mainline as a result of
> > daef47b89efd0b7 ("selftests: Compile kselftest headers with
> > -D_GNU_SOURCE") and daef47b89efd0 ("selftests: Compile kselftest headers
> > with -D_GNU_SOURCE") - thus far I've found that the use of
> > static_assert() is triggering build breaks where testsuites aren't
> > picking up the addition of _GNU_SOURCE (including stopping installing
> > the other tests in the same directory), and there's a bunch of tests
> > which #define _GNU_SOURCE in their code and now trigger build warnings.
> > I'm looking at fixes and mitigations now.

> Would it be better to revert this for now and get this for now? I wouldn't
> want you to extra busy work to workaround this.

I have patches that both fix the build breakage (it turns out on closer
inspection that it's just ALSA that's impacted I think, the extensive
extra warning splat and some other stuff that's just updates in
mainline) was making the impact look wider) and deescalate it to a
#warning which I'm currently running through CI.

> > The build failures are taking out the ALSA tests entirely which has
> > caused my personal CI to explode badly :/

> This has been in next for a while and I didn't see any failures. These
> kind of changes are tricky. On second thought, I probably should have
> delayed picking this up.

Yeah, I'd been on holiday for literally a month (got home Monday night)
- once I saw the issues I realised I had registered them going past at
some point while I was away but hadn't really been paying attention to
what was going on in -next.  I'm kind of surprised nobody else picked up
on the warnings though.

--Fkl8inbLxXTHkfZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZGIawACgkQJNaLcl1U
h9CQXgf/Y/NUJVFs+5zFCK0T5X0XAUxM7LgN319i/Yb6lN8ByNEs5clJLo2A1wsm
iN9L7EggUYJx7WTQjg5vs96126aPCUUZs6OkzjAvTGo0N+h7pQxJ0jDKUvXq5vc5
Pj/h6Df62sKAQ5pifdj1hGHaQRRNUcXlB7I+LpMcqNI6rIOfiHmv9LmCGI4qRlZh
vsi99m1sipx6I3lAzvyf/ZrL/yZoSa3O0rOPeZnKHyS22QexpbOQ69dcSxf9KsMI
1N3CqR7yWhvctHxljkImOwSnScbck41f21KZjv9NGR6XjuCuGegdC8B/jEf6iLI/
V1Yzhs0oPkI5W6kITlKD7PEPE2mAvg==
=+ajI
-----END PGP SIGNATURE-----

--Fkl8inbLxXTHkfZP--

