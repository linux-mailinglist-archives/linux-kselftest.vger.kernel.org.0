Return-Path: <linux-kselftest+bounces-21689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A39C2035
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8CA2848EC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D71F8189;
	Fri,  8 Nov 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBiZ2qTu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724A1F80B9
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078970; cv=none; b=Nq1/HIl5BoGTSEnWz6QCfYKd//0x1zV/+5MVHSJwC2cgRcL75tUjp8FOQ2F2HtXZTIXaBUIFMEoeUmTjCmOm1MW6/wkaOx2riACh4z9Lggsq+OLfW+bdudCV3oQ6G35URhHsz3+/hQq5h6tmYquFQSuOa0LxD/Xg3elYKrOV7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078970; c=relaxed/simple;
	bh=boaP+72vGDu2N8mwMvuNKji6ZLGbovIJOVDiOZbKVDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syYxBV/BjIUCfs0qOIFhiPhBlu2cZjAHUPKdd505QkhQQOhHigKeeuJDLmx9vOshO/y8dEo+YaH/5yDQ+KT5TjZGBKkQW8+cKsyo3JCVlUid+UoJQttlnkjx5hkjxsj5Xm3FDVukAKMBCaBlUg7laUvmrVbwMjKno9VVTQW9DT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBiZ2qTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6302BC4CECD;
	Fri,  8 Nov 2024 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731078969;
	bh=boaP+72vGDu2N8mwMvuNKji6ZLGbovIJOVDiOZbKVDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBiZ2qTuqr9S7NXtekxKU0twe+sq9tSEwuybuTSf+SKF/T0HEKL9kxhqIxiD8jGgm
	 c9qtWy0M03r2PhtM+rTP2Y4YalWXGMNVfnjzfObra841MtWDFetrgs6EANcqUP6ebb
	 iJd/GMg50aLBZflBIpuhwNLo1iwf+CIguekcuoqTVO5ibgbzaHQH9xSWxWMT3894rY
	 T7Z3Clo7gHHpR+LiAYlfCw+fkAmwi8Qx+pmm1wLpDAu8sfEBoun5lticTf0/dBs3Yf
	 IclDEHTS1AZid/xsfFJ3BEBCJ5qo99WKEnateU/7P42EwRiGPOthZoduxEsMjcoXpI
	 fYu+eR0fmR/Zg==
Date: Fri, 8 Nov 2024 15:16:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/4] kselftest/arm64: Fix compilation warnings/errors in
 the arm64 tests
Message-ID: <704d17b9-6426-4969-82ad-5b9d71dac7fb@sirena.org.uk>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
 <3f0b7891-7f67-441b-8ba9-ab302ac57792@sirena.org.uk>
 <Zy4oT2w63WGXBASQ@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qW3xC7n+7fxxxnSY"
Content-Disposition: inline
In-Reply-To: <Zy4oT2w63WGXBASQ@arm.com>
X-Cookie: Do not overtax your powers.


--qW3xC7n+7fxxxnSY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 03:03:43PM +0000, Catalin Marinas wrote:
> On Fri, Nov 08, 2024 at 02:58:34PM +0000, Mark Brown wrote:
> > On Fri, Nov 08, 2024 at 01:49:16PM +0000, Catalin Marinas wrote:

> > > It looks like people started ignoring the compiler warnings (or even
> > > errors) when building the arm64-specific kselftests. The first three
> > > patches are printf() arguments adjustment. The last one adds
> > > ".arch_extension sme", otherwise they fail to build (with my toolchain

> > Unfortunately there's a lot of toolchain variance with these warnings so
> > a lot of people simply won't see them, you need a fairly fresh toolchain

> But we should still fix them ;). I tried both gcc-12 and clang-14 that
> come with my Debian stable installation. If we see others, we'll fix
> them in time.

Oh, we should definitely fix them - it's just I'm not sure people have
been seeing them to be ignoring them as you mentioned above.  AFAICT
nobody goes on warning patrol in the selftests with any degree of
frequency like happens in the main kernel, nor tunes the warning set, so
they tend to build up in the older tests that aren't being updated as a
matter of routine.  You do sometimes get someone coming in and doing a
round of cleanups but it's sporadic.

--qW3xC7n+7fxxxnSY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuKzQACgkQJNaLcl1U
h9BvHgf/fd1AfPtGYuLGC1xc4cVPvQgobJiD1KwsSb8268zU9eJ3Ny1iB2T2u/Xv
6uvibBNVqJpnUD05wjkCtfQbFVeu7rWhSrsds4alo3Mc+1xagXENNvOkZzhv+XnJ
Ly2tqvd4H3bfMXrcW+N0Vecn381mBTEVyix4kzLqZfSYVgzeCYu6f4iwa3xOezr2
lQ4TGxy2BL4JSwyBO0FD7GWZY/hzTY5AqGfNPtRaTmxF9MwzUWzgnYZ8REayCcWN
+C8UNfEsbxNKWioGGU9vggbesKGCqE7vUIaeZ1PaIpgXb4715Btm7xtg2UUdabrD
psDKzQnyHA2SYqwnmLc7YoxfRL5fog==
=sgwi
-----END PGP SIGNATURE-----

--qW3xC7n+7fxxxnSY--

