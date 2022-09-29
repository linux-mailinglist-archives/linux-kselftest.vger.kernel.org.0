Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582BC5EFA47
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiI2QVy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 12:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiI2QUN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 12:20:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44852253D;
        Thu, 29 Sep 2022 09:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9EC2B81E59;
        Thu, 29 Sep 2022 16:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2BEC433D6;
        Thu, 29 Sep 2022 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664468382;
        bh=a2NGbV0KNZ4CqbaOXaD8TLvI2KNvPxg0PZC3tUgSAXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQQkiBB0DRXdQ2K9agjn79HAWa4krFA9RP2nzH5BOZUjA9v563VRs1jAXTryMyM84
         JrNhfq4xfgy8RacwJzmibVTpEQ0IL0YSrzVLLaa4heLnw24y2I3Vhs3T6ez9iQRXX2
         Vr5qGLq1xoWRoyQKQH35/LcwMDQhllgfPyoeegsNtLhxs2vaKew/05nGxwDzEKsmp9
         C1Z9cTVf+KWAkj2XiiW0Itac70ENUM9yRKiez+PiQKO90f8e5WMNAPPxHmDiOpbBJW
         ZeGwqWI4Wzf9ysRHoUhUXeYjhPpoL+Df5Q0n2ADiC86wa8XAZ8K48p6aHEXDkP0MwM
         i4M3RwO1l5Fig==
Date:   Thu, 29 Sep 2022 17:19:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Subject: Re: selftest: arm64: missing install files
Message-ID: <YzXFmT1qYz6inFrC@sirena.org.uk>
References: <CA+G9fYuw3Xn2wPc3_MXsJFNx7O4Zu91wFt+VsK4qwKMB7HdGow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="33saO4ZIu08nOG3h"
Content-Disposition: inline
In-Reply-To: <CA+G9fYuw3Xn2wPc3_MXsJFNx7O4Zu91wFt+VsK4qwKMB7HdGow@mail.gmail.com>
X-Cookie: Last week's pet, this week's special.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--33saO4ZIu08nOG3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 29, 2022 at 09:03:54PM +0530, Naresh Kamboju wrote:

> While running kselftest arm64 tests the following list of tests
> were missing which means those test binaries not installed on to the rootfs.
> Not a part of "make install" do we need to fix Makefiles ?
> or am I missing something on the build machine ?

There's probably an issue in either the build system or in how you're
using it.  I'd guess if there is an issue in the source it's in the
generic kselftest stuff rather than something arm64 specific.

> We are building on the one machine and testing on multiple arm64 target
> devices. Please refer to build log [1] and test log [2].

The build log does not seem to include the command used to start the
kselftest build and I'm not clear that it includes anything from the
install step at all, never mind the command for it.  As far as I can
tell everything built fine and something that was done between the build
and trying to run the tests didn't work as expected but there doesn't
appear to be any information about that part of the process.

An example of a build which builds all expected executables and installs
them into a tarball for deployment on a system can be seen here:

https://storage.kernelci.org/mainline/master/v6.0-rc7/arm64/defconfig%2Bkselftest/gcc-10/logs/kselftest.log

--33saO4ZIu08nOG3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM1xZgACgkQJNaLcl1U
h9BzIggAhAO2Zs+LoHq9Y2Mv6ukTR9Ov5khaZ3FqGWR711cAKf6nH2I2A53kXs7A
SAB1kfoymnsGkkKGD1XYchfcK5J+F+MAh9KTET878gWhHiF29AZzhWIX+LCn9xZ5
nG2JE2mMb9lWTtlsUlRGXHQ8cRnkpq1dZIneVw6lqeQxMUZh8XFI9P4+l0pHcnPi
EmWeLn69wV62Y+Zo8qdlAQfPjFtVYl1HEkdldnzbDZnWuGlZl4jJzqiQ/l9QrhLk
S06FJF0h70rGrWiyQ7T3zcQ9qtOlSDqUqbqw71iN2sr1h5CPTMVw9cX3J9UVNTZQ
yWTz03UbHESNlHnIYNfN2UE97ZsWiA==
=2rQl
-----END PGP SIGNATURE-----

--33saO4ZIu08nOG3h--
