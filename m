Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C906BB3AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 13:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjCOMxy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 08:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjCOMxw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 08:53:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEFB95441;
        Wed, 15 Mar 2023 05:53:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B33AB81DF4;
        Wed, 15 Mar 2023 12:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7799C433D2;
        Wed, 15 Mar 2023 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678884815;
        bh=73YQjdWBQ7W+f1WTCO1fpecJQkpb+JY7Fg21petFwTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtfzCLi+N05uMJ+YAB5G3kk5X3kxSCSkY4mPoYpyahE2ZFPIHIX2nMF4ECQZ/XVSw
         CDCEmggVKj6b9a5Q4ZpikbxfrMgpuDOe2weeOqdkb7UwRHNC6JMmZwSRmsKt1tqnmq
         cRAi8oetJn7F5TUwM5skyJUFSSZukvXeJdELQD42mkk17JZAhORKYWhIc5/fdPpLJf
         uO0QU//JVCfvvf0Wb05vtlAU1KZZz9JL1bPRW7wN21uf1PlkDRFc+l+2nTuF9KQHST
         YWfH4JPKFfgpRV+bAajeo3oMfETA8bdKeAm38lQa+poREA/eFWXxoHTpJBB/RnzOWR
         hDP4i8LNXMAgQ==
Date:   Wed, 15 Mar 2023 12:53:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     kernelci@groups.io, rmoar@google.com
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "dlatypov@google.com" <dlatypov@google.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
Message-ID: <4568b302-2a5a-4499-b2f7-12f89c031495@sirena.org.uk>
References: <20230310222002.3633162-1-rmoar@google.com>
 <BYAPR13MB2503C590A2AE6FEF6BCAC529FDBB9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <CA+GJov5O6hGdjYMXjRd34MEZuyBuukyJCOsS=HeO30h43eLQbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U7vq7nqwbMFIlUmg"
Content-Disposition: inline
In-Reply-To: <CA+GJov5O6hGdjYMXjRd34MEZuyBuukyJCOsS=HeO30h43eLQbQ@mail.gmail.com>
X-Cookie: "Speed is subsittute fo accurancy."
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--U7vq7nqwbMFIlUmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 14, 2023 at 06:03:59PM -0400, Rae Moar via groups.io wrote:

> One thing to note on the created churn: I have noticed a proportion of
> kselftests currently implement skipped tests in a way that does not
> use the SKIP directive. They use a comment of the format "# [SKIP]"
> prior to a test result line with no SKIP directive. Thus, in order to
> reach KTAP compliance the way skip tests are handled would need to be
> changed in these cases anyways.

This is the documented way of reporting a skip in KTAP:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/ktap.rst#n97

TBH I'm finding it really hard to summon much enthusiasm for changing
this except as part of some other incompatible update - the current
format isn't ideal but deploying a change would be a bunch of hassle for
the existing test automation systems.

--U7vq7nqwbMFIlUmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQRv8gACgkQJNaLcl1U
h9BmFQf/Q1nCvItoW2dwIKw8OMB17PPv988cXqqaciRnl2GNIvXW1BEgAZ02WipH
iUO+5wSKsyyoZWEwRewPEdbrRjCuXyXRUDFkBJ7kmaqwMrJqLTV9Ittf7LsNbAt3
eekzRFG1+ksmERKtJtVnKQ047Ed49o6/vYJmt3URAvLKZ3jRrPVMgFrANuQG6Zw2
J3hjbS/EumCa0GwzP2/gFbwAWyZQUbwYlFXDeBH7ckZyr5PZULj76CiBtxmbj/dG
VE2i4aQPhWDa8rPpjJFQnPtTCCddE6AIh4f8JUhxLmd86Kx2f710G7b7OYeqFcLD
uHh7g8vAalv15HB5imHnxf8Gzu9C5w==
=nDd6
-----END PGP SIGNATURE-----

--U7vq7nqwbMFIlUmg--
