Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53A0576477
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 17:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiGOPdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Jul 2022 11:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOPdO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Jul 2022 11:33:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EF2BF43
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jul 2022 08:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA6B9B82C23
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jul 2022 15:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F67C34115;
        Fri, 15 Jul 2022 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657899190;
        bh=9aHm1Fu3V4PgkcOae+20k1x/4kckqaUx81hhfHgpEas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDw9C/OEmqdqfd+aWY52ugJk967wQveESgwRiptkC2sFO866Dbbow6rV998GZwwWm
         jQbrmdeP9Vg9/E0TH2Hx6oy3fLADYXF2BE9bgJDpaQPbh/RHlgywU8QPaa40Fi+/O1
         sQekSjokfj96p2EI+jpwIOtH5zTKoT43IlVEk/CD+7TkDO5CU80Q/a7KvGwPu+ueN2
         XJk8GhYjmGvBEZ6px+ZieaDFOQZYnNy5JlTwucHk/9OdxWYaZqBhGVefLEZ8SDRVNm
         /zhf0YuBXWsecuecRh7b8apTyXeCFVNhll2TdgVUtLrFRtUJV4RYqth8/LWq62GzgY
         aXQ1d2SFE2B+w==
Date:   Fri, 15 Jul 2022 16:33:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "li_jessen2016@gmail.com li" <lijessen2016@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Subject: Re: FAIL: alsa/Makefile dependency check
Message-ID: <YtGIrl/RIuI2TBps@sirena.org.uk>
References: <CAK0WjkiJb9_mTmTMWUb2dX-B6_52Fr4stxXrgaW=07RjfMzvZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fEtqbAyeOk6CacDc"
Content-Disposition: inline
In-Reply-To: <CAK0WjkiJb9_mTmTMWUb2dX-B6_52Fr4stxXrgaW=07RjfMzvZw@mail.gmail.com>
X-Cookie: You dialed 5483.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--fEtqbAyeOk6CacDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 15, 2022 at 10:47:16PM +0800, li_jessen2016@gmail.com li wrote:

> FAIL: alsa/Makefile dependency check: $(shell
> FAIL: alsa/Makefile dependency check: pkg-config

..

> So I wonder why the FAIL info appears in the presence of *$(shell
> pkg-config --libs alsa) *in alsa/Makefile. Is it some sort of bug or
> did I miss something?

I think that's a bug in this tool you're running - it's not
understanding the $(shell ...) and generating false positives, not 100%
sure what it's trying to do but it's fairly clearly parsing every
element in the statement as a dependency of some kind.

--fEtqbAyeOk6CacDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLRiK0ACgkQJNaLcl1U
h9CkCgf+L4Jui8awFZT9usl0KInbgUG5TQ68toB0FGI/85vtxRbjTRFsOLheddam
QRSnLA2AaCyZID+nsneRsxV7y7HbIBmuLKMiMrpJxCc0cbqxxHlHUZuhQ8VWhH2Z
Kwg0WRRTmn2JoicAV388LcKAQw2KOulViwnpjPMFm2lPkYO6OWoCDHfGbtEvu9YV
aPH361LmJY75jNhYFhQ44Kc3ZAVXAm1qt0VRrYo8ZSXWMISEJgm+3ZYhcu9eFrEz
eh6uwcDkbsjMDTbH/+smHbz4uCSDHdsjd4XTuDI5g8Ul15cwWsbuL3KizZBnFT0F
ZufXcvuBNC/dBvSgGpr9P2gEPiSHUQ==
=sura
-----END PGP SIGNATURE-----

--fEtqbAyeOk6CacDc--
