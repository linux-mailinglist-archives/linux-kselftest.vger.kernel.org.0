Return-Path: <linux-kselftest+bounces-21687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E809C1FF9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E454E1F2365A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF281D0400;
	Fri,  8 Nov 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzBg3XVL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FD17BBF
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078251; cv=none; b=UabR2A8QAOrdvOg0UFRKmsctw1XgeQaklQ2AnYruzFvDgE6NfJBB2ohATS5tPnwVVC5D8Y4ZPpU1H09zFpTsyo7G2+96TSqyxzYzpyKWY49GTyepnLOeVr/HioUkWsVxfwHtVkPISZ4YJX6GJrcASesvcg2bETo5WlsQUS6VXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078251; c=relaxed/simple;
	bh=6s2DosjfqDuLSyaiFlqd5KG4tRwfskrDs06O3YBify4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1XZBT5+NtC18627j2xXJfrJgmRgcrN1CqwRTMRivziWZanoOpMwuc/iV1tnP/j5GklgS9GIaIHy65lOjfmvtddoUiDTubRt+ieID+ViX7H13Bvw1KdV2k1vjmNLUIh/AjK20llevUjtdj3sipBysnKHUthtogE7EsNGK4YGr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzBg3XVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318A4C4CECD;
	Fri,  8 Nov 2024 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731078251;
	bh=6s2DosjfqDuLSyaiFlqd5KG4tRwfskrDs06O3YBify4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzBg3XVLJlLlqsW9r8hsJws/1aFY98ZXIr/OoF4Y1D05/tciEKo1xX1wMKwAZcp5q
	 OxmSmO5SBlyAmnTDGDwaO0zb9Ta0ooqfHgC+2Bb+Owh0QjggDBKMyqrjgI/TdwFRln
	 NFSbNEvRG5qfTXqireg3+geq9cU+NS8xok9e5iGQtQJtOMABm+qox0VHnSw2VO0KpC
	 Fix38bXZpBrbJ71qCpvS8ZXMO+23HSRDkJ1ueOb+WBXWgwvl5N4eZvRBTMeH1HwLfC
	 Y4wLPLFNI83TKHQfs3IkCC0QHEIYDNorYFMnyt6m90XYBEr5WZYrt2Sh37hVfk8hkn
	 IIACVmzcg4fSw==
Date: Fri, 8 Nov 2024 15:04:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] kselftest/arm64: Fix printf() compiler warnings in
 the arm64 syscall-abi.c tests
Message-ID: <0935d03a-d29b-4e66-a5f8-367b8274f375@sirena.org.uk>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
 <20241108134920.1233992-4-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xo69RfIwy0Aa7qeS"
Content-Disposition: inline
In-Reply-To: <20241108134920.1233992-4-catalin.marinas@arm.com>
X-Cookie: Fremen add life to spice!


--xo69RfIwy0Aa7qeS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 01:49:19PM +0000, Catalin Marinas wrote:
> Fix the incorrect length modifiers in arm64/abi/syscall-abi.c.

Reviewed-by: Mark Brown <broonie@kernel.org>

--xo69RfIwy0Aa7qeS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuKGYACgkQJNaLcl1U
h9D3fwf9FYkmX3JoIbjpbzljb2FSS8q+dlnkPkTVrCqtHFFu4mUWTeS4Hf2PBGEp
mug7ManyT3rH4dk/pRmsc+7AmXVjIhuothTUjXCanMn1/sNUMcA3OnY/Bg+7RE/4
QQfb5G3JLH8KZa2QFiCQtauV6lYmGEHDm6qGL8XnxQTr5WQxykF1IugOqHFEpTft
XeRZ9Ic6aSdpcTViU1n4gzT5xsICz8ZMIdyoyEfCJwpSDYWmQzUVRx323A6DgNyy
Jg8FZUC2xBXXPE4TgZyZACY0URKFD6Iy8egeysDecOv9NMFF7mARgEEdIwlJcatw
bry31dcAmMl2iD78yq25YvHRuh9anw==
=eTgI
-----END PGP SIGNATURE-----

--xo69RfIwy0Aa7qeS--

