Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFCC39296A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 10:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhE0IXc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 May 2021 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbhE0IXb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 May 2021 04:23:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF99C061763
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 01:21:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so1966670wmc.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Yl6M9+Wv20DMyGQbKMyOFV8IPBXoGGkukL8lC0ZqBw=;
        b=fUDRGD7slioaHdtXM8R3baID7FpI0u2ItwlGTX320OC6YJs1KcEoCQPl1MyC2iajUp
         UxLZt63PXtuRPsd2okEkVoy/YUw+18DB2ZkqOnBfTbMrgS1iQpe/fZDsuByR0dl2K08H
         VaBc52eci1A+dqvBEx/cHrqTiYNBNKIDoGNGO025phWvcsVakfCmLEKcAxh8d068yWIO
         rL7n9FDr1hkef4O/pxQhUTzcZHM9v2g1HDlBKOnmlN6v09NXkMUEpsyUdRoZFm6Qspee
         OcesocEX3VquaPXmwMaL+xRSzMk6/qdFe86jJerPGl8XEzK1h63eAmKLzfZgwSkQGtFt
         R+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Yl6M9+Wv20DMyGQbKMyOFV8IPBXoGGkukL8lC0ZqBw=;
        b=nWyH2OYQA1BqgGO0yXMxkTkX0Sg+BtB4TTTRyLvmrXzMFJFq/5XnTrrrsa9xMGd875
         GL5QcSIM4ztX2gWO7y8vGMc2ie3Mq9KpyH+4WXH52BvmXKJo0KtJwftEPFQYVcuHitFI
         M2Pt5msrvOJr3phIAskUNB2khd0ZwMymbXo0wcmt9NEIC9DVv+D6UoEujkDU1cOErQRZ
         l5VyxrwDIKiSkKemT6No+cmL72O+hEWaNeekvnsAkKRLBaS7DurQOsOxMzIT4ezzGJuO
         eoyloJYNGWVAIQYFRebay/5ooeBg1bN1DcfiamjngTxHppPaDVEjHX0HSHRUhkuDhQac
         YGUQ==
X-Gm-Message-State: AOAM533zeMA8UvEmboDwbMDYoQBM6P22nD3mqDLM0XTZN/LHUdg/RNYX
        eGmJJBRzoLJOKP9qvrK4bIuFWnrQdLlE4ivFPLaip+6NB8EJDg==
X-Google-Smtp-Source: ABdhPJxhZ1vcoYigGPyJRuIHAp0Dle1+yjRWlnZz0YpPJE4OKrXLfonKjooW7MSUffOZjwV2MZRmno5dPbRtabDYnns=
X-Received: by 2002:a1c:cc17:: with SMTP id h23mr2146354wmb.129.1622103715879;
 Thu, 27 May 2021 01:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com> <CAGS_qxpCzh7G2Hng7o=+Q_xnVHPxTU54EYoLsXtCsDATSXj-Lw@mail.gmail.com>
In-Reply-To: <CAGS_qxpCzh7G2Hng7o=+Q_xnVHPxTU54EYoLsXtCsDATSXj-Lw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 May 2021 16:21:44 +0800
Message-ID: <CABVgOS=+3pFxv68Fo3BgmgT-6S4-61HY_KaHM2GYhYv2G8pvnA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: Support skipped tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ccaf2b05c34b7347"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000ccaf2b05c34b7347
Content-Type: text/plain; charset="UTF-8"

On Thu, May 27, 2021 at 4:49 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, May 26, 2021 at 1:11 AM 'David Gow' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > The kunit_mark_skipped() macro marks the current test as "skipped", with
> > the provided reason. The kunit_skip() macro will mark the test as
> > skipped, and abort the test.
> >
> > The TAP specification supports this "SKIP directive" as a comment after
> > the "ok" / "not ok" for a test. See the "Directives" section of the TAP
> > spec for details:
> > https://testanything.org/tap-specification.html#directives
> >
> > The 'success' field for KUnit tests is replaced with a kunit_status
> > enum, which can be SUCCESS, FAILURE, or SKIPPED, combined with a
> > 'status_comment' containing information on why a test was skipped.
> >
> > A new 'kunit_status' test suite is added to test this.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> This is pretty exciting to see.
> Some minor nits below.
>
>

Thanks: I'll take these suggestions on board for v2.

> > ---
> > This change depends on the assertion typechecking fix here:
> > https://lore.kernel.org/linux-kselftest/20210513193204.816681-1-davidgow@google.com/
> > Only the first two patches in the series are required.
> >
> > This is the long-awaited follow-up to the skip tests RFC:
> > https://lore.kernel.org/linux-kselftest/20200513042956.109987-1-davidgow@google.com/
> >
> > There are quite a few changes since that version, principally:
> > - A kunit_status enum is now used, with SKIPPED a distinct state
> > - The kunit_mark_skipped() and kunit_skip() macros now take printf-style
> >   format strings.
> > - There is now a kunit_status test suite providing basic tests of this
> >   functionality.
> > - The kunit_tool changes have been split into a separate commit.
> > - The example skipped tests have been expanded an moved to their own
> >   suite, which is not enabled by KUNIT_ALL_TESTS.
> > - A number of other fixes and changes here and there.
> >
> > Cheers,
> > -- David
> >
> >  include/kunit/test.h   | 68 ++++++++++++++++++++++++++++++++++++++----
> >  lib/kunit/kunit-test.c | 42 +++++++++++++++++++++++++-
> >  lib/kunit/test.c       | 51 ++++++++++++++++++-------------
> >  3 files changed, 134 insertions(+), 27 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index b68c61348121..40b536da027e 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -105,6 +105,18 @@ struct kunit;
> >  #define KUNIT_SUBTEST_INDENT           "    "
> >  #define KUNIT_SUBSUBTEST_INDENT                "        "
> >
> > +/**
> > + * enum kunit_status - Type of result for a test or test suite
> > + * @KUNIT_SUCCESS: Denotes the test suite has not failed nor been skipped
> > + * @KUNIT_FAILURE: Denotes the test has failed.
> > + * @KUNIT_SKIPPED: Denotes the test has been skipped.
> > + */
> > +enum kunit_status {
> > +       KUNIT_SUCCESS,
> > +       KUNIT_FAILURE,
> > +       KUNIT_SKIPPED,
> > +};
> > +
> >  /**
> >   * struct kunit_case - represents an individual test case.
> >   *
> > @@ -148,13 +160,20 @@ struct kunit_case {
> >         const void* (*generate_params)(const void *prev, char *desc);
> >
> >         /* private: internal use only. */
> > -       bool success;
> > +       enum kunit_status status;
> >         char *log;
> >  };
> >
> > -static inline char *kunit_status_to_string(bool status)
> > +static inline char *kunit_status_to_string(enum kunit_status status)
>
> nit: I personally would think this maps SKIPPED => "SKIPPED", etc.
> (If I didn't know all that logic lived in kunit tool).
>
> I don't have any replacement names to suggest that I'm fully happy
> with, however.
> kunit_status_to_tap_str(), kunit_status_to_ok_notok(), eh.
>

Yeah: I kept the existing names for these functions, which which
worked well when it was just a bool.

The TAP spec seems to just call this "ok/not ok", and given we already
have kunit_print_okay_not_ok(), kunit_status_to_ok_not_ok() seems the
best of those options.

> >  {
> > -       return status ? "ok" : "not ok";
> > +       switch (status) {
> > +       case KUNIT_SKIPPED:
> > +       case KUNIT_SUCCESS:
> > +               return "ok";
> > +       case KUNIT_FAILURE:
> > +               return "not ok";
> > +       }
> > +       return "invalid";
> >  }
> >
> >  /**
> > @@ -212,6 +231,7 @@ struct kunit_suite {
> >         struct kunit_case *test_cases;
> >
> >         /* private: internal use only */
> > +       char status_comment[256];
> >         struct dentry *debugfs;
> >         char *log;
> >  };
> > @@ -245,19 +265,21 @@ struct kunit {
> >          * be read after the test case finishes once all threads associated
> >          * with the test case have terminated.
> >          */
> > -       bool success; /* Read only after test_case finishes! */
> >         spinlock_t lock; /* Guards all mutable test state. */
> > +       enum kunit_status status; /* Read only after test_case finishes! */
> >         /*
> >          * Because resources is a list that may be updated multiple times (with
> >          * new resources) from any thread associated with a test case, we must
> >          * protect it with some type of lock.
> >          */
> >         struct list_head resources; /* Protected by lock. */
> > +
> > +       char status_comment[256];
> >  };
> >
> >  static inline void kunit_set_failure(struct kunit *test)
> >  {
> > -       WRITE_ONCE(test->success, false);
> > +       WRITE_ONCE(test->status, KUNIT_FAILURE);
> >  }
> >
> >  void kunit_init_test(struct kunit *test, const char *name, char *log);
> > @@ -348,7 +370,7 @@ static inline int kunit_run_all_tests(void)
> >  #define kunit_suite_for_each_test_case(suite, test_case)               \
> >         for (test_case = suite->test_cases; test_case->run_case; test_case++)
> >
> > -bool kunit_suite_has_succeeded(struct kunit_suite *suite);
> > +enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite);
> >
> >  /*
> >   * Like kunit_alloc_resource() below, but returns the struct kunit_resource
> > @@ -612,6 +634,40 @@ void kunit_cleanup(struct kunit *test);
> >
> >  void kunit_log_append(char *log, const char *fmt, ...);
> >
> > +/**
> > + * kunit_mark_skipped() - Marks @test_or_suite as skipped
> > + *
> > + * @test_or_suite: The test context object.
> > + * @fmt:  A printk() style format string.
> > + *
> > + * Marks the test as skipped. @fmt is given output as the test status
> > + * comment, typically the reason the test was skipped.
> > + *
> > + * Test execution continues after kunit_mark_skipped() is called.
> > + */
> > +#define kunit_mark_skipped(test_or_suite, fmt, ...)                    \
> > +       do {                                                            \
> > +               WRITE_ONCE((test_or_suite)->status, KUNIT_SKIPPED);     \
> > +               scnprintf((test_or_suite)->status_comment, 256, fmt, ##__VA_ARGS__); \
> > +       } while (0)
> > +
> > +/**
> > + * kunit_skip() - Marks @test_or_suite as skipped
> > + *
> > + * @test_or_suite: The test context object.
> > + * @fmt:  A printk() style format string.
> > + *
> > + * Skips the test. @fmt is given output as the test status
> > + * comment, typically the reason the test was skipped.
> > + *
> > + * Test execution is halted after kunit_skip() is called.
> > + */
> > +#define kunit_skip(test_or_suite, fmt, ...)                            \
> > +       do {                                                            \
> > +               kunit_mark_skipped((test_or_suite), fmt, ##__VA_ARGS__);\
> > +               kunit_try_catch_throw(&((test_or_suite)->try_catch));   \
> > +       } while (0)
> > +
> >  /*
> >   * printk and log to per-test or per-suite log buffer.  Logging only done
> >   * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
> > diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> > index 69f902440a0e..d69efcbed624 100644
> > --- a/lib/kunit/kunit-test.c
> > +++ b/lib/kunit/kunit-test.c
> > @@ -437,7 +437,47 @@ static void kunit_log_test(struct kunit *test)
> >  #endif
> >  }
> >
> > +static void kunit_status_set_failure_test(struct kunit *test)
> > +{
> > +       struct kunit fake;
> > +
> > +       kunit_init_test(&fake, "fake test", NULL);
> > +
> > +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_SUCCESS);
> > +       kunit_set_failure(&fake);
> > +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAILURE);
> > +}
> > +
> > +static void kunit_status_mark_skipped_test(struct kunit *test)
> > +{
> > +       struct kunit fake;
> > +
> > +       kunit_init_test(&fake, "fake test", NULL);
> > +
> > +       /* Before: Should be SUCCESS with no comment. */
> > +       KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
> > +       KUNIT_EXPECT_STREQ(test, fake.status_comment, "");
> > +
> > +       /* Mark the test as skipped. */
> > +       kunit_mark_skipped(&fake, "Accepts format string: %s", "YES");
> > +
> > +       /* After: Should be SKIPPED with our comment. */
> > +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_SKIPPED);
> > +       KUNIT_EXPECT_STREQ(test, fake.status_comment, "Accepts format string: YES");
> > +}
> > +
> > +static struct kunit_case kunit_status_test_cases[] = {
> > +       KUNIT_CASE(kunit_status_set_failure_test),
> > +       KUNIT_CASE(kunit_status_mark_skipped_test),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite kunit_status_test_suite = {
> > +       .name = "kunit_status",
> > +       .test_cases = kunit_status_test_cases,
> > +};
> > +
> >  kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
> > -                 &kunit_log_test_suite);
> > +                 &kunit_log_test_suite, &kunit_status_test_suite);
> >
> >  MODULE_LICENSE("GPL v2");
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 2f6cc0123232..0ee07705d2b0 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -98,12 +98,14 @@ static void kunit_print_subtest_start(struct kunit_suite *suite)
> >
> >  static void kunit_print_ok_not_ok(void *test_or_suite,
> >                                   bool is_test,
> > -                                 bool is_ok,
> > +                                 enum kunit_status status,
> >                                   size_t test_number,
> > -                                 const char *description)
> > +                                 const char *description,
> > +                                 const char *directive)
> >  {
> >         struct kunit_suite *suite = is_test ? NULL : test_or_suite;
> >         struct kunit *test = is_test ? test_or_suite : NULL;
> > +       const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP " : "";
> >
> >         /*
> >          * We do not log the test suite results as doing so would
> > @@ -114,25 +116,31 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
> >          * representation.
> >          */
> >         if (suite)
> > -               pr_info("%s %zd - %s\n",
> > -                       kunit_status_to_string(is_ok),
> > -                       test_number, description);
> > +               pr_info("%s %zd - %s%s%s\n",
> > +                       kunit_status_to_string(status),
> > +                       test_number, description,
> > +                       directive_header, directive ? directive : "");
> >         else
> > -               kunit_log(KERN_INFO, test, KUNIT_SUBTEST_INDENT "%s %zd - %s",
>
> Hmm, why not kunit_info(test, ...)?
>

No reason: it was kunit_log() originally, and I didn't change it. I
can replace this for v2 if you prefer.


> > -                         kunit_status_to_string(is_ok),
> > -                         test_number, description);
> > +               kunit_log(KERN_INFO, test,
> > +                         KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
> > +                         kunit_status_to_string(status),
> > +                         test_number, description,
> > +                         directive_header, directive ? directive : "");
> >  }
> >
> > -bool kunit_suite_has_succeeded(struct kunit_suite *suite)
> > +enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
> >  {
> >         const struct kunit_case *test_case;
> > +       enum kunit_status status = KUNIT_SKIPPED;
> >
> >         kunit_suite_for_each_test_case(suite, test_case) {
> > -               if (!test_case->success)
> > -                       return false;
> > +               if (test_case->status == KUNIT_FAILURE)
> > +                       return KUNIT_FAILURE;
> > +               else if (test_case->status == KUNIT_SUCCESS)
> > +                       status = KUNIT_SUCCESS;
> >         }
> >
> > -       return true;
> > +       return status;
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
> >
> > @@ -143,7 +151,8 @@ static void kunit_print_subtest_end(struct kunit_suite *suite)
> >         kunit_print_ok_not_ok((void *)suite, false,
> >                               kunit_suite_has_succeeded(suite),
> >                               kunit_suite_counter++,
> > -                             suite->name);
> > +                             suite->name,
> > +                             suite->status_comment);
> >  }
> >
> >  unsigned int kunit_test_case_num(struct kunit_suite *suite,
> > @@ -252,7 +261,8 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
> >         test->log = log;
> >         if (test->log)
> >                 test->log[0] = '\0';
> > -       test->success = true;
> > +       test->status = KUNIT_SUCCESS;
> > +       test->status_comment[0] = '\0';
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_init_test);
> >
> > @@ -376,7 +386,8 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
> >         context.test_case = test_case;
> >         kunit_try_catch_run(try_catch, &context);
> >
> > -       test_case->success = test->success;
> > +       test_case->status = test->status;
> > +
> >  }
> >
> >  int kunit_run_tests(struct kunit_suite *suite)
> > @@ -388,7 +399,6 @@ int kunit_run_tests(struct kunit_suite *suite)
> >
> >         kunit_suite_for_each_test_case(suite, test_case) {
> >                 struct kunit test = { .param_value = NULL, .param_index = 0 };
> > -               bool test_success = true;
> >
> >                 if (test_case->generate_params) {
> >                         /* Get initial param. */
> > @@ -398,7 +408,6 @@ int kunit_run_tests(struct kunit_suite *suite)
> >
> >                 do {
> >                         kunit_run_case_catch_errors(suite, test_case, &test);
> > -                       test_success &= test_case->success;
> >
> >                         if (test_case->generate_params) {
> >                                 if (param_desc[0] == '\0') {
> > @@ -410,7 +419,7 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                                           KUNIT_SUBTEST_INDENT
> >                                           "# %s: %s %d - %s",
> >                                           test_case->name,
> > -                                         kunit_status_to_string(test.success),
> > +                                         kunit_status_to_string(test.status),
> >                                           test.param_index + 1, param_desc);
> >
> >                                 /* Get next param. */
> > @@ -420,9 +429,10 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                         }
> >                 } while (test.param_value);
> >
> > -               kunit_print_ok_not_ok(&test, true, test_success,
> > +               kunit_print_ok_not_ok(&test, true, test_case->status,
> >                                       kunit_test_case_num(suite, test_case),
> > -                                     test_case->name);
> > +                                     test_case->name,
> > +                                     test.status_comment);
> >         }
> >
> >         kunit_print_subtest_end(suite);
> > @@ -434,6 +444,7 @@ EXPORT_SYMBOL_GPL(kunit_run_tests);
> >  static void kunit_init_suite(struct kunit_suite *suite)
> >  {
> >         kunit_debugfs_create_suite(suite);
> > +       suite->status_comment[0] = '\0';
> >  }
> >
> >  int __kunit_test_suites_init(struct kunit_suite * const * const suites)
> > --
> > 2.31.1.818.g46aad6cb9e-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210526081112.3652290-1-davidgow%40google.com.

--000000000000ccaf2b05c34b7347
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnAYJKoZIhvcNAQcCoIIPjTCCD4kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz2MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
ILbFHw0h01NI0v+AeczGMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCNr3LBERPjVctGdVEb
/hN6/N6F2eUWxZLSUbuV7fOle0OvI8xz2AUBrOYQLp94ox9LqmsATKPsBl2uiktsvfs/AXNMcmOz
qsWHzfqp4XlvNgQsC/UyUMWxZoEyTDfTSat09yQjkFJ7viwzrqqscmTx5oTZz8TPRt0mbxwx3qry
wDzYxadSUQXNpNnfi0FBDYUUfuCLFWPsPsAXmgh483u0RbNik9OY/ozNq1Gvg/U0jQOlJf2IiKbE
kUL5Vq8gDDu6bETx5bHmRmSjHhwo7eVbxywczpzdFsU3dauZ3BzqhLy2pRGGzZybSH/3mf7o9y15
gmRHE7WzPLrsULHG/TM8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABm/kO+4pd09krN7Fjk8ypMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCgQS7U
ivxmqS7dKPyUlVh/fTlbk8ot/8VAp5GVACuh1jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA1MjcwODIxNTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAlkWYROR2ac6nMpCy4GRfGizW
YrdOKJvO5vgk1K5psI82SjOYu4/w12iOYxVaVqFBnOx8p24kdIzDzmI2W2W7jMcCEGdMT77ZZ/dq
OukIVkqj+kGA9Ngm3XBIQVUml49IZq1Tp+2QTH7UbSx255sy7WDIMRhIJsy+gOrzu8XdMPjBEPNL
Rv06zYe6wr3IAXgTCLJQVpIClJ/ZhROT31JfWCsETCX8BETTu47bgKG4p4zo/p70GP7KwYa5XKus
0GzuNVhSMslWfUTmuMdVROJQ7Ma8N5odm2kqGUGLioYmeLBNRxAoY0DD9JGq1BSUYjldjRYRga4i
/vfhUGd6GV2e3g==
--000000000000ccaf2b05c34b7347--
