Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3275662C354
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiKPQCa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 11:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiKPQC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 11:02:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440854B03;
        Wed, 16 Nov 2022 08:02:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E23461EBF;
        Wed, 16 Nov 2022 16:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FA9C433D7;
        Wed, 16 Nov 2022 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668614547;
        bh=TcEbmGJjNsv4Ftednt9yZC3FbP7kzskTZo9SDvFCzHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9MpqF0z9M9S/v1+qR0ItdXQrRLG3fNlaPd5eD/p/f2LbrF+IMS5n36jljF1asxn6
         c7Te7M0CPQqHptjmDFyAU0hVJhBuifLj5RZJdhvOVXmyEKJW/pTcU0s3r+yXTK/wtK
         xhMTyvcJXSUrRHxAYZivCXGMfTh7kW96UW3FHBna8dcuKkJi9RH9IY/1nBmVejGVd5
         1dlRyednE7m34wPkEkqG+9YfB7TmkWNUkyCQ6oDkRakwQenweDmPRAynZ1q+ewxjRF
         Ex67aOxMwuU6VWkhEb8YBv/gMp5rF28QJFpdi4Mn7lOBJrEeP08uEoB+5YFze9+eoI
         eVkNhHkC0R8+A==
Date:   Wed, 16 Nov 2022 16:02:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Remi Duraffort <remi.duraffort@linaro.org>
Subject: Re: kselftest: Bad test result: from results parsing in LAVA
Message-ID: <Y3UJj6v8xv2rvMp5@sirena.org.uk>
References: <CA+G9fYu0p4cFdkrkQyV4OC-iPpY18asV0VTP=O_sysLNaJJAQw@mail.gmail.com>
 <Y3TlVAgo9XSWKm1h@sirena.org.uk>
 <CA+G9fYuckvzw_t4iSQ5Kj_FvRb-bfWaT66DazEejrKXePaDGuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QuIAI3jeL4BDw//t"
Content-Disposition: inline
In-Reply-To: <CA+G9fYuckvzw_t4iSQ5Kj_FvRb-bfWaT66DazEejrKXePaDGuA@mail.gmail.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--QuIAI3jeL4BDw//t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 07:36:10PM +0530, Naresh Kamboju wrote:
> On Wed, 16 Nov 2022 at 18:57, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Nov 16, 2022 at 05:46:33PM +0530, Naresh Kamboju wrote:

> > > Test results parser showing =E2=80=9CBad test results: =E2=80=9C,

> > When reporting an issue can you please try to provide some
> > analysis which goes beyond the level of "I saw an error message"
> > - for example here it's hard to tell if you think you're seeing
> > an issue somewhere in your test automation system or if you're
> > trying to report something in the tests.

> Let me add more information about this,

> Kees Cook, has done the work of a kselftest results parser in perl
> which is in the test-definitions repository. which was working well
> for two years now. please refer to the below commit log and link to
> the kselftest test-definitions [3].

> The new test cases output is not coping up with the old results parser
> and both KernelCI [1] and LKFT [2] using LAVA have noticed.
> Kselftest results parser problem [4].

I'm still not clear if you believe there is an issue in the tests
or in your test infrastructure here.  I can't identify any
problem with the test output, everything appears to be within the
KTAP spec:

   https://www.kernel.org/doc/html/latest/dev-tools/ktap.html#test-case-res=
ult-lines

My best guess is that either this script which the infrastructure
is using or something else that uses the results of the script is
broken when the test description includes spaces.  The KTAP spec
says that each test case result is a line in the form:

   <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]

where

   The description is a description of the test, generally the
   name of the test, and can be any string of words (can=E2=80=99t include =
#).
   The description is optional, but recommended.

ie, anything after the space following the test number up to a #
or the end of the line is a valid test description (it's not the
intent but it does appear that the # needs to have a space before
it).  You could argue that non-alphabetic characters are out of
spec for the description since any separators between words
aren't themselves words but realistically that'd invalidate a
fairly large subset of the selftests which probably isn't
constructive.

--QuIAI3jeL4BDw//t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN1CY8ACgkQJNaLcl1U
h9D+Hwf/WcLRCEFjVXwxjSQevEenU/4QXRyju/vgjjnV5cmJ973j+KnguN17ofSy
bwcuSBrmx1AhtsCSg5qT+DSpBCQ89rBEA2qG07nn4qknOP6ISZCJ18rOWNjlHkIL
Fa9IbAsPRlvDIdVd0R8IZpT3k+A0CpLPr6Mv1JCLGeZM2wYfOu8TQXTsvgYgCH6I
nslVd9O4QrQdKgweQ/HZkdJES+mzFhgMkg4d+ZEzRfn0c+/WEz2vREojyLnfwjkx
7sUeelLSGDQJvAMX0oJE+r7wRkKr4+t/OiAFXkfNucm/Yam8HLBg5yxwgZ5EVCx5
TtcsIv1230xO/vKLsLJ1C2gi3UymUA==
=4vqB
-----END PGP SIGNATURE-----

--QuIAI3jeL4BDw//t--
