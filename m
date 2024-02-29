Return-Path: <linux-kselftest+bounces-5626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C115C86C7BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 12:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C681C2341A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 11:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EA07AE4F;
	Thu, 29 Feb 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKcbF2F8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F357A73F;
	Thu, 29 Feb 2024 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204989; cv=none; b=BKDH8TDmAvm5dKrWSZxgjjd06CnaOLO2GCTLkVquHGv6+8qATCJYq6H3CcaodqYZRLy2tcX6oNBehm7Sugk81Sn4Ad0Sg+YQVEaHJrYNuLrzZ3nTnzaS0tWkDiNGu5JPBS4mxORCH+XfHy+Ksceg8t1Re8Z7/ULy73kkz+9kNLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204989; c=relaxed/simple;
	bh=3Jp3DLK4GaGdce9BlkhMX4N5x38K7gfZP7ZzlOJJEfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nW9Q8PsM4xJsvsL00Wm7wrUjZX0wZew1bV+trkC6EyItUuvD5lXG1EFdKdOPv/Upqa7yV9YmKzZ7um6FLo6XR/zx8crxLL6pr81X+sUvODnwAIjLmVWPoS438cIWisTvmLMlfMAgTeDQw50FoX7q4+do7UDnGU9kKNaRFUfAGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKcbF2F8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7E3C433C7;
	Thu, 29 Feb 2024 11:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709204988;
	bh=3Jp3DLK4GaGdce9BlkhMX4N5x38K7gfZP7ZzlOJJEfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKcbF2F8ZMtL7sBtcMDzQD6+mAG3TlIU9zJO8V9rQDocWsppaDOIxHNY1RvGjFHWw
	 MJmN90Q2aEVdInZAr/grLzs0Qg/1CJblp0gm9YcUTPcllXe24r7VbFt1/mrOY9scQ4
	 JsXgknMvJkYmR4XQHtS0+FB80b5EpjX1ToXNL2uGfJvbdagyEGVniY9+268P+sZc8o
	 YQUKobwfQOW1cnqEV5CEOko6ZGbFyxko1jaPKVXNYchKccAaMlH/lanDmDt5p7Ehko
	 onxsBZFkSNU59cP1t7HX5eK1pzTx63dac9NAaSD7gB2n4+jyOBoVxwiwg0DYfcvd6H
	 TjlmtFWS6dkGA==
Date: Thu, 29 Feb 2024 11:09:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, pawiecz@collabora.com,
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
	kernelci@lists.linux.dev, kunit-dev@googlegroups.com,
	nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr,
	Julia.Lawall@inria.fr, kernel@collabora.com,
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <c7df72f5-857f-4ebb-b751-25fcb786427e@sirena.org.uk>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228230725.GF1659@pendragon.ideasonboard.com>
 <ZeBQtfY8FG_qtoEJ@valkosipuli.retiisi.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Iws3dWkEFVnb2rF9"
Content-Disposition: inline
In-Reply-To: <ZeBQtfY8FG_qtoEJ@valkosipuli.retiisi.eu>
X-Cookie: Marriage is the sole cause of divorce.


--Iws3dWkEFVnb2rF9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 29, 2024 at 09:39:01AM +0000, Sakari Ailus wrote:
> On Thu, Feb 29, 2024 at 01:07:25AM +0200, Laurent Pinchart wrote:

> > > We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
> > > Feel free to join and contribute to the conversation. The KernelCI team has
> > > weekly calls where we also discuss the GitLab-CI pipeline.

> > Could we communicate using free software please ? Furthermore, it's not
> > possible to create an account on that slack instance unless you have an
> > e-mail address affiliated with a small number of companies
> > (https://kernelci.slack.com/signup#/domain-signup). That's a big no-go
> > for me.

> I agree. There is no shortage of good alternatives either: we have IRC,
> Matrix and XMPP for instance. Just pick one of them.

And indeed KernelCI does actually already have #kernelci on libera.chat.

--Iws3dWkEFVnb2rF9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXgZfQACgkQJNaLcl1U
h9AdtAf/TjlgwmBR+dFt3Imb6vVXvcZz1uk0yqE9QdLn/+P7uF+i6O6Lo61wzzW7
wZF6S/KVkz5gmMx3Ow6CzP1eyKOYvn2N/m2F7ImNuRtqKUMKv/0/rzxEtH5DK+da
F1p6iV8WH3xIplXt0+nxc198yzskr+/zj8i5Qbs/OCVOl/VNmYZ70u9BFAhmsdmo
O3YFYTKWetaRZPx8u8uoPUnAVofMV3vF4PtGQQDHPTmK9AC+4poc0jIx2V6PviY8
yYgh9MrynKWlj1WRPrutfENQo++scSX66MdRQj4DfDeZm+7LUHDe1FzK3bRncJgo
e5RUDmeCXKOY6foBuo2NKtLQHPBOPw==
=uZ/p
-----END PGP SIGNATURE-----

--Iws3dWkEFVnb2rF9--

