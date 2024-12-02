Return-Path: <linux-kselftest+bounces-22672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743F79E01DE
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 13:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BE27B334BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF60F202F65;
	Mon,  2 Dec 2024 12:05:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584F1FECCE;
	Mon,  2 Dec 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141101; cv=none; b=PSVY/VpPX1zEplwZ2HSRtUyWUjFfZlWecQNQRG7Rfh+238zLm26w1Z+ybfkzlCSMegto5ci70caSxPdKCZRIwx8SDgYafRRZpiIjSVJ5ezPOk2fj6m9RYh33BVa7gpahzMvJKrH9PRn1B9YDAuVUU9RA8CR716wkCWJzZhMj1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141101; c=relaxed/simple;
	bh=3fgC2VCsjiFNi8y9u5JWWhnjpjAWSTZSe9/C8VYmkoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYwZwzBgMoy/h4V6J37aug2YLD+8u/ffWOfUBDK1gGNg9yhYrkB56o/TVek7ACbp68WsODGJX2Jmp4bTw2mwGa/Id8LIAM36SVF+F3uRKbj/2kIO0dTmNSdCa7llau4La1lgaFwETS6qX8KrjxpoUWWQA4cznldI5oVgoYJBFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 46D7A1C00C4; Mon,  2 Dec 2024 13:04:58 +0100 (CET)
Date: Mon, 2 Dec 2024 13:04:57 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	shuah@kernel.org, mark.rutland@arm.com, thiago.bauermann@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 4/5] kselftest/arm64: Corrupt P0 in the
 irritator when testing SSVE
Message-ID: <Z02iaXudPt42mby+@duo.ucw.cz>
References: <20241124124210.3337020-1-sashal@kernel.org>
 <20241124124210.3337020-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5C6mcP4K8z2tNCMR"
Content-Disposition: inline
In-Reply-To: <20241124124210.3337020-4-sashal@kernel.org>


--5C6mcP4K8z2tNCMR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Mark Brown <broonie@kernel.org>
>=20
> [ Upstream commit 3e360ef0c0a1fb6ce9a302e40b8057c41ba8a9d2 ]
>=20
> When building for streaming SVE the irritator for SVE skips updates of bo=
th
> P0 and FFR. While FFR is skipped since it might not be present there is no
> reason to skip corrupting P0 so switch to an instruction valid in streami=
ng
> mode and move the ifdef.

This is mismerged. Original patch moves #ifdef. How did AUTOSEL came
up with this?

Best regards,
								Pavel

> +++ b/tools/testing/selftests/arm64/fp/sve-test.S
> @@ -459,7 +459,8 @@ function irritator_handler
>  	movi	v9.16b, #2
>  	movi	v31.8b, #3
>  	// And P0
> -	rdffr	p0.b
> +	ptrue	p0.d
> +#ifndef SSVE
>  	// And FFR
>  	wrffr	p15.b
> =20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5C6mcP4K8z2tNCMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ02iaQAKCRAw5/Bqldv6
8mzMAJ412V6JjbuxcrchCjkJtPf4IIGCNACfW7cPJx2m3ROlazM0FJ728S145fE=
=cDPI
-----END PGP SIGNATURE-----

--5C6mcP4K8z2tNCMR--

