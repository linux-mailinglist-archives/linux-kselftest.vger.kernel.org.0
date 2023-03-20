Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53C06C126E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 13:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjCTM5Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 08:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCTM4u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 08:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5E719A5;
        Mon, 20 Mar 2023 05:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63E1E614C4;
        Mon, 20 Mar 2023 12:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A23C4339B;
        Mon, 20 Mar 2023 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679316923;
        bh=dG3rgQEOE1xh6Y0d4k+wkRiHch3qwNxwNb1/iqQQHj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1MuoDkIUAyHs2N0ek7SxR5gI7ILGTPmNt88hYmObzKYDLiAK0GOzEpjSfgR34gOz
         Myj41pKGTVTJYvtrKun01zYvrW4AcD5K5vBEG7XxSnvWW5qvgREWVUDl2gifMF4cxP
         CN8roRCRc3Fes8sVVtHbOc/l4kRD/XWeV7sApRHSTlaLEwJU3EZl4zjJ9NWhjnXMwB
         PkCJ2pohrR+2ehCXOOoB/bIJIBbrzFdriorwqL0wFDScCxYvI7XBPTaQFVY56uFguv
         4r+EOoSnErs99/Dt9K/iYuOhUa9378fYTrn/C371/sm0GQ7aF3I+/LOTpVtWZuhukj
         K7+GUyXJZuBkw==
Date:   Mon, 20 Mar 2023 12:55:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: selftests: arm64: list of test failures
Message-ID: <4583cfa7-f733-4dcf-8066-dcd9b2c4ebda@sirena.org.uk>
References: <CA+G9fYstgoa7jsO9rTmdDR4ZDUFQXdDqax8SongkOCZxFmX3Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RYpAzemWZ7vrro8f"
Content-Disposition: inline
In-Reply-To: <CA+G9fYstgoa7jsO9rTmdDR4ZDUFQXdDqax8SongkOCZxFmX3Og@mail.gmail.com>
X-Cookie: Keep away from fire or flame.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--RYpAzemWZ7vrro8f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 01:40:13PM +0530, Naresh Kamboju wrote:
> selftests: arm64 below list of test cases fails on Linux next and
> Linux mainline builds with clang-16 and gcc-12 kernel booted on
> recently configured tuxrun qemu-arm64 (v7.2) enabled with MTE=3Don.
>=20
> Am I missing anything on test configs / environment ?

Your qemu is buggy, 6.2 has a known issue which has subsequently been
fixed.

--RYpAzemWZ7vrro8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQYV7QACgkQJNaLcl1U
h9B1Dwf+NF+PXjRcQABF+Qbuv5q4yhCm3eJRdLGq0hkXD7fm6kKvh81T8jvwwTAb
b/PcaUDAbceQOysCTBcjWBxvwHDpNI9kNYqtxKtSyNrw8tF2VUjvrxQL+rC3yqsx
UEnkuCNhCgz7CEzohyKUlI95pvo66lTZSIDkYsnVibiVW0vfmNo3TSQW54kDDl6/
u0CbJ1u2SkgOlf5ddaRT79I9SK3hxeiNMHEAw4o8jmwdL9vVxvTUReJg4LFo5WJ0
lW8XOijFOolF+WsyhMLs1nKjuEPynB2Bq4ZxrVuqdO7JxS4WSEpdEhng+maZb3K7
H8R89XdQmi6fNI6ICLcTW1N/nPxFRA==
=bO2d
-----END PGP SIGNATURE-----

--RYpAzemWZ7vrro8f--
