Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A642CA9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 22:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhJMUGD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 16:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhJMUGD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 16:06:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9734BC061570
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 13:03:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k26so3447584pfi.5
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgFjKX8reFAQlRSI6+C/M2san2NuQ9pZKH4qq5N0ORA=;
        b=VSlXGsF/QMUDk6H4I7Q1RWMoyhO5vruH8JUPowXPpz+Lf78eJA6NU12tOBGg/ReWK4
         oJEKUqc8CM3T5T7KXWRoG6GqvJgroYfgINnL5GkN+cvzIdeZ3Q7KHhIY7rwzdol9+tQd
         kOcebwGU/Riv3idwvSaoPOZudKcuFZ/++qQM1Zd/LHoPfG/QzVQyOiHVrgth8fd+PaQp
         t/0eghqJ12oUofvBWIsVWbXIeJau6OcJCRVSupfjxrAOXRGX+h6c5HxLKyIt3zMdZxYx
         iZxzYpQGhVFJgT1uMjtHr/O3d+ZXYXiTQja1GvyChQ8AskPxKrgun6hMWCwTRAnlHzPE
         y5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgFjKX8reFAQlRSI6+C/M2san2NuQ9pZKH4qq5N0ORA=;
        b=AZLLhHquTzSPir84M5ZgbJNxJzZrOOGF98p8MEZvN6yFwBMf6fU3eNhT6q8f/4BMK6
         UBxUAe4qkscTE/Pk5jlz4BFyWdmv5urGzfQYO3dnr6kA+HyIZF/9T9vQYobxmT6nopjv
         BjQXGyJAaJhfcuAmMq+ZEYOtY5rCyq6A/rVfVaeq4Vkygtjkw1nocOpi13rkcvXcx0C/
         0muPseJXIPHxXYwyUUMC5SWEd0pcXe5QTEV3Mlr8DANc3gdGx6D4z4vRzFJK2IT3LSv6
         bL5InZbDclhPbgmV1detmVPqvj/4dZ/KWk0tN4RrP6MzkHm0zQrX4zwh6CyjfIAEVeRa
         zkZg==
X-Gm-Message-State: AOAM5320NbH1aGUBRnDtAK/2cyxkQuvWL8qtAlNYU9MiMcSh4KOG9KGS
        ZLdwBTBI/sQFzEAegUxD8htb8qB4MbSfA/8A0B08FQ==
X-Google-Smtp-Source: ABdhPJxaklLKuAvk/2LwKr/YyGs7XJ3x3gvFsjDPPl88WU44cszIowMay7HiETIklEYo3qMMmB8dz0ZCpJovkblYKGE=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr1029294pfb.3.1634155438515; Wed, 13
 Oct 2021 13:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211013191320.2490913-1-dlatypov@google.com>
In-Reply-To: <20211013191320.2490913-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 13 Oct 2021 13:03:46 -0700
Message-ID: <CAFd5g47=aO3e8d4_GGcgY9BK43Z0Oo6SGD-2e5rJDp5r3k4XXQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: flatten kunit_suite*** to kunit_suite** in executor
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Jeremy Kerr <jk@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 13, 2021 at 12:13 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Per [1], we might not need the array-of-array of kunit_suite's.
>
> This RFC patch previews the changes we'd make to the executor to
> accommodate that by making the executor automatically flatten the
> kunit_suite*** into a kunit_suite**.
>
> The test filtering support [2] added the largest dependency on the
> current kunit_suite*** layout, so this patch is based on that.
>
> It actually drastically simplifies the code, so it might be useful to
> keep the auto-flattening step until we actually make the change.
>
> [1] https://lore.kernel.org/linux-kselftest/101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=3b29021ddd10cfb6b2565c623595bd3b02036f33
>
> Cc: Jeremy Kerr <jk@codeconstruct.com.au>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

I like it! This seems to make a lot of logic simpler (and from the
sounds makes Jeremy's proposed module patch easier?).

> ---
>  lib/kunit/executor.c      | 132 +++++++++++++++-----------------------
>  lib/kunit/executor_test.c | 131 ++++++++++---------------------------
>  2 files changed, 85 insertions(+), 178 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 22640c9ee819..3a7246336625 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -88,60 +88,18 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
>  static char *kunit_shutdown;
>  core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
>
> -static struct kunit_suite * const *
> -kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
> -                     struct kunit_test_filter *filter)
> -{
> -       int i, n = 0;
> -       struct kunit_suite **filtered, *filtered_suite;
> -
> -       n = 0;
> -       for (i = 0; subsuite[i]; ++i) {
> -               if (glob_match(filter->suite_glob, subsuite[i]->name))
> -                       ++n;
> -       }
> -
> -       if (n == 0)
> -               return NULL;
> -
> -       filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
> -       if (!filtered)
> -               return NULL;
> -
> -       n = 0;
> -       for (i = 0; subsuite[i] != NULL; ++i) {
> -               if (!glob_match(filter->suite_glob, subsuite[i]->name))
> -                       continue;
> -               filtered_suite = kunit_filter_tests(subsuite[i], filter->test_glob);
> -               if (filtered_suite)
> -                       filtered[n++] = filtered_suite;
> -       }
> -       filtered[n] = NULL;
> -
> -       return filtered;
> -}
> -
> +/* Stores a NULL-terminated array of suites. */
>  struct suite_set {
> -       struct kunit_suite * const * const *start;
> -       struct kunit_suite * const * const *end;
> +       struct kunit_suite * const *start;
> +       struct kunit_suite * const *end;
>  };
>
> -static void kunit_free_subsuite(struct kunit_suite * const *subsuite)
> -{
> -       unsigned int i;
> -
> -       for (i = 0; subsuite[i]; i++)
> -               kfree(subsuite[i]);
> -
> -       kfree(subsuite);
> -}
> -
>  static void kunit_free_suite_set(struct suite_set suite_set)
>  {
> -       struct kunit_suite * const * const *suites;
> +       struct kunit_suite * const *suites;
>
>         for (suites = suite_set.start; suites < suite_set.end; suites++)
> -               kunit_free_subsuite(*suites);
> +               kfree(*suites);
>         kfree(suite_set.start);
>  }
>
> @@ -149,10 +107,11 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                                             const char *filter_glob)
>  {
>         int i;
> -       struct kunit_suite * const **copy, * const *filtered_subsuite;
> +       struct kunit_suite **copy, *filtered_suite;
>         struct suite_set filtered;
>         struct kunit_test_filter filter;
>
> +       /* Note: this includes space for the terminating NULL. */
>         const size_t max = suite_set->end - suite_set->start;
>
>         copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
> @@ -164,11 +123,17 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>
>         kunit_parse_filter_glob(&filter, filter_glob);
>
> -       for (i = 0; i < max; ++i) {
> -               filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], &filter);
> -               if (filtered_subsuite)
> -                       *copy++ = filtered_subsuite;
> +       for (i = 0; suite_set->start[i] != NULL; i++) {
> +               if (!glob_match(filter.suite_glob, suite_set->start[i]->name))
> +                       continue;
> +
> +               filtered_suite = kunit_filter_tests(suite_set->start[i], filter.test_glob);
> +               if (!filtered_suite)
> +                       continue;
> +
> +               *copy++ = filtered_suite;
>         }
> +       *copy = NULL;
>         filtered.end = copy;
>
>         kfree(filter.suite_glob);
> @@ -190,52 +155,56 @@ static void kunit_handle_shutdown(void)
>
>  }
>
> -static void kunit_print_tap_header(struct suite_set *suite_set)
> -{
> -       struct kunit_suite * const * const *suites, * const *subsuite;
> -       int num_of_suites = 0;
> -
> -       for (suites = suite_set->start; suites < suite_set->end; suites++)
> -               for (subsuite = *suites; *subsuite != NULL; subsuite++)
> -                       num_of_suites++;
> -
> -       pr_info("TAP version 14\n");
> -       pr_info("1..%d\n", num_of_suites);
> -}
> -
>  static void kunit_exec_run_tests(struct suite_set *suite_set)
>  {
> -       struct kunit_suite * const * const *suites;
> -
> -       kunit_print_tap_header(suite_set);
> +       pr_info("TAP version 14\n");
> +       pr_info("1..%zu\n", suite_set->end - suite_set->start);
>
> -       for (suites = suite_set->start; suites < suite_set->end; suites++)
> -               __kunit_test_suites_init(*suites);
> +       __kunit_test_suites_init(suite_set->start);
>  }
>
>  static void kunit_exec_list_tests(struct suite_set *suite_set)
>  {
> -       unsigned int i;
> -       struct kunit_suite * const * const *suites;
> +       struct kunit_suite * const *suites;
>         struct kunit_case *test_case;
>
>         /* Hack: print a tap header so kunit.py can find the start of KUnit output. */
>         pr_info("TAP version 14\n");
>
>         for (suites = suite_set->start; suites < suite_set->end; suites++)
> -               for (i = 0; (*suites)[i] != NULL; i++) {
> -                       kunit_suite_for_each_test_case((*suites)[i], test_case) {
> -                               pr_info("%s.%s\n", (*suites)[i]->name, test_case->name);
> -                       }
> +               kunit_suite_for_each_test_case((*suites), test_case) {
> +                       pr_info("%s.%s\n", (*suites)->name, test_case->name);
>                 }
>  }
>
> +// TODO(dlatypov@google.com): delete this when we store suites in a single array.
> +static struct suite_set make_suite_set(void)
> +{
> +       struct suite_set flattened;
> +       size_t num_of_suites = 0;
> +
> +       struct kunit_suite * const * const *suites, * const *subsuite;
> +       struct kunit_suite **end;
> +
> +       for (suites = __kunit_suites_start; suites < __kunit_suites_end; suites++)
> +               for (subsuite = *suites; *subsuite != NULL; subsuite++)
> +                       num_of_suites++;
> +
> +       end = kcalloc(num_of_suites + 1, sizeof(*flattened.start), GFP_KERNEL);
> +       flattened.start = end;
> +
> +       for (suites = __kunit_suites_start; suites < __kunit_suites_end; suites++)
> +               for (subsuite = *suites; *subsuite != NULL; subsuite++)
> +                       *end++ = *subsuite;
> +       *end = NULL;
> +       flattened.end = end;
> +       return flattened;
> +}
> +
>  int kunit_run_all_tests(void)
>  {
> -       struct suite_set suite_set = {
> -               .start = __kunit_suites_start,
> -               .end = __kunit_suites_end,
> -       };
> +       struct suite_set suite_set = make_suite_set();
> +       struct kunit_suite * const *unfiltered = suite_set.start; /* need to free at end */
>
>         if (filter_glob_param)
>                 suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
> @@ -247,9 +216,10 @@ int kunit_run_all_tests(void)
>         else
>                 pr_err("kunit executor: unknown action '%s'\n", action_param);
>
> -       if (filter_glob_param) { /* a copy was made of each array */
> +       if (filter_glob_param) { /* a copy was made of each suite */
>                 kunit_free_suite_set(suite_set);
>         }
> +       kfree(unfiltered);
>
>         kunit_handle_shutdown();
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 7d2b8dc668b1..d9fce637eb56 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -9,8 +9,6 @@
>  #include <kunit/test.h>
>
>  static void kfree_at_end(struct kunit *test, const void *to_free);
> -static void free_subsuite_at_end(struct kunit *test,
> -                                struct kunit_suite *const *to_free);
>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
>                                             const char *suite_name,
>                                             struct kunit_case *test_cases);
> @@ -41,124 +39,77 @@ static void parse_filter_test(struct kunit *test)
>         kfree(filter.test_glob);
>  }
>
> -static void filter_subsuite_test(struct kunit *test)
> +static void filter_suites_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
> -       struct kunit_suite * const *filtered;
> -       struct kunit_test_filter filter = {
> -               .suite_glob = "suite2",
> -               .test_glob = NULL,
> -       };
> +       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
> +       struct suite_set got;
>
>         subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
>         subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
>         /* Want: suite1, suite2, NULL -> suite2, NULL */
> -       filtered = kunit_filter_subsuite(subsuite, &filter);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
> -       free_subsuite_at_end(test, filtered);
> +       got = kunit_filter_suites(&suite_set, "suite2");
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
> +       kfree_at_end(test, got.start);
>
>         /* Validate we just have suite2 */
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
> -       KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
> -       KUNIT_EXPECT_FALSE(test, filtered[1]);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite2");
> +       // DO NOT SUBMIT: null-terminated for now.

Can you elaborate what you mean here?

> +       KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
> +       KUNIT_EXPECT_FALSE(test, *got.end);
>  }
>
> -static void filter_subsuite_test_glob_test(struct kunit *test)
> +static void filter_suites_test_glob_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
> -       struct kunit_suite * const *filtered;
> -       struct kunit_test_filter filter = {
> -               .suite_glob = "suite2",
> -               .test_glob = "test2",
> -       };
> +       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
> +       struct suite_set got;
>
>         subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
>         subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
>         /* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
> -       filtered = kunit_filter_subsuite(subsuite, &filter);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
> -       free_subsuite_at_end(test, filtered);
> +       got = kunit_filter_suites(&suite_set, "suite2.test2");
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
> +       kfree_at_end(test, got.start);
>
>         /* Validate we just have suite2 */
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
> -       KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
> -       KUNIT_EXPECT_FALSE(test, filtered[1]);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite2");
> +       // DO NOT SUBMIT: null-terminated for now.
> +       KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
> +       KUNIT_EXPECT_FALSE(test, *got.end);
>
>         /* Now validate we just have test2 */
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]->test_cases);
> -       KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->test_cases[0].name, "test2");
> -       KUNIT_EXPECT_FALSE(test, filtered[0]->test_cases[1].name);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
> +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test2");
> +       KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
>  }
>
> -static void filter_subsuite_to_empty_test(struct kunit *test)
> +static void filter_suites_to_empty_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
> -       struct kunit_suite * const *filtered;
> -       struct kunit_test_filter filter = {
> -               .suite_glob = "not_found",
> -               .test_glob = NULL,
> -       };
> +       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
> +       struct suite_set got;
>
>         subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
>         subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
>
> -       filtered = kunit_filter_subsuite(subsuite, &filter);
> -       free_subsuite_at_end(test, filtered); /* just in case */
> -
> -       KUNIT_EXPECT_FALSE_MSG(test, filtered,
> -                              "should be NULL to indicate no match");
> -}
> -
> -static void kfree_subsuites_at_end(struct kunit *test, struct suite_set *suite_set)
> -{
> -       struct kunit_suite * const * const *suites;
> +       got = kunit_filter_suites(&suite_set, "not_found");
> +       kfree_at_end(test, got.start); /* just in case */
>
> -       kfree_at_end(test, suite_set->start);
> -       for (suites = suite_set->start; suites < suite_set->end; suites++)
> -               free_subsuite_at_end(test, *suites);
> +       KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
> +                               "should be empty to indicate no match");
>  }
>
> -static void filter_suites_test(struct kunit *test)
> -{
> -       /* Suites per-file are stored as a NULL terminated array */
> -       struct kunit_suite *subsuites[2][2] = {
> -               {NULL, NULL},
> -               {NULL, NULL},
> -       };
> -       /* Match the memory layout of suite_set */
> -       struct kunit_suite * const * const suites[2] = {
> -               subsuites[0], subsuites[1],
> -       };
> -
> -       const struct suite_set suite_set = {
> -               .start = suites,
> -               .end = suites + 2,
> -       };
> -       struct suite_set filtered = {.start = NULL, .end = NULL};
> -
> -       /* Emulate two files, each having one suite */
> -       subsuites[0][0] = alloc_fake_suite(test, "suite0", dummy_test_cases);
> -       subsuites[1][0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> -
> -       /* Filter out suite1 */
> -       filtered = kunit_filter_suites(&suite_set, "suite0");
> -       kfree_subsuites_at_end(test, &filtered); /* let us use ASSERTs without leaking */
> -       KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t)1);
> -
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0][0]);
> -       KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
> -}
>
>  static struct kunit_case executor_test_cases[] = {
>         KUNIT_CASE(parse_filter_test),
> -       KUNIT_CASE(filter_subsuite_test),
> -       KUNIT_CASE(filter_subsuite_test_glob_test),
> -       KUNIT_CASE(filter_subsuite_to_empty_test),
>         KUNIT_CASE(filter_suites_test),
> +       KUNIT_CASE(filter_suites_test_glob_test),
> +       KUNIT_CASE(filter_suites_to_empty_test),
>         {}
>  };
>
> @@ -188,20 +139,6 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
>                                      (void *)to_free);
>  }
>
> -static void free_subsuite_res_free(struct kunit_resource *res)
> -{
> -       kunit_free_subsuite(res->data);
> -}
> -
> -static void free_subsuite_at_end(struct kunit *test,
> -                                struct kunit_suite *const *to_free)
> -{
> -       if (IS_ERR_OR_NULL(to_free))
> -               return;
> -       kunit_alloc_resource(test, NULL, free_subsuite_res_free,
> -                            GFP_KERNEL, (void *)to_free);
> -}
> -
>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
>                                             const char *suite_name,
>                                             struct kunit_case *test_cases)
>
> base-commit: e7198adb84dcad671ad4f0e90aaa7e9fabf258dc
> --
> 2.33.0.882.g93a45727a2-goog
>
