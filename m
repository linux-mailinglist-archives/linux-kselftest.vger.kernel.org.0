Return-Path: <linux-kselftest+bounces-11105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD50B8D8164
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 13:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2531C2160D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 11:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7FD84A46;
	Mon,  3 Jun 2024 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSABx7Iw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442124A08;
	Mon,  3 Jun 2024 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414704; cv=none; b=MSdZ1Oz0VyMyCuJ8TVdc+F6rQrOLOOcHHRmZhFjYsagZgfgP6YoXk3O0+rtudaIIVJ4AlpCTBvi6BJ4q3NBFiBbHkBN9vTRjjbsAUf9GI3+QjKkQ8tve7WVpeOeQPfzmf0b3lTct34d5iJEiBVz63INmqq1Senv5gOW2nJ6L0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414704; c=relaxed/simple;
	bh=TWRC08F1B8xoRvMQiF3zg64H2B0opUb04uKXgiUGxC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVzok/+Dct0wrd0nRtyod0SzS0xem8D7Y9I9BW0/4hs3wGhc7St90o15GaIapz9XCj6VPF/8is1VCutbcpIVQbL8exC3rfEZvKvXbhmarBT0RLsbm0AAgaX5lFSPE1Ccf9qn9hMSK4e1xOC6baycrR2ZL+c9u21SaeW2ipFDYuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSABx7Iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058F9C2BD10;
	Mon,  3 Jun 2024 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717414704;
	bh=TWRC08F1B8xoRvMQiF3zg64H2B0opUb04uKXgiUGxC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSABx7Iw5P+O610S16NKTpohZgAsHIuHtjj7woP3hUNge8+QvuiMEPHlAXr8AyXQv
	 QIAoqzJELkr8K5rA0en1jTy/WW1a2nov2gXyYn3hs+aCY8gzABYptJWKAbAGnpnFBp
	 jKVTO4+GapEp1R5V2DbwDBXCC4ZXlyffPub0zhCfGAve5NfKAGeqeRhBsGC3EW0rk6
	 p167mLa4ILVlgWc+iSQ+qCwu0bQr4ubxZn0F/AeE8HY9cGX/+m1KNiy6SEzqRjhYjY
	 +ngrsn0pv/ydS944D0t8cYSCszW5icbuL5dBiBqHycPFoMAUY6t3chFDOinvAtjtQs
	 oOdblXYCiVYCA==
Date: Mon, 3 Jun 2024 12:38:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: testing/selftests/alsa/mixer-test: 10 failures on Dell XPS 13
 9360
Message-ID: <c9707ade-bd43-419b-8959-0b45d572facd@sirena.org.uk>
References: <1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de>
 <87cyp280yw.wl-tiwai@suse.de>
 <21f73368-5db6-49a1-b8b7-9b06e698327a@sirena.org.uk>
 <878qzp97qh.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R3eNN6pTu5AITEFG"
Content-Disposition: inline
In-Reply-To: <878qzp97qh.wl-tiwai@suse.de>
X-Cookie: Don't let your status become too quo!


--R3eNN6pTu5AITEFG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2024 at 08:06:14PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Fri, May 31, 2024 at 05:17:43PM +0200, Takashi Iwai wrote:
> > > On Fri, 31 May 2024 07:50:33 +0200,

> > I would say these are all bugs, they show the driver not correcting the
> > value and allowing users to read back out of range values that were
> > written.  Even if the driver is accepting out of range values I'd expect
> > it to transform them somehow when storing, the program will accept a
> > mismatched read when testing this case but it will complain if the read
> > value is not valid according to the control's info.

> Ideally, yeah.  But it's a whack-a-mole game, and my gut feeling is
> that it'd be better to enable the input validation globally, something
> like below.

Yeah, I mean I tend to think the whole accepting invalid values thing is
questionable to start off with so I do think that's a good idea.  That
said we probably should still be fixing the drivers as well.

--R3eNN6pTu5AITEFG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZdqykACgkQJNaLcl1U
h9Db1Qf/XNB3of8vi+itY+/Z8PKnPMk+cGR3J16JdHzuc/1XgNdh6tq48POjILKq
BvcnLxqooWZylbzROrB8oJIA7Ffiv5bD7b8IberGiZyqj6WKZROFVUy27Z2I4ekV
6aBcsjFvlnjIKUj+6xKYyaTe1PdBv3IyWlrW2xNT7Zwy4uN66FcYeP58EMWLfZKr
QVHImNY9Vt2cnbVdHbb10qOqi+1fUI5iFqyE2t/ETxFQiioydWyxIDpG4vRDO/bt
C3ZfqFkXLXOmdym3RoFCEVCKj2OchtgdgraE/VlKsqJOabXPEp6bYqnrF+bUGcjV
goKrFZJ+W/YfnlIJjn1t37Z86ANYaQ==
=iMu2
-----END PGP SIGNATURE-----

--R3eNN6pTu5AITEFG--

