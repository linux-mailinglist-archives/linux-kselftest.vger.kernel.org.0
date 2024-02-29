Return-Path: <linux-kselftest+bounces-5610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C286C46D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C7C1C20CBF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD356B78;
	Thu, 29 Feb 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZZH06X4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3057301;
	Thu, 29 Feb 2024 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197335; cv=none; b=WrD3cN6EniqrPEbBoo3A8snzqgpNRvRZxF9y7KYL1TAah1KTwN+0lOyOVKhp2mwBzzwDaXvf/FNSTzTHIvspOFm7Sgew6t+SGmMWCmBTpdwrsp/E4mfMyqct/VjHl7Fa7c+aSWkPuv565TZGal0izXa+wVb9QFa3HaydJ+40y6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197335; c=relaxed/simple;
	bh=fNrH7JlGLnpLjF+A5BTqnuPbH1+VOztWweuNWUWW1fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEV3mXu3TTJ1iqOnQqn3s7tES9HIEQUNVm3RVQbbGPM77E5sH1SyUZc9WWKaVY20oA61rBE/n+A3Q44LI68FN+mZUsrtyTJFoifEAS3wdGPxMkC7ZJqIyVdGbQuamELMmByT4gCWuBNK2L9vLpGrcbzBcQQx8AHj5Md18r6piJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZZH06X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FC4C43394;
	Thu, 29 Feb 2024 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709197334;
	bh=fNrH7JlGLnpLjF+A5BTqnuPbH1+VOztWweuNWUWW1fU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZZH06X4ZI+doijyS0EPB1L7lqeu2ki5yiAEqAbnisJpk4vc7edOBfDnlBpQFGdDA
	 fiBKUf7SRoads3YwZZpY2yIiRyPWdcOcf16Faw4opY1MDXxw4Xt8NcE1zbmbGOTmhg
	 Hfv1ocZ0CfUdqmZeKQQNsI9hAeaD2aGtgt2QoR4oeo8fP/INjREpEr/CrPhY9NIEbN
	 bCq+98UPXngJal43EHoUdw1xt0yrdL6fAlrCjAy3bbQCRqP1ct5OON97N6LHYquLx/
	 tQFFPY5pCM1z4IIc4gb3XswhXCw2FarkW+W92YRDJ0Flr+4Ki0L7Fn+52cA/NQPwRI
	 1OEH6d9ULFlkA==
Date: Thu, 29 Feb 2024 10:02:11 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Helen Koike <helen.koike@collabora.com>
Cc: linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, 
	gustavo.padovan@collabora.com, pawiecz@collabora.com, spbnick@gmail.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, kernelci@lists.linux.dev, 
	skhan@linuxfoundation.org, kunit-dev@googlegroups.com, nfraprado@collabora.com, 
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, torvalds@linuxfoundation.org, 
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240229-dancing-laughing-groundhog-d85161@houat>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brdohharmqyoi5zz"
Content-Disposition: inline
In-Reply-To: <20240228225527.1052240-2-helen.koike@collabora.com>


--brdohharmqyoi5zz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Helen,

Thanks for working on this

On Wed, Feb 28, 2024 at 07:55:25PM -0300, Helen Koike wrote:
> This patch introduces a `.gitlab-ci` file along with a `ci/` folder,
> defininga basic test pipeline triggered by code pushes to a GitLab-CI
> instance. This initial version includes static checks (checkpatch and
> smatch for now) and build tests across various architectures and
> configurations. It leverages an integrated cache for efficient build
> times and introduces a flexible 'scenarios' mechanism for
> subsystem-specific extensions.
>=20
> [ci: add prerequisites to run check-patch on MRs]
> Co-developed-by: Tales Aparecida <tales.aparecida@redhat.com>
> Signed-off-by: Tales Aparecida <tales.aparecida@redhat.com>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>=20
> ---
>=20
> Hey all,
>=20
> You can check the validation of this patchset on:
>         https://gitlab.collabora.com/koike/linux/-/pipelines/87035
>=20
> I would appreciate your feedback on this work, what do you think?
>=20
> If you would rate from 0 to 5, where:
>=20
> [ ] 0. I don't think this is useful at all, and I doubt it will ever be. =
It doesn't seem worthwhile.
> [ ] 1. I don't find it useful in its current form.
> [ ] 2. It might be useful to others, but not for me.
> [ ] 3. It has potential, but it's not yet something I can incorporate int=
o my workflow.
> [ ] 4. This is useful, but it needs some adjustments before I can include=
 it in my workflow.
> [ ] 5. This is really useful! I'm eager to start using it right away. Why=
 didn't you send this earlier? :)
>=20
> Which rating would you select?

4.5 :)

One thing I'm wondering here is how we're going to cope with the
different requirements each user / framework has.

Like, Linus probably want to have a different set of CI before merging a
PR than (say) linux-next does, or stable, or before doing an actual
release.

Similarly, DRM probably has a different set of requirements than
drm-misc, drm-amd or nouveau.

I don't see how the current architecture could accomodate for that. I
know that Gitlab allows to store issues template in a separate repo,
maybe we could ask them to provide a feature where the actions would be
separate from the main repo? That way, any gitlab project could provide
its own set of tests, without conflicting with each others (and we could
still share them if we wanted to)

I know some of use had good relationship with Gitlab, so maybe it would
be worth asking?

Maxime

--brdohharmqyoi5zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeBIEgAKCRDj7w1vZxhR
xSjBAQCRssfillRrGUMBa1ch3HBDzvSfbSqZ2N/SJfWL+UZbAwEAsIDU0lgkUX70
nn5+H8DQwoNMV2PnoT2QpRTKqGauPwY=
=mmaE
-----END PGP SIGNATURE-----

--brdohharmqyoi5zz--

