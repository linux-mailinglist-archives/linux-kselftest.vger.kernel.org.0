Return-Path: <linux-kselftest+bounces-25127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DCCA1BB42
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 18:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4D73ACF42
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742DB1BD9E5;
	Fri, 24 Jan 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSN2fOAB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032C14D456;
	Fri, 24 Jan 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737738918; cv=none; b=MXhTyBIO6QfJHQfy/7Iqm47oM8Z07M0A2p94kxu0mZVH3AJSFj/URh0NQKYx0545L4cyOjx560dHY5fQbTsG7qK9QnvVNjADYi+713WVYyGJxvbNNJCZ8hT+J1Khams8Bqy2SviBhDi6NWBUHlV+BPeVH0z/k0NxGJys/8EpbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737738918; c=relaxed/simple;
	bh=hL1Pnok4pk95DWthMJhdLv7Et5KDH2Cy8/6CclGJc9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRxlZ52geXDXCrtBx5UdNzt/W7+w90IueTPIZejVshnbb2tVM+eeHzb1MTk7AUx5MisMpkePpFuIeqzoUIsR+oeN3mXPzjJiPvVY6OPN70cvwEvxJohHixuQ5bOz7v2LLCw81Z0eL21h91rx9ome1ntI6S1YYMKBvVy8re3fiAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSN2fOAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6371AC4CEDD;
	Fri, 24 Jan 2025 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737738917;
	bh=hL1Pnok4pk95DWthMJhdLv7Et5KDH2Cy8/6CclGJc9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSN2fOABQtjXvmiTLONv3E5DCykDu/bFTGc31Xg8GgV5eKQ04JksLBEqXsDzVJxqY
	 z5qztk2HfbPkKXSSwazOdAf+ycsArGwhNg4tLhoKuPjnDsnb1yCJG2vjSMcRG7oKe2
	 h6n4FvivW5VYzE51ri70tPB0RcgtNAeO1kBsLwOMI1vEy46IunkcwLdP85LugXFIZH
	 AA8fRZpJqnZyq3X97VgiwZflyo1EtgLQ6EohugVPVIehUf4BMHR6MXShD/NjTzAoHP
	 fOXdVnOOmijyEkR80A7n51X31yCWilr+Baluhf3ZjhCHl8YV/pB78pjgjpMaVZxKDE
	 XyzsmKa52srBQ==
Date: Fri, 24 Jan 2025 17:15:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
	pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
	workflows@vger.kernel.org, skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	laura.nao@collabora.com, kernel@collabora.com,
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
	daniels@collabora.com, helen.koike@collabora.com,
	shreeya.patel@collabora.com, denys.f@collabora.com,
	nicolas.dufresne@collabora.com, louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com, melissa.srw@gmail.com, simona@ffwll.ch,
	airlied@gmail.com, Tim.Bird@sony.com,
	laurent.pinchart@ideasonboard.com, leobras.c@gmail.com,
	groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <023598a3-7fe5-4882-87a1-e8ec2a5f6c81@sirena.org.uk>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
 <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
 <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Huwn+Ta6PtLsEoK9"
Content-Disposition: inline
In-Reply-To: <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
X-Cookie: Earth is a beta site.


--Huwn+Ta6PtLsEoK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2025 at 06:32:07PM +0200, Jarkko Sakkinen wrote:

> Can we then agree that any CI changes can be sent untested to LKML if
> a patch set needs to reflect on those? It's not reasonable to except
> local runs Gitlab from individuals for patch sets. It makes our lives
> more difficult, not easier.

I think the theory here is that this more shared building blocks for
people who want to set something up using gitlab rather than the one
true CI system that everyone has to use.  Even with people who do end up
using gitlab there's going to be issues with things like hardware access
and just realistic resources which mean that not everyone can test
everything.  We generally have an expectation that people will make a
reasonable effort to test things, not that they're going to cover
everything, and I don't see why this should be different.

> All maintainers I know test their patches for the most part with
> BuildRoot, distro VM's and stuff like that. Not claiming that they
> don't exist, but never heard of kernel maintainer who uses Gitlab
> as their main kernel testing tool.

There's a huge diversity in what people are using for their CI
infrastructure, gitlab instances are definitely in there already.  The
last time I looked at the implementation the clang testing was driven
through gitlab, AIUI the DRM and media systems also have something.  One
of the ways gitlab is handy is that it's something that companies are
likely to have set up anyway which helps with getting things
provisioned.

> > Sure, a script could be contributed too, but the value of this contribution is
> > a ready-made integration. And we want to make it easily discoverable, and
> > easily contributed to.

> This is definitely NOT "lots of flexibility".

> Are you dead seriously claiming that DevOps engineers could not handle
> well defined CI scripts and bind to whatever CI makes sense to them?
> o_O

There's going to be an audience out there for people who aren't
specifically devops people and would find it helpful to have something
to look at when getting started, and even where people are capable of
doing the work it seems helpful to pool effort on the more common stuff.

--Huwn+Ta6PtLsEoK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeTypYACgkQJNaLcl1U
h9AeIggAhJ8K56ckeB6tRwQTWAXxPyLs0G04D366IiHS9x4Wi98nBmIngSKwwVq7
utqbsL2LMNZyjC2PnRnNHePvVRBLLjZ+h3xRw/TSqCm/XZZdo/oyTjSZ5QvjnBt1
9BKrJ186Q8TG9xm72Oa6d6BQGpueFVhGbjsZcLRwEsLzXrvIubUEDnypRAIF9S2c
FO7tWZXjZ9gHl6nEJonyAJiiVEY+lSwggJpN77cyxcy3Z9uGBrWwzJjNfCGUYsck
byfTCKi03bXXtCt1bJCRpN/B/MPec5L4tEnT73aVeeLuRCNqjyRl8S5AZbhVp5+O
GX21rf6JPygUXusD9FYHAiCjTHRhmA==
=bKno
-----END PGP SIGNATURE-----

--Huwn+Ta6PtLsEoK9--

