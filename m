Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5163FB01
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 23:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiLAWzv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 17:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiLAWzp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 17:55:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E58BE4E6
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 14:55:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 571A4B8203A
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 22:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB338C433C1;
        Thu,  1 Dec 2022 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669935342;
        bh=cvrPNkMdTayZW2+mx8ZpfTJbOGVT1F6b+IjEaJFrZ5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqQ1wp8af1M0pv58PHVj8RZKEfAQB2y0/QV5UbbRSlycy9xKML4wRwgluNDi7oQPG
         85cbOHIm49UmuzBIWxSsk7v3UPTU27Sl54Hih4iQF+mD4c0k+H7sMibDef/qzJVIun
         FReAkAUwc6xnxINrobcAX3torKf8IYT3Vpm6UXwJr+2JK1sEW1p8KZudZ6Bm5MGzVR
         bqQCT3HhRHJw380/oRHxGZW1zrsLljompZs4HFpbxbfIey7Tvon0cI9qvhxv4W77qL
         bXgluULiG6LPFor+UATu3HP9/T8C+gXSRiXHMrG4YnyUAqyqvkTgn+tPbP3nJWA5ms
         9O0rY6GGO4dvg==
Date:   Thu, 1 Dec 2022 22:55:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftests/alsa: pcm - move more configuration to
 configuration files
Message-ID: <Y4kw6VErxaeDcKix@sirena.org.uk>
References: <20221201173333.2494019-1-perex@perex.cz>
 <Y4kF7fG70EySxDQn@sirena.org.uk>
 <92abef25-2cbc-eb10-bb4d-e9cae06d7383@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="flo8lt0x0gxthEpv"
Content-Disposition: inline
In-Reply-To: <92abef25-2cbc-eb10-bb4d-e9cae06d7383@perex.cz>
X-Cookie: Leveraging always beats prototyping.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--flo8lt0x0gxthEpv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 01, 2022 at 09:42:52PM +0100, Jaroslav Kysela wrote:

> As for the generic tool, I would like to have an option to control all mechanisms:

> 1) only default config
> 2) only hw specific config
> 3) default + hw specific configs (merged)

> A new field in the pcm configuration may be added for this to build the
> per-device-stream configuration. If we merge those two configs, I think that
> only a field which will skip the default config is sufficient to cover all
> possibilities. The test names are a good identification, what was executed.

That's not quite what I implemented (see below...) but I think it's
not too far off.

> As Takashi already applied your set, I'll try to merge my code with yours
> and keep the added functionality.

I've just prepared a branch which I'm running through my tests now which
just does a revert, applies your patch and then does most of what I
said.  I'll send it later assuming everything looks OK enough on my test
farm (probably in ~1-2 hours).  All this working together is great but
one of us needs to move to a different timezone.  :P  I think we're
*roughly* on the same page here, just some edges to iron out.

For the config merging/selection thing I think for the merge we could
either add a section in the per-board config which overrides defaults or
just go with what I did where we add the test list, as well as adding
command line options to select only the per-board or only the
per-system.  Does any of that line up with what you were thinking?

The following changes since commit 7d721baea138696d5a6746fb5bce0a510a91bd65:

  kselftest/alsa: Add more coverage of sample rates and channel counts (2022-12-01 20:02:14 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git alsa-pcm-test-hacks

for you to fetch changes up to 9e96c58e581313bd639fd51f37c8e831d7b4a05c:

  kselftest/alsa: pcm - Add more coverage by default (2022-12-01 22:46:30 +0000)

----------------------------------------------------------------
Jaroslav Kysela (1):
      kselftest/alsa: pcm - move more configuration to configuration files

Mark Brown (6):
      kselftest/alsa: pcm - Drop recent coverage improvement changes
      kselftest/alsa: pcm - Always run the default set of tests
      kselftest/alsa: pcm - skip tests when we fail to set params
      kselftest/alsa: pcm - Support optional description for tests
      kselftest/alsa: pcm - Provide descriptions for the default tests
      kselftest/alsa: pcm - Add more coverage by default

 tools/testing/selftests/alsa/Makefile              |   2 +-
 tools/testing/selftests/alsa/alsa-local.h          |   3 +
 tools/testing/selftests/alsa/conf.c                |  26 ++-
 .../alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf       |  43 +++--
 tools/testing/selftests/alsa/pcm-test.c            | 205 ++++++++++++++-------
 tools/testing/selftests/alsa/pcm-test.conf         |  63 +++++++
 6 files changed, 250 insertions(+), 92 deletions(-)
 create mode 100644 tools/testing/selftests/alsa/pcm-test.conf

--flo8lt0x0gxthEpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOJMOgACgkQJNaLcl1U
h9COgAf/VyxeMSIg6OpTLZwnfDlNMwYrv7uwosthMbkLJcGYb7Gmb90HXGgySACb
7GRJqv6MmCT5uurga7oWACYeeNSd61yS60h+2zEEUyuXU+uduAfGaJg9nEY76zee
riUBcfspalqD4E9lyY40GhONvq8C1sLR/75VfzKTW/0RzKfgldzZh5vLI0Mbh6TH
5TzFeTS8thOQA8i1ZkSYcksRMlDKE2oknGkmIdXZopVjCEEPKqVhVffhcrZwjsVA
XgoEBud2oLe4+umBRj/oAtcxq6qICWWyKlq7qunPuUiswXYB4yardZBvJ68O2NZ1
iyRNXM3K4FAxdDlY53QIw9TNOPpMYA==
=1Urw
-----END PGP SIGNATURE-----

--flo8lt0x0gxthEpv--
