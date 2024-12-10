Return-Path: <linux-kselftest+bounces-23118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340919EB983
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 19:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F34216586A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 18:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBAD204695;
	Tue, 10 Dec 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3QZf2QU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C51BC9E2;
	Tue, 10 Dec 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856191; cv=none; b=EmGgH90INrrx84oTmB2p6pAwQxI8YGXDM+KDHpOlxqejAqL3WDWYpyHlSlK0kdY34E0Z8HfVhUyafy9DVlQdWnxtNyIIU5aR5ySfHk1P9wUYl8LfeG2kSJwBvx60yHLBN8ertaFSpZX1HxLdODdKoSjYabEUNHXyRLoyf83lU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856191; c=relaxed/simple;
	bh=LeyVSRDVsBs+4yUCaB87Pq4OseXmV/4M3itrMP0/wm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6kB471+RH9aSlGCf0zFY8/4jpEmUN/3zTaKabx3jwTLtULLi3nypm04FETCQc3/ANBcF3OXTaCBAF/plJ5BerUNinAX3bhAm8gzLI/rSCifUzSFbm8uGCpfUFYKtrV/UiTCHpkreFmXYkByb0KF8isdUcFAfu4l5tObY/8G9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3QZf2QU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21645C4CED6;
	Tue, 10 Dec 2024 18:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856190;
	bh=LeyVSRDVsBs+4yUCaB87Pq4OseXmV/4M3itrMP0/wm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3QZf2QU1+RKgBarpr3fmwhoA5L2UhFOM9C1RZQnVhg7boSvpELYwkm/EJ/f9atQd
	 vcOIEchsMsRDa9jgC/fglZJI4mvMN8alAfd84kefwG0FYRw9KC7vSHFuP09km5/IcS
	 CEYTczJEmB7IJNgFMxl4xacUh4LnlRveu+fsyKUwjmNFziOu2IJaDx/1TDPb2lVAJH
	 XPZD8d5WjtzFfxNjLIQQUKn24rKrurj5mnKjbj0jihY+320p6VCbzNOOZ6uUrh1Kf0
	 fPS4qcE2JDYYupqGny4KQBES6fDNu1O06rc9d2vfaK5+NPJrBOPt8m5DmUq4BEvGZU
	 p5ZGCHa9/GO1g==
Date: Tue, 10 Dec 2024 18:43:05 +0000
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
Message-ID: <b859bdcd-7343-4d53-9f3a-f374deca725a@sirena.org.uk>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
 <20241203-arm64-2024-dpisa-v3-2-a6c78b1aa297@kernel.org>
 <20241210170953.GB16075@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O7xabmfxJqulB9XD"
Content-Disposition: inline
In-Reply-To: <20241210170953.GB16075@willie-the-truck>
X-Cookie: Leave no stone unturned.


--O7xabmfxJqulB9XD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2024 at 05:09:55PM +0000, Will Deacon wrote:

> Can we _please_ just generate this stuff. It feels like we've been
> making silly typos over and over again with the current approach so
> either it's hard or we're not very good at it. Either way, it should be
> automated.

> Others have managed it [1], so it's clearly do-able.

Yes, the issues here are not technical ones.  Though there are some
complications -  eg, IIRC the XML doesn't encode the signedness of
fields like we do and there's areas where we've deliberately diverged.
Given the amount of review I end up having to do of sysreg changes your
reasoning is especially apparent to me.  I've passed this feedback on
(again).

--O7xabmfxJqulB9XD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdYi7gACgkQJNaLcl1U
h9CY6wf/S1Ub6ZKKgKDElFV3e1bfepjDl2LGu2hOv6vTYntBUtYf58M4kC5iUUsW
VhM9pHp1mjel6TFgH+3a9a7LKOOBdnfROZzmbN/WJnMaggX6kUKJ7NdtfxoQptN0
ifPvJgGbPi5qIBlrVVBPwbw3Zk/Y9RQtbXZqPmz+SeAI2jCre4pjauoNoYpFPrha
fBV6p6e22M5wwV3E+7WfrBxuDvXcxbxoa9oQMNaozZgyFKkMRhW3rlVjKqQ6WtCp
vDYL9qGYhVUjVa0XxOlI7pph9xGF8qHFU7uEt14rssvlKisbIJzOn+WbtsQImdwA
kRgTDRh0VHV1QUFKgSC2MoK5ROEFNg==
=DVp6
-----END PGP SIGNATURE-----

--O7xabmfxJqulB9XD--

