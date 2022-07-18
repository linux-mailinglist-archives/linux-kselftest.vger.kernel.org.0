Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AC578062
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jul 2022 13:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiGRLEM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jul 2022 07:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiGRLEK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jul 2022 07:04:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB95100F
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jul 2022 04:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5121AB81167
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jul 2022 11:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C8FC341C0;
        Mon, 18 Jul 2022 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658142247;
        bh=Eww+XW76vpqEZHfn4M8h5LGlBIt88VJrdBd6Rqndts0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqHzK21jKCW75csX0xmfqwvJx0ImipjYIp2km1QQOO38gdTLA4CFoO9iJg74haE2i
         2bql/sQgs18qSfO61I2dNTd8IvnxHpx38S3PMq4lw5v1ktvVTcRSl43dLSGrD/ZXG6
         ROmEb729vA8IOtW/G62McbFOQ2qcCRyofYrOhHMm/SFUbkiV4oj5hH+KnYZX+dfTNv
         UsgapEPSz4vI7mLiXM2OZntFgAYzm/DTnuVHEFWnUs4mls/0rd8J8iMDhoJsF5aWHT
         W64GFYoyH3sIc/teS1R/DxpYozDptv6EElfYWuAdn8Z/VsamKED/0FQLHocEfzTi6E
         LWXdsxeL/+OmA==
Date:   Mon, 18 Jul 2022 12:04:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "li_jessen2016@gmail.com li" <lijessen2016@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Subject: Re: FAIL: alsa/Makefile dependency check
Message-ID: <YtU+Iknsx1OL3jq2@sirena.org.uk>
References: <CAK0WjkiJb9_mTmTMWUb2dX-B6_52Fr4stxXrgaW=07RjfMzvZw@mail.gmail.com>
 <YtGIrl/RIuI2TBps@sirena.org.uk>
 <CAK0WjkjCbCvOJ66bX5t_LansAAd0foT1gYS1Gkz5QWcAYPQ6bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a7peLFy8jDXtySeP"
Content-Disposition: inline
In-Reply-To: <CAK0WjkjCbCvOJ66bX5t_LansAAd0foT1gYS1Gkz5QWcAYPQ6bQ@mail.gmail.com>
X-Cookie: The greatest remedy for anger is delay.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--a7peLFy8jDXtySeP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 16, 2022 at 09:14:08AM +0800, li_jessen2016@gmail.com li wrote:

> Thanks for your kind reply. Then what should I do? To officially raise a
> bug to all the relevant persons in the kernel community?

Yeah, I'd figure out who works on the script and mail them about it (or
develop a patch if you feel up to it!).

--a7peLFy8jDXtySeP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLVPiEACgkQJNaLcl1U
h9BTvAf/eAx2Qxzc8UHqJneDZOboXnKcz4paW2e90eHGFLpoCjdZsinUoKEei/3Q
iPko+HDdL+H3Z30Prk3gohHjL54P7F0ChSH1fMMESFbEtHKCUV8+DDFcYGNbMOWI
4JwNryA9kbUwVxCblgI4xDe185sQJTCuEyWEkYvf2CmyH+zBmLCzAvF2NqnK6VIf
WV4F2IcsGBTVXgruS4J2qUlpBoKVjEamWpDNsCNFYSTX035wsUWZp+rdr4N1lMFS
r8UGdZqwXFVMJwB3eJ1kZbEYS8q5hwZ0hnCHuMkH0bKH0A4G5ECaNfzJF9GELIya
4qqWgF9GKpvyWH32Stj1xSxPukBBwA==
=lqvJ
-----END PGP SIGNATURE-----

--a7peLFy8jDXtySeP--
