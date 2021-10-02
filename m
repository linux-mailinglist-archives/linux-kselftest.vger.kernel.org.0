Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1499041FA44
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 09:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhJBHYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Oct 2021 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhJBHYO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Oct 2021 03:24:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBDAC0613E9
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Oct 2021 00:22:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g193-20020a1c20ca000000b0030d55f1d984so1754609wmg.3
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Oct 2021 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pmGpQX/Zl8xEvrb/CboG3QRe7xOAnyymc/VH7jNEziw=;
        b=WTg8Q/LGYJeIyz2zcAyOkwbKic2kHHnGShxJYrlMAK35mHCKmEGN6OD25SBrojWsQY
         cTLMyYgati/Au2x5bKvrRDIfhgKImxOS/DmfBmjhN00OEE+7znBtR3mJYUYmyem3O0u8
         yTaNvCCmuA9PcLYBGmlFtwSNH0RBdWIGSSRlP6kwpozed4suGEBRWPXVEW9N5IoA2CcK
         Pr7K5sCRBKSYohD0rdhGCExqdL8A9cXF0sP2FNnBd7IEW9Sy4N5zuuyRR6tuqFHwHL5d
         p1gOyuB63MgruoUOVm/Vq9/Wk9s3C2ZZK/6+EBNO11nM5Z6135gKSXfYC09DqM5ssloy
         aHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pmGpQX/Zl8xEvrb/CboG3QRe7xOAnyymc/VH7jNEziw=;
        b=gOiKCUbSr7PTuJzDiTr+8NHPXUiu+c+q1bn+UhYaIuALNSxcH35pH6qo+oD159trtI
         kkEphwTBGvuvOUN+iYrcCdaGhOp4XKmgZvEd1EuOvqrLdf+KTmkxtvhODFLuky8xj++T
         TC8aTaKFxRii7oq7/hH26tQBJwkKCkQmgGtWc7kbtaNPIZuWZ5c7ygigDzCIQT7TXn4+
         icjzN8V+a/tFM5NnoRhoy5pJxGdzwVpcK2zKEslU/ncap6siVguU0XTPaLK2Hxv6yPDy
         XXFXtmJXnKXehNGZBsK85vrWJOpQf+J6b/VJ1UzAwPcNFkpbp/k5cGOuxJ7kWc7p3q+d
         4/XA==
X-Gm-Message-State: AOAM533Q2i9sUaTMz2fsZYDn7wm1hoPQ1tnd4QiIbLdZAr+nnGcNCipP
        i2XBuwQprVz6igQ8NmWiek+Q+JPOYMnf8Y5FrnilFg==
X-Google-Smtp-Source: ABdhPJzOjQo+JRnPbId0IlahS52O3z1GeplhLR5tEciaSm9ovEnvluDHjMKjSCNAE9WJnpgSE73emQG2LffCHi0S+xs=
X-Received: by 2002:a05:600c:1c1d:: with SMTP id j29mr8173542wms.49.1633159347551;
 Sat, 02 Oct 2021 00:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br> <20210926223322.848641-6-isabellabdoamaral@usp.br>
In-Reply-To: <20210926223322.848641-6-isabellabdoamaral@usp.br>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Oct 2021 15:22:16 +0800
Message-ID: <CABVgOSn+_kB64+1VVkw_hqur==3fkunu81kjQczuSgm-Q8c_Hw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] test_hash.c: refactor into kunit
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, ferreiraenzoa@gmail.com,
        augusto.duraes33@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 27, 2021 at 6:33 AM Isabella Basso <isabellabdoamaral@usp.br> w=
rote:
>
> Use KUnit framework to make tests more easily integrable with CIs. Even
> though these tests are not yet properly written as unit tests this
> change should help in debugging.
>
> Also remove kernel messages (i.e. through pr_info) as KUnit handles all
> debugging output and let it handle module init and exit details.
>
> Changes since v1:
> - As suggested by David Gow:
>   1. Keep module support.
>   2. Reword commit message.
> - As reported by the kernel test bot:
>   1. Fix compilation for m68k and parisc architectures.
>

It might be worth moving the changelog under the "---" here, so that
it's not a part of the final commit message.

> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: David Gow <davidgow@google.com>
> Co-developed-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.com>
> Signed-off-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.com>
> Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> ---

I went through this in a little more detail, and I'm happy with it.
It'd still be nice if someone with more knowledge of the hashing code
looked over it, but since George's email bounced, I'm happy to give
this my reviewed-by.

There are a few minor comments below (and above, I guess), which would
be worth doing as part of a v3.

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David

>  lib/Kconfig.debug |  28 ++++---
>  lib/Makefile      |   2 +-
>  lib/test_hash.c   | 187 ++++++++++++++--------------------------------
>  3 files changed, 78 insertions(+), 139 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index eb6c4daf5fcb..04eec87c2964 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2204,15 +2204,6 @@ config TEST_RHASHTABLE
>
>           If unsure, say N.
>
> -config TEST_HASH
> -       tristate "Perform selftest on hash functions"
> -       help
> -         Enable this option to test the kernel's integer (<linux/hash.h>=
), and
> -         string (<linux/stringhash.h>) hash functions on boot (or module=
 load).
> -
> -         This is intended to help people writing architecture-specific
> -         optimized versions.  If unsure, say N.
> -
>  config TEST_SIPHASH
>         tristate "Perform selftest on siphash functions"
>         help
> @@ -2361,6 +2352,25 @@ config BITFIELD_KUNIT
>
>           If unsure, say N.
>
> +config HASH_KUNIT_TEST
> +       tristate "KUnit Test for integer hash functions" if !KUNIT_ALL_TE=
STS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Enable this option to test the kernel's string (<linux/stringha=
sh.h>), and
> +         integer (<linux/hash.h>) hash functions on boot.
> +
> +         KUnit tests run during boot and output the results to the debug=
 log
> +         in TAP format (https://testanything.org/). Only useful for kern=
el devs
> +         running the KUnit test harness, and not intended for inclusion =
into a
> +         production build.
> +
> +         For more information on KUnit and unit tests in general please =
refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         This is intended to help people writing architecture-specific
> +         optimized versions. If unsure, say N.
> +
>  config RESOURCE_KUNIT_TEST
>         tristate "KUnit test for resource API"
>         depends on KUNIT
> diff --git a/lib/Makefile b/lib/Makefile
> index c2e81d0eb31c..0bc336d9d036 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -62,7 +62,7 @@ obj-$(CONFIG_TEST_BITOPS) +=3D test_bitops.o
>  CFLAGS_test_bitops.o +=3D -Werror
>  obj-$(CONFIG_TEST_SYSCTL) +=3D test_sysctl.o
>  obj-$(CONFIG_TEST_SIPHASH) +=3D test_siphash.o
> -obj-$(CONFIG_TEST_HASH) +=3D test_hash.o
> +obj-$(CONFIG_HASH_KUNIT_TEST) +=3D test_hash.o
>  obj-$(CONFIG_TEST_IDA) +=3D test_ida.o
>  obj-$(CONFIG_KASAN_KUNIT_TEST) +=3D test_kasan.o
>  CFLAGS_test_kasan.o +=3D -fno-builtin
> diff --git a/lib/test_hash.c b/lib/test_hash.c
> index db9dd18b4e8b..9cb8b1d2ab06 100644
> --- a/lib/test_hash.c
> +++ b/lib/test_hash.c
> @@ -14,14 +14,12 @@
>   * and hash_64().
>   */
>
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt "\n"
> -
>  #include <linux/compiler.h>
>  #include <linux/types.h>
>  #include <linux/module.h>
>  #include <linux/hash.h>
>  #include <linux/stringhash.h>
> -#include <linux/printk.h>
> +#include <kunit/test.h>
>
>  /* 32-bit XORSHIFT generator.  Seed must not be zero. */
>  static u32 __init __attribute_const__
> @@ -66,40 +64,32 @@ struct test_hash_params {
>  };
>
>  #ifdef HAVE_ARCH__HASH_32
> -static bool __init
> -test_int__hash_32(struct test_hash_params *params)
> +static void __init

Let's get rid of the __init bits here: it's possible KUnit tests will
execute after kernel and/or module initialisation.

> +test_int__hash_32(struct kunit *test, struct test_hash_params *params)
>  {
>         params->hash_or[1][0] |=3D params->h2 =3D __hash_32_generic(param=
s->h0);
>  #if HAVE_ARCH__HASH_32 =3D=3D 1
> -       if (params->h1 !=3D params->h2) {
> -               pr_err("__hash_32(%#x) =3D %#x !=3D __hash_32_generic() =
=3D %#x",
> -                      params->h0, params->h1, params->h2);
> -               return false;
> -       }
> +       KUNIT_EXPECT_EQ_MSG(test, params->h1, params->h2,
> +                           "__hash_32(%#x) =3D %#x !=3D __hash_32_generi=
c() =3D %#x",
> +                           params->h0, params->h1, params->h2);
>  #endif
> -       return true;
>  }
>  #endif
>
>  #ifdef HAVE_ARCH_HASH_64
> -static bool __init
> -test_int_hash_64(struct test_hash_params *params, u32 const *m, int *k)
> +static void __init

Ditto for all other functions in this file: remove the __init.

> +test_int_hash_64(struct kunit *test, struct test_hash_params *params, u3=
2 const *m, int *k)
>  {
>         params->h2 =3D hash_64_generic(*params->h64, *k);
>  #if HAVE_ARCH_HASH_64 =3D=3D 1
> -       if (params->h1 !=3D params->h2) {
> -               pr_err("hash_64(%#llx, %d) =3D %#x !=3D hash_64_generic()=
 =3D %#x",
> -                      *params->h64, *k, params->h1, params->h2);
> -               return false;
> -       }
> +       KUNIT_EXPECT_EQ_MSG(test, params->h1, params->h2,
> +                           "hash_64(%#llx, %d) =3D %#x !=3D hash_64_gene=
ric() =3D %#x",
> +                           *params->h64, *k, params->h1, params->h2);
>  #else
> -       if (params->h2 > *m) {
> -               pr_err("hash_64_generic(%#llx, %d) =3D %#x > %#x",
> -                      *params->h64, *k, params->h1, *m);
> -               return false;
> -       }
> +       KUNIT_EXPECT_LE_MSG(test, params->h1, params->h2,
> +                           "hash_64_generic(%#llx, %d) =3D %#x > %#x",
> +                           *params->h64, *k, params->h1, *m);
>  #endif
> -       return true;
>  }
>  #endif
>
> @@ -112,8 +102,8 @@ test_int_hash_64(struct test_hash_params *params, u32=
 const *m, int *k)
>   * inline, the code being tested is actually in the module, and you can
>   * recompile and re-test the module without rebooting.
>   */
> -static bool __init
> -test_int_hash(unsigned long long h64, u32 hash_or[2][33])
> +static void __init
> +test_int_hash(struct kunit *test, unsigned long long h64, u32 hash_or[2]=
[33])
>  {
>         int k;
>         struct test_hash_params params =3D { &h64, (u32)h64, 0, 0, hash_o=
r };
> @@ -121,8 +111,7 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][=
33])
>         /* Test __hash32 */
>         hash_or[0][0] |=3D params.h1 =3D __hash_32(params.h0);
>  #ifdef HAVE_ARCH__HASH_32
> -       if (!test_int__hash_32(&params))
> -               return false;
> +       test_int__hash_32(test, &params);
>  #endif
>
>         /* Test k =3D 1..32 bits */
> @@ -131,29 +120,24 @@ test_int_hash(unsigned long long h64, u32 hash_or[2=
][33])
>
>                 /* Test hash_32 */
>                 hash_or[0][k] |=3D params.h1 =3D hash_32(params.h0, k);
> -               if (params.h1 > m) {
> -                       pr_err("hash_32(%#x, %d) =3D %#x > %#x", params.h=
0, k, params.h1, m);
> -                       return false;
> -               }
> +               KUNIT_EXPECT_LE_MSG(test, params.h1, m,
> +                                   "hash_32(%#x, %d) =3D %#x > %#x",
> +                                   params.h0, k, params.h1, m);
>
>                 /* Test hash_64 */
>                 hash_or[1][k] |=3D params.h1 =3D hash_64(h64, k);
> -               if (params.h1 > m) {
> -                       pr_err("hash_64(%#llx, %d) =3D %#x > %#x", h64, k=
, params.h1, m);
> -                       return false;
> -               }
> +               KUNIT_EXPECT_LE_MSG(test, params.h1, m,
> +                                   "hash_64(%#llx, %d) =3D %#x > %#x",
> +                                   h64, k, params.h1, m);
>  #ifdef HAVE_ARCH_HASH_64
> -               if (!test_int_hash_64(&params, &m, &k))
> -                       return false;
> +               test_int_hash_64(test, &params, &m, &k);
>  #endif
>         }
> -
> -       return true;
>  }
>
>  #define SIZE 256       /* Run time is cubic in SIZE */
>
> -static int __init test_string_or(void)
> +static void __init test_string_or(struct kunit *test)
>  {
>         char buf[SIZE+1];
>         u32 string_or =3D 0;
> @@ -173,20 +157,15 @@ static int __init test_string_or(void)
>         } /* j */
>
>         /* The OR of all the hash values should cover all the bits */
> -       if (~string_or) {
> -               pr_err("OR of all string hash results =3D %#x !=3D %#x",
> -                      string_or, -1u);
> -               return -EINVAL;
> -       }
> -
> -       return 0;
> +       KUNIT_EXPECT_FALSE_MSG(test, ~string_or,
> +                              "OR of all string hash results =3D %#x !=
=3D %#x",
> +                              string_or, -1u);

It might be worth using KUNIT_EXPECT_EQ_MSG() instead of
EXPECT_FALSE(), as the real goal of this is to check if all bits are
set.

This'd look something like:
KUNIT_EXPECT_EQ_MSG(test, string_or, -1u, "OR of all string hash
results =3D %#x !=3D %#x", string_or, -1u);

If instead we checked if string_or =3D=3D -1u, I think it'd be clearer and
match the message better. (In fact, I think you could get away with
removing the message and using the non-_MSG variants if you really
wanted, though the extra text describing it as the OR of all string
results is better.)

>  }
>
> -static int __init test_hash_or(void)
> +static void __init test_hash_or(struct kunit *test)
>  {
>         char buf[SIZE+1];
>         u32 hash_or[2][33] =3D { { 0, } };
> -       unsigned tests =3D 0;
>         unsigned long long h64 =3D 0;
>         int i, j;
>
> @@ -201,39 +180,27 @@ static int __init test_hash_or(void)
>                         u32 h0 =3D full_name_hash(buf+i, buf+i, j-i);
>
>                         /* Check that hashlen_string gets the length righ=
t */
> -                       if (hashlen_len(hashlen) !=3D j-i) {
> -                               pr_err("hashlen_string(%d..%d) returned l=
ength"
> -                                       " %u, expected %d",
> -                                       i, j, hashlen_len(hashlen), j-i);
> -                               return -EINVAL;
> -                       }
> +                       KUNIT_EXPECT_EQ_MSG(test, hashlen_len(hashlen), j=
-i,
> +                                           "hashlen_string(%d..%d) retur=
ned length %u, expected %d",
> +                                           i, j, hashlen_len(hashlen), j=
-i);
>                         /* Check that the hashes match */
> -                       if (hashlen_hash(hashlen) !=3D h0) {
> -                               pr_err("hashlen_string(%d..%d) =3D %08x !=
=3D "
> -                                       "full_name_hash() =3D %08x",
> -                                       i, j, hashlen_hash(hashlen), h0);
> -                               return -EINVAL;
> -                       }
> +                       KUNIT_EXPECT_EQ_MSG(test, hashlen_hash(hashlen), =
h0,
> +                                           "hashlen_string(%d..%d) =3D %=
08x !=3D full_name_hash() =3D %08x",
> +                                           i, j, hashlen_hash(hashlen), =
h0);
>
>                         h64 =3D h64 << 32 | h0;   /* For use with hash_64=
 */
> -                       if (!test_int_hash(h64, hash_or))
> -                               return -EINVAL;
> -                       tests++;
> +                       test_int_hash(test, h64, hash_or);
>                 } /* i */
>         } /* j */
>
> -       if (~hash_or[0][0]) {
> -               pr_err("OR of all __hash_32 results =3D %#x !=3D %#x",
> -                       hash_or[0][0], -1u);
> -               return -EINVAL;
> -       }
> +       KUNIT_EXPECT_FALSE_MSG(test, ~hash_or[0][0],

As above, maybe KUNIT_EXPECT_EQ_MSG() instead. (And ditto for all
similar checks against ~hash_or[...])?


> +                              "OR of all __hash_32 results =3D %#x !=3D =
%#x",
> +                              hash_or[0][0], -1u);
>  #ifdef HAVE_ARCH__HASH_32
>  #if HAVE_ARCH__HASH_32 !=3D 1    /* Test is pointless if results match *=
/
> -       if (~hash_or[1][0]) {
> -               pr_err("OR of all __hash_32_generic results =3D %#x !=3D =
%#x",
> -                       hash_or[1][0], -1u);
> -               return -EINVAL;
> -       }
> +       KUNIT_EXPECT_FALSE_MSG(test, ~hash_or[1][0],
> +                              "OR of all __hash_32_generic results =3D %=
#x !=3D %#x",
> +                              hash_or[1][0], -1u);
>  #endif
>  #endif
>
> @@ -241,65 +208,27 @@ static int __init test_hash_or(void)
>         for (i =3D 1; i <=3D 32; i++) {
>                 u32 const m =3D ((u32)2 << (i-1)) - 1;    /* Low i bits s=
et */
>
> -               if (hash_or[0][i] !=3D m) {
> -                       pr_err("OR of all hash_32(%d) results =3D %#x "
> -                               "(%#x expected)", i, hash_or[0][i], m);
> -                       return -EINVAL;
> -               }
> -               if (hash_or[1][i] !=3D m) {
> -                       pr_err("OR of all hash_64(%d) results =3D %#x "
> -                               "(%#x expected)", i, hash_or[1][i], m);
> -                       return -EINVAL;
> -               }
> +               KUNIT_EXPECT_EQ_MSG(test, hash_or[0][i], m,
> +                                   "OR of all hash_32(%d) results =3D %#=
x (%#x expected)",
> +                                   i, hash_or[0][i], m);
> +               KUNIT_EXPECT_EQ_MSG(test, hash_or[1][i], m,
> +                                   "OR of all hash_64(%d) results =3D %#=
x (%#x expected)",
> +                                   i, hash_or[1][i], m);
>         }
> -
> -       pr_notice("%u tests passed.", tests);
> -
> -       return 0;
> -}
> -
> -static void __init notice_skipped_tests(void)
> -{
> -       /* Issue notices about skipped tests. */
> -#ifdef HAVE_ARCH__HASH_32
> -#if HAVE_ARCH__HASH_32 !=3D 1
> -       pr_info("__hash_32() is arch-specific; not compared to generic.")=
;
> -#endif
> -#else
> -       pr_info("__hash_32() has no arch implementation to test.");
> -#endif
> -#ifdef HAVE_ARCH_HASH_64
> -#if HAVE_ARCH_HASH_64 !=3D 1
> -       pr_info("hash_64() is arch-specific; not compared to generic.");
> -#endif
> -#else
> -       pr_info("hash_64() has no arch implementation to test.");
> -#endif
>  }
>
> -static int __init
> -test_hash_init(void)
> -{
> -       int ret;
> -
> -       ret =3D test_string_or();
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D test_hash_or();
> -       if (ret < 0)
> -               return ret;
> -
> -       notice_skipped_tests();
> +static struct kunit_case hash_test_cases[] __refdata =3D {
> +       KUNIT_CASE(test_string_or),
> +       KUNIT_CASE(test_hash_or),
> +       {}
> +};
>
> -       return ret;
> -}
> +static struct kunit_suite hash_test_suite =3D {
> +       .name =3D "hash",
> +       .test_cases =3D hash_test_cases,
> +};
>
> -static void __exit test_hash_exit(void)
> -{
> -}
>
> -module_init(test_hash_init);   /* Does everything */
> -module_exit(test_hash_exit);   /* Does nothing */
> +kunit_test_suite(hash_test_suite);
>
>  MODULE_LICENSE("GPL");
> --
> 2.33.0
>
