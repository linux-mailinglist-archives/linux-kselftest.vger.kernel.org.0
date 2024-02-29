Return-Path: <linux-kselftest+bounces-5624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A55BE86C632
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD20B2760A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8C262A1D;
	Thu, 29 Feb 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhuIblFQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586662A19;
	Thu, 29 Feb 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200621; cv=none; b=d8TDV8AGaYDzJtyHQLg9PtzuDpc3edpvtRp9H5V3rMPaMEJ1wxUqxMgWKvuDsWUmR3YcftQ9JzpB7pGT499S9yXg0gntQcEtNPjvGL4khReZ1xToUllhhMALSVWEwhotXUFAZ7J0CTR0Lb36Lo8emhjK4DayE6jz3rYjhsh78IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200621; c=relaxed/simple;
	bh=iNaRdEVaMHWobztCiAzO/M37ER6KhZR4DFakU8WYEZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD103aJtr8SEMgNJLfH3mwbo1FSFwsV1NgN+P80es4ea3lN1QbH9kMW5d/r9sW+9Iz0FyIpp/q/MgJtVhVtG3ko7jsObSIn4lTFQirgs3irvrBvRw3YLGLuWE75X7ckfs//pFxmY4B1kwZsgUjAUaqEPv2bCQS5L4zOEQByT7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhuIblFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5388C433F1;
	Thu, 29 Feb 2024 09:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200621;
	bh=iNaRdEVaMHWobztCiAzO/M37ER6KhZR4DFakU8WYEZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhuIblFQZzcu+2sLNm+9nD3/tRvPDe1ckx8Su0hfHrH/8Mael/sgXoHiKfIWSpkol
	 QDk1/zVk2BU6wWlWCv9GQ/HMDWidR8UWAaeoIPcHkwXnz6KoXzzzskHQf06p/aG01Z
	 xsvc2aWx2CMAFh8cYPYpov4NuL5tsjzYUZIVIDkanz53ApFeddAR0KWEz3BL4W9RsT
	 NLi2oJBz1aJpaQiPJrhrrmy3Y1+1Y6XXKp1i6rC9rE8bvfF7hnAYz/oJumTOajlKd6
	 6S9SvQsRB3+MZK3XNnyDF9cZ/VhedN78zFcvdAkApRSuYBRC8GEIN4pvhypsDe236h
	 1wYM5lVbFYRTA==
Date: Thu, 29 Feb 2024 10:56:58 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, kernelci@lists.linux.dev, 
	skhan@linuxfoundation.org, kunit-dev@googlegroups.com, nfraprado@collabora.com, 
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, torvalds@linuxfoundation.org, 
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240229-quizzical-persimmon-honeybee-b5db48@houat>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqbbrit24to5mmpq"
Content-Disposition: inline
In-Reply-To: <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>


--vqbbrit24to5mmpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu, Feb 29, 2024 at 11:23:22AM +0200, Nikolai Kondrashov wrote:
> Hi everyone,
>=20
> On 2/29/24 11:02, Maxime Ripard wrote:
> > On Wed, Feb 28, 2024 at 07:55:25PM -0300, Helen Koike wrote:
> > > Which rating would you select?
> >=20
> > 4.5 :)
> >=20
> > One thing I'm wondering here is how we're going to cope with the
> > different requirements each user / framework has.
> >=20
> > Like, Linus probably want to have a different set of CI before merging a
> > PR than (say) linux-next does, or stable, or before doing an actual
> > release.
> >=20
> > Similarly, DRM probably has a different set of requirements than
> > drm-misc, drm-amd or nouveau.
> >=20
> > I don't see how the current architecture could accomodate for that. I
> > know that Gitlab allows to store issues template in a separate repo,
> > maybe we could ask them to provide a feature where the actions would be
> > separate from the main repo? That way, any gitlab project could provide
> > its own set of tests, without conflicting with each others (and we could
> > still share them if we wanted to)
> >=20
> > I know some of use had good relationship with Gitlab, so maybe it would
> > be worth asking?
>=20
> GitLab already supports getting the CI YAML from other repos. You can cha=
nge
> that in the repo settings.

I'm interested but couldn't find it in the doc, do you have a link to
the right section?

> However, I think a better approach would be *not* to add the .gitlab-ci.y=
aml
> file in the root of the source tree, but instead change the very same repo
> setting to point to a particular entry YAML, *inside* the repo (somewhere
> under "ci" directory) instead.
>=20
> This way all the different subtrees can have completely different setup, =
but
> some could still use Helen's work and employ the "scenarios" she
> implemented.

I'm worried that this kind of setup will just create duplicated YAML
that will be developped in complete silos and will become difficult to
maintain. But that's definitely an opinion :)

Maxime

--vqbbrit24to5mmpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeBU6QAKCRDj7w1vZxhR
xQ7BAP409AbFcwBdoKD+HMuHlPoXehR+KqHJiC/xTs+iNzmyNwEAkcokR20iK1ta
dDEJ7oinWP3ncejFNUuTUwCM09uQGw0=
=Y3AM
-----END PGP SIGNATURE-----

--vqbbrit24to5mmpq--

