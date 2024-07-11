Return-Path: <linux-kselftest+bounces-13602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E192EC7D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19FE3B2496C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844D16CD12;
	Thu, 11 Jul 2024 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0G4skA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7EC8BFD;
	Thu, 11 Jul 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714770; cv=none; b=aNZ51zrgVVgaQRyn/1wb6jcB5zzrCcRnC8MkbufzKx0d8XT8s3TDeATJMhSjva1/ZlCbyMQ7INw+q4XIjkHE5ScbpjyB4Zs3utdvB4g/uMukav/I5hxNUtljiCtQuOeuQSxBjfTFsH7+hZ2wl2C2XQqeM65KMxwDDV7kvG73u8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714770; c=relaxed/simple;
	bh=SwRdtjhihPCHAVs2FVYLRfxFyvmKTZPzi6KmiCgoTww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/CRDdm355AOdS7ft6a8t52NfJIeoJ9j3KjzcPt6NypBaiuYNQcbOzMyDuRcZo2wVHgpUBsjrKOt7DvBMDsgqXSyqoSq1NGOf3Tia/fSXuD1wX3IhdhnBag9ohRqrpMDreWB6gL5S+gZv8GSLzMYUTp/nnXFPo+TR3T1jJ0V1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0G4skA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FFDC116B1;
	Thu, 11 Jul 2024 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720714769;
	bh=SwRdtjhihPCHAVs2FVYLRfxFyvmKTZPzi6KmiCgoTww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0G4skA8Tn5yxLL2Iaq9ZS0WXdlQKCg5WwzDGl/T2ajNdOEBgGJ4uJpz0EbQoxDjk
	 9zIDZ8CqL9PcOvxqxeekNgUhGNeDkpOBi7o3crtkwI6K8+lifHEeougZ+C4783p9di
	 mLyfWCqF3C059TJvW3Mu6K+/zZUvTsIiQ/kkc+8qupeq8UArkFTp6idDFEMLxEu9za
	 mraOmK2Fll5kJOfttZFOfRRsoj/PW20vLXI3crL2CJoW96kFgMmHdrF7FdL16/p4eK
	 32wGFuhP9R1G+9KQfU6C+OFvtqJ3X1WvvmcjQogRYuLZi/jkj2PFrsK1gWDnVi0Cx1
	 2Lu4g/lWDFx2A==
Date: Thu, 11 Jul 2024 17:19:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Use card name rather than number in test
 names
Message-ID: <b3fdbb63-067b-4ff4-8fd8-1c2455a553a5@sirena.org.uk>
References: <20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org>
 <7cd921b3-fed9-4b0c-9ba8-381e45ef4218@perex.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HzrO27/Ki/7DpdHj"
Content-Disposition: inline
In-Reply-To: <7cd921b3-fed9-4b0c-9ba8-381e45ef4218@perex.cz>
X-Cookie: Individualists unite!


--HzrO27/Ki/7DpdHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2024 at 06:08:38PM +0200, Jaroslav Kysela wrote:
> On 11. 07. 24 16:33, Mark Brown wrote:

> > Address this by replacing our use of card numbers with card names which are
> > more likely to be stable across runs. We use the long name since in the

> I think that a combination of card number and card ID may be sufficient (and
> a compromise). It's shorter and user-friendly. Additionally, a table may be
> printed at the beginning of report with card number, card ID and long card
> name for further processing and identification.

These don't help, the problem is that anything which includes the card
number in the test name result is going to result in unstable test names
depending on race conditions at boot.  There are automated systems that
parse kselftest output generically, I'm not sure there's a great deal of
enthusiasm for writing a custom parser for the ALSA selftests
specifically.

--HzrO27/Ki/7DpdHj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaQBgwACgkQJNaLcl1U
h9AYagf/WW+148pc/VOKJhcllAIu66wbfTEChyp2qGQ25wJbxQFCtKMc7cyKhBkG
qSRReaPNpIZtA+eaWhvAknMVqz+VDpTEw9eV+MDIZOATK5PJ1s7DT7i7VnYgQ9+Y
aE4XDnR0iw3W4GVp/+dQUAyF/DoD6dyolbhtM2aKaEQunh+pUem6flREdxw4B6nY
vex/pMtsB6y/4FX1nrhMOsTKs8Pwh76u95ntLSDwgKxU1D3dgD5dbyWwaNSV2JF7
Z+MdgaIqhb37o9aG50CKy3Tvi+i5/JB1zd7ZClE98LZyr5LMz29iL2Mw/Gl7cWCl
2CVW2+D1vl/BUhkYjwveXMyjbwZ5Ag==
=3ekl
-----END PGP SIGNATURE-----

--HzrO27/Ki/7DpdHj--

