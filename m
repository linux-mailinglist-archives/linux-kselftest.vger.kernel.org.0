Return-Path: <linux-kselftest+bounces-33850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D0AC4E2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A293ADC3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016FC265CD0;
	Tue, 27 May 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcWOz2Li"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB325A337;
	Tue, 27 May 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748347570; cv=none; b=IMHUgv3pUikFeSg7R3sCTXZDMWD54rFzVi59Zv0w/bMVqeIxm0rn2ekQUTcvheCri5l2KBroAy7t3eFNydGjZb+mCUkgWO6nS4BFcgaO604AM8p0iwNmrNCZlJGV7iJCAzKQ4Hs640KqQQ+r0N1sSu3ufekGN3PJfdKj30VW80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748347570; c=relaxed/simple;
	bh=ZEDyTJOkgHkfFP9xlk9nnK+s6LSAfKHuMEaoY0SgR4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeLw260hWN6AIIwUtstuiRXF1yLW7GjPUB5yIrAHBOtQkqSupuSJOJLckuzzneyx8iXEalWRXEh/iptSPEUiOuIxQqLXJ30Z+9ixUvxAyQ+ekZmS/h6E8HBm29fmAp6gmTF4YuL+rU3O2MEtJzAiYv3tZiTLIzT29bCs77yuf18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcWOz2Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E73C4CEE9;
	Tue, 27 May 2025 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748347570;
	bh=ZEDyTJOkgHkfFP9xlk9nnK+s6LSAfKHuMEaoY0SgR4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcWOz2LimXhOMHE19ddfVuKOvbbF3Txzlu0FYBBE3d9KoFsGg4jTBZ4Ljo90Av0Pc
	 xCS4yliH0nJ1k65XOtrSXemzALD8+mchqlJWHHR1yDA5cUo4iuIRTFBY8X2SlxuKcz
	 +LCTSOwlAfsB2IKiy8BoFlgel0EDgHH4LM6MilW/RsQqdl/Y5GFymSPtq/j0LJriFT
	 yYZA0rB+Vlsiz3yTFooBw9Zbc9GishYDZKzKWq7+P3eNAVUV69TP/HCqIoUWCxMXWi
	 kKQnwoVNulYqKlOsF+B1UsbLnZ4lQmwe1GfFwvHyaQR+91Gbn/yqZEZYqHoAuDiqBN
	 JkXSFC3FAtjmQ==
Date: Tue, 27 May 2025 13:06:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests/mm: Report unique test names for each cow
 test
Message-ID: <355ee4be-13e6-4ebd-b4c6-0cb34eae96c1@sirena.org.uk>
References: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
 <20250522-selftests-mm-cow-dedupe-v1-3-713cee2fdd6d@kernel.org>
 <3745cced-199a-4c9f-a282-d9587f2edd41@lucifer.local>
 <3729c741-fd02-41f9-9668-7575871e7acb@sirena.org.uk>
 <675ce51b-a218-4fe9-a571-56387d72fffb@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DLgfvVZ12OQfPqYs"
Content-Disposition: inline
In-Reply-To: <675ce51b-a218-4fe9-a571-56387d72fffb@lucifer.local>
X-Cookie: New customers only.


--DLgfvVZ12OQfPqYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2025 at 12:53:30PM +0100, Lorenzo Stoakes wrote:
> On Tue, May 27, 2025 at 12:49:57PM +0100, Mark Brown wrote:

> > Ugh, this was masked because it's part of a series and among the
> > problems with the kselftest build system is the fact that it eats
> > errors.

> Compile errors too? That's... not great.

Yes, you only find out that something failed to build when the binary
doesn't show up in the output or if you read the logs which is terrible
in a CI system.  If you install things to actually run them you get a
lot of build log from that which scrolls things off the screen and you
might have the binary from last time lying around.

--DLgfvVZ12OQfPqYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg1qqsACgkQJNaLcl1U
h9AXaAf/S89P//NjW4NR8PjkaRUN5/4/ccML7dYANNnFp69Uxe1vhMETVrn3zLlq
O+T+dP6gGJ6Udl7rdiI0RE4f62PnNn+xSiAmYiuLMvzgG1M1Q/Zghi+EghHatiL/
MFB1BguMF3S1DTJ145Cgjea6D7v4RlrdwLH8byM04s3aCxXFB8M6MeTBzv83lKvz
ExEbaDewnFZYs3MAqgs5ZxQRUsyg3uAYbYkRzIBJUFh2KS02UW/tU9GQLdQgpOW5
xNpt4/KNlK+Kb/XCGeoSNELCB5SvBmsIv22Zo38QnMI4Fx+UAhFuksy17PvWKE9u
Owpfwm5/43Wi/WTIImaP0nrrvqWkzQ==
=zaUr
-----END PGP SIGNATURE-----

--DLgfvVZ12OQfPqYs--

