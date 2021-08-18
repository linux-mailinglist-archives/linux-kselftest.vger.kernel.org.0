Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B12E3F0E9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 01:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhHRX2l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 19:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbhHRX2l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 19:28:41 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34F9C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Aug 2021 16:28:05 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y3so4038796ilm.6
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Aug 2021 16:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BrU0iZqqjGrpvKj3ZNY2zCgtm6J9wmKve0nNKL18jU=;
        b=AYEQc9rtXTQ27rNXvmk7OTivnDhbtjVoWuFd/vIxONqU8r0SuxhdV4Kt922iRny4Qi
         3vRf1IMfQ3TFkfwqLGlG+FDTxkoIAalW+BISe9ZT3lP/4ciLtI4l0xbfcidKxkXVRSAV
         ZLrBLSOtl1ZCB9amSkT6DaJbCSK2abQQNCNVSI2feaGQz2k+hej3SUlqpoKsmhLQc302
         MTKB5EueMk9GA1jPwBXwX3Waa843uIz1eBpiOD67O5N95hy1hSc8MprpdpnipiFiw76u
         cp2Lczm1z3sGsVaOm30G5bYKbiTNXlXlHe2J0lwNTH9hmkGw7x9dRjW4KH04+snAB5rf
         O5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BrU0iZqqjGrpvKj3ZNY2zCgtm6J9wmKve0nNKL18jU=;
        b=ImcN05Nb1z/ob0rAzz5jLd4B4BGw95YxqYRaEJCW8m6Ojz/gqV/HJE/orsDlw+SBLg
         rq2LlD2wSMIEjxRMNSgzvZAwV+ix3VNJKWHiM47n/VL2nvrvyR/7o4VzyIUnWCccOiia
         uoMhst/zuH5SoMzMijsb3CR8Q2pp5SheGmNb39Sd2AH3ZJW0+8KiYUmjhblTwl5AQae6
         iIL4AQB7kcX2976xQ94w0h19vwjjLuVY7ZfRjSu/0CFKNgFmhnBwUapDrRCFNE551QYB
         AerJkgYFIuiTP6RdfSH69hyR1hIRfwpPg+0QhGvTEcqjOjxjNzIE26o7MRaJ8s97A4E8
         tkrg==
X-Gm-Message-State: AOAM531Vbgjfz8nTBQXswuJw34kvAg7ZBhCRPVNudQsf6FB3f3ddBDLR
        MIUDhfuwZH85sIEo3mpOi97y2DyIV0ts2Jd4xXKspw==
X-Google-Smtp-Source: ABdhPJxNqS1TFH2jqOuQxDCFzBmlGqHv9+75YvSF2HRLdvJnUgtxe1hdFzB386Juptjy2tuJYZGxHNLe5TyXrqGhByo=
X-Received: by 2002:a92:bf12:: with SMTP id z18mr7835335ilh.274.1629329284814;
 Wed, 18 Aug 2021 16:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210809213859.3495973-1-dlatypov@google.com> <CAGS_qxqQS4gtkRYuPYJ+bULEXb0L0VjnHUc+Z49YYKWkUtVTkw@mail.gmail.com>
In-Reply-To: <CAGS_qxqQS4gtkRYuPYJ+bULEXb0L0VjnHUc+Z49YYKWkUtVTkw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 18 Aug 2021 16:27:53 -0700
Message-ID: <CAGS_qxq6ByD42m1A3qSx+tGhKN4nVSZr0TuzY1ZZ9tz53ygqKw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: allow filtering test cases via glob
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 17, 2021 at 9:47 AM Daniel Latypov <dlatypov@google.com> wrote:
>
>  On Mon, Aug 9, 2021 at 2:39 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Commit 1d71307a6f94 ("kunit: add unit test for filtering suites by
> > names") introduced the ability to filter which suites we run via glob.
> >
> > This change extends it so we can also filter individual test cases
> > inside of suites as well.
> >
> > This is quite useful when, e.g.
> > * trying to run just the tests cases you've just added or are working on
> > * trying to debug issues with test hermeticity
> >
> > Examples:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit '*exec*.parse*'
>
> There is a bug with this patch relating to suites.
> $ ./tools/testing/kunit/kunit.py run--kunitconfig=lib/kunit 'kunit-log-test'
> ...
> Kernel panic - not syncing: Segfault with no mm
>
> Before this patch:
> Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
>
> Another thing to note: if I run it with other test suites, it seems to run fine.

Ah.
The following line is problematic.

static void kunit_log_test(struct kunit *test)
{
struct kunit_suite *suite = &kunit_log_test_suite;

The test assumes that the suite object is the one that is currently
being executed.
That is not the case, as this patch makes a copy of each suite object.

So suite->log doesn't point to valid memory and trying to do a
`strstr()` check on it causes a segfault, normally.

Running this test with *any* filter causes it to crash.
E.g.
$ run_kunit --kunitconfig=lib/kunit 'kunit-*'
...
Testing complete. 10 tests run. 0 failed. 1 crashed. 0 skipped.

>
>
>
>
> > ...
> > ============================================================
> > ======== [PASSED] kunit_executor_test ========
> > [PASSED] parse_filter_test
> > ============================================================
> > Testing complete. 1 tests run. 0 failed. 0 crashed.
> >
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit '*.no_matching_tests'
> > ...
> > [ERROR] no tests run!
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> >  lib/kunit/executor.c      | 107 +++++++++++++++++++++++++++++++++----
> >  lib/kunit/executor_test.c | 109 +++++++++++++++++++++++++++++++++-----
> >  2 files changed, 192 insertions(+), 24 deletions(-)
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index acd1de436f59..bab3ab940acc 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -17,21 +17,80 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
> >  static char *filter_glob_param;
> >  module_param_named(filter_glob, filter_glob_param, charp, 0);
> >  MODULE_PARM_DESC(filter_glob,
> > -               "Filter which KUnit test suites run at boot-time, e.g. list*");
> > +               "Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
> > +
> > +/* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
> > +struct kunit_test_filter {
> > +       char *suite_glob;
> > +       char *test_glob;
> > +};
> > +
> > +/* Split "suite_glob.test_glob" into two. Assumes filter_glob is not empty. */
> > +static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
> > +                                   const char *filter_glob)
> > +{
> > +       const int len = strlen(filter_glob);
> > +       const char *period = strchr(filter_glob, '.');
> > +
> > +       if (!period) {
> > +               parsed->suite_glob = kmalloc(len, GFP_KERNEL);
> > +               parsed->test_glob = NULL;
> > +               strcpy(parsed->suite_glob, filter_glob);
> > +               return;
> > +       }
> > +
> > +       parsed->suite_glob = kzalloc(period - filter_glob + 1, GFP_KERNEL);
> > +       parsed->test_glob = kzalloc(len - (period - filter_glob) + 1, GFP_KERNEL);
> > +
> > +       strncpy(parsed->suite_glob, filter_glob, period - filter_glob);
> > +       strncpy(parsed->test_glob, period + 1, len - (period - filter_glob));
> > +}
> > +
> > +/* Create a copy of suite with only tests that match test_glob. */
> > +static struct kunit_suite *
> > +kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
> > +{
> > +       int n = 0;
> > +       struct kunit_case *filtered, *test_case;
> > +       struct kunit_suite *copy;
> > +
> > +       kunit_suite_for_each_test_case(suite, test_case) {
> > +               if (!test_glob || glob_match(test_glob, test_case->name))
> > +                       ++n;
> > +       }
> > +
> > +       if (n == 0)
> > +               return NULL;
> > +
> > +       /* Use memcpy to workaround copy->name being const. */
> > +       copy = kmalloc(sizeof(*copy), GFP_KERNEL);
> > +       memcpy(copy, suite, sizeof(*copy));
> > +
> > +       filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
> > +
> > +       n = 0;
> > +       kunit_suite_for_each_test_case(suite, test_case) {
> > +               if (!test_glob || glob_match(test_glob, test_case->name))
> > +                       filtered[n++] = *test_case;
> > +       }
> > +
> > +       copy->test_cases = filtered;
> > +       return copy;
> > +}
> >
> >  static char *kunit_shutdown;
> >  core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> >
> >  static struct kunit_suite * const *
> >  kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
> > -                       const char *filter_glob)
> > +                     struct kunit_test_filter *filter)
> >  {
> >         int i, n = 0;
> > -       struct kunit_suite **filtered;
> > +       struct kunit_suite **filtered, *filtered_suite;
> >
> >         n = 0;
> > -       for (i = 0; subsuite[i] != NULL; ++i) {
> > -               if (glob_match(filter_glob, subsuite[i]->name))
> > +       for (i = 0; subsuite[i]; ++i) {
> > +               if (glob_match(filter->suite_glob, subsuite[i]->name))
> >                         ++n;
> >         }
> >
> > @@ -44,8 +103,11 @@ kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
> >
> >         n = 0;
> >         for (i = 0; subsuite[i] != NULL; ++i) {
> > -               if (glob_match(filter_glob, subsuite[i]->name))
> > -                       filtered[n++] = subsuite[i];
> > +               if (!glob_match(filter->suite_glob, subsuite[i]->name))
> > +                       continue;
> > +               filtered_suite = kunit_filter_tests(subsuite[i], filter->test_glob);
> > +               if (filtered_suite)
> > +                       filtered[n++] = filtered_suite;
> >         }
> >         filtered[n] = NULL;
> >
> > @@ -57,12 +119,32 @@ struct suite_set {
> >         struct kunit_suite * const * const *end;
> >  };
> >
> > +static void kunit_free_subsuite(struct kunit_suite * const *subsuite)
> > +{
> > +       unsigned int i;
> > +
> > +       for (i = 0; subsuite[i]; i++)
> > +               kfree(subsuite[i]);
> > +
> > +       kfree(subsuite);
> > +}
> > +
> > +static void kunit_free_suite_set(struct suite_set suite_set)
> > +{
> > +       struct kunit_suite * const * const *suites;
> > +
> > +       for (suites = suite_set.start; suites < suite_set.end; suites++)
> > +               kunit_free_subsuite(*suites);
> > +       kfree(suite_set.start);
> > +}
> > +
> >  static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
> >                                             const char *filter_glob)
> >  {
> >         int i;
> >         struct kunit_suite * const **copy, * const *filtered_subsuite;
> >         struct suite_set filtered;
> > +       struct kunit_test_filter filter;
> >
> >         const size_t max = suite_set->end - suite_set->start;
> >
> > @@ -73,12 +155,17 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
> >                 return filtered;
> >         }
> >
> > +       kunit_parse_filter_glob(&filter, filter_glob);
> > +
> >         for (i = 0; i < max; ++i) {
> > -               filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], filter_glob);
> > +               filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], &filter);
> >                 if (filtered_subsuite)
> >                         *copy++ = filtered_subsuite;
> >         }
> >         filtered.end = copy;
> > +
> > +       kfree(filter.suite_glob);
> > +       kfree(filter.test_glob);
> >         return filtered;
> >  }
> >
> > @@ -126,9 +213,7 @@ int kunit_run_all_tests(void)
> >                 __kunit_test_suites_init(*suites);
> >
> >         if (filter_glob_param) { /* a copy was made of each array */
> > -               for (suites = suite_set.start; suites < suite_set.end; suites++)
> > -                       kfree(*suites);
> > -               kfree(suite_set.start);
> > +               kunit_free_suite_set(suite_set);
> >         }
> >
> >         kunit_handle_shutdown();
> > diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> > index cdbe54b16501..dbb49c099e02 100644
> > --- a/lib/kunit/executor_test.c
> > +++ b/lib/kunit/executor_test.c
> > @@ -9,38 +9,103 @@
> >  #include <kunit/test.h>
> >
> >  static void kfree_at_end(struct kunit *test, const void *to_free);
> > +static void free_subsuite_at_end(struct kunit *test,
> > +                                struct kunit_suite *const *to_free);
> >  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> > -                                           const char *suite_name);
> > +                                           const char *suite_name,
> > +                                           struct kunit_case *test_cases);
> > +
> > +void dummy_test(struct kunit *test) {}
> > +
> > +struct kunit_case dummy_test_cases[] = {
> > +       /* .run_case is not important, just needs to be non-NULL */
> > +       { .name = "test1", .run_case = dummy_test },
> > +       { .name = "test2", .run_case = dummy_test },
> > +       {},
> > +};
> > +
> > +static void parse_filter_test(struct kunit *test)
> > +{
> > +       struct kunit_test_filter filter = {NULL, NULL};
> > +
> > +       kunit_parse_filter_glob(&filter, "suite");
> > +       KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
> > +       KUNIT_EXPECT_FALSE(test, filter.test_glob);
> > +       kfree(filter.suite_glob);
> > +       kfree(filter.test_glob);
> > +
> > +       kunit_parse_filter_glob(&filter, "suite.test");
> > +       KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
> > +       KUNIT_EXPECT_STREQ(test, filter.test_glob, "test");
> > +       kfree(filter.suite_glob);
> > +       kfree(filter.test_glob);
> > +}
> >
> >  static void filter_subsuite_test(struct kunit *test)
> >  {
> >         struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
> >         struct kunit_suite * const *filtered;
> > +       struct kunit_test_filter filter = {
> > +               .suite_glob = "suite2",
> > +               .test_glob = NULL,
> > +       };
> >
> > -       subsuite[0] = alloc_fake_suite(test, "suite1");
> > -       subsuite[1] = alloc_fake_suite(test, "suite2");
> > +       subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> > +       subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
> >
> >         /* Want: suite1, suite2, NULL -> suite2, NULL */
> > -       filtered = kunit_filter_subsuite(subsuite, "suite2*");
> > +       filtered = kunit_filter_subsuite(subsuite, &filter);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
> > -       kfree_at_end(test, filtered);
> > +       free_subsuite_at_end(test, filtered);
> >
> > +       /* Validate we just have suite2 */
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
> >         KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
> > +       KUNIT_EXPECT_FALSE(test, filtered[1]);
> > +}
> > +
> > +static void filter_subsuite_test_glob_test(struct kunit *test)
> > +{
> > +       struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
> > +       struct kunit_suite * const *filtered;
> > +       struct kunit_test_filter filter = {
> > +               .suite_glob = "suite2",
> > +               .test_glob = "test2",
> > +       };
> > +
> > +       subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> > +       subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
> >
> > +       /* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
> > +       filtered = kunit_filter_subsuite(subsuite, &filter);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
> > +       free_subsuite_at_end(test, filtered);
> > +
> > +       /* Validate we just have suite2 */
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
> > +       KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
> >         KUNIT_EXPECT_FALSE(test, filtered[1]);
> > +
> > +       /* Now validate we just have test2 */
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]->test_cases);
> > +       KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->test_cases[0].name, "test2");
> > +       KUNIT_EXPECT_FALSE(test, filtered[0]->test_cases[1].name);
> >  }
> >
> >  static void filter_subsuite_to_empty_test(struct kunit *test)
> >  {
> >         struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
> >         struct kunit_suite * const *filtered;
> > +       struct kunit_test_filter filter = {
> > +               .suite_glob = "not_found",
> > +               .test_glob = NULL,
> > +       };
> >
> > -       subsuite[0] = alloc_fake_suite(test, "suite1");
> > -       subsuite[1] = alloc_fake_suite(test, "suite2");
> > +       subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> > +       subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
> >
> > -       filtered = kunit_filter_subsuite(subsuite, "not_found");
> > -       kfree_at_end(test, filtered); /* just in case */
> > +       filtered = kunit_filter_subsuite(subsuite, &filter);
> > +       free_subsuite_at_end(test, filtered); /* just in case */
> >
> >         KUNIT_EXPECT_FALSE_MSG(test, filtered,
> >                                "should be NULL to indicate no match");
> > @@ -52,7 +117,7 @@ static void kfree_subsuites_at_end(struct kunit *test, struct suite_set *suite_s
> >
> >         kfree_at_end(test, suite_set->start);
> >         for (suites = suite_set->start; suites < suite_set->end; suites++)
> > -               kfree_at_end(test, *suites);
> > +               free_subsuite_at_end(test, *suites);
> >  }
> >
> >  static void filter_suites_test(struct kunit *test)
> > @@ -74,8 +139,8 @@ static void filter_suites_test(struct kunit *test)
> >         struct suite_set filtered = {.start = NULL, .end = NULL};
> >
> >         /* Emulate two files, each having one suite */
> > -       subsuites[0][0] = alloc_fake_suite(test, "suite0");
> > -       subsuites[1][0] = alloc_fake_suite(test, "suite1");
> > +       subsuites[0][0] = alloc_fake_suite(test, "suite0", dummy_test_cases);
> > +       subsuites[1][0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> >
> >         /* Filter out suite1 */
> >         filtered = kunit_filter_suites(&suite_set, "suite0");
> > @@ -88,7 +153,9 @@ static void filter_suites_test(struct kunit *test)
> >  }
> >
> >  static struct kunit_case executor_test_cases[] = {
> > +       KUNIT_CASE(parse_filter_test),
> >         KUNIT_CASE(filter_subsuite_test),
> > +       KUNIT_CASE(filter_subsuite_test_glob_test),
> >         KUNIT_CASE(filter_subsuite_to_empty_test),
> >         KUNIT_CASE(filter_suites_test),
> >         {}
> > @@ -120,14 +187,30 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
> >                                      (void *)to_free);
> >  }
> >
> > +static void free_subsuite_res_free(struct kunit_resource *res)
> > +{
> > +       kunit_free_subsuite(res->data);
> > +}
> > +
> > +static void free_subsuite_at_end(struct kunit *test,
> > +                                struct kunit_suite *const *to_free)
> > +{
> > +       if (IS_ERR_OR_NULL(to_free))
> > +               return;
> > +       kunit_alloc_and_get_resource(test, NULL, free_subsuite_res_free,
> > +                                    GFP_KERNEL, (void *)to_free);
> > +}
> > +
> >  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> > -                                           const char *suite_name)
> > +                                           const char *suite_name,
> > +                                           struct kunit_case *test_cases)
> >  {
> >         struct kunit_suite *suite;
> >
> >         /* We normally never expect to allocate suites, hence the non-const cast. */
> >         suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
> >         strncpy((char *)suite->name, suite_name, sizeof(suite->name) - 1);
> > +       suite->test_cases = test_cases;
> >
> >         return suite;
> >  }
> >
> > base-commit: 36a21d51725af2ce0700c6ebcb6b9594aac658a6
> > --
> > 2.32.0.605.g8dce9f2422-goog
> >
