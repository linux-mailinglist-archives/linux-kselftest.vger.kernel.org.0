Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABD069B118
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 17:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjBQQiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 11:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjBQQiV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 11:38:21 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70429199EB;
        Fri, 17 Feb 2023 08:38:15 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9F4051E18;
        Fri, 17 Feb 2023 17:38:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1676651892;
        bh=b0acJb9pUW7KPBRZUk8+qJN8ems67QwFNdAqyRhHEAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JH2e3nV5IdEXVOjP9nwOHnELfyplyVPxo9p0PhqIErHO1+VEGEYUWVUWwRTpkULaI
         uou02y9+LzSgZtDCN6hTCnoC5DqtPXolgSjPe2CfprcUSxaRoQPsmXSaF+xn5aLuuA
         IYLHCRArvE0f7zXxOxPB9yRVE/89l70rUts9h9Kr3/A7qeTbgmRQx3vZbwTYFNm1nk
         oWTJ+qRbEjcn8I7vhKrx+vTzZ1h12maK/ZibQgRYuuFwa9KOZsW8JCeKgzkfGKBRQ8
         YX02zT5g5ZxXMJq74HnoKa5a3s2NtXlT9FvJBhdHCUX88QvwDT3ebuFxNfOCN8mLp+
         meNQhdmqLv4rQ==
Date:   Fri, 17 Feb 2023 17:38:11 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] selftests: hid: import hid-tools hid-multitouch
 and hid-tablets tests
Message-ID: <20230217163811.i2dvoffzqyqwhc52@tarta.nabijaczleweli.xyz>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
 <20230217-import-hid-tools-tests-v1-6-d1c48590d0ee@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3mws5jieo4g5ql5j"
Content-Disposition: inline
In-Reply-To: <20230217-import-hid-tools-tests-v1-6-d1c48590d0ee@redhat.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--3mws5jieo4g5ql5j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2023 at 05:18:00PM +0100, Benjamin Tissoires wrote:
> These tests have been developed in the hid-tools[0] tree for a while.
> Now that we have  a proper selftests/hid kernel entry and that the tests
> are more reliable, it is time to directly include those in the kernel
> tree.
>=20
> There are a lot of multitouch tests, and the default timeout of 45 seconds
> is not big enough. Bump it to 200 seconds.
>=20
> [0] https://gitlab.freedesktop.org/libevdev/hid-tools
>=20
> Cc: Peter Hutterer <peter.hutterer@who-t.net>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>
> Cc: =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>
> Cc: Bla=C5=BE Hrastnik <blaz@mxxn.io>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  tools/testing/selftests/hid/Makefile               |    2 +
>  tools/testing/selftests/hid/config                 |    1 +
>  tools/testing/selftests/hid/hid-multitouch.sh      |    7 +
>  tools/testing/selftests/hid/hid-tablet.sh          |    7 +
>  tools/testing/selftests/hid/settings               |    3 +
>  .../testing/selftests/hid/tests/test_multitouch.py | 2088 ++++++++++++++=
++++++
>  tools/testing/selftests/hid/tests/test_tablet.py   |  872 ++++++++
>  7 files changed, 2980 insertions(+)

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>

Best,

--3mws5jieo4g5ql5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmPvrXAACgkQvP0LAY0m
WPH/kBAAgvUlsF8qiI5pXZnAsOVS35kh2cZxvEkxVhKMpPPP5tRW74m5r3QD+5Ex
dYaz7yxGEYbq6L+kxOyGbjenfMHE4JcL9xNo6IM1u1tg1vm/IrIcvuOz6eXTksVb
4mizmWewe71KpqMaqaa47S1nHo3RVta5WMr/GW725kwVfiGgxQIZ3x0+VvxkTlDr
0qW+MeSMc6mstoTQRZBBCjQFOfjmXwh7+ztd/YJxi5D999SPvuR4Ys8N7iz97Z0A
F1evfLE36/h6qvOuT1dLa2rwuuqHGA4JZ5zupzD7vVaPO4Y16r3hwSS2OYm7JBre
L5CakjB+gvK5xBxkQ+25h9Td3dMDlAoSvb5C6swD5qbdq1fOEL83ayAOR19FI/Uo
qFWJ3mU55CPPxpF19kAxqteFPKPgEapvvUAONYrOVmRHjy8wiabWqlT46TLn7Mqj
htWrXNdmjL3eO7J0rCrJk9zSD6ihDtuxj7zqqPo2+671nHjF0/tX8jkurfsS0rKw
qKlDBS75Z4vkXHHhOyCuUtYx7bZyIuySTHFDtIG8n6+NM8KU0QHP1sfJWdYsV9d1
Ur9aSkaNDAF0MY4aDCk3WwE5admvOizNAO7IOYTE7JuBn02758fMrtEytKkWDSJT
jdC248fB80Lo2zaMuD/e6nPaS4u9s0OivcooHKl5/SOjGxoUnxg=
=8SUP
-----END PGP SIGNATURE-----

--3mws5jieo4g5ql5j--
