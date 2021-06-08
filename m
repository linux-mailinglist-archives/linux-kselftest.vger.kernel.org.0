Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8737939EB2E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 03:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhFHBFY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Jun 2021 21:05:24 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:39581 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhFHBFX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Jun 2021 21:05:23 -0400
Received: by mail-lj1-f173.google.com with SMTP id c11so24687387ljd.6
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Jun 2021 18:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5//JaUfOBX14+dgOWBv13EyWt9MqvlvNFYYREoGDBIk=;
        b=MPc+PvrCmdlzhm+SAZu/oyMk07hbqpRZTLDa28l8bngJbe7aWhTF0XwYsdVl8Vm8pO
         Z7dIWhZcuJz7uoK6p3KdtDgHy3khmfDGqUsZ65XDV1bh02D6PQBlC/t+t4kU07ERUAZr
         0xpJLGOt0grVrVbyo19CzZLwswonoBoDCaYV+Y/ghc/ijTpEeyTTlzt96hh2PBzJXs/6
         dkJiI+AzvBiEeY2WnehvcuLAMR9lk2hzRyScMf2uhZ2GXuctBCscoZTNDBcKD5eg/XjU
         HCo6qJNLnF2xHfQLAojA3XWaqlqm2ze/b4sLyGRu2furjpXaT7ARRPuCasU2ZZSPQA/S
         52bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5//JaUfOBX14+dgOWBv13EyWt9MqvlvNFYYREoGDBIk=;
        b=H+cCoG6jSabjn8Fc94ORLUWu1ETrITgIqL7OHiYXAVbwPA52Lgv9hui1ARSorGxn7V
         7gu7oKbVY92oWCT+4WlqIiMjsOeeP7/6rUpFXtwroXOv29oeyMTzhepoIt8ByKn/oxOC
         X7Z5eqB52fGEZTYsmXm8snu/xroubYjAxEkA4CHYNmx8Ql5YV5b1NnAiIRJzbG7tWlI8
         uWW9y7G0Gdxav5GuZfMl/SdT/wt1XdUh05ePiwCSTg6eWPC1Y+eniR4LVcNlDjmPhR8s
         +UOlr8ugmILqDTpY8Y/T77GuZ8QFKQECbjs6iCVW/ZJRs8CCjFtzbbOihC6Bf4BegZBO
         08lg==
X-Gm-Message-State: AOAM532+cSQafVDqxzZw31u0aec4YpNUQRXceG2dc/WZSNfkSTjpMzXD
        6zd/lSioWTGRyFFxILpWedMHAEslOUx51cAIB/Irnw==
X-Google-Smtp-Source: ABdhPJwtAnVFUfmlRsI5GZAF/YZeE0NxPIIDqWwmyw5vqjnlHPZ0IgJR4g0KPh7f/sZR67V8zlRsiN/ztcR8O/uLbbM=
X-Received: by 2002:a2e:8ec2:: with SMTP id e2mr15688040ljl.446.1623114138007;
 Mon, 07 Jun 2021 18:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210605215215.171165-1-andrealmeid@collabora.com>
In-Reply-To: <20210605215215.171165-1-andrealmeid@collabora.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Jun 2021 18:02:05 -0700
Message-ID: <CAGS_qxoMZXLQDeyqF2C3U5VMgJFwWejsQSg9s4s0S0-X7YTWyA@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert UUID runtime test to KUnit
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 5, 2021 at 2:52 PM Andr=C3=A9 Almeida <andrealmeid@collabora.co=
m> wrote:
>
> Remove custom functions for testing and use KUnit framework. Test cases
> and test data remains the same.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
> ---
>  lib/Kconfig.debug |  13 +++--
>  lib/Makefile      |   2 +-
>  lib/test_uuid.c   | 131 ++++++++++++++++++----------------------------
>  3 files changed, 62 insertions(+), 84 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 678c13967580..e8bd574d7a67 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2188,9 +2188,6 @@ config TEST_BITMAP
>
>           If unsure, say N.
>
> -config TEST_UUID
> -       tristate "Test functions located in the uuid module at runtime"
> -
>  config TEST_XARRAY
>         tristate "Test the XArray code at runtime"
>
> @@ -2429,6 +2426,16 @@ config BITS_TEST
>
>           If unsure, say N.
>
> +config TEST_UUID
> +       tristate "Unit test for UUID" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the UUID unit test.
> +         Tests parsing functions for UUID/GUID strings.
> +
> +         If unsure, say N.
> +

Random question: this moves the config option down.
Is the intent to keep all the KUnit-based tests together?

I personally think it would be fine to leave it where it was, makes
`git blame` a bit more useful.

>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index 2cc359ec1fdd..6ef3c614409d 100644
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
> +obj-$(CONFIG_TEST_UUID) +=3D test_uuid.o
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o
> diff --git a/lib/test_uuid.c b/lib/test_uuid.c
> index cd819c397dc7..45c919b0d724 100644
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
> @@ -33,101 +32,73 @@ static const struct test_uuid_data test_uuid_test_da=
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
> +       const struct test_data *data =3D (const struct test_data *)(test-=
>param_value);
> +
> +       KUNIT_ASSERT_EQ(test, guid_parse(data->uuid, &le), 0);
> +       KUNIT_EXPECT_TRUE(test, guid_equal(&data->le, &le));
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
> +       const struct test_data *data =3D (const struct test_data *)(test-=
>param_value);
> +

> +       KUNIT_ASSERT_EQ(test, uuid_parse(data->uuid, &be), 0);
> +       KUNIT_EXPECT_TRUE(test, uuid_equal(&data->be, &be));


You could make use of the _MSG variants, fyi.
See https://www.kernel.org/doc/html/latest/dev-tools/kunit/tips.html#custom=
izing-error-messages

I'd actually written up a version of this patch but never ended up
sending it out.
(I prefer how you've more properly split up the test cases and used
parameterized testing.)

Here's how I'd converted the test case using those _MSG variants:
        /* LE */
        KUNIT_EXPECT_FALSE_MSG(test, guid_parse(data->uuid, &le),
                               "LE: failed to parse '%s'", data->uuid);

        KUNIT_EXPECT_TRUE_MSG(test, guid_equal(&data->le, &le),
                "LE: '%s' should be equal to %pUl", data->uuid, &le);

        /* BE */
        KUNIT_EXPECT_FALSE_MSG(test, uuid_parse(data->uuid, &be),
                               "BE: failed to parse '%s'", data->uuid);

        KUNIT_EXPECT_TRUE_MSG(test, uuid_equal(&data->be, &be),
                "BE: '%s' should be equal to %pUl", data->uuid, &be);

Example failure output:
          # test_uuid: EXPECTATION FAILED at lib/test_uuid.c:77
          Expected uuid_equal(&data->be, &be) to be true, but is false

      BE: 'c33f4995-3701-450e-9fbf-206a2e98e576' should be equal to
95493fc3-0137-0e45-9fbf-206a2e98e576
          not ok 1 - test_uuid


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
> +       const char *data =3D (const char *)(test->param_value);
>
> -       /* BE */
> -       total_tests++;
> -       if (!uuid_parse(data, &be))
> -               test_uuid_failed("negative", true, true, data, NULL);
> +       KUNIT_ASSERT_NE(test, guid_parse(data, &le), 0);
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
> +       const char *data =3D (const char *)(test->param_value);
>
> -       if (failed_tests =3D=3D 0)
> -               pr_info("all %u tests passed\n", total_tests);
> -       else
> -               pr_err("failed %u out of %u tests\n", failed_tests, total=
_tests);
> +       KUNIT_ASSERT_NE(test, uuid_parse(data, &be), 0);
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
> +       .name =3D "uuid-test",
> +       .test_cases =3D uuid_test_cases,
> +};
> +kunit_test_suite(uuid_test_suite);
>
>  MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
>  MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.31.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20210605215215.171165-1-andrealmeid%40collabora.com.
