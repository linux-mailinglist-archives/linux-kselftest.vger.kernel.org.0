Return-Path: <linux-kselftest+bounces-33623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB9AC20B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 12:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2983AACCF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA5227581;
	Fri, 23 May 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLkpQQQc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11325226D04;
	Fri, 23 May 2025 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995278; cv=none; b=a8mJeaF9mLA16PCWm0gy0ixQfqtQ/GEsMD7pXbLl2l/nOXC0LTMeh+oVO38SpvXQs5FLNOv9I1VpT9P1CeU4avwmg029cP86dLv1k9qRbAcCVMO5WnxyJHZzBDePL+WeMY7lhEpDM/g8Bvmd+vDWdT+XRm/OJnZZkNKANeyrdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995278; c=relaxed/simple;
	bh=j4f7StKSUjnfIxsKZ4PCRY7thFWBu9DMMOUlqJko6Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY99hTE5nBL3g11cQLQ9YlttsAXeZcRxGw2SMf6xshFprbMGqNnCO5rJj4gjPXk1mszIcJAGcJaG2ZRWFOXmSCPDYHEI2mP5IRU/oYoolkNp2Oty3XU6DBQDamghoKe/RwuD7wDob++f7gJNfgzuWkJeoTfzI39wyJKLR6T5MAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLkpQQQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3631CC4CEEF;
	Fri, 23 May 2025 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747995277;
	bh=j4f7StKSUjnfIxsKZ4PCRY7thFWBu9DMMOUlqJko6Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLkpQQQcgFQS8Ckgkq1xi3SKqfWulGkQ+gHbq1/TcwBs6onPvXEtVmKJMFucD2Yw3
	 FOoPhBC1HG5UJF+Fygb07VEQunWh8f3mdfy5iEsNDwYT6bcAg5AuyTlloLwZY3VA7b
	 ad2cxqbkf0WWEbcjYdRC72xIkJoULg8Th7d5CusV3MjQNXqa0raF3xXIVGCpBIvlHA
	 n9/ZnrAf843ncYUt8XfN7XJpW1599In67N9SsOKa+SauU6W2KKC3P8qiHOIX5v+yaF
	 TwaSforl7c/pVQeocWU39OgTUN4hcmhftz/IYLz6cEpp7iGhPJYtL+hKlG36YN5FEV
	 dQgpZwgEezyCg==
Date: Fri, 23 May 2025 11:14:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/9] tools/nolibc: move ioctl() to sys/ioctl.h
Message-ID: <aDBKiafQmW8mGuN8@finisterre.sirena.org.uk>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
 <20250515-nolibc-sys-v1-1-74f82eea3b59@weissschuh.net>
 <eda3af4a-8dfe-4f82-a934-2d0256b754e2@sirena.org.uk>
 <89bb5a3e-dd6c-475d-9c5d-0bd1595be735@t-8ch.de>
 <744a1aa8-1efc-4c20-b45e-070fc038f6e8@sirena.org.uk>
 <198bf1a8-98d0-4693-a4cf-234cad728c9b@t-8ch.de>
 <ccc18ae8-80e5-471e-b1ef-da132b13b27c@sirena.org.uk>
 <25a18e14-8ac9-4ac8-8907-a087050b1eb6@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rru5DFlX4L7d80S4"
Content-Disposition: inline
In-Reply-To: <25a18e14-8ac9-4ac8-8907-a087050b1eb6@t-8ch.de>
X-Cookie: Well begun is half done.


--Rru5DFlX4L7d80S4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 10:33:13AM +0200, Thomas Wei=DFschuh wrote:
> On 2025-05-21 19:49:39+0100, Mark Brown wrote:

> > That seems to build with 869c788909b93a78ead1ca28c42b95eeb0779215 which
> > is the current HEAD of:

> >   git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git=
 for-next

> Thanks for testing!

> To be sure, was this your full test-run? Or did you do a full test-run

Just a build of the arm64 selftests (which are the only thing I build
that was affected).

> on linux-next in the meantime?
> I'd like to get your confirmation before sending these changes to Linus.

Today's -next appears to have built and be running the arm64 selftests
OK again in my personal CI:

   https://lava.sirena.org.uk/scheduler/job/1419721#L2482

There shoud also be results (both build and runtime) from KernelCI:

   https://dashboard.kernelci.org/

but there might be a bit more lag seeing the results there.

--Rru5DFlX4L7d80S4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgwSogACgkQJNaLcl1U
h9A+QQf/U/M/4FJnWwx7NUX5+Am97EppmQp46sPy6UAVufxg6ycX30+I2Q783cqF
R+ZGbegaiq0C/lrsGTsAE5NKScgoJ1OvbAbdd5STiUZ2f2s+st6cPkoR+VbiXNJ/
0bteweky73k8zzaEr5f96+3v9kZfbZSYa3ldDHH8vuE0ZkIWfR8vxsjvvUby2UVI
qqZgySIx1Ggj+O55dLf37+mkMU8AT6OhFnj/aLZgXUDlkKKhH6YDsgOQHqW46IsE
ZxyfocDTCbUBGaqS5bte4G3mFoOnvl8be0D3D8lvIfvr59VVHjzkm9CcfHwYbNvI
eH6XOI+OfpqYQn2UutGlfCdjhCKJlg==
=fK8J
-----END PGP SIGNATURE-----

--Rru5DFlX4L7d80S4--

