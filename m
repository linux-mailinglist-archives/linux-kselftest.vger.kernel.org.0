Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9524774F0ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 16:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGKOAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjGKOAp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 10:00:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B710F0;
        Tue, 11 Jul 2023 07:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D536C614F8;
        Tue, 11 Jul 2023 14:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FF0C433C7;
        Tue, 11 Jul 2023 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689084037;
        bh=C5aimvSy1uuXB59oV7jyehu8pLiCWszQXE0xcUViaqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtVBEA6ncdi5oyxhNKcYOHmcsGB3XPs+V8afZa97TsEUGXTCt8NFnwD22DJcr+VCa
         9nKW3qz8v61jMFzXGDHvfglojqkLlLcrT4yHlnTGVdfUoknB/iju0dQ7u7cWa7Cuf0
         1oYYM6qHeKJ7X4P33jakory1uyE0i8D3igVpGsxpTHr+i9ODFx06aQPcftUtS/7nfd
         gw4rhECo5cMZ9UruP7ZPwbKdnO+ool4LaPC1OF0WwmzrZohGp3sQFWwMGhKDOlGsyj
         PSKH9Y90QlcxIA4Z9XNl1mVsnL1dzkJblLCn1eaj4A4XBwCq2RezsushQMsB12MjoD
         6plqbGghUmWkA==
Date:   Tue, 11 Jul 2023 15:00:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Message-ID: <8768fa96-004f-4e81-a380-a1a7784ad59c@sirena.org.uk>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <04a35122-5020-5ad9-7bdc-c17f9a27bf50@nvidia.com>
 <ZKx17G7ULaQox7Xo@finisterre.sirena.org.uk>
 <ec86c0eb-5c6d-48a2-c216-ec4f40710ca1@nvidia.com>
 <ZKyGh8AKRLobQKlX@finisterre.sirena.org.uk>
 <04724b21-6c7c-8584-fd17-9222051dc99d@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QaTq0OHcvbKpu6fR"
Content-Disposition: inline
In-Reply-To: <04724b21-6c7c-8584-fd17-9222051dc99d@nvidia.com>
X-Cookie: marriage, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--QaTq0OHcvbKpu6fR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 04:10:14PM -0700, John Hubbard wrote:
> On 7/10/23 15:30, Mark Brown wrote:

> > There is a floor on binutils version for the kselftests that's more
> > aggressive than that for the kernel itself, though that looks like RHEL
> > 8 which has binutils 2.30 which *should* be fine for most things - the
> > MTE tests won't build but they do have version detection so should skip,
> > I guess you might have trouble with PAC support which doesn't have
> > detection in the tests?  It's certainly old enough that I'm surprised to
> > hear someone doing development for anything current with it.

> This used to be a development machine, but now it is sufficiently old
> that it is lightly used--that would explain how I could reserve it on
> short notice for this. Maybe I'll adopt it and upgrade to a modern
> distro, now that I seem to need an arm64 box.


> > That does seem to work around the issue at least with a quick out of
> > tree build, including with GCC 8.

> Great news! That's really helpful. And in fact, I have discovered two
> more things:

> 1) The "emit_tests" target is there apparently because commit
> 313a4db7f3387 ("kselftest: arm64: extend toplevel skeleton Makefile")
> believed that it was necessary to skip emitting tests if not on the
> right native platform. I'm tempted to delete the entire emit_tests
> target in both arm64 and riscv selftests (and that also seems to work
> just fine) in order to simplify things, perhaps as a follow up step.

> For now I'll just post the simpler fix, though.

I suspect it might've been needed at the time the patch was written but
subsequent changes in the kselftest Makefile stuff have obsoleted it.

--QaTq0OHcvbKpu6fR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStYH8ACgkQJNaLcl1U
h9DQ0gf/WmpkiCf81vIuuCr9MlgdFCA5U0BFgpJTlxI+4NO5IV1/zFkBdKGavFGG
CEb+PVbj0x+3n5oCeNL5qaCPT90OC2IoVryVdWEnY3UwKIly8pFOGwB7I0GdMXQE
BWU7MPnJNe3RsISgvMb1Bt43LybmzLAw6vZcz6EKUxYD0eGcYrY3Hu1rr6KlwiYT
3oKRA8GIeaDT6ONTBBcPaHS78NuUB2SxX8ipp+K8pg20KVokzGxwljnaO86Gj/7m
kA2zDz16Ujwhd/3VjJXfFdqlvGWll9asKv5phsLnWzkOqBIMJ1wqd7QvdMDcHS4M
KT4Vl+btdE6q7uQDyZ111/4UDH2nxg==
=nRFw
-----END PGP SIGNATURE-----

--QaTq0OHcvbKpu6fR--
