Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D03757571
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 09:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjGRHjK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGRHjK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 03:39:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586E2E69
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:39:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so42335e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689665941; x=1692257941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v8FJRrAqogtMq84Hlw+fHDcbwy1SCB1mdP7Qz3gKtFw=;
        b=B4VPfbECdQv2Vm0i8zvLHf3uKNV4cOPzrxy3LWwlRVNbmDBzxHr8ddaGkZwYQ9/+JG
         hLhcEpCSHFirUoRTUpiLFn+P3oxL5WZmA2SoAHVOiBGj8I+DNpcuBdB6hUS/+zkaNfI9
         dOC50wH1KXS34WYpO/hnjQWR51BVMF/xeuF83SpIAAuARSzz5x6xuqm5ebAIpjeZnTww
         3zjD9SiYS1UJJsfhd5f2XYlmZSFUylL5yTFBYEyK7PKrgkgocrNGs4Rt/9IYxYJf/0Is
         bS6lAf+7KI6TL37HaacQhdodstXcytkaL9VCjOvuhHeNyAs+OV17koNhBvRjiO/ptggf
         H81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665941; x=1692257941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8FJRrAqogtMq84Hlw+fHDcbwy1SCB1mdP7Qz3gKtFw=;
        b=hclFEpOoTRlARV7wTnD0wMEzMVkPMg0dPqsq7naJXw/0LMgq/SXornUuyKw1L27tea
         TK7ndAlcBZ4EcUqJO17hXYr8RzkOq3/WRJIGwZpA3+4UAbO5rP51yn+cVZS+0oR53zn2
         pxWohj+D/46YWbnFN4Cy+6UD4YXiALxbZd53IfeiMeNF3PMCAiWE7dGfS+nGYm2W/RP5
         3h0QhWpdfZ3KPcB3OjmB2h/1xICdboiKMlRmWUHDWbgR0O4RS/xzZx0sgP0UFnFR+uHX
         YHNghbzhJNP3/TPlsxu4EWL+Q+2hgAdgkYNi+ufR1m3Mg+Ghu6iSouobVEfWublZ82Dr
         7cQA==
X-Gm-Message-State: ABy/qLZalCBX6CwCXFIX+kM0nONTkPx/m2u7NKgWjwSLDS1IUHTiZS27
        d5TDv10JjVfCDx5zS4tsTxp+xBUGaFeZ79Bsdbkd9w==
X-Google-Smtp-Source: APBJJlFxfORGtQgeSrzZMUGCDTnZBttV0acScwsIBVAOIfWMS2lH5lz57g/QHgtdQsZyvQ+Kb05+j3E/pjmiYkY6ZLg=
X-Received: by 2002:a05:600c:8617:b0:3f6:f4b:d4a6 with SMTP id
 ha23-20020a05600c861700b003f60f4bd4a6mr47798wmb.7.1689665941400; Tue, 18 Jul
 2023 00:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-2-rmoar@google.com>
In-Reply-To: <20230707210947.1208717-2-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Jul 2023 15:38:48 +0800
Message-ID: <CABVgOSkoKUVHE8=Z0gwsn-SfhgVy8rO62s5mHbfu6GXB54OfWA@mail.gmail.com>
Subject: Re: [RFC v2 1/9] kunit: Add test attributes API structure
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004157b40600be0215"
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

--0000000000004157b40600be0215
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jul 2023 at 05:09, Rae Moar <rmoar@google.com> wrote:
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

So, this is the one thing I'm a little unsure about here, and it's
really more of a problem with test names overall.

As noted in the KTAPv2 attributes and test name proposals, the names
and attributes are only really defined for "suites", hence the need to
have a different output format for test cases.

Personally, I'd prefer to keep the formats the same if we can (at
least for the actual KTAP output; I'm less concerned with the
list_attr option). That might make things a bit more difficult to
parse, though.

One possibility would be to combine the KTAP attributes and test name
specs and suggest that every test has a "test name" attribute, which
must be the first attribute output.

The output would then look something like:
KTAP version 2
# Name: my_suite
# Other-Attr: value
1..2
  KTAP version 2
  # Name: test_1
  # Other-Attr: value
  ok 1 test_1
  # Name: test_2
  # Other-Attr: value
  not ok 2 test_2
ok 1 my_suite

Would there be any problems with something like that?

I'm less concerned with the list_attr option, as that's not something
totally standardised in the way KTAP is.

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

The only other thing I'd really like to support one day is having
attributes for individual parameters in parameterised tests. I think
it makes sense as a follow-up, though.

>
> Changes since v1:
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

Do we want a separate set of attributes for test cases and suites?
(I think probably not, but it's worth making sure.)

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

I do worry a bit that we'll end up with a huge list of variants of the
KUNIT_CASE_* macros if we start adding more things here. I can't think
of a better way to handle it at the moment, though.



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
> 2.41.0.255.g8b1d071c50-goog
>

--0000000000004157b40600be0215
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAI
HCAeiBPnT6Ylu0rLH2KZLBl9ZMT4eMG27szoa1r8gDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTgwNzM5MDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANlv3Y0W+YkYC5JxwZX3U
TJ11xpLLzFpMZLwtEgu8AlgLEMsBQtuUb9t5NXUHDp6uKpwaJXc6/mbsH9/G2oMrHzUeuqYIs9J9
0Q5+MnedPzrUTwU3p1LB+ZhUZfjtJqTBVg+8T7Ma9RAPf4BHXD6locHntxVAy35NBIEujNUQxjVM
RRfJVaCvrK3BmYVhFH20CgQx/p96Ia4kUMdLk2sS8Dh4rYINjZq6lrRnAqrDrVLU/01RJayJoCdB
G6LJCHi0WiPFMc1Ast9FcXzdwzCMgNKAnYBBpQo4hehW2zZnGf0ga470j0EpG4VjqxtTDwTuIQlG
TwgwhjNFEaRGhgrNLA==
--0000000000004157b40600be0215--
