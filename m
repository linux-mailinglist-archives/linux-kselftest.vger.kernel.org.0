Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEFB4ADD4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 16:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241945AbiBHPqb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 10:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbiBHPqa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 10:46:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC2C0613CA
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 07:46:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4DD2B81BC2
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 15:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A88EC004E1;
        Tue,  8 Feb 2022 15:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644335187;
        bh=DRWJIJPMlskULku9yaK+tODGkj7DW8yQ/eJCnmvS9as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGksKg4R10A5v7fwn05lVZu5Nx4atr7PUzK7fmO5XUalzYLwvx8BINcE82IWBQyma
         SlU+bC7fL5VaEwYi/PZxGvcuGCzuxZG6kAloNLVT+ChWVjARlTx9MCPVJp5wLbJdtF
         Xd0sp+/MBApRSNjeu9BBjROt0tCZ8cAN2M1P7gC2p2KkTLTZbBKOUUMmRH7OpzPm76
         TRnbNJJZTvynE3O13njW26RkfUibF39HEdNDQeoy2dIdIR110Tx7nS3HQ4df5hU752
         Pe6jAqrUdae9Axm1QW2+6d7/0rOKJc0j4DuK9f88dqG2+F2jTa3NLFsQdpzpWezHP9
         UVYHg0rLOz7Wg==
Date:   Tue, 8 Feb 2022 15:46:20 +0000
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
Message-ID: <YgKQTLwW+ha5XNx8@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
 <49da0f58-7a20-e557-54c3-34bd7074f711@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a0nOFmUi8k/21Hgr"
Content-Disposition: inline
In-Reply-To: <49da0f58-7a20-e557-54c3-34bd7074f711@linuxfoundation.org>
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


--a0nOFmUi8k/21Hgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 07, 2022 at 05:10:35PM -0700, Shuah Khan wrote:

> > +++ b/Documentation/arm64/sme.rst
> > @@ -0,0 +1,432 @@
>=20
> Missing SPDX here?

Only a couple of rst files have SPDX documentation here, I guess the
SPDX people aren't worrying about documentation?

--a0nOFmUi8k/21Hgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICkEwACgkQJNaLcl1U
h9AJxQf/biL9lh017hFUh2yzO+cXO2WAlCO8hMp+diLpKGjXJsHjbB+/BeJu9X1I
CpAQL2bMPweDbErwHK4EgdIzguG983JnF83hfxwPfYlP9wIeTlYqOG5vQGYscXhI
wQmoy5NCgCly1vL6+1uSoMj5P4Iot8SnmQOG1ZraCT7l2NRmcF/UQf0Lu/tZgK4S
SIalo2MpLDxODhkaXYkaRorbu97DOV4DVroDon8kEqH5VEVykzK65nXDytvQWwNr
Q/c93T32M5r+SP4aX16vrLu1dmDJolARtDIFNRnAmQLxuIZsIx0VqH0VKTxALMlK
1RWedBYAFc5LnyG7I4DMTdtEHIfQZA==
=yh62
-----END PGP SIGNATURE-----

--a0nOFmUi8k/21Hgr--
