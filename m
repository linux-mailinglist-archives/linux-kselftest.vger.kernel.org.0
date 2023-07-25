Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B38C760D63
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGYIoE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjGYIng (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:43:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E786213D
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so9135a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690274550; x=1690879350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xBrTKjXlDSR0kZuQmYB96A83zZIeewgSHxzGKsn+6o0=;
        b=50YXjjnBF7jSlEzSt6QMuLFxjj9BNonwuAQUlNwpcuLivT4j7LoEhy9AXhqs2/IK6L
         r4OR864ZaBXSEXdrEzranHAd17r+56fx2DR9T7tNYGxWeDSy5E1CdZIjcGmsU1r1XlDZ
         6X/qbT5pwG93NUCwuSUbRrYstAx2jynrjL6C5WLPkspo8NdpkAcWkrDBroVNOsUMi7or
         JIyxwKfW+eGBkSteoKxy4APR6OaAC3X+4ji7nXWfKAYaT8SgBEC0SplPFnKNMQnco2Az
         qV7KLnbLw8nQ4cVCwYfaj353eWYKnn53jfrCPjVXAu0YFBx9OZ9Ux+cbYSAJYd9le9o3
         OcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274550; x=1690879350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBrTKjXlDSR0kZuQmYB96A83zZIeewgSHxzGKsn+6o0=;
        b=Qm8QXjXwZUFBxJIHLwEF9UIjx7wJrmXtlRR8IS+mm0WuuioCEVA2/GLaDKKHGLs9ow
         I6YfRT6hrAkqHiF7lYsoIF8qExP3hEGMbPBmU6c75aaHyXxnXgyZeed1t/JkCAtDoiho
         kjCu3lcs72UiFvUB9ebA0Y7fxIqIPky14GSIGH0XSog6l92V1hsO0pSZMJQsqqK9pQGu
         vLLDswimRqoyCbwhPxaKjVy32VaYy8QlouPgfOfGPphR4Tnoskw9FJ74vZtlYt1G+nX/
         lQlKz4fqRxzd28wP1kax/zuc0Rwf69AWMfkr6JGVbKz6m+8Jy4VcJi6zjlix3gPpnucP
         pLNA==
X-Gm-Message-State: ABy/qLbSlayPsmCLswZ4MsJo+Y8RispLtBUT7rfuoqsFiVf82NVsmpmK
        y48dXqLPmh4Fj7sIqoWSFGRktcpmLhStScx2bPxv3A==
X-Google-Smtp-Source: APBJJlE2yV866xSiPQ/yZYsxyCRjYxi7I32kb+OPCtIGERJPDFR8UUAzStoM1WBz7yjF3IYxWlKq5ts6Bbnag7I6Y3E=
X-Received: by 2002:a50:cd93:0:b0:522:3ead:377 with SMTP id
 p19-20020a50cd93000000b005223ead0377mr46087edi.7.1690274550299; Tue, 25 Jul
 2023 01:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230724162834.1354164-1-rmoar@google.com> <20230724162834.1354164-5-rmoar@google.com>
In-Reply-To: <20230724162834.1354164-5-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 25 Jul 2023 16:42:16 +0800
Message-ID: <CABVgOS=NCNnmDFAYC9P-bDv9N1eVu59rX85p5oruAB=v5Chkgg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] kunit: Add ability to filter attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002c6f7306014bb6d8"
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

--0000000000002c6f7306014bb6d8
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jul 2023 at 00:30, Rae Moar <rmoar@google.com> wrote:
>
> Add filtering of test attributes. Users can filter tests using the
> module_param called "filter".
>
> Filters are imputed in the format: <attribute_name><operation><value>
>
> Example: kunit.filter="speed>slow"
>
> Operations include: >, <, >=, <=, !=, and =. These operations will act the
> same for attributes of the same type but may not between types.
>
> Note multiple filters can be inputted by separating them with a comma.
> Example: kunit.filter="speed=slow, module!=example"
>
> Since both suites and test cases can have attributes, there may be
> conflicts. The process of filtering follows these rules:
> - Filtering always operates at a per-test level.
> - If a test has an attribute set, then the test's value is filtered on.
> - Otherwise, the value falls back to the suite's value.
> - If neither are set, the attribute has a global "default" value, which
>   is used.
>
> Filtered tests will not be run or show in output. The tests can instead be
> skipped using the configurable option "kunit.filter_action=skip".
>
> Note the default settings for running tests remains unfiltered.
>
> Finally, add "filter" methods for the speed and module attributes to parse
> and compare attribute values.
>
> Note this filtering functionality will be added to kunit.py in the next
> patch.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Looks good. One super-minor formatting nitpick below.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>
> Changes since v1:
> - Fix compile warning of use of uninitialized variable
>
> Changes since RFC v2:
> - Change to output only one error before exiting.
>
> Changes since RFC v1:
> - Change method for inputting filters to allow for spaces in filtering
>   values
> - Add option to skip filtered tests instead of not run or show them with
>   the filter_action=skip flag
>
>  include/kunit/attributes.h |  31 +++++
>  lib/kunit/attributes.c     | 271 +++++++++++++++++++++++++++++++++++++
>  lib/kunit/executor.c       |  94 ++++++++++---
>  lib/kunit/executor_test.c  |  12 +-
>  lib/kunit/test.c           |  10 +-
>  5 files changed, 390 insertions(+), 28 deletions(-)
>
> diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
> index 9fcd184cce36..bc76a0b786d2 100644
> --- a/include/kunit/attributes.h
> +++ b/include/kunit/attributes.h
> @@ -9,6 +9,20 @@
>  #ifndef _KUNIT_ATTRIBUTES_H
>  #define _KUNIT_ATTRIBUTES_H
>
> +/*
> + * struct kunit_attr_filter - representation of attributes filter with the
> + * attribute object and string input
> + */
> +struct kunit_attr_filter {
> +       struct kunit_attr *attr;
> +       char *input;
> +};
> +
> +/*
> + * Returns the name of the filter's attribute.
> + */
> +const char *kunit_attr_filter_name(struct kunit_attr_filter filter);
> +
>  /*
>   * Print all test attributes for a test case or suite.
>   * Output format for test cases: "# <test_name>.<attribute>: <value>"
> @@ -16,4 +30,21 @@
>   */
>  void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level);
>
> +/*
> + * Returns the number of fitlers in input.
> + */
> +int kunit_get_filter_count(char *input);
> +
> +/*
> + * Parse attributes filter input and return an objects containing the
> + * attribute object and the string input of the next filter.
> + */
> +struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *err);
> +
> +/*
> + * Returns a copy of the suite containing only tests that pass the filter.
> + */
> +struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suite,
> +               struct kunit_attr_filter filter, char *action, int *err);
> +
>  #endif /* _KUNIT_ATTRIBUTES_H */
> diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> index 9dce4f4d726c..d37c40c0ce4f 100644
> --- a/lib/kunit/attributes.c
> +++ b/lib/kunit/attributes.c
> @@ -67,6 +67,104 @@ static const char *attr_string_to_string(void *attr, bool *to_free)
>         return (char *) attr;
>  }
>
> +/* Filter Methods */
> +
> +static const char op_list[] = "<>!=";
> +
> +/*
> + * Returns whether the inputted integer value matches the filter given
> + * by the operation string and inputted integer.
> + */
> +static int int_filter(long val, const char *op, int input, int *err)
> +{
> +       if (!strncmp(op, "<=", 2))
> +               return (val <= input);
> +       else if (!strncmp(op, ">=", 2))
> +               return (val >= input);
> +       else if (!strncmp(op, "!=", 2))
> +               return (val != input);
> +       else if (!strncmp(op, ">", 1))
> +               return (val > input);
> +       else if (!strncmp(op, "<", 1))
> +               return (val < input);
> +       else if (!strncmp(op, "=", 1))
> +               return (val == input);
> +       *err = -EINVAL;
> +       pr_err("kunit executor: invalid filter operation: %s\n", op);
> +       return false;
> +}
> +
> +/*
> + * Returns whether the inputted enum value "attr" matches the filter given
> + * by the input string. Note: the str_list includes the corresponding string
> + * list to the enum values.
> + */
> +static int attr_enum_filter(void *attr, const char *input, int *err,
> +               const char * const str_list[], int max)
> +{
> +       int i, j, input_int;
> +       long test_val = (long)attr;
> +       const char *input_val = NULL;
> +
> +       for (i = 0; input[i]; i++) {
> +               if (!strchr(op_list, input[i])) {
> +                       input_val = input + i;
> +                       break;
> +               }
> +       }
> +
> +       if (!input_val) {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: filter value not found: %s\n", input);
> +               return false;
> +       }
> +
> +       for (j = 0; j <= max; j++) {
> +               if (!strcmp(input_val, str_list[j]))
> +                       input_int = j;
> +       }
> +
> +       if (!input_int) {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: invalid filter input: %s\n", input);
> +               return false;
> +       }
> +
> +       return int_filter(test_val, input, input_int, err);
> +}
> +
> +static int attr_speed_filter(void *attr, const char *input, int *err)
> +{
> +       return attr_enum_filter(attr, input, err, speed_str_list, KUNIT_SPEED_MAX);
> +}
> +
> +/*
> + * Returns whether the inputted string value (attr) matches the filter given
> + * by the input string.
> + */
> +static int attr_string_filter(void *attr, const char *input, int *err)
> +{
> +       char *str = attr;
> +
> +       if (!strncmp(input, "<", 1)) {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: invalid filter input: %s\n", input);
> +               return false;
> +       } else if (!strncmp(input, ">", 1)) {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: invalid filter input: %s\n", input);
> +               return false;
> +       } else if (!strncmp(input, "!=", 2)) {
> +               return (strcmp(input + 2, str) != 0);
> +       } else if (!strncmp(input, "=", 1)) {
> +               return (strcmp(input + 1, str) == 0);
> +       }
> +       *err = -EINVAL;
> +       pr_err("kunit executor: invalid filter operation: %s\n", input);
> +       return false;
> +}
> +
> +
>  /* Get Attribute Methods */
>
>  static void *attr_speed_get(void *test_or_suite, bool is_test)
> @@ -99,6 +197,7 @@ static struct kunit_attr kunit_attr_list[] = {
>                 .name = "speed",
>                 .get_attr = attr_speed_get,
>                 .to_string = attr_speed_to_string,
> +               .filter = attr_speed_filter,
>                 .attr_default = (void *)KUNIT_SPEED_NORMAL,
>                 .print = PRINT_ALWAYS,
>         },
> @@ -106,6 +205,7 @@ static struct kunit_attr kunit_attr_list[] = {
>                 .name = "module",
>                 .get_attr = attr_module_get,
>                 .to_string = attr_string_to_string,
> +               .filter = attr_string_filter,
>                 .attr_default = (void *)"",
>                 .print = PRINT_SUITE,
>         }
> @@ -113,6 +213,11 @@ static struct kunit_attr kunit_attr_list[] = {
>
>  /* Helper Functions to Access Attributes */
>
> +const char *kunit_attr_filter_name(struct kunit_attr_filter filter)
> +{
> +       return filter.attr->name;
> +}
> +
>  void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level)
>  {
>         int i;
> @@ -145,3 +250,169 @@ void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level
>                 }
>         }
>  }
> +
> +/* Helper Functions to Filter Attributes */
> +
> +int kunit_get_filter_count(char *input)
> +{
> +       int i, comma_index, count = 0;
> +
> +       for (i = 0; input[i]; i++) {
> +               if (input[i] == ',') {
> +                       if ((i - comma_index) > 1)
> +                               count++;
> +                       comma_index = i;
> +               }
> +       }
> +       if ((i - comma_index) > 0)
> +               count++;
> +       return count;
> +}
> +
> +struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *err)
> +{
> +       struct kunit_attr_filter filter = {};
> +       int i, j, comma_index, new_start_index;
> +       int op_index = -1, attr_index = -1;
> +       char op;
> +       char *input = *filters;
> +
> +       /* Parse input until operation */
> +       for (i = 0; input[i]; i++) {
> +               if (op_index < 0 && strchr(op_list, input[i])) {
> +                       op_index = i;
> +               } else if (!comma_index && input[i] == ',') {
> +                       comma_index = i;
> +               } else if (comma_index && input[i] != ' ') {
> +                       new_start_index = i;
> +                       break;
> +               }
> +       }
> +
> +       if (op_index <= 0) {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: filter operation not found: %s\n", input);
> +               return filter;
> +       }
> +
> +       /* Temporarily set operator to \0 character. */
> +       op = input[op_index];
> +       input[op_index] = '\0';
> +
> +       /* Find associated kunit_attr object */
> +       for (j = 0; j < ARRAY_SIZE(kunit_attr_list); j++) {
> +               if (!strcmp(input, kunit_attr_list[j].name)) {
> +                       attr_index = j;
> +                       break;
> +               }
> +       }
> +
> +       input[op_index] = op;
> +
> +       if (attr_index < 0) {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: attribute not found: %s\n", input);
> +       } else {
> +               filter.attr = &kunit_attr_list[attr_index];
> +       }
> +
> +       if (comma_index) {
> +               input[comma_index] = '\0';
> +               filter.input = input + op_index;
> +               input = input + new_start_index;
> +       } else {
> +               filter.input = input + op_index;
> +               input = NULL;
> +       }
> +
> +       *filters = input;
> +
> +       return filter;
> +}
> +
> +struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suite,
> +               struct kunit_attr_filter filter, char *action, int *err)
> +{
> +       int n = 0;
> +       struct kunit_case *filtered, *test_case;
> +       struct kunit_suite *copy;
> +       void *suite_val, *test_val;
> +       bool suite_result, test_result, default_result, result;
> +
> +       /* Allocate memory for new copy of suite and list of test cases */
> +       copy = kmemdup(suite, sizeof(*copy), GFP_KERNEL);
> +       if (!copy)
> +               return ERR_PTR(-ENOMEM);
> +
> +       kunit_suite_for_each_test_case(suite, test_case) { n++; }
> +
> +       filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
> +       if (!filtered) {
> +               kfree(copy);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       n = 0;
> +
> +       /* Save filtering result on default value */
> +       default_result = filter.attr->filter(filter.attr->attr_default, filter.input, err);
> +       if (*err) {
> +               kfree(copy);
> +               kfree(filtered);
> +               return NULL;
> +       }
> +
> +       /* Save suite attribute value and filtering result on that value */
> +       suite_val = filter.attr->get_attr((void *)suite, false);
> +       suite_result = filter.attr->filter(suite_val, filter.input, err);
> +       if (*err) {
> +               kfree(copy);
> +               kfree(filtered);
> +               return NULL;
> +       }
> +
> +       /* For each test case, save test case if passes filtering. */
> +       kunit_suite_for_each_test_case(suite, test_case) {
> +               test_val = filter.attr->get_attr((void *) test_case, true);
> +               test_result = filter.attr->filter(filter.attr->get_attr(test_case, true),
> +                               filter.input, err);
> +               if (*err) {
> +                       kfree(copy);
> +                       kfree(filtered);
> +                       return NULL;
> +               }
> +
> +               /*
> +                * If attribute value of test case is set, filter on that value.
> +                * If not, filter on suite value if set. If not, filter on
> +                * default value.
> +                */
> +               result = false;
> +               if (test_val) {
> +                       if (test_result)
> +                               result = true;
> +               } else if (suite_val) {
> +                       if (suite_result)
> +                               result = true;
> +               } else if (default_result) {
> +                       result = true;
> +               }
> +
> +               if (result) {
> +                       filtered[n++] = *test_case;
> +               } else if (action && strcmp(action, "skip") == 0) {
> +                       test_case->status = KUNIT_SKIPPED;
> +                       filtered[n++] = *test_case;
> +               }
> +       }
> +
> +       if (n == 0) {
> +               kfree(copy);
> +               kfree(filtered);
> +               return NULL;
> +       }
> +
> +       copy->test_cases = filtered;
> +
> +       return copy;
> +}
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 12e38a48a5cc..c286ae47435a 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -17,6 +17,9 @@ extern struct kunit_suite * const __kunit_suites_end[];
>
>  static char *filter_glob_param;
>  static char *action_param;
> +static char *filter_param;
> +static char *filter_action_param;
> +

Nit: do we need this extra newline here?


>
>  module_param_named(filter_glob, filter_glob_param, charp, 0);
>  MODULE_PARM_DESC(filter_glob,
> @@ -27,15 +30,23 @@ MODULE_PARM_DESC(action,
>                  "<none>: run the tests like normal\n"
>                  "'list' to list test names instead of running them.\n"
>                  "'list_attr' to list test names and attributes instead of running them.\n");
> +module_param_named(filter, filter_param, charp, 0);
> +MODULE_PARM_DESC(filter,
> +               "Filter which KUnit test suites/tests run at boot-time using attributes, e.g. speed>slow");
> +module_param_named(filter_action, filter_action_param, charp, 0);
> +MODULE_PARM_DESC(filter_action,
> +               "Changes behavior of filtered tests using attributes, valid values are:\n"
> +               "<none>: do not run filtered tests as normal\n"
> +               "'skip': skip all filtered tests instead so tests will appear in output\n");
>
>  /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
> -struct kunit_test_filter {
> +struct kunit_glob_filter {
>         char *suite_glob;
>         char *test_glob;
>  };
>
>  /* Split "suite_glob.test_glob" into two. Assumes filter_glob is not empty. */
> -static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
> +static void kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
>                                     const char *filter_glob)
>  {
>         const int len = strlen(filter_glob);
> @@ -57,7 +68,7 @@ static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
>
>  /* Create a copy of suite with only tests that match test_glob. */
>  static struct kunit_suite *
> -kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
> +kunit_filter_glob_tests(const struct kunit_suite *const suite, const char *test_glob)
>  {
>         int n = 0;
>         struct kunit_case *filtered, *test_case;
> @@ -111,12 +122,15 @@ static void kunit_free_suite_set(struct suite_set suite_set)
>
>  static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                                             const char *filter_glob,
> +                                               char *filters,
> +                                               char *filter_action,
>                                             int *err)
>  {
> -       int i;
> -       struct kunit_suite **copy, *filtered_suite;
> +       int i, j, k, filter_count;
> +       struct kunit_suite **copy, *filtered_suite, *new_filtered_suite;
>         struct suite_set filtered;
> -       struct kunit_test_filter filter;
> +       struct kunit_glob_filter parsed_glob;
> +       struct kunit_attr_filter *parsed_filters;
>
>         const size_t max = suite_set->end - suite_set->start;
>
> @@ -127,17 +141,52 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                 return filtered;
>         }
>
> -       kunit_parse_filter_glob(&filter, filter_glob);
> -
> -       for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
> -               if (!glob_match(filter.suite_glob, suite_set->start[i]->name))
> -                       continue;
> +       if (filter_glob)
> +               kunit_parse_glob_filter(&parsed_glob, filter_glob);
>
> -               filtered_suite = kunit_filter_tests(suite_set->start[i], filter.test_glob);
> -               if (IS_ERR(filtered_suite)) {
> -                       *err = PTR_ERR(filtered_suite);
> +       /* Parse attribute filters */
> +       if (filters) {
> +               filter_count = kunit_get_filter_count(filters);
> +               parsed_filters = kcalloc(filter_count + 1, sizeof(*parsed_filters), GFP_KERNEL);
> +               for (j = 0; j < filter_count; j++)
> +                       parsed_filters[j] = kunit_next_attr_filter(&filters, err);
> +               if (*err)
>                         return filtered;
> +       }
> +
> +       for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
> +               filtered_suite = suite_set->start[i];
> +               if (filter_glob) {
> +                       if (!glob_match(parsed_glob.suite_glob, filtered_suite->name))
> +                               continue;
> +                       filtered_suite = kunit_filter_glob_tests(filtered_suite,
> +                                       parsed_glob.test_glob);
> +                       if (IS_ERR(filtered_suite)) {
> +                               *err = PTR_ERR(filtered_suite);
> +                               return filtered;
> +                       }
> +               }
> +               if (filter_count) {
> +                       for (k = 0; k < filter_count; k++) {
> +                               new_filtered_suite = kunit_filter_attr_tests(filtered_suite,
> +                                               parsed_filters[k], filter_action, err);
> +
> +                               /* Free previous copy of suite */
> +                               if (k > 0 || filter_glob)
> +                                       kfree(filtered_suite);
> +                               filtered_suite = new_filtered_suite;
> +
> +                               if (*err)
> +                                       return filtered;
> +                               if (IS_ERR(filtered_suite)) {
> +                                       *err = PTR_ERR(filtered_suite);
> +                                       return filtered;
> +                               }
> +                               if (!filtered_suite)
> +                                       break;
> +                       }
>                 }
> +
>                 if (!filtered_suite)
>                         continue;
>
> @@ -145,8 +194,14 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>         }
>         filtered.end = copy;
>
> -       kfree(filter.suite_glob);
> -       kfree(filter.test_glob);
> +       if (filter_glob) {
> +               kfree(parsed_glob.suite_glob);
> +               kfree(parsed_glob.test_glob);
> +       }
> +
> +       if (filter_count)
> +               kfree(parsed_filters);
> +
>         return filtered;
>  }
>
> @@ -206,8 +261,9 @@ int kunit_run_all_tests(void)
>                 goto out;
>         }
>
> -       if (filter_glob_param) {
> -               suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
> +       if (filter_glob_param || filter_param) {
> +               suite_set = kunit_filter_suites(&suite_set, filter_glob_param,
> +                               filter_param, filter_action_param, &err);
>                 if (err) {
>                         pr_err("kunit executor: error filtering suites: %d\n", err);
>                         goto out;
> @@ -223,7 +279,7 @@ int kunit_run_all_tests(void)
>         else
>                 pr_err("kunit executor: unknown action '%s'\n", action_param);
>
> -       if (filter_glob_param) { /* a copy was made of each suite */
> +       if (filter_glob_param || filter_param) { /* a copy was made of each suite */
>                 kunit_free_suite_set(suite_set);
>         }
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index ce6749af374d..d7ab069324b5 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -24,15 +24,15 @@ static struct kunit_case dummy_test_cases[] = {
>
>  static void parse_filter_test(struct kunit *test)
>  {
> -       struct kunit_test_filter filter = {NULL, NULL};
> +       struct kunit_glob_filter filter = {NULL, NULL};
>
> -       kunit_parse_filter_glob(&filter, "suite");
> +       kunit_parse_glob_filter(&filter, "suite");
>         KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
>         KUNIT_EXPECT_FALSE(test, filter.test_glob);
>         kfree(filter.suite_glob);
>         kfree(filter.test_glob);
>
> -       kunit_parse_filter_glob(&filter, "suite.test");
> +       kunit_parse_glob_filter(&filter, "suite.test");
>         KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
>         KUNIT_EXPECT_STREQ(test, filter.test_glob, "test");
>         kfree(filter.suite_glob);
> @@ -50,7 +50,7 @@ static void filter_suites_test(struct kunit *test)
>         subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
>         /* Want: suite1, suite2, NULL -> suite2, NULL */
> -       got = kunit_filter_suites(&suite_set, "suite2", &err);
> +       got = kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
>         kfree_at_end(test, got.start);
> @@ -74,7 +74,7 @@ static void filter_suites_test_glob_test(struct kunit *test)
>         subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
>         /* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
> -       got = kunit_filter_suites(&suite_set, "suite2.test2", &err);
> +       got = kunit_filter_suites(&suite_set, "suite2.test2", NULL, NULL, &err);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
>         kfree_at_end(test, got.start);
> @@ -100,7 +100,7 @@ static void filter_suites_to_empty_test(struct kunit *test)
>         subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
>         subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
> -       got = kunit_filter_suites(&suite_set, "not_found", &err);
> +       got = kunit_filter_suites(&suite_set, "not_found", NULL, NULL, &err);
>         KUNIT_ASSERT_EQ(test, err, 0);
>         kfree_at_end(test, got.start); /* just in case */
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 9ee55139ecd1..cb9797fa6303 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -613,18 +613,22 @@ int kunit_run_tests(struct kunit_suite *suite)
>         kunit_suite_for_each_test_case(suite, test_case) {
>                 struct kunit test = { .param_value = NULL, .param_index = 0 };
>                 struct kunit_result_stats param_stats = { 0 };
> -               test_case->status = KUNIT_SKIPPED;
>
>                 kunit_init_test(&test, test_case->name, test_case->log);
> -
> -               if (!test_case->generate_params) {
> +               if (test_case->status == KUNIT_SKIPPED) {
> +                       /* Test marked as skip */
> +                       test.status = KUNIT_SKIPPED;
> +                       kunit_update_stats(&param_stats, test.status);
> +               } else if (!test_case->generate_params) {
>                         /* Non-parameterised test. */
> +                       test_case->status = KUNIT_SKIPPED;
>                         kunit_run_case_catch_errors(suite, test_case, &test);
>                         kunit_update_stats(&param_stats, test.status);
>                 } else {
>                         /* Get initial param. */
>                         param_desc[0] = '\0';
>                         test.param_value = test_case->generate_params(NULL, param_desc);
> +                       test_case->status = KUNIT_SKIPPED;
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
>                                   "KTAP version 1\n");
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> --
> 2.41.0.487.g6d72f3e995-goog
>

--0000000000002c6f7306014bb6d8
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAEDPnEOWzT2vYIrJhGq
c1swDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzA1MTIx
NjMzMjlaFw0yMzExMDgxNjMzMjlaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCfIQuFV9ECjSKrnHc+/gEoEHeMu29G
hkC9x5KA7Tgm7ZISSdxxP+b9Q23vqKKYcaXlXzxDUweAEa7KrhRdZMpcF1p14/qI6AG7rBn8otbO
t6QSE9nwXQRL5ITEHtPRcQzLU5H9Yyq4b9MmEZAq+ByKX1t6FrXw461kqV8I/oCueKmD0p6mU/4k
xzQWik4ZqST0MXkJiZenSKDDN+U1qGgHKC3HAzsIlWpNh/WsWcD4RRcEtwfW1h9DwRfGFp78OFQg
65qXbeub4G7ELSIdjGygCzVG+g1jo6we5uqPep3iRCzn92KROEVxP5lG9FlwQ2YWMt+dNiGrJdKy
Kw4TK7CrAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFG/UTu3x
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB7
8SYg+ENEZwxmYk318iaLaOV55m1Igh1DLqulc70mSzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MjUwODQyMzBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAfMcjdKtfzJKTtn4t2vGx
MJ3Zbdj1EReL08HWgmjKlUWsC2DCMVkgoGQS5H0WX8k1VzsxOR8mLSEISpQhomdZjuqxLK3adGhs
hi6Fo/ifbevRC8gW0JLVvf/5MJSEta4nyX3hQUb7btJBUCoFSjrLLpFgSk8KvGiX5fdG+D5/G8u5
x4c3P2+k/Sqn4jolda+AQWjU5TcWwnay1l7AYr0nIsTCzRtav409eBkt4S9N4iMPACC7B7/7pWdN
pAnzOoP88QI1zA1GKPQmSnjaH2ukcviHKLbBjzYRS8eYxwCv1aetElao1/KvunaHPD4I6zNZ4xze
vlweuYFWsZeZ93fD9w==
--0000000000002c6f7306014bb6d8--
