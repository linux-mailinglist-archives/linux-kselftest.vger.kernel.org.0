Return-Path: <linux-kselftest+bounces-2717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A360A827600
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 18:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EE12841C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564D754657;
	Mon,  8 Jan 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGWifiPQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C553E3E;
	Mon,  8 Jan 2024 17:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC2EC433C7;
	Mon,  8 Jan 2024 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704733540;
	bh=7+lhq+96/jDhteAN2wE7R5CLLTtgrCijUIdGIIxjVQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGWifiPQc/e6T0lNzEAK0wokpj1O9R7XCMbMRW29Wr53T6PodzYLFeaE7dXsOaIOD
	 8DBiHRnJygFAivWJUhI/AjZaJbJhRbRsvLHx88MSlTRbKxC4HrICX22kFGLRkmBOy4
	 MYVVgaMxJRwgFaWN4mgb65uxtcko8L95k0qSVsomqq2dOdDKhsKJGz8wGImbikCRuY
	 eaVitbwd9jyBc2x7OngaX7SW7BX6p5We8Jir1XzfHeBeturEWVD1OIRnxRW1yaV835
	 mx7VNAXdoXrBNPCosvBbB4MBSFZIGheHu04gtciPOUwJM2d7yl/Qu6M/eno7Q60fzL
	 pRqty97SMDYUg==
Date: Mon, 8 Jan 2024 17:05:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 3/4] kselftest/alsa - mixer-test: Fix the print format
 specifier warning
Message-ID: <c2745f79-d2f1-4c3e-a75a-fde6c51d0725@sirena.org.uk>
References: <20240107173704.937824-1-mirsad.todorovac@alu.unizg.hr>
 <20240107173704.937824-4-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T910bVcutMKaYqac"
Content-Disposition: inline
In-Reply-To: <20240107173704.937824-4-mirsad.todorovac@alu.unizg.hr>
X-Cookie: Best if used before date on carton.


--T910bVcutMKaYqac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 07, 2024 at 06:37:06PM +0100, Mirsad Todorovac wrote:
> GCC 13.2.0 compiler issued the following warning:

Acked-by: Mark Brown <broonie@kernel.org>

--T910bVcutMKaYqac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWcK14ACgkQJNaLcl1U
h9Ab9Qf8DcmuOpDkgqQTzZSnVbmo4WblxfFvzaBPOpFHn8LsdXs6IeRYCcenvDGO
Fn1hfAjGgXnTlPnYYngMIYE9xdRu3tLOb5uxc3oFZZId+OK0/xdSpTI1hJVCRrPy
MxYF2E8Jvf0PbDuGcx+IZPKJm/Zri8u4UzmM7AFxhr1XfFAK5NR/vLV2Qsm1wZp/
ZXje45ByWnyruk5U8aK6AAFLjUzAMJYIauV7SJflkC4uTBxObFRYAgnb2cb8ztwS
5TGs2pg51XhSoQ1h83ek10Tw0w2rhzxgMEIO3PJHN3s5qJ/ogtGYzRpbPhtlOXd4
1QEcdrmywi4s/mKTL3J8fCuWMfrXWQ==
=QhNA
-----END PGP SIGNATURE-----

--T910bVcutMKaYqac--

