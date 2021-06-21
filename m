Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD423AF81F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhFUV6m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 17:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhFUV6l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 17:58:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CC1C061574;
        Mon, 21 Jun 2021 14:56:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 7AC8B1F41F33
Subject: Re: [PATCH v4 1/1] lib: Convert UUID runtime test to KUnit
To:     Daniel Latypov <dlatypov@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        David Gow <davidgow@google.com>, tales.aparecida@gmail.com
References: <20210621133148.9226-1-andrealmeid@collabora.com>
 <20210621133148.9226-2-andrealmeid@collabora.com>
 <CAGS_qxoJ_+2EiRbssXuyiXrWuzzmC6-jsAd4qb_wJ4t0-Y+8bA@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <a224bf47-f567-3ae7-725a-f39a4511e49d@collabora.com>
Date:   Mon, 21 Jun 2021 18:56:16 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGS_qxoJ_+2EiRbssXuyiXrWuzzmC6-jsAd4qb_wJ4t0-Y+8bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Às 18:29 de 21/06/21, Daniel Latypov escreveu:
> On Mon, Jun 21, 2021 at 6:32 AM André Almeida <andrealmeid@collabora.com> wrote:
>>
>> Remove custom functions for testing and use KUnit framework. Keep the
>> tested functions and test data the same.
>>
>> Current test threat (g/u)uid_parse and (g/u)uid_equal as different test
>> cases. Make both functions being part of the same test case, given the
>> dependency regarding their results. This reduces the tests cases from 6
>> cases to 4, while keeping the test coverage the same. Given that we have
>> 3 strings for each test case, current test output notifies 18 tests
>> results, and the KUnit output announces 12 results.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> 
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> 
> Looks good to me.
> 
> I haven't been keeping up, but this won't get picked up until KUnit
> prints test statistics?

Good question, I don't think this was decided.

Andy, what do you think?

> But even if that's the case or not, this patch would be fine as-is.
> It'd be strictly an KUnit-internal thing to print test stats.
> 
>> ---
>>  lib/Kconfig.debug |   8 ++-
>>  lib/Makefile      |   2 +-
>>  lib/test_uuid.c   | 137 +++++++++++++++++++---------------------------
>>  3 files changed, 64 insertions(+), 83 deletions(-)
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 678c13967580..606ec5e2586d 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -2188,8 +2188,12 @@ config TEST_BITMAP
>>
>>           If unsure, say N.
>>
>> -config TEST_UUID
>> -       tristate "Test functions located in the uuid module at runtime"
>> +config UUID_KUNIT_TEST
>> +       tristate "Unit test for UUID" if !KUNIT_ALL_TESTS
>> +       depends on KUNIT
>> +       default KUNIT_ALL_TESTS
>> +       help
>> +         Tests parsing functions for UUID/GUID strings.
>>
>>  config TEST_XARRAY
>>         tristate "Test the XArray code at runtime"
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 2cc359ec1fdd..cc19048961c0 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -85,7 +85,6 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
>>  obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>>  obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
>>  obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
>> -obj-$(CONFIG_TEST_UUID) += test_uuid.o
>>  obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
>>  obj-$(CONFIG_TEST_PARMAN) += test_parman.o
>>  obj-$(CONFIG_TEST_KMOD) += test_kmod.o
>> @@ -354,5 +353,6 @@ obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>>  obj-$(CONFIG_BITS_TEST) += test_bits.o
>>  obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
>> +obj-$(CONFIG_UUID_KUNIT_TEST) += test_uuid.o
>>
>>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>> diff --git a/lib/test_uuid.c b/lib/test_uuid.c
>> index cd819c397dc7..30f350301e6d 100644
>> --- a/lib/test_uuid.c
>> +++ b/lib/test_uuid.c
>> @@ -1,21 +1,20 @@
>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>>  /*
>> - * Test cases for lib/uuid.c module.
>> + * Unit tests for lib/uuid.c module.
>> + *
>> + * Copyright 2016 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> + * Copyright 2021 André Almeida <andrealmeid@riseup.net>
>>   */
>> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> -
>> -#include <linux/init.h>
>> -#include <linux/kernel.h>
>> -#include <linux/module.h>
>> -#include <linux/string.h>
>> +#include <kunit/test.h>
>>  #include <linux/uuid.h>
>>
>> -struct test_uuid_data {
>> +struct test_data {
>>         const char *uuid;
>>         guid_t le;
>>         uuid_t be;
>>  };
>>
>> -static const struct test_uuid_data test_uuid_test_data[] = {
>> +static const struct test_data correct_data[] = {
>>         {
>>                 .uuid = "c33f4995-3701-450e-9fbf-206a2e98e576",
>>                 .le = GUID_INIT(0xc33f4995, 0x3701, 0x450e, 0x9f, 0xbf, 0x20, 0x6a, 0x2e, 0x98, 0xe5, 0x76),
>> @@ -33,101 +32,79 @@ static const struct test_uuid_data test_uuid_test_data[] = {
>>         },
>>  };
>>
>> -static const char * const test_uuid_wrong_data[] = {
>> +static const char * const wrong_data[] = {
>>         "c33f4995-3701-450e-9fbf206a2e98e576 ", /* no hyphen(s) */
>>         "64b4371c-77c1-48f9-8221-29f054XX023b", /* invalid character(s) */
>>         "0cb4ddff-a545-4401-9d06-688af53e",     /* not enough data */
>>  };
>>
>> -static unsigned total_tests __initdata;
>> -static unsigned failed_tests __initdata;
>> -
>> -static void __init test_uuid_failed(const char *prefix, bool wrong, bool be,
>> -                                   const char *data, const char *actual)
>> +static void uuid_correct_le(struct kunit *test)
>>  {
>> -       pr_err("%s test #%u %s %s data: '%s'\n",
>> -              prefix,
>> -              total_tests,
>> -              wrong ? "passed on wrong" : "failed on",
>> -              be ? "BE" : "LE",
>> -              data);
>> -       if (actual && *actual)
>> -               pr_err("%s test #%u actual data: '%s'\n",
>> -                      prefix,
>> -                      total_tests,
>> -                      actual);
>> -       failed_tests++;
>> +       guid_t le;
>> +       const struct test_data *data = test->param_value;
>> +
>> +       KUNIT_ASSERT_EQ_MSG(test, guid_parse(data->uuid, &le), 0,
>> +                           "failed to parse '%s'", data->uuid);
>> +       KUNIT_EXPECT_TRUE_MSG(test, guid_equal(&data->le, &le),
>> +                             "'%s' should be equal to %pUl", data->uuid, &le);
>>  }
>>
>> -static void __init test_uuid_test(const struct test_uuid_data *data)
>> +static void uuid_correct_be(struct kunit *test)
>>  {
>> -       guid_t le;
>>         uuid_t be;
>> -       char buf[48];
>> -
>> -       /* LE */
>> -       total_tests++;
>> -       if (guid_parse(data->uuid, &le))
>> -               test_uuid_failed("conversion", false, false, data->uuid, NULL);
>> -
>> -       total_tests++;
>> -       if (!guid_equal(&data->le, &le)) {
>> -               sprintf(buf, "%pUl", &le);
>> -               test_uuid_failed("cmp", false, false, data->uuid, buf);
>> -       }
>> -
>> -       /* BE */
>> -       total_tests++;
>> -       if (uuid_parse(data->uuid, &be))
>> -               test_uuid_failed("conversion", false, true, data->uuid, NULL);
>> -
>> -       total_tests++;
>> -       if (!uuid_equal(&data->be, &be)) {
>> -               sprintf(buf, "%pUb", &be);
>> -               test_uuid_failed("cmp", false, true, data->uuid, buf);
>> -       }
>> +       const struct test_data *data = test->param_value;
>> +
>> +       KUNIT_ASSERT_EQ_MSG(test, uuid_parse(data->uuid, &be), 0,
>> +                           "failed to parse '%s'", data->uuid);
>> +       KUNIT_EXPECT_TRUE_MSG(test, uuid_equal(&data->be, &be),
>> +                             "'%s' should be equal to %pUl", data->uuid, &be);
>>  }
>>
>> -static void __init test_uuid_wrong(const char *data)
>> +static void uuid_wrong_le(struct kunit *test)
>>  {
>>         guid_t le;
>> -       uuid_t be;
>> -
>> -       /* LE */
>> -       total_tests++;
>> -       if (!guid_parse(data, &le))
>> -               test_uuid_failed("negative", true, false, data, NULL);
>> +       const char * const *data = test->param_value;
>>
>> -       /* BE */
>> -       total_tests++;
>> -       if (!uuid_parse(data, &be))
>> -               test_uuid_failed("negative", true, true, data, NULL);
>> +       KUNIT_ASSERT_NE_MSG(test, guid_parse(*data, &le), 0,
>> +                           "parsing of '%s' should've failed", *data);
>>  }
>>
>> -static int __init test_uuid_init(void)
>> +static void uuid_wrong_be(struct kunit *test)
>>  {
>> -       unsigned int i;
>> -
>> -       for (i = 0; i < ARRAY_SIZE(test_uuid_test_data); i++)
>> -               test_uuid_test(&test_uuid_test_data[i]);
>> -
>> -       for (i = 0; i < ARRAY_SIZE(test_uuid_wrong_data); i++)
>> -               test_uuid_wrong(test_uuid_wrong_data[i]);
>> +       uuid_t be;
>> +       const char * const *data = test->param_value;
>>
>> -       if (failed_tests == 0)
>> -               pr_info("all %u tests passed\n", total_tests);
>> -       else
>> -               pr_err("failed %u out of %u tests\n", failed_tests, total_tests);
>> +       KUNIT_ASSERT_NE_MSG(test, uuid_parse(*data, &be), 0,
>> +                           "parsing of '%s' should've failed", *data);
>> +}
>>
>> -       return failed_tests ? -EINVAL : 0;
>> +static void case_to_desc_correct(const struct test_data *t, char *desc)
>> +{
>> +       strcpy(desc, t->uuid);
>>  }
>> -module_init(test_uuid_init);
>>
>> -static void __exit test_uuid_exit(void)
>> +KUNIT_ARRAY_PARAM(correct, correct_data, case_to_desc_correct);
>> +
>> +static void case_to_desc_wrong(const char * const *s, char *desc)
>>  {
>> -       /* do nothing */
>> +       strcpy(desc, *s);
>>  }
>> -module_exit(test_uuid_exit);
>> +
>> +KUNIT_ARRAY_PARAM(wrong, wrong_data, case_to_desc_wrong);
>> +
>> +static struct kunit_case uuid_test_cases[] = {
>> +       KUNIT_CASE_PARAM(uuid_correct_be, correct_gen_params),
>> +       KUNIT_CASE_PARAM(uuid_correct_le, correct_gen_params),
>> +       KUNIT_CASE_PARAM(uuid_wrong_be, wrong_gen_params),
>> +       KUNIT_CASE_PARAM(uuid_wrong_le, wrong_gen_params),
>> +       {}
>> +};
>> +
>> +static struct kunit_suite uuid_test_suite = {
>> +       .name = "uuid",
>> +       .test_cases = uuid_test_cases,
>> +};
>> +kunit_test_suite(uuid_test_suite);
>>
>>  MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
>>  MODULE_LICENSE("Dual BSD/GPL");
>> --
>> 2.32.0
>>
