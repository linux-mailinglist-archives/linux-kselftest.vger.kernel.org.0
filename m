Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5793AF761
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 23:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhFUVbk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 17:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhFUVbj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 17:31:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D18C061574
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jun 2021 14:29:23 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id a11so9852171ilf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jun 2021 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LreJURYo31mkkBRLLHPsvZ67AQbV4MMiMdNITLKAXuA=;
        b=AfxFt5rNw3d8BJSpV1/Mdklz1HKdRPQRNvCXp/SQqIhlfYilGev2tiUwaXQTTMNozv
         G8LCxhg2Dfn1EVoTbSBPb0CFB4CiqrbEkf0np9VCdyP8tsGdXtISrlP6ngJQ+5aRWqto
         TNHWm8iNhuwpr8jxrKbecYD7dCWT0XIAw4ULPL/piNhJoqcSAFzil4ZPvgpMjz9Y+fw2
         EPKj4cRBuSNFUu9LutYecquv5h0gG1k7ApPpNkuwO/v/2At2HxDSaXJGDI6aCAyRBvS7
         PWLvtikIj51I55YIdZEvS7HE70beKebcf70ftVMt0MqajD05N0oXSI0zcIPHShwvj1Bw
         v4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LreJURYo31mkkBRLLHPsvZ67AQbV4MMiMdNITLKAXuA=;
        b=IfbJ4G5/rGoO+7gdmKLLn86zYQqKaz3cEE826xpOh53VH7SngVgb8UHd4adVMxGwPw
         ZLlIKT0NrFcUJ4dM6tbOp8XDGqQGheJB2Tbp8NArhoSnx46EQdm6YEcr0znIMl62D33l
         Ii6iBT1QO75QBhzYzYwzsDicDeQ25geteW7ePnOkKWvK80gu7SLcvLQajIXdqCpvHEcT
         hDI6QSgnX6i2smVQ7wmCINwUFrenWHJIbxM6OfQSaqG19Lw7zyATTx6EgDeCnRYB73uJ
         FF87fQTGbAeU0ixN3AoarllZ9eOFWTOENGA5XE8sngXn18NErr2PNBlv1zLKXuV8RXeG
         7+Gw==
X-Gm-Message-State: AOAM530MhOPfjgBknL3BExfFBIHJk5+furGdZOGPBoWjT8tp91lFUJ4O
        vFFocUVP6OLEWzcHOFt8RsI6GOyJ0kaBKdeH0ZIMyg==
X-Google-Smtp-Source: ABdhPJwvlLKu294pssJ58/SiwnWhe9wZfMwxaxsLGNMixSUnAMX7SsJ6aiB4TrW6/uzG4zX/0cZ2IvWLLZGjAi9+2aY=
X-Received: by 2002:a05:6e02:1068:: with SMTP id q8mr203096ilj.194.1624310962728;
 Mon, 21 Jun 2021 14:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210621133148.9226-1-andrealmeid@collabora.com> <20210621133148.9226-2-andrealmeid@collabora.com>
In-Reply-To: <20210621133148.9226-2-andrealmeid@collabora.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 21 Jun 2021 14:29:11 -0700
Message-ID: <CAGS_qxoJ_+2EiRbssXuyiXrWuzzmC6-jsAd4qb_wJ4t0-Y+8bA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] lib: Convert UUID runtime test to KUnit
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        David Gow <davidgow@google.com>, tales.aparecida@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 21, 2021 at 6:32 AM Andr=C3=A9 Almeida <andrealmeid@collabora.c=
om> wrote:
>
> Remove custom functions for testing and use KUnit framework. Keep the
> tested functions and test data the same.
>
> Current test threat (g/u)uid_parse and (g/u)uid_equal as different test
> cases. Make both functions being part of the same test case, given the
> dependency regarding their results. This reduces the tests cases from 6
> cases to 4, while keeping the test coverage the same. Given that we have
> 3 strings for each test case, current test output notifies 18 tests
> results, and the KUnit output announces 12 results.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Looks good to me.

I haven't been keeping up, but this won't get picked up until KUnit
prints test statistics?
But even if that's the case or not, this patch would be fine as-is.
It'd be strictly an KUnit-internal thing to print test stats.

> ---
>  lib/Kconfig.debug |   8 ++-
>  lib/Makefile      |   2 +-
>  lib/test_uuid.c   | 137 +++++++++++++++++++---------------------------
>  3 files changed, 64 insertions(+), 83 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 678c13967580..606ec5e2586d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2188,8 +2188,12 @@ config TEST_BITMAP
>
>           If unsure, say N.
>
> -config TEST_UUID
> -       tristate "Test functions located in the uuid module at runtime"
> +config UUID_KUNIT_TEST
> +       tristate "Unit test for UUID" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Tests parsing functions for UUID/GUID strings.
>
>  config TEST_XARRAY
>         tristate "Test the XArray code at runtime"
> diff --git a/lib/Makefile b/lib/Makefile
> index 2cc359ec1fdd..cc19048961c0 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -85,7 +85,6 @@ obj-$(CONFIG_TEST_STATIC_KEYS) +=3D test_static_key_bas=
e.o
>  obj-$(CONFIG_TEST_PRINTF) +=3D test_printf.o
>  obj-$(CONFIG_TEST_BITMAP) +=3D test_bitmap.o
>  obj-$(CONFIG_TEST_STRSCPY) +=3D test_strscpy.o
> -obj-$(CONFIG_TEST_UUID) +=3D test_uuid.o
>  obj-$(CONFIG_TEST_XARRAY) +=3D test_xarray.o
>  obj-$(CONFIG_TEST_PARMAN) +=3D test_parman.o
>  obj-$(CONFIG_TEST_KMOD) +=3D test_kmod.o
> @@ -354,5 +353,6 @@ obj-$(CONFIG_LIST_KUNIT_TEST) +=3D list-test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) +=3D test_linear_ranges.o
>  obj-$(CONFIG_BITS_TEST) +=3D test_bits.o
>  obj-$(CONFIG_CMDLINE_KUNIT_TEST) +=3D cmdline_kunit.o
> +obj-$(CONFIG_UUID_KUNIT_TEST) +=3D test_uuid.o
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o
> diff --git a/lib/test_uuid.c b/lib/test_uuid.c
> index cd819c397dc7..30f350301e6d 100644
> --- a/lib/test_uuid.c
> +++ b/lib/test_uuid.c
> @@ -1,21 +1,20 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>  /*
> - * Test cases for lib/uuid.c module.
> + * Unit tests for lib/uuid.c module.
> + *
> + * Copyright 2016 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> + * Copyright 2021 Andr=C3=A9 Almeida <andrealmeid@riseup.net>
>   */
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/string.h>
> +#include <kunit/test.h>
>  #include <linux/uuid.h>
>
> -struct test_uuid_data {
> +struct test_data {
>         const char *uuid;
>         guid_t le;
>         uuid_t be;
>  };
>
> -static const struct test_uuid_data test_uuid_test_data[] =3D {
> +static const struct test_data correct_data[] =3D {
>         {
>                 .uuid =3D "c33f4995-3701-450e-9fbf-206a2e98e576",
>                 .le =3D GUID_INIT(0xc33f4995, 0x3701, 0x450e, 0x9f, 0xbf,=
 0x20, 0x6a, 0x2e, 0x98, 0xe5, 0x76),
> @@ -33,101 +32,79 @@ static const struct test_uuid_data test_uuid_test_da=
ta[] =3D {
>         },
>  };
>
> -static const char * const test_uuid_wrong_data[] =3D {
> +static const char * const wrong_data[] =3D {
>         "c33f4995-3701-450e-9fbf206a2e98e576 ", /* no hyphen(s) */
>         "64b4371c-77c1-48f9-8221-29f054XX023b", /* invalid character(s) *=
/
>         "0cb4ddff-a545-4401-9d06-688af53e",     /* not enough data */
>  };
>
> -static unsigned total_tests __initdata;
> -static unsigned failed_tests __initdata;
> -
> -static void __init test_uuid_failed(const char *prefix, bool wrong, bool=
 be,
> -                                   const char *data, const char *actual)
> +static void uuid_correct_le(struct kunit *test)
>  {
> -       pr_err("%s test #%u %s %s data: '%s'\n",
> -              prefix,
> -              total_tests,
> -              wrong ? "passed on wrong" : "failed on",
> -              be ? "BE" : "LE",
> -              data);
> -       if (actual && *actual)
> -               pr_err("%s test #%u actual data: '%s'\n",
> -                      prefix,
> -                      total_tests,
> -                      actual);
> -       failed_tests++;
> +       guid_t le;
> +       const struct test_data *data =3D test->param_value;
> +
> +       KUNIT_ASSERT_EQ_MSG(test, guid_parse(data->uuid, &le), 0,
> +                           "failed to parse '%s'", data->uuid);
> +       KUNIT_EXPECT_TRUE_MSG(test, guid_equal(&data->le, &le),
> +                             "'%s' should be equal to %pUl", data->uuid,=
 &le);
>  }
>
> -static void __init test_uuid_test(const struct test_uuid_data *data)
> +static void uuid_correct_be(struct kunit *test)
>  {
> -       guid_t le;
>         uuid_t be;
> -       char buf[48];
> -
> -       /* LE */
> -       total_tests++;
> -       if (guid_parse(data->uuid, &le))
> -               test_uuid_failed("conversion", false, false, data->uuid, =
NULL);
> -
> -       total_tests++;
> -       if (!guid_equal(&data->le, &le)) {
> -               sprintf(buf, "%pUl", &le);
> -               test_uuid_failed("cmp", false, false, data->uuid, buf);
> -       }
> -
> -       /* BE */
> -       total_tests++;
> -       if (uuid_parse(data->uuid, &be))
> -               test_uuid_failed("conversion", false, true, data->uuid, N=
ULL);
> -
> -       total_tests++;
> -       if (!uuid_equal(&data->be, &be)) {
> -               sprintf(buf, "%pUb", &be);
> -               test_uuid_failed("cmp", false, true, data->uuid, buf);
> -       }
> +       const struct test_data *data =3D test->param_value;
> +
> +       KUNIT_ASSERT_EQ_MSG(test, uuid_parse(data->uuid, &be), 0,
> +                           "failed to parse '%s'", data->uuid);
> +       KUNIT_EXPECT_TRUE_MSG(test, uuid_equal(&data->be, &be),
> +                             "'%s' should be equal to %pUl", data->uuid,=
 &be);
>  }
>
> -static void __init test_uuid_wrong(const char *data)
> +static void uuid_wrong_le(struct kunit *test)
>  {
>         guid_t le;
> -       uuid_t be;
> -
> -       /* LE */
> -       total_tests++;
> -       if (!guid_parse(data, &le))
> -               test_uuid_failed("negative", true, false, data, NULL);
> +       const char * const *data =3D test->param_value;
>
> -       /* BE */
> -       total_tests++;
> -       if (!uuid_parse(data, &be))
> -               test_uuid_failed("negative", true, true, data, NULL);
> +       KUNIT_ASSERT_NE_MSG(test, guid_parse(*data, &le), 0,
> +                           "parsing of '%s' should've failed", *data);
>  }
>
> -static int __init test_uuid_init(void)
> +static void uuid_wrong_be(struct kunit *test)
>  {
> -       unsigned int i;
> -
> -       for (i =3D 0; i < ARRAY_SIZE(test_uuid_test_data); i++)
> -               test_uuid_test(&test_uuid_test_data[i]);
> -
> -       for (i =3D 0; i < ARRAY_SIZE(test_uuid_wrong_data); i++)
> -               test_uuid_wrong(test_uuid_wrong_data[i]);
> +       uuid_t be;
> +       const char * const *data =3D test->param_value;
>
> -       if (failed_tests =3D=3D 0)
> -               pr_info("all %u tests passed\n", total_tests);
> -       else
> -               pr_err("failed %u out of %u tests\n", failed_tests, total=
_tests);
> +       KUNIT_ASSERT_NE_MSG(test, uuid_parse(*data, &be), 0,
> +                           "parsing of '%s' should've failed", *data);
> +}
>
> -       return failed_tests ? -EINVAL : 0;
> +static void case_to_desc_correct(const struct test_data *t, char *desc)
> +{
> +       strcpy(desc, t->uuid);
>  }
> -module_init(test_uuid_init);
>
> -static void __exit test_uuid_exit(void)
> +KUNIT_ARRAY_PARAM(correct, correct_data, case_to_desc_correct);
> +
> +static void case_to_desc_wrong(const char * const *s, char *desc)
>  {
> -       /* do nothing */
> +       strcpy(desc, *s);
>  }
> -module_exit(test_uuid_exit);
> +
> +KUNIT_ARRAY_PARAM(wrong, wrong_data, case_to_desc_wrong);
> +
> +static struct kunit_case uuid_test_cases[] =3D {
> +       KUNIT_CASE_PARAM(uuid_correct_be, correct_gen_params),
> +       KUNIT_CASE_PARAM(uuid_correct_le, correct_gen_params),
> +       KUNIT_CASE_PARAM(uuid_wrong_be, wrong_gen_params),
> +       KUNIT_CASE_PARAM(uuid_wrong_le, wrong_gen_params),
> +       {}
> +};
> +
> +static struct kunit_suite uuid_test_suite =3D {
> +       .name =3D "uuid",
> +       .test_cases =3D uuid_test_cases,
> +};
> +kunit_test_suite(uuid_test_suite);
>
>  MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
>  MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.32.0
>
