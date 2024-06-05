Return-Path: <linux-kselftest+bounces-11260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE368FD7C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9CA285026
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A6157A41;
	Wed,  5 Jun 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMfLYeEu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634913A897;
	Wed,  5 Jun 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620548; cv=none; b=IG1tw2oGZ3Al1Jn3LBADNnYODiGdaakBuQG5V0dBbKibvFLoksqxTcaRCEGs1PKey6dRtguYIQnPnxnTFWsYKb2T7gG/5NLa/V7/ynXcx6AC5nDw6ioEDWGuOyQuD9rr3xsd5AZTmXZZ2QF/jQ/goyHnojg/oHznQaePU9s/Nuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620548; c=relaxed/simple;
	bh=iooQD+slmT5/eWMAszFqIGNDD4xIV6olB6rXYeIs3mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAYdol1aQaL1buXe9B24XIbE1uCe8AHNOPxnapDbjblfQA+jy5AebMxrNOD5STxG66oaPv1a2e3egA0Xzp2wlVlGBLWYZc0awrwqLgUoiecDr0WOwpUBWW1xJGEmx/H3+IQGGB9ygCpmna41XVuFiAUu4licXyK4+67aHHBdArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMfLYeEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D9BC2BD11;
	Wed,  5 Jun 2024 20:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717620548;
	bh=iooQD+slmT5/eWMAszFqIGNDD4xIV6olB6rXYeIs3mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMfLYeEuBubeoqkdrxTGu8FGk8qrxsWuUD1ofvn5w07AN0a7jqA2lD3VFU1b5kl0R
	 ErO0KxJ76uD3JoBs9pb2kQGKKXZC2Ucpbs6ARKc8uO33tS2cDRuaw0pB2NgzFHF2Wg
	 5H1/HWBh0ui2bl9MEVa4KPBY3bZ99RpECqF8vJtGaR7xchr8ElmQUa0cih6PqEaTgN
	 0jeq2pn1dhgol6hiwVd+VZrahUlUB8yOupYOefRmnQenw9AoJLXODQuoYTIuOrCX1n
	 R7SF4mdRMj+fK0OBbX6PWDInRrNSa/EbYwwze9bWEF9v8M8x5rIzzOK98OBhUGhoX2
	 GJAymk0oCumYQ==
Date: Wed, 5 Jun 2024 21:48:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug Report] selftests: arm64: build errors
Message-ID: <079b5dfc-b77e-4808-831a-c0d38c4923b4@sirena.org.uk>
References: <5ec0f2f3-5259-41a9-a25d-5baf1680dd10@collabora.com>
 <7b7f4dd1-bc13-4827-84d6-20ebed7119b6@sirena.org.uk>
 <8e1e2f1d-a578-43c0-ad55-fb593967ac5e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JhYnV4hMM1CPNckb"
Content-Disposition: inline
In-Reply-To: <8e1e2f1d-a578-43c0-ad55-fb593967ac5e@collabora.com>
X-Cookie: Simulated picture.


--JhYnV4hMM1CPNckb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 01:13:45PM +0500, Muhammad Usama Anjum wrote:
> On 6/3/24 6:31 PM, Mark Brown wrote:
> > On Mon, Jun 03, 2024 at 06:28:16PM +0500, Muhammad Usama Anjum wrote:

> >> test.c: In function =E2=80=98handler=E2=80=99:
> >> test.c:85:50: error: =E2=80=98PSR_BTYPE_MASK=E2=80=99 undeclared (firs=
t use in this
> >> function); did you mean =E2=80=98PSR_MODE_MASK=E2=80=99?
> >>    85 |  write(1, &"00011011"[((uc->uc_mcontext.pstate & PSR_BTYPE_MAS=
K)

> >> I've GCC 8 installed. I'm not expecting the errors because of a little
> >> older compiler. Any more ideas about the failures?

> > You need to run headers_install IIRC.

> I'm running:
> make headers && make -C tools/testing/selftests

> I've tried gcc 12 as well.

It's your system headers (or not finding the kernel ones anyway) rather
that the compiler.  For PSR_BTYPE_MASK it's ptrace.h that's needed.

--JhYnV4hMM1CPNckb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZgzzUACgkQJNaLcl1U
h9BxAgf/Wo+3F59fFxKwN2tfRUMG4wnzDNqfDur6Y3HdCHPXkeFySk5KbH9DJaKH
rymjsMabTp2Tjq9eCeU1ceTa2jAiBLuOJxD83SblQXdyRWcnSy6+7PYYVzvdWrgP
oJidYigkUWPSwCM8p/1B/ogwilVm9SY3eLY1n5vA5YRYXrdxVtvCOFRc/O7OB2NM
pL6Odp9jippLJMUyBkyixv+e959tnPenBBQ1RGFqA01WWT/ytrZk8sanc4BMFwfb
sc7Gk7gVrzKGjGcuoTPX3bU4EhBl2hFJ9JG38d07bkX60UpmKc9D8S84EvnqZW6F
PynqM4Rgo9QJPf6m9leKtyayWn6LpA==
=BwgQ
-----END PGP SIGNATURE-----

--JhYnV4hMM1CPNckb--

