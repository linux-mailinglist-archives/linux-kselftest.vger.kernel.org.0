Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDED3F81BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 06:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhHZE1m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 00:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhHZE1l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 00:27:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1CC0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 21:26:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q14so2819924wrp.3
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 21:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N4lJ8QMbfg7GkcPRcPmDTwgEwk429EDYI8YSDC4YcwM=;
        b=XOeB0HPUw0dpBG3AvA8HoIDun43Qjhf8K1KRu2rrydo5zriIvLWz/QohNsFUzyceD1
         47zYt26ZtZHRKIZS0yOFIQFxUtGqLNqt/8P2eRJiK6qIMypzC92AvbRrGATMKBBNhH3x
         cvTPTx4HXg5eItqVI2lXXxfovmheVBO7eSI7GKwj4S5DEB1VG9Xpyxjh2tvLVjXhy4Y2
         XKxQLCTZTqrbfTkkqm9HB90/BfAFAtGNk666cTmheJqOqQK6qAAUJIlpP+BY0XmM/ov5
         +UA/C5dobQgSXqnJSxJluS8PeTC04OWTctK0GtAvsQgp496ardXziiw1BronnzJaTPMj
         9oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N4lJ8QMbfg7GkcPRcPmDTwgEwk429EDYI8YSDC4YcwM=;
        b=sDKtpDAmTLcOOBc7Y5eDMk9JTszBMeLcmEe3FZu4FQOf2ZGnnJiOPHYMSZCR/P9I0O
         UYWy8jCNOwq2AgUewk4Jn642k+i4s6Tt+YeL+pRTvFiZzrIuAu9JAl9Nuaz6UdTdsyEA
         toOFPINEm4krRmFtMZWJ+YbWoKlZUTi5UHRkF+Rdi3hdwRmKVfkmZ4UbvymwPwqOh2KS
         YYRW7NDZa6o5hQ+CGQuf8ithPS6cnkiufJPsuj0EvyVwsPN1JvPFQTQUNH+w2G531nMU
         arAYXFMqveuTjzI4Njyl3UdEpY6OyI1Bc3iZUxZrPbcFtiNWSw8atQ33sY1aQKR0Ovyr
         zhSA==
X-Gm-Message-State: AOAM531e2NRuSGZ+A6KJBF+jckMjOD2ifRYoWKbll6mESLhXPglt9ZTf
        lxMQY8k1edeQswGMkQFKYgiRFt2nwTcWv4XNyWCrkg==
X-Google-Smtp-Source: ABdhPJyGY6T0Q9TPPMPO6Wrl80VzUoRNRcEaXbX/bIM8fVqYiLYnIE+8nqi1FsN46fgTmlypkoZG8pogJ07UquPvRAU=
X-Received: by 2002:adf:f08b:: with SMTP id n11mr1403480wro.176.1629952013296;
 Wed, 25 Aug 2021 21:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br> <20210826012626.1163705-7-isabellabdoamaral@usp.br>
In-Reply-To: <20210826012626.1163705-7-isabellabdoamaral@usp.br>
From:   David Gow <davidgow@google.com>
Date:   Thu, 26 Aug 2021 12:26:42 +0800
Message-ID: <CABVgOSkHkN8Rx+JKN3W89oECAYuoiyVndvhGcOQswDbo9RXQ8w@mail.gmail.com>
Subject: Re: [PATCH 6/6] test_hash.c: refactor into kunit
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     linux@sciencehorizons.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 26, 2021 at 9:26 AM Isabella Basso <isabellabdoamaral@usp.br> w=
rote:
>
> Use KUnit framework to make tests more easily integrable with CIs. Even
> though these tests are not yet properly written as unit tests this
> change should help in debugging.

Thanks -- I think KUnit is a good fit for these tests. I've tested the
series, and it works well for me (but again, I'm no expert on the
hashing code).

I've left a few comments below, but there's nothing major which seems
to actually break the test, so this series is nevertheless:

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David

>
> Also drop module support and remove kernel messages (i.e. through
> pr_info) as KUnit handles all debugging output.

To clarify, are you actually dropping support for building this as a
module, or just letting KUnit handle it for you? Ideally, this will
still work as a module, even if it also works as a built-in test.
(Given that the Kconfig entry still is 'tristate', I assume this is the cas=
e.)

>
> Co-developed-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.com>
> Signed-off-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.com>
> Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> ---
>  lib/Kconfig.debug |  28 ++++---
>  lib/Makefile      |   2 +-
>  lib/test_hash.c   | 197 ++++++++++++++--------------------------------
>  3 files changed, 79 insertions(+), 148 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5e5894d98c50..adefb03a7e16 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2221,15 +2221,6 @@ config TEST_RHASHTABLE
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
> @@ -2378,6 +2369,25 @@ config BITFIELD_KUNIT
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
> index c168823b0963..84590bbf47dc 100644
> --- a/lib/test_hash.c
> +++ b/lib/test_hash.c
> @@ -14,14 +14,10 @@
>   * and hash_64().
>   */
>
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt "\n"
> -
> -#include <linux/compiler.h>
>  #include <linux/types.h>
> -#include <linux/module.h>
>  #include <linux/hash.h>
>  #include <linux/stringhash.h>
> -#include <linux/printk.h>
> +#include <kunit/test.h>
>
>  #define SIZE 256 /* Run time is cubic in SIZE */
>
> @@ -29,7 +25,7 @@ static u32 string_or; /* stores or-ed string output */
>  static u32 hash_or[2][33] =3D { { 0, } }; /* stores or-ed hash output */
>
>  /* 32-bit XORSHIFT generator.  Seed must not be zero. */
> -static u32 __init __attribute_const__
> +static u32 __attribute_const__
>  xorshift(u32 seed)
>  {
>         seed ^=3D seed << 13;
> @@ -39,7 +35,7 @@ xorshift(u32 seed)
>  }
>
>  /* Given a non-zero x, returns a non-zero byte. */
> -static u8 __init __attribute_const__
> +static u8 __attribute_const__
>  mod255(u32 x)
>  {
>         x =3D (x & 0xffff) + (x >> 16);   /* 1 <=3D x <=3D 0x1fffe */
> @@ -50,8 +46,7 @@ mod255(u32 x)
>  }
>
>  /* Fill the buffer with non-zero bytes. */
> -static void __init
> -fill_buf(char *buf, size_t len, u32 seed)
> +static void fill_buf(char *buf, size_t len, u32 seed)
>  {
>         size_t i;
>
> @@ -62,41 +57,31 @@ fill_buf(char *buf, size_t len, u32 seed)
>  }
>
>  #ifdef HAVE_ARCH__HASH_32
> -static bool __init
> -test_int_hash32(u32 *h0, u32 *h1, u32 *h2)
> +static bool test_int_hash32(struct kunit *test, u32 *h0, u32 *h1, u32 *h=
2)
>  {
>         hash_or[1][0] |=3D *h2 =3D __hash_32_generic(h0);
>  #if HAVE_ARCH__HASH_32 =3D=3D 1
> -       if (*h1 !=3D *h2) {
> -               pr_err("__hash_32(%#x) =3D %#x !=3D __hash_32_generic() =
=3D %#x",
> -                      *h0, *h1, *h2);
> -               return false;
> -       }
> +       KUNIT_ASSERT_EQ_MSG(test, *h1, *h2,
> +                           "__hash_32(%#x) =3D %#x !=3D __hash_32_generi=
c() =3D %#x",
> +                           *h0, *h1, *h2);

Should this (and others) be EXPECTations rather than ASSERTions? I
imagine we'd want to continue the test even if this doesn't match.

(I know that the existing function returns early here, but I'd argue
that __hash_32() and __hash_32_generic() producing different results
is a separate issue than the final ORed result turning out
differently, and we shouldn't change the latter by exiting out early
from the former. Equally, there's probably an argument for splitting
out the __hash_32() vs __hash_32_generic() tests completely from the
_or tests, but that would be more work.)

>  #endif
> -       return true;
>  }
>  #endif
>
>  #ifdef HAVE_ARCH_HASH_64
> -static bool __init
> -test_int_hash64(unsigned long long h64, u32 *h0, u32 *h1, u32 *h2, u32 c=
onst *m, int k)
> +static bool test_int_hash64(struct kunit *test, unsigned long long h64, =
u32 *h0, u32 *h1,
> +               u32 *h2, u32 const *m, int k)
>  {
>         *h2 =3D hash_64_generic(*h64, *k);
>  #if HAVE_ARCH_HASH_64 =3D=3D 1
> -       if (*h1 !=3D *h2) {
> -               pr_err("hash_64(%#llx, %d) =3D %#x !=3D hash_64_generic()=
 =3D %#x",
> -                      *h64, *k, *h1, *h2);
> -               return false;
> -       }
> +       KUNIT_ASSERT_EQ_MSG(test, *h1, *h2,
> +                           "hash_64(%#llx, %d) =3D %#x !=3D hash_64_gene=
ric() =3D %#x",
> +                           *h64, *k, *h1, *h2);
>  #else
> -       if (*h2 > *m) {
> -               pr_err("hash_64_generic(%#llx, %d) =3D %#x > %#x",
> -                      *h64, *k, *h1, *m);
> -               return false;
> -       }
> +       KUNIT_ASSERT_LE_MSG(test, *h1, *h2,
> +                           "hash_64_generic(%#llx, %d) =3D %#x > %#x",
> +                           *h64, *k, *h1, *m);
>  #endif
> -       return true;
> -
>  }
>  #endif
>
> @@ -109,8 +94,7 @@ test_int_hash64(unsigned long long h64, u32 *h0, u32 *=
h1, u32 *h2, u32 const *m,
>   * inline, the code being tested is actually in the module, and you can
>   * recompile and re-test the module without rebooting.
>   */
> -static bool __init
> -test_int_hash(unsigned long long h64)
> +static void test_int_hash(struct kunit *test, unsigned long long h64)
>  {
>         int k;
>         u32 h0 =3D (u32)h64, h1;
> @@ -122,7 +106,7 @@ test_int_hash(unsigned long long h64)
>         /* Test __hash32 */
>         hash_or[0][0] |=3D h1 =3D __hash_32(h0);
>  #ifdef HAVE_ARCH__HASH_32
> -       if (!test_int_hash32(&h0, &h1, &h2))
> +       if (!test_int_hash32(test, &h0, &h1, &h2))
>                 return false;
>  #endif
>
> @@ -132,27 +116,22 @@ test_int_hash(unsigned long long h64)
>
>                 /* Test hash_32 */
>                 hash_or[0][k] |=3D h1 =3D hash_32(h0, k);
> -               if (h1 > m) {
> -                       pr_err("hash_32(%#x, %d) =3D %#x > %#x", h0, k, h=
1, m);
> -                       return false;
> -               }
> +               KUNIT_ASSERT_LE_MSG(test, h1, m,
> +                                   "hash_32(%#x, %d) =3D %#x > %#x",
> +                                   h0, k, h1, m);
>
>                 /* Test hash_64 */
>                 hash_or[1][k] |=3D h1 =3D hash_64(h64, k);
> -               if (h1 > m) {
> -                       pr_err("hash_64(%#llx, %d) =3D %#x > %#x", h64, k=
, h1, m);
> -                       return false;
> -               }
> +               KUNIT_ASSERT_LE_MSG(test, h1, m,
> +                                   "hash_64(%#llx, %d) =3D %#x > %#x",
> +                                   h64, k, h1, m);
>  #ifdef HAVE_ARCH_HASH_64
> -               if (!test_int_hash64(&h64, &h0, &h1, &h2, &m, &k))
> -                       return false;
> +               test_int_hash64(test, &h64, &h0, &h1, &h2, &m, &k);
>  #endif
>         }
> -
> -       return true;
>  }
>
> -static int __init test_string_or(void)
> +static void test_string_or(struct kunit *test)
>  {
>         char buf[SIZE+1];
>         int i, j;
> @@ -173,19 +152,14 @@ static int __init test_string_or(void)
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
> +       KUNIT_ASSERT_FALSE_MSG(test, ~string_or,
> +                             "OR of all string hash results =3D %#x !=3D=
 %#x",
> +                             string_or, -1u);
>  }
>
> -static int __init test_hash_or(void)
> +static void test_hash_or(struct kunit *test)
>  {
>         char buf[SIZE+1];
> -       unsigned tests =3D 0;
>         unsigned long long h64 =3D 0;
>         int i, j;
>
> @@ -201,39 +175,27 @@ static int __init test_hash_or(void)
>                         u32 h0 =3D full_name_hash(buf+i, buf+i, j-i);
>
>                         /* Check that hashlen_string gets the length righ=
t */
> -                       if (hashlen_len(hashlen) !=3D j-i) {
> -                               pr_err("hashlen_string(%d..%d) returned l=
ength"
> -                                      " %u, expected %d",
> -                                      i, j, hashlen_len(hashlen), j-i);
> -                               return -EINVAL;
> -                       }
> +                       KUNIT_ASSERT_EQ_MSG(test, hashlen_len(hashlen), j=
-i,
> +                                           "hashlen_string(%d..%d) retur=
ned length %u, expected %d",
> +                                           i, j, hashlen_len(hashlen), j=
-i);
>                         /* Check that the hashes match */
> -                       if (hashlen_hash(hashlen) !=3D h0) {
> -                               pr_err("hashlen_string(%d..%d) =3D %08x !=
=3D "
> -                                      "full_name_hash() =3D %08x",
> -                                      i, j, hashlen_hash(hashlen), h0);
> -                               return -EINVAL;
> -                       }
> +                       KUNIT_ASSERT_EQ_MSG(test, hashlen_hash(hashlen), =
h0,
> +                                           "hashlen_string(%d..%d) =3D %=
08x !=3D full_name_hash() =3D %08x",
> +                                           i, j, hashlen_hash(hashlen), =
h0);
>
>                         h64 =3D h64 << 32 | h0;   /* For use with hash_64=
 */
> -                       if (!test_int_hash(h64))
> -                               return -EINVAL;
> -                       tests++;
> +                       test_int_hash(test, h64);
>                 } /* i */
>         } /* j */
>
> -       if (~hash_or[0][0]) {
> -               pr_err("OR of all __hash_32 results =3D %#x !=3D %#x",
> -                      hash_or[0][0], -1u);
> -               return -EINVAL;
> -       }
> +       KUNIT_ASSERT_FALSE_MSG(test, ~hash_or[0][0],
> +                              "OR of all __hash_32 results =3D %#x !=3D =
%#x",
> +                              hash_or[0][0], -1u);
>  #ifdef HAVE_ARCH__HASH_32
>  #if HAVE_ARCH__HASH_32 !=3D 1    /* Test is pointless if results match *=
/
> -       if (~hash_or[1][0]) {
> -               pr_err("OR of all __hash_32_generic results =3D %#x !=3D =
%#x",
> -                      hash_or[1][0], -1u);
> -               return -EINVAL;
> -       }
> +       KUNIT_ASSERT_FALSE_MSG(test, ~hash_or[1][0],
> +                              "OR of all __hash_32_generic results =3D %=
#x !=3D %#x",
> +                              hash_or[1][0], -1u);
>  #endif
>  #endif
>
> @@ -241,65 +203,24 @@ static int __init test_hash_or(void)
>         for (i =3D 1; i <=3D 32; i++) {
>                 u32 const m =3D ((u32)2 << (i-1)) - 1;    /* Low i bits s=
et */
>
> -               if (hash_or[0][i] !=3D m) {
> -                       pr_err("OR of all hash_32(%d) results =3D %#x "
> -                              "(%#x expected)", i, hash_or[0][i], m);
> -                       return -EINVAL;
> -               }
> -               if (hash_or[1][i] !=3D m) {
> -                       pr_err("OR of all hash_64(%d) results =3D %#x "
> -                              "(%#x expected)", i, hash_or[1][i], m);
> -                       return -EINVAL;
> -               }
> +               KUNIT_ASSERT_EQ_MSG(test, hash_or[0][i], m,
> +                                   "OR of all hash_32(%d) results =3D %#=
x (%#x expected)",
> +                                   i, hash_or[0][i], m);
> +               KUNIT_ASSERT_EQ_MSG(test, hash_or[1][i], m,
> +                                   "OR of all hash_64(%d) results =3D %#=
x (%#x expected)",
> +                                   i, hash_or[1][i], m);
>         }
> -
> -       pr_notice("%u tests passed.", tests);
> -
> -       return 0;
>  }
>
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
> -}
> -
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
> -
> -       return ret;
> -}
> -
> -static void __exit test_hash_exit(void)
> -{
> -}
> +static struct kunit_case hash_test_cases[] =3D {
> +       KUNIT_CASE(test_string_or),
> +       KUNIT_CASE(test_hash_or),

Ideally, these could be split up further into separate __hash_32(),
hash_32(), and hash_64() tests. Maybe even with separate tests for
architecture-specific versus generic implementations as mentioned
above, if that made sense. It'd require enough reworking of the tests
and expected results though, that I wouldn't necessarily want to force
such a significant change at the same time as this more
straightforward port to KUnit.

> +       {}
> +};
>
> -module_init(test_hash_init);   /* Does everything */
> -module_exit(test_hash_exit);   /* Does nothing */
> +static struct kunit_suite hash_test_suite =3D {
> +       .name =3D "hash_tests",

It might be worth just naming this "hash", as the fact that it's a
KUnit suite already tells us it contains tests.

> +       .test_cases =3D hash_test_cases,
> +};
>
> -MODULE_LICENSE("GPL");

It's probably worth keeping this in as it's still GPLed, and can be
built as a module.

> +kunit_test_suite(hash_test_suite);


> --
> 2.33.0
>
