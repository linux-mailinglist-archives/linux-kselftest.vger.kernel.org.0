Return-Path: <linux-kselftest+bounces-6169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F10877BC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 09:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC72B1F2182E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47B11C8B;
	Mon, 11 Mar 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPs1yrMD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66D11725;
	Mon, 11 Mar 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146405; cv=none; b=I3iz4/3wLAjHYhTB4LqSrfHutxawojpIeX4gPiPN5EF45YMBf/rTF5KxRdpvMY0TXkfxvcYJbmd2Ea8mL5pFNRolcRJY+Z1FV+zuNjevJMkGIsaj0xo/Y22JIGUMP2HpEgaoygcgCZ55hElefmQRnWlnZh/EOXR36R2aLteJmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146405; c=relaxed/simple;
	bh=u/HzVfHPDgGvIAyVqL6vd1wQwhGAYlAumZCp5eqbyZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEaqKnBJ8aoJYvDc7zrrtHTs1sHVnELl4Ze0MPI3Ik0HkhGPi80XdsGeyIOSKVBYVFAySZMAFTBMQ4ilFO0DUV4UuUHpazGUqH5K1CKGiH1gDSg05mD/vAKEGwHNoTljqkV6rjUmod3v2JicPlSzAy/jNGCVCspQU94mE9VUVf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPs1yrMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79ECC433F1;
	Mon, 11 Mar 2024 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710146405;
	bh=u/HzVfHPDgGvIAyVqL6vd1wQwhGAYlAumZCp5eqbyZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPs1yrMDOT4qu17gVzoFqHfD4/PcM1EpPKdEPlw3EefZynzxlRt6TBYS3+2x0CI4R
	 9ff17zB0FfByX522iSHZlUvLdYAJ5nllg8UXRfswuqzd5gjQyhTSG0oFQVVmTEntlB
	 hvicqBKOTNktm1zDi4GeTX4dN/b6WbQVLwO9l0oI5wRPTtKh1bQ4Q32CZlXuUnI2ZI
	 2utVOpkbR6jcDVWmcszNaCCXbMaftHFTu+jSW5LLcoqczwPxiLWpC/+5oXZF9nR+qj
	 Xo05gL0o8n4cgAWxXIq/96y9SlCc2s3lRdOkoCXiMJ+Yl3+AHEYQl2OFLyaVVoo12l
	 3hydjp0gbZyAQ==
Date: Mon, 11 Mar 2024 09:40:02 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	spbnick@gmail.com, tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kernelci@lists.linux.dev, skhan@linuxfoundation.org, kunit-dev@googlegroups.com, 
	nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr, 
	laura.nao@collabora.com, ricardo.canuelo@collabora.com, kernel@collabora.com, 
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240311-electric-cream-hippo-20eada@houat>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <d417daa2a8e3951da44bf2d555e04d98c83a3c5c.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w77ek3n4gomubfzs"
Content-Disposition: inline
In-Reply-To: <d417daa2a8e3951da44bf2d555e04d98c83a3c5c.camel@collabora.com>


--w77ek3n4gomubfzs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Thu, Mar 07, 2024 at 01:05:12PM -0500, Nicolas Dufresne wrote:
> Le jeudi 29 f=E9vrier 2024 =E0 10:02 +0100, Maxime Ripard a =E9crit=A0:
> > On Wed, Feb 28, 2024 at 07:55:25PM -0300, Helen Koike wrote:
> > > This patch introduces a `.gitlab-ci` file along with a `ci/` folder,
> > > defininga basic test pipeline triggered by code pushes to a GitLab-CI
> > > instance. This initial version includes static checks (checkpatch and
> > > smatch for now) and build tests across various architectures and
> > > configurations. It leverages an integrated cache for efficient build
> > > times and introduces a flexible 'scenarios' mechanism for
> > > subsystem-specific extensions.
> > >=20
> > > [ci: add prerequisites to run check-patch on MRs]
> > > Co-developed-by: Tales Aparecida <tales.aparecida@redhat.com>
> > > Signed-off-by: Tales Aparecida <tales.aparecida@redhat.com>
> > > Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > >=20
> > > ---
> > >=20
> > > Hey all,
> > >=20
> > > You can check the validation of this patchset on:
> > >         https://gitlab.collabora.com/koike/linux/-/pipelines/87035
> > >=20
> > > I would appreciate your feedback on this work, what do you think?
> > >=20
> > > If you would rate from 0 to 5, where:
> > >=20
> > > [ ] 0. I don't think this is useful at all, and I doubt it will ever =
be. It doesn't seem worthwhile.
> > > [ ] 1. I don't find it useful in its current form.
> > > [ ] 2. It might be useful to others, but not for me.
> > > [ ] 3. It has potential, but it's not yet something I can incorporate=
 into my workflow.
> > > [ ] 4. This is useful, but it needs some adjustments before I can inc=
lude it in my workflow.
> > > [ ] 5. This is really useful! I'm eager to start using it right away.=
 Why didn't you send this earlier? :)
> > >=20
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
> As agreed, the .gitlab-ci.yaml file at the list will go away. Its a defau=
lt
> location, but not a required location. This way, each sub-system can have=
 their
> own (or not have one). The different sub-system forks will have to be con=
figured
> to point to their respective CI main configuration.
>=20
> Of course nothing prevents having common set of configuration for jobs an=
d jobs
> template. As an example, we could have a job template common for checkpat=
ch, and
> allow each subsystem adding their own sauce on top. It can save the dupli=
cate
> effort of parsing the tool results and reporting it in a format gitlab
> understand.

That makes total sense to me and would be incredibly useful indeed.

Maxime

--w77ek3n4gomubfzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZe7DYQAKCRDj7w1vZxhR
xV1bAP9SznauRTHmk6BDIF8VURG655ttC42MmrZ8cF89TuL8fgEAr49BYmklqUpK
gyHR4Xi8NBxGUOVUbAeJr+Ys4vmCPA8=
=ZXTU
-----END PGP SIGNATURE-----

--w77ek3n4gomubfzs--

