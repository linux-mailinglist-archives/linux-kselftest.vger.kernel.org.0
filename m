Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71978311878
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 03:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhBFCiv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 21:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhBFCgE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:36:04 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85D4C08ED45
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 15:27:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u15so4362584plf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 15:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pf4F3uuR1gvS1Fcn0xt9kNN+Ve3xAtpGXi3ER1E9C7Y=;
        b=aB107IothZK3ym+vCPrM6h/gftGIUY6FkY+Pb0wWFx5AtC147+H3DZxRw3+qKnbe83
         wVvwfMBFGunoucSMM4ccEFJC1whxNosfn+gXhw83XNaouxoeuDja6BF06uaGV13pBGTE
         zPQikRaK9z4Z+SiQzWpV5S7dENvs6pbvC4TNHk7laA1DLhtYmW1j79YrNeQKNYmPFDw9
         olC2V+GHrEp1+MxtNOjE9rBXhTC0BaU6eTSusLOmrXocr7eN2W9PZWrMohy2ielsEGOI
         JWrW216HSN4/Sww73y2YsDLfa5mLCTxQ8hpiDD9QajQzTE2a34sgEeRdKtH8TUwDUyNn
         bNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pf4F3uuR1gvS1Fcn0xt9kNN+Ve3xAtpGXi3ER1E9C7Y=;
        b=FYpUAtPS+L2spwU5kP7/XFUwmrcvnhWobqq7indPsCfpstJR7i3+6WvQ3Whx4pIead
         ehMkNzursD36QwudF4N68vh+b3qpPccf4H2PynP46LJmJkAJaVzo0zXaV6moH3IsQ0/G
         ITzddTR62RumJj0Y/iVZ0rrQHp7J+RTwN56xZB2jqMUeclWjlRyRQYxwKomVHjdfT0JX
         kPVXNjDw1kz6i0t+rv2zhFVDHc5MVS052n7UtKtnTMEw5FU1rygsvzsOWwBuCJJd1iZg
         AE2STh3cmL5LcHTSLdZmHOvMs6qVKAHApVr2qxfb/nhuMXjVubHSObAjRh7ABtYI+SYO
         SnRw==
X-Gm-Message-State: AOAM5307Xoq1HScFv+dv7sPaY3eeyJBEAu5xYmMlX3HQ4urPu3ulTWUk
        bVmzdjFQV32kmC544HxA2HSwdpCH4s6NwLJzVt6m9w==
X-Google-Smtp-Source: ABdhPJyC573mabAtW9KOH2O+xD4MgFluSedML4EnrbXtULwXen/ZN3QS6AJ60Zn7UVEWF0/UF5E7wTklqYze0+QfXtQ=
X-Received: by 2002:a17:902:f686:b029:de:18c7:41f8 with SMTP id
 l6-20020a170902f686b02900de18c741f8mr6219953plg.65.1612567659118; Fri, 05 Feb
 2021 15:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20201211072319.533803-1-davidgow@google.com>
In-Reply-To: <20201211072319.533803-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Feb 2021 15:27:27 -0800
Message-ID: <CAFd5g473d1dGriVGiWmqY8qSjU7WDJgEb3yFqUjsag-3xFdgjA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Print test statistics on failure
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 11:23 PM David Gow <davidgow@google.com> wrote:
>
> When a number of tests fail, it can be useful to get higher-level
> statistics of how many tests are failing (or how many parameters are
> failing in parameterised tests), and in what cases or suites. This is
> already done by some non-KUnit tests, so add support for automatically
> generating these for KUnit tests.
>
> This change adds a 'kunit_stats_enabled' switch which has three values:
> - 0: No stats are printed (current behaviour)
> - 1: Stats are printed only for tests/suites with more than one
>      subtests, and at least one failure (new default)
> - 2: Always print test statistics
>
> For parameterised tests, the summary line looks as follows:
> "    # inode_test_xtimestamp_decoding: 0 / 16 test parameters failed"
> For test suites, it looks like this:
> "# ext4_inode_test: (0 / 1) tests failed (0 / 16 test parameters)"
>
> kunit_tool is also updated to correctly ignore diagnostic lines, so that
> these statistics do not prevent the result from parsing.
>
> Signed-off-by: David Gow <davidgow@google.com>

Sorry, forgot about this. A couple of comments below:

> ---
>
> This is largely a follow-up to the discussion here:
>  https://lore.kernel.org/linux-kselftest/CABVgOSmy4n_LGwDS7yWfoLftcQzxv6S+iXx9Y=OPcgG2gu0z1w@mail.gmail.com/T/#t
>
> Does this seem like a sensible addition?

I am fine with it as long as other people want it.

> Cheers,
> -- David
>
>  lib/kunit/test.c                    | 71 +++++++++++++++++++++++++++++
>  tools/testing/kunit/kunit_parser.py |  2 +-
>  2 files changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index ec9494e914ef..711e269366a7 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -9,6 +9,7 @@
>  #include <kunit/test.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
> +#include <linux/moduleparam.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
>
> @@ -16,6 +17,40 @@
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>
> +/*
> + * KUnit statistic mode:
> + * 0 - disabled
> + * 1 - only when there is at least one failure, and more than one subtest
> + * 2 - enabled
> + */
> +static int kunit_stats_enabled = 1;
> +core_param(kunit_stats_enabled, kunit_stats_enabled, int, 0644);

I think this should be a module param.

Also, remember to document the param with: MODULE_PARM_DESC()

> +static bool kunit_should_print_stats(int num_failures, int num_subtests)
> +{
> +       if (kunit_stats_enabled == 0)
> +               return false;
> +
> +       if (kunit_stats_enabled == 2)
> +               return true;
> +
> +       return (num_failures > 0 && num_subtests > 1);
> +}
> +
> +static void kunit_print_test_stats(struct kunit *test,
> +                                  size_t num_failures, size_t num_subtests)
> +{
> +       if (!kunit_should_print_stats(num_failures, num_subtests))
> +               return;
> +
> +       kunit_log(KERN_INFO, test,
> +                 KUNIT_SUBTEST_INDENT
> +                 "# %s: %lu / %lu test parameters failed",
> +                 test->name,
> +                 num_failures,
> +                 num_subtests);
> +}
> +
>  /*
>   * Append formatted message to log, size of which is limited to
>   * KUNIT_LOG_SIZE bytes (including null terminating byte).
> @@ -346,15 +381,37 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>         test_case->success = test->success;
>  }
>
> +static void kunit_print_suite_stats(struct kunit_suite *suite,
> +                                   size_t num_failures,
> +                                   size_t total_param_failures,
> +                                   size_t total_params)
> +{
> +       size_t num_cases = kunit_suite_num_test_cases(suite);
> +
> +       if (!kunit_should_print_stats(num_failures, num_cases))
> +               return;
> +
> +       kunit_log(KERN_INFO, suite,
> +                 "# %s: (%lu / %lu) tests failed (%lu / %lu test parameters)",
> +                 suite->name,
> +                 num_failures,
> +                 num_cases,
> +                 total_param_failures,
> +                 total_params);
> +}
> +
>  int kunit_run_tests(struct kunit_suite *suite)
>  {
>         char param_desc[KUNIT_PARAM_DESC_SIZE];
>         struct kunit_case *test_case;
> +       size_t num_suite_failures = 0;
> +       size_t total_param_failures = 0, total_params = 0;
>
>         kunit_print_subtest_start(suite);
>
>         kunit_suite_for_each_test_case(suite, test_case) {
>                 struct kunit test = { .param_value = NULL, .param_index = 0 };
> +               size_t num_params = 0, num_failures = 0;
>                 bool test_success = true;
>
>                 if (test_case->generate_params) {
> @@ -385,13 +442,27 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                 test.param_value = test_case->generate_params(test.param_value, param_desc);
>                                 test.param_index++;
>                         }
> +
> +                       if (!test.success)
> +                               num_failures++;
> +                       num_params++;
> +
>                 } while (test.param_value);
>
> +               kunit_print_test_stats(&test, num_failures, num_params);
> +
>                 kunit_print_ok_not_ok(&test, true, test_success,
>                                       kunit_test_case_num(suite, test_case),
>                                       test_case->name);
> +
> +               if (!test_success)
> +                       num_suite_failures++;
> +               total_params += num_params;
> +               total_param_failures += num_failures;
>         }
>
> +       kunit_print_suite_stats(suite, num_suite_failures,
> +                               total_param_failures, total_params);
>         kunit_print_subtest_end(suite);
>
>         return 0;
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 6614ec4d0898..88ee2b2668ad 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -95,7 +95,7 @@ def print_log(log):
>         for m in log:
>                 print_with_timestamp(m)
>
> -TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
> +TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*# Subtest:).*$')
>
>  def consume_non_diagnositic(lines: List[str]) -> None:
>         while lines and not TAP_ENTRIES.match(lines[0]):
>
> base-commit: 5f6b99d0287de2c2d0b5e7abcb0092d553ad804a
> --
> 2.29.2.576.ga3fc446d84-goog
>
