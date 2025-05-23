Return-Path: <linux-kselftest+bounces-33650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C127AC24BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B8A7B791C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9791F2951D6;
	Fri, 23 May 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhiM3Bhh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1252951C7;
	Fri, 23 May 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009438; cv=none; b=eRFU27KyKZwswju7gV164RuJlFkEeZod5nVdeO/I6SbZkPP0lxXEbwQKaWhMZJUG7v3P/yKRC9I6LENx6KeSW8ilRUxWp8xaY0BhJYN2OzYZQ6OPquMiqM+EvVP3HF5DR8Nciul1NvW9PrgSaXhIfDH50nh0RtzY9qDVGHbOYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009438; c=relaxed/simple;
	bh=SSblO2qVWIjlntGNtgCj+1uYCyMpD1LCHVB9tlR9PzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5m/KH1xYiICc+D1OBpPgwRIxIdzmM+jhXgE1YwS5FSE77Yl4Db6eoji1dJl/BZOA2OobkCWMHA2hoA4AHGGUIPhgGZBnjeUHelPLFtkq710MKhAXXVCdCijb0yLX1XQCYLpjoA4pvmd1FvB9A9ZD48AD6lKGYsovUUc1sxUFHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhiM3Bhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8FEC4CEE9;
	Fri, 23 May 2025 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748009437;
	bh=SSblO2qVWIjlntGNtgCj+1uYCyMpD1LCHVB9tlR9PzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhiM3BhhRTGcd5koMHAmUyk7LUGbqzIvZ8N88Qn2hwj+GKTRlwQrGjgsO4JXruSHY
	 lQKTGTf5Br3WAhjAOECwP3WVvlzeGJ7pjYW4UbWJkY2YeXUGv0r65enuO8977PRhax
	 Hgdfk5Nx+w6/edRMSNdOeEIPKGDWQbBVlXkiiOlVKjHtf3pmOPQZyKIiu0rdk+xSqv
	 aO6pBEUyQNMj8HvUT1r0syx0fw4SFC3x/riHLzZ443BHLw0MgUrOIkqWZRETXbl5WM
	 IzuVm9JKRdCTWS1D5W8id35t0csqrrgGchgLpCuQx1M6H8WCgQe/+77/ezRV9IgqQF
	 PozANS6ab2tsQ==
Date: Fri, 23 May 2025 15:10:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/filesystems: Fix build of anon_inode_test
Message-ID: <aDCB2oWJl2fTGf4t@finisterre.sirena.org.uk>
References: <20250518-selftests-anon-inode-build-v1-1-71eff8183168@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bP/l2XWz3qyPXN2p"
Content-Disposition: inline
In-Reply-To: <20250518-selftests-anon-inode-build-v1-1-71eff8183168@kernel.org>
X-Cookie: Well begun is half done.


--bP/l2XWz3qyPXN2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 03:01:34PM +0100, Mark Brown wrote:
> The anon_inode_test test fails to build due to attempting to include
> a nonexisting overlayfs/wrapper.h:
>=20
> anon_inode_test.c:10:10: fatal error: overlayfs/wrappers.h: No such file =
or directory
>    10 | #include "overlayfs/wrappers.h"
>       |          ^~~~~~~~~~~~~~~~~~~~~~
>=20
> This is due to 0bd92b9fe538 ("selftests/filesystems: move wrapper.h out
> of overlayfs subdir") which was added in the vfs-6.16.selftests branch
> which was based on -rc5 and does not contain the newly added test so
> once things were merged into vfs.all in the build started failing - both
> parent commits are fine.

This build failure is still present in today's -next.

--bP/l2XWz3qyPXN2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgwgdkACgkQJNaLcl1U
h9CL/gf/bnEzJbJ2Ohu6bWhnCfPodBGMVf3hVL4ipnxaQ67z2vmVpomJT503vNnp
qu0zEaIxEyhRPFJn2WmIqBrAnCHVvUlaUv4pXb6N9mk7pC+zQZP7nki1Mpx3CL7S
KApcWT86j+Fxm3WgNFSuEJo3hQd+OPZA3cU/hX+JVjsTCmRD0hb6cNNNvgOD3rbS
mPsCPjbQPq4r2tm9YDDUKbNG9k6EnuYhdCsNqb/boyUwMTHTz6afp45AHe+g/Cb3
sSk7lI6YSFh3j3CJN18gJURrk8hNg/IukWqPmnRlTgXEmirvRdRCRgh+u5Ir6KaT
dlb3ymMoRx8ZWd2oSMQ05AL00vje0g==
=5cDf
-----END PGP SIGNATURE-----

--bP/l2XWz3qyPXN2p--

