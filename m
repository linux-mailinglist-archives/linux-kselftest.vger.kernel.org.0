Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE643DA205
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 13:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhG2LWb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 07:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231834AbhG2LWb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 07:22:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD06E60E9B;
        Thu, 29 Jul 2021 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627557748;
        bh=FcuFb6wlftgSlWoSTOwAzofJHtrPrqyxkS6xE1qzB18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgFR7CinLkyo9QZHPWgXRDYxvxgVlAX5ZnAvM7+uaERbBP/+0Nk8CrssxnHdA1GVO
         VwPzF8ohmc5WNK1lLDaKooQnEdekJwXFyMN1B8QSl9xIYqaJWYWbsm0LG+ECjFSexT
         fmpj4eHip0n/RahaZGTGviOFozrfTG5L9bm3NBReepiczNueyxMnBaKz3+QKlTA7gm
         ojQqLoPoSVIxJ5YzUDIwAJepzu+yzqBxunjI8tHt7tqmLRRF+fDjmuF3Cj8jzhE/+F
         cR5eG5G8O4FmTuMjLzYWeWJpSxXLwiauihbz2jf3/irj+s0XRPlTQarJRXvAAWwzcP
         +1Pzq+//TjnDw==
Date:   Thu, 29 Jul 2021 12:22:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] kselftest/arm64: Provide a helper binary and
 "library" for SVE RDVL
Message-ID: <20210729112217.GK4670@sirena.org.uk>
References: <20210728163318.51492-1-broonie@kernel.org>
 <20210728163318.51492-2-broonie@kernel.org>
 <20210729095222.GH1724@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J3rqiH0DIeiRD2zz"
Content-Disposition: inline
In-Reply-To: <20210729095222.GH1724@arm.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--J3rqiH0DIeiRD2zz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 29, 2021 at 10:52:24AM +0100, Dave Martin wrote:
> On Wed, Jul 28, 2021 at 05:33:15PM +0100, Mark Brown wrote:

> > +	return 0;

> For consistency with the changes in vec-syscfg, we could use
> EXIT_SUCCESS here.

0 and EXIT_SUCCESS are defined as equivalent (though they need not be
equal!) and 0 is much more idiomatic.

> Although it's hard to see what could go wrong I/O-wise that doesn't
> involve vec-syscfg itself having gone wrong, it's probably good
> practice to do the final error check:

> 	if (ferror(stdout) || fclose(stdout))
> 		return EXIT_FAILURE;

> 	return EXIT_SUCCESS;

> (In reality, people rarely seem to bother with this, so I'm not going
> to lose sleep if we don't do it...)

Yeah, I think this is one of those raising more questions than it
answers kind of things.

> > +.globl rdvl_sve

> Should we stick a

> 	.type rdvl_sve, @function

> here?  This may avoid surprises with future toolchain behaviours.
> Probably doesn't matter, but I have bad memories of Thumb-2...

> Lacking this annotation is widespread though, as well as being de facto
> standard before awkward architectures came along.

Yeah, it doesn't seem to be in the slightest bit idiomatic for the arm64
asm code the kernel has.  I don't know if you think it's worth adding
that to SYM_FUNC_START now we have it though?

> If the selftests have access to the ENTRY() macro we could use that, but
> I'm guessing that isn't exported for userspace.

We don't use that any more anyway, it's SYM_FUNC_START() and friends not
that those are outside the kernel either.  We will have to do something
like that if anyone starts building userspace with BTI though (or I
might just shove a BTI C in there unconditionally, I'm sure we'll cope
with the overhead on older systems).

--J3rqiH0DIeiRD2zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmECj2gACgkQJNaLcl1U
h9A90wf/V5EUCOkVbK4/Pt1Gkd/v98yXPokeJTn6vhVPDVSOBo6QH2mv/LUQfRID
mPJ3b4UXdi39JUOefgfn+4MZjQzPcZJUO3TI5Osny2BXPWj5Ii5L6aV75iOEInyg
Dc6eY/Anr/KVQcnETSmKJXrS2ZNOY6H8ZDkQmz6mW0NPBoNL5h0rnEF4FTJhDnSw
LrvmSLlNeqEVGF1f5OiH+AOR9uZNr9+6msOVoR1cqT/JZjVuZzAXHG9EUju4Krdl
wdiAOagB0dPN/xq9mbyu6AgCqZQF3VCR4/C0VYeqNwXYjXwobrXGRaclQFC7y/Kk
QqINh0AbZJYVbKT/0f2FIrGlO547QA==
=xtv7
-----END PGP SIGNATURE-----

--J3rqiH0DIeiRD2zz--
