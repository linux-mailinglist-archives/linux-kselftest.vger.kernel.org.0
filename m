Return-Path: <linux-kselftest+bounces-23608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F179F800E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 17:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EE07A0603
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA1C22688D;
	Thu, 19 Dec 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auXtyA4x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB022619A;
	Thu, 19 Dec 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626351; cv=none; b=TjME16LvEUk3z3IzO2769zUl/x52+dpkyA7245XbJuOqrlQ7VUJTdLdqF0T0qucKwf93UNAS4GMzU8QbQCL6cKy7cEgIxlTJ7AJx4pxQkOpMUi4pxg/St6ly8HXQa67PaP5VW1/LA5tr5lZtz3luJpjE9nZ7QFgFkazXsbxZelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626351; c=relaxed/simple;
	bh=ypXaJWp5FnrK2zptKyzvmWYExxQK1Fxh1FHf08743/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plyLmYnhOsktqdOpK12Ljn8wlP7HW71PvENmx8c+vLjAd5UPxrKVOWaVOPqp/e4CVIxCW6eEB4/mPfiXi5ZpLeSSJg2pmyvhePczcGN+S0LvdiWSdciBK6MSJaBxw91m18TGgCAbEqKGsvt8S8u9Z4J7p5OzN6a63DwsBZ8+qEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auXtyA4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C4DC4CECE;
	Thu, 19 Dec 2024 16:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734626350;
	bh=ypXaJWp5FnrK2zptKyzvmWYExxQK1Fxh1FHf08743/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=auXtyA4xrFWrERNxmVwHNDhnAXBkQxQ2WML0TSPU6xnFHbLaINkmx1/oIbmaw5UBd
	 ha3o7TLRPYCPasKpFBQqR+Scs44gxkCMHpLkg5khJ4msvqvp915YROa8KrUSQeVLys
	 O5N4H6/CFaPPd9f2RVlV+3GPSO8k3IxcQS4D6Kc7wEA6lExl6216/v/pcHgArGaejl
	 9CQn9BdKHAeS0gylpCDC8jMONqiIYAHQjJr28zWy6ux14GJfrVdVBOM18yC75A6/0M
	 vnqSZ/R+PItnqEvhVKdrGRM+Qz3Cfx3Hi3bcJVcsB19zwxo818GFQM0+FE9VcSBvuP
	 X9q/fMkZdX7vg==
Date: Thu, 19 Dec 2024 16:39:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601
 2024-09
Message-ID: <51632b4e-19a0-487f-878d-f03abeea2553@sirena.org.uk>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
 <20241203-arm64-2024-dpisa-v3-2-a6c78b1aa297@kernel.org>
 <20241210170953.GB16075@willie-the-truck>
 <b859bdcd-7343-4d53-9f3a-f374deca725a@sirena.org.uk>
 <20241211224015.GB17836@willie-the-truck>
 <248dea18-bfad-4ec9-9a7d-5c87c7f48c84@sirena.org.uk>
 <20241219155547.GC24724@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VyjcJ0zj30NUrDgi"
Content-Disposition: inline
In-Reply-To: <20241219155547.GC24724@willie-the-truck>
X-Cookie: You have taken yourself too seriously.


--VyjcJ0zj30NUrDgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2024 at 03:55:48PM +0000, Will Deacon wrote:
> On Thu, Dec 12, 2024 at 11:33:05AM +0000, Mark Brown wrote:

> > That'd be useful, yes - unfortunately I think that's still something I
> > can't work on myself at the moment for the above mentioned non-technical
> > reasons.

> Is anybody able to work on it? Without insight into the "non-technical
> reasons", I don't know what I'm supposed to do other than write the tool
> myself (which means finding some spare cycles...) or refusing to take
> wholesale sysreg definitions until it's been ironed out :/

Similar issues will apply to anyone at Arm as things currently stand.

--VyjcJ0zj30NUrDgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdkTCgACgkQJNaLcl1U
h9DCJAf8CuU5u1XxAnkW18x2L4cYSHQf98sGUnZENATCQW4WaqnatXSW03A/Y0Fs
56SZ9lcKhlhbbcGp0oO4AM02igAnOtSCQBtPG/ZSv7eOLdNLvMsRve9RX5Prgbp1
J63vhYvmVBhqcp0+OO9BJHkdqTkZvs2fgyTL5wb8yTv2u0EAkX32Dx2Qo1fCX1Pr
dgrbnXcXjyc+yq5Q2DrpBhKsMANKyogTFubMPlgYyhCyqeEJbE6irqiO6um+thHW
6Z9IkgN0vqfJUAEEbnOD5acFDamTlED+km44BJJ6hCAA3VtrNqesF0adCSV0Da3k
0rPz0JhoTWgz6DjCMQFwhzG9xz4DPw==
=evNu
-----END PGP SIGNATURE-----

--VyjcJ0zj30NUrDgi--

