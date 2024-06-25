Return-Path: <linux-kselftest+bounces-12701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F24916D53
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 17:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31C21C211B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 15:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854B516F0F6;
	Tue, 25 Jun 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo2hoIBC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62E14A091;
	Tue, 25 Jun 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330170; cv=none; b=AhO64ETjfNdZppZsFQA53BeyLx3zd20I5bqH0qvJlqL4z+NC8u6uCcS4E1+/TzGZrOaZO/meZqnZYvGeFUVSw1HUuLMLwA9KyzcRnNPZr8vMjkxRAnTkj00DY6YyGGDRhhd8RfLeYB4DC4gEP1vlP4WlgYrn2sMAV/ExrwWcxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330170; c=relaxed/simple;
	bh=K4dsrZ4qjfJdfMkEn89XSrclRqFQcQshy9ANZQe2l24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI5WwT0qg5aXoO5J1FT77KTH8weTWIHrsEEL6Yd4s0nVPFJ6qVuUlPbitIXrFdX/bdUPMgBRqIC7CeW2tfnaM/k9UT4GE/vsXtE4p64/YJvWdTj0YAO1kz/C+OAiNho31mn5Id8WDe13mbVjHeb0V3WAcM3ztAKE9S4bSK0Y7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo2hoIBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC58C32781;
	Tue, 25 Jun 2024 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330169;
	bh=K4dsrZ4qjfJdfMkEn89XSrclRqFQcQshy9ANZQe2l24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oo2hoIBCbLRYVt3TDK9ScWN9F79pbRgwiai3uNaRLNP0FT8QK18M4e/XTGIvjLWgT
	 QnZAoDXtZrfWMDBa+qJvI8lvOEpccWGqQB0oShHhEHIgoHwr8ubJkFi0uvLKkO7Fw9
	 SHfuXTsGBDqVfJEmINC64W2REJA4AW6ER24vuTG1lN2SarMJnKmqmLMNCQjntHGAff
	 JEF5pDUkPCUM6xDBY2reXCISFTuIK4+yfztRjO6ZKC6q3D9TUPqvCFUY1opVkK8yvD
	 sLhAFf4abXxjruF3tFw990/KCmUSJ9ebZ9Gi9OxuL3gdm0Yq32t0RMRKtgQJMzHUj+
	 w3x1B2rCBS9Fg==
Date: Tue, 25 Jun 2024 16:42:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	will@kernel.org, ryan.roberts@arm.com, rob.herring@arm.com,
	mark.rutland@arm.com, linux@armlinux.org.uk, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com, aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] selftests: arm, arm64: Use ifdeffery to pull
 signal infrastructure
Message-ID: <9e7157d4-bb3e-4793-ac0d-05cf67ff98d1@sirena.org.uk>
References: <20240625122408.1439097-1-dev.jain@arm.com>
 <20240625122408.1439097-4-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NmDW5cKBRO90m6ma"
Content-Disposition: inline
In-Reply-To: <20240625122408.1439097-4-dev.jain@arm.com>
X-Cookie: Results vary by individual.


--NmDW5cKBRO90m6ma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 05:54:02PM +0530, Dev Jain wrote:

> Use ifdeffery to guard code chunks meant specifically for arm64, in
> preparation for putting signal tests in selftests/arm.

I've got to say I don't love this but I'm not sure how much better we
could do if we want to share the code.  Though one thing that did jump
out at me was:

> +/* Not used by selftests/arm */
> +#ifdef __aarch64__
>  #define __stringify_1(x...)	#x
>  #define __stringify(x...)	__stringify_1(x)
> =20
> @@ -43,6 +45,7 @@ enum {
>  #define FEAT_SME		(1UL << FSME_BIT)
>  #define FEAT_SME_FA64		(1UL << FSME_FA64_BIT)
>  #define FEAT_SME2		(1UL << FSME2_BIT)
> +#endif

There's a lot of ifdefs around feature handling.  Could we reduce the
ifdeffery by instead of removing all the code just removing the
definitions of the features and the bit that initialises them based on
the hwcaps?  In general a stubbing out approach like that tends to be
cleaner and less fragile.

--NmDW5cKBRO90m6ma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ65XMACgkQJNaLcl1U
h9BkFwf/fcOohh/GWcR99zsvqMCPd/bJM+7iwbrTmUj5Yw/pqBvvvNZq5z6Pfwcw
QndHLlv3rAeorUyE6ymUGh8JilZavWb+7urAU5ozg0qmSzhUy/CX9qZg+e09Xw5p
7eIB3F5ffeb0UKn1iDZgOImCr2WxzgS+Zq8ykF67MNITfahwc9t8Nn5wnGTz+ZdX
XB7hIvm0Fk4XoV6+JyPP56HMsQ+PYNYlO5I3R1/PV6yTNofUWrowdmm0BUxUt8xO
OyaL3/TvOVzyZ9zNnJliOXdF2av5OeBDM9hjCCXTtNfDDc3u8VBIb4Fc8zZ95H0J
GkVeJvDv9vcDez7PkN7ApYbaFaI/xA==
=/ZuD
-----END PGP SIGNATURE-----

--NmDW5cKBRO90m6ma--

