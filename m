Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4992B760D64
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjGYIoG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjGYIn3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:43:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0AF211B
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so5884a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690274544; x=1690879344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cDlqf0NuzgYH/nWWZ6Q3632gkjcpW4xnxRvCvaZygDE=;
        b=5bKYH792F+WM15KVJp6ActgKd/KQWk7QOEhuU5CROyy8CSe6dpjBejhOlQgNhbHLpg
         se4pqPi4jhE7dJXO0ycJhV9l0SM0B47AqAohJ0jXJsVW0BbBzhOUrj4CsoWRRl+DsYuY
         CU3kEuxyDbDfRelBXmH+M5zasVSWNZE/VhY4CdPaL7kWUfzmAZLhkXXzFqMis9Dw8PhT
         tSFBk7467xOkuV8MBIqN8Y/U08nNRH9sO0A3KYykv+/+96QoUieemtieZjnvQPgDIQVn
         C+xFrAJieaWxLikd4n0p4KElCkjtIbHY7ORyM4l6BUz/RT5tW97jfihx6exRlR9vPFmd
         gG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274544; x=1690879344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDlqf0NuzgYH/nWWZ6Q3632gkjcpW4xnxRvCvaZygDE=;
        b=KpAOmW2T9nIfsUF/MTfyjeSaFkjr6OQXPascws5z2qEZN2K9o3gwZbBJ10iAZ37oy5
         659qSONzIAzLQjoDpjF2ngwKg6C+hXVRE8h1Re0Jf34Rm62CrdpZdUFlKqDAd0vdhRSp
         P3jzAOLSO2XYkbDLHQku5+BMilCTw/nmC9nV7iPRSno/f7np3FPV+kf2QnWlY3kV4H/Z
         Rpur1s02a1qacMHfQ/nQAGrbQo87Yq0uTu/uS5S7ttH4wTbgrxlYaEqONJ2R78KXRl8a
         jBtDpHwKwOYYZ0OWoO44GbxbC3SdHiZouyp3Uv2etHqYVg+74KhJJcs5wn71WIw+H+3m
         Q5zQ==
X-Gm-Message-State: ABy/qLbictJWfqodR71ZBTx5iYyPGKCz3Eq8XeqpUiYx7hm6Q4aDnS7F
        a2vwbujDNytOJqDh+F3PpcDwxGujYlWfnNhJyd2EIA==
X-Google-Smtp-Source: APBJJlFyNnCjlbJ25ze7/GE+XSMtXJwIHVqNCzl9/TowfwbiI6+vQarzh3Od7U5cE2auQ4fdHldIPecfc/9N00UDvb0=
X-Received: by 2002:a50:d4d3:0:b0:51a:1ffd:10e with SMTP id
 e19-20020a50d4d3000000b0051a1ffd010emr41804edj.3.1690274543803; Tue, 25 Jul
 2023 01:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230724162834.1354164-1-rmoar@google.com> <20230724162834.1354164-2-rmoar@google.com>
In-Reply-To: <20230724162834.1354164-2-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 25 Jul 2023 16:42:10 +0800
Message-ID: <CABVgOSky8C=19Cjq6vTgU=mQKvNmsUZvwFgtceLp-7aWW1+PHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] kunit: Add test attributes API structure
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c9ce3e06014bb507"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000c9ce3e06014bb507
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jul 2023 at 00:30, Rae Moar <rmoar@google.com> wrote:
>
> Add the basic structure of the test attribute API to KUnit, which can be
> used to save and access test associated data.
>
> Add attributes.c and attributes.h to hold associated structs and functions
> for the API.
>
> Create a struct that holds a variety of associated helper functions for
> each test attribute. These helper functions will be used to get the
> attribute value, convert the value to a string, and filter based on the
> value. This struct is flexible by design to allow for attributes of
> numerous types and contexts.
>
> Add a method to print test attributes in the format of "# [<test_name if
> not suite>.]<attribute_name>: <attribute_value>".
>
> Example for a suite: "# speed: slow"
>
> Example for a test case: "# test_case.speed: very_slow"
>
> Use this method to report attributes in the KTAP output (KTAP spec:
> https://docs.kernel.org/dev-tools/ktap.html) and _list_tests output when
> kernel's new kunit.action=list_attr option is used. Note this is derivative
> of the kunit.action=list option.
>
> In test.h, add fields and associated helper functions to test cases and
> suites to hold user-inputted test attributes.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Looks good to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>
> Changes since v1:
> - No major changes
>
> Changes since RFC v2:
> - No major changes
>
> Changes since RFC v1:
> - Add list_attr option to only include attribute in the _list_tests output
>   when this module param is set
> - Add printing options for attributes to print always, print only for
>   suites, or print never.
>
>  include/kunit/attributes.h | 19 +++++++++
>  include/kunit/test.h       | 33 ++++++++++++++++
>  lib/kunit/Makefile         |  3 +-
>  lib/kunit/attributes.c     | 80 ++++++++++++++++++++++++++++++++++++++
>  lib/kunit/executor.c       | 21 ++++++++--
>  lib/kunit/test.c           | 17 ++++----
>  6 files changed, 161 insertions(+), 12 deletions(-)
>  create mode 100644 include/kunit/attributes.h
>  create mode 100644 lib/kunit/attributes.c
>
> diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
> new file mode 100644
> index 000000000000..9fcd184cce36
> --- /dev/null
> +++ b/include/kunit/attributes.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit API to save and access test attributes
> + *
> + * Copyright (C) 2023, Google LLC.
> + * Author: Rae Moar <rmoar@google.com>
> + */
> +
> +#ifndef _KUNIT_ATTRIBUTES_H
> +#define _KUNIT_ATTRIBUTES_H
> +
> +/*
> + * Print all test attributes for a test case or suite.
> + * Output format for test cases: "# <test_name>.<attribute>: <value>"
> + * Output format for test suites: "# <attribute>: <value>"
> + */
> +void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level);
> +
> +#endif /* _KUNIT_ATTRIBUTES_H */
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 23120d50499e..1fc9155988e9 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -63,12 +63,16 @@ enum kunit_status {
>         KUNIT_SKIPPED,
>  };
>
> +/* Holds attributes for each test case and suite */
> +struct kunit_attributes {};
> +
>  /**
>   * struct kunit_case - represents an individual test case.
>   *
>   * @run_case: the function representing the actual test case.
>   * @name:     the name of the test case.
>   * @generate_params: the generator function for parameterized tests.
> + * @attr:     the attributes associated with the test
>   *
>   * A test case is a function with the signature,
>   * ``void (*)(struct kunit *)``
> @@ -104,6 +108,7 @@ struct kunit_case {
>         void (*run_case)(struct kunit *test);
>         const char *name;
>         const void* (*generate_params)(const void *prev, char *desc);
> +       struct kunit_attributes attr;
>
>         /* private: internal use only. */
>         enum kunit_status status;
> @@ -133,6 +138,18 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   */
>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
>
> +/**
> + * KUNIT_CASE_ATTR - A helper for creating a &struct kunit_case
> + * with attributes
> + *
> + * @test_name: a reference to a test case function.
> + * @attributes: a reference to a struct kunit_attributes object containing
> + * test attributes
> + */
> +#define KUNIT_CASE_ATTR(test_name, attributes)                 \
> +               { .run_case = test_name, .name = #test_name,    \
> +                 .attr = attributes }
> +
>  /**
>   * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
>   *
> @@ -154,6 +171,20 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>                 { .run_case = test_name, .name = #test_name,    \
>                   .generate_params = gen_params }
>
> +/**
> + * KUNIT_CASE_PARAM_ATTR - A helper for creating a parameterized &struct
> + * kunit_case with attributes
> + *
> + * @test_name: a reference to a test case function.
> + * @gen_params: a reference to a parameter generator function.
> + * @attributes: a reference to a struct kunit_attributes object containing
> + * test attributes
> + */
> +#define KUNIT_CASE_PARAM_ATTR(test_name, gen_params, attributes)       \
> +               { .run_case = test_name, .name = #test_name,    \
> +                 .generate_params = gen_params,                                \
> +                 .attr = attributes }
> +
>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_case
>   *
> @@ -163,6 +194,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   * @init:      called before every test case.
>   * @exit:      called after every test case.
>   * @test_cases:        a null terminated array of test cases.
> + * @attr:      the attributes associated with the test suite
>   *
>   * A kunit_suite is a collection of related &struct kunit_case s, such that
>   * @init is called before every test case and @exit is called after every
> @@ -182,6 +214,7 @@ struct kunit_suite {
>         int (*init)(struct kunit *test);
>         void (*exit)(struct kunit *test);
>         struct kunit_case *test_cases;
> +       struct kunit_attributes attr;
>
>         /* private: internal use only */
>         char status_comment[KUNIT_STATUS_COMMENT_SIZE];
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index cb417f504996..46f75f23dfe4 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -6,7 +6,8 @@ kunit-objs +=                           test.o \
>                                         string-stream.o \
>                                         assert.o \
>                                         try-catch.o \
> -                                       executor.o
> +                                       executor.o \
> +                                       attributes.o
>
>  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=                          debugfs.o
> diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> new file mode 100644
> index 000000000000..9bda5a5f4030
> --- /dev/null
> +++ b/lib/kunit/attributes.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit API to save and access test attributes
> + *
> + * Copyright (C) 2023, Google LLC.
> + * Author: Rae Moar <rmoar@google.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <kunit/attributes.h>
> +
> +/* Options for printing attributes:
> + * PRINT_ALWAYS - attribute is printed for every test case and suite if set
> + * PRINT_SUITE - attribute is printed for every suite if set but not for test cases
> + * PRINT_NEVER - attribute is never printed
> + */
> +enum print_ops {
> +       PRINT_ALWAYS,
> +       PRINT_SUITE,
> +       PRINT_NEVER,
> +};
> +
> +/**
> + * struct kunit_attr - represents a test attribute and holds flexible
> + * helper functions to interact with attribute.
> + *
> + * @name: name of test attribute, eg. speed
> + * @get_attr: function to return attribute value given a test
> + * @to_string: function to return string representation of given
> + * attribute value
> + * @filter: function to indicate whether a given attribute value passes a
> + * filter
> + */
> +struct kunit_attr {
> +       const char *name;
> +       void *(*get_attr)(void *test_or_suite, bool is_test);
> +       const char *(*to_string)(void *attr, bool *to_free);
> +       int (*filter)(void *attr, const char *input, int *err);
> +       void *attr_default;
> +       enum print_ops print;
> +};
> +
> +/* List of all Test Attributes */
> +
> +static struct kunit_attr kunit_attr_list[] = {};
> +
> +/* Helper Functions to Access Attributes */
> +
> +void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level)
> +{
> +       int i;
> +       bool to_free;
> +       void *attr;
> +       const char *attr_name, *attr_str;
> +       struct kunit_suite *suite = is_test ? NULL : test_or_suite;
> +       struct kunit_case *test = is_test ? test_or_suite : NULL;
> +
> +       for (i = 0; i < ARRAY_SIZE(kunit_attr_list); i++) {
> +               if (kunit_attr_list[i].print == PRINT_NEVER ||
> +                               (test && kunit_attr_list[i].print == PRINT_SUITE))
> +                       continue;
> +               attr = kunit_attr_list[i].get_attr(test_or_suite, is_test);
> +               if (attr) {
> +                       attr_name = kunit_attr_list[i].name;
> +                       attr_str = kunit_attr_list[i].to_string(attr, &to_free);
> +                       if (test) {
> +                               kunit_log(KERN_INFO, test, "%*s# %s.%s: %s",
> +                                       KUNIT_INDENT_LEN * test_level, "", test->name,
> +                                       attr_name, attr_str);
> +                       } else {
> +                               kunit_log(KERN_INFO, suite, "%*s# %s: %s",
> +                                       KUNIT_INDENT_LEN * test_level, "", attr_name, attr_str);
> +                       }
> +
> +                       /* Free to_string of attribute if needed */
> +                       if (to_free)
> +                               kfree(attr_str);
> +               }
> +       }
> +}
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 74982b83707c..12e38a48a5cc 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -2,6 +2,7 @@
>
>  #include <linux/reboot.h>
>  #include <kunit/test.h>
> +#include <kunit/attributes.h>
>  #include <linux/glob.h>
>  #include <linux/moduleparam.h>
>
> @@ -24,7 +25,8 @@ module_param_named(action, action_param, charp, 0);
>  MODULE_PARM_DESC(action,
>                  "Changes KUnit executor behavior, valid values are:\n"
>                  "<none>: run the tests like normal\n"
> -                "'list' to list test names instead of running them.\n");
> +                "'list' to list test names instead of running them.\n"
> +                "'list_attr' to list test names and attributes instead of running them.\n");
>
>  /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
>  struct kunit_test_filter {
> @@ -172,7 +174,7 @@ static void kunit_exec_run_tests(struct suite_set *suite_set)
>         __kunit_test_suites_init(suite_set->start, num_suites);
>  }
>
> -static void kunit_exec_list_tests(struct suite_set *suite_set)
> +static void kunit_exec_list_tests(struct suite_set *suite_set, bool include_attr)
>  {
>         struct kunit_suite * const *suites;
>         struct kunit_case *test_case;
> @@ -180,10 +182,19 @@ static void kunit_exec_list_tests(struct suite_set *suite_set)
>         /* Hack: print a ktap header so kunit.py can find the start of KUnit output. */
>         pr_info("KTAP version 1\n");
>
> -       for (suites = suite_set->start; suites < suite_set->end; suites++)
> +       for (suites = suite_set->start; suites < suite_set->end; suites++) {
> +               /* Print suite name and suite attributes */
> +               pr_info("%s\n", (*suites)->name);
> +               if (include_attr)
> +                       kunit_print_attr((void *)(*suites), false, 0);
> +
> +               /* Print test case name and attributes in suite */
>                 kunit_suite_for_each_test_case((*suites), test_case) {
>                         pr_info("%s.%s\n", (*suites)->name, test_case->name);
> +                       if (include_attr)
> +                               kunit_print_attr((void *)test_case, true, 0);
>                 }
> +       }
>  }
>
>  int kunit_run_all_tests(void)
> @@ -206,7 +217,9 @@ int kunit_run_all_tests(void)
>         if (!action_param)
>                 kunit_exec_run_tests(&suite_set);
>         else if (strcmp(action_param, "list") == 0)
> -               kunit_exec_list_tests(&suite_set);
> +               kunit_exec_list_tests(&suite_set, false);
> +       else if (strcmp(action_param, "list_attr") == 0)
> +               kunit_exec_list_tests(&suite_set, true);
>         else
>                 pr_err("kunit executor: unknown action '%s'\n", action_param);
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 84e4666555c9..9ee55139ecd1 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -9,6 +9,7 @@
>  #include <kunit/resource.h>
>  #include <kunit/test.h>
>  #include <kunit/test-bug.h>
> +#include <kunit/attributes.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> @@ -168,6 +169,13 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
>  }
>  EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>
> +/* Currently supported test levels */
> +enum {
> +       KUNIT_LEVEL_SUITE = 0,
> +       KUNIT_LEVEL_CASE,
> +       KUNIT_LEVEL_CASE_PARAM,
> +};
> +
>  static void kunit_print_suite_start(struct kunit_suite *suite)
>  {
>         /*
> @@ -181,17 +189,11 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
>         pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
>         pr_info(KUNIT_SUBTEST_INDENT "# Subtest: %s\n",
>                   suite->name);
> +       kunit_print_attr((void *)suite, false, KUNIT_LEVEL_CASE);
>         pr_info(KUNIT_SUBTEST_INDENT "1..%zd\n",
>                   kunit_suite_num_test_cases(suite));
>  }
>
> -/* Currently supported test levels */
> -enum {
> -       KUNIT_LEVEL_SUITE = 0,
> -       KUNIT_LEVEL_CASE,
> -       KUNIT_LEVEL_CASE_PARAM,
> -};
> -
>  static void kunit_print_ok_not_ok(struct kunit *test,
>                                   unsigned int test_level,
>                                   enum kunit_status status,
> @@ -651,6 +653,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         }
>                 }
>
> +               kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
>
>                 kunit_print_test_stats(&test, param_stats);
>
> --
> 2.41.0.487.g6d72f3e995-goog
>

--000000000000c9ce3e06014bb507
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDL
fJI8Av3idErxDeCMmMz2V468akUAIp+zFMhUHA2S8zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MjUwODQyMjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAQjsyuguFNJzRlZC5q8DD
QjbTbJUNvYFPPD/MH1Qn/MXt82PtFLWv3S0Bd2ASxS2WExDK60aVulfP02JWD2I18Fe14E1fmMGe
vJh9INWjAQnstuuuH3tmEr4a19sfXlX9qJ+w/yg2tMMdSQ1JmZLFODAc/h8jxiEgJqFUAdCYWe4f
5FticnXa5eOrZEOBGVpF3O6KDZzaDBq/KzskFyHQR0kodSFzG/p0TPBvwDgtJ5gO7ZE66cYQmHM1
rjvBT45lNBAT6P0c3gECCkh+CW8vWnkOx+GN+A2/FdwkKISnXCyLxChlQ+Y6dwxxOovnuBYBr7Lq
P0WcGUP/Cd3YCAmHdw==
--000000000000c9ce3e06014bb507--
