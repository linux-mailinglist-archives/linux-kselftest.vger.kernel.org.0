Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77B43921A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 22:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhEZUuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 16:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhEZUuy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 16:50:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15742C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 13:49:21 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k16so2470437ios.10
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SffeaccrU8+f6j1f9jdCK0NgU3/4SLjODieMD3LKAyY=;
        b=mICm2u0G0JEiMgmQRV+P9WCkY8oIlnXatmIbuk5RWGhCZ23Cd6VB/Tr8niOeeBI/JL
         Zh265xahbHaEFI1xDDjkOlY+R32D0oKR2fbNdxKGJPlLpJsm2FhUVWkLRfz6zDIovaOQ
         y5qZdmW0Ybz7mMLcjz3oTSdo+R/F0DAfn+WRsnPg7EJe5CQAT1VIYm6Is3f5xaO+xC13
         4bv6tx3+1mWL4ZCm9NN/RrFC/xglJ/K5/Jzxksyz4SBQPmIXM8kIMQW2qfoILOismhvQ
         Sjv7gOWfeXGJZAwVmXF/lQNEaSU2rIkR5s7s69pdbt8lDkCQcSZLUy7lwFiYKtPg/iC6
         /Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SffeaccrU8+f6j1f9jdCK0NgU3/4SLjODieMD3LKAyY=;
        b=XYTSp40FJ4/A+TN4jWE1fb7gzNKaH28EkflV0QjEwSIOA6qtLMMXt52Wl6vBhfK+6u
         HQaEuqU0wKSARuTGu38hwSYtKJGq4ajlrIQerefEyTsXBpvuMFP9QWc1Neuhe45ejqGH
         0e9v8hmNzvak32TY/Gj8wgz/1X2rDLo39TCq+rd0I76v5YSIJRb8nVURyXIQZyFNCAVj
         hKHjb/RVllLABUP1kDp9na2KrxZprfTlNgpPvWxw84lSvj8c95hFkpC/bxR9YA94brGk
         r+1M3YqgrzV4QYGutyfeItUCrUSAIlYcvJvWlI2NSwH+byVVA1BvNi6pGCCy+KapFqi0
         xsoA==
X-Gm-Message-State: AOAM5313WmBFaN72/LYSUTODKYCxxZ3vVFTHm/d4ohp/vO4aKu2tGDkv
        n/Nw7Le1BsLVUgwUG+SA84I4gXcmWwsURmNc7+wJMw==
X-Google-Smtp-Source: ABdhPJx+iV40eF/A68R0UDCjCpZgZY8qZnbDttrVnSQY2eWJVdmzJ4227pZH14eKPUtDg7veYJWUKGmib76+T06Wwo4=
X-Received: by 2002:a05:6638:2181:: with SMTP id s1mr81384jaj.66.1622062160212;
 Wed, 26 May 2021 13:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com>
In-Reply-To: <20210526081112.3652290-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 26 May 2021 13:49:08 -0700
Message-ID: <CAGS_qxpCzh7G2Hng7o=+Q_xnVHPxTU54EYoLsXtCsDATSXj-Lw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: Support skipped tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 26, 2021 at 1:11 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> The kunit_mark_skipped() macro marks the current test as "skipped", with
> the provided reason. The kunit_skip() macro will mark the test as
> skipped, and abort the test.
>
> The TAP specification supports this "SKIP directive" as a comment after
> the "ok" / "not ok" for a test. See the "Directives" section of the TAP
> spec for details:
> https://testanything.org/tap-specification.html#directives
>
> The 'success' field for KUnit tests is replaced with a kunit_status
> enum, which can be SUCCESS, FAILURE, or SKIPPED, combined with a
> 'status_comment' containing information on why a test was skipped.
>
> A new 'kunit_status' test suite is added to test this.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

This is pretty exciting to see.
Some minor nits below.


> ---
> This change depends on the assertion typechecking fix here:
> https://lore.kernel.org/linux-kselftest/20210513193204.816681-1-davidgow@google.com/
> Only the first two patches in the series are required.
>
> This is the long-awaited follow-up to the skip tests RFC:
> https://lore.kernel.org/linux-kselftest/20200513042956.109987-1-davidgow@google.com/
>
> There are quite a few changes since that version, principally:
> - A kunit_status enum is now used, with SKIPPED a distinct state
> - The kunit_mark_skipped() and kunit_skip() macros now take printf-style
>   format strings.
> - There is now a kunit_status test suite providing basic tests of this
>   functionality.
> - The kunit_tool changes have been split into a separate commit.
> - The example skipped tests have been expanded an moved to their own
>   suite, which is not enabled by KUNIT_ALL_TESTS.
> - A number of other fixes and changes here and there.
>
> Cheers,
> -- David
>
>  include/kunit/test.h   | 68 ++++++++++++++++++++++++++++++++++++++----
>  lib/kunit/kunit-test.c | 42 +++++++++++++++++++++++++-
>  lib/kunit/test.c       | 51 ++++++++++++++++++-------------
>  3 files changed, 134 insertions(+), 27 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b68c61348121..40b536da027e 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -105,6 +105,18 @@ struct kunit;
>  #define KUNIT_SUBTEST_INDENT           "    "
>  #define KUNIT_SUBSUBTEST_INDENT                "        "
>
> +/**
> + * enum kunit_status - Type of result for a test or test suite
> + * @KUNIT_SUCCESS: Denotes the test suite has not failed nor been skipped
> + * @KUNIT_FAILURE: Denotes the test has failed.
> + * @KUNIT_SKIPPED: Denotes the test has been skipped.
> + */
> +enum kunit_status {
> +       KUNIT_SUCCESS,
> +       KUNIT_FAILURE,
> +       KUNIT_SKIPPED,
> +};
> +
>  /**
>   * struct kunit_case - represents an individual test case.
>   *
> @@ -148,13 +160,20 @@ struct kunit_case {
>         const void* (*generate_params)(const void *prev, char *desc);
>
>         /* private: internal use only. */
> -       bool success;
> +       enum kunit_status status;
>         char *log;
>  };
>
> -static inline char *kunit_status_to_string(bool status)
> +static inline char *kunit_status_to_string(enum kunit_status status)

nit: I personally would think this maps SKIPPED => "SKIPPED", etc.
(If I didn't know all that logic lived in kunit tool).

I don't have any replacement names to suggest that I'm fully happy
with, however.
kunit_status_to_tap_str(), kunit_status_to_ok_notok(), eh.

>  {
> -       return status ? "ok" : "not ok";
> +       switch (status) {
> +       case KUNIT_SKIPPED:
> +       case KUNIT_SUCCESS:
> +               return "ok";
> +       case KUNIT_FAILURE:
> +               return "not ok";
> +       }
> +       return "invalid";
>  }
>
>  /**
> @@ -212,6 +231,7 @@ struct kunit_suite {
>         struct kunit_case *test_cases;
>
>         /* private: internal use only */
> +       char status_comment[256];
>         struct dentry *debugfs;
>         char *log;
>  };
> @@ -245,19 +265,21 @@ struct kunit {
>          * be read after the test case finishes once all threads associated
>          * with the test case have terminated.
>          */
> -       bool success; /* Read only after test_case finishes! */
>         spinlock_t lock; /* Guards all mutable test state. */
> +       enum kunit_status status; /* Read only after test_case finishes! */
>         /*
>          * Because resources is a list that may be updated multiple times (with
>          * new resources) from any thread associated with a test case, we must
>          * protect it with some type of lock.
>          */
>         struct list_head resources; /* Protected by lock. */
> +
> +       char status_comment[256];
>  };
>
>  static inline void kunit_set_failure(struct kunit *test)
>  {
> -       WRITE_ONCE(test->success, false);
> +       WRITE_ONCE(test->status, KUNIT_FAILURE);
>  }
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
> @@ -348,7 +370,7 @@ static inline int kunit_run_all_tests(void)
>  #define kunit_suite_for_each_test_case(suite, test_case)               \
>         for (test_case = suite->test_cases; test_case->run_case; test_case++)
>
> -bool kunit_suite_has_succeeded(struct kunit_suite *suite);
> +enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite);
>
>  /*
>   * Like kunit_alloc_resource() below, but returns the struct kunit_resource
> @@ -612,6 +634,40 @@ void kunit_cleanup(struct kunit *test);
>
>  void kunit_log_append(char *log, const char *fmt, ...);
>
> +/**
> + * kunit_mark_skipped() - Marks @test_or_suite as skipped
> + *
> + * @test_or_suite: The test context object.
> + * @fmt:  A printk() style format string.
> + *
> + * Marks the test as skipped. @fmt is given output as the test status
> + * comment, typically the reason the test was skipped.
> + *
> + * Test execution continues after kunit_mark_skipped() is called.
> + */
> +#define kunit_mark_skipped(test_or_suite, fmt, ...)                    \
> +       do {                                                            \
> +               WRITE_ONCE((test_or_suite)->status, KUNIT_SKIPPED);     \
> +               scnprintf((test_or_suite)->status_comment, 256, fmt, ##__VA_ARGS__); \
> +       } while (0)
> +
> +/**
> + * kunit_skip() - Marks @test_or_suite as skipped
> + *
> + * @test_or_suite: The test context object.
> + * @fmt:  A printk() style format string.
> + *
> + * Skips the test. @fmt is given output as the test status
> + * comment, typically the reason the test was skipped.
> + *
> + * Test execution is halted after kunit_skip() is called.
> + */
> +#define kunit_skip(test_or_suite, fmt, ...)                            \
> +       do {                                                            \
> +               kunit_mark_skipped((test_or_suite), fmt, ##__VA_ARGS__);\
> +               kunit_try_catch_throw(&((test_or_suite)->try_catch));   \
> +       } while (0)
> +
>  /*
>   * printk and log to per-test or per-suite log buffer.  Logging only done
>   * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 69f902440a0e..d69efcbed624 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -437,7 +437,47 @@ static void kunit_log_test(struct kunit *test)
>  #endif
>  }
>
> +static void kunit_status_set_failure_test(struct kunit *test)
> +{
> +       struct kunit fake;
> +
> +       kunit_init_test(&fake, "fake test", NULL);
> +
> +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_SUCCESS);
> +       kunit_set_failure(&fake);
> +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAILURE);
> +}
> +
> +static void kunit_status_mark_skipped_test(struct kunit *test)
> +{
> +       struct kunit fake;
> +
> +       kunit_init_test(&fake, "fake test", NULL);
> +
> +       /* Before: Should be SUCCESS with no comment. */
> +       KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
> +       KUNIT_EXPECT_STREQ(test, fake.status_comment, "");
> +
> +       /* Mark the test as skipped. */
> +       kunit_mark_skipped(&fake, "Accepts format string: %s", "YES");
> +
> +       /* After: Should be SKIPPED with our comment. */
> +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_SKIPPED);
> +       KUNIT_EXPECT_STREQ(test, fake.status_comment, "Accepts format string: YES");
> +}
> +
> +static struct kunit_case kunit_status_test_cases[] = {
> +       KUNIT_CASE(kunit_status_set_failure_test),
> +       KUNIT_CASE(kunit_status_mark_skipped_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_status_test_suite = {
> +       .name = "kunit_status",
> +       .test_cases = kunit_status_test_cases,
> +};
> +
>  kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
> -                 &kunit_log_test_suite);
> +                 &kunit_log_test_suite, &kunit_status_test_suite);
>
>  MODULE_LICENSE("GPL v2");
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 2f6cc0123232..0ee07705d2b0 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -98,12 +98,14 @@ static void kunit_print_subtest_start(struct kunit_suite *suite)
>
>  static void kunit_print_ok_not_ok(void *test_or_suite,
>                                   bool is_test,
> -                                 bool is_ok,
> +                                 enum kunit_status status,
>                                   size_t test_number,
> -                                 const char *description)
> +                                 const char *description,
> +                                 const char *directive)
>  {
>         struct kunit_suite *suite = is_test ? NULL : test_or_suite;
>         struct kunit *test = is_test ? test_or_suite : NULL;
> +       const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP " : "";
>
>         /*
>          * We do not log the test suite results as doing so would
> @@ -114,25 +116,31 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>          * representation.
>          */
>         if (suite)
> -               pr_info("%s %zd - %s\n",
> -                       kunit_status_to_string(is_ok),
> -                       test_number, description);
> +               pr_info("%s %zd - %s%s%s\n",
> +                       kunit_status_to_string(status),
> +                       test_number, description,
> +                       directive_header, directive ? directive : "");
>         else
> -               kunit_log(KERN_INFO, test, KUNIT_SUBTEST_INDENT "%s %zd - %s",

Hmm, why not kunit_info(test, ...)?

> -                         kunit_status_to_string(is_ok),
> -                         test_number, description);
> +               kunit_log(KERN_INFO, test,
> +                         KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
> +                         kunit_status_to_string(status),
> +                         test_number, description,
> +                         directive_header, directive ? directive : "");
>  }
>
> -bool kunit_suite_has_succeeded(struct kunit_suite *suite)
> +enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
>  {
>         const struct kunit_case *test_case;
> +       enum kunit_status status = KUNIT_SKIPPED;
>
>         kunit_suite_for_each_test_case(suite, test_case) {
> -               if (!test_case->success)
> -                       return false;
> +               if (test_case->status == KUNIT_FAILURE)
> +                       return KUNIT_FAILURE;
> +               else if (test_case->status == KUNIT_SUCCESS)
> +                       status = KUNIT_SUCCESS;
>         }
>
> -       return true;
> +       return status;
>  }
>  EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
>
> @@ -143,7 +151,8 @@ static void kunit_print_subtest_end(struct kunit_suite *suite)
>         kunit_print_ok_not_ok((void *)suite, false,
>                               kunit_suite_has_succeeded(suite),
>                               kunit_suite_counter++,
> -                             suite->name);
> +                             suite->name,
> +                             suite->status_comment);
>  }
>
>  unsigned int kunit_test_case_num(struct kunit_suite *suite,
> @@ -252,7 +261,8 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
>         test->log = log;
>         if (test->log)
>                 test->log[0] = '\0';
> -       test->success = true;
> +       test->status = KUNIT_SUCCESS;
> +       test->status_comment[0] = '\0';
>  }
>  EXPORT_SYMBOL_GPL(kunit_init_test);
>
> @@ -376,7 +386,8 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>         context.test_case = test_case;
>         kunit_try_catch_run(try_catch, &context);
>
> -       test_case->success = test->success;
> +       test_case->status = test->status;
> +
>  }
>
>  int kunit_run_tests(struct kunit_suite *suite)
> @@ -388,7 +399,6 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>         kunit_suite_for_each_test_case(suite, test_case) {
>                 struct kunit test = { .param_value = NULL, .param_index = 0 };
> -               bool test_success = true;
>
>                 if (test_case->generate_params) {
>                         /* Get initial param. */
> @@ -398,7 +408,6 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                 do {
>                         kunit_run_case_catch_errors(suite, test_case, &test);
> -                       test_success &= test_case->success;
>
>                         if (test_case->generate_params) {
>                                 if (param_desc[0] == '\0') {
> @@ -410,7 +419,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                           KUNIT_SUBTEST_INDENT
>                                           "# %s: %s %d - %s",
>                                           test_case->name,
> -                                         kunit_status_to_string(test.success),
> +                                         kunit_status_to_string(test.status),
>                                           test.param_index + 1, param_desc);
>
>                                 /* Get next param. */
> @@ -420,9 +429,10 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         }
>                 } while (test.param_value);
>
> -               kunit_print_ok_not_ok(&test, true, test_success,
> +               kunit_print_ok_not_ok(&test, true, test_case->status,
>                                       kunit_test_case_num(suite, test_case),
> -                                     test_case->name);
> +                                     test_case->name,
> +                                     test.status_comment);
>         }
>
>         kunit_print_subtest_end(suite);
> @@ -434,6 +444,7 @@ EXPORT_SYMBOL_GPL(kunit_run_tests);
>  static void kunit_init_suite(struct kunit_suite *suite)
>  {
>         kunit_debugfs_create_suite(suite);
> +       suite->status_comment[0] = '\0';
>  }
>
>  int __kunit_test_suites_init(struct kunit_suite * const * const suites)
> --
> 2.31.1.818.g46aad6cb9e-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210526081112.3652290-1-davidgow%40google.com.
