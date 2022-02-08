Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A9D4ADE22
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 17:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiBHQTY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 11:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiBHQTX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 11:19:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544CC061576
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 08:19:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA5561699
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 16:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE69C004E1;
        Tue,  8 Feb 2022 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337162;
        bh=gzpbduvOrB92O7Klqq3r2KXyOxfguLFKQkuqKq2JWss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HzhR6dZ+yd3whIuSFwnzBfQ5EaZbtdE1L3QtLZT4NnOUvHGJD19QBZxYK7JPS0Nlz
         lBGxQwPWaIKsA9dNoVJk+RhSdPYeKpGVc+NyzFkdYHJshMpllha57SSWlVHi2EMjLj
         36fkRVa2BuGf2H2LPrqLPm7Mfjek5+rLnjJSojw/tLgOkEqA54MEAotkVVT0aJCaP5
         J1+ilPbMROUzvVmk9JP69bl6rncQzPtUjqiIvGQxjVuw7CIPTbudASP9feKlHGFO28
         oGnE5buAUK9zzQqU7C0/tVwvGkzcYQYGDGONoUvy6FlLJwMMl3M6iTSE0cB9jUglK+
         776riKp9NqQ6w==
Date:   Tue, 8 Feb 2022 16:19:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
Subject: Re: [PATCH v11 32/40] kselftest/arm64: Add tests for TPIDR2
Message-ID: <YgKYA0H6C8U59UmI@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-33-broonie@kernel.org>
 <14e08c27-289d-8c39-15ef-220e0a7949f0@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="caKUZSkjaiZxfANo"
Content-Disposition: inline
In-Reply-To: <14e08c27-289d-8c39-15ef-220e0a7949f0@linuxfoundation.org>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--caKUZSkjaiZxfANo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 07, 2022 at 05:23:15PM -0700, Shuah Khan wrote:
> On 2/7/22 8:21 AM, Mark Brown wrote:

> > +		set_tpidr2(getpid());
> > +		if (get_tpidr2() == getpid()) {
> > +			exit(1);
> > +		} else {
> > +			putstr("# Failed to set TPIDR2 in child\n");
> > +			exit(0);

> Is this test expected to fail? Is that why it exits with 0 status?

This is so that we can use the exit code as a boolean value in the
parent without having to invert it.  Given that this is just a fork() of
the program itself it didn't seem useful to invert the value purely to
pass it back to the parent, it seemed better to consistently use natural
true/false rather than 0 on success rather than mixing the two.

--caKUZSkjaiZxfANo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICmAMACgkQJNaLcl1U
h9DeCwf+M/YFs1syQhLXKoRRvMUlgHvbSyoJSU3IxNUIOcl12UfUn8ZnTOuP8FsQ
/7kKlUxz8oDnuqiRJ86gOXrPf9EG13fBlzQn2UxN6X45m6tJ6fU3xrWHi6D5Thkc
LZ9Q4pKDUA70X8vufRj5E1VW23M/nGDOW9xIXvAi02JT+/DnYTYURkCCCSGbWUEQ
H8GMD6/oKdaBYMCziYq2BimpzQ1UMRdi0dR4MFr3bVfREBJuTy/TGWpkLyGz6LsV
noHGtzoRd04yFDWQVpRueYQ8S6jp9JugXpmZNWPtIrt9OmdSL6IV69sOEfeS2DLP
j9mn9PTZszWXRHrplxa7fjJVKVPGlw==
=1Dto
-----END PGP SIGNATURE-----

--caKUZSkjaiZxfANo--
