Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67224BF9A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Feb 2022 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiBVNnC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Feb 2022 08:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiBVNnB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Feb 2022 08:43:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82738119843
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Feb 2022 05:42:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B5BB0CE1285
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Feb 2022 13:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10505C340E8;
        Tue, 22 Feb 2022 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645537353;
        bh=Dgt4Njyb87/1m9sSS9cByUyH93W7hgmQZXT2bQcvLbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FS2HTkxtW64sxuVW8n0wSjhFlnRTJuMQnIZ8Xql1lrAR2ox/DacMZ9PAdsJk6UWK/
         mu+lY9POXbUOs0c2AHa+OGNgqOtv+kg9mpdjVN3o56QsCE8yey3T6RwZOLC+uJnAYn
         E5l5gg+GY4HB9yJg74dQ1KkkL00YZaQid3Lj1x7SSfNKlW5Oq30olisneiH6HghyJl
         tgkN+zOyCjmG8tw7x6KTV7YQSGw6NLul3xsoE+xyTYTzQnpAE0Sl59MMFaYKX1VDT0
         K3MLAy35yo2hAhq3M0LaJkWHiJ9nfqMM7pGsbSBMCeiQphDm/8HWb0tstH8e8u5vTp
         5JdcGAvVtr6ag==
Date:   Tue, 22 Feb 2022 13:42:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v11 16/40] arm64/sme: Implement streaming SVE context
 switching
Message-ID: <YhToQuAqnbg3FXDI@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-17-broonie@kernel.org>
 <YhTct2Cy1fMOsjuZ@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HCJoz7wijUUjw35T"
Content-Disposition: inline
In-Reply-To: <YhTct2Cy1fMOsjuZ@arm.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--HCJoz7wijUUjw35T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 22, 2022 at 12:53:11PM +0000, Catalin Marinas wrote:

> I think I get this but a state diagram somewhere would help ;).

> IIUC you don't disable SM on a context switch, you just leave it in
> place until a task_fpsimd_load(). It shouldn't be a problem as
> kernel_neon_begin() disables it anyway.

Yes, streaming mode is part of the floating point state and this is how
we handle floating point in general - it's part of what's tracked with
TIF_FOREIGN_FPSTATE.  Unless we want to do something with floating point
we don't touch it.

--HCJoz7wijUUjw35T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIU6EIACgkQJNaLcl1U
h9AQKwf+NQfS1WFJTmF/zyR2Ew84K70XTrrLzPlgOF24CCCSuihIA3ZF22mUWYB4
W3snzj3yvOJioOrceWBR/rcSXdLqQy/KDO9CUbWAkShtfo4uukYgS9pivUZAEm8m
f+tJg3ktwvR7iO/wrYW65kfYAlwxSdzjXbUBFb8BkcwVjiezVOWVR1cZp8WV47DC
pIztOPzukFtV1lwiwZw6/p9M0qhsrXooLGBXcDw99t5WWWyfSF0sXREO8V1C0Tx5
zWULO6hCfSr9uK9T19lMG/FXDSnrV+3A0QuWZY2qMJiub1mgKJH/ofRKCNHnnJSR
70fYhIlRd5nXUGingt6IIJaIp/tQbw==
=JTyO
-----END PGP SIGNATURE-----

--HCJoz7wijUUjw35T--
