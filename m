Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C60517D36
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 08:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiECGRb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 02:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiECGR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 02:17:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD75B36156
        for <linux-kselftest@vger.kernel.org>; Mon,  2 May 2022 23:13:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c11so12150906wrn.8
        for <linux-kselftest@vger.kernel.org>; Mon, 02 May 2022 23:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ogvWq0aM7sAazL6ew3cO18SpuyvR04xEm09T1ox3YMU=;
        b=SJO2VdrMBSeWKZE2pBv2gl9zInHlUcf144i0QvW9AQZoTpZoPgbAwxnK1ldoznLUPA
         Wv5raOkMn4tXhjeofQa2TsBU/bT0fV16EKcjI47Ue7Q1z9JfgrKaSG4h9epST6/ztWzT
         BbF9fsZvtjzjKlP3V1wfVgkpmcfyi6h2ibDrypRIeMcLAorXEY3FSr98DLSSQWpS8L8q
         Sjz8i8FNkhKoyqLygref7c+STnTmw3F0IKgkkPIBjgY3m2hvWip9D0yLubomVo12FUFd
         syVIPWhQuZ6RqNczcwfjy3Oyoz0G8c8+4KciEXj/AHdcQCSI+CDlefFzmpbIWO9wxAal
         8rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ogvWq0aM7sAazL6ew3cO18SpuyvR04xEm09T1ox3YMU=;
        b=AqWY4BMcaAlrrHPNffMhvK5tETZ1XiGmldLZaqD/eh0AlBathYB/EEb/Di5MElxD2F
         nsWx0IhHGJkLWEEQFNiQOx86FHAxYesWI/HMgX2c5y20ExAZnfsg4C5rpA2Kf4Ux8Mqm
         hfZZ/+44HBQWbXBvVhyUQcD/RU7MflBZWs+iBNv8bSAGRSqfafAPymQjJY7Dbjcf1gZa
         BZnucW74jk5ANs7kKA0vheQcdbvz2oqS18qI8IDAVcj0mQ6I4bbhgOdeDl1P7j97oEYZ
         KpPpJkwGC6pLpogOdVQKB18/7V9a5iwANuLTmkYcEdQF88RUY3WdbbuL+7Hw3BArDxJy
         rp2g==
X-Gm-Message-State: AOAM533oWaE+nOP6Gk9c04SvJ/7+QiUY+Htsc7Wtyj5LBVDHBdl8AbME
        gnq1lOAgk7bC5PYSjtf1S1GNp2KDoaetmPkawHabKg==
X-Google-Smtp-Source: ABdhPJy3afWlFcxptAQs6X+ThgspNJrrTOKb1Kj8r+jQ3vT0YFao60dOTwUSCJlsW6BoKdfsHLgZ6kEjzfVSllAkvlI=
X-Received: by 2002:a5d:4806:0:b0:20a:da03:711b with SMTP id
 l6-20020a5d4806000000b0020ada03711bmr11133467wrq.395.1651558433216; Mon, 02
 May 2022 23:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220502192327.81153-1-dlatypov@google.com>
In-Reply-To: <20220502192327.81153-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 3 May 2022 14:13:41 +0800
Message-ID: <CABVgOS=kQpJbZR1DY3=dpcWvasUzDjCNx07t6bDdkWKmxhpQnQ@mail.gmail.com>
Subject: Re: [PATCH] lib/atomic64_test.c: convert to use KUnit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 3, 2022 at 3:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The test currently is a bunch of checks (implemented using BUG_ON())
> that can be built into the kernel or as a module.
>
> Convert it to a KUnit test, which can also run in both modes.
> From a user's perspective, this change adds a CONFIG_KUNIT=3Dy dep and
> changes the output format of the test [1]. The test itself is the same.
>
> This hopefully makes the test easier to run and more consistent with
> similar tests in lib/.
> Since it has no dependencies, it can be run without explicitly setting
> up a .kunitconfig via
> $ ./tools/testing/kunit/kunit.py run atomic
> ...
> [13:53:44] Starting KUnit Kernel (1/1)...
> [13:53:44] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [13:53:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D atom=
ic (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> [13:53:47] [PASSED] test_atomic
> [13:53:47] [PASSED] test_atomic64
> [13:53:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D [PASSED] atomic =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [13:53:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [13:53:47] Testing complete. Passed: 2, Failed: 0, Crashed: 0, Skipped: 0=
, Errors: 0
> [13:53:47] Elapsed time: 13.902s total, 1.629s configuring, 9.331s buildi=
ng, 2.852s running
>
> It can be run on ARCH=3Dx86_64 (and others) via:
> $ ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 atomic
>
> The message about which platform the test ran on won't show up in
> kunit.py, but still gets printed out in dmesg, e.g.
> > TAP version 14
> > 1..1
> >     # Subtest: atomic
> >     1..2
> >     ok 1 - test_atomic
> >     ok 2 - test_atomic64
> >     # atomic: ran on x86-64 platform with CX8 and with SSE
> > # atomic: pass:2 fail:0 skip:0 total:2
> > # Totals: pass:2 fail:0 skip:0 total:2
> > ok 1 - atomic
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> [1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
> ---

This looks good to me. It's nice to see these tests being standardised.

> Meta:
> 1. this patch applies on top of the kunit branch,
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git=
/?h=3Dkunit

(To anyone else trying it: make sure you update this first, as the
prerequisites only just landed.)

> 2. checkpatch complains about aligning with parens, but it wants me to
> indent the `#ifdef CONFIG_X86_64` which seems inappropriate in context.

Huh... checkpatch isn't showing any such warning on my system.

> 3. this file doesn't seem to have a clear maintainer, so I assume this
> conversion is fine to go through the kunit branch. The only observable
> differences are the new CONFIG_KUNIT=3Dy dep and more standardized (KTAP)
> output format.
> ---

I'm happy to vouch for this not breaking anything, even though I'm
definitely not an expert on the atomics code.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  lib/Kconfig.debug   |   4 +-
>  lib/atomic64_test.c | 107 +++++++++++++++++++++-----------------------
>  2 files changed, 55 insertions(+), 56 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 075cd25363ac..4cf8d5feda0a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2223,7 +2223,9 @@ config PERCPU_TEST
>           If unsure, say N.
>
>  config ATOMIC64_SELFTEST
> -       tristate "Perform an atomic64_t self-test"
> +       tristate "Perform an atomic64_t self-test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
>         help
>           Enable this option to test the atomic64_t functions at boot or
>           at module load time.
> diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
> index d9d170238165..46cb0130f8d0 100644
> --- a/lib/atomic64_test.c
> +++ b/lib/atomic64_test.c
> @@ -5,13 +5,9 @@
>   * Copyright =C2=A9 2010  Luca Barbieri
>   */
>
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <kunit/test.h>
>
> -#include <linux/init.h>
> -#include <linux/bug.h>
> -#include <linux/kernel.h>
>  #include <linux/atomic.h>
> -#include <linux/module.h>
>
>  #ifdef CONFIG_X86
>  #include <asm/cpufeature.h>    /* for boot_cpu_has below */
> @@ -23,9 +19,7 @@ do {                                                   =
       \
>         r =3D v0;                                                 \
>         atomic##bit##_##op(val, &v);                            \
>         r c_op val;                                             \
> -       WARN(atomic##bit##_read(&v) !=3D r, "%Lx !=3D %Lx\n",       \
> -               (unsigned long long)atomic##bit##_read(&v),     \
> -               (unsigned long long)r);                         \
> +       KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), r);       \
>  } while (0)
>
>  /*
> @@ -46,8 +40,8 @@ do {                                                   =
       \
>         atomic##bit##_set(&v, v0);                              \
>         r =3D v0;                                                 \
>         r c_op val;                                             \
> -       BUG_ON(atomic##bit##_##op(val, &v) !=3D r);               \
> -       BUG_ON(atomic##bit##_read(&v) !=3D r);                    \
> +       KUNIT_ASSERT_EQ(test, atomic##bit##_##op(val, &v), r);  \
> +       KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), r);       \
>  } while (0)
>
>  #define TEST_FETCH(bit, op, c_op, val)                         \
> @@ -55,8 +49,8 @@ do {                                                   =
       \
>         atomic##bit##_set(&v, v0);                              \
>         r =3D v0;                                                 \
>         r c_op val;                                             \
> -       BUG_ON(atomic##bit##_##op(val, &v) !=3D v0);              \
> -       BUG_ON(atomic##bit##_read(&v) !=3D r);                    \
> +       KUNIT_ASSERT_EQ(test, atomic##bit##_##op(val, &v), v0); \
> +       KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), r);       \
>  } while (0)
>
>  #define RETURN_FAMILY_TEST(bit, op, c_op, val)                 \
> @@ -72,8 +66,8 @@ do {                                                   =
       \
>  #define TEST_ARGS(bit, op, init, ret, expect, args...)         \
>  do {                                                           \
>         atomic##bit##_set(&v, init);                            \
> -       BUG_ON(atomic##bit##_##op(&v, ##args) !=3D ret);          \
> -       BUG_ON(atomic##bit##_read(&v) !=3D expect);               \
> +       KUNIT_ASSERT_EQ(test, atomic##bit##_##op(&v, ##args), ret);\
> +       KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), expect);  \
>  } while (0)
>
>  #define XCHG_FAMILY_TEST(bit, init, new)                               \
> @@ -101,7 +95,7 @@ do {                                                 \
>                         i, (i) - one, (i) - one);       \
>  } while (0)
>
> -static __init void test_atomic(void)
> +static void test_atomic(struct kunit *test)
>  {
>         int v0 =3D 0xaaa31337;
>         int v1 =3D 0xdeadbeef;
> @@ -144,7 +138,7 @@ static __init void test_atomic(void)
>  }
>
>  #define INIT(c) do { atomic64_set(&v, c); r =3D c; } while (0)
> -static __init void test_atomic64(void)
> +static void test_atomic64(struct kunit *test)
>  {
>         long long v0 =3D 0xaaa31337c001d00dLL;
>         long long v1 =3D 0xdeadbeefdeafcafeLL;
> @@ -156,12 +150,12 @@ static __init void test_atomic64(void)
>
>         atomic64_t v =3D ATOMIC64_INIT(v0);
>         long long r =3D v0;
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         atomic64_set(&v, v1);
>         r =3D v1;
> -       BUG_ON(v.counter !=3D r);
> -       BUG_ON(atomic64_read(&v) !=3D r);
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
> +       KUNIT_ASSERT_EQ(test, atomic64_read(&v), r);
>
>         TEST(64, add, +=3D, onestwos);
>         TEST(64, add, +=3D, -one);
> @@ -190,12 +184,12 @@ static __init void test_atomic64(void)
>         INIT(v0);
>         atomic64_inc(&v);
>         r +=3D one;
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         INIT(v0);
>         atomic64_dec(&v);
>         r -=3D one;
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         INC_RETURN_FAMILY_TEST(64, v0);
>         DEC_RETURN_FAMILY_TEST(64, v0);
> @@ -204,73 +198,76 @@ static __init void test_atomic64(void)
>         CMPXCHG_FAMILY_TEST(64, v0, v1, v2);
>
>         INIT(v0);
> -       BUG_ON(atomic64_add_unless(&v, one, v0));
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_FALSE(test, atomic64_add_unless(&v, one, v0));
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         INIT(v0);
> -       BUG_ON(!atomic64_add_unless(&v, one, v1));
> +       KUNIT_ASSERT_TRUE(test, atomic64_add_unless(&v, one, v1));
>         r +=3D one;
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         INIT(onestwos);
> -       BUG_ON(atomic64_dec_if_positive(&v) !=3D (onestwos - 1));
> +       KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), (onestwos - 1=
));
>         r -=3D one;
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         INIT(0);
> -       BUG_ON(atomic64_dec_if_positive(&v) !=3D -one);
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), -one);
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         INIT(-one);
> -       BUG_ON(atomic64_dec_if_positive(&v) !=3D (-one - one));
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), (-one - one))=
;
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         INIT(onestwos);
> -       BUG_ON(!atomic64_inc_not_zero(&v));
> +       KUNIT_ASSERT_TRUE(test, atomic64_inc_not_zero(&v));
>         r +=3D one;
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         INIT(0);
> -       BUG_ON(atomic64_inc_not_zero(&v));
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_FALSE(test, atomic64_inc_not_zero(&v));
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         INIT(-one);
> -       BUG_ON(!atomic64_inc_not_zero(&v));
> +       KUNIT_ASSERT_TRUE(test, atomic64_inc_not_zero(&v));
>         r +=3D one;
> -       BUG_ON(v.counter !=3D r);
> +       KUNIT_ASSERT_EQ(test, v.counter, r);
>
>         /* Confirm the return value fits in an int, even if the value doe=
sn't */
>         INIT(v3);
> +
>         r_int =3D atomic64_inc_not_zero(&v);
> -       BUG_ON(!r_int);
> +       KUNIT_ASSERT_NE(test, r_int, 0);
>  }
>
> -static __init int test_atomics_init(void)
> -{
> -       test_atomic();
> -       test_atomic64();
> +static struct kunit_case atomic_test_cases[] =3D {
> +       KUNIT_CASE(test_atomic),
> +       KUNIT_CASE(test_atomic64),
> +       {},
> +};
>
> +static void atomic_suite_exit(struct kunit_suite *suite)
> +{
>  #ifdef CONFIG_X86
> -       pr_info("passed for %s platform %s CX8 and %s SSE\n",
> +       kunit_info(suite, "ran on %s platform %s CX8 and %s SSE\n",
>  #ifdef CONFIG_X86_64
> -               "x86-64",
> +                  "x86-64",
>  #elif defined(CONFIG_X86_CMPXCHG64)
> -               "i586+",
> +                  "i586+",
>  #else
> -               "i386+",
> +                  "i386+",
>  #endif
> -              boot_cpu_has(X86_FEATURE_CX8) ? "with" : "without",
> -              boot_cpu_has(X86_FEATURE_XMM) ? "with" : "without");
> -#else
> -       pr_info("passed\n");
> +                  boot_cpu_has(X86_FEATURE_CX8) ? "with" : "without",
> +                  boot_cpu_has(X86_FEATURE_XMM) ? "with" : "without");
>  #endif
> -
> -       return 0;
>  }
>
> -static __exit void test_atomics_exit(void) {}
> +static struct kunit_suite atomic_test_suite =3D {
> +       .name =3D "atomic",
> +       .test_cases =3D atomic_test_cases,
> +       .suite_exit =3D atomic_suite_exit,
> +};
>
> -module_init(test_atomics_init);
> -module_exit(test_atomics_exit);
> +kunit_test_suites(&atomic_test_suite);
>
>  MODULE_LICENSE("GPL");
>
> base-commit: 38289a26e1b8a37755f3e07056ca416c1ee2a2e8
> --
> 2.36.0.464.gb9c8b46e94-goog
>
