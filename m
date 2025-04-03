Return-Path: <linux-kselftest+bounces-30078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F68FA7A8E0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 19:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A042A7A3255
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B702512D0;
	Thu,  3 Apr 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHbIwc9Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4924BBE9
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702481; cv=none; b=S+k2Bs12+Tw81wyL6gDo7w0Vjoc/3vsZZJcRp+vo9Cj/wBCo9MPhPI7lswVt3V1VaO2fF4Znu/x7Mpd4RAp77DQcp4ix9HGANzF0XoTA7U5sYJR1C7bDsAVg8SYzNIfrRUtwceP0sQ9hrnz1Foh/DarwKkqyNx9YT8pRvy4sZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702481; c=relaxed/simple;
	bh=E212xaF2knChur5TVdEsm99wvf/dBUG/xjHkdjxnRsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWH25wM+uDxCMsBSfo2RQRfbZgV0um8KsGHkNc14Y88RmNTm6hm7KM6jaXlBKBRcIrcwmQVozRLeMjJq1RU1n6MClpANwjQ39avYQNryVhdLWjE58AQVj8iCFI4PGyUZEbfNQ9WFRM3Kh6u7BlSnHfVEltCQ5p7aC9maoB5mZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHbIwc9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D91C4CEE3;
	Thu,  3 Apr 2025 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743702480;
	bh=E212xaF2knChur5TVdEsm99wvf/dBUG/xjHkdjxnRsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHbIwc9QC+nSNdOBukhi6qx2Zdc6dVrZQmZYGKW02X/r6klDFgyfF/w8JdadDwXdx
	 Nl91qbT4xMrrouFf+ZhJbIhsG8zr+s49pxdzie4h6fMmA9ERhEzC704PuOeoYRIIzG
	 T0ioDijNij0D64QyCeufZ/VZkdzdWYIctWN4xZq5lorhpcl3FsE1DajCQAoWa1zOmT
	 IaO17AK3KtTQdODqaMCOp9OEXiDrPhvsSeJ0GqK1E+pcr2BLHrDSUjn47Gf4s2Gagv
	 S1zu84KSxh8ehcKvY1Mg62SyFCCIQ1wSF6dIUCUTVLn93+tvmUMizAQQuj6gpDxzwl
	 +12vedkG5QVhQ==
Date: Thu, 3 Apr 2025 18:47:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: David Gow <davidgow@google.com>, Jakub Kicinski <kuba@kernel.org>,
	patches@opensource.cirrus.com, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
Message-ID: <8f2de668-0ee2-4c8f-a26a-1aa77f6a0108@sirena.org.uk>
References: <20250402103655.3e0c62d7@kernel.org>
 <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
 <CABVgOSmSU=i9WvUHFERY--Pgqg3Hr_LxgA9HJ_5aG4F-FgKhzA@mail.gmail.com>
 <d9d9fa47-c926-4479-a0c9-fb6c0713b244@sirena.org.uk>
 <40aae10e-184a-446f-b4fa-09935e25ee21@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RZROG081eLImuNyH"
Content-Disposition: inline
In-Reply-To: <40aae10e-184a-446f-b4fa-09935e25ee21@opensource.cirrus.com>
X-Cookie: Logic is the chastity belt of the mind!


--RZROG081eLImuNyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2025 at 05:57:51PM +0100, Richard Fitzgerald wrote:
> On 3/4/25 14:26, Mark Brown wrote:

> > I've not heard anyone mention hitting the timeouts, though now I run
> > interactively I do see that the Cirrus stuff is a good proportion of the
> > runtime for --alltests.  We could potentially add a config option,
> > though it'd need to end up in the config file so it gets turned on and
> > we'd still run into any timeout issues.  There's a tension with people
> > expecting --alltests to actually run all the tests as well...

> I don't want to get into the situation where nobody outside of Cirrus
> is running the tests. One of the main points of converting our tests to
> kunit was the hope that more people would run them on more
> configurations.

Yes, me either - I do actually run them as part of my automated testing.

--RZROG081eLImuNyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfuycwACgkQJNaLcl1U
h9BN8Af8DqF9KbL/ju4wtfoF1oIBfnBS9tpjUoyRx7F11pWiCdMIHmtQg/OvcnDh
q0infjSD5SpMPvnX35PweCa2J3exgVXbx3Hz8gr17AmuqOjlFCDsRZ0rGpEmhyje
CdFbMELiS3pLtqfuDMqQftABDGQvy37goAU3YPUzMejD0318Sx6nYgaQkf/iKG6r
mZMZ7h5Hnyh2yS3hutp1xCrH2iYsshK5H0knmwhXEAXJtDDpG8IlNhPaGSekmnit
cV4KJK2eTneBnzjAGz7+2fcOGwrC56sHTQsxU5i7aTY2/vmQRC/xLycvxFFWmrLx
lo+VdmnnYiDh5KWQBwDRijydTdH/5w==
=yZ71
-----END PGP SIGNATURE-----

--RZROG081eLImuNyH--

