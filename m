Return-Path: <linux-kselftest+bounces-5724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7EB86E2F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 15:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE5B282C9E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999006EB73;
	Fri,  1 Mar 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PybPpKrr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE5A40;
	Fri,  1 Mar 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302068; cv=none; b=flTBEOyJi1aQxTshM55Jhplsxvs4sh/lG/dVwjr4Pj7yJqh8GTui5TSjrk7hqWQ2PqDZLVCsrgHdZ1Uf07wN3lGZwb2mGE7dISiGN7UsLnkgNI/xyHAorf6kiaH9wfVNu7gS6ZKsnHn/kjPyvAx/aaHLtYhZXan3XvcSG2P9KPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302068; c=relaxed/simple;
	bh=V/ZkOgK2iZvRSQ++CJWksKmz0CTjhfhLyLii2QbfEkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUaV6H/w7rbo4UCDaLsLXy5U1krhxrK9gHO2y1f+HO/YvvPE36GnlY6BF4ecrYIgZHS/2yE+nYhnKIWCXcX0SfKovyCfA4dId5EoI5H/ewBLBNuWKJwajeZ4rLTgo9KpBjzUfPpWi39WOeiZzlsN0jx+15B2GNkHEsO2QWjymgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PybPpKrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9129C433F1;
	Fri,  1 Mar 2024 14:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709302067;
	bh=V/ZkOgK2iZvRSQ++CJWksKmz0CTjhfhLyLii2QbfEkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PybPpKrrCcZPy18fpDWyIlQodCkmfcS1+/l19GXkZ5jkeKjFQYmQo+krU/Ko9/JMR
	 Q5w05L8FpAF5VJfBGVnUbE84zUiK1aUyXtABKvHzocb3zZwcljQgcDF4EiigStwNdS
	 Cww/amyTfu8FpryNgmEuFAxp9V+Ve+9Pjp5pJZJes/fxCcUxAm/zbZZRftNTzPHnvS
	 Oj7zC2/yU3RziaxBek7jtQdUSaYDu/zGD862eAROgE0dqHsoX1Akz5E9CAaSw9rQYt
	 Zl/5YHw/4hwcy3X6oEqHDhFHzfekhpO+5KVnojVxnOLAe1eAlOIuRuatjotfKru6DA
	 65NE8wX3ss10Q==
Date: Fri, 1 Mar 2024 14:07:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com, pawiecz@collabora.com,
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
	kernelci@lists.linux.dev, skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	laura.nao@collabora.com, ricardo.canuelo@collabora.com,
	kernel@collabora.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <9183479f-eea8-493e-9a56-9f3f778e3034@sirena.org.uk>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YhbwdPAihVH/ItCG"
Content-Disposition: inline
In-Reply-To: <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
X-Cookie: Schizophrenia beats being alone.


--YhbwdPAihVH/ItCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2024 at 12:27:13PM +0200, Nikolai Kondrashov wrote:
> On 2/29/24 10:21 PM, Linus Torvalds wrote:

> > We already have the situation that the drm people have their own ci
> > model. II'm ok with that, partly because then at least the maintainers
> > of that subsystem can agree on the rules for that one subsystem.

> > I'm not at all interested in having something that people will then
> > either fight about, or - more likely - ignore, at the top level
> > because there isn't some global agreement about what the rules are.

> > For example, even just running checkpatch is often a stylistic thing,
> > and not everybody agrees about all the checkpatch warnings.

...

> > I would suggest the CI project be separate from the kernel.

> It is possible to have a GitLab CI setup with the YAML files in a separate
> repository. And we can start with that. However, ultimately I think it's
> better to have it in the same repo with the code being tested. This way you
> could submit code changes together with the required tweaks to the CI to keep
> it passing, making development smoother and faster.

> With that in mind, and if you agree, where else would you say we could put it?
> Under "scripts"? Or "Documentation"? And where it would be best for the
> various subsystems to put theirs? Or could we have the top-level "ci" dir and
> pile all the different setups there? Or would you like to wait and see how
> adoption goes, and then decide?

If we were going to put bits of this in tree how about something like
tools/testing/forges?  I'd hope that things could be shared by multiple
services, if not we could always have subdirs I guess.  We could put
glue bits like defining how to run kunit, checkpatch or whatever with
these systems in there so people can share figuring that bit out.
Individual trees or CI systems using these forge based systems could
then reference these files when defining what specific tests they want
to run when which seems more like where the differences will be.

I'm not super familiar with this stuff, the above is based on it looking
like there's an OK degree of separation between the "what to run" and
"how to run" bits.  I might be misreading things, and it's not clear to
me how often it'll be useful to be able to update things in tree.

--YhbwdPAihVH/ItCG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXh4SoACgkQJNaLcl1U
h9Bblwf/VTM6YUfyvCiFxlO2Sxm0DvgYcdMKFDVe0Iwu6FKdwHafjgfDIAW/fydL
Zseb1Kh+uo2pgtj0H6hU5ZNPVzux4lyYsfO7aWhZePjev836VEqMIEeJJp7Xxc+G
GyrpLnxWa/q+WvHh/dOycgP8JdJTWIoPPP27rSFGsgikoqTVhtJUF2ld6MPJGSbe
2Gna3Kd/ALF9sms7c/ND6qWhoqLlsjFF7v6SDUuOHfVozPdez72lpAx0WLSdj29D
9Bm2oGIEPWS1dlyXRXh34AaUeUFqXnr0kK2fgOkadM/ndszTaB3+X3ujZXC2MCUL
+5OwpbUNLXA9RkS8JN2anvXIQ9uuGg==
=mh+h
-----END PGP SIGNATURE-----

--YhbwdPAihVH/ItCG--

