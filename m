Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DED8665F17
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 16:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjAKP3h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 10:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbjAKP31 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 10:29:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4674A1EAF5;
        Wed, 11 Jan 2023 07:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6DF61D74;
        Wed, 11 Jan 2023 15:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0B9C433D2;
        Wed, 11 Jan 2023 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673450959;
        bh=k4EqcXKa2U93Bvz+LsthhVfBPtBJruA6ZLU8JV/bTZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LcjJBqeLPdr8XdBk1zgpCopKKfq+xpbLUisTnLQ3h2++hvdQ5hD0PtE5JyIY2cSmS
         x6QnoFvJ8dBBUL1VmeR/o3agtSOuLkDEeP9M89lCwUn51tq1A7XKyOPGyqW3UxRnZA
         7DyaaElQ7K4hrfUqi/a4/oZuaT/27J+YhAq+YCgoJYwZK05gyT3v1t51kxgmGkJ0Ng
         wVV5p0oc/TXhMbjmEy0tUzUh2k8G58R8m2h+B9DwGe3eI19FdNLuviH6cZUx1MLAIn
         OA0KY9dr5FejzCRwlyYm6ict6znb1xPyvruac2lUPyWIAkVnWpGtjEdAths57W/a4p
         9NK4NtOcBu+zw==
Date:   Wed, 11 Jan 2023 15:29:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkft-triage@lists.linaro.org, skhan@linuxfoundation.org,
        will@kernel.org, anders.roxell@linaro.org
Subject: Re: [PATCH] selftests/arm64: bump timeout to 15 minutes
Message-ID: <Y77Vynb+rhiQMJQB@sirena.org.uk>
References: <20230111142912.81606-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OpEFxpQGrRN7OL+v"
Content-Disposition: inline
In-Reply-To: <20230111142912.81606-1-naresh.kamboju@linaro.org>
X-Cookie: Life is not for everyone.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--OpEFxpQGrRN7OL+v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2023 at 07:59:12PM +0530, Naresh Kamboju wrote:

> LKFT CI found that with the latest mainline kernel (6.1) on
> some QEMU emulators and FVP, the following tests will take
> longer than the kselftest framework default timeout (45 seconds) to
> run and thus got terminated with TIMEOUT error:
> * fp-stress - took about 11m30s
> * sve-ptrace - took about 8m50s
> * check_gcr_el1_cswitch - took about 6m
> * check_user_mem - took about 3m
> * syscall-abi - took about 5m

We should really only be applying this to emulated platforms, all these
tests will run in a much more sensible time on physical platforms (eg,
fp-stress runs for the target of slightly more than 10s on every
physical platform I've tried it on and I've no reason to believe it'd
have problems on others).  Even for emulated specific configuration
that's a bit of a moving target given the range of emulation options out
there.

I do also note that the systems you're using appear to be giving
astonishingly poor performance even for emulated platforms, for example
on my desktop here syscall-abi takes about 12s in qemu and what the FVP
internally thinks is 10s there for the default set of vector lengths
(the actual wall clock time for the FVP is more like 45s, but I'd expect
the runner to enforce the internally recorded time).  Even fp-stress is
running in about 20s on qemu, though it does rather badly stress the
current versions of the FVP and start getting up to something more like
what you're reporting with 8 cores (the biggest performance issues there
are for things that stress multiple cores simultaneously).

Conincidentally I just wrote a change to the ptrace tests which will
reduce the number of cases which will reduce the I/O costs a lot if
nothing else.

--OpEFxpQGrRN7OL+v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO+1ckACgkQJNaLcl1U
h9B0Wgf/enT1TUVf8j97uV900bXkgbamjFrE4LK9cU//1/7Wlo5kf0evIp/A7pwm
mHWMr8Zw4eRxoemDXY74qE1nbDo1EU52XM006lKnSIcFvfq9qnbZkt2nsndyuXbB
+NyWKQ3sjqsoO6UVs/jl9HyA7ZyAyeYQnaWTeEtMD8ionSjpjJcYUg4v0god9CfR
11x78bbe5ugPtIW/68CqjK24EQnED6iMZXzt/yLcgrHgBazC9+ml9JxrfuVQCaY6
EB273IF166Cu93ijgnHNyebcN7NhRZP58mSYAAoohfIXrhXawjAFUuKA2pQ9/Fsb
1+sP3N99zbyewIHcIK/DM9Dyxr3XXg==
=SJkQ
-----END PGP SIGNATURE-----

--OpEFxpQGrRN7OL+v--
