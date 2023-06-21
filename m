Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D7873873D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFUOjV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFUOjU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 10:39:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495891994;
        Wed, 21 Jun 2023 07:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9399612B7;
        Wed, 21 Jun 2023 14:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C34C433C8;
        Wed, 21 Jun 2023 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358358;
        bh=VXBvW08YHCjFJUo8Y3I1beTInLzEQKnsdmhPOK4bYIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZl1k1F0ZcAed6cyywzNyeNFbJ7D6LC6xDLfFbVBm2LiVc0WmmIBNSjNUlr6y4Q6c
         rJpTjq0rjslE8kERMZNeE2zcPY3jxdT9ITE+Pz7qR78CSkCef7gSlpSVKVJiPXtMtq
         hmdokXAc3JVSVmgu5FhkQ1pzAjoIF1f7E6t42PDhxgPHYycyqhX2rcVAsZQNz24xKh
         es6lnaa0+8Xq6joKOvOZr0nHG6PvKgVnojHtrULUOYyRhvTgmKPN8D56nB9aEa+bMi
         5KqpBXJ4p19QxRnGye8BhGeFJRMBjIcxvq1/75EWokHyNOoRUhTPwcGb8cTK/e1z9i
         PxmFblnHkgLcQ==
Date:   Wed, 21 Jun 2023 15:39:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftest/alsa: pcm-test: Decrease stream duration
 from 4 to 2 seconds
Message-ID: <9069ad0c-d166-4620-a3de-a36ab233cab0@sirena.org.uk>
References: <20230620220839.2215057-1-nfraprado@collabora.com>
 <20230620220839.2215057-3-nfraprado@collabora.com>
 <33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
 <443f697b-fecf-6e8e-0b76-65257aff7da8@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lN6DZShoSnw04Qtm"
Content-Disposition: inline
In-Reply-To: <443f697b-fecf-6e8e-0b76-65257aff7da8@perex.cz>
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


--lN6DZShoSnw04Qtm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 04:08:47PM +0200, Jaroslav Kysela wrote:

> I think that the problem is somewhere else here. The overall test timeout
> should be calculated dynamically. All tests may be queried for the maximal
> expected interval based on the hardware/software capabilities. It's a bit
> pitfall to have a fixed time limit where the realtime tests depend on the
> number of devices.

I tend to agree here, unfortunately Shuah hasn't responded to queries
=66rom N=EDcolas about this which I imagine is what inspired this patch.  We
also have problems with mixer-test on one of the Dialog CODECs with a
couple of 64k value controls and no cache only mode.

--lN6DZShoSnw04Qtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSTC48ACgkQJNaLcl1U
h9BGbwf/Tdjkixv5SETg00LJp+l4cOfv6sRpMFmm0MjvB7B8F7D8D4fFtu8vwLCk
1pVCzZ2Z6WSbnPBMlVDSWV9ns+VBPoXD/W9R1OBx+IgQLyqr/FXUvQFed3MvQSrt
uOHg5udSeoLyfhpGMgbHRUEy2yFjt+jJNvlPn5GPk0W9gDQ540afmJStnKzyOXrW
8eL8q14TSSzn41yRaOZSN5K6Qx5vu/qDOxk2qKr9pUAkVABHVd1BBqzoysINKWEk
++RHedjGxb4PrspUa5io2mzmDkd3VzoQu+ReCxSbLerIa45KG2oev+o9kSFK2Lbu
juIvTAHQ21sYmy6eHgoLaxAshfYtyg==
=GpWQ
-----END PGP SIGNATURE-----

--lN6DZShoSnw04Qtm--
