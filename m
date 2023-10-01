Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E927A7B46B7
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Oct 2023 12:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjJAKYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Oct 2023 06:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjJAKYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Oct 2023 06:24:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ACABD;
        Sun,  1 Oct 2023 03:24:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612AFC433C8;
        Sun,  1 Oct 2023 10:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696155847;
        bh=3J4Ci8pFc+DmlurKYeaxIe2BPvpv1QL1Ctd0FLxCkOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3JZViOEUlr1YJYSb2kQFv1rP2FtU8VqiyxF4+VzqNWNUe6k6+o2UC9oul8z+Ffzk
         msrf5tUGF4O+oKzzyuWwccHmDg1TlUc7vjqLwipmVMUJ8QucZI91R4+eByhp7gCIFV
         VC5QTwg+g1/HpTsTCl6mykLv1TH7HULSF1sO97TJPVGlaVcnf3LyUb39RDfVkWENtO
         yk802GSKR0TAi+Xj86gTg4cK4VGWSrNcrOoZQ/eia6EHiQD05i3Ycyw09Jh8ml2rl8
         B0y9U6sh1G9salLhXz9RRQKTG+Os9gX00W6Uj7QxSt6qWhf5KsoPnmIHBuOiOHq2Oz
         Ued1RU3mhAhYw==
Date:   Sun, 1 Oct 2023 11:24:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kselftest: Add a ksft_perror() helper
Message-ID: <ZRlIxEz7P1OcqxEo@finisterre.sirena.org.uk>
References: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
 <20230928-ktap-exec-v1-1-1013a2db0426@kernel.org>
 <202309281747.594B3352@keescook>
 <ZRaB3SfRaUFsP7XN@finisterre.sirena.org.uk>
 <202309291031.1B2A2EE@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UDoYUhKHud29veub"
Content-Disposition: inline
In-Reply-To: <202309291031.1B2A2EE@keescook>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--UDoYUhKHud29veub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 29, 2023 at 10:31:56AM -0700, Kees Cook wrote:
> On Fri, Sep 29, 2023 at 09:50:53AM +0200, Mark Brown wrote:

> > Like I say it's for nolibc - it's just some header files (all in the
> > kernel source), while it generally aims to be libc compatible it's
> > intentionally very small.

> Right, I mean, how would one normally encounter this environment? Running
> the selftests on m68k userspace or something?

There's a bunch of selftests that cover interfaces that are intended to
be used by libc which are built with nolibc in order to avoid the tests
and glibc stomping over each other.

--UDoYUhKHud29veub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUZSMAACgkQJNaLcl1U
h9DD8wf+KAOPJMIi0AOD0kssdg4itbJeEYP6scQJZaQjT52QUboMEmHpC+NZDSGs
3T2YrxxvJiBiaFcfxTYZFQ2fEt6ogyMfqWDFahGqJUkvl2LW0qHjlXedXmSwQ2Qj
Av82er5/kd9QvhOWulW6V7kV7cc78dA5TX2Oj90ZFGGSDHusIzIaJ3H4oUDYSnn8
IoRX41NcdIDBAupikf1TsEOcPlPJ9krHwuWodc7Vz2R25tCBPiS3BF4IXnE/vHLZ
nKV4D1MP8PsisTbR+bIGKCiwfBR7rEnGdBJE4pWK6/nQpq1t+w24yjw+ZEdWpGSa
Fi4O76w93xiFVM+saYPKaZ2xXh7Qsg==
=dHwy
-----END PGP SIGNATURE-----

--UDoYUhKHud29veub--
