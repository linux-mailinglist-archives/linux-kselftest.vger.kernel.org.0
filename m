Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31A442C8D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJMSjg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 14:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhJMSjg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 14:39:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FE06610A0;
        Wed, 13 Oct 2021 18:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634150252;
        bh=4GZEzamE26qpJU7uu+fqafcszILrax/UK1nk+uHh7Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0gsc4U5W+/CAUtySNc7RtKdfaCUsQ4pze4uOWeDJhlrVV21heVzzvP8fNpURxROR
         Q2S14hHsIGg5fRyedITJbtD5OXu5qQ3V0v7YQOYw5A6IhqVZKSK0vsKd/IMDsqs7xs
         u/gjK89kWYzNvVYri0O2NHf3NBg0Tjqe4y0+cMfvFtuaKmKGtogibv/3DWCic4eumo
         EFL3RIZ4SvMsDyj7B/WyFiYG94qLv6j9DvOmM1LEQ4jZwlmsF4/6i8wtNk8PIo2fQA
         oAkFX60EoIewRhWJlHUrFGq/QUZNXQaenhaXUezS+4yT9WRAkArMDJ87HhxlQdpL5I
         1uAqknogsrujg==
Date:   Wed, 13 Oct 2021 19:37:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Richard Sandiford <Richard.Sandiford@arm.com>
Subject: Re: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Message-ID: <YWcnan0ifmngWzJ1@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <20211011131730.GL2700@arm.com>
 <YWQ67ad5wfRgp9l7@sirena.org.uk>
 <20211011141937.GM2700@arm.com>
 <YWSaHaJOIbEigw4w@sirena.org.uk>
 <20211012082321.GN2700@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bDSCeHHLDQazAnvi"
Content-Disposition: inline
In-Reply-To: <20211012082321.GN2700@arm.com>
X-Cookie: Where do you think you're going today?
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--bDSCeHHLDQazAnvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 12, 2021 at 09:23:21AM +0100, Szabolcs Nagy wrote:
> The 10/11/2021 21:10, Mark Brown wrote:

> > OK, that makes sense.  I've changed the code and the kselftest so that
> > TPIDR2 is preserved on thread creation.

> does thread creation have to work the same way as fork?

> (in a pthread_create child we want tpidr2 to be 0,
> since it represents thread specific data. in a fork
> child we want to preserve tpidr2 to mirror the
> state of the parent as much as possible)

...

> i'm not sure when to do tpidr2=0 exactly, but something
> like CLONE_SETTLS is set or child runs on a new stack
> would work for me. if that's too ugly then preserving
> tpidr2 in the child is fine.

Resetting it on CLONE_SETTLS is straightforward to implement so if that
works for you it sounds good to me, I've got it implemented locally
already with a test case.

--bDSCeHHLDQazAnvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFnJ2kACgkQJNaLcl1U
h9C0zwf/RGZv2LeH/H48CAwXDA1MHp59jdD7Jnj9C1t6weT4wx0I88rVY5ldAZ2v
r/vIO1phJ46ma1H2fmDTL4paomWT2aNE6JMK6EpEiKaZ8TY+TMskJHKTimPgCwcO
2QCCw9czNqbb8E8xIBJ0xHOkYmcU/k4w9NCtV+CfNNTWT+BUf51RixQiaKhRtSIH
MZpPnOBTSllS4Zxa5lE/X17j1xCylSnpszeg/b5Forlghb6yGTFHuyLFtIxXi2Ld
8gqi94Wn3KjT+OvAPkkd14h9BGS4Up/cNN6NGTRvBbJojkIvfKuf3I/LAD46A04Z
LCfzPOsJWUhnj2HMwGcyEKtYlZFiOw==
=Yg7r
-----END PGP SIGNATURE-----

--bDSCeHHLDQazAnvi--
