Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDD1757EF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGROEy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 10:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjGROEi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 10:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EE82132
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 07:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 273B8615C2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 14:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4D0C433C9;
        Tue, 18 Jul 2023 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689688998;
        bh=WlS7Z5EdRNH+yPYQSYk18jt7Nv1ToMJ5zBRNQDTYJeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKii+jlVNd0dulA7+WThl1ud97SJdjCvawymEJlMTJ93S0ucT6GPL4e67TafRnVXZ
         x6x7+zwAlEZFDkPMGwiSXRR2ZCdgc6LgOil2vumuc+Rt/0QvPO9il21f3pgwbLst1K
         un0lL2cFg/pnqxgZrOFdwO7KCe599F1QZReS0CSgjLFuFH3YTiVzBnH4uDz4ckFn81
         RlhMqNbnOTLxqDPwSgGRLkXHyiVM+YIOG61+wwl90qJlhER0mSmpdsDzzBJlddz7Y8
         TlSJpxpJxmStF6W4geMrx6jUdtPK4QYipj6Cy0X3JGMu9k3kq4X/Zt5cI+E4HEO7rl
         ZyAdin4mDrYRA==
Date:   Tue, 18 Jul 2023 15:03:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 4/5] kunit: Enable ASoC in all_tests.config
Message-ID: <a2cf54c1-6351-43a7-a18e-368a9b1de5d3@sirena.org.uk>
References: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
 <20230718-asoc-topology-kunit-enable-v2-4-0ee11e662b92@kernel.org>
 <CABVgOSkJ9KASn9zxWMr23xh0U61er0WUPwQprjq1ADY67oxX8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+BFQ1mUGDxse7BxO"
Content-Disposition: inline
In-Reply-To: <CABVgOSkJ9KASn9zxWMr23xh0U61er0WUPwQprjq1ADY67oxX8g@mail.gmail.com>
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


--+BFQ1mUGDxse7BxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 05:03:41PM +0800, David Gow wrote:

> I'm happy to take this via the KUnit tree, but if it's easier to take
> all of these via ALSA or another tree, let me know.

I was hoping to do a bit more KUnit coverage for ASoC so it'd be kind of
handy to have them in the ASoC tree to make life easier there, though
it's an open question if I actually get round to doing that before the
next merge window.  It looks like everyone is OK with me applying them
so I'll queue them for my CI, please shout if that's an issue.

--+BFQ1mUGDxse7BxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2m6AACgkQJNaLcl1U
h9ARJgf+IlI/tNdcIlmHj79oLO42O5wETWdMcwDWx5/igc+7PWwcYzDunMKk5nH6
8M/nxF3n9z+Q05tEoo+Tn1Sut5r9fDR3fa5VLufq+WFca6ZFvCdZQtBN0R+oG/ve
42AgNjKTCgYr2V9iX4nQWPH9TtSTWgGORCnRcApGmeBcaassNSvXdmLOQDr1acNs
ZVYiS4msd6TkjZvwKxLld/FC2l6F52BicN3pP22e2rjWX6k6sJf5nkKmBtvJSW1Z
iE7nrtsSQLNERGuusYP1WbDNQx6vFHhYUI6WJ0vwUG5XZFYdaBluCGDqM+BkLSdc
A5QkySi3eBfjaAtyQak/HJl/bHLwaQ==
=BBJO
-----END PGP SIGNATURE-----

--+BFQ1mUGDxse7BxO--
