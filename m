Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0341D3BA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 May 2020 21:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgENTEa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 May 2020 15:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729087AbgENSya (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 May 2020 14:54:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD291C061A0C
        for <linux-kselftest@vger.kernel.org>; Thu, 14 May 2020 11:54:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so1544063plr.4
        for <linux-kselftest@vger.kernel.org>; Thu, 14 May 2020 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EwrCg9JwQwemK5iYCzZ6MG84iVCAOzFew5sC8INW9A=;
        b=cwU0T2dMgB4GyP7utbktsfqXpgVi/mm4Y5yuVoeaiPp8qeJwtBSkinEZGCpEino0ol
         nop5Rwe2+Tgs93ZtiL22i14DC7xt9k8CzxWc7KWhsM9oTHWK0j/PzuV1U7SJyaOc81vg
         lp7WtvalVrHUiPjdjPM/ws1js+mm+rORAlqW+HHyt0n2teCMksVhCdNYAZQYzHiOydBC
         sW6ZHxjq6HDi7CoQc6bWtPWy0g5k030rcLAAgnFHtu2fydLHB6hCfxE1kF9o2IBocBpW
         adQE2lcK2ESGigt0aBj6QZCdWd8WBkwklFf2aI6ksGChpHtkskuF4DDezjS4KodxgMgO
         Uhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EwrCg9JwQwemK5iYCzZ6MG84iVCAOzFew5sC8INW9A=;
        b=mHtWjkVFkgtx6JMlPB027Yb0YTdJTO7YjadhnisYV/PA6TKfy8TXjt4h5kc1NFx7zw
         LnQLbmMq2AlyMUcZH9fiMuSXhR9P5WZfZKiCzwp8zxSjSPD+KJniscib+O9VTwffZXzS
         cYhwpUHNp1I1xwszgsxxYZB5STHnKxQ4zL7bpEYLPGABxsUrnDOT4ns26fo+/q1c+upO
         s16b4IG0KV6hnHO543bdWhe7ArV95rCfoleW/8iUfHiLoAR8m8HnmIf85QUJnEa2Gnoo
         o/eIf/sSJTqzYOrm1k0PU8Y8wTCY3cUCkoty+/kp/VRH0fNFrjKbBzbRyPu4eQx3EoBU
         iJXA==
X-Gm-Message-State: AOAM532pYfT4IUek0Aiw3rh6n3J+VB3qz+iMNzVCMCrdWS3cBaVB5VtZ
        +8tYwBn42LioDvGUGmaJDntswNKLymTYTvR+fvCZ+Q==
X-Google-Smtp-Source: ABdhPJwPUg1N8x7No4AjXWAG0cIpa1Gol9Cs4KN02jHsnKzEmT/iQnW+VbdpFJNOkYGMeSytLFSkDXYMc1SlLII1lLs=
X-Received: by 2002:a17:90a:ad49:: with SMTP id w9mr16094033pjv.20.1589482469934;
 Thu, 14 May 2020 11:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200513042956.109987-1-davidgow@google.com>
In-Reply-To: <20200513042956.109987-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 May 2020 11:54:18 -0700
Message-ID: <CAFd5g47auKoQPhCeMHSTMtE_9+fZ6eOHZkojV5j0AX4N4hE_pw@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: Support skipped tests
To:     David Gow <davidgow@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Marco Elver <elver@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 12, 2020 at 9:30 PM David Gow <davidgow@google.com> wrote:
>
> This is a proof-of-concept to support "skipping" tests.
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
> kunit_tool will parse this SKIP directive, and renders skipped tests in
> yellow and counts them. Skipped tests do not affect the result for a
> suite.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Following on from discussions about the KCSAN test[1], which requires a
> multi-core/processor system to make sense, it would be useful for tests
> to be able to mark themselves as "skipped", where tests have runtime
> dependencies which aren't met.
>
> As a proof-of-concept, this patch doesn't implement some things which
> we'd ideally like to have (e.g., non-static "reasons" for skipping the
> test, maybe some SKIP macros akin to the EXPECT and ASSERT ones), and
> the implementation is still pretty hacky, but I though I'd put this out
> there to see if there are any thoughts on the concept in general.
>
> Cheers,
> -- David
>
> [1]: https://lkml.org/lkml/2020/5/5/31
>
>  include/kunit/test.h                | 12 ++++++++++++
>  lib/kunit/kunit-example-test.c      |  7 +++++++
>  lib/kunit/test.c                    | 23 ++++++++++++++++-------
>  tools/testing/kunit/kunit_parser.py | 21 +++++++++++++++++----
>  4 files changed, 52 insertions(+), 11 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9b0c46a6ca1f..7817c5580b2c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -178,6 +178,7 @@ struct kunit_suite {
>         /* private - internal use only */
>         struct dentry *debugfs;
>         char *log;
> +       const char *skip_directive;

Might want to consider protecting this too: see below.

>  };
>
>  /**
> @@ -213,6 +214,8 @@ struct kunit {
>          * protect it with some type of lock.
>          */
>         struct list_head resources; /* Protected by lock. */
> +
> +       const char *skip_directive;

This should probably either be protected by a lock or be WRITE_ONCE;
depending on what happens when you skip a test case multiple times.

>  };
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
> @@ -391,6 +394,15 @@ void kunit_cleanup(struct kunit *test);
>
>  void kunit_log_append(char *log, const char *fmt, ...);
>
> +#define kunit_mark_skipped(test_or_suite, reason)                      \
> +       (test_or_suite)->skip_directive = "SKIP " reason
> +
> +#define kunit_skip(test_or_suite, reason)                              \
> +       do {                                                            \
> +               kunit_mark_skipped(test_or_suite, reason);              \
> +               kunit_try_catch_throw(&((test_or_suite)->try_catch));   \
> +       } while (0)
> +
>  /*
>   * printk and log to per-test or per-suite log buffer.  Logging only done
>   * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index be1164ecc476..998401a61458 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -29,6 +29,12 @@ static void example_simple_test(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, 1 + 1, 2);
>  }
>
> +static void example_skip_test(struct kunit *test)
> +{
> +       kunit_skip(test, "this test should be skipped");

So this raises an interesting question: Is it okay to have a test that
always skips no matter what?

In my mind, what you have done here is basically an integration test
of your feature. It would be equivalent to having a test that always
fails to test that a test failure works correctly. I am certainly not
opposed to such a test existing, but I think it should probably be
separate from the example test, and kunit.py should probably have some
awareness to test the whole pipeline and mark the test as a success
when run as part of testing KUnit.

I am curious what people think about this.

> +       KUNIT_EXPECT_EQ(test, 1 + 1, 2);
> +}
> +
>  /*
>   * This is run once before each test case, see the comment on
>   * example_test_suite for more information.
> @@ -52,6 +58,7 @@ static struct kunit_case example_test_cases[] = {
>          * test suite.
>          */
>         KUNIT_CASE(example_simple_test),
> +       KUNIT_CASE(example_skip_test),
>         {}
>  };
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index ccb2ffad8dcf..84b9be3a8da7 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -79,10 +79,12 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>                                   bool is_test,
>                                   bool is_ok,
>                                   size_t test_number,
> -                                 const char *description)
> +                                 const char *description,
> +                                 const char *directive)
>  {
>         struct kunit_suite *suite = is_test ? NULL : test_or_suite;
>         struct kunit *test = is_test ? test_or_suite : NULL;
> +       const char *directive_header = directive ? " # " : "";
>
>         /*
>          * We do not log the test suite results as doing so would
> @@ -93,13 +95,16 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>          * representation.
>          */
>         if (suite)
> -               pr_info("%s %zd - %s\n",
> +               pr_info("%s %zd - %s%s%s\n",
>                         kunit_status_to_string(is_ok),
> -                       test_number, description);
> +                       test_number, description,
> +                       directive_header, directive ? directive : "");
>         else
> -               kunit_log(KERN_INFO, test, KUNIT_SUBTEST_INDENT "%s %zd - %s",
> +               kunit_log(KERN_INFO, test,
> +                         KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
>                           kunit_status_to_string(is_ok),
> -                         test_number, description);
> +                         test_number, description,
> +                         directive_header, directive ? directive : "");
>  }
>
>  bool kunit_suite_has_succeeded(struct kunit_suite *suite)
> @@ -122,7 +127,8 @@ static void kunit_print_subtest_end(struct kunit_suite *suite)
>         kunit_print_ok_not_ok((void *)suite, false,
>                               kunit_suite_has_succeeded(suite),
>                               kunit_suite_counter++,
> -                             suite->name);
> +                             suite->name,
> +                             suite->skip_directive);
>  }
>
>  unsigned int kunit_test_case_num(struct kunit_suite *suite,
> @@ -232,6 +238,7 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
>         if (test->log)
>                 test->log[0] = '\0';
>         test->success = true;
> +       test->skip_directive = NULL;
>  }
>  EXPORT_SYMBOL_GPL(kunit_init_test);
>
> @@ -357,7 +364,8 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>
>         kunit_print_ok_not_ok(&test, true, test_case->success,
>                               kunit_test_case_num(suite, test_case),
> -                             test_case->name);
> +                             test_case->name,
> +                             test.skip_directive);
>  }
>
>  int kunit_run_tests(struct kunit_suite *suite)
> @@ -378,6 +386,7 @@ EXPORT_SYMBOL_GPL(kunit_run_tests);
>  static void kunit_init_suite(struct kunit_suite *suite)
>  {
>         kunit_debugfs_create_suite(suite);
> +       suite->skip_directive = NULL;
>  }
>
>  int __kunit_test_suites_init(struct kunit_suite **suites)
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 64aac9dcd431..ecfc8ee1da2f 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -43,6 +43,7 @@ class TestCase(object):
>  class TestStatus(Enum):
>         SUCCESS = auto()
>         FAILURE = auto()
> +       SKIPPED = auto()

Since you treat SKIPPED in the kernel as a flag, should we maybe treat
it the same here?

>         TEST_CRASHED = auto()
>         NO_TESTS = auto()
>
> @@ -107,6 +108,8 @@ def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
>
>  OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
>
> +OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP (.*)$')
> +
>  OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
>
>  OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
> @@ -124,6 +127,10 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
>         if match:
>                 test_case.log.append(lines.pop(0))
>                 test_case.name = match.group(2)
> +               skip_match = OK_NOT_OK_SKIP.match(line)
> +               if skip_match:
> +                       test_case.status = TestStatus.SKIPPED
> +                       return True
>                 if test_case.status == TestStatus.TEST_CRASHED:
>                         return True
>                 if match.group(1) == 'ok':
> @@ -190,9 +197,9 @@ def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
>                 return TestStatus.TEST_CRASHED
>         elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
>                 return TestStatus.FAILURE
> -       elif left != TestStatus.SUCCESS:
> +       elif left != TestStatus.SUCCESS and left != TestStatus.SKIPPED:
>                 return left
> -       elif right != TestStatus.SUCCESS:
> +       elif right != TestStatus.SUCCESS and right != TestStatus.SKIPPED:
>                 return right
>         else:
>                 return TestStatus.SUCCESS
> @@ -281,10 +288,13 @@ def parse_run_tests(kernel_output) -> TestResult:
>         total_tests = 0
>         failed_tests = 0
>         crashed_tests = 0
> +       skipped_tests = 0
>         test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
>         for test_suite in test_result.suites:
>                 if test_suite.status == TestStatus.SUCCESS:
>                         print_suite_divider(green('[PASSED] ') + test_suite.name)
> +               elif test_suite.status == TestStatus.SKIPPED:
> +                       print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
>                 elif test_suite.status == TestStatus.TEST_CRASHED:
>                         print_suite_divider(red('[CRASHED] ' + test_suite.name))
>                 else:
> @@ -293,6 +303,9 @@ def parse_run_tests(kernel_output) -> TestResult:
>                         total_tests += 1
>                         if test_case.status == TestStatus.SUCCESS:
>                                 print_with_timestamp(green('[PASSED] ') + test_case.name)
> +                       elif test_case.status == TestStatus.SKIPPED:
> +                               skipped_tests += 1
> +                               print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
>                         elif test_case.status == TestStatus.TEST_CRASHED:
>                                 crashed_tests += 1
>                                 print_with_timestamp(red('[CRASHED] ' + test_case.name))
> @@ -306,6 +319,6 @@ def parse_run_tests(kernel_output) -> TestResult:
>         print_with_timestamp(DIVIDER)
>         fmt = green if test_result.status == TestStatus.SUCCESS else red
>         print_with_timestamp(
> -               fmt('Testing complete. %d tests run. %d failed. %d crashed.' %
> -                   (total_tests, failed_tests, crashed_tests)))
> +               fmt('Testing complete. %d tests run. %d failed. %d crashed. %d skipped.' %
> +                   (total_tests, failed_tests, crashed_tests, skipped_tests)))
>         return test_result

Overall, I am a big fan!

Thanks!
