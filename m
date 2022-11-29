Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1465563BEE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 12:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiK2LZs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 06:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiK2LZm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 06:25:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E75E3D5
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 03:25:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3831B616C5
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 11:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54014C433D7;
        Tue, 29 Nov 2022 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669721115;
        bh=YK8MGpJdBuaPZGJd2P9e8MZ4HREyWerCc5ZAcQIVXEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glp9ihcsq2HSGUF/PrBetup8qde/RgU3rMMMfGjYjM14d5gxEx9jhEBHpMi8rR7hb
         c81hrA4gFV9+RSosNaHI3tFHzlS4mNOg8lrYwZsP6rZNKoUVdozwl75j89zmQeaEyF
         mm8NDJkAM6b9jV2FexkLQQtWlwnlRBYy2EuMXfvo6EvIACzs3X8bMWzjNeIXr8iHJS
         bbYnULSIE0/6mB669kR3+0evGKkYEDcouGsYMFtog6pPwsWqevBs0VjtUUf0x7Oc2C
         9ITt5vqI+4sYxMkrxTm7+VVZ9hsu8Q7trgspAwZSIf9Suy0N/l62Ziha+vv3A0aAL1
         YyxaH8ZLvbI+Q==
Date:   Tue, 29 Nov 2022 11:25:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: alsa - move shared library configuration code
 to conf.c
Message-ID: <Y4XsF2tir8bNS14i@sirena.org.uk>
References: <20221129085306.2345763-1-perex@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/mMC9lhECteaEL4T"
Content-Disposition: inline
In-Reply-To: <20221129085306.2345763-1-perex@perex.cz>
X-Cookie: An apple a day makes 365 apples a year.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--/mMC9lhECteaEL4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 29, 2022 at 09:53:06AM +0100, Jaroslav Kysela wrote:
> The minimal alsa-lib configuration code is similar in both mixer
> and pcm tests. Move this code to the shared conf.c source file.

Tested-by: Mark Brown <broonie@kernel.org>

--/mMC9lhECteaEL4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOF7BYACgkQJNaLcl1U
h9AcUQf9EkIRMut8eWxXQH5qqrq4g4RGzHNakyEjhasONpYTWVvbDRA91KrziWaa
UQPUSZijdEPjE26/rkmfVyJNDKuGTwRnjEwO3ulmb8lbUs44rMzjNCdJnEZt8OOw
rg3PYX4bwbDeFNZqiNRBemXH3nDTNiKrGkbWLfl7TW5fQP6bwW1w6hZ/i0nStJnD
OnuF11E4UUcadloc2u562W6NWHHtRyoH3Krl9Df8zDJ0SbEamOTQnFnkxBIbMGK7
faP1lQ3BxCNnozC1GImlAKJkhGiQc4BUNcbO3u6uOiZzlwkMJLoUmRs+U4ppnzB3
FENh2r7nhcww1FqrJh2IAagTIWOpaA==
=AK+i
-----END PGP SIGNATURE-----

--/mMC9lhECteaEL4T--
