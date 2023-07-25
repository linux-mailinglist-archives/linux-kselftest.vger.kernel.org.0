Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10611761920
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 15:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGYNAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 09:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGYNAq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 09:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C288BC
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 06:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26B2061709
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 13:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81030C433C8;
        Tue, 25 Jul 2023 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690290044;
        bh=8sekik/Gnl6y5amkaat0UOSbm8J0fnSVApjOC+oLZH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFOVpHdonxY1zkZMGUWUzGK02JkqeILhgvmj8ZqXipjPGoyYY11pJfcQZOY0xz059
         qSam6Bkj8usRN9HS1qcparPY7hbTmKsMarEstuvGzwnOGHVBKUcoHieZXMnReqMjcj
         5Zr/dvAskoyfOBsiWUSBMEsTXYCxU2+oV6Dgw79f7zXlFHpXAY7FPUcgWVB4pYWDuI
         2PmLiU/DM7UmiMoIq1KNvMqAGjfU9AG5RRUGtLO0OEGNNBacF2aEIhq42fPL41MOQ9
         x1mIYTL9PLNEAULsqFYTTelwddfQvVq2JKSRVLhhyDM6oPgdCR9Y4GStv7VUABvUvo
         vkrbdfcezELNg==
Date:   Tue, 25 Jul 2023 14:00:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: selftests: arm64: za-fork.c: kselftest.h:123:2: error: call to
 undeclared function 'setvbuf'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <41cd365e-7757-4c93-9d36-0a258d6d59db@sirena.org.uk>
References: <CA+G9fYus3Z8r2cg3zLv8uH8MRrzLFVWdnor02SNr=rCz+_WGVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iI9utGQiQA7jRuVu"
Content-Disposition: inline
In-Reply-To: <CA+G9fYus3Z8r2cg3zLv8uH8MRrzLFVWdnor02SNr=rCz+_WGVg@mail.gmail.com>
X-Cookie: Happiness is the greatest good.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--iI9utGQiQA7jRuVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 06:26:34PM +0530, Naresh Kamboju wrote:
> selftests: arm64: za-fork.c build failed with clang-16 due to below
> warnings / errors on Linux next-20230725.

Ryan, this looks to be your setvbuf() change:

> Build failed for:
>   - selftests: arm64: za-fork
>   - selftests: arm64: za-ptrace
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> clang --target=3Daarch64-linux-gnu -fintegrated-as
> -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argument
> -Werror=3Doption-ignored -Werror=3Dunused-command-line-argument
> --target=3Daarch64-linux-gnu -fintegrated-as
> -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
> -include ../../../../include/nolibc/nolibc.h -I../..\
> -static -ffreestanding -Wall za-fork.c
> /home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/arm64/fp/za-fork-a=
sm.o
> -o /home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/arm64/fp/za-fork
> In file included from <built-in>:1:
> In file included from ./../../../../include/nolibc/nolibc.h:97:
> In file included from ./../../../../include/nolibc/arch.h:25:
> ./../../../../include/nolibc/arch-aarch64.h:178:35: warning: unknown
> attribute 'optimize' ignored [-Wunknown-attributes]
> void __attribute__((weak,noreturn,optimize("omit-frame-pointer")))
> __no_stack_protector _start(void)
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from za-fork.c:12:
> ../../kselftest.h:123:2: error: call to undeclared function 'setvbuf';
> ISO C99 and later do not support implicit function declarations
> [-Wimplicit-function-declaration]
>         setvbuf(stdout, NULL, _IOLBF, 0);
>         ^
> ../../kselftest.h:123:24: error: use of undeclared identifier '_IOLBF'
>         setvbuf(stdout, NULL, _IOLBF, 0);
>                               ^
> 1 warning and 2 errors generated.
> make[5]: Leaving directory '/builds/linux/tools/testing/selftests/arm64/f=
p'
>=20
>=20
> Links:
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMB=
LYJCp4OXDmWl/build.log
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMB=
LYJCp4OXDmWl/
>=20
>=20
> steps to reproduce:
> ---
> # tuxmake \
>  --runtime podman \
>  --target-arch arm64 \
>  --toolchain clang-16 \
> --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676Hp=
K243gMBLYJCp4OXDmWl/config
> LLVM=3D1 LLVM_IAS=3D1 dtbs dtbs-legacy headers kernel kselftest modules
>=20
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org

--iI9utGQiQA7jRuVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS/x3YACgkQJNaLcl1U
h9A+HAf/ajSK7fsaQ7pFA4UmmplIY7TElZG3fFh/uRlbVCrm1JWaMTYplygyrBtE
Xpaw4qhMpe59ob7tDxns8AVoE45fx8mvckYemJYIay0jTiY3y3+tZIsRE/6sVYGU
+lCGi+wL75M8KeBlUlkWb2N/rfgYo4yu4PR87KS+O4BX86UNKwqAj2MLzemsM1Da
YwicZAI4Rl/nzdraABVfoU7jJNuXU+0Y1VKeHrSBtiZYVyBA95qpw1sh7vp+PB2u
/JpPT4xqyeJGfRH7oZqnma6DFsfJFNQqRM38ffcrkyoleL3S+VCMTJMXwDGlhHTx
uECryolbJBCSFYox3hcOJfc882BFqA==
=961+
-----END PGP SIGNATURE-----

--iI9utGQiQA7jRuVu--
