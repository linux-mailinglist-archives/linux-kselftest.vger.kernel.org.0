Return-Path: <linux-kselftest+bounces-30025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBC8A794C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81743B76FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02ED1946C7;
	Wed,  2 Apr 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5QeJkrA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98E1E4A4
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616533; cv=none; b=tjPbZGDRqJaUvLa5As8t4LUTwdkLldAvMZ3qjm1xEU80K1k9K2HkeTMtdEqJP2P9EAKyOEXQhUI2NhsFkAshbATTzWhUbgmI8rYJe4WDslFA4+tYRXf03vveoHD5exK0/X5vs2Wn+XjLDrzjfbEJ8A8tfsgvwjnj8zzckVfF66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616533; c=relaxed/simple;
	bh=4JwGd3tvfMu4T/rdmkwCS6PicZWIk1VKRtUsCE4CFeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4XhQ+l7nMUD50lvjMazyBRKUy1TuI+0E3HT4vmmAnbgu+3H5uZGgxaLrxp2frlk5QRIY6FTtd1es/QJvTFrEpSKk62wZNxtRiTUtPk2T5RnuvaiOcxu8ZqiiejHdYlJ00Tc8RYsMKJhleORJTp42tOGBwte69Fz+m97NhvlLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5QeJkrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF68C4CEDD;
	Wed,  2 Apr 2025 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743616533;
	bh=4JwGd3tvfMu4T/rdmkwCS6PicZWIk1VKRtUsCE4CFeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5QeJkrAT2Ms4UifSO8OT3RjW14Qe3S1Tg5pn6KGz824KfWXh747S2AfwD5r+rAtM
	 +BSmpH1NgSWtD0fb+YtqEpv8riA//3rbnjxF2wVefWtUrmtb0adu2g6GS4YgDMp/LK
	 wofsAFgHVwVnRFqQbuMZEAp+d15vtCA5T9isF9DGkd0T0xXO6zawHP4dcI7OOWegkB
	 U5xznVTZcpMEiff+HPGnpck3eYLHyIY4nQhnrcCojVDnubHB+fE+sQGGWthoWswfjp
	 COhUsTYxn/BJ31iZs0UoeXgPsitJWn+9ATrHmvM5Nm6oaOJbJ3uDUNyjSiJoyS6gML
	 ZK5VxQ8WL2EYg==
Date: Wed, 2 Apr 2025 18:55:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
Message-ID: <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
References: <20250402103655.3e0c62d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7+1oWCPrYU3AOY32"
Content-Disposition: inline
In-Reply-To: <20250402103655.3e0c62d7@kernel.org>
X-Cookie: To stay youthful, stay useful.


--7+1oWCPrYU3AOY32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2025 at 10:36:55AM -0700, Jakub Kicinski wrote:

> The Cirrus tests keep failing for me when run on x86

>  ./tools/testing/kunit/kunit.py run --alltests --json --arch=x86_64

> https://netdev-3.bots.linux.dev/kunit/results/60103/stdout

You've not said what tree you're testing there but everything is fine in
-next AFAICT, and there is one fix for cs_dsp on it's way to Linus at
the minute specifically for KUnit.

> It seems like new cases continue to appear and we have to keep adding
> them to the local ignored list. Is it possible to get these fixed or
> can we exclude the cirrus tests from KUNIT_ALL_TESTS?

This is the first report I've seen from you...

--7+1oWCPrYU3AOY32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmftehAACgkQJNaLcl1U
h9CHrwf+IIMnud8H5btVKEonVuRFZWvag2BTzVtRYrJhamaeCI+MBWlX1vRGhNvH
RIUN3B7uSL9BsPkVa8Tj/cb/IpNIAzpge6sIAOT7C7okp5eiX8IrTf9DE4gBJCmD
tr3GQRPeOQ9ufYrucTz9KYdMHpq7d2521dbgqk5bFESZ2TsGEdhm8AaKf3X84AjV
evQHv7a319jJ7PzellfykaLG7BdVwQAZloGCWgzE5E4hj3T+2yAVhC0x/UbmPD1v
+9Q1IP58E9Q06LzZ1Z2oKmtQxclSqeVleZMjPPXeWlnJuw5ewTN/S1probbGxfZ5
LOW/+Pk7GL4iUoK2qj9xz49SDuynOA==
=lDNW
-----END PGP SIGNATURE-----

--7+1oWCPrYU3AOY32--

