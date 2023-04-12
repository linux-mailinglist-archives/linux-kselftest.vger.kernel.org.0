Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764BA6DFAA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjDLP6q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDLP6p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 11:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4C93C2A;
        Wed, 12 Apr 2023 08:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEC02632DC;
        Wed, 12 Apr 2023 15:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973B1C433EF;
        Wed, 12 Apr 2023 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681315122;
        bh=Sz1fajTEnTSRD31WR8VDCczBSAJtygp8Yr5Rf0oACkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYNrSxXAnH2t/pEIJxou6eRtCBAE6tSYuNM66nrW22jXhdMPXufnQRX/oHRvrS7DK
         hZsKN3AZzvkhRLlYncPG7l4vP2L1ANtK8eFXXAFvkm02OHvDuyZXxNy9vlVenKnbXb
         H+n9f3d3D2x4Wn8GvwTHiQCtWaJ0vrF8h5Mx4tIrmOihcck+PBzmSnn6iZ51EHYaV6
         finHmGGcEtIsftHJIGVPpRfgkMXA0yaPievdUjVlhmdNOCTL4wuA+TR2aO90Usdtkg
         NCibMzUm3vEXpQifdd8Sfl+ywzoagNhkKqlczSuBpduZbfCl+g6UkfqQBNy2gTjKCd
         fy9lzhW5ExSjA==
Date:   Wed, 12 Apr 2023 16:58:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org
Subject: Re: [PATCH v3 3/4] tools/nolibc: implement fd-based FILE streams
Message-ID: <f28e3c85-84a4-4b30-a3f5-c2efad311fe7@sirena.org.uk>
References: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
 <20230328-nolibc-printf-test-v3-3-ddc79f92efd5@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3BwlXs+yCitnNnmA"
Content-Disposition: inline
In-Reply-To: <20230328-nolibc-printf-test-v3-3-ddc79f92efd5@weissschuh.net>
X-Cookie: Brain off-line, please wait.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--3BwlXs+yCitnNnmA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2023 at 06:04:36PM +0000, Thomas Wei=DFschuh wrote:

> This enables the usage of the stream APIs with arbitrary filedescriptors.
>=20
> It will be used by a future testcase.

This breaks the explicit use of standard streams:

> -static __attribute__((unused)) FILE* const stdin  =3D (FILE*)-3;
> -static __attribute__((unused)) FILE* const stdout =3D (FILE*)-2;
> -static __attribute__((unused)) FILE* const stderr =3D (FILE*)-1;
> +static __attribute__((unused)) FILE* const stdin  =3D (FILE*)(intptr_t)~=
STDIN_FILENO;
> +static __attribute__((unused)) FILE* const stdout =3D (FILE*)(intptr_t)~=
STDOUT_FILENO;
> +static __attribute__((unused)) FILE* const stderr =3D (FILE*)(intptr_t)~=
STDERR_FILENO;

Nothing in this change (or anything else in the series AFAICT) causes
STDx_FILENO to be declared so we get errors like below in -next when a
kselftest is built with this version of nolibc:

clang --target=3Daarch64-linux-gnu -fintegrated-as -Werror=3Dunknown-warnin=
g-option -Werror=3Dignored-optimization-argument -Werror=3Doption-ignored -=
Werror=3Dunused-command-line-argument --target=3Daarch64-linux-gnu -fintegr=
ated-as -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
	-include ../../../../include/nolibc/nolibc.h -I../..\
	-static -ffreestanding -Wall za-fork.c /tmp/kci/linux/build/kselftest/arm6=
4/fp/za-fork-asm.o -o /tmp/kci/linux/build/kselftest/arm64/fp/za-fork
In file included from <built-in>:1:
In file included from ./../../../../include/nolibc/nolibc.h:97:
In file included from ./../../../../include/nolibc/arch.h:25:
=2E/../../../../include/nolibc/arch-aarch64.h:176:35: warning: unknown attr=
ibute 'optimize' ignored [-Wunknown-attributes]
void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(v=
oid)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from <built-in>:1:
In file included from ./../../../../include/nolibc/nolibc.h:102:
=2E/../../../../include/nolibc/stdio.h:33:71: error: use of undeclared iden=
tifier 'STDIN_FILENO'
static __attribute__((unused)) FILE* const stdin  =3D (FILE*)(intptr_t)~STD=
IN_FILENO;
                                                                      ^
=2E/../../../../include/nolibc/stdio.h:34:71: error: use of undeclared iden=
tifier 'STDOUT_FILENO'
static __attribute__((unused)) FILE* const stdout =3D (FILE*)(intptr_t)~STD=
OUT_FILENO;
                                                                      ^
=2E/../../../../include/nolibc/stdio.h:35:71: error: use of undeclared iden=
tifier 'STDERR_FILENO'
static __attribute__((unused)) FILE* const stderr =3D (FILE*)(intptr_t)~STD=
ERR_FILENO;
                                                                      ^
1 warning and 3 errors generated.

The kselftest branch itself is fine, the issues manifest when it is
merged with the nolibc branch.  I'm not quite sure what the implicit
include that's been missed here is?

--3BwlXs+yCitnNnmA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ21SwACgkQJNaLcl1U
h9AZBQf8DJal6OJHifjyunW7cVsIhwp8/OXNFwIY1HNl3CXYXE+TRKeeNvmfl7UI
sVbKzqryTerbl/BMnbN1HuPUCLtuVGv+CQJ0ZWIRwUN98lhKc/yYU9cMJPbgJesC
S9mnVucGFqXMpvItJaoPZjdWyUZ7rOJVM/DkBbw3Lxv6sisI6sQC4Scg92v62q36
ZJTW7p7Esc+HKR5L5ny1DCujCRt4UPRz3xExhZj6OmjfjcTCPkK/vIJjoVCadkOb
r18/bQa4PamCc+To2qbe2qribqwrBLVEiFKaDUSnLC7tGW3E4pFtQFcH33fyikEW
gp34TTiAVcKwgIqZi65VbYMGIaIXwA==
=95Ju
-----END PGP SIGNATURE-----

--3BwlXs+yCitnNnmA--
