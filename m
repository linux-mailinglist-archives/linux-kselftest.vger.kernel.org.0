Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5783DFC3F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 09:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhHDHnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 03:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbhHDHnm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 03:43:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EB5C0613D5;
        Wed,  4 Aug 2021 00:43:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso2405136pjo.1;
        Wed, 04 Aug 2021 00:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fOMj2y0rLoQwuJe+Zd0XQ3vetH0lhSEGRdRxLTN6n4=;
        b=aDdVS32fQutSKA7d394oca5HUswP524QdPoW6/jxsBni1TptLWotV6/S0WmhaXe6oc
         yyojOezJKnhOTbZA6VBcrES13AfKVM989HbJaea1AP8sMk9jBRnCZH9pMzHx3AgGYt7D
         R+OyBI0+iUPqUISoAe+vBDvliTz62QjkXaEbIY9iJKLEF+0tw1Hqk3gbv4p37LnVmfzE
         Q9tws5+THETgb+/u45TFbKFT/ka6R0DRwpAE1ZpAVmUkXGQOSuq5uBrAU/+Hn7QqdWgx
         BZKfE/iN2p3iLp8Wn1lV7/uWrhr6V+3U0EAxqpJAbdjOGmxiJDG2iWVj8VifW/wYGrqL
         usQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fOMj2y0rLoQwuJe+Zd0XQ3vetH0lhSEGRdRxLTN6n4=;
        b=jpO7xBp3ERQIbbiLUh0oMnCnWZjNKQMFbfYUYD152bc7H6N+pmA1PIK+DRnl1FmvwA
         wOF2YUl9rHITzvnC8zldRL3cYwW5w7rXOMTfb+1mg6wRJFKHsyfPdKYSu/t1tI4oxqYl
         vW20+wC2MIOwoy/YA9hQk5QjxTyEyviPtEwgbe79zaRbbt4Fzqh6gb1oBnS2akuCN/d1
         CJNzWT2oWgllHhVH96rlBDXZBqGXSnmqyZy1TDTGgCY/RqP51mnly/acczOa93bEB7Ub
         2oqVQpsupYRF2Y/XUqPvvT1Yy1+hmV/CvV0rlQjVPWEA5mok0sCePT6wrDZPuHs+1mRH
         UmfQ==
X-Gm-Message-State: AOAM530WR8hucOt8WQCieDUbuSWtYmlSumwXEVHTpUEeB42MjE/dSk/M
        2XSHebkR3AZK9+oXz1vPNfHlniGdFIva14pTYXs=
X-Google-Smtp-Source: ABdhPJxGLlpYN7lmL4AYupBhIsnuG37eJL6mkrjNXg93UHtkx8PfeaO29Or8n6pjApc5bR5hhAK5a5fqg9gnIqxpl2k=
X-Received: by 2002:a17:902:ac90:b029:12c:e7a:c183 with SMTP id
 h16-20020a170902ac90b029012c0e7ac183mr50851plr.21.1628063008750; Wed, 04 Aug
 2021 00:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210804050809.628266-1-davidgow@google.com>
In-Reply-To: <20210804050809.628266-1-davidgow@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Aug 2021 10:42:52 +0300
Message-ID: <CAHp75VeibpVCcQD6VcACM9=AaaG3KWExJ5cS4orXLkFBu4PtXQ@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Print test statistics on failure
To:     David Gow <davidgow@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Cc: Rasmus

On Wed, Aug 4, 2021 at 8:08 AM David Gow <davidgow@google.com> wrote:
>
> When a number of tests fail, it can be useful to get higher-level
> statistics of how many tests are failing (or how many parameters are
> failing in parameterised tests), and in what cases or suites. This is
> already done by some non-KUnit tests, so add support for automatically
> generating these for KUnit tests.
>
> This change adds a 'kunit.stats_enabled' switch which has three values:
> - 0: No stats are printed (current behaviour)
> - 1: Stats are printed only for tests/suites with more than one
>      subtest (new default)
> - 2: Always print test statistics
>
> For parameterised tests, the summary line looks as follows:
> "    # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16"
> For test suites, there are two lines looking like this:
> "# ext4_inode_test: pass:1 fail:0 skip:0 total:1"
> "# Totals: pass:16 fail:0 skip:0 total:16"
>
> The first line gives the number of direct subtests, the second "Totals"
> line is the accumulated sum of all tests and test parameters.
>
> This format is based on the one used by kselftest[1].
>
> [1]: https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/kselftest.h#L109
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> This is the long-awaited v2 of the test statistics patch:
> https://lore.kernel.org/linux-kselftest/20201211072319.533803-1-davidgow@google.com/
>
> It updates the patch to apply on current mainline kernels, takes skipped
> tests into account, changes the output format to better match what
> kselftest uses, and addresses some of the comments from v1.
>
> Please let me know what you think, in particular:
> - Is this sufficient to assuage any worries about porting tests to
>   KUnit?
> - Are we printing too many stats by default: for a lot of existing tests
>   many of them are useless. I'm particuarly curious about the separate
>   "Totals" line, versus the per-suite line -- is that useful? Should it
>   only be printed when the totals differ?
> - Is the output format sufficiently legible for people and/or tools
>   which may want to parse it?
>
> Cheers,
> -- David
>
> Changelog:
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20201211072319.533803-1-davidgow@google.com/
> - Rework to use a new struct kunit_result_stats, with helper functions
>   for adding results, accumulating them over nested structures, etc.
> - Support skipped tests, report them separately from failures and
>   passes.
> - New output format to better match kselftest:
>   - "pass:n fail:n skip:n total:n"
> - Changes to stats_enabled parameter:
>   - Now a module parameter, with description
>   - Default "1" option now prints even when no tests fail.
> - Improved parser fix which doesn't break crashed test detection.
>
> ---
>  lib/kunit/test.c                    | 109 ++++++++++++++++++++++++++++
>  tools/testing/kunit/kunit_parser.py |   2 +-
>  2 files changed, 110 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index d79ecb86ea57..f246b847024e 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -10,6 +10,7 @@
>  #include <kunit/test-bug.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
> +#include <linux/moduleparam.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
>
> @@ -51,6 +52,51 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
>  EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
>  #endif
>
> +/*
> + * KUnit statistic mode:
> + * 0 - disabled
> + * 1 - only when there is more than one subtest
> + * 2 - enabled
> + */
> +static int kunit_stats_enabled = 1;
> +module_param_named(stats_enabled, kunit_stats_enabled, int, 0644);
> +MODULE_PARM_DESC(stats_enabled,
> +                 "Print test stats: never (0), only for multiple subtests (1), or always (2)");
> +
> +struct kunit_result_stats {
> +       unsigned long passed;
> +       unsigned long skipped;
> +       unsigned long failed;
> +       unsigned long total;
> +};
> +
> +static bool kunit_should_print_stats(struct kunit_result_stats stats)
> +{
> +       if (kunit_stats_enabled == 0)
> +               return false;
> +
> +       if (kunit_stats_enabled == 2)
> +               return true;
> +
> +       return (stats.total > 1);
> +}
> +
> +static void kunit_print_test_stats(struct kunit *test,
> +                                  struct kunit_result_stats stats)
> +{
> +       if (!kunit_should_print_stats(stats))
> +               return;
> +
> +       kunit_log(KERN_INFO, test,
> +                 KUNIT_SUBTEST_INDENT
> +                 "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
> +                 test->name,
> +                 stats.passed,
> +                 stats.failed,
> +                 stats.skipped,
> +                 stats.total);
> +}
> +
>  /*
>   * Append formatted message to log, size of which is limited to
>   * KUNIT_LOG_SIZE bytes (including null terminating byte).
> @@ -393,15 +439,69 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>                 test_case->status = KUNIT_SUCCESS;
>  }
>
> +static void kunit_print_suite_stats(struct kunit_suite *suite,
> +                                   struct kunit_result_stats suite_stats,
> +                                   struct kunit_result_stats param_stats)
> +{
> +       if (kunit_should_print_stats(suite_stats)) {
> +               kunit_log(KERN_INFO, suite,
> +                         "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
> +                         suite->name,
> +                         suite_stats.passed,
> +                         suite_stats.failed,
> +                         suite_stats.skipped,
> +                         suite_stats.total);
> +       }
> +
> +       if (kunit_should_print_stats(param_stats)) {
> +               kunit_log(KERN_INFO, suite,
> +                         "# Totals: pass:%lu fail:%lu skip:%lu total:%lu",
> +                         param_stats.passed,
> +                         param_stats.failed,
> +                         param_stats.skipped,
> +                         param_stats.total);
> +       }
> +}
> +
> +static void kunit_update_stats(struct kunit_result_stats *stats,
> +                              enum kunit_status status)
> +{
> +       switch (status) {
> +       case KUNIT_SUCCESS:
> +               stats->passed++;
> +               break;
> +       case KUNIT_SKIPPED:
> +               stats->skipped++;
> +               break;
> +       case KUNIT_FAILURE:
> +               stats->failed++;
> +               break;
> +       }
> +
> +       stats->total++;
> +}
> +
> +static void kunit_accumulate_stats(struct kunit_result_stats *total,
> +                                  struct kunit_result_stats add)
> +{
> +       total->passed += add.passed;
> +       total->skipped += add.skipped;
> +       total->failed += add.failed;
> +       total->total += add.total;
> +}
> +
>  int kunit_run_tests(struct kunit_suite *suite)
>  {
>         char param_desc[KUNIT_PARAM_DESC_SIZE];
>         struct kunit_case *test_case;
> +       struct kunit_result_stats suite_stats = { 0 };
> +       struct kunit_result_stats total_stats = { 0 };
>
>         kunit_print_subtest_start(suite);
>
>         kunit_suite_for_each_test_case(suite, test_case) {
>                 struct kunit test = { .param_value = NULL, .param_index = 0 };
> +               struct kunit_result_stats param_stats = { 0 };
>                 test_case->status = KUNIT_SKIPPED;
>
>                 if (test_case->generate_params) {
> @@ -431,14 +531,23 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                 test.param_value = test_case->generate_params(test.param_value, param_desc);
>                                 test.param_index++;
>                         }
> +
> +                       kunit_update_stats(&param_stats, test.status);
> +
>                 } while (test.param_value);
>
> +               kunit_print_test_stats(&test, param_stats);
> +
>                 kunit_print_ok_not_ok(&test, true, test_case->status,
>                                       kunit_test_case_num(suite, test_case),
>                                       test_case->name,
>                                       test.status_comment);
> +
> +               kunit_update_stats(&suite_stats, test_case->status);
> +               kunit_accumulate_stats(&total_stats, param_stats);
>         }
>
> +       kunit_print_suite_stats(suite, suite_stats, total_stats);
>         kunit_print_subtest_end(suite);
>
>         return 0;
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index b88db3f51dc5..c699f778da06 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -137,7 +137,7 @@ def print_log(log) -> None:
>         for m in log:
>                 print_with_timestamp(m)
>
> -TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
> +TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*# (Subtest:|.*: kunit test case crashed!)).*$')
>
>  def consume_non_diagnostic(lines: LineStream) -> None:
>         while lines and not TAP_ENTRIES.match(lines.peek()):
> --
> 2.32.0.554.ge1b32706d8-goog
>


-- 
With Best Regards,
Andy Shevchenko
