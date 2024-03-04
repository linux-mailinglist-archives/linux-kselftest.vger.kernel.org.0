Return-Path: <linux-kselftest+bounces-5826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFAC87006A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 12:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3DC1F23B65
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F338DF7;
	Mon,  4 Mar 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od6ndyT7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56291B965;
	Mon,  4 Mar 2024 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551723; cv=none; b=BZD9k4VdciadquiQYxJKNGNoTpMbovZ/DOx6zfVjRAo38MKyu9LTZGlvzuWbnkSVEWABBnI2EcwNv9yVUW55baexJmj0F4ZB0T8feRSuffV9QfysZx5CPxo0zFDP3DGZ/VoFDNHfrYFY666B9PqwDM7GRTl8rigpPKPPcMhaCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551723; c=relaxed/simple;
	bh=or2T4offzEJ0CeMUlNFZZpSiTyyFitZkNk9jwiLFRK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no+XsQQE/k0Tm+VBpdLyAESIr0Gg8zHtIfqo9WwyGTl4zZERubIMrlqy8OldBCnJhIwcLy6ZAlqqCOLyn22Msv76pe4y0827ytl+fxJUGaBRe418ovxivGU4P6oQBDVKXjLcxZrvURh3BXRw1wjWqMlFQc13r/Jhtm3uN8KESF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od6ndyT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08565C433C7;
	Mon,  4 Mar 2024 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709551722;
	bh=or2T4offzEJ0CeMUlNFZZpSiTyyFitZkNk9jwiLFRK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Od6ndyT7ylv+7TEzrS8j958J4csrcec8FRIw7OBTQts/NviexhqeLOFTx4R12ljuL
	 iwHWeBlVji12HBhf6bRNj4u12aiBZ28Al3Kohn4OzfohMfPPLxnPs8zD62a8pEYwmF
	 ZyWdqCqx+GUachME3oQ4mdmnLbfai31LS6l+OKeQMbNtx8k+Q330vY2t9UQJDOpsVJ
	 djzcX5svtSJhXinZ8dfhYqCqLVf1fzfjTjE6dpbIsdW07bwZJsExf4dM3roVWv0GlG
	 yYsGLVYe0SNDSh9CAXaj+XhR9UBEFViaR41rZ0hIQeYPnCBEfD4f3FJo97szqo5zX4
	 6kBn5u2Tyc38A==
Date: Mon, 4 Mar 2024 12:28:39 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, 
	Guenter Roeck <groeck@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Nikolai Kondrashov <spbnick@gmail.com>, Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, kernelci@lists.linux.dev, 
	skhan@linuxfoundation.org, kunit-dev@googlegroups.com, nfraprado@collabora.com, 
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240304-shrewd-encouraging-marmoset-54ffb2@houat>
References: <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
 <269232e6-41c9-4aa1-9320-662beabcd69b@infradead.org>
 <CAMuHMdXuXV9WV3aANFTteuP8Q3JY6R5OWsVBedGOP7e_JguxqA@mail.gmail.com>
 <CAMuHMdWi069YAvOoXe7sHJ_o702tY4tDQgL3sfApPR3aCnZboQ@mail.gmail.com>
 <20240304-transparent-oriole-of-honeydew-f4174e@houat>
 <CAMuHMdXyvcyXw8eXc2MONNaBYYGpVdnPh2h3T=QV38MEUzhu9A@mail.gmail.com>
 <20240304-dangerous-mastiff-of-fury-1fac5c@houat>
 <CAMuHMdV2HkYjowOZBgSZQ3N01UeUTnyv5kjx-82C9YJ+dsgsxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ymv3tdq2u4ztffpw"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV2HkYjowOZBgSZQ3N01UeUTnyv5kjx-82C9YJ+dsgsxQ@mail.gmail.com>


--ymv3tdq2u4ztffpw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 12:12:47PM +0100, Geert Uytterhoeven wrote:
> Hi Maxime,
>=20
> On Mon, Mar 4, 2024 at 11:20=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> > On Mon, Mar 04, 2024 at 11:07:22AM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Mar 4, 2024 at 10:15=E2=80=AFAM Maxime Ripard <mripard@kernel=
=2Eorg> wrote:
> > > > On Mon, Mar 04, 2024 at 09:12:38AM +0100, Geert Uytterhoeven wrote:
> > > > > On Sun, Mar 3, 2024 at 10:30=E2=80=AFAM Geert Uytterhoeven <geert=
@linux-m68k.org> wrote:
> > > > > ERROR: modpost: "__udivdi3" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi=
=2Eko] undefined!
> > > > > make[3]: *** [scripts/Makefile.modpost:145: Module.symvers] Error=
 1
> > > > > make[2]: *** [Makefile:1871: modpost] Error 2
> > > > > make[1]: *** [Makefile:240: __sub-make] Error 2
> > > > > make: *** [Makefile:240: __sub-make] Error 2
> > > > >
> > > > > No warnings found in log.
> > > > > -----------------------------------------------------------------=
-->8---
> > > >
> > > > The driver is meant for a controller featured in an SoC with a Cort=
ex-A8
> > > > ARM CPU and less than a GiB/s memory bandwidth.
> > >
> > > Good, so the hardware cannot possibly need 64-bit pixel clock values =
;-)
> >
> > This is an early patch to convert that function into a framework hook
> > implementation. HDMI 2.1 has a max TMDS character rate of slightly less
> > than 6GHz, so larger than 2^32 - 1.
> >
> > So yes, this driver doesn't need to. The framework does however.
>=20
> That's gonna be interesting, as the Common Clock Framework does not
> support 64-bit clock rates on 32-bit platforms yet...

As far as KMS goes, it doesn't really matter. The TMDS character rate
doesn't need to be backed by a CCF clock.

And realistically speaking, I don't expect any 32 bit platform to
support HDMI 2.1.

Maxime

--ymv3tdq2u4ztffpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeWwZwAKCRDj7w1vZxhR
xaKuAP9qEN4vzS30W73MSnW/4xHYdwyadBOylpEz37phu0ydjwEA0XJSmLO2W7Ui
31PIhTlZnimQzWdsNxR4U30hC+EXvQA=
=FW8N
-----END PGP SIGNATURE-----

--ymv3tdq2u4ztffpw--

