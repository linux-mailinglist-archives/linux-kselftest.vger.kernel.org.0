Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BFF7E459C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 17:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjKGQPp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 11:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbjKGQPb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 11:15:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13CDA25F;
        Tue,  7 Nov 2023 08:07:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFA0C433C8;
        Tue,  7 Nov 2023 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699373226;
        bh=qt8mBKKeBYKkff8R7gCnVYHBMt8O03gHumJCiEar4VU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5+9Mi1WpPk9vBDdZunajdAtfdVEfLxRikmymj4bCsI5dv6lslMEP42pnzP06Q6cL
         9nWXDA2OHE0eNej2TNI7pYwn4qiPa0MIm1ckVpVqv5im2wuudZpkseWuB6kmCYxTza
         BMNR8UP3JNELDTCAOVO5wHR8iU/of9BRu8ID0coJzuU/GR/i9htQl43S9xUhQ8cPYk
         pVw6k2qNC27CMQ72FsdOsHtiruV3WP0tVbNoHVP1FpNQkHZyGvqSGcZd7VydjujmZE
         M8YBi9hn7TZ+7/DMxD4A3ZACxP0tBhxsnJPsCR1AZdOIqHQwov988O0y3v5mJAp0MF
         eww2jzm0o6/BA==
Date:   Tue, 7 Nov 2023 16:05:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Subject: Re: selftests: arm64: fp-stress: Unable to handle kernel paging
 request at virtual address
Message-ID: <ZUpgZ65SYqKVeQoo@finisterre.sirena.org.uk>
References: <CA+G9fYsrLTbFkz-LJmAY9efDyEr-8bHcxivBDPToPjBxjStoDg@mail.gmail.com>
 <ZUpH0FNTYAl9Z+L6@finisterre.sirena.org.uk>
 <CA+G9fYta5cUpFArGfON3R+HUGxJRyEsc9zdTwwk5Un+wHqLN8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="95C7jDeNt3c0BqKs"
Content-Disposition: inline
In-Reply-To: <CA+G9fYta5cUpFArGfON3R+HUGxJRyEsc9zdTwwk5Un+wHqLN8g@mail.gmail.com>
X-Cookie: Slow day.  Practice crawling.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--95C7jDeNt3c0BqKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 07, 2023 at 08:14:59PM +0530, Naresh Kamboju wrote:
> On Tue, 7 Nov 2023 at 19:51, Mark Brown <broonie@kernel.org> wrote:

> > This all seems very surprising, especially given that AFAICT there are
> > no changes in stable-6.6-rc for arch/arm64.

> We do not see on the mainline and next.
> Is this reported problems on stable-rc 6.6 and 6.5 are due to running
> latest kselftest on older kernels ?

There's also no backports I can see in the selftests (at all, never mind
just arm64).  There were a small number of selftest changes for arm64
went in during the merge window but nothing that looks super relevant.

--95C7jDeNt3c0BqKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVKYGYACgkQJNaLcl1U
h9DdWwf+MMu97uld9xtcDaED2X7a2u2theIQch48gWqnprnJIlfclOC9DRVv49DT
bEVDRXQl2reUikWIJFZLXsNRAq3CC+OTQBOBAzvQ/NGh9Cq83t99c14wpnZg9fO6
raSV5rJEwTieCAhzdmdW5WeE/LD6LcAc7aZlMH6rc/llF50gUa9I5yLc3dpXx/Uo
HZwZRpfGLLEMAJljuT1xbwgV2mL3j2QNoIMPTrSw0XdpXaW25r+SxaDKBUxufN6Y
Hjh2XLdNE02R/r9gDj+5gF1RWz7hcF1k4tAUOnwUGWrtoPTzK81/E1WDRJz1VFih
G7HgptmbZHud3B5PPHJ10BKoB2DbCA==
=Rr33
-----END PGP SIGNATURE-----

--95C7jDeNt3c0BqKs--
