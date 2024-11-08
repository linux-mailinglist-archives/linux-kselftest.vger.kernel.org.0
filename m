Return-Path: <linux-kselftest+bounces-21685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59109C1FE5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824371F23120
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB591C9EB9;
	Fri,  8 Nov 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPTMClML"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0617BBF
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078084; cv=none; b=PzCU0HZUnG5S/L6Zj33QcygJaPuRn8y+0XUem+FZaL0M0f6IODQoSr6ALLg/akgupX894B1IzazqOZT1BcswlUikjh8BURc7rYIl3nobFKnDXZu4/q4JFeiNy5KOe+RTk2/EZr/Z1RZzWnQ3p+rUcibBN3kucrTibL6TqKLdUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078084; c=relaxed/simple;
	bh=+GtWP8s1H5yuCjJ7iApCzWEGb6NjIifbIiaQZVF1NCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLVKiAe7uNVZUe1vePV3UqwpQueI743ocjU5I9+qBhPoSl+ExpTRJafPotXRvecLjnTHXAQyT3IXGLUJ8nBgJxjlJgcZDMkB0r7XBL6DZ4tDl55xrLGyeO6RkNgFtFzr0ZaeOdruyqb4mJ3A7mtTLFYqwEZ+VeusfiOjqMM64jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPTMClML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1B2C4CECD;
	Fri,  8 Nov 2024 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731078083;
	bh=+GtWP8s1H5yuCjJ7iApCzWEGb6NjIifbIiaQZVF1NCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPTMClMLXm5Gwd3XSKD4vHlV38lSfghRD6k6lpJCbMCXkcofblUuuq/GMog12pigZ
	 YUEn+DkaVvQyZ0yvH+VOpy+w0BCh8689Y/RlaY+r4gYEntoAL7IjpaGS/P9SUN77Rv
	 dURQx9nUwcykIFcpuMDtzhZ/Ud9+fG0fqxUVg9lmEvHGMxkXotY120eZjUJiidewTQ
	 t/hmuEqCE9nt6Qa3Id4bXS0gY2uBDNTyYUTmJSSTJ9nqWiKqxsfIBJJZiQPl4QwGVR
	 xFEPbhvX7ArtIqsYJl2lpV7TIBxXjLoTXNOtIvp+jr7+BsRkUEczHxGMZwhTF+SP5z
	 a/847l5LqOdGw==
Date: Fri, 8 Nov 2024 15:01:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/4] kselftest/arm64: Fix printf() compiler warnings in
 the arm64 fp tests
Message-ID: <a5ef2d73-04ad-4b66-bdb4-e17161d9eb89@sirena.org.uk>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
 <20241108134920.1233992-2-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HMGxNV9GQjk2SStd"
Content-Disposition: inline
In-Reply-To: <20241108134920.1233992-2-catalin.marinas@arm.com>
X-Cookie: Do not overtax your powers.


--HMGxNV9GQjk2SStd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 01:49:17PM +0000, Catalin Marinas wrote:
> Lots of incorrect length modifiers, missing arguments or conversion
> specifiers. Fix them.

Reviewed-by: Mark Brown <broonie@kernel.org>

--HMGxNV9GQjk2SStd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuJ78ACgkQJNaLcl1U
h9CZDwf9HlAUKB9LCyBi3ZVkP9Z7lD2zuMWbfwXq1yJVEquBQCdXI4zS20j1KHt3
1pbyG0gB5HYN72zj90BdYA6QSjtWPFaMcWBMTO5ogTuP0blwizeu66VbcCm1EaWy
fNHNtV+h/8fp0R49KidMygqEPK8SOdmtWwYjHVPIc5kD9qQRhTTibanpl56diShW
NSPWn7932e8UEJN1v5ZkOywQksJHLPTdCJJQeh85NeyKc3LI9BEvGsUU5hM8INbM
pD7r3igLNnn7iL5raYZDPYIKIk4vD/Cg9PbK+T9yZaAghc/dadIBlSGdBoJTrWo1
2L/nh4OTHk0+SIuWqEoHTFWDUmITYQ==
=w5ZO
-----END PGP SIGNATURE-----

--HMGxNV9GQjk2SStd--

