Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF2664BC29
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 19:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiLMSh0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 13:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiLMShJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 13:37:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8539724F18;
        Tue, 13 Dec 2022 10:37:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E89C4CE1788;
        Tue, 13 Dec 2022 18:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C48BC433EF;
        Tue, 13 Dec 2022 18:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670956624;
        bh=TZt06SyB1pRuSeRM8PyPzTftv5HrZokdtl7YXOZCqLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODZmT8ris3vWslK2p0e3u3fRwVt9Z0vKqngv66h3i2t2Ros4cxz8qyp+ZeIe2/s4Z
         LWwdx1HWTlVC5hbJmd6RX8KaiIllJ9w/WLONqDiWhG6FT/xk0IwwZiEAogRje+kKBX
         pBtxdOk91SpTDB08KiMuNF8NfPReJylCwNXz9yjzMNf/QD5TCSIsGZCJ/ss2Izpcnh
         UyUFkToyN6Apx4Whg0bWMbo0sBSNLIdSZw2Oz6kn+9Jude6pc8dCU0/zNnZulqMu3t
         bTsMR0bB5nhfxgjiaEAnwAhW9hMUNNWqeMfF7ObpiIbXJ9+1RyH7vrTZUjhD4X6g4u
         oQ6+1H2QTnHiQ==
Date:   Tue, 13 Dec 2022 18:36:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Increase kselftest timeout
Message-ID: <Y5jGSk0WQ6OwYuT/@sirena.org.uk>
References: <20221213183242.1908249-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o4OjguzpDJJHyi8a"
Content-Disposition: inline
In-Reply-To: <20221213183242.1908249-1-nfraprado@collabora.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--o4OjguzpDJJHyi8a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 03:32:42PM -0300, N=EDcolas F. R. A. Prado wrote:
> The default timeout for kselftests is 45 seconds, but pcm-test can take
> longer than that to run depending on the number of PCMs present on a
> device.

Reviewed-by: Mark Brown <broonie@kernel.org>

This is also useful for mixer-test with slower control buses and fancier
CODECs.

--o4OjguzpDJJHyi8a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOYxkoACgkQJNaLcl1U
h9CYiQf+OQRoREGJ0ahUyN/ztXNCsKXPSDumEO7MjTxV2r5SNAGhJyfY0nJBXkZq
6qBS/liQx8l1vt80ShBTn4u+2eqz60W92WRfO8A57bOEScn//N2wDECoC+6Qu+Kt
5mSsuF+8X28+oejIuguyjtFstR28yecl/LAJNZtWr1ppUxmm4vilCbsD7rO3Pcx+
TeMg/WnaK8gy8wbUV2dfmUn61N2J1Y5+L26GxeA5v0ro4l4Hbh9UPJpJllWXVlB8
DgaBkv38r1EwaK8VL1Xl264VXeOAa/sKoXx8QEfpz6laSbUs8qADkm0Hjb1UParx
sQIus6/udG238dBmQTC+EzsXSNj3zw==
=2DJM
-----END PGP SIGNATURE-----

--o4OjguzpDJJHyi8a--
