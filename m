Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2073E75802F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjGROyy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 10:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjGROyv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 10:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A95196;
        Tue, 18 Jul 2023 07:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E0676160E;
        Tue, 18 Jul 2023 14:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0821EC433C7;
        Tue, 18 Jul 2023 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689692088;
        bh=rgmBgjIDYkzzmlgWFHvXALNdWd95/pbvuzMWirSR12U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=roVjxYhCoL3n+h0sZWq1nlWqUgCLd0Q0TvVYRcrO5/u73XAp+BGt/EcXc77jrduR6
         ukSZI/Gbwy3oyGxv7EPy2EYqiC81gpLdYFEjuOBkdjNzF7qHqlOstKunFqiuarCfVI
         XN0BAT1KXbw/Wtbtcj+IjvYO210sb6ZTvsbDPfHj/YoM4db+mDTsDYHCg/cV+9AkLg
         DbyCTgbFmPXYHkZrAYCxtLWwsXa6n7cITeWJ9ZM6koSLeGDll0OSxjFqrv0qnbsbsa
         +KCtbPQIF0v2HGmzAJHISVStxv76/tKyP8bIC+WVvPhWNRnCAaxDs2ehtR08MCYSXw
         TOwyyJ5kSpeww==
Date:   Tue, 18 Jul 2023 15:54:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Message-ID: <85526b4e-c2ba-4b19-9c2f-ba39a248a713@sirena.org.uk>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
 <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
 <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
 <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
 <f479b731-7782-0417-2d4c-31a7c3c9491c@nvidia.com>
 <20230714112653.0b42d3c9818b038d219b5e41@linux-foundation.org>
 <68ccfd77-ce2f-857a-37a7-e9b3edcd495d@linuxfoundation.org>
 <5e5bf5c0-bcda-ec2a-ba4c-5f35dcfbc373@nvidia.com>
 <d03af9cc-c72e-d23f-73ad-ca0e079c3187@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u7HQOWZHHEWX8a1V"
Content-Disposition: inline
In-Reply-To: <d03af9cc-c72e-d23f-73ad-ca0e079c3187@linuxfoundation.org>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--u7HQOWZHHEWX8a1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 01:11:10PM -0600, Shuah Khan wrote:
> On 7/14/23 12:36, John Hubbard wrote:

> > Just to be clear, when you say you're applying "both", I'm hoping you mean
> > both of these:

> > [1] https://lore.kernel.org/all/20230711005629.2547838-1-jhubbard@nvidia.com/
> > [2] https://lore.kernel.org/all/20230712193514.740033-1-jhubbard@nvidia.com/

> Right. The ones you have links to:

> Please check the latest fixes to see if we are all squared away:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes

These didn't seem to make it to -rc2 - it'd be *really* good to get them
for -rc3, not having the selftests there would be very disruptive to the
standard arm64 workflow.

--u7HQOWZHHEWX8a1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2p7IACgkQJNaLcl1U
h9DWSAf+IqfMO1FPLdG3/gWN3HkhIbv+uwXVNBfYuJnTbcH3ndSGl+JRmvPw0nMm
skZCr0MAJHyDK7TOtEU+oR66J3Zyd9oPBHakol1Ryf+0O2NzmzRYG5vAN7VAivRO
MZxcsiABHBA+dSJgOpsjxzK+jzdCkC0zT4mxW2gfpubGZ9Nr/bQnVaKI0Z9FAiPh
7iRNz9eSA3/BlbPZrJYL64EdCxVSRKgNXayngEYWC9nymLi3A2YKzcyIuPM3gUaW
b+y8JpjYtng0jtOiFLVHXsgjiGp5+1rRC7ctugW9XCVovU+tZbHG5ou/7kOby1uS
c3B/9I3agaLQyZsDjyDhNmiQVK/wvA==
=wRzC
-----END PGP SIGNATURE-----

--u7HQOWZHHEWX8a1V--
