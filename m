Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C11650E3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 16:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiLSPEt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 10:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiLSPEo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 10:04:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CFBE0CD
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 07:04:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7843B80E50
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 15:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E311C433F1;
        Mon, 19 Dec 2022 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671462278;
        bh=CmhuRHP8mkL/wl8RnQZbvtMK2PExRu2c9Hpn8B14ETA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqPn7ayRGaf1JJF3fQxlpudZPPuD51RpCc4580VeMBBwP7TinD07LkKeqFIkL93CJ
         qDmRxjgPAxlZK9tg5KHoaZ9C3B2+lJTKLRG1JJTtuVe1VyzSo2rsGsQCU6SasKAGYT
         Hhx8Orld0vnSgsDKOAs9Kx0lHFfeu1tGlm2AhrXIZlaV1m6D80a0P/Rt6C6914DESn
         k+b+RNDUyaqYQN+ujcCv+ll5AHuYCCKNWPrwOMR4ChAcjRrDxL9sxPvDCfiW9fWYUP
         EdIlF2EB04n9EOToyd+qPkiV25L2o04lbBqPEgsO2D5zzSQX8JxpsWH831aoPVZjEg
         OxDQ37rr746dQ==
Date:   Mon, 19 Dec 2022 15:04:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 06/21] arm64/sme: Manually encode ZT0 load and store
 instructions
Message-ID: <Y6B9gUVkDxcbwfnI@sirena.org.uk>
References: <20221111215026.813348-1-broonie@kernel.org>
 <20221111215026.813348-7-broonie@kernel.org>
 <69d85a20-77d4-21b0-20bc-19146eb3e160@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PUicwCEn1DJryd+/"
Content-Disposition: inline
In-Reply-To: <69d85a20-77d4-21b0-20bc-19146eb3e160@huawei.com>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--PUicwCEn1DJryd+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 17, 2022 at 05:40:27PM +0800, Zenghui Yu wrote:
> On 2022/11/12 5:50, Mark Brown wrote:

> >  /*
> >   * Zero the entire ZA array
> >   *	ZERO ZA

> Unrelated to this patch but the zero_za macro doesn't appear to have
> any in kernel user.

Yes, it's not actually needed and could be deleted.

--PUicwCEn1DJryd+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgfYAACgkQJNaLcl1U
h9AgXgf8DBiYJBIwV+AaNdfLXkl/ve2QMAnDxd+fo2L01kTO3qefmcDMZdCPBsUK
40scUc8Frk6ssw4p9lmZtOhFV1VKRDkaGrnU+WiWl062Ig6qW+nqcCyOGXw7/4RC
1rv0hI+Xfkhf940oljxS7WGK9/GwydxgPSrRiCAf8L16kJC/foXge6stAxV3EoDI
k7d9hHFSwCtXlIVbtLFpW7YtAQRG/+fvsHxI0LhzFSnDEWkD78W6L8+iS9df1M0B
Ks1EnoF0QlOMmjwhDn1lRzNs8+f/Q2aoCSF5EljF7x5qHPwBd9JXsXOaLctwnD6c
QCqxTxg2U56ShzSTNf5KZOzd/OZycg==
=E+v6
-----END PGP SIGNATURE-----

--PUicwCEn1DJryd+/--
