Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84FA6A43E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 15:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjB0OMK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 09:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB0OMJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 09:12:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8421B1E9DF;
        Mon, 27 Feb 2023 06:12:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 480CDB80C95;
        Mon, 27 Feb 2023 14:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAB1C433EF;
        Mon, 27 Feb 2023 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677507126;
        bh=6AG7SceOELnCwREF/HAA2yOyakikt8NQE9ObYcefNKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxn5CzsvFHeDdbXDE2G/zhqcVECnDGBw5Q1mylYpQHZe5sOORg5OdojkjbridiYVL
         joL3+Rp+Fmz/W1yfW3ENC4vIy1uA/GCOTpy73zSTFEwRHFCPuUwcMKmgbLmPQ34O+l
         ZpX8wh0bwwcXn/2EDUcdzxgokoitrK8kJqhBKtj4BX77OOF8DHkWOYYQVLUSAj6Zka
         uUVbhTHrj5mwfrkp4YsgNYYvkPKkJ2y/IJhnUeO2s2FfR/dXhijZz3st7MvciqggLV
         EgoMSHjo4T9/W260zsxzTmEmlvMQBr1rf8h1nOSVZxPvvx3lWO3JABw2K9ybemM+X3
         S5qPvr6GhBOJw==
Date:   Mon, 27 Feb 2023 14:12:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, shuah@kernel.org,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] Fix snprintf format warnings during 'alsa' kselftest
 compilation
Message-ID: <Y/y6MNh8yXcsQWWj@sirena.org.uk>
References: <20230223143214.16564-1-ivan.orlov0322@gmail.com>
 <Y/eAyrYs+wEu180d@sirena.org.uk>
 <1db3bfe5-0982-b445-9c94-784478279028@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wjrc9TRZIcm10rXr"
Content-Disposition: inline
In-Reply-To: <1db3bfe5-0982-b445-9c94-784478279028@gmail.com>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--wjrc9TRZIcm10rXr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2023 at 11:14:56PM +0300, Ivan Orlov wrote:

> I compiled the test via gcc 11.3.0 without any custom options, the arch is
> x86_64. There were five warnings during the test compilation, and all of
> them were caused by incorrect format in 'snprintf' function calls. As I
> know, using incorrect format in 'snprintf' creates an undefined behavior.
> Maybe there is a point to fix it?

The question is more where does the warning come from and is this a good
fix - a common pattern where generic types like size_t get used is that
the underlying type changes between platforms and warnings just get
moved about by changing the printf format around.

--wjrc9TRZIcm10rXr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP8ujAACgkQJNaLcl1U
h9BwQwf+P5EOVKFjuPDJj1+sBltQmwV+lc9tBNVgCfUuyNl2YVOxr4M5gIgzZ8MV
4MKKEq2gK8Oiwb52v6zRXjwyswsgNiJI6l0RvbM8uW05kE4T71pvtSnt83eN9cLC
9HgHf1ErUxg8rauXvjRl6RZJNiZRs4k/MK7Jnb0aI4qP3wRrK8t49MJbZ95ukibz
F6WcumWdD58Jg7fspthrSvs7vn1q3TNqwMBYWWtuyZEwPRUqueIUH2SrcZ8It6ov
UW2gQaqCaOYw3YP2+EHsdFJPpJgsSa9tQ8VrVW+HEpZ7iP5r7ystzY1OoUE5MGwf
BXZ4rpvbBbA4jehWBVPhTv9QLwno/g==
=C6G+
-----END PGP SIGNATURE-----

--wjrc9TRZIcm10rXr--
