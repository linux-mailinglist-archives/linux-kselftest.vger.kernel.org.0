Return-Path: <linux-kselftest+bounces-15540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71664954ED8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB13283D2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799C31BB68D;
	Fri, 16 Aug 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSET03Ak"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8C77113
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825881; cv=none; b=Pj9SQuPADEA8EW9b1m0eWtMJuaPkU3mLYfChSfCVmHV8EIolUIXbHqAEAF2za7RNxha0WtO+GBoW4DP2x7JAw3gfn0E9N7D3Jj6FfjSsBnmdYBiqWqmszilf/JCZr4WvNHkkaxJfXiPQ5Sr7djIhgq9RGNUtZDa/Sv+hDBhJrpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825881; c=relaxed/simple;
	bh=35IWzGvJpOWaAkRhjAOn+hxf3z8zXCPF3yav7OAkLpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw7Mbsf+vskVlAgBsOv93GwLU4CeLeUd8sFlN7l8RpevfVUFLFZcAUgxnyrPF6KQNxfUkdg49kaj1e25rlybb8E6yiZIQ2EVpkp0QzjkbvqvaJkm3G6O/wcNrU+lQq76ZScEsyh8dm4jKsEC3VHUO1FdNdHsGZDFPdUG05YTvJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSET03Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9B3C4AF0B;
	Fri, 16 Aug 2024 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825880;
	bh=35IWzGvJpOWaAkRhjAOn+hxf3z8zXCPF3yav7OAkLpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSET03AkZ76AuBiM94EKISIZRG+p6oMIXpkCusn9yvs1zzUYLeOHPp8fOmNVSf9zi
	 H96EwrlU4i7hJqq1r4SqiLgBllkdTKW1GWhgv7qAK7MkOg9q8xbheyusxZxUfxlBTG
	 /crXxzQ8j1sdYL3dtDfDmVssWd6MSnNo0ENsuOOBHU0qTOUtm6vIxdPzxgqMyMsi/H
	 GFlmqaipHu4RQcy7wAXYkvHyDhR0qEOt5HGtLgEClPkIKoalpnA8hefNrAc68051Yq
	 DXV5xIa2tj7hpMByJefnXZzLmuxGjxuhi4RFl25zPghOcRhrdKJ5w6Du6E2DdqXUPZ
	 Vw3gpRgnsd74g==
Date: Fri, 16 Aug 2024 17:31:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 6/8] kselftest/arm64: mte: fix printf type warnings about
 __u64
Message-ID: <123e3310-479a-43a0-8300-fdb6d0cd6c71@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
 <20240816153251.2833702-7-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4Tfnv0Dub9nBMib"
Content-Disposition: inline
In-Reply-To: <20240816153251.2833702-7-andre.przywara@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--T4Tfnv0Dub9nBMib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 04:32:49PM +0100, Andre Przywara wrote:
> When printing the signal context's PC, we use a "%lx" format specifier,
> which matches the common userland (glibc's) definition of uint64_t as an
> "unsigned long". However the structure in question is defined in a
> kernel uapi header, which uses a self defined __u64 type, and the arm64
> kernel headers define this using "int-ll64.h", so it becomes an
> "unsigned long long". This mismatch leads to the usual compiler warning.

Reviewed-by: Mark Brown <broonie@kernel.org>

--T4Tfnv0Dub9nBMib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/ftMACgkQJNaLcl1U
h9AfZAf/d7qvH/ITLGh3AG1sY5Vj+CKet+i5Irac12+G8+ClhnizTP0kHYbOyg66
2bbR7KeEz6b0r41A70208rDgk8NAs8cmEe+gxrJbSfkaLMaNkaoEJ4p14GmwwHkT
c5nmFmYmZWidff0oH6tM1Pl4REBjRwAOTOnFog5I1+7wqpi5DeSW1S6nA96D/QoI
a9+Jp8tF3s28E7An/RdwAg5xxe6IgMd9P5GlFilt10Q/sRweS8MExTFqPFeg/Dn2
mbACIN01L/oIrLqqYFpZar0I41WmE6Wu+vSBInrFDBMGOtKqK6ctQdRfy1ukzK1z
oItWAMPsdae6+2WTiEASRBbh3ArnTA==
=s+5b
-----END PGP SIGNATURE-----

--T4Tfnv0Dub9nBMib--

