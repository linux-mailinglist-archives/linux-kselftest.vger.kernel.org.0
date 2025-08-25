Return-Path: <linux-kselftest+bounces-39854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E49B34602
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159CC1885430
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781A2FD1D7;
	Mon, 25 Aug 2025 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7dnuw1w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB922FD1B1;
	Mon, 25 Aug 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136286; cv=none; b=HClwoZ3Be8p1dnSsoG8CWlE3Z8IAnc7eSc+8/L+4o+nhPetEv/ibcyoz8Cv4SJ+0qAIX4/VuOTmdpBV63DUVxieuNVv7QQTolJ2KZrNsn2FRmbxYGIhgMNQY3QQeyYeeHFMqTYsJg4m9zGFFGV+E1t3zZnHgnhlF8RQezGBB8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136286; c=relaxed/simple;
	bh=8dSso2N5KSmgLAtF6av/17DEDuEYDtbG1/oPAIfoiKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8iWwFwFuf5KD0QVF/rmqz+07w0yVmAQinJSJn14seHeTwtKLCNtRrYJSPOjERJzomA71EVyNbPa38TY9d5vr+XCQGq42hMopgRIetqaSvvbFBeIwjBZLA4rfo8OelkapsxaI7kMpKqWODhviFcqWkDl63PgqXJ2tDf56EF0fT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7dnuw1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D9DC4CEED;
	Mon, 25 Aug 2025 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756136285;
	bh=8dSso2N5KSmgLAtF6av/17DEDuEYDtbG1/oPAIfoiKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7dnuw1w/7MAem+AcLipOzAy0iCDUH7w4/SZXtFKRKsqZZJO2yeqW0wyYd0G1i42h
	 DfRZNdI5NHreSJjkOmj3LSlewz5Y7TcKmqhxV6P+SWJkRBKM2wQ0l48LrHvSJ7wTun
	 5SrD9iAZNhItWJ3tPrkNqRDuRQ3ble0YbzwYeEmulYrKY1R5x7KZvnWtktzDGJDXTj
	 XERIdtUaRD2on5rAuMD04elNh7XXjibF8yZLf7qANzMqeC5+OtTS0Nq+UIGa4r6GnR
	 w4PHpS5KN/fk81JazgwrWcCy13+pfrVy00v43ibaGCNpEsnX9JcfGupQFGPB4efdr4
	 ifYM7iNhRRDzQ==
Date: Mon, 25 Aug 2025 16:38:01 +0100
From: Mark Brown <broonie@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
	ebiggers@google.com, martin.petersen@oracle.com, ardb@kernel.org,
	thiago.bauermann@linaro.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/arm64: Fix typos in malloc return value check
Message-ID: <aKyDWRkgv-BAtuDc@finisterre.sirena.org.uk>
References: <20250824131647.490439-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="miGEQnQWrbritfVa"
Content-Disposition: inline
In-Reply-To: <20250824131647.490439-1-zlatistiv@gmail.com>
X-Cookie: Filmed before a live audience.


--miGEQnQWrbritfVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 24, 2025 at 04:16:47PM +0300, Nikola Z. Ivanov wrote:
> Fix double "-ed" in malloc return value check

Reviewed-by: Mark Brown <broonie@kernel.org>


--miGEQnQWrbritfVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmisg1UACgkQJNaLcl1U
h9ASfgf/YGmdSiL8/P92y//a3VVs5MwJXjfBPqxoEYDuK+QDU7k3D/eZ5UdyAuP6
lpxJgjVLT23t/D2DLtfcjpfBEtfbs2iEz7gRMALdMqEM8OeVZfiVqGygYiCT4ggM
zPGq8BSie2C3C0SNP5z219ldAPWl2bLLF6RqqV6RtaZWXpuf54VBGblB2+cTp+X5
OqOWOjf/ese9TE+bNTO+cOTm60SdJanRrBGG69YPvQfWGdKsBBE3yTxE5JHK2E4L
Qbvw4tFGrzQfqYb+FWu96LFETn9Mpg0cLybpJgXPBt8hcmjXcn3n7KDI7D9GQiOq
8OvI3cKjYTPX9tWlyh3T49v6HJ/EMg==
=aEbu
-----END PGP SIGNATURE-----

--miGEQnQWrbritfVa--

