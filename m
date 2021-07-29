Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D373DA860
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhG2QD4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 12:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231906AbhG2QDs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 12:03:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 694E560FE7;
        Thu, 29 Jul 2021 16:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627574624;
        bh=I5/0wbvQjRtUZGZp5PJXGGfoHYJ5B7fFWhCC4Bvu9Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RHXfURQ7sRXeSta3ZMDiV66PboyLoatlfyQA3dG/CJiZxomFi1nF4n+HQ8tiO9hUo
         9YkfJuJzkEJNk01RYJ/N5RsOKlczDGuPys2Qp2aed5WreMZAQbMC/tVJKwwYeMME/5
         nJ83NQMN1nQ5sPKaBs4ERckEWVMAg+Z2SSp7APbyHPZTXl8IsXLPdu+XzSaQusEv0z
         hngrQT3d1YqcOFas/jxbqfPYC6yf8cXoGAGlP23SM66J2lJaLSbBnmIWRsXDis6jII
         o1emrtDUOFj0pgdfUadBjY8uErQViEiICeofVFnadvOPXc3RhXf7R7fFkq0aQNR9Mw
         pNvzmq24Q91FA==
Date:   Thu, 29 Jul 2021 17:03:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave P Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] kselftest/arm64: Provide a helper binary and
 "library" for SVE RDVL
Message-ID: <20210729160334.GQ4670@sirena.org.uk>
References: <20210728163318.51492-1-broonie@kernel.org>
 <20210728163318.51492-2-broonie@kernel.org>
 <20210729095222.GH1724@arm.com>
 <20210729112217.GK4670@sirena.org.uk>
 <20210729132701.GH20179@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bffnoS4O5HScezMk"
Content-Disposition: inline
In-Reply-To: <20210729132701.GH20179@e103592.cambridge.arm.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--bffnoS4O5HScezMk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 29, 2021 at 02:27:04PM +0100, Dave P Martin wrote:
> On Thu, Jul 29, 2021 at 12:22:17PM +0100, Mark Brown wrote:

> > Yeah, it doesn't seem to be in the slightest bit idiomatic for the arm64
> > asm code the kernel has.  I don't know if you think it's worth adding
> > that to SYM_FUNC_START now we have it though?

> Actually, I think the core definition of SYM_FUNC_END() in
> <linux/linkage.h> does this.

Ah, so it does.

> It would be good to pick up the common linkage macros; if we have to
> sprinkle .type manually all over the tests people will likely make
> mistakes, to that's probably not worth it.

> If picking up the macros isn't trivial to do, I guess it's not that
> important at this stage.

They're not exported from the kernel at all at the minute so that'd be a
whole new block of work that feels out of scope here, we already have a
stack of asm code in selftests.

> > that those are outside the kernel either.  We will have to do something
> > like that if anyone starts building userspace with BTI though (or I
> > might just shove a BTI C in there unconditionally, I'm sure we'll cope
> > with the overhead on older systems).

> I thought about that, but that .S file isn't annotated as supporting
> BTI, so I guess there's no problem for now(?)

True, we'll generate linker warnings but it should otherwise sort itself
out unless someone forced BTI mode.  The whole annotation thing really
isn't fun to deal with for assembly code, hopefully there'll be some
toolchain improvements in this area at some point.

--bffnoS4O5HScezMk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEC0VUACgkQJNaLcl1U
h9Cc1gf/ZesM/m/TLkTq7nJ21Nb8QcZjkeLs9CfQugMPwXN92xFgte7QI2dp9pce
6LyZkxrzRq5bCmPcSzEMNt0ZQjZl1C7BWbydEL7ZtJZ/9WTporheuK+NiZ6tj5LS
aIltc3v4EICJvp4uVwxXmOQi+sTbegxLPsBOSFeBf2cbrjQJ4RVi95rDaqc5O52b
8uXwciinghPlFlX1cLr7R90Wjpgh0ZX+7k2YI5hjiGcqipOHX/fM9gg8lButqFU5
/vCWuYKgPz97/RaFVkEi9rwKurnsNEpc4JOfrlC/zEAt5PbMxkOHeOujS4JnMNzP
3CuDkXWts7H/jswzeocLKAvSfjb3Dg==
=qxKu
-----END PGP SIGNATURE-----

--bffnoS4O5HScezMk--
