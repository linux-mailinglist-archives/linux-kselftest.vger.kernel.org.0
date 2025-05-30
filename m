Return-Path: <linux-kselftest+bounces-34063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A599AC9251
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E585B502348
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5AB7DA66;
	Fri, 30 May 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI0Ghf63"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C372DCBE6;
	Fri, 30 May 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748618184; cv=none; b=EMCratP2aNQWopf1Q6pyJdc1IsWfP7OIdFcF51jHjeOk6c5Dl2rMLdWgdzgrdKzeqVUDn8E1L24A37P26Dzbn8K6YC/o6M/nGTYmC+/Reckymf3TMvx1lZrMNURkC007W6gB7/X6DM5mseDVcBYLwsCLld1dsYarzravubCt8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748618184; c=relaxed/simple;
	bh=hNDXrkBKfg/Lw1k6ehbXBxfJcCE3Nuc4xcHJgiw94/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpdfGjqFwFC8H0U6M0/F/02G4pGNGeQwzhiYAfPlSDyUzXg0IQygGjZ9W8bEzLtQhENyboPWmT9wd0QvLUG9L5WI8AGY8/lOHYs9vX0P0O+Fo5YWbh2ADZB0afcKxLzhOd/UPtCbPtYysa6JQOcD88pIdNZsNwOsz9LawepJ5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI0Ghf63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C28C4CEED;
	Fri, 30 May 2025 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748618183;
	bh=hNDXrkBKfg/Lw1k6ehbXBxfJcCE3Nuc4xcHJgiw94/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pI0Ghf63ZY1XycTvAkPUhsHgiiC7GJzsKpc4/f3pQ6vKZdjX2V3qcnPMJSMYbO4Ix
	 0KV3AuGIqBZqaeqvnekVR0u2+HIAqiKMWQFx2FRh0W1lauRGPte5jO/HeljDQXjNGy
	 KcJP6cyfsziAac6XcgD0GqGNxjnOjbF2V7ScdaBcRlXB/IsVXKJp0FmZT8TPHOZow2
	 WoUydn1+rbFHtmk9dMOLfgFBnqu+k8xtiUBRYxuxzNfSEGvHEmPddfM5qnNNH0Moye
	 VGZMQURTsQBWGGxsGZGMmXLVkH2d4G4RO7L71hZTXou2+ehgx7q7W09S8grpMVpOvf
	 rbehzbBJsPs7Q==
Date: Fri, 30 May 2025 16:16:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, brendan.higgins@linux.dev,
	davidgow@google.com, rmoar@google.com, rf@opensource.cirrus.com,
	mic@digikod.net, skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH net] Revert "kunit: configs: Enable
 CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
Message-ID: <aDnLxFi15Z4X5PJk@finisterre.sirena.org.uk>
References: <20250530135800.13437-1-kuba@kernel.org>
 <aDnKH1LiYiuWhLA6@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XK5Zeg2AyvcUAOAX"
Content-Disposition: inline
In-Reply-To: <aDnKH1LiYiuWhLA6@finisterre.sirena.org.uk>
X-Cookie: Well begun is half done.


--XK5Zeg2AyvcUAOAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 30, 2025 at 04:09:22PM +0100, Mark Brown wrote:
> On Fri, May 30, 2025 at 06:58:00AM -0700, Jakub Kicinski wrote:

> >  $ make ARCH=x86_64 O=.kunit olddefconfig
> >  ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> >  This is probably due to unsatisfied dependencies.
> >  Missing: CONFIG_INIT_STACK_ALL_PATTERN=y

> This seems like there's a bigger issue here - this sort of thing will
> keep happening if you're running with older compilers and it's also
> going to be prevent the addition of any coverage that's specific to
> architectures.  It would seem better to fix this by warning only and not
> erroring out, perhaps splitting the config fragments into must succeed
> and can be dropped sections.

Sorry, meant to also say:

Acked-by: Mark Brown <broonie@kernel.org>

--XK5Zeg2AyvcUAOAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg5y8QACgkQJNaLcl1U
h9AX0gf/R80iKzOlHDOUfFvpIj/GA2KzoH/TFEhAPquu6Y2ACEqc0v8f0VROL6/H
k2Tj09ntX7DN8PVrDVH16C0JvRNyX9XJ2q2+b4cniLPxKlWH7UQj/ohuGhH5eDYw
wHB8FfoxZn1NNXRn1XmksSGwMXFVhjiSqyHR2Bwf8yEiw8KxBYYMpItKgE3VC2Cn
GfJk4bebhP27IE005DqyIVfVRHMtbUEgUdAmBcjh3xLSVgAWMGQATngOoYgYXXvA
VXIFvxINw3TPBYTM/8c38f5iloUFtfJoFAqq2ObtT2tTy9JiBMpHKsTXJmr7OTRu
z00VPhiJ0rb56arQ33l5ZkyK1AcimQ==
=90HL
-----END PGP SIGNATURE-----

--XK5Zeg2AyvcUAOAX--

