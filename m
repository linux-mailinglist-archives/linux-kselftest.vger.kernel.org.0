Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4339C7A8984
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjITQca (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 12:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbjITP7p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 11:59:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518FDC2;
        Wed, 20 Sep 2023 08:59:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1E8C433C8;
        Wed, 20 Sep 2023 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695225578;
        bh=TgtnsvbGOUf8/0QiUmZytL37sBH2oYZX/bZUhckgbWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJkPEMCBo+sXlFkUNsfJxYxt0aDsH8bSEpxSVkhOlXV8YRypx58EO6CWrZiWsKb1M
         FDDK6ykYVM6VWpu993IiZiF8hm8CrMlDczIeOuLFFqVbU1QNta1+1PLawVO5tlEdid
         B10WocAKfwAbIkD3GggqrFQsJ79ofEPp+h8eNjStcr0U1ncEdM9XHTAwcu8wi+a23X
         4NcyNZHzvgT2KtQk33pbRHMNVRK4qAsq7C2L3qIbvI4RIyeI402aF6vuSg2PE30b55
         zQ9hd9WNZSDs7qD6KaXrh93CPnjJZkjfHKERT7BFjIcri9H4Yjrie3P04D/Ykha+0U
         rEF/Zj6gdaI1A==
Date:   Wed, 20 Sep 2023 16:59:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Takashi Iwai <tiwai@suse.com>, kernel@collabora.com,
        Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: pcm-test: Report cards declared in
 config but missing
Message-ID: <b1658cfc-74b6-44c5-9e2b-816772ff58a1@sirena.org.uk>
References: <20230919152702.100617-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TR7m/tl8KYNB3BtE"
Content-Disposition: inline
In-Reply-To: <20230919152702.100617-1-nfraprado@collabora.com>
X-Cookie: Even a hawk is an eagle among crows.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--TR7m/tl8KYNB3BtE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 11:26:21AM -0400, N=EDcolas F. R. A. Prado wrote:
> When parsing the configs, keep track of card configurations that match
> the current system but haven't matched any card, and report those as
> test failures as they represent that a card which was expected to be
> present on the system is missing. This allows the configuration files to
> not only be used to detect missing PCM devices (which is currently
> possible) but also that the soundcard hasn't been registered at all.

Reviewed-by: Mark Brown <broonie@kernel.org>

--TR7m/tl8KYNB3BtE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmULFuQACgkQJNaLcl1U
h9Ahigf/dKE+gXp9ZH4jZ1QZyixn2tKUPrKHFW0rcLc22QxUNfiy8PHk75LjKCXJ
o+rCl7qjgygLrfSiPNOsBbqeoW+v4G932AuYCGpMZKI2/u1oDTNg7NTnBcJTw4xz
fDYMOrZ+1z96gZHeOAZJa3C10hgkWMz72duAVMWb4b1S03kyRY7EboUzFc5bgqSi
SpnwJoQweI0DRjAsK4FoITvWctL4krn1l5eMOClIIA9CgHZKjORGeQD6ReIDZ16N
Dwkc6jRHnprFA4bWxcMCHzCAIY4MdP+EA6B2i7baLfwodjo1tRNRCUDXPXworCwP
e7QJf2nIQGkX9IvdZXSwXkwcZxgWMg==
=XtEC
-----END PGP SIGNATURE-----

--TR7m/tl8KYNB3BtE--
