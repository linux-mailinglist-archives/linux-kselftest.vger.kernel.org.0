Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730AE512097
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbiD0RRy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243939AbiD0RRx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 13:17:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB11433B0
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 10:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A903B827C4
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 17:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E129AC385A9;
        Wed, 27 Apr 2022 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651079677;
        bh=1Wyh8HAQGleHtCXp63QH7fWGdVyOUhsSM+yv05Z8elw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJjI+yPUj/93d5Yww+huZrME56O8muQF4VW5ow0L+Uu29fJA6xhv6GlKKQbzgj17j
         jC187r2Foq4IBQ3URPZbgESLFL/xLgqqAEUJqh06sUc2BbRX3RnobTWb5+OSjAQgye
         +N3oQHj5OHBqf3vpLbLeDlVgFiE/HD1j2EbgNUABCb8qS2xYxOrq033ydwJX3vZEgI
         ApSQ4pdqE2SMfIoyRdf5wmsgxmcedu1UxWfZpSbr0yDfcDSnhM7o01IVJNqaqa/d7V
         Wt6bpcnNaNvoQpg6U0n6KU8gnQMuWTYNW8dmaZPWU6DY8hRRkoO/xVk+X8S/+lrmkD
         CDv5L3Y3FE9RQ==
Date:   Wed, 27 Apr 2022 18:14:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Alan Hayward <alan.hayward@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>
Subject: Re: [PATCH v14 00/39] arm64/sme: Initial support for the Scalable
 Matrix Extension
Message-ID: <Yml599vM948wXt6g@sirena.org.uk>
References: <20220419112247.711548-1-broonie@kernel.org>
 <20220427170858.GA2009@qian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SPfSU1Fp6tBwB5Ei"
Content-Disposition: inline
In-Reply-To: <20220427170858.GA2009@qian>
X-Cookie: Buckle up!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--SPfSU1Fp6tBwB5Ei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2022 at 01:08:58PM -0400, Qian Cai wrote:
> On Tue, Apr 19, 2022 at 12:22:08PM +0100, Mark Brown wrote:

> > but not SVE, SME is an ARMv9 feature and SVE is mandatory for ARMv9.
> > The code attempts to handle any such systems that are encountered but
> > this hasn't been tested extensively.
>=20
> Running CPU offline/online on a Neoverse-N1 server will trigger a crash.

Can you try with=20

   https://lore.kernel.org/r/20220427130828.162615-1-broonie@kernel.org

please?

--SPfSU1Fp6tBwB5Ei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJpefYACgkQJNaLcl1U
h9D1cAf+Onw5Pv5V2hKpJvcA5UX72wxZZ5Ln0Tt1QZLj8ao+nwGOLjwfk9EsK1Vd
h5lSxFF5OlEPCcmcKAbeoxzBv+j5YdlW5ifiHToAt7faO67xrTBI8EZBWXTqp6Ht
qANgoQvint2TO0GNxmkjSnI4itbJ2552NLuGSA7sdEevyat94D6gWeJqqiLShsDa
c7DbFEdzWX+AQrGzJ24vzGHCSG5AmA5VFnl9kqxA7aBouymENDc0EzDMPv6h72tH
blNLM01jSkNMvMiT6Z2okfgeXdHZ1u9ZgVof8w9skZeyt4ZtoPgGKSytliSZTu6i
ug033/8MxGzNUKABtp7oxitOR8+O8Q==
=bIU0
-----END PGP SIGNATURE-----

--SPfSU1Fp6tBwB5Ei--
