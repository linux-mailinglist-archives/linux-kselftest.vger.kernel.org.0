Return-Path: <linux-kselftest+bounces-16784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72959660BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 13:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F2028B1A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720E21922F4;
	Fri, 30 Aug 2024 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/fpZaXl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47273170A01;
	Fri, 30 Aug 2024 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017351; cv=none; b=G71X4aWjc0+30u/vpKxoV18FI3RaRQvKxh43BmgCKsEtCFFljTbv4c1uJEOdeMmi23VdDMbXAHCsqjzvriSHmsEi51kF4GrD1Di3mDLSknfTJiP9LKSvWX/lLS6ipr54KxfN0uBYOBa7q1VN73k7qY/RA0Hx7FCRRdJY6JLOyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017351; c=relaxed/simple;
	bh=+0oIB5pGRfMUNAhdXZ+MJJrJHp6SdwfGK04XE55ZJk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skKNfnVy3LN/je7hdk/P/SAP2p7uW3vEeV7wQQeHU3LoY3PeToa3xoYTVAs82GSdcNLWjMxwrdySXIa03DLc3afaymuuEWeXmcFI3VX04HQtDvHP/LKITTtszLRnyxd3+YolGWbvc41AK1xj6OY1x4tEmuoGf1BipinMCTZBbCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/fpZaXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9039CC4CEC2;
	Fri, 30 Aug 2024 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725017350;
	bh=+0oIB5pGRfMUNAhdXZ+MJJrJHp6SdwfGK04XE55ZJk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/fpZaXlKr8aI9RA+3656UcCGYs1gP3mf3FBgRA0KAgSJaR/xUG4tt0N8xUCCU5uw
	 MOIqILLutWg16NqbGPKadXIvG6wB6p0JZc+hydKrie3vjvw0+MTbI/S8jp3dajb5N2
	 2nK3mVSoBmjhZArBrMhWMcaR0AvwIO6mPncuhsZ3fJ+aORLe5gnLyzOoVvzJ2PxL7o
	 hArAeVR0fpWhyCs77wk1b2WBhgRWHmSfch9v7PH2HkLinGc8d4hdF1V4xRgKXKyygv
	 JotmbBBSd5Vmh8t0UO17FGSPKCHv3GyJ3Cxjd51nRyzH1axdmhXiE2xnrU1BPauK7e
	 G1tUP4cmZksUA==
Date: Fri, 30 Aug 2024 12:29:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	will@kernel.org, ryan.roberts@arm.com, Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix build warnings for ptrace
Message-ID: <5490390f-208f-4dde-94a3-6a2b9481e7af@sirena.org.uk>
References: <20240830052911.4040970-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="12Nb1XZkOew6N80K"
Content-Disposition: inline
In-Reply-To: <20240830052911.4040970-1-dev.jain@arm.com>
X-Cookie: for ARTIFICIAL FLAVORING!!


--12Nb1XZkOew6N80K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 30, 2024 at 10:59:11AM +0530, Dev Jain wrote:
> A "%s" is missing in ksft_exit_fail_msg(); instead, use the newly
> introduced ksft_exit_fail_perror().

Reviewed-by: Mark Brown <broonie@kernel.org>

--12Nb1XZkOew6N80K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbRrQEACgkQJNaLcl1U
h9D8hAf9FsqcmGydocsaV8mqD3tYKAOHYeztneMnmSZ7oYeeU0FZ45qRw8MCfqWk
aLusvWpgqpN+sRU9ksRSWXYfQW5WUrt3iR58/auhTxpn83IDiWJ4fFSbyNhzeLBA
YyrLtpT9MkRiCn5pWpZMKDM7er7vXLRUNz971mE5iBix//2FmmanHsRBZLy4DSSy
0wSArEVKzdPLSAm8pNwemm4BzqLW8O5j3iM3hQcqUW0LbhhXR5WvUX9DZ1isKs4a
fMli0OvKMwki9TbWtpWQpRi0lv4x57nw6DUSi0O7P8jDXJlMIQC6n6g8oXIrvj7m
l3ZA56LY3P4bK/y7leipiO3j2R+jAw==
=7PNF
-----END PGP SIGNATURE-----

--12Nb1XZkOew6N80K--

