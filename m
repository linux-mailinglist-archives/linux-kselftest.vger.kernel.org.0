Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EA946F3AE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 20:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhLITQn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 14:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhLITQn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 14:16:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE5AC061746
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 11:13:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A512B82614
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 19:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8CFC004DD;
        Thu,  9 Dec 2021 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639077186;
        bh=tBjKfzzRE9XRyPWf8hY0hOezaPV1G1zvOSI/pTH5Nc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9hNoUR6/nlkgrc/c6NS/6UwdwbrdVGLJPGeoif/E0ETu5gFjvqCnUknWfSZTFDoL
         NHUnRtYg/oVw1BUvMsWHP4nT5jAMhHlPm423j5tV0Vwa77/KAFoztMOO4ko6DVVzy+
         bPAqIipZbUUyMPXoyEO22baGT7S6kDmtLUmVrV9onNrFazoFwViwoZvbOO+PaTEOCB
         2cKPowK353BgREcTvQzN9l9eod/9nFiCyksAvEKbB9DNsSjZp9Lijp9iJkPB0rwIIp
         WOFfp41w8MlR9Fo6IKHqLVG+mGaultMWTjAvSv5LS7vTtscwo8VJGJk9tcAfZFVBlp
         uuPy4Re+vE4zw==
Date:   Thu, 9 Dec 2021 19:13:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 06/37] kselftest/arm64: Add a test program to exercise
 the syscall ABI
Message-ID: <YbJVPGqADH/cadaU@sirena.org.uk>
References: <20211115152835.3212149-1-broonie@kernel.org>
 <20211115152835.3212149-7-broonie@kernel.org>
 <YbI3ZfhOO+M5L/9V@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+g5G8wE4mIOqQUJ+"
Content-Disposition: inline
In-Reply-To: <YbI3ZfhOO+M5L/9V@arm.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--+g5G8wE4mIOqQUJ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 09, 2021 at 05:05:41PM +0000, Catalin Marinas wrote:
> On Mon, Nov 15, 2021 at 03:28:04PM +0000, Mark Brown wrote:

> > +// SPDX-License-Identifier: GPL-2.0-only

> Nitpick: I think GPL-2.0 is sufficient (i.e. no '-only' suffix), though
> about a quarter seem to use the -only variant.

Yeah, it's that because it's the default for kernel stuff.  Easier to
make it restrictive and then relax later?

> > +	/*
> > +	 * After a syscall the low 128 bits of the Z registers should
> > +	 * be preserved and the rest be zeroed.
> > +	 */

> That's the current behaviour I think but the sve.rst doc states the
> values after syscall are 'unspecified' (same for the P regs). Should we
> tighten the doc as well?

I think so if this goes in as is.  There was some debate at the time
that SVE was originally merged, with a strong desire from some people to
make sure that this behaves consistently on every syscall.  I've copied
in Mark Rutland and Marc Zyngier who I think have opinions here.

> A downside with forcing zero is that it may prevent us from some
> optimisations in the future. Currently we do an sve_user_discard() on
> the syscall entry path and disable SVE but we could instead do this only
> on context switch or when the kernel used Neon.

Yes, this is limiting our options for performance work since we need to
at least take the cost of zeroing the non-shared state on every syscall,
though there's still options for choosing not to disable SVE all the
time (I've got a patch already I need to do a bit more work on).  The
currently documented behaviour is in line with AAPCS here so you do have
to wonder how likely it is that someone will rely on the zeroing.  On
the other hand anything like only zeroing the state on context switch
would mean that it's more likely that userspace bugs with something
forgetting that the state might be cleared will be intermittent and most
likely hard to reproduce which will make people miserable.  There's a
good chance that bugs will be wrong answers rather than something more
immediate like a fault which really doesn't help there.

> Of course, we also run the risk of the current behavior (zeroing)
> becoming the de-facto ABI.

All current kernels do the zeroing so given that SVE hardware is
starting to roll out widely and that usage is likely to be with kernels
that are already available, some people will doubtless backport any
performance work that changes the behaviour but it's never going to be
everyone.  At the very least we I think we need to decide soon if we
really do want the consistent behaviour we currently have and update the
ABI document if we do, if not there's more options we can include in
performance work.

Deciding that the current behaviour is in fact our ABI is definitely the
safest thing and the path of least resistance, though it's not ideal
=66rom a performance point of view.  My sense is that we would probably be
fine changing things but there are real risks and my sense is that
there's going to be substantial pushback based on those which will
result in us sticking with the current behaviour.

--+g5G8wE4mIOqQUJ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGyVTsACgkQJNaLcl1U
h9CTxAf9E5xGr3FzUMCmjq1Lz0p/KmM6qNn62C4Z/68RP5CWqG/R4/tGPL4vWGHB
jCbEbyajSRvZbD5Xzj931XGgv2rKnO/1+pq3MDgqs2VgPJN1ONzl4XVm+N0ysUgd
VdZAzxpR3A4N3ODHRqMsavXa2qvF62DTbiml2Q6S2VD6EWSi3UjD1O+cVryn/0QX
1ixejCtFgHNsMYTW9UNZ+9loEAXnjpgK02GDUhOgFeg8+9f7oOGQfOFUkyJFrmOt
8kKVYRgqSwW65ww6Oy9aQE9PNLuB8If4bbR8ogLhrAC4nG3tvJomh3ExanzdosQY
T1kjvEzrsHrapshxcOnmI6rLy8cu4w==
=SKV5
-----END PGP SIGNATURE-----

--+g5G8wE4mIOqQUJ+--
