Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDF563D704
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 14:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiK3Nm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 08:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiK3Nm4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 08:42:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B43D3E086
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 05:42:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1116D61BA3
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 13:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D8FC433C1;
        Wed, 30 Nov 2022 13:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669815774;
        bh=Z4YsbSuW2L2E0PCaV/Fdm4TGFl+eiPGNZpF4YJdVjRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XyR2Kz6+biAaiJlvVFQ/U4ogycAIRUiaMBSJsn/fsw/WLHQaYCvGiyLj0u3bv8BIy
         FII2X/UKnB5X1Qa4bHra0dXMzdeQUgLJ9w/MP53Q85NLkJrNyXI0Tbp1KyY9HhCaDc
         LTjo1C0AGnLa7iMbBURtKMAQOsqkDDqUzNrPiJfj98EDVF30FH5BXrM8Dx7Lax1eP/
         ps6oEpw+BRd9ObXPtl4+0H6Y0GdahKS8YYNwGvidyR5hHZpil6zkaLBhAN10LRPb95
         A/LRSubrmC8cIh+TVkAjgUpJ/qLRfy4rfxP0MN9LqBJi++GU2LJOqbWO6QUr+DSN05
         r9w1VuptGnUig==
Date:   Wed, 30 Nov 2022 13:42:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 6/6] kselftest/alsa: Add more coverage of sample rates
 and channel counts
Message-ID: <Y4dd2b2cgkhGkR85@sirena.org.uk>
References: <20221130000608.519574-1-broonie@kernel.org>
 <20221130000608.519574-7-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LkXPArDBIQ+IlES9"
Content-Disposition: inline
In-Reply-To: <20221130000608.519574-7-broonie@kernel.org>
X-Cookie: Jesus is my POSTMASTER GENERAL ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--LkXPArDBIQ+IlES9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 30, 2022 at 12:06:08AM +0000, Mark Brown wrote:

> +	{ "8k.1.big",    "S16_LE",   8000, 2,     2000,   16000 },
> +	{ "8k.2.big",    "S16_LE",   8000, 2,     4000,   32000 },
> +	{ "44k1.2.big",  "S16_LE",  44100, 2,    22050,  192000 },
> +	{ "48k.2.small", "S16_LE",  48000, 2,      512,    4096 },
> +	{ "48k.2.big",   "S16_LE",  48000, 2,    24000,  192000 },
> +	{ "48k.6.big",   "S16_LE",  48000, 6,    48000,  576000 },
> +	{ "96k.2.big",   "S16_LE",  96000, 2,    48000,  384000 },

It looks like the period/buffer size numbers need some tuning other than
for 44.1kHz and 48kHz 6 channel, if I do any more fiddling with this
series I'll split the problematic ones out into a separate commit if I
don't get things sorted (but we could just leave things as-is and fix
incrementally too I guess).

--LkXPArDBIQ+IlES9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOHXdgACgkQJNaLcl1U
h9CNLwf+JBoVVimM0Q6TBFs+OndC25sjt/A5hINKDUvit734gJFzUwd7LExgG7gH
J7teCnR5q2E9y37AjkE2Q8r7jU+AYpVQdG5yT3RJDoJVoX6RA/w+glxKXWNcSv6O
2BKzNFRksolSoJcNKLtJq58O+kO5tPGQrtk3d+2tLYaQer3t+C31huKYopEudNiT
VEqm2+zN075A4Zd5sDzh+vfdCKfuY1qmgsOlPtxgu9Q4JSC+Gpj8R/kcAxCRd3t8
4Dy6TG0SuQNovCDisTFGr9XXjdTGMftbMKiwwU/WZH+wKsPnnV0Cw4lv7pScu4a8
GY+JrR1mac0BZ5/VOu2LB4Jvr1k9eg==
=cwHx
-----END PGP SIGNATURE-----

--LkXPArDBIQ+IlES9--
