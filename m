Return-Path: <linux-kselftest+bounces-5841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F190187081C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 18:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C4EB2316B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5F65FF0F;
	Mon,  4 Mar 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCtFf9/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC15FDDD;
	Mon,  4 Mar 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572174; cv=none; b=jDQZMLXwRzueas/rnhUklT7QtEWVdi2y4nF9eQwsktg00Et0Y6n/izLRzsVRuz7kJKG9SZ8WVWPj9gzTGLPEnr8h3ePeOZFjksPSRhMtyWzToz9h7uyJK8kdIBvppW6IqPCeIOmy9nEGF1SlQcM4SiWIBLFDhDkNp+JICfmDgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572174; c=relaxed/simple;
	bh=KFuuK6Z/Lbtgs0+49Cr4tb8gzfzX+qY3CeO9ab9UQbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7yXsbv8GZjvm2XzCzMTsCkCa2Izn6QRIc8yR9dJZnIJIEsxdNjVmfX6IQtmLsnq424amySeUldVFlGx1uligmar6jedaWz2f8SW0oRcszm8BHa2kqG5MuO4HMgZ/ccTFP/GKceEMUfwWsQa4jM/nh6q0W7l+o5iGX+kZaC7SsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCtFf9/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1522FC433C7;
	Mon,  4 Mar 2024 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709572173;
	bh=KFuuK6Z/Lbtgs0+49Cr4tb8gzfzX+qY3CeO9ab9UQbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCtFf9/2G5rTnjGvWTuJiR5sMtfoApydEFX+YkpjmcQc4hX533qVYJHvPVrgzmXxP
	 tA1flS8fgAkpUjkjQuynvbudLq2kcpL1bln2Un50p0Aj1RjVHqmt5QSq84gRBqHgq3
	 iZQc1nr/AcWvDRYveT8ZJu+R6Fz48VyIOWF+j69EGOHkJK+EEBaKkN97DORJ7vBXQ5
	 10jwJhHpLRKJYnaSkH+C1uK/wg7ml3pbdwn1/JNl7QqQZlpour37eYwO1heGhmLOT0
	 9KR93efnH2icsYGHSacwW7Git2KGjvh+DRh1TKFqOC4v1g4UrfMNpFNLqPdOCiXRgC
	 73oA9EHPJ+xyA==
Date: Mon, 4 Mar 2024 18:09:31 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Guenter Roeck <groeck@google.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, 
	Nikolai Kondrashov <spbnick@gmail.com>, Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, kernelci@lists.linux.dev, 
	skhan@linuxfoundation.org, kunit-dev@googlegroups.com, nfraprado@collabora.com, 
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240304-benevolent-brawny-urchin-0af0ad@houat>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
 <20240304-rigorous-silkworm-of-awe-4eee8f@houat>
 <CABXOdTc4MXcjwgGuJb4_69-4OFELD37x0B6oMr=4z=nxZ2HPXQ@mail.gmail.com>
 <20240304-ludicrous-grinning-goldfish-090aac@houat>
 <CABXOdTeDydWO9mf2yxWjjebHZ1bE=R2HPs1P4XYwNhzznNKxmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ufoh4k2ksxi7sc3r"
Content-Disposition: inline
In-Reply-To: <CABXOdTeDydWO9mf2yxWjjebHZ1bE=R2HPs1P4XYwNhzznNKxmw@mail.gmail.com>


--ufoh4k2ksxi7sc3r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 08:17:22AM -0800, Guenter Roeck wrote:
> On Mon, Mar 4, 2024 at 8:05=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
> >
> > On Mon, Mar 04, 2024 at 07:46:34AM -0800, Guenter Roeck wrote:
> > > On Mon, Mar 4, 2024 at 1:24=E2=80=AFAM Maxime Ripard <mripard@kernel.=
org> wrote:
> > > [ ... ]
> > > >
> > > > If anything, it's more of a side-effect to the push for COMPILE_TEST
> > > > than anything.
> > > >
> > >
> > > If the drm subsystem maintainers don't want people to build it with
> > > COMPILE_TEST while at the same time not limiting it to platforms where
> > > it doesn't even build, I'd suggest making it dependent on
> > > !COMPILE_TEST.
> >
> > I don't think we want anything. My point was that you can't have an
> > option that is meant to explore for bad practices and expose drivers
> > that don't go through the proper abstraction, and at the same time
> > complain that things gets broken. It's the whole point of it.
> >
> Can we get back to the original problem, please ?

Sure.

> Build errors such as failed 32-bit builds are a nuisance for those
> running build tests. It seems to me that an automated infrastructure
> to prevent such build errors from making it into the kernel should be
> desirable. You seem to disagree, and at least it looked like you
> complained about the existence of COMPILE_TEST, or that people are
> doing COMPILE_TEST builds. What is your suggested alternative ?
> Disabling build tests on drm doesn't seem to be it, and it seems you
> don't like the idea of a basic generic CI either, but what is it ?

You don't have to be aggressive about it though. Anyway. The original
problem I pointed out was funding. You can't expect everyone to pay for
builders running things they fundamentally don't care about.

That's it.

I'm all for CI, I'm all for automated tests and builds, I don't think
COMPILE_TEST is a bad idea, I also think doing those kind of builds is
worth it and useful.

But the point of those exploratory kind of builds is precisely to look
for breakages, so is something we should expect, not complain about.
There's nothing to fix, or nothing to improve to me, except the general
discourse.

And singling out DRM because it regularly allegedly breaks things on
xtensa or m68k and claiming we're not taking CI seriously because of it
is completely ridiculous. If the all the subsystems were taking CI as
seriously as DRM, we would be in a much better place.

Maxime

--ufoh4k2ksxi7sc3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeYASgAKCRDj7w1vZxhR
xXLuAP4wC5xDGdiHGqBC8Uk90cIgeJhuDjincOi98AnfIDAzLwEAlRjgqNP7e2++
8/J5xjuIH8MC29W7H8pSrQAXvFY5Dg0=
=DYuz
-----END PGP SIGNATURE-----

--ufoh4k2ksxi7sc3r--

