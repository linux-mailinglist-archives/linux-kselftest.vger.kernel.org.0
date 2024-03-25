Return-Path: <linux-kselftest+bounces-6550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFFB88ABA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A271F60EA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8068E135A52;
	Mon, 25 Mar 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKiEbKev"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B55135A7E;
	Mon, 25 Mar 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383785; cv=none; b=q3DEHuMP1baR+fZ4TxCLSus+E5QnGaIKZ0myMUjLrzRtUlqt7U7aYW0fjLKk+GXXPJgs9ylxlfBbaJN+Y3Ex3KPNWOFBKwHKUWpPxJr1IIdYKcyoBekAAA+GdtTPLWPuz+kN5nx+C7hZ6GQ4ejS+vMAe1MG1oDeE+spWjXv+y5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383785; c=relaxed/simple;
	bh=T0OPtdTcAi8F6v9f72txarGuzp3TSBSZpNDBj2DExlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCpYR7mHpz3l3Y8AWmFXplW8SZoPqLShujQYLbCHqhUfqOGydWqCCH92YGBh+e0xt2Ngkx9x7bhPT2RboJ1jwr8Sit8oPy2zUpsRTIOMSkWT+aZAbdTsNgVZjEfelUjAKc/WzDARLn71ib+uu6rSeLl7RNVD3Rxn8BcEY8gLiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKiEbKev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171E3C43394;
	Mon, 25 Mar 2024 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711383785;
	bh=T0OPtdTcAi8F6v9f72txarGuzp3TSBSZpNDBj2DExlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKiEbKevu7vNk6EnUovOUbT1wTFSZYmWHLsXP54P3OiUvKQRdla6QmzLWk0hX1h5M
	 0Mp6H4sR9fDe5RY4t6cr5lRr5MtkWkuRGb+AGyBp1xemmnf4WLa2ObmpZwKCfXBLAO
	 lNXjxkDmLpnsFpuZY7KQQy5V5evlYimuLcydO2diGUwfbQUHQzY9HzIMKMSiAe493i
	 d4Dk4fcqCLWy/irFazEGj6VIHK2g9a3uFz2GAVd+tGZ5jwaH76y57+eDTf3PrOHwlm
	 j29mPi9TbVhOTQqvCCQ7ydA5b+7t+e5TEcGxmI7rZEFYTNjn4Ek8EqjzM1h8w+l6pP
	 BkRp9l5s4rrhQ==
Date: Mon, 25 Mar 2024 16:23:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, x86@kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: kunit alltests runs broken in mainline
Message-ID: <7e2b745a-df07-41cb-a088-966aa46fc175@sirena.org.uk>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, x86@kernel.org,
	linux-wireless@vger.kernel.org
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
 <9c9e1297e2548b363fc93e774c8546e6ebf4efd6.camel@sipsolutions.net>
 <c01d6e1c-1dad-4012-b8b0-dccf19b2e3f2@sirena.org.uk>
 <0d314451371764362a43c4368469c2be6a17eb8c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RLJk4R88JU+iqQ/w"
Content-Disposition: inline
In-Reply-To: <0d314451371764362a43c4368469c2be6a17eb8c.camel@sipsolutions.net>
X-Cookie: Evil isn't all bad.


--RLJk4R88JU+iqQ/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 05:16:35PM +0100, Johannes Berg wrote:

> Anyway, does it fix it for you as well? if yes, where/how should we get
> that in?

Seems to.  Given the breakage I'd expect it to go to Linus urgently, I
don't know that it super matters exactly how but I guess net will be
sending a pull anyway and is the source of the breakage? =20

--RLJk4R88JU+iqQ/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBpOMACgkQJNaLcl1U
h9BeNwf+MeLSVo/HYZnAlD/QCWQH4pI718Nc/VHMLElVLBmbixZ8G1QYnkzBQtk4
BqoctdmlbQXE2bELVFh5pfqoZlD8/c2QWvmV6jsg9s74Rspf7YOCOXezkxHXtnCk
IbNgeu50HBE3Wc/f9e5JZHSgQrL6MAZwNYFPyKtwPzFgCMhIGTACyeh0OG7GRry0
CQ0o67/NiDa+1We9CHQUQum9pbE74hI1h262smSVnmejDSrxCJckBwB5O8iwQuU/
ulU1deCHjWoC6aB0tXRXQcsEPFSPuOVojm9zKKWBn8C0OSEIqMf8e5pDHOHDy/Sm
64C6eYVrLHJsP46huKXF/fWM+1/a0A==
=lhEs
-----END PGP SIGNATURE-----

--RLJk4R88JU+iqQ/w--

