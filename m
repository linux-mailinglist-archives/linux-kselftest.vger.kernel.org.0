Return-Path: <linux-kselftest+bounces-48428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0058CFF94A
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 19:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5A5D300463C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 18:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231F34D92A;
	Wed,  7 Jan 2026 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLtdKPjD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BA3A0B1E;
	Wed,  7 Jan 2026 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805175; cv=none; b=U5y+SJkC6b4gEBOOZTi22rz7W4hjo9YMHE1nUmgp9OKPkgC3KKchq7R4sRXn9mhRlxlXw1/bwuEDXIsmG2eYrQT+GfYT5pYXtET+kffhcnYgVlq9b0LamILCwRflUjekHjMMz6PnZ2sa1CeEbHoCaMammwf/FmLTqqgqJlBysW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805175; c=relaxed/simple;
	bh=HwEX46v431f+sbGo5EqxgnUwfzroRLeV1erewYphpFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0Kfpi8qCvkhRU0jgzVN/wfJw3yF4vkUhqXvsXGQ21VrFRN7gU3DstaXo7IByHyJKCRkmObRWkJeo1hGbRWjcdLE1K2h0Z65/J6LxtbwRppq+XMb+kpdX+/lwLJjFcun2v+jdmGgT9siyUsz/RYMZibiGj0qTrVsQvQTBwuGt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLtdKPjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FABC19422;
	Wed,  7 Jan 2026 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767805174;
	bh=HwEX46v431f+sbGo5EqxgnUwfzroRLeV1erewYphpFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLtdKPjDsjq3CIydu0nCMpF4xRX3a55iYS+c9WgEvIR/u6j3EKWGkGLeLWRiajwpS
	 H6u1dCYqeZPV1/Ux2QI8IdGPfJuejyK9Mt0fTfD/JeNjo7JHyp3pzzLFeNN4ks5XZ5
	 7vWfdHNcpXdGvYSU9u65pPhUzx1omRJREpdghlBG+Q25jcki5mYF0ytTjZrPFnEXtT
	 FNW+qmTeHDbLxEgNbxQ6J/z53F1JwlmkXotfuFM2Wm1oTLUffAm4FwXJMd/QQYf5J8
	 MLQYMW3L7Et0Rjy3GA2p/FA8V315OhSzmnnSFop+/ETv3A0XHAt8hIHXTGGO9EUGQk
	 zCntVNjC0MKaA==
Date: Wed, 7 Jan 2026 16:59:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 3/8] selftests/mm: pass down full CC and CFLAGS to
 check_config.sh
Message-ID: <b7458982-ec26-4057-bd4c-0609d177ae32@sirena.org.uk>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
 <20260107164842.3289559-4-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rXNMserVLWCKQhmh"
Content-Disposition: inline
In-Reply-To: <20260107164842.3289559-4-kevin.brodsky@arm.com>
X-Cookie: Truth is free, but information costs.


--rXNMserVLWCKQhmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 07, 2026 at 04:48:37PM +0000, Kevin Brodsky wrote:

> Remove these assumptions by passing down CC and CFLAGS as-is from
> the Makefile, so that the same command line is used as when actually
> building the tests.

Reviewed-by: Mark Brown <broonie@kernel.org>

--rXNMserVLWCKQhmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlekPAACgkQJNaLcl1U
h9BHWwf+J+x1LLkKhs/euNG82nQXegO3caN5yRTlLIM1Nc8Kq0ZrA0Y6sBNrwZc5
SlSYRizBioqJS1iLS47DopU7DG3+woAKh3opxwBfAk23aixyD2dLEqXFmgy0z0Un
BwEVHQerLkh8Ogi2GAxr+sqPedN0WEr1GbSY3VfTG1qYiNW3SG5+0AJ6qtSiToIi
830xiMgDyxn0GD+jS+sY3U+wgMfUF6T9Kwu3X/24LQTRKGUCjBMKxDK1j+5j4QuM
I+23PU1qoMHlTDxAphGaXijY0owBT8rJZEy6pF+B81W+Ww0mFD7butnAUrubBePh
JOG0zO8+G59kVsPNgqaeDi7Zt7UXRw==
=PiEC
-----END PGP SIGNATURE-----

--rXNMserVLWCKQhmh--

