Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89E0738475
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjFUNIu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjFUNIt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27E019AB;
        Wed, 21 Jun 2023 06:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 360D3614B3;
        Wed, 21 Jun 2023 13:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F99C433C8;
        Wed, 21 Jun 2023 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687352925;
        bh=8rei6Srdj2hOeoUrA3FxQyYSVAkO4eKByya+vrCiMow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jzdbg3X7R2R5aA3l8Bd5J468BcoyvZBbSNoW5z+bFd+uFHYr1hhHbrrbcXsJlunb6
         RRtpi5CAMalVtBG9vvSqM6C5QpMzt7OdwQIcW2TO3CSc+L/uHJDuOaJqKvYwFhBd57
         2SSve45pWiVdVg6dY8nlQNVJ9ktQDejU8ZmG5VqnOR5pOIIU99tEYhg9A8RncBiNmd
         UsqW95s+2dzAa61gQ8bB0RFNUCnZNkvXKvi1YNf+X8FW/YRSxSgNZQn4Et8139Rn1l
         rGoMll5XO4YOTdPbpbBdZSkcqEf7e9jCXwNlIyrcbOO/VeqQt4v1WalbRl4ud0xEAh
         bwiFENJzWPQTg==
Date:   Wed, 21 Jun 2023 14:08:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftest/alsa: pcm-test: Decrease stream duration
 from 4 to 2 seconds
Message-ID: <33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
References: <20230620220839.2215057-1-nfraprado@collabora.com>
 <20230620220839.2215057-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XuUu5UqlTitESjDI"
Content-Disposition: inline
In-Reply-To: <20230620220839.2215057-3-nfraprado@collabora.com>
X-Cookie: When among apes, one must play the ape.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--XuUu5UqlTitESjDI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 06:08:26PM -0400, N=EDcolas F. R. A. Prado wrote:

> -	const int duration_s =3D 4, margin_ms =3D 100;
> +	const int duration_s =3D 2, margin_ms =3D 100;

This doesn't scale the margin with the duration which will affect the
sensitivity of the test to misclocking.  It should make it less
sensitive which is *probably* safer but at least worth noting.

We might also have issues with some of the lower sample rates, IIRC some
devices are constrained in ways that mean they want a minimum buffer
size which is harder to satisfy with very short playbacks and low sample
rates.

I don't know why Jaroslav picked the 4s number here.

--XuUu5UqlTitESjDI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSS9lcACgkQJNaLcl1U
h9DvRQf/Sa8yVLTUhx/xI7Go5M1j3MnEnA2L8Kol2HP04viW/HKYX9nikxkUgxKI
30UMmR4G03BqyUEpOcDV2fxkvkeHCJXpvC9fRR16FWeTQbSFb/RNXMDxiP5tQa90
DG/qLbm2FEoOgPYARMmqwI/E1610i63eSnsj0toP87QQxGc4H8XRL1HH7u3/tl5D
BhFVvN2xaiZCnQROs1n4yDcslDNZLIdGR1yWUW9nx+e4dNIWOQ/AW4yluB3EFv+J
tGfFR5SPEsJNtIqVAtKb+NPBGYcEl52aUFRCbB30gWKSQIsq6gris+8EOTTjHs+x
L0tFO5FBQfrA9J3lK6eOwSQTx0Ob4A==
=yDSV
-----END PGP SIGNATURE-----

--XuUu5UqlTitESjDI--
