Return-Path: <linux-kselftest+bounces-44656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5ECC2D1AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 17:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6831895F30
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585A3168E0;
	Mon,  3 Nov 2025 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJHdEwDV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51310314D01
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186955; cv=none; b=Jur6xc9jL8KPbgSUcVzZN/4B9ddPpc2LbkbQ+QZi/wkubhbVa/ZCJhp95Vq6oSBrWju2z1KtZrIcwz825cABgd12Q+0z1uz8HTBR1KdX19W6S8H0STFU+dNdPohWnBnYzxR/C29zBcwbCcSbtnoeLFNBNRER6AiCHGobOzKOy1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186955; c=relaxed/simple;
	bh=93FBKrK0toqosvLDln27pA8mtH7ilIFrTvv6JsRg2ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHAf6me9Ush5fpG8AnfqNPY1oUh/jNC6GFOcrl4zMQqksuVVeYMGX6OAJ1sFJTkyQ6VzI/f/ii+aO7VswJBjyr+ux+CHc9+R4ox6CyX2gv3SKXpQpU1WDNJO+Blw8p4brCF02qpx4s15y1HfxFYGT80xrz8nucngY46R8sw9Mjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJHdEwDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EDEC4CEE7;
	Mon,  3 Nov 2025 16:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762186955;
	bh=93FBKrK0toqosvLDln27pA8mtH7ilIFrTvv6JsRg2ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJHdEwDV9C4QptAxVCFZz6DjBvfRwdYFCCEA1JO4GzFVJpaeF/mZoYwy3xP2fRKkd
	 IdGMbAFwkOvGDurcVGnCenCOcoP4ygIh9XNhXh+rmMjiuqFpPSvzYiIhLd343CT3jf
	 Q6moRwBooDU8gsg6reguK04iUT/v4Himfbh8MgWRP7OIIzso/c9ZkrYORJ8Z2T+rNX
	 161FW2ZnK75SG3F69VI1PFR209K/IyhKflXWPr6ufX7iSBKe/xYUO40/M+VyGWd5bw
	 OwF5EdYzMvXjDIs2hn4vp5/bbotv0a6kCC4VxJAi3A7tQO4UJebcKElOxAaoCqF4qD
	 aNhq3528ce5VA==
Date: Mon, 3 Nov 2025 16:22:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	linux-kselftest@vger.kernel.org, shuah@kernel.org, will@kernel.org
Subject: Re: [PATCH] kselftest/arm64: Align zt-test register dumps
Message-ID: <aQjWyM9Eyboav5R2@finisterre.sirena.org.uk>
References: <20251103160417.1023545-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5lnNBZ32XwriuUaA"
Content-Disposition: inline
In-Reply-To: <20251103160417.1023545-1-mark.rutland@arm.com>
X-Cookie: A mushroom cloud has no silver lining.


--5lnNBZ32XwriuUaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2025 at 04:04:17PM +0000, Mark Rutland wrote:
> The zt-test output is awkward to read, as the 'Expected' value isn't
> dumped on its own line and isn't aligned with the 'Got' value beneath.

Reviewed-by: Mark Brown <broonie@kernel.org>

The other tests all print either a register or row number after the PID
and iteration but there's nothing equivalent for ZT0, the newline got
deleted along with those logs since it's wrapped into the number print.

--5lnNBZ32XwriuUaA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkI1sQACgkQJNaLcl1U
h9Cx7wf/bR6vlLy2s6mopoo2jg7WKsRYwpZil6D18mN+KgBkNsuHa37wpbcWa8KH
LD5oRHAFT8yPH67RoQagBbgWJH08bbKJTChT/kzHGKN2M9RJvtNwZPRVO2g5SBmx
666C2q1ROkLMTocaWaXmJb2I/ru/itfNwg5v4u1JtFol9k/i06BwjySrrHf3HslC
7swocDKz1ucp3a+H3d0cWjJ0fZIMonVw7/kylOnxhHRA/Y9IthHKJRGOZHTnLAxT
lX5JV2VhK2bLG2UM/DvSl4Itnxg2/XLCq7px1/TTL7APeP1Xt9whQKiQuDYqMIHJ
JFicZpB956ZXA1VOkJqWixJKs+lrbg==
=m3CS
-----END PGP SIGNATURE-----

--5lnNBZ32XwriuUaA--

