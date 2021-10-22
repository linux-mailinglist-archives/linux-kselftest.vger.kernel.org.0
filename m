Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7702343785B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Oct 2021 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhJVNvs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Oct 2021 09:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhJVNvq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Oct 2021 09:51:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 798296120E;
        Fri, 22 Oct 2021 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634910569;
        bh=wasqAXJABwWIMN9083gbkCvBk1ASO/3vSMZxS7vRi8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXD+k/LPoXUFJt860tVG4E65b7p+5AJ0SsSBuWhmTdvCgOXTi5ldeNgGOVVGPFu5d
         qH32OzsauFYNVZN81YwRA3+CEfbe4acyDJsLlf1rriyRvWAalrLAYaQzb+vyh0KYnU
         qHLmOgYzRNJ/VheBVSjk+fwFHcmRVWiktzdBamXxNNb3EXN9gZC/wiVgLE9udMUKLF
         x7Hhcso3QEf7Ggw9LB8AwsDX5IvMi06nuPeZej5kfNd47lYbYSz1fhdpYi4kksDk/7
         Ksylit2shefZOi17CB1UWkVTSSKJhfKj43HCHgmySTtjpsW/7TSDbJ7yh8MhMUFGCt
         kmU5B/K+xO/Yg==
Date:   Fri, 22 Oct 2021 14:49:26 +0100
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
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 07/42] arm64/sve: Put system wide vector length
 information into structs
Message-ID: <YXLBZrxlqs7cPGzM@sirena.org.uk>
References: <20211019172247.3045838-1-broonie@kernel.org>
 <20211019172247.3045838-8-broonie@kernel.org>
 <YXKfKJHRkiu6AXqy@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7aB3Vt8ajWzS8quD"
Content-Disposition: inline
In-Reply-To: <YXKfKJHRkiu6AXqy@arm.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--7aB3Vt8ajWzS8quD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 22, 2021 at 12:23:20PM +0100, Catalin Marinas wrote:
> On Tue, Oct 19, 2021 at 06:22:12PM +0100, Mark Brown wrote:

> > -static void set_sve_default_vl(int val)
> > +static void set_default_vl(enum vec_type type, int val)
> >  {
> > -	WRITE_ONCE(__sve_default_vl, val);
> > +	WRITE_ONCE(vl_config[type].__default_vl, val);
> >  }

> Same here, it should probably be static inline.

TBH I'd be worried if setting the default VL is sufficiently performance
critical that we have to insist on it being inlined - it seems as well
to let the compiler make the choice if it wants to.  It's only useful
for the gets because we need a stub.

--7aB3Vt8ajWzS8quD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFywWUACgkQJNaLcl1U
h9DD2Af/SjYwT92seV1iv0YeNL07ul38QdstN3GPVi5GrUxXzxe9gtKCzJzvYyEi
a33b+liuicTjDKBySjmekLurLFf95HeAHMZyGVbcq17YRq3JuRiUCOKPs/Xbrrry
VBUEwfQFLtVLocbVsE4NRCgR23/Ts48EATeWag9CR8YXHcCyW3EyDsXH3bS1hech
YcP+/ydiyYS/ZcorrrBNXgZtb0NmOVVlBzPBS0fHtytCkOX9BvQxZEW39T34bRTV
8aF6MrEDb21S/hIgUubmS69LdxLivsbDnpY/xu7+LbHZVr458mH5PXRpeDR+BnOu
M579Mewi1v5W88dgXacNA0g00RzIDQ==
=ObmI
-----END PGP SIGNATURE-----

--7aB3Vt8ajWzS8quD--
