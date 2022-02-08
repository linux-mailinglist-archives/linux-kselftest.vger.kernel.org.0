Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5180B4ADE47
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 17:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383099AbiBHQXX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 11:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378812AbiBHQXW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 11:23:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B28C061576
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 08:23:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ABEDB81BEA
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 16:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9D6C004E1;
        Tue,  8 Feb 2022 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337399;
        bh=7EjAF78EZ5QWa+t6GFhhwSedAHtA4f8i1cRtLq4H/cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDs1Y+chouwfHWvO7jOyLHsTVlM/IoxwKUiK1fD/NrGAbyps7In4U2A/F8W11aPFg
         6u2Bn4/JYITl887j/ZJ3vlUzMd0MGj68hhoV1UR52z9x1zDHX646F6BgrNHWOfP4OO
         /+oNHpszZvHmETmEBsgJNzQ4Aqebn5qYj3lEg2Q5yLgJCFC5tGzDN9cmtCG0mX3Zeh
         loPIxk6kuoyLX4JwnrINX2ytdglLgwK93/Z4i5l/B9fpB3yUriAcEqxQFog9rDapg/
         eFNlO0lkxxlsZOcsf9ccHMh7n6ebC1vmAGrfj1VtMqzIGArDa+jRYNh8VYd4KqhP6t
         ZS9ECDSHKojOQ==
Date:   Tue, 8 Feb 2022 16:23:12 +0000
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
Subject: Re: [PATCH v11 34/40] kselftest/arm64: sme: Provide streaming mode
 SVE stress test
Message-ID: <YgKY8NluYQxbeUw7@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-35-broonie@kernel.org>
 <3b173e0e-7651-b820-26c4-37d1cbe94224@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+Dm2AwXmRIQQetd4"
Content-Disposition: inline
In-Reply-To: <3b173e0e-7651-b820-26c4-37d1cbe94224@linuxfoundation.org>
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


--+Dm2AwXmRIQQetd4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 07, 2022 at 05:40:08PM -0700, Shuah Khan wrote:

> > +child_died () {
> > +	cleanup
> > +	exit 1

> Is this a failure condition?

Yes.

--+Dm2AwXmRIQQetd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICmPAACgkQJNaLcl1U
h9CldAgAhU51Tq/k4inkyhHPj1IrMyCrf7zKGWMmKVj5+FGBYpRrg6i/Oc5u9sek
8onQDXFuxVi/0m9JbTxcTfFRULR+we2mg8JqUwkcDRvw7WOK+nx/EZlDchMcEZXA
kZAj7RPINQHWN0NGJW5+++67YCCc+1GHTuyUYktMuqD/Z7w0Zyi61KZDr8hria4y
W5XvfpAWrwUGIu5QFRk28lZfs2D2BbZI+YkqYqb7xGAEHMkm4OOudIoSK/xTv5hl
2d+DAQ3T29QJEc3OObLyn4KB8Eo+XJLhoGhkJ6v8uj4jf65MMrzadjWg9Z8e1We7
+N7K7kMJljE6v9aVYNvPosEGJOufzw==
=TjlJ
-----END PGP SIGNATURE-----

--+Dm2AwXmRIQQetd4--
