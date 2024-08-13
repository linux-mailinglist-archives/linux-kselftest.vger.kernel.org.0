Return-Path: <linux-kselftest+bounces-15209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9BC950326
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 13:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCE01C21D5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86748189911;
	Tue, 13 Aug 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hita5IoU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE717A583
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546811; cv=none; b=DvQnDsgouttIgsJf358iKm70D53ThIAksgQHEY/OXkRfS3PrDCq+AVtcJrnEN2odYNkANgUllFMQ/PBj4JHHfpKbqgZBefPkoE5l63SAxJItdOB8hpJnLeAUsFecA9ehXOliU9W4w2cEtNdSVvUJ3X9iMKtaH6iPDxw6kSr8TX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546811; c=relaxed/simple;
	bh=Yq3U6hAaoF85rPHSeXqXTGctHUw6k8hPjnKraDtokRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfAArdZD+J1ZS3AL6t8Whawjspu/jUuSSK+zjhMUN4ehzXuh+R25Nop4pbxHWXQdCtb/csZtcwiyRd5WaAJBSyxSqZgDH96flZEjhTuTu4Mc/5Y6mBb9HlC8onZDWeD4beAIMsh2EQxMmPAAir58yu7lnHETsxW/Ho65HhBNyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hita5IoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6FCC4AF0B;
	Tue, 13 Aug 2024 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723546811;
	bh=Yq3U6hAaoF85rPHSeXqXTGctHUw6k8hPjnKraDtokRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hita5IoUbz98GJRptNRJs+pVwjjXXN4Yg1GdvE6TAzcsq0e7HlDijz02uFvVBPrv9
	 ocQZXTHQgtWwYduLQLWPCP5Z4zJw9M7wGa/pcE8LRT/fOaPTnqO4Y+JG3Uk1o+I5AQ
	 jUEbMLy0/n23Ghrnzo4BMF9QvsH2cbNab3TMl89az9wffGT3aGN2xKm7L7utKSovH4
	 JQPxDeUtmW0cLqfF5cJrz/fhwzuHkzuJZStkPST+jkgS2AssgAS6suCivWRJL5yhst
	 QszODAbiIO8xsy7gnefVTHBM4ATemphQMTx8ZNpvYIObCCQ577p5mXwtsiQkrQ0GBI
	 0+IuCkHIb5uQg==
Date: Tue, 13 Aug 2024 12:00:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: signal: fix/refactor SVE vector length
 enumeration
Message-ID: <561f31a7-6813-499a-a6b5-83bccb69a3e0@sirena.org.uk>
References: <20240812140924.2100643-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GH7guKdBC/s2eDnW"
Content-Disposition: inline
In-Reply-To: <20240812140924.2100643-1-andre.przywara@arm.com>
X-Cookie: Say no, then negotiate.


--GH7guKdBC/s2eDnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2024 at 03:09:24PM +0100, Andre Przywara wrote:

> +		/* Did we find the lowest supported VL? */
> +		if (use_sme && vq < sve_vq_from_vl(vl))
> +			break;

We don't need the use_sme check here, SVE is just architecturally
guaranteed to never trip the && case.  Unless you add a warning for
broken implementations I'd just skip it.

--GH7guKdBC/s2eDnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma7PLUACgkQJNaLcl1U
h9C9lQf8D3XDHBUwzhqd4+jPHYxA0Y8Do5ml1zAh0G4akZj1ZLQuepKZ6CiNpX7N
5kT33AvpzllgcOv09kFbenauOHPMShCG6leO0SvBkK/FR4uvgvSYl/Jm3oE37hu8
mR5uIa618iOoSAVgOPGJSKnJyMwLpzLq7aJdqQelvOK5JTpyUCDfKQ/RczCRC9JC
KKtBZ6BLg7Jf9G7X4SsG1q0CQmI6I9n/+VCeQqpuYi1A29fBdjt9ikRBQGFpcQN3
V/Emi3qfuJR56fulgqfV4nlJ3zsg9J0jWS5NAr2pjRRwCTQMPz8w8oCfdJ5vKCCa
NZmMhV8HGMI3e27wKW4052CIBnHOOA==
=5Hbz
-----END PGP SIGNATURE-----

--GH7guKdBC/s2eDnW--

