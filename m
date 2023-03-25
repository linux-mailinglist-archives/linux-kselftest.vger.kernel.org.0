Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FD06C8E30
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 13:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCYMcH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCYMcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 08:32:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F611171;
        Sat, 25 Mar 2023 05:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50B07B8075B;
        Sat, 25 Mar 2023 12:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF05C433D2;
        Sat, 25 Mar 2023 12:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747523;
        bh=juilGb7bs/wbisWQoWXEvsQcaNpcQtaSUuekDXjow7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gr7DmWAPrns6fda+dhtZllEohQxfiEX2Fdy3/koM9lROVtsxbbcBK5vyMVmoJSVNL
         fF+n0ZJ2oBbEBSrkXWEHg7kRkkO3U2dJUcZY2Aq3VqkzcUZqRXsqj8vWfF4JBIdkyl
         08NbRlMwx5XIiEllhI+1jJDsmuQ9Pk667m+iQRNQb1Ij79DIQaF5/MMH4ZMmUjK2S9
         Ckk6OerqfK9pOHqwohchAeS/Isra16Xcy7YAVytouDRzGwP3ePKJF7ndr5/DM2JUC7
         20Mc9AnaKk+fqIBphCGDD67GNQ8GNGiHVlWzdLQUSDVuh7uqXanRm2iEkuHzStbHHp
         nnfmC3iI3jGlA==
Date:   Sat, 25 Mar 2023 12:32:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regmap: Add some basic kunit tests
Message-ID: <ZB7pwKh8A2lZc1sU@sirena.org.uk>
References: <20230324-regmap-kunit-v1-0-62ef9cfa9b89@kernel.org>
 <20230324-regmap-kunit-v1-2-62ef9cfa9b89@kernel.org>
 <CABVgOSmFkFihwT_AN0foqu+_=MQ_rJMPi7MKgj0Y8Dk0d_L2zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rRd4vd+XwEmqkyDu"
Content-Disposition: inline
In-Reply-To: <CABVgOSmFkFihwT_AN0foqu+_=MQ_rJMPi7MKgj0Y8Dk0d_L2zA@mail.gmail.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--rRd4vd+XwEmqkyDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 25, 2023 at 02:30:17PM +0800, David Gow wrote:

> It looks like regmap.basic_ranges is broken here (um, i386, arm64):

> Am I missing a prerequisite?

Yes, there's a missing feature there which means that ranges
don't do anything with the specific interface regmap-ram uses - I
already posted a patch for it, should appear in -next next week.

--rRd4vd+XwEmqkyDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQe6bsACgkQJNaLcl1U
h9B1/Af7BcRxbgIGOIl103TYUvJEpFuj408vW+Y9GyNi+6E4H5h6zjxZtu8+cOGd
CC7URdVmAIuu2pKkdTrDmiWVGsOYjwQ81W7agQvJI/pBtXvK0D7v0OYMIu78ozK4
1Byxdar+2pp2h9/tika1ST0EQ8grphAPcTyLiYWpRxhVuhrA8B2SrI4iPbicS1Q9
ZBJyZ1DnKmHCq9R6vZVNluTgIkDz280hCavLxMdgBiqFSvL6qwKrRqkJe6z6IxTW
c7jydFHJtC2MGk+UQjjAjUg0RRNyIkzTSxQbwQw7qGdnIIokIhLRGO4XC6Qlb0yA
BAMgmQkV5P3+hYaD5XctyqDMq/hhlA==
=i4UP
-----END PGP SIGNATURE-----

--rRd4vd+XwEmqkyDu--
