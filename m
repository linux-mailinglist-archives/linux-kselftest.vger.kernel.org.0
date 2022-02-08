Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499EC4AE0F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 19:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbiBHSiV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 13:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiBHSiR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 13:38:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B561C061576
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 10:38:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E883560E04
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 18:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BA0C004E1;
        Tue,  8 Feb 2022 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644345495;
        bh=8wrf14wnnwhTD0V2fyJYfFIjDT1NePF3BbrQJCxM4Qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vy2jnHNouE74L++j3JKHDG6ILgdmE6Eso28ntVdJOGUJj6DN1LSuAPlCB/FNzyoZX
         wS6OWAE9QQ3BVB+Z1G+NxR3eHdQ0vap0xwds3nij7LtxqUMkozZ2Q+NlDqCURQwCut
         RvBUknGgUnd5VkuH/bZ3v94PsFCYRCXVa5LGcmNvbQOBrePCDTV6HSZXFtt8kGz5pO
         fhnXjaPWmkWv9iwnA0l8/8u1FJhVp3kFh6AHwQBCQWqKCbfyUhrm3+Xgatzy8u2gtX
         2N+eslw0n4cMiY5mKeMO2uimuB1C2tUdAE21KGc6PNuddnMVZjjnrkhzJRqR0Zkwo3
         Eoigg7sI9DB8Q==
Date:   Tue, 8 Feb 2022 18:38:08 +0000
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
Subject: Re: [PATCH v11 06/40] arm64/sme: Provide ABI documentation for SME
Message-ID: <YgK4kKrSs6e9seG8@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
 <49da0f58-7a20-e557-54c3-34bd7074f711@linuxfoundation.org>
 <YgKQTLwW+ha5XNx8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9EzABKYwuXw7aJpF"
Content-Disposition: inline
In-Reply-To: <YgKQTLwW+ha5XNx8@sirena.org.uk>
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


--9EzABKYwuXw7aJpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 08, 2022 at 03:46:27PM +0000, Mark Brown wrote:
> On Mon, Feb 07, 2022 at 05:10:35PM -0700, Shuah Khan wrote:
>=20
> > > +++ b/Documentation/arm64/sme.rst
> > > @@ -0,0 +1,432 @@
> >=20
> > Missing SPDX here?

> Only a couple of rst files have SPDX documentation here, I guess the
> SPDX people aren't worrying about documentation?

I can't find any free format plain text files with SPDX in them, even
really prominent stuff like README.  The process documentation is silent
on what's supposed to be done here too, it says you should use the
comment style for whatever format you're writing in but that's not a
thing for free format text.  Dealing with this feels out of scope for
this series, probably something for whenever someone gets round to doing
a conversion to .rst or some other format.

--9EzABKYwuXw7aJpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICuJAACgkQJNaLcl1U
h9BKKAf/eUkYZVVQvMCsseGHtizTn6cn3eKYSzI8N+tQsJd4H43DHGBxjOcxe1V0
HyzbzUP1LuhnEXcADTd7dn08m5Hfq2PXSpEhzBCAW7mPIr88/XqLgDmXWqj3Y74w
BGrZ7GqJslA/jasJv4OS342/zqvFLgBu1zigLQjPE8xkOOxn/SgCuNk46rx/Hvs9
0EoWC26i2h+XPDVRWkZNGrVm23OSoeTzcSiYjbswj/E28o7Wnjs5Lzfheu3iN41P
yJcy8KnTMiBr16UFuRdWN2/NYLr7AoHQY18S5WPhjj4DZfDNvjcIVT2Qtp0xPt3P
JiJi4yQwNUP/ormKMXAvW7dekiZRNQ==
=Lo6A
-----END PGP SIGNATURE-----

--9EzABKYwuXw7aJpF--
