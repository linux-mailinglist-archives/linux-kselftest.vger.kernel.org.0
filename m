Return-Path: <linux-kselftest+bounces-23034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576E29E9462
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 13:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DC728478D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36B22488B;
	Mon,  9 Dec 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFQDkCw6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC82236EF;
	Mon,  9 Dec 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747816; cv=none; b=hlzeOVH9uQGCGQdz9QVZQZZ18BjS1JV6s5bl18WQVFUEZdepvvf3eStLfuX3tbKgDlqEoHbLlcTM2YIfaS0+o7DCrcY2lH+1kAOQXJf/JKAGSpyhNASPzwu5DCJtCsOVZhjxUuR5k6FADIH5lHZKkm+oT7fb26WSu+seWDteNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747816; c=relaxed/simple;
	bh=fU7JocH+KX+BzHCdE650z9D0sioBzhAoJR1baPJ9Ngw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZKQ4Wf0m+Qc4/X+T6SUAKOpbstU0vXLyW5lwBs0KloRkVOkaDTJ67uNyVxwbWxzDo/5FJ3Lk0WBG7crXfMJ9A6PWLeuvDGXmJzQsn7FSEdE3Kqy/CXIc5prexKGPXorNG/FldZMIMJDtpONpQCO4ZAhGc3ehS4FL+nL00ZW9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFQDkCw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8883C4CED1;
	Mon,  9 Dec 2024 12:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733747816;
	bh=fU7JocH+KX+BzHCdE650z9D0sioBzhAoJR1baPJ9Ngw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFQDkCw6uBL0azgpIY8eUxNjE6YkBk2azrXe9L+McetcdErtE6/yzZQW1KGkzae8L
	 EIZBNnBm1PTpU8QSOnGTKBEZT0aNQu3tssVIncJExa/mw+gvQS9DnSARFC9D9OaxVS
	 NtMDcw5wdgC6wOgUANPjmm/caAZHx7TL/11Ko3Va4Fp4lHZUVATq1iR3QYtrobj6Q2
	 3NdPqCF+i3f/W3gcallgUb4xTK3JozQOL/SeO0R/dFPRxDmJt+m8YgR1VtwVctYEYl
	 AawGR5NwXDhN+K9nj88MOyISvhxsvxbyKlj8I6fl9aS9S10ttHHz3WMGLpWaoyhNi6
	 P02TeRc1FHPgQ==
Date: Mon, 9 Dec 2024 12:36:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: abi: fix SVCR detection
Message-ID: <3279e669-1ee2-4792-9e10-8b40928de6b4@sirena.org.uk>
References: <20241209105237.10498-1-o451686892@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="niIOaNVqrCdk9TWd"
Content-Disposition: inline
In-Reply-To: <20241209105237.10498-1-o451686892@gmail.com>
X-Cookie: Lensmen eat Jedi for breakfast.


--niIOaNVqrCdk9TWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 09, 2024 at 06:52:37PM +0800, Weizhao Ouyang wrote:

> When using svcr_in to check ZA and Streaming Mode, we should make sure
> that the value in x2 is correct, otherwise it may trigger an Illegal
> instruction if FEAT_SVE and !FEAT_SME.

>  	// Set SVCR if we're doing SME
> -	cbz	x1, 1f
>  	adrp	x2, svcr_in
>  	ldr	x2, [x2, :lo12:svcr_in]
> +	cbz	x1, 1f
>  	msr	S3_3_C4_C2_2, x2

This is against an older verison of the code so wouldn't apply now.
It's not also checking the value of SVCR, this is checking the SME flag
passed in via x1.  You can see that the SVCR value is loaded into x2 but
the check is against x1.

--niIOaNVqrCdk9TWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdW5GMACgkQJNaLcl1U
h9CFGAf+NOmJS7zfKX8ub3vY7iK8rhpg37EQQlYcPuE5fAkhIyUx6eKqtobU2FzL
fqnPOWvkobsArRBSeUAIAUnahlqn2XNQKGX3XuJHUTnt24IARB76rpGRhXKl5uT4
6JZcTLddrNKi+/B8j+ivLp8iGh6O3u6Hxi/U6f/QsYULh3BABeWsreagh41iDhqx
wLas3NT8PgfnYd3BttsCgrjv5/xjNmmnnj+K17+9/PqIGi3gjeXWFbxRrq01e6dN
pVXbZHt3UzdpanqVZrR8zdhbqyFBjuiZuOI19FlCB1bMyBlk4uYJpT/GmGfnrbag
XMsQsRcBRxkBArPtfXnhufY1zxRm1g==
=gU9c
-----END PGP SIGNATURE-----

--niIOaNVqrCdk9TWd--

