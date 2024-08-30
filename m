Return-Path: <linux-kselftest+bounces-16829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FAB966675
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8811F2244A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316CB1B5EB7;
	Fri, 30 Aug 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGlscV6f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557E4D8AE;
	Fri, 30 Aug 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033952; cv=none; b=WgFPrGB0hdWRbqGePlC4n8GiZp3qXLEArwMf7Be7POxFQ3PmLo0ByarrRqotOoOGvAdJ2Rm0ndom6vDaSMmTdosEZvb79mVT6Us3YowWNneG7hLWnMfMiEiw0xGBWkUGGjCiKJkpgK3WBJOiunuRZtG1iLOV+TAJrNeyU+GqB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033952; c=relaxed/simple;
	bh=hPFUhjw5gI4fOLO11VdO3KMneQthkDLz5gusV0BUkCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcpqfzONZ+WTPmu4atCVrTVo10XnI8a11HLgiltrRNZh3YhpqopEg9JAo0lq7h3/MNriJn6HeVlfs/KBEviNUT4/N6UFtExDT34PJUjYAQcwpyeNRotcY/CjIewi5KjGt9OKUQJZCSjQnZFrjjvlHOuj0+WFWid0nllk7tyOfIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGlscV6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9BFC4CEC2;
	Fri, 30 Aug 2024 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725033951;
	bh=hPFUhjw5gI4fOLO11VdO3KMneQthkDLz5gusV0BUkCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGlscV6fnr+bsWWbxSc4cRFAzOjpYfo9oBFohffP6YmNiMrDzyqKBL7fl7cfqUWWB
	 6vQQSSGMhjsxjGkMrGDtDm5RwgZ8nRPnwj7MwjtCi3fGcclPrl1FW8EeaRBS0V17+T
	 8Q3l3cn7wR18ivd8QGrofy3CuzvJ3MqaWyyORbE6gvNhhR9r2hqrOec0FermNRanm4
	 rjXHqYUnobYLfKfK30+52P4A5hVoyuZ0i3/BD/UdVHpdlGSD7U5QAJ13ELcPalAbEn
	 mqfkkHzpgcYA9hNvwJVr0nwOAN4NrrW2cZx2cJ4+XiUIBJfM6NDSbpAuaQDPrvvgh0
	 h0wgL+jdho4sw==
Date: Fri, 30 Aug 2024 17:05:47 +0100
From: Mark Brown <broonie@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: vDSO: fix cross build for getrandom and
 chacha tests
Message-ID: <0621305d-84d2-4943-ad6e-9d951dd7c337@sirena.org.uk>
References: <dd1d8f71-28ab-44db-819e-90aff2f9b9be@sirena.org.uk>
 <20240830155513.493854-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8fs4vNpe0ZDZ4xN/"
Content-Disposition: inline
In-Reply-To: <20240830155513.493854-1-Jason@zx2c4.com>
X-Cookie: for ARTIFICIAL FLAVORING!!


--8fs4vNpe0ZDZ4xN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 05:54:35PM +0200, Jason A. Donenfeld wrote:
> From: Mark Brown <broonie@kernel.org>
>=20
> Unlike the check for the standalone x86 test, the check for building the
> vDSO getrandom and chacaha tests looks at the architecture for the host
> rather than the architecture for the target when deciding if they should
> be built. Since the chacha test includes some assembler code this means
> that cross building with x86 as either the target or host is broken. Use
> a check for ARCH instead.
>=20
> This also handles s a small complication in conditionalizing on x86_64
> but not x86, which requires defining the standard SRCARCH variable and
> being careful about which uname-m substitutions are done.
>=20
> Fixes: 4920a2590e91 ("selftests/vDSO: add tests for vgetrandom")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Mark - is this okay with you? I fixed the issue I mentioned.

That makes sense and appears to work for me so:

Tested-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>

--8fs4vNpe0ZDZ4xN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbR7doACgkQJNaLcl1U
h9Bjywf/bljJf0m8w53LEEJzT3nwEaWM3bi7hfEI3ircVPOEnWyz+dDa2oYUiRGN
3RhjETieiV7YHuScluKXkD7gSJOTU7/GR2t+eGkOI7+6/SGePU4kIjVOmQvFd8gP
ec8ZfVLTeUmiNz6uqMbqYGUXq2TG2LyGlbgRCP5leIoIWv/JgnrYi65L5Z3KWA3Z
RQXCCNRFHv5A+PkNQx1LaTTQqCODj7N4TnEkVIvwNhbGQckTWTukgJ30BGAXM9fI
zkdkhidNSZ6bKmVM7eygEeEtsBiaNsGFZdBdb9QsdjLI9Gh+ZxfSjCgjHxn1GxT/
tP2PX6hFjCjqM5fAKZfbc+4fcqAlHA==
=O4K5
-----END PGP SIGNATURE-----

--8fs4vNpe0ZDZ4xN/--

