Return-Path: <linux-kselftest+bounces-13727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF79314A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7B0B22A3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C5318C18B;
	Mon, 15 Jul 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJThqjkT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DE18C326;
	Mon, 15 Jul 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047706; cv=none; b=fmJ8db95JwQi/irtl2Afu4yhuHq6yfKLcnuQDpC89arV6K4iz9TC8q0qE9apH7oDwYGFx9p60DIxT+jc71uHYO8uhh5a9A4GedeweysCKZ9OYbQzAz1nuLjtECeP19sSt3NO5xLQEjo40Di6fqxYDa5gltl1JplVrYj6IiRmuXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047706; c=relaxed/simple;
	bh=+dNOIzwt18V2RG+4S/Y0QG8predeZMs0ESv2bgm9vcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apgXTfB7fv8Yp1YbHlRil8qJn63lDVVJpBePvJRrvBQ61XKW3mUUlfZPWvLyKmpfUs46R44ucReVxWK6Xz1Wc1v4GgoFfbGAVo02qC06jY/FdSbYtT7kPoDwuGRP6lSMTLcsbRHYIBmVVwn5IcQV+yvivLkWnxXTU/Wd1pJkfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJThqjkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B47C32782;
	Mon, 15 Jul 2024 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047705;
	bh=+dNOIzwt18V2RG+4S/Y0QG8predeZMs0ESv2bgm9vcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJThqjkTaIngwWYLlIBM6OSzh1dMRvlke9+q/OBmaildB+kL9h4bPSswkYTaBnsSu
	 iUvD+dXPgXUmHQs20/F6ufsj7V16k14DjNR2M90LIO0F7WDutlzViydFJrGDjXHtKt
	 sM+hVbNHSREm0xwpQnbMRl8TbyR8aUL0EWmeqQ1oj/8amlsXddFNQg7aXJPeWErAZG
	 XGVkw6QXgzo4sGZWXC3z7++XA6LMgiSUmpXTN7DTHmQP6u6Ppswp/IRRdW7SGONOvb
	 vp8jxgbPLUEno/7DyD5e7iG4jtJW9Y33L0gStY1Qvt9ooO2MtaenOT1e744RVsf+pi
	 XpbXOxMMDMYAg==
Date: Mon, 15 Jul 2024 13:48:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Use card name rather than number in test
 names
Message-ID: <26f70671-7b3b-48db-bdd9-f54f68f080a5@sirena.org.uk>
References: <20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org>
 <7cd921b3-fed9-4b0c-9ba8-381e45ef4218@perex.cz>
 <b3fdbb63-067b-4ff4-8fd8-1c2455a553a5@sirena.org.uk>
 <877cdrt3zc.wl-tiwai@suse.de>
 <e4962ea0-3f03-43b5-b773-68abe1d73cc9@perex.cz>
 <bb42afb8-48a7-4daf-b28b-b82bd5c77d57@sirena.org.uk>
 <c1be6bec-90f5-4bb3-b6b0-8524095fc490@perex.cz>
 <31e73e81-e60f-4d0b-b0ac-118f1dc72610@sirena.org.uk>
 <e52a5a7e-5358-40d4-8f3d-2adb03018c41@perex.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxdFCyXV0QTpjsA2"
Content-Disposition: inline
In-Reply-To: <e52a5a7e-5358-40d4-8f3d-2adb03018c41@perex.cz>
X-Cookie: You'll be sorry...


--zxdFCyXV0QTpjsA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 13, 2024 at 09:35:36AM +0200, Jaroslav Kysela wrote:
> On 12. 07. 24 20:19, Mark Brown wrote:

> > Sure, but the genesis of this patch is that probe order isn't
> > sufficiently stable and we want to avoid names based on it...  using the
> > ID will be more likely to work out stable than just pure probe order but
> > it's still got the same issue.

> The probe order is almost stable for the drivers with the non-deferred
> probe. Also, administrators may set persistent ID for complex hardware

It's not very stable for modules being loaded, there's enough going on
and enough module loads happening simultaneously that it's very easy for
drivers to come up in different orders.  I'm seeing these issues quite
frequently in my test farm.

> configuration cases based on other keys like serial number or so
> (sysfs/udev).

For a lot of test scenarios that's just not really relevant - with a
pool of machines any per machine keys get hard to manage, and for
something like kernelci.org customising the rootfs for even classes of
boards never mind specific boards is going to be an unreasonable ask.

> For long name - the device path may change (USB moved to different port, PCI
> card moved to different slot), so the stability of this string is also
> questionable.

The concern here is repeated boots on the same system in an automated
context, if someone changes the hardware then it's reasonable that the
set of cards would change.

--zxdFCyXV0QTpjsA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaVGpQACgkQJNaLcl1U
h9CT1wf/XZ26rIJZkRd1EFfWIw1ECMj1SsFqo78LBgrs4NzgWBG4lmpXf8N0xrx2
JB5FQ6jP6jOPxK3Tdqpf3S9jJL/J7aCCj+cdrVHiBw6mTcTil6fMOUTPhKgYkfox
ZKeBO9PZ+oSqAa9C4fABFPpURZds5WS1eV2zCwJiogGYlJY/MBFljdW+69dVq+8l
acp1EUSpXnc0MYBGP/YVAlRUTkxs95OXkqC4DoT7Gub3VHxjRvVeUPqvAQ5tHB9q
Zl5LF4R5pE8MdoLr2K3+QH3Zsd3bo+Otk401+D+ZgOlHo99OR79QETbKeIdG8uov
Tmq/zhcsz5+B9zGLe+LZkEbj951EDw==
=1gjS
-----END PGP SIGNATURE-----

--zxdFCyXV0QTpjsA2--

