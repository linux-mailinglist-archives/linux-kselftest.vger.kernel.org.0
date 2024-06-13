Return-Path: <linux-kselftest+bounces-11848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A93906828
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F061C2162A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 09:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF2113D8A4;
	Thu, 13 Jun 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiWFGClQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8013D88F;
	Thu, 13 Jun 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269760; cv=none; b=AD9ca6Cn61iAnstxeKyhpD/BAWKRlJZ3z2tikmky8DBxSKtXGhg8XdpP5eiq6s9D4jNrJUnIMsHU95utShZuUulHg6l+rWuxX4uNMG19ePSfNXvjor5wK2RoEcYnU1x6EUr2xoFpRTo6/s5/FMyVJnS4pNXx5zQBbTPNH0dAG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269760; c=relaxed/simple;
	bh=gvcruUrcMDeZJuFMRXz2VyRLJWDOoLkAa4+b8US2yMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld9yz4s0bNcKrMumopx+3Bv1yhs7UdIpz0Ke/b3UWMLD1P3lQQeYCCTIP/nq3VCvqxTPqqv9mNX+W2RPwnLGVjOr4cseWaIn8rcwcaPmdc4T9awuJ188UX9ZspIIsNqJbacGdQZiXMAl/RX29voCwQSqgKl10063nk05G3zmXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiWFGClQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC5FC2BBFC;
	Thu, 13 Jun 2024 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718269760;
	bh=gvcruUrcMDeZJuFMRXz2VyRLJWDOoLkAa4+b8US2yMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiWFGClQ6hGbuMwXYi42jppylU1YplzBLvsU5R/h/nOJdCOxsLtY7lJhffZpDIp58
	 K6rtMIiRDKYW1smDv/B0PLPgxFPCFEItNn0gCDrh3HdUJ/RcqvYaA8DST09+m2wEtM
	 zB48DO0iUIAqP3/wZNzbQBoa+gSpbctI9C4PD29H5xn/+ccEKhboODiSdmYFWMutZT
	 QzDsCst8bL1GWhZnmYK72x97ob+PPqgmc6xJO9tVY99ndNxNPQ/+JuBN9p+Sl9ejJm
	 LU/vKTYSqhpm5yFMGD1xvGGQirjiM+r+Ix22AJ8bLECBjJyfJdy8nUXLwygOpnoGRn
	 hn4YSAaQ+w+NQ==
Date: Thu, 13 Jun 2024 10:09:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] kselftest/arm64: Fix a couple of spelling mistakes
Message-ID: <Zmq3PiVadZbhD7_9@finisterre.sirena.org.uk>
References: <20240613073429.1797451-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8CKz+sy497jdMZZn"
Content-Disposition: inline
In-Reply-To: <20240613073429.1797451-1-colin.i.king@gmail.com>
X-Cookie: Your love life will be... interesting.


--8CKz+sy497jdMZZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2024 at 08:34:29AM +0100, Colin Ian King wrote:
> There are two spelling mistakes in some error messages. Fix them.

Reviewed-by: Mark Brown <broonie@kernel.org>

--8CKz+sy497jdMZZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZqtz0ACgkQJNaLcl1U
h9B0eQf+PnE2rlgpH9z/1u3jvHef4njzwv/OqDsOOGNKA5D3fELa/dYUkDxMornh
hA7PHkeHRLdNPDMyE3r1WCTKUvQ4T/m6wU0l6At/94iCXMQ9o4YDMljwcWaoIv+9
InPw9qapOr746RF5JQwjpEkDVXsKSppl8s54OxEg+bhIbvqTzzYqeqEg18Us84U2
S/ft+2mvFEZ7oGCnL3E5HBpqJH4Z24XIlyp5ZfI/qZLveOFmvs9eLzRouIu38RP5
iKmskKJIPIw/4Kipdze+uDt6Y1dy9Lo/F/EVtFPBSGcCE25eUKEnLCsqbwrgzgyN
6urtb3b2Ktr7Le4popJx4KCCsaZxdQ==
=iImt
-----END PGP SIGNATURE-----

--8CKz+sy497jdMZZn--

