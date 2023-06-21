Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98DD738CB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFURIf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 13:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFURIe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 13:08:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC25135;
        Wed, 21 Jun 2023 10:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 103DB61615;
        Wed, 21 Jun 2023 17:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503ECC433C0;
        Wed, 21 Jun 2023 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687367312;
        bh=ZMr77jsR3SW8Dv/WoWnmFrUI+GNGUZXIyByY3L5hI6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYWSoLiFIsZ1nfDhdck7LiifPmHR84QXTyuGiCMU/g7H5RBloxpx7xyQaqMUx16TU
         YAXNuvLWUsgov3iWlwf4cgSfMHex5l4Tx5XuSZTSJ1t8GT5poh8+VqrulyReaGepWp
         TKRc9T2718YWQQEpbuNWmEwT3gTIW9HXi7IoRmChfdv9El4sRhTobLtkFxQFIbztPv
         sNlwnxkhpkpH4iOB1dW/Mf6M45aCQT+9HyxRKgviTqags6QGH3kz5ZvRU+X0yu/3gp
         wN9HOzvhRr0QiOaIrWvdqQrfJgh4tfnaWO4SyQFImPV0ZaqhA+xUENh5nwXYlramQo
         sQ3OClM7HOsmw==
Date:   Wed, 21 Jun 2023 18:08:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     =?iso-8859-1?B?Ik7tY29sYXMgRi4gUi4gQS4i?= Prado 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftest/alsa: pcm-test: Decrease stream duration
 from 4 to 2 seconds
Message-ID: <f5cab2c2-1638-4d19-aff3-d46ed34b857e@sirena.org.uk>
References: <20230620220839.2215057-1-nfraprado@collabora.com>
 <20230620220839.2215057-3-nfraprado@collabora.com>
 <33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
 <443f697b-fecf-6e8e-0b76-65257aff7da8@perex.cz>
 <9069ad0c-d166-4620-a3de-a36ab233cab0@sirena.org.uk>
 <5c2d5213-5299-44f1-9611-26002c8a5d3a@notapiano>
 <87352krcz5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sJ223WL4sI8q4Z0q"
Content-Disposition: inline
In-Reply-To: <87352krcz5.wl-tiwai@suse.de>
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


--sJ223WL4sI8q4Z0q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2023 at 06:34:22PM +0200, Takashi Iwai wrote:

> So, we're back to square...  Unless anyone has a strong objection, I'm
> inclined to take this as a workaround for 6.5 for now, as the merge
> window deadline is coming.  We can improve things at the same time for
> the future kernel, too.

It feels like it might be good to let it cook for a bit longer before
going to Linus (eg, applying after the merge window) so we've more
chance to see what the impact is on other boards?

--sJ223WL4sI8q4Z0q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSTLooACgkQJNaLcl1U
h9CHJQf7Bn6pMlneZXihhoTKXkp58Tz+OhUfB9RBtYGcHEyPCRoxwLmhZ/8CV+Av
ucrbzZmxYOaStT5mGuz7vYY3JjCPSItte03vaKR3k7vC8iNoVjthpdgW6u7qVSha
wr1sjMVkxgNhMXTNuc4HRAEOu5vXFFB14DuV9lrQYpv50VxIh5U73XQw3jNcGjYz
8S4HoDtqIzzAvBkblIcGSgLbpj/DaMrMXYmxd32TjjN/b1swYQAY1CmheqOMeUqm
BhIlwhzoWhMhmZ4ZB2BWIFgYia6cxeqnURnUbL5QkJ8KgYzsbneR8QRldGGs8Hjr
Ab/65yDMSzPzAkC+FoeJ4zU3tb0eyQ==
=4AF1
-----END PGP SIGNATURE-----

--sJ223WL4sI8q4Z0q--
