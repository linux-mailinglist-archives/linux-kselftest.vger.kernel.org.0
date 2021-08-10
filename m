Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4833E5138
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Aug 2021 04:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhHJC63 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 22:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhHJC63 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 22:58:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3C9C061796
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Aug 2021 19:58:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q10so878558wro.2
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Aug 2021 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKJ68dwGJlNs7YkExbguXXrf7lVwV3L2CBk/u/I1kiU=;
        b=uTi42yQU1aEA1iqnbmicZtYf3bM1iRNmBMhcL9vFTQf8NVwhpYCLccLiAO2qWvy7v2
         srQenar5NcAFJXGnf/WgThZiyPYcnuuNjxMNXq1BR86x1ewiPB6yPfyca3A9P1ziCKF4
         PR7UgV8G2DZo0nnNRmB13lZl1tN331iDolw2rTaSoECrHRf1fzJrUbFqStKhHseoIzSB
         1oIGLvUxKJ5T+g+O0UJyu1HPTybf2OvEVbfc5HrZZtP9u1OQrX7xjloKu5Rro3i8oND+
         W1dSeLvOYVEYU8qtNL53pefUIcwLJBwWQtqGCkTlG5DJlWVvOrepTZluzPSl50zh9Xsq
         CU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKJ68dwGJlNs7YkExbguXXrf7lVwV3L2CBk/u/I1kiU=;
        b=GYANCqm8rbWWgvMWfFKPFOvod/Q4oqzYsao8zyxHLTimovRhwfgWFc2VzemNF7i/0O
         fs0r3usoAP+qOdrV4viAETYErt+2IJDQISmfFQzsXfoaDLNtxcJnoLElSWoWt31UnyHY
         qdZPP6dVPogDMsOAvL+0DfHs1JTedN/CzJb1N2vUNdJHr6lsnakLa1AYgxEqgaq5544T
         yV0+aBhclxqF3W+BDBrt++KAaKs9f2tjUj32mxE8jHXz3vYd2BKIs+LRDZwZXNonxyoU
         nzSQ2L28bPl9NSlPVN9sbzxWK+O4vJJLAdeHvrhSRw5jiHF/cp2hZBk4GICdL0ACb71X
         KBuw==
X-Gm-Message-State: AOAM532qDeRYLuc/SMsvLife7veQAczKWZVRImhdFoSmu5WMM5fZmInq
        eF65+BVlRsJ/UXTgTwhYWszFKV7LycUHYqcYcrTbjA==
X-Google-Smtp-Source: ABdhPJwoqoINzAdATLBxrc3bXfYE5zGLaR/UyCB1Z9Grl0lahxjTnJ7q56Gu6eBFBq3c2rpwgniNMLZhvc283uS/Om0=
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr29173607wru.33.1628564285768;
 Mon, 09 Aug 2021 19:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210809223431.3514531-1-dlatypov@google.com>
In-Reply-To: <20210809223431.3514531-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 10 Aug 2021 10:57:54 +0800
Message-ID: <CABVgOSkG+KDxtvEFTGr_Kce-Lh3o85-nNwe3CV=_xcwRqDCHxg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: allow filtering test cases via glob
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 10, 2021 at 6:34 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit 1d71307a6f94 ("kunit: add unit test for filtering suites by
> names") introduced the ability to filter which suites we run via glob.
>
> This change extends it so we can also filter individual test cases
> inside of suites as well.
>
> This is quite useful when, e.g.
> * trying to run just the tests cases you've just added or are working on
> * trying to debug issues with test hermeticity
>
> Examples:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit '*exec*.parse*'
> ...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> [PASSED] parse_filter_test
> ============================================================
> Testing complete. 1 tests run. 0 failed. 0 crashed.
>
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit '*.no_matching_tests'
> ...
> [ERROR] no tests run!
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Thanks! This works a treat. A minor documentation suggestion and a bad
optimisation idea lurk below, but I'm happy with this as-is
regardless.

Reviewed-by: David Gow <davidgow@google.com>

-- David

> ---
> v1 -> v2: update Documentation/.../running_tips.rst
> ---
>  .../dev-tools/kunit/running_tips.rst          |  11 +-
>  lib/kunit/executor.c                          | 107 +++++++++++++++--
>  lib/kunit/executor_test.c                     | 109 +++++++++++++++---
>  3 files changed, 201 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index d1626d548fa5..f471bcbdabd4 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -25,8 +25,8 @@ It can be handy to create a bash function like:
>  Running a subset of tests
>  -------------------------
>
> -``kunit.py run`` accepts an optional glob argument to filter tests. Currently
> -this only matches against suite names, but this may change in the future.
> +``kunit.py run`` accepts an optional glob argument to filter tests. The format
> +is ``"<suite_glob>[.test_glob]"``.

It might be worth having an even more explicit note that this is two
separate globs separated by a '.', rather than one glob which matches
a string formed by 'suite.test'. e.g., you do need 'sysctl*.*write'
instead of 'sysctl*write' to match those tests. (And hope no-one gets
scared off by the MS-DOS style *.* :-) )

>  Say that we wanted to run the sysctl tests, we could do so via:
>
> @@ -35,6 +35,13 @@ Say that we wanted to run the sysctl tests, we could do so via:
>         $ echo -e 'CONFIG_KUNIT=y\nCONFIG_KUNIT_ALL_TESTS=y' > .kunit/.kunitconfig
>         $ ./tools/testing/kunit/kunit.py run 'sysctl*'
>
> +We can filter down to just the "write" tests via:
> +
> +.. code-block:: bash
> +
> +       $ echo -e 'CONFIG_KUNIT=y\nCONFIG_KUNIT_ALL_TESTS=y' > .kunit/.kunitconfig
> +       $ ./tools/testing/kunit/kunit.py run 'sysctl*.*write*'
> +
>  We're paying the cost of building more tests than we need this way, but it's
>  easier than fiddling with ``.kunitconfig`` files or commenting out
>  ``kunit_suite``'s.
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index acd1de436f59..bab3ab940acc 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -17,21 +17,80 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>  static char *filter_glob_param;
>  module_param_named(filter_glob, filter_glob_param, charp, 0);
>  MODULE_PARM_DESC(filter_glob,
> -               "Filter which KUnit test suites run at boot-time, e.g. list*");
> +               "Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
> +
> +/* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
> +struct kunit_test_filter {
> +       char *suite_glob;
> +       char *test_glob;
> +};
> +
> +/* Split "suite_glob.test_glob" into two. Assumes filter_glob is not empty. */
> +static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
> +                                   const char *filter_glob)
> +{
> +       const int len = strlen(filter_glob);
> +       const char *period = strchr(filter_glob, '.');
> +
> +       if (!period) {
> +               parsed->suite_glob = kmalloc(len, GFP_KERNEL);
> +               parsed->test_glob = NULL;
> +               strcpy(parsed->suite_glob, filter_glob);
> +               return;
> +       }
> +
> +       parsed->suite_glob = kzalloc(period - filter_glob + 1, GFP_KERNEL);
> +       parsed->test_glob = kzalloc(len - (period - filter_glob) + 1, GFP_KERNEL);

If you're in the mood for premature optimisation (and I don't actually
think this function is a good candidate for it), you could just
replace the '.' with a '\0' in this function. It'd be easy to coalesce
the allocations (or possibly remove them entirely if we could modify
filter_glob_param). That being said, this is probably not the place to
try to be too clever, since it's only called once, so ignore this. :-)

> +
> +       strncpy(parsed->suite_glob, filter_glob, period - filter_glob);
> +       strncpy(parsed->test_glob, period + 1, len - (period - filter_glob));
> +}
> +
> +/* Create a copy of suite with only tests that match test_glob. */
> +static struct kunit_suite *
> +kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
> +{
> +       int n = 0;
> +       struct kunit_case *filtered, *test_case;
> +       struct kunit_suite *copy;
> +
> +       kunit_suite_for_each_test_case(suite, test_case) {
> +               if (!test_glob || glob_match(test_glob, test_case->name))
> +                       ++n;
> +       }
> +
> +       if (n == 0)
> +               return NULL;
> +
> +       /* Use memcpy to workaround copy->name being const. */
> +       copy = kmalloc(sizeof(*copy), GFP_KERNEL);
> +       memcpy(copy, suite, sizeof(*copy));
> +
> +       filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
> +
> +       n = 0;
> +       kunit_suite_for_each_test_case(suite, test_case) {
> +               if (!test_glob || glob_match(test_glob, test_case->name))
> +                       filtered[n++] = *test_case;
> +       }
> +
> +       copy->test_cases = filtered;
> +       return copy;
> +}
>
>  static char *kunit_shutdown;
>  core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
>
>  static struct kunit_suite * const *
>  kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
> -                       const char *filter_glob)
> +                     struct kunit_test_filter *filter)
>  {
>         int i, n = 0;
> -       struct kunit_suite **filtered;
> +       struct kunit_suite **filtered, *filtered_suite;
>
>         n = 0;
> -       for (i = 0; subsuite[i] != NULL; ++i) {
> -               if (glob_match(filter_glob, subsuite[i]->name))
> +       for (i = 0; subsuite[i]; ++i) {
> +               if (glob_match(filter->suite_glob, subsuite[i]->name))
>                         ++n;
>         }
>
> @@ -44,8 +103,11 @@ kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
>
>         n = 0;
>         for (i = 0; subsuite[i] != NULL; ++i) {
> -               if (glob_match(filter_glob, subsuite[i]->name))
> -                       filtered[n++] = subsuite[i];
> +               if (!glob_match(filter->suite_glob, subsuite[i]->name))
> +                       continue;
> +               filtered_suite = kunit_filter_tests(subsuite[i], filter->test_glob);
> +               if (filtered_suite)
> +                       filtered[n++] = filtered_suite;
>         }
>         filtered[n] = NULL;
>
> @@ -57,12 +119,32 @@ struct suite_set {
>         struct kunit_suite * const * const *end;
>  };
>
> +static void kunit_free_subsuite(struct kunit_suite * const *subsuite)
> +{
> +       unsigned int i;
> +
> +       for (i = 0; subsuite[i]; i++)
> +               kfree(subsuite[i]);
> +
> +       kfree(subsuite);
> +}
> +
> +static void kunit_free_suite_set(struct suite_set suite_set)
> +{
> +       struct kunit_suite * const * const *suites;
> +
> +       for (suites = suite_set.start; suites < suite_set.end; suites++)
> +               kunit_free_subsuite(*suites);
> +       kfree(suite_set.start);
> +}
> +
>  static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                                             const char *filter_glob)
>  {
>         int i;
>         struct kunit_suite * const **copy, * const *filtered_subsuite;
>         struct suite_set filtered;
> +       struct kunit_test_filter filter;
>
>         const size_t max = suite_set->end - suite_set->start;
>
> @@ -73,12 +155,17 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                 return filtered;
>         }
>
> +       kunit_parse_filter_glob(&filter, filter_glob);
> +
>         for (i = 0; i < max; ++i) {
> -               filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], filter_glob);
> +               filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], &filter);
>                 if (filtered_subsuite)
>                         *copy++ = filtered_subsuite;
>         }
>         filtered.end = copy;
> +
> +       kfree(filter.suite_glob);
> +       kfree(filter.test_glob);
>         return filtered;
>  }
>
> @@ -126,9 +213,7 @@ int kunit_run_all_tests(void)
>                 __kunit_test_suites_init(*suites);
>
>         if (filter_glob_param) { /* a copy was made of each array */
> -               for (suites = suite_set.start; suites < suite_set.end; suites++)
> -                       kfree(*suites);
> -               kfree(suite_set.start);
> +               kunit_free_suite_set(suite_set);
>         }
>
>         kunit_handle_shutdown();
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index cdbe54b16501..dbb49c099e02 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -9,38 +9,103 @@
>  #include <kunit/test.h>
>
>  static void kfree_at_end(struct kunit *test, const void *to_free);
> +static void free_subsuite_at_end(struct kunit *test,
> +                                struct kunit_suite *const *to_free);
>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> -                                           const char *suite_name);
> +                                           const char *suite_name,
> +                                           struct kunit_case *test_cases);
> +
> +void dummy_test(struct kunit *test) {}
> +
> +struct kunit_case dummy_test_cases[] = {
> +       /* .run_case is not important, just needs to be non-NULL */
> +       { .name = "test1", .run_case = dummy_test },
> +       { .name = "test2", .run_case = dummy_test },
> +       {},
> +};
> +
> +static void parse_filter_test(struct kunit *test)
> +{
> +       struct kunit_test_filter filter = {NULL, NULL};
> +
> +       kunit_parse_filter_glob(&filter, "suite");
> +       KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
> +       KUNIT_EXPECT_FALSE(test, filter.test_glob);
> +       kfree(filter.suite_glob);
> +       kfree(filter.test_glob);
> +
> +       kunit_parse_filter_glob(&filter, "suite.test");
> +       KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
> +       KUNIT_EXPECT_STREQ(test, filter.test_glob, "test");
> +       kfree(filter.suite_glob);
> +       kfree(filter.test_glob);
> +}
>
>  static void filter_subsuite_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
>         struct kunit_suite * const *filtered;
> +       struct kunit_test_filter filter = {
> +               .suite_glob = "suite2",
> +               .test_glob = NULL,
> +       };
>
> -       subsuite[0] = alloc_fake_suite(test, "suite1");
> -       subsuite[1] = alloc_fake_suite(test, "suite2");
> +       subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> +       subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
>         /* Want: suite1, suite2, NULL -> suite2, NULL */
> -       filtered = kunit_filter_subsuite(subsuite, "suite2*");
> +       filtered = kunit_filter_subsuite(subsuite, &filter);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
> -       kfree_at_end(test, filtered);
> +       free_subsuite_at_end(test, filtered);
>
> +       /* Validate we just have suite2 */
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
>         KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
> +       KUNIT_EXPECT_FALSE(test, filtered[1]);
> +}
> +
> +static void filter_subsuite_test_glob_test(struct kunit *test)
> +{
> +       struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
> +       struct kunit_suite * const *filtered;
> +       struct kunit_test_filter filter = {
> +               .suite_glob = "suite2",
> +               .test_glob = "test2",
> +       };
> +
> +       subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> +       subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
> +       /* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
> +       filtered = kunit_filter_subsuite(subsuite, &filter);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
> +       free_subsuite_at_end(test, filtered);
> +
> +       /* Validate we just have suite2 */
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
> +       KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
>         KUNIT_EXPECT_FALSE(test, filtered[1]);
> +
> +       /* Now validate we just have test2 */
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]->test_cases);
> +       KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->test_cases[0].name, "test2");
> +       KUNIT_EXPECT_FALSE(test, filtered[0]->test_cases[1].name);
>  }
>
>  static void filter_subsuite_to_empty_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
>         struct kunit_suite * const *filtered;
> +       struct kunit_test_filter filter = {
> +               .suite_glob = "not_found",
> +               .test_glob = NULL,
> +       };
>
> -       subsuite[0] = alloc_fake_suite(test, "suite1");
> -       subsuite[1] = alloc_fake_suite(test, "suite2");
> +       subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> +       subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
> -       filtered = kunit_filter_subsuite(subsuite, "not_found");
> -       kfree_at_end(test, filtered); /* just in case */
> +       filtered = kunit_filter_subsuite(subsuite, &filter);
> +       free_subsuite_at_end(test, filtered); /* just in case */
>
>         KUNIT_EXPECT_FALSE_MSG(test, filtered,
>                                "should be NULL to indicate no match");
> @@ -52,7 +117,7 @@ static void kfree_subsuites_at_end(struct kunit *test, struct suite_set *suite_s
>
>         kfree_at_end(test, suite_set->start);
>         for (suites = suite_set->start; suites < suite_set->end; suites++)
> -               kfree_at_end(test, *suites);
> +               free_subsuite_at_end(test, *suites);
>  }
>
>  static void filter_suites_test(struct kunit *test)
> @@ -74,8 +139,8 @@ static void filter_suites_test(struct kunit *test)
>         struct suite_set filtered = {.start = NULL, .end = NULL};
>
>         /* Emulate two files, each having one suite */
> -       subsuites[0][0] = alloc_fake_suite(test, "suite0");
> -       subsuites[1][0] = alloc_fake_suite(test, "suite1");
> +       subsuites[0][0] = alloc_fake_suite(test, "suite0", dummy_test_cases);
> +       subsuites[1][0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
>
>         /* Filter out suite1 */
>         filtered = kunit_filter_suites(&suite_set, "suite0");
> @@ -88,7 +153,9 @@ static void filter_suites_test(struct kunit *test)
>  }
>
>  static struct kunit_case executor_test_cases[] = {
> +       KUNIT_CASE(parse_filter_test),
>         KUNIT_CASE(filter_subsuite_test),
> +       KUNIT_CASE(filter_subsuite_test_glob_test),
>         KUNIT_CASE(filter_subsuite_to_empty_test),
>         KUNIT_CASE(filter_suites_test),
>         {}
> @@ -120,14 +187,30 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
>                                      (void *)to_free);
>  }
>
> +static void free_subsuite_res_free(struct kunit_resource *res)
> +{
> +       kunit_free_subsuite(res->data);
> +}
> +
> +static void free_subsuite_at_end(struct kunit *test,
> +                                struct kunit_suite *const *to_free)
> +{
> +       if (IS_ERR_OR_NULL(to_free))
> +               return;
> +       kunit_alloc_and_get_resource(test, NULL, free_subsuite_res_free,
> +                                    GFP_KERNEL, (void *)to_free);
> +}
> +
>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> -                                           const char *suite_name)
> +                                           const char *suite_name,
> +                                           struct kunit_case *test_cases)
>  {
>         struct kunit_suite *suite;
>
>         /* We normally never expect to allocate suites, hence the non-const cast. */
>         suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
>         strncpy((char *)suite->name, suite_name, sizeof(suite->name) - 1);
> +       suite->test_cases = test_cases;
>
>         return suite;
>  }
>
> base-commit: 36a21d51725af2ce0700c6ebcb6b9594aac658a6
> --
> 2.32.0.605.g8dce9f2422-goog
>
