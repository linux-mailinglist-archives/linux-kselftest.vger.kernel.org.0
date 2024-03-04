Return-Path: <linux-kselftest+bounces-5839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7AC870684
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 17:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6137C1C20E1E
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E6E482D0;
	Mon,  4 Mar 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPZUFFoI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28414E1C1;
	Mon,  4 Mar 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568308; cv=none; b=TIjEl90S0ZEB+MQz1RZJRxrQ+L0f00STL7AOVjcJ0zHmnNyw3+HnlFe+NhdiC7GxrBUdKo7TBNG2eE+412oM7CKPF/IN6INnYFtNHFXFRmO9jRekBR9kBTsRau4Ma2HKkam9dDFdaGI2HCuJdbvvvwiettyrl9pyAFFEwpObHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568308; c=relaxed/simple;
	bh=IqKjf/V5VV8UE4R3lEGBliAPiP3FkHrOso1nqZ3aCuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MirgCImQVNPC81Hq32dR8sCRr1jD3Y3l3st8aKYw15ARW8Pz2ZX5dawiylQubQgNopaXll0c7bUtlWYqgsxwhS1efB9+O+iLjdjY3vkcNRSc2Rap1VlRmU66WmRt69sbYoGsh+xDC8Q3uzC7AONXf0kvJAoXBXZodjOdjZzfZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPZUFFoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10655C43390;
	Mon,  4 Mar 2024 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709568308;
	bh=IqKjf/V5VV8UE4R3lEGBliAPiP3FkHrOso1nqZ3aCuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPZUFFoISF7hoNFdL4xnmd1M1+T9744bsa0ut//cI3GKpuvePacbzacYODEpQ1W5Y
	 u8uGDRH9+VYz7Yjuz7BwP6ilvpq7SZZCEFpnrmpMuGisdmSPKQb7rHGkFb+Gk5KPAe
	 TK6E2wMKN59TlYacTHf/3lGf/YRz4bOjxt8K9wPuFGLde3itcwuXOd7EVvbGuR6RHL
	 f3DuH1pJ8n5cJtyk1kIRZJwMspexJsb9YlZ7gqCOIWWK/hAIzysux3q+Dtm+h36w9u
	 zSr2MHI5200MBnykWbm823kjJdKxWD9muE7sg3HmLwFmVpBr/v0r89Sa9SW/vZ/elK
	 shgUZUIvnzILg==
Date: Mon, 4 Mar 2024 17:05:05 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Guenter Roeck <groeck@google.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, 
	Nikolai Kondrashov <spbnick@gmail.com>, Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, kernelci@lists.linux.dev, 
	skhan@linuxfoundation.org, kunit-dev@googlegroups.com, nfraprado@collabora.com, 
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240304-ludicrous-grinning-goldfish-090aac@houat>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
 <20240304-rigorous-silkworm-of-awe-4eee8f@houat>
 <CABXOdTc4MXcjwgGuJb4_69-4OFELD37x0B6oMr=4z=nxZ2HPXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="thflmdlthwp7swbs"
Content-Disposition: inline
In-Reply-To: <CABXOdTc4MXcjwgGuJb4_69-4OFELD37x0B6oMr=4z=nxZ2HPXQ@mail.gmail.com>


--thflmdlthwp7swbs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 07:46:34AM -0800, Guenter Roeck wrote:
> On Mon, Mar 4, 2024 at 1:24=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
> [ ... ]
> >
> > If anything, it's more of a side-effect to the push for COMPILE_TEST
> > than anything.
> >
>=20
> If the drm subsystem maintainers don't want people to build it with
> COMPILE_TEST while at the same time not limiting it to platforms where
> it doesn't even build, I'd suggest making it dependent on
> !COMPILE_TEST.

I don't think we want anything. My point was that you can't have an
option that is meant to explore for bad practices and expose drivers
that don't go through the proper abstraction, and at the same time
complain that things gets broken. It's the whole point of it.

> The same applies to all other subsystems where maintainers don't want
> build tests to run but also don't want to add restrictions such as
> "64-bit only". After all, this was just one example.

We have drivers for some 32 bits platforms.

Maxime

--thflmdlthwp7swbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeXxMAAKCRDj7w1vZxhR
xYlQAPwIi05mGTIAHwJKG4sBeZKb2fVtGkVhOtt6zHMKVCL4UgEA4a2ngKZUqIko
YkvJr1Lsw7kRsL8JpjsPGMT6i86ACwY=
=NUWE
-----END PGP SIGNATURE-----

--thflmdlthwp7swbs--

