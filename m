Return-Path: <linux-kselftest+bounces-2719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 412C4827678
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45332B2243D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314E85467C;
	Mon,  8 Jan 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsTwT/i7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD254663;
	Mon,  8 Jan 2024 17:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F89C433C7;
	Mon,  8 Jan 2024 17:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704735484;
	bh=eNUrttsVgFF4P/49UF3SSpefaOULOT3cYt21cVvtd8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsTwT/i7gpjtBxKQ298UbzoZbtlAnCHmNdS8OTdB3dpoIW2/5pWIIxDlkb5TfK4hp
	 08k1cGec+1eZlU8BdA7vEyBMjLRjkzQD09Y4onzWIvQ6ZUPoF7w7TIdWpV47T0bZib
	 kir/k81p2l6uHumyys31uP1HeZj3pG2LuStz/wjy+ItH1/dQxDxbuUr/+gWtod2Lcg
	 dZ7JF3Ip2RZiR5I/At2LGpeSYCW3ql3G/fKHRXPjd/B+9y6XzV3vEjEenyKQvtcWsz
	 T/aTdQ6nIvzrYh38FlYWvdh2YHd7y45tti71XidueRgj0ExQHmDmhaM8bTV4U9bGBU
	 mC/ISNL3U63bA==
Date: Mon, 8 Jan 2024 17:37:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 4/4] kselftest/alsa - conf: Stringify the printed
 errno in sysfs_get()
Message-ID: <0654c2d9-3980-4f5c-9c0f-eaafc44fee52@sirena.org.uk>
References: <20240107173704.937824-1-mirsad.todorovac@alu.unizg.hr>
 <20240107173704.937824-5-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A8cnQTpSggv4PUgP"
Content-Disposition: inline
In-Reply-To: <20240107173704.937824-5-mirsad.todorovac@alu.unizg.hr>
X-Cookie: Best if used before date on carton.


--A8cnQTpSggv4PUgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 07, 2024 at 06:37:08PM +0100, Mirsad Todorovac wrote:
> GCC 13.2.0 reported the warning of the print format specifier:

Acked-by: Mark Brown <broonie@kernel.org>

--A8cnQTpSggv4PUgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWcMvcACgkQJNaLcl1U
h9BXwgf+PmizVcddynLN/+45MndOSyIGNHf+pdHPtqijnt/LK2KL++RVGqSO0qP3
2SDNiL83pcKT7ojUAHHQNPoafXx1l32mA+Sv2mw8Mn770t+WhyQUzbkMKf/q9sjf
Qd5EAX8cXGd1UzoALVA95FR/17ePC5Fm+/v8vhREFH+l3vwpqW+jTjx9UkyC+9Cy
mkdGJ3xzgWc4LJ/sdT2+2SNL9rNOu24NO/9xe1Sz3RLUUPWPTxRUc9XC1qz3Viql
fwH4eSGHXhd1/J7pcrM4hwejjdy9foW/p6numLkXqI6S6xaUTFkcqzoj3AVkO7H1
N+ld18phJC+50RefKyYbua/c5QdBTQ==
=P2F1
-----END PGP SIGNATURE-----

--A8cnQTpSggv4PUgP--

