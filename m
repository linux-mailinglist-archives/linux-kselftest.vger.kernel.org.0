Return-Path: <linux-kselftest+bounces-34670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ABFAD517C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7833A5A5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35062405E1;
	Wed, 11 Jun 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvxCBurT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C1227E93
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637321; cv=none; b=JflBvNxVbt9b8uZBz1fEY9XykuL2DhBA5hBaZLxw4mJGaR+cQyOhjayvW4ZPlCpIlb1NWP1NhcvtizGfLhclKWaanYNdlEex+OcizucCuE1nzpPfnrDF+yKSK16DJlL5gEQNpYZyw+5iBk8uflqNwabEw7FBrAGvBmE3u8KcsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637321; c=relaxed/simple;
	bh=otd8DmQF2UPjbKT5TlEFQ7WEFH7QnjxQ/GuXyTc7qu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt9yzxYEjz4OU1+ZM+Edu1nRGBBFSES77zem0/sGba9W2GlGjtC6LRvlKwMCMLTkg6mD2H0acAZPzKauJu5P7hBuNUjYKO2QE094Fp0EYC9rMsnRxlyBpoNJ6l3KsL8AzPxfE8810RySUc8DsJITRSn+QI9QV8l7pkaoKGVjGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvxCBurT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A4DC4CEEE;
	Wed, 11 Jun 2025 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749637321;
	bh=otd8DmQF2UPjbKT5TlEFQ7WEFH7QnjxQ/GuXyTc7qu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvxCBurT8daVCjlC31sPGq9a/TtFBK8AjTa5MyFFXo2Vj4tqQV4IYmG5rqXNmTW6x
	 np7dwWknL/VkU8ijnQKIjUkfqWn5mTVHFhsVSH1K+LT1so1BRZ9912R2AGvbNbaBKe
	 1dim2ky7IGFp18kckwgzhIdy9pvjpXFesozG/Fdt6OrpYokeP0LC8pqqi9q+ekwUkN
	 s1s0KYqMFbvSxLFHOD7JTWOAJqc4FvReBtuU4CpUU0c/24npjTK2pMIluQJhK8ktyz
	 c20p6NefjqR638l4e/2efqtjuImNhO5svuJy4hxB9xGc1IrvcIfxZVwymnQN4y8Gde
	 9Ii3e60QML3Cg==
Date: Wed, 11 Jun 2025 11:21:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: nolibc test target overwites kernel config without asking
Message-ID: <fe05f6a1-b97a-4105-8aeb-db0e84a0b2f6@sirena.org.uk>
References: <3d5128b9-b4b6-4a8e-94ce-ea5ff4ea655b@sirena.org.uk>
 <5df3037e-2486-43f2-9fc8-e0aeb716c848@t-8ch.de>
 <3f874365-c113-442c-a32f-f0b9611f999e@sirena.org.uk>
 <7ea4c9e5-c55e-40ca-986f-a827f04f1f9b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8Ofa72wwBM/yREqJ"
Content-Disposition: inline
In-Reply-To: <7ea4c9e5-c55e-40ca-986f-a827f04f1f9b@t-8ch.de>
X-Cookie: No skis take rocks like rental skis!


--8Ofa72wwBM/yREqJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 10:52:02PM +0200, Thomas Wei=DFschuh wrote:
> On 2025-06-10 18:21:27+0100, Mark Brown wrote:

> > Given that AFAICT the tests don't use any kselftest infrastructure or
> > otherwise overlap with it I think it'd be better to move them to
> > tools/testing/nolibc, that'd make it clearer that they're their own
> > thing and avoid surprises.

> Also makes sense. However I plan to make the tests compatible with
> kselftests as one of the next steps. The custom logic will stay, but for
> increased test coverage the tests should also work as regular selftests.

Ah, great - if it's going to be integrated into the kselftest runtime
system then that'd help a lot.

--8Ofa72wwBM/yREqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhJWMQACgkQJNaLcl1U
h9DzCgf+KHYbYzYzp1WZhblslJrjx3XZdg00Z1pIj8SO4jlCmmmZOXJ7ptJtjY5s
gCf53V3Tu+7SOaGggXFyess6E6eCDSwHd64jhZ6iuj1BvtEI7q8kNH1oOiOth9sw
a/eFhjH/eN0OYVywpJxkocBSFrGLJ8wZb/TtOpTUHnTo5fqFrkYzOuiwrQK4Vu6+
7wsj2sVIiXJ+HYJRJE+azdMBDBK0TjwVGkmBO6PJzKlqv8kAmaxNdZwDllpyUin8
SB1UafIwFKka5g9q5WW3+nSlcxJoCwCA9jPJWPuwsKDTd1IUvwh7eF/Sh7+ktkLl
XqKb9LSLJrbcZ2jO2RwBBpqcQxtGeg==
=y4hA
-----END PGP SIGNATURE-----

--8Ofa72wwBM/yREqJ--

