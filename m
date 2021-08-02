Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF9B3DDAB4
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 16:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhHBOUO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 10:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235826AbhHBOUD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 10:20:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AF8460555;
        Mon,  2 Aug 2021 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627913993;
        bh=QDeww16REs82+2ELKf8YCA6HnrevwnUdlHNo99mHMD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atI5dEyt2B5ZjH+7q7UCCn1haWku7+kgdUjJGib5eQZQLc5+R2qW5M/LU3hWvU9pN
         hVZvzEEK/h+V3i/DXq9iRDr6RH7miWzHAloHV7hK/rTTU0KLr9cTCkoq08AmtMk2Ti
         KNofEqaa0n43276thvU5FPsDePf7BlOL4Q5/1zCOmpzbF41p/EuH/1nxh+79N5ITWO
         HbZGMpGPXsc8mtWVBY1rcloIeqe24/c5dgWy3s91VMU6wa9premc1WnVh0Lou8+3ld
         jGu2px+uWjPGp/Xw7I4vvG2by8ouKlzPA3hQrxoIJ5C+FI0BGc5b6UyxOLD8fekqtw
         WMq5K0yAPQsKA==
Date:   Mon, 2 Aug 2021 15:19:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210802141939.GF4668@sirena.org.uk>
References: <20210729151518.46388-1-broonie@kernel.org>
 <20210729151518.46388-4-broonie@kernel.org>
 <20210729160642.GP1724@arm.com>
 <20210729173411.GT4670@sirena.org.uk>
 <20210802102517.GA25258@arm.com>
 <20210802113330.GD4668@sirena.org.uk>
 <20210802123749.GB25258@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline
In-Reply-To: <20210802123749.GB25258@arm.com>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 02, 2021 at 01:37:50PM +0100, Dave Martin wrote:
> On Mon, Aug 02, 2021 at 12:33:30PM +0100, Mark Brown wrote:

> > That really doesn't seem like a good idea - it's just asking for
> > fragility if a signal gets delivered to the parent process or something.
> > Even if almost all the time there will only be one trip through the loop
> > we should still have the loop there for those few cases where it
> > triggers.

> This concern only applies when the program actually registers signal
> handlers.

> wait() can't return for any other reason, and it mustn't, precisely
> because historically software would have made this assumption.  This is
> one reason why wait3() etc. are separate functions.

That's great for the reader with a detailed knowledge of exactly what
error handling can be skipped and how standards conforming Linux is but
less good for the reader who is merely aware of best practices.  I am
not clear what the problem that is solved by removing the loop here is
TBH - to me it just makes it less obvious that we've handled everything.

> That aside though, can't we use popen(3)?

> I tend to forget about popen because it is "boring" to use it, but it
> looks like it fits this case quite well.  Then it would be libc's
> problem how to fork and wait safely.

popen() appears to be break the _SET_VL_ONEXEC test.  Between a lack of
strace in my test filesystem and not spotting anything obvious in the
glibc sources I can't tell exactly where it's doing something different,
though it does feel like it should be a separate testcase if it's
anything interesting.  I do think there is value in having exactly
what's done to start the child process be clear in the test program, and
that coverage of anything interesting from popen() could be done
incrementally.

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEH/voACgkQJNaLcl1U
h9A5lAf+JUyEqinK5kSJKo/4YANsc7DJi8c/mQqjkDbu85NGIhzBr41umgN72MB7
+lqBntPr1QdZgsUbYmk620LAcEN7aOsQtpxx9/XeVS3a+gg5u43KfETWYsHz5VY7
BKZlAzlbPZNbrZqAHPr8qHT37AN0xX/6OxTGuh0+62a74ux0cO7QPxWwv7UZwi1r
HwADx+GHjArCO9O1+GUgLzBWPQRt0HlE2k+aybwQ+/W/bHldGuBiwsHxY69FaRR2
ghSiUwIYXduhoqxWOIVa5UZulnR1lj4fPUjTA0O5EBwxb68PEEECLFKyZj0I3VMY
WY9LNe3B8E489kZxbvmGCLTY9Onv8A==
=35Nf
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
