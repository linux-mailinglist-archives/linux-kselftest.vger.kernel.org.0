Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D896349B3D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 13:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382498AbiAYMSA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 07:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386957AbiAYMPi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 07:15:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20795C061773
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 04:15:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B312260F83
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 12:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC0EC340E0;
        Tue, 25 Jan 2022 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643112936;
        bh=+BPgF8RegY0meHVcPfjKYDlnsQFJtpvb4tI1Bi3dYXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtM0nmjKZgFQbwMBnBGO/d5R3rHePax1BqLreg9msC+fpgKIGKk0ZGrk7Lk0bWo08
         jEaruAfvfaT3zWVSlNFBOE3WVaQ9xfJPC87FnkuwedSYGET09lWy1LCQeiBinB2rdb
         lwgoV5gjF8Go/Nj7Wl5q8tq8sn16X+fOInxNXBfHDuXccGOu652i/xwLYjX9+YmsA4
         AtnS6Pr1WTGHgZog1BdwBhDrBatOqqHwnXEs3cQqdMN0o1lf6v32CgLbJkRKEyhUkx
         9HxKqsipXfZG/GWBrdy12AHY+uHLxC6nxRDSSpqUg29V1zJ9u9g6xJqsviMtfNb3OI
         u+vA4aFtVw4Fw==
Date:   Tue, 25 Jan 2022 12:15:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v8 05/38] arm64/sme: System register and exception
 syndrome definitions
Message-ID: <Ye/p4YpWWnZSPFaZ@sirena.org.uk>
References: <20220125001114.193425-1-broonie@kernel.org>
 <20220125001114.193425-6-broonie@kernel.org>
 <87zgnk6or8.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DA6PqB3G+/AhTsSL"
Content-Disposition: inline
In-Reply-To: <87zgnk6or8.wl-maz@kernel.org>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--DA6PqB3G+/AhTsSL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 25, 2022 at 11:25:31AM +0000, Marc Zyngier wrote:
> On Tue, 25 Jan 2022 00:10:41 +0000,
> Mark Brown <broonie@kernel.org> wrote:

> > +/* HFG[WR]TR_EL2 bit definitions */
> > +#define HFGxTR_EL2_nTPIDR_EL0_SHIFT	55
> > +#define HFGxTR_EL2_nTPIDR_EL0_MASK	(1 << HFGxTR_EL2_nTPIDR_EL0_SHIFT)

> This annoyingly clashes with bit 35 of the same registers, which maps
> to TPIDR_EL0. I have the feeling that this really should be TPIDR2_EL0.

Yes, it should be.

--DA6PqB3G+/AhTsSL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHv6eEACgkQJNaLcl1U
h9Bqogf/cPq0bM4yoDggdP1uvRbGK1VpH1TSSNyNLxG6PNgq8w3D5EY8BuCDrP40
Ss+eJ0UElwdsoXScwvFKoIeXt6pGtughyC2uEnxz+rif0YlGOQyoWg9SWbzq56+g
lSrYeMGyIPzHiJaXtjsFQEQBfiRoxEGilmte8Owq01WhyTea9cEZbYyu9Wk8pjJZ
GWPOOMBXqCRPL5zbFVJsGEV4meEMFew/pqNCZJw5jgkUEHGj8ln92kipxoE8YULJ
ibed2fmR2WpadC7SftEzh9S/Gd+I2XBxtw5bg7f8OSqn0NAit0umxnwXVmT1jGxu
+kQ/lXqNg/SndWNAKKGAWteJRQqTUA==
=nbA7
-----END PGP SIGNATURE-----

--DA6PqB3G+/AhTsSL--
