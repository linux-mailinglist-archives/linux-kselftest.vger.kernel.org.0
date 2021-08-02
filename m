Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356803DDD8E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhHBQX7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 12:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232725AbhHBQX7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 12:23:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22C4860F55;
        Mon,  2 Aug 2021 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627921429;
        bh=fd0w1leBpZOJYXNsXSHQymGiFrTvsUyV8+apyFqO3Vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlNmuaEcNUJU3Ex1p3JPV0swOJZCg6GKrLclfL78dIfHlNe0wtSwTnXVNXtPOTKJp
         Rhhr6VHurUld6WiDQ3IAtUdl9Ov97WED4czGMLcxcg6vGjplgKbewHhLN406Vxfm3C
         ZR9dwTQ5Tqweq5dGClvwuHABhI+l//ZN+M/e2zpcMalQx3U9ymcjboGaATRdr1LIIh
         vUXU1IuMIyoHrkEwa+m7KySILmMRGEP+KRJSfg6siSlS+pwn1Ir7bd3H09SqzUYf/l
         4iciUBTCLfCkCE1UVNF7IhX+/Q8OKcbJ6m81gurvElZGYRXPC7w/Ty32B1IIQQR+pS
         IhYJ+nCuwNQuQ==
Date:   Mon, 2 Aug 2021 17:23:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210802162331.GJ4668@sirena.org.uk>
References: <20210729151518.46388-1-broonie@kernel.org>
 <20210729151518.46388-4-broonie@kernel.org>
 <20210729160642.GP1724@arm.com>
 <20210729173411.GT4670@sirena.org.uk>
 <20210802102517.GA25258@arm.com>
 <20210802113330.GD4668@sirena.org.uk>
 <20210802123749.GB25258@arm.com>
 <20210802141939.GF4668@sirena.org.uk>
 <20210802153614.GC25258@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="utPK4TBebyzZxMrE"
Content-Disposition: inline
In-Reply-To: <20210802153614.GC25258@arm.com>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--utPK4TBebyzZxMrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 02, 2021 at 04:36:15PM +0100, Dave Martin wrote:
> On Mon, Aug 02, 2021 at 03:19:39PM +0100, Mark Brown wrote:

> > popen() appears to be break the _SET_VL_ONEXEC test.  Between a lack of
> > strace in my test filesystem and not spotting anything obvious in the
> > glibc sources I can't tell exactly where it's doing something different,
> > though it does feel like it should be a separate testcase if it's

> Ah, dang, popen() will run the target program via a shell, so there will
> actually be two fork-exec()s, with the VL being reset to default by the
> second exec.

Oh, of course - it's basically a more useful system().  The bit where it
adds the sh invocation was buried somewhere in the glibc source I didn't
find.

> This is the kind of reason why I tend not to go for it, I guess --
> it looks convenient, but it's just that little bit overcooked as an API.
> *sigh*

Well, if you're working at the stdio level it's fine I think but this
program is at the level below that.

--utPK4TBebyzZxMrE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEIHAIACgkQJNaLcl1U
h9A6GQf/fOOEjQoqwxQmiqEZMKB+y9/JbHA0Xq11RMwaD3+Hq7+cV3muzAFjz5dm
dt/A0IaLXG8oPzZbWQCygNYkLFM1/4qBu0gBx7lrxOOQSkd3wTV1g0B1Nzw6hY7t
my/7vPIrRCQknm61cIaYjsJOoJlKDCDnsqjKw1NwEeoQQMmQX/V/WYDPQO3fW6GK
orQf8/K7Ldjvae41Fc+yywMC0xO4a3Nnvze1bRceHutjDz9+RKxgSHphBtBXK9Bd
z2SrLPdokOVATMnGjKgm9io6jsnTDFlIDbF1tTYaVSHMPLHCb+qyGptIH/4KsbyS
9FfbUbSVqZF+OKNOu1/icrTWZlB8Iw==
=wSrF
-----END PGP SIGNATURE-----

--utPK4TBebyzZxMrE--
