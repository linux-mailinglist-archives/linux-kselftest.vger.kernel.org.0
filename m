Return-Path: <linux-kselftest+bounces-41621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33525B5A457
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 23:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8E22A01E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 21:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04376328588;
	Tue, 16 Sep 2025 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqkHM2AE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F5328572;
	Tue, 16 Sep 2025 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059674; cv=none; b=lhUv6MPut+++nmnN/fzFPCFzxprD8rm50D4ZWad8OW95V8HPPR9slBulw828zc+6cXgyVplWfeDBo0jdnIkO3Ci8kLxq0GUp5CJMEDMLDVvwkmyMdKvRwpkz9zoOzLGeFHxM48e8gnGQLkvx5lig6o9CwWXKcwHOAh98aiVsD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059674; c=relaxed/simple;
	bh=4alxzrUdOK5CtjJJqQwPxV2gCyf0hBSdvjtFuyZab4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9mdAhedCx9AiuMQTG1y4EBBOGfIee7k+wi9yIzgSP3zWu6AHblvJCmpooptgB4H6CUqyyfVrW+soqbFepCXaak6Ak9vMxDzZwMk84+kpMQ07geb9LUmPGznINwMAyHDOW2WFLAey4ZnHN+NMh4+5PHQVNEgHixlnvSrRjnTJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqkHM2AE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EAAC4CEEB;
	Tue, 16 Sep 2025 21:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758059674;
	bh=4alxzrUdOK5CtjJJqQwPxV2gCyf0hBSdvjtFuyZab4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqkHM2AElvFo1Vqq/Rh2bjQMcAEERYu7c5C2fACPhHmXNYCbIxyUddnL9b6n4fueV
	 Fr4KCV1HLUM3XhpMAzkRRpctAFMhkU9kCzlcBtp1NS96Zzmi8ayiQxC/VU6qTP+LNO
	 h/VdnaoSPV3ahJyHxZ8V1py3XzMkDN44689Sr1O3TkJMiCoYe0wQQCRiKBeOrViv4/
	 ybymEkJ8FymTHWJ4F3csd2DYCNF4+DrBtr/KhnUL/Z30Oz3PZmLyBVyyT8WKeAcjp2
	 xYrsD78cUbdHeMTYPIaw8SVweg7GaJO4dL/m7txn47ah4yk3/lsAAnbkE/tX7OPkZE
	 ywa4zhpI+zP7w==
Date: Tue, 16 Sep 2025 22:54:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/3] kselftest/arm64: Add lsfe to the hwcaps test
Message-ID: <73cba923-facd-4c9a-a5dc-2413ef8b055c@sirena.org.uk>
References: <20250818-arm64-lsfe-v3-0-af6f4d66eb39@kernel.org>
 <20250818-arm64-lsfe-v3-3-af6f4d66eb39@kernel.org>
 <aMnTm59nrA5lBxN5@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p8SWN4j5J2YR9ElS"
Content-Disposition: inline
In-Reply-To: <aMnTm59nrA5lBxN5@willie-the-truck>
X-Cookie: The people rule.


--p8SWN4j5J2YR9ElS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 16, 2025 at 10:16:11PM +0100, Will Deacon wrote:
> On Mon, Aug 18, 2025 at 08:21:20PM +0100, Mark Brown wrote:

> > +	/* LDFADD H0, H0, [X0] */
> > +	asm volatile(".inst 0x7c200000"
> > +		     : "+r" (memp)

> Doesn't this corrupt H0 without the compiler knowing? It's probably
> easier to use STFADD.

Yeah, that's more correct and easier than specifying constraints.  In
practice it should be safe as the compiler is unlikely to use FP in the
instructions it generates and it's a caller saved register.  The program
is in general not careful with constraints.

> > +		     :
> > +		     : "cc", "memory");

> Why do you need the "cc" clobber?

It's overkill.

--p8SWN4j5J2YR9ElS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjJ3JQACgkQJNaLcl1U
h9AdSwf+KQSnGogEd+URgYtj9MeVv6Hiw0FX45ZsYI85Bi0KOmP+Nu9Tw1jbTfsM
JgVvX+UfLVkSnmDHbdvTT8KSJ92bCk7p8vm/liTHygyQmmYVXaQMoVNGLdkCngtH
DcLWwf6FKzeJfp5wO1nM7PR36ITmX9H8DaTszOFPzbzpcy3VKkJ5xlhB27Lpehav
NBfz3XpkdnZpyxwdE1fsHwiQE6tZC5uesLXRt7gDHrFk5jI4OhmMYSyg9PfR39f3
Z7qrEp8pZM6JNQcHpkJu+W7KLwGe/AXXj2SYjAy0uHfciTEUYIQBwj9+vmY6NdYW
8hTyvGXk1ls7EfGSbDIGjGSZOzKkAA==
=0H3m
-----END PGP SIGNATURE-----

--p8SWN4j5J2YR9ElS--

