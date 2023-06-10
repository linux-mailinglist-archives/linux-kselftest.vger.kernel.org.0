Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBE472AA47
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFJI3u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjFJI3k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 04:29:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DE3AA1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 01:29:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7f7dfc037so33335e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686385774; x=1688977774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NpQYXxKxuFyNDraCux77LFinVt/ens10nWHcBfTRCiU=;
        b=QKa7sSJXj4TBNHzoghlJE5M//gcxNLC10ucOrrO3UaWPu6ffriiFvSFZXk5ue+twZd
         LW+dWRPgKhwHjQ8qTTeBuGRrCY+a+zLXaETaycTpz02gx0wrADM3lXARREMbw/eD5tsu
         HZjdnqvm8FD4RVNpEKhrPSJ3dYoLUWVzSaZ8A43nEYbkz/QkJfGNjjMkycpcIniG+nbu
         PUNyeKy0elvSkgvFggXMzq7jCgYC2vHlZ7RJ2VlXfQ1czBz/tMeM8jE/KMfFYKxIR9Yd
         9OrnH1+LS0CMgYH4ybsi93LQklPxKqxPfWJ2CDcIKQDi1pEWmZgjvP6vmTBvQbtyP7sT
         /7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686385774; x=1688977774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpQYXxKxuFyNDraCux77LFinVt/ens10nWHcBfTRCiU=;
        b=atZitAgF78bKo3odcXIw7BoqdlPKbrR6QhYUZLotzvndKxk8s4qqNJBAI4EAquoTom
         +u/yIp8jUWz6JAkB4Vh43eFLNr9Uu8Ju5r61v4d7dbVyIo3vbFSLAHRKt+qNvBCHxvty
         F2yH4ihsmPCDz95oxObMIhXulBqwBWWEeCXTfnC5GITjWgdXrWuIAF2vlXRR1jkPcmSn
         AiZmflxVks88ql8hUtDplrHtNpxFXwiJVpq4FJY99CUZWdNqyp7Adp3WNmnilqGTf/8q
         RCeVVpfu6vBzHLv6gNomL5e0gzv96BeniiEa6seeB8kB0jJwQFctmuVTjJ7Zr1/MLQ8x
         gJvg==
X-Gm-Message-State: AC+VfDw8uLCNRdZoPQh3cRxdyHGw/+Jxdnex+Er1O2NezhXvmJy/7+iJ
        eqTW/2PFzg1XBaSqvWoSqZTZAfqI95DH5qgyp87wvg==
X-Google-Smtp-Source: ACHHUZ5W4ExBoKhGWqrsy6dr7PUH0MeR78uSyS4sNOiB5j5YTpz6kBojFFzRw1kGcQYzSTUd8VXu/suv7aG/TAkrkrc=
X-Received: by 2002:a05:600c:1d88:b0:3f7:e4d8:2569 with SMTP id
 p8-20020a05600c1d8800b003f7e4d82569mr44147wms.5.1686385774279; Sat, 10 Jun
 2023 01:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com> <20230610005149.1145665-4-rmoar@google.com>
In-Reply-To: <20230610005149.1145665-4-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 10 Jun 2023 16:29:21 +0800
Message-ID: <CABVgOSmf=4v0jPdgEor-vrsr4YiEn_0wR4Xv+z_jobBT1SaVEQ@mail.gmail.com>
Subject: Re: [RFC v1 3/6] kunit: Add ability to filter attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000ca7e205fdc24955"
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

--0000000000000ca7e205fdc24955
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Jun 2023 at 08:52, Rae Moar <rmoar@google.com> wrote:
>
> Add filtering of test attributes. Users can filter tests using a
> module_param_array called "filter". This functionality will be added to
> kunit.py in the next patch.
>
> The filters will be imputed in the format:
> "<attribute_name><operation><attribute_value>"
>
> Example: "speed>slow"

Maybe give a full command-line example of "kunit.filter=speed>slow"?

>
> Operations include: >, <, >=, <=, !=, and =. These operations do not need
> to act the same for every attribute.

I assume here that operations should act the same for attributes of
the same type, but a string attribute might behave differently from an
int, an enum, an array, etc.

As a design principle, I think we definitely want the same operation
to act the same way between different attributes, unless there's an
extraordinarily good reason.

>
> Add method to parse inputted filters.
>
> Add the process of filtering tests based on attributes. The process of
> filtering follows these rules:
>
> A test case with a set attribute overrides its parent suite's attribute
> during filtering.
>
> Also, if both the test case attribute and suite attribute are unset the
> test acts as the default attribute value during filtering.

This behaviour probably needs to be documented more clearly in the
final version.

As I understand it:
- Both tests and suites have attributes.
- Filtering always operates at a per-test level.
- If a test has an attribute set, then the test's value is filtered on.
- Otherwise, the value falls back to the suite's value.
- If neither are set, the attribute has a global "default" value, which is used.
- If an entire suite is filtered out, it's removed, giving the
appearance that filtering can operate on a suite level.

I actually quite like these rules, but we do need to document them.
I'd perhaps argue that the "default attribute" could be done away with
and we just rely on the filter function choosing whether or not
"unset" matches a filter or not, but on the other hand, it does make
reusing filter functions potentially easier.

>
> Finally, add a "filter" method for the speed attribute to parse and compare
> enum values of kunit_speed.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

One other idea: do we want filtered-out tests to totally disappear (as
this patch does), to mark them as skipped (potentially useful, too),
or have configurable behaviour.

I think there are good reasons for each of those: having them totally
disappear is much cleaner, but it's also useful to see what tests
you're actually, well, skipping.

>  include/kunit/attributes.h |  22 +++++
>  lib/kunit/attributes.c     | 172 +++++++++++++++++++++++++++++++++++++
>  lib/kunit/executor.c       |  79 +++++++++++++----
>  lib/kunit/executor_test.c  |   8 +-
>  4 files changed, 258 insertions(+), 23 deletions(-)
>
> diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
> index 9fcd184cce36..bca60d1181bb 100644
> --- a/include/kunit/attributes.h
> +++ b/include/kunit/attributes.h
> @@ -9,6 +9,15 @@
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
>  /*
>   * Print all test attributes for a test case or suite.
>   * Output format for test cases: "# <test_name>.<attribute>: <value>"
> @@ -16,4 +25,17 @@
>   */
>  void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level);
>
> +/*
> + * Parse attributes filter input and return an object containing the attribute
> + * object and the string input.
> + */
> +struct kunit_attr_filter kunit_parse_filter_attr(char *input, int *err);

Should we rename this kunit_parse_attr_filter, as it returns a
kunit_attr_filter?

> +
> +
> +/*
> + * Returns a copy of the suite containing only tests that pass the filter.
> + */
> +struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suite,
> +               struct kunit_attr_filter filter, int *err);
> +
>  #endif /* _KUNIT_ATTRIBUTES_H */
> diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> index e17889f94693..4f753a28e4ee 100644
> --- a/lib/kunit/attributes.c
> +++ b/lib/kunit/attributes.c
> @@ -49,6 +49,66 @@ static const char *attr_speed_to_string(void *attr, bool *to_free)
>         return attr_enum_to_string(attr, speed_str_list, to_free);
>  }
>
> +/* Filter Methods */
> +
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
> +static int attr_enum_filter(void *attr, const char *input, int *err,
> +               const char * const str_list[], int max)

As this is a generic helper function to be used by multiple types of
attributes, let's document it a bit.

> +{
> +       int i, j, input_int;
> +       long test_val = (long)attr;
> +       const char *input_val;
> +
> +       for (i = 0; input[i]; i++) {
> +               if (!strchr("<!=>", input[i])) {

Can we yoink this string of "operation characters" into a global or
#define or something, as it recurs a few times here, and it'd be best
to only have it in one place.

> +                       input_val = input + i;
> +                       break;
> +               }
> +       }
> +
> +       if (!input_val) {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: filter operation not found: %s\n", input);
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
>  /* Get Attribute Methods */
>
>  static void *attr_speed_get(void *test_or_suite, bool is_test)
> @@ -68,6 +128,7 @@ static const struct kunit_attr speed_attr = {
>         .name = "speed",
>         .get_attr = attr_speed_get,
>         .to_string = attr_speed_to_string,
> +       .filter = attr_speed_filter,
>         .attr_default = (void *)KUNIT_SPEED_NORMAL,
>  };
>
> @@ -106,3 +167,114 @@ void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level
>                 }
>         }
>  }
> +
> +/* Helper Functions to Filter Attributes */
> +
> +struct kunit_attr_filter kunit_parse_filter_attr(char *input, int *err)
> +{
> +       struct kunit_attr_filter filter;
> +       int i, j, op_index = 0;
> +       int attr_index = -1;
> +       char op;
> +
> +       /* Parse input until operation */
> +       for (i = 0; input[i]; i++) {
> +               if (strchr("<>!=", input[i])) {
> +                       op_index = i;
> +                       break;
> +               }
> +               if (input[i] == ' ')
> +                       break;
> +       }
> +
> +       if (!op_index) {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: filter operation not found: %s\n", input);
> +               return filter;
> +       }
> +
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
> +       filter.input = input + op_index;
> +
> +       if (attr_index < 0) {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: attribute not found: %s\n", input);
> +       } else {
> +               filter.attr = &kunit_attr_list[attr_index];
> +       }
> +
> +       return filter;
> +}
> +
> +struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suite,
> +               struct kunit_attr_filter filter, int *err)
> +{
> +       int n = 0;
> +       struct kunit_case *filtered, *test_case;
> +       struct kunit_suite *copy;
> +       void *suite_val, *test_val;
> +       bool suite_result, test_result, default_result;
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
> +
> +       /* Save suite attribute value and filtering result on that value */
> +       suite_val = filter.attr->get_attr((void *)suite, false);
> +       suite_result = filter.attr->filter(suite_val, filter.input, err);
> +
> +       /* For each test case, save test case if passes filtering. */
> +       kunit_suite_for_each_test_case(suite, test_case) {
> +               test_val = filter.attr->get_attr((void *) test_case, true);
> +               test_result = filter.attr->filter(filter.attr->get_attr(test_case, true),
> +                               filter.input, err);
> +               /*
> +                * If attribute value of test case is set, filter on that value.
> +                * If not, filter on suite value if set. If not, filter on
> +                * default value.
> +                */
> +               if (test_val) {
> +                       if (test_result)
> +                               filtered[n++] = *test_case;
> +               } else if (suite_val) {
> +                       if (suite_result)
> +                               filtered[n++] = *test_case;
> +               } else if (default_result) {
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
> +       return copy;
> +}
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 767a84e32f06..c67657821eec 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -15,8 +15,12 @@ extern struct kunit_suite * const __kunit_suites_end[];
>
>  #if IS_BUILTIN(CONFIG_KUNIT)
>
> +#define MAX_FILTERS 10 // Limit of number of attribute filters
>  static char *filter_glob_param;
>  static char *action_param;
> +static int filter_count;
> +static char *filter_param[MAX_FILTERS];
> +
>
>  module_param_named(filter_glob, filter_glob_param, charp, 0);
>  MODULE_PARM_DESC(filter_glob,
> @@ -26,15 +30,16 @@ MODULE_PARM_DESC(action,
>                  "Changes KUnit executor behavior, valid values are:\n"
>                  "<none>: run the tests like normal\n"
>                  "'list' to list test names instead of running them.\n");
> +module_param_array_named(filter, filter_param, charp, &filter_count, 0);
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
> +static void kunit_parse_filter_glob(struct kunit_glob_filter *parsed,
>                                     const char *filter_glob)
>  {
>         const int len = strlen(filter_glob);
> @@ -56,7 +61,7 @@ static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
>
>  /* Create a copy of suite with only tests that match test_glob. */
>  static struct kunit_suite *
> -kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
> +kunit_filter_glob_tests(const struct kunit_suite *const suite, const char *test_glob)
>  {
>         int n = 0;
>         struct kunit_case *filtered, *test_case;
> @@ -110,12 +115,15 @@ static void kunit_free_suite_set(struct suite_set suite_set)
>
>  static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                                             const char *filter_glob,
> +                                               char **filters,
> +                                               int filter_count,
>                                             int *err)
>  {
> -       int i;
> -       struct kunit_suite **copy, *filtered_suite;
> +       int i, j, k;
> +       struct kunit_suite **copy, *filtered_suite, *new_filtered_suite;
>         struct suite_set filtered;
> -       struct kunit_test_filter filter;
> +       struct kunit_glob_filter parsed_glob;
> +       struct kunit_attr_filter parsed_filters[MAX_FILTERS];
>
>         const size_t max = suite_set->end - suite_set->start;
>
> @@ -126,17 +134,49 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                 return filtered;
>         }
>
> -       kunit_parse_filter_glob(&filter, filter_glob);
> +       if (filter_glob)
> +               kunit_parse_filter_glob(&parsed_glob, filter_glob);
>
> -       for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
> -               if (!glob_match(filter.suite_glob, suite_set->start[i]->name))
> -                       continue;
> +       /* Parse attribute filters */
> +       if (filter_count) {
> +               for (j = 0; j < filter_count; j++) {
> +                       parsed_filters[j] = kunit_parse_filter_attr(filters[j], err);
> +                       if (*err)
> +                               return filtered;
> +               }
> +       }
>
> -               filtered_suite = kunit_filter_tests(suite_set->start[i], filter.test_glob);
> -               if (IS_ERR(filtered_suite)) {
> -                       *err = PTR_ERR(filtered_suite);
> -                       return filtered;
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
>                 }
> +               if (filter_count) {
> +                       for (k = 0; k < filter_count; k++) {
> +                               new_filtered_suite = kunit_filter_attr_tests(filtered_suite,
> +                                               parsed_filters[k], err);
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
> +                       }
> +               }
> +
>                 if (!filtered_suite)
>                         continue;
>
> @@ -144,8 +184,8 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>         }
>         filtered.end = copy;
>
> -       kfree(filter.suite_glob);
> -       kfree(filter.test_glob);
> +       kfree(parsed_glob.suite_glob);
> +       kfree(parsed_glob.test_glob);
>         return filtered;
>  }
>
> @@ -203,8 +243,9 @@ int kunit_run_all_tests(void)
>                 goto out;
>         }
>
> -       if (filter_glob_param) {
> -               suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
> +       if (filter_glob_param || filter_count) {
> +               suite_set = kunit_filter_suites(&suite_set, filter_glob_param,
> +                               filter_param, filter_count, &err);
>                 if (err) {
>                         pr_err("kunit executor: error filtering suites: %d\n", err);
>                         goto out;
> @@ -218,7 +259,7 @@ int kunit_run_all_tests(void)
>         else
>                 pr_err("kunit executor: unknown action '%s'\n", action_param);
>
> -       if (filter_glob_param) { /* a copy was made of each suite */
> +       if (filter_glob_param || filter_count) { /* a copy was made of each suite */
>                 kunit_free_suite_set(suite_set);
>         }
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index ce6749af374d..4c8cb46857b2 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -24,7 +24,7 @@ static struct kunit_case dummy_test_cases[] = {
>
>  static void parse_filter_test(struct kunit *test)
>  {
> -       struct kunit_test_filter filter = {NULL, NULL};
> +       struct kunit_glob_filter filter = {NULL, NULL};
>
>         kunit_parse_filter_glob(&filter, "suite");
>         KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
> @@ -50,7 +50,7 @@ static void filter_suites_test(struct kunit *test)
>         subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
>         /* Want: suite1, suite2, NULL -> suite2, NULL */
> -       got = kunit_filter_suites(&suite_set, "suite2", &err);
> +       got = kunit_filter_suites(&suite_set, "suite2", NULL, 0, &err);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
>         kfree_at_end(test, got.start);
> @@ -74,7 +74,7 @@ static void filter_suites_test_glob_test(struct kunit *test)
>         subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
>         /* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
> -       got = kunit_filter_suites(&suite_set, "suite2.test2", &err);
> +       got = kunit_filter_suites(&suite_set, "suite2.test2", NULL, 0, &err);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
>         kfree_at_end(test, got.start);
> @@ -100,7 +100,7 @@ static void filter_suites_to_empty_test(struct kunit *test)
>         subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
>         subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
> -       got = kunit_filter_suites(&suite_set, "not_found", &err);
> +       got = kunit_filter_suites(&suite_set, "not_found", NULL, 0, &err);
>         KUNIT_ASSERT_EQ(test, err, 0);
>         kfree_at_end(test, got.start); /* just in case */
>

It'd be nice to add some more tests for attribute filtering specifically here.



> --
> 2.41.0.162.gfafddb0af9-goog
>

--0000000000000ca7e205fdc24955
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD2
fzJqxfTw1O/9turAZy+hYZC8Z5mkEwuPeNVQC0IzHzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA2MTAwODI5MzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAGvNRlgODXDJH1PBaDUAo
pH7LlxJfDKkCoqY5Ae2mxT/looqUo8WFYAyIy/VOkLUgVP0YytndLlxsKa8ZZBFFhVSasSbtCQeH
grnyJDx0RF6xXHsjffyaNZkzByO6ctEWKBpO2+6j4Zc327fCbmCeib7otS1Q2SvMD+7XNUHgua37
z8lna90oP3QK7umZdBS+smZYeTjvljvCbGYVMlGbJT6TSVng/jO46Iz/Qsqctw2ZoYT9AHgWYPKg
czFc9tpn3KQdKVzKU/kiFC3evOMSqB6y2z+S9KOcc+/qy0DVxHYk4XRh4HqVeLmGzQri05/cQn3p
08yKDDoGg8I6n5Vmew==
--0000000000000ca7e205fdc24955--
