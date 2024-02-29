Return-Path: <linux-kselftest+bounces-5608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9CD86C3F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCF91C22489
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F135481CE;
	Thu, 29 Feb 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z34O1fiM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C538537E9;
	Thu, 29 Feb 2024 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196208; cv=none; b=HGBQB884wecxYFqJUB3u/J6Zm8dj/JaN/YTyb1Kq+vtr1bvYB+TKOT57a87XB8GOWVRPN8RWEvge4ijlVTiQRTswnEDj7/9px9pwySWFVboZhFagAHm2cnqzQM5+VOjIDaxz9iAzfJJPOSCMTNFFz1BwIq5Kbpv4UfWX8X/2abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196208; c=relaxed/simple;
	bh=OtJFUbFzli0ao9Kk04l+WlQKFdrjGXqosC1GcMlUSc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+9NSbqtKf34ZCe4+QCpRsZ+TLlsHEgTmR1AalZAo3Ljwy0j6DpERBS9dyrliHBA8fSzVoQVmNxZi2GjZW0c4rsOez36a/Nmkk7pLW3ilH3VHbBj0srBlgh8yMWoKbQYOlrtO39wS+b4MBc2cOho6Nm43h8YVFDRp2F6VAeU110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z34O1fiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D39AC43390;
	Thu, 29 Feb 2024 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709196207;
	bh=OtJFUbFzli0ao9Kk04l+WlQKFdrjGXqosC1GcMlUSc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z34O1fiMdBDeainA1ZPjTfVLielaOBKLFzX80CW3c98pKgURmEjTwJcXGsOqiJ0Ia
	 ZwmkHPVHgPYH9oMMqExQdZYthC0nFc5SVVDwn7Uz689/6Fs4J5TA5kom9TGKWGv4UM
	 vVlUAwe7W0KNMMU18vYMLOViKVsKAjuFzlj43qvt8EN2qxWNC8PZ8RbbyW7I4x3JTi
	 8PNYG4kPaOXvSqWLsmuQU00wkUA0cyTxDrvfCX2SB7KBkYkHVQVhVckkTmf/D3Bk3m
	 pM5EwmORJVumtGEpriYqslBnnsSDYb/04nHzojvoSRNLCcSJsBKdW07GUWZTvuUjVC
	 WKrO2LBS3O2yg==
Date: Thu, 29 Feb 2024 09:43:25 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	spbnick@gmail.com, tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kernelci@lists.linux.dev, skhan@linuxfoundation.org, kunit-dev@googlegroups.com, 
	nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr, 
	laura.nao@collabora.com, ricardo.canuelo@collabora.com, kernel@collabora.com, 
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240229-rampant-blue-llama-c4ee7d@houat>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228230725.GF1659@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eu5m6zbxesqv7xj2"
Content-Disposition: inline
In-Reply-To: <20240228230725.GF1659@pendragon.ideasonboard.com>


--eu5m6zbxesqv7xj2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 01:07:25AM +0200, Laurent Pinchart wrote:
> > Chat Discussions
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > For those interested in further discussions:
> >=20
> > **Join Our Slack Channel:**
> > We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance htt=
ps://kernelci.slack.com/ .
> > Feel free to join and contribute to the conversation. The KernelCI team=
 has
> > weekly calls where we also discuss the GitLab-CI pipeline.
>=20
> Could we communicate using free software please ? Furthermore, it's not
> possible to create an account on that slack instance unless you have an
> e-mail address affiliated with a small number of companies
> (https://kernelci.slack.com/signup#/domain-signup). That's a big no-go
> for me.

Yeah, and that list looks super restrictive and arbitrary. Like,
microsoft is there but kernel.org isn't?

I'm sure there's a reason, but we should at the very least open it to
everyone.

Maxime

--eu5m6zbxesqv7xj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeBDrAAKCRDj7w1vZxhR
xT7gAP4oRjk5cvZCFl9XtJxHv+2sUJDNxvUgOUs8Px07O0eymQEAgtIrH290cK2V
mFnAbb5kwrTnyNl2XQDimzTR0qN31Q4=
=Cc5W
-----END PGP SIGNATURE-----

--eu5m6zbxesqv7xj2--

