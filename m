Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC34BEE09
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Feb 2022 00:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiBUXjk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Feb 2022 18:39:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiBUXjk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Feb 2022 18:39:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5619240AB
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 15:39:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F8BA61361
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 23:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C38C340E9;
        Mon, 21 Feb 2022 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645486755;
        bh=q1IlG4736I9Ca4Bq23/owtBp8HKg6Hi5NPLrAAnQ0Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6npgAsfP5Wc5GBQf0mEfmGaX4vrAjF3DBucFy0sna5O0oCTNc9+B/wsiusUUcHyC
         U9aGGlFl/ONhM711uVuVCzg6FhNN5TnADzNcac2glj6xIXpCJcV/hLR/pUvyTZsHOw
         v7GYPTA0OYJL0E7s08NiFscoYjP3MvvpE82VLkfX2fTM9aGkAHrbK0gkmgeq9L2ODP
         6xFhV+Zk+dXYbxEX55hHEBOINLmRLS4fo5fCXoG5UEaEIXdJqL0Cmc2kg1Jb7CRf+m
         0VrXa1Zc6QBMPlA7sSGuj2dbK8nu99fuEvExEMm4aLTBm11FqKEDuckmpJk7xQ6R5d
         zwOiWhbD6gx+g==
Date:   Mon, 21 Feb 2022 23:39:07 +0000
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
Subject: Re: [PATCH v11 11/40] arm64/sme: Identify supported SME vector
 lengths at boot
Message-ID: <YhQim+ezIauVvE5v@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-12-broonie@kernel.org>
 <YhO2YJ1mliDYjy67@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cfWJdZnctFslGcVc"
Content-Disposition: inline
In-Reply-To: <YhO2YJ1mliDYjy67@arm.com>
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


--cfWJdZnctFslGcVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 21, 2022 at 03:57:20PM +0000, Catalin Marinas wrote:
> On Mon, Feb 07, 2022 at 03:20:40PM +0000, Mark Brown wrote:

> > +		if (IS_ENABLED(CONFIG_ARM64_SME)) {
> > +			sme_kernel_enable(NULL);
> > +			vec_init_vq_map(ARM64_VEC_SME);

> Why do we need to call sme_kernel_enable() here? It's called again later
> via the cpufeature framework. I guess you need the CPACR_EL1 setup but
> we don't seem to do this for SVE.

It's not needed any more, it's bit rot.

--cfWJdZnctFslGcVc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIUIpoACgkQJNaLcl1U
h9AelAf+JxDGkO9etXGN9Qaw8x9BIScL19CYJdSOuNS8CUsg/wCZeHMIqhuTowDB
G3BSLkhbE1Tx5HnfECHCPq8eGyrEj0VV8mMW7z7dLX6ra1fvMVDXZC1Qc94gD/Q4
qgrJf6JnDPsMheUjFXJwWet6v6v245tO07vmgUSCbw7fy9Qe30pJEMqo7dz2yElQ
uDaeEJWEvqXlfpZPzsBFpNZStG28smGCnmHGk6ONEyWaZaqO0KrPNy/ibf0R4WkH
1V6Fe5opF5a92UubRQckrXhcKWoDP8zCJYIzrSgtPGKCLSEcB4qCRpl0itdSI173
DgMEKQh1xF/TqEJThDO/pgo7Zl3zEA==
=4fVM
-----END PGP SIGNATURE-----

--cfWJdZnctFslGcVc--
