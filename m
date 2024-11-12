Return-Path: <linux-kselftest+bounces-21853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E59C5693
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6331C1F26567
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 11:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65201FA84A;
	Tue, 12 Nov 2024 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9nO8jOw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2651F77B6;
	Tue, 12 Nov 2024 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410870; cv=none; b=HSmFrOr/4sEzIGRUMUgJoe9sBj/GATZvkbzJi1FEnQZdpt9pOPXFiK9Ky1+HHRbSESHAlLTdnetr15sFargeWN6NIvmtoTqWoQ9Ko2fTrYlp+z//XPPHpod6PYipPdirtAPhQQBDUr78TW1HfUchoSpJiYtEYjLGJUm8tdQa8wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410870; c=relaxed/simple;
	bh=f0VPYp2OO3whp5YDsd40TwogfCDX5tumV8g575tkc+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAG/4PMF+O2Zi3OpzVweHN1sfOZxQ9vTjMwAS46Ip9yE4TlNQix8HOvfAfXuhGKzst4UjxOlv+3HlfHlJcIVQ0eXCjJhyH0rnGfhOu5s1OGTnYVxUn+D2sux40NEG1lXnEhxl4FPjiGEC/mqRJv3TMujVswLGAmhe53OMPwqjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9nO8jOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B73C4CECD;
	Tue, 12 Nov 2024 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731410870;
	bh=f0VPYp2OO3whp5YDsd40TwogfCDX5tumV8g575tkc+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9nO8jOwGdE2eJmRA3VqYyeS0I/abCFyhLXCKxSVUtBqc5I9rp6fKuIQeWWgKUlQF
	 Yu9hfER2m48nJ7yoKInSMkfmDi4ozET6F4JiZ/caS/zH32FBGXCArEpWncOMj+Ae4R
	 iuP73/ZkYIVkIDGFKdw748sTjNVGbwLGUgH+DJSZWhsxNwgJM69dUgzgGtAbU+mBLS
	 ChDQAQnxu0R0jLxg2pCaUfYNzhYaZcjlcycaUcqUnzgkm+FaXMBSgozj+g+6apA74c
	 DW1ZL3dXrVuwbslORr9fG+ES/JukXbcg/bUjzmAu8YvcwkqHWUyu46kwtV0FTT4Jxc
	 J0gYYPn0sf7qA==
Date: Tue, 12 Nov 2024 11:27:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] kselftest/arm64: Use a define for SVCR
Message-ID: <ZzM7shsAlpOks5pp@finisterre.sirena.org.uk>
References: <20241107-arm64-fp-ptrace-fpmr-v1-0-3e5e0b6e3be9@kernel.org>
 <20241107-arm64-fp-ptrace-fpmr-v1-2-3e5e0b6e3be9@kernel.org>
 <ZzKUaqv_K-MRTti4@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gcR+M1ygfRDpV8Bq"
Content-Disposition: inline
In-Reply-To: <ZzKUaqv_K-MRTti4@arm.com>
X-Cookie: Editing is a rewording activity.


--gcR+M1ygfRDpV8Bq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2024 at 11:34:02PM +0000, Catalin Marinas wrote:

> I get an error when trying to build this out of tree:

> /home/cmarinas/work/linux/tools/testing/selftests/../../../tools/arch/arm64/include/asm/sysreg.h:132:10: fatal error: asm/sysreg-defs.h: No such file or directory
>   132 | #include "asm/sysreg-defs.h"
>       |          ^~~~~~~~~~~~~~~~~~~

> Probably sysreg-defs.h has not been generated yet. Too late to figure it
> out now.

We can just drop this from the series and replace it with dropping the
FPMR define that we did this for into the patch that uses it, it's just
mildly annoying.

--gcR+M1ygfRDpV8Bq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmczO7AACgkQJNaLcl1U
h9CHBAf+PPh7lLLzU6GxFh5DqMg1ZlACdjTyDjhV8GK64oD/SfS1snUL7DX4F4VN
7QOFaexuWZdXC0zQn3Ln72r9Of59gxIbRyK8X5mljc991QGuGZln3VyiBXcnPSYJ
HvLAX8eqp9q9s50l+Awsl7kC1WxpfLTpDtmsiXcyU2o3Ap5sCZeWDxrQgx08khRD
cTdiO0n29BH9BJtlhuQCSflcl2A5HhrmcC2F8p474Ms81OtGpEuw6Rc4A3z3juX7
8jsDaMGM+kz2y/S9oUbPj4ss50vbfkmM5C9GUmEuZdq67RrTSikz6nr9xejxzpXB
gaRlRgv5pzWJEnCH8AN4+A0qphOINg==
=igwC
-----END PGP SIGNATURE-----

--gcR+M1ygfRDpV8Bq--

