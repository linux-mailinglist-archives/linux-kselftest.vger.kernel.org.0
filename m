Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E57751ED3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGMK2F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjGMK15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 06:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22618268B
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 03:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7837660C44
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 10:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA0DC433BC;
        Thu, 13 Jul 2023 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689244074;
        bh=CrzntzTldU7Ro0kscYLoVmmQ2ktvukltq9bhAgOwHcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=id+b0040kuDr080TnKTvw7Kw9uPzt205rve7ZUuOGI/e+Lg6j1riUfpFBWKhG6FMd
         HqB0GWHSqnCdDOAJr/6QlLMKGWTKQqPqHDZwSKlf9CzL3QMIbDJYPCleXpwDCuxc9p
         cTx/PaIAXVO0H9/s/Mxm6ABJ+DB2HW+kWa9yEhaFFgVq/9Pd0EGJEIhKrc0tH52DiA
         SJzvYmA5Z4cZlvTjN2bkRB3jgsYJAuQLCZH6AX1kEykErL76WNS3DNDnIZkrArAmbA
         qnpdF7IXONs/Q0EbFE1X/FZxMJCGpTqcSZyAJarHxxLtIZXJmWNZ5YNo9uOoEoGdW3
         ATa8T4pOZ9irA==
Date:   Thu, 13 Jul 2023 11:27:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 1/2] kunit: Enable ASoC in all_tests.config
Message-ID: <8fd7bb4a-057a-45e6-91c9-fd77140f4ff1@sirena.org.uk>
References: <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org>
 <20230712-asoc-topology-kunit-enable-v1-1-b9f2da9dca23@kernel.org>
 <CABVgOSku9p34jgHk6-L4KD1dVAKuX06tFqTM2QL0zA8t+Rdotg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LzGK+YoeTYDqG8YF"
Content-Disposition: inline
In-Reply-To: <CABVgOSku9p34jgHk6-L4KD1dVAKuX06tFqTM2QL0zA8t+Rdotg@mail.gmail.com>
X-Cookie: This end up.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--LzGK+YoeTYDqG8YF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 12:19:13PM +0800, David Gow wrote:

> While I love the idea of this, it breaks the default UML --alltests
> build, as all of ALSA is behind an "if !UML".

Oh, UML finally works again - that's good.

> ALSA folks, how horrifying a prospect is removing the "if !UML"
> everywhere? If it's not trivial, how do we feel about adding
> "sound/soc/.kunitconfig" containing these tests?

I suspect this is due to UML not providing some key APIs like DMA, if
it's building now I guess those dependencies might have been fixed.  Do
all the drivers build properly if you enable UML, otherwise all the
randconfig people will get upset, it could've been to save all the
drivers from having to deal with UML features issues?

Another option would be for the KUnit runner to just ignore kconfig
options getting disabled.

--LzGK+YoeTYDqG8YF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSv0aUACgkQJNaLcl1U
h9BVRwf/XNnrlg9WGWUCByN6cAPedsu2lHSLkG4ax64j+pbeZeJozEHoXBNkporH
zJ8pR1PnnCevNeHc0UfV4Euw6t0AHN9TRDlwblFLX56IeKWyI85PlDl1N0tghZ9a
bBCrCYV1e4FVYfs68nF1vvRYw6xfe0+5fuGabxW/DzzLo/3kQs+UjQ6D5rayDWiZ
TGeq6dwXiajFla+Pi1EwqWpCgjSRv3+dHldCtu1XlGfDxTz6EL6a9F7BvLfiG/Dd
omGJ1Tw2CwAeED/BKtvdM0Mbe3pJDC7rokGmbDdZSf1uAuYzK6fjKilcIi4VkxRP
A48bunCDf6EvCf4ePqmMSeg4MrVFjA==
=bIG1
-----END PGP SIGNATURE-----

--LzGK+YoeTYDqG8YF--
