Return-Path: <linux-kselftest+bounces-14707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE986945E02
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 14:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925F1282D00
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EE61E3CA6;
	Fri,  2 Aug 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIBV7iZT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319B4A31;
	Fri,  2 Aug 2024 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602590; cv=none; b=Fe/Yr6sz/iDCbHQwJ5ogenr5Do+sVTVb8mhuOg0QmQRjFLdgzePOWq6T41DhyCiY8w8soLriORVPznAzixPt4tArlhkSoCDQwzOyeLSrNYxa4wPETZiiTjihjzsIzfqnZ7QLOwo3Su9B12fH6B52VnU6v1ewoG5Rc6iR6wMK3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602590; c=relaxed/simple;
	bh=633lVYjHNRU3EjRX/nYwTZxzcH0uaJwWa8OgY7HscFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU/ajVw4qvH8s384y8S7wu4SJRpUW0A2YeGpCnzxp4LYdCk/gmpcjke0aCtrw8HN1+bMH/0RCaU9TPoJ5+xCHlCIQqb1FYpE3rknXifVH3NpOMah6fPuP3fFBlbSunPxUHa7klLf0wc5bRoGD7wcM0IDRVd4YaVpIxvVgJY6vVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIBV7iZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F8BC32782;
	Fri,  2 Aug 2024 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722602588;
	bh=633lVYjHNRU3EjRX/nYwTZxzcH0uaJwWa8OgY7HscFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIBV7iZTMmq2Z5PgLMx4dEAx7osuIAdcyHHr7XtgSLzBNk9EmyRGUtYBqZueJTlEe
	 Yoe4zkJ1Wrb641tuC/3m4R160s+aO55ZE7WCWJaV8kYmfIlUOStsdcG+3jLrJNEar0
	 Fo3MSS4pim+5DOwnj2QWgU8O/YkI0uZ5V2Rf4VbFdEEqQqHaNCmSW+1UdBcdDU/Uwv
	 TGCS05qgKKRDDT/7E8y8pvO9RrptgjlbpjFZ6ue6nXhxV4VqlmcevKqfj5nOxdlMaI
	 IhP4nbGzfO5pcbmtBP+61scNwYBFnNSwuNDStJiTxN7+Zn7wmj0jMnCsIzMnhQXCa1
	 A9BF40NdLyTRQ==
Date: Fri, 2 Aug 2024 13:43:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: arm64: Correct feature test for S1PIE in
 get-reg-list
Message-ID: <7b9b3ef4-66da-4314-8265-5947998758e9@sirena.org.uk>
References: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>
 <86le1g19aa.wl-maz@kernel.org>
 <811ea0eb-bc87-4ac3-8bca-27c787e43051@sirena.org.uk>
 <86jzgz1eqb.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eCayuY2LI5Ibm307"
Content-Disposition: inline
In-Reply-To: <86jzgz1eqb.wl-maz@kernel.org>
X-Cookie: -- I have seen the FUN --


--eCayuY2LI5Ibm307
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2024 at 10:00:28AM +0100, Marc Zyngier wrote:

> Also, the test predates the generated stuff by some margin.

Yeah, there were still defines in the main kernel source that were being
retyped rather than shared previously which made me wonder.

> Mark Brown <broonie@kernel.org> wrote:

> > I'd certainly be happy to convert, though that does
> > seem a bit invasive for a fix.

> Not for a point fix, for sure. And if you do, make sure it is entirely
> scripted.

When you say "entirely scripted" here I take it you're referring to the
list of registers as well, and I guess also to the information about
what is enumerated by which ID register values?  I'd already been
thinking about looking at the latter bit, and possibly also tracking
wiring things up to traps (though that's only relevant inside the
kernel).  I agree that seems sensible, but I do think we can usefully do
things in stages - even just replacing the magic numbers with use of the
defines would be less error prone.  It would be great if we just
automatically covered every sysreg we know about in this test without
any manual steps.

--eCayuY2LI5Ibm307
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmas1FYACgkQJNaLcl1U
h9DpJAf/U25LzOtlHywYKGpxk73rxEA/68hitfX505a0+ZlIYHFFD6RqH0x+Kw/A
ngf/3/BlP5kbKJ2pOysyUlh0RZWCei3IAToZpAINczoiNaEvXdpe+cZgi3nQUAL+
DZmG7uN2og56sEGReLy9bUQbyjretNRF//+7Og6186yXBYenL4rNlDUB0CikT9sT
Aehvs+6RWM3/DQCi0oGm4LoLaf64MGlFFYMw+6mA8N4aPYWEwxkiUFdd/NOHhJ0T
PifGAPV3f6fFosjPtUsPS4por6cHubvXl/s67zqwbMKS2pxfXIk5GTGlI0h+7+GU
V0VrWdmAtowwcrU+Mz6h1EHAmjxDAg==
=ERtX
-----END PGP SIGNATURE-----

--eCayuY2LI5Ibm307--

