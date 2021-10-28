Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D41943F2DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 00:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJ1WjA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 18:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhJ1WjA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 18:39:00 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9FC061570
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 15:36:32 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id j28so2216090ila.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 15:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tK1+5HlOuiSkOMddGgoV7U/XOQaHtx3v2HgHVD1iYN8=;
        b=ZxvSeDwPFW152l1kjOzLqFVTqRIZ1tSyJm/Eu65JwEexV3UdocljKuPe7+igtGft0o
         4J/OTTf7MgYfOgPneYct2FlOlzmd3wJ7Te3HfdnpZP4bfo3Sw/oO508tPp1qntRlOUPv
         rf5SEQxfxGDJhvw/ti2Kx+r6hvqzPJVL0Y/6eZEASyPRd9PDy7p6gpnRzw2qzh3OXs1y
         3clqox8iEkZu6FZ6KkldBcFLkJ0GpBYbtgZ7xpzDKhfZ2OvnPFHLRLRehVSslnV02Fv7
         sAolhMktaCRwpH5T/eZXbKMykoArybd5dK8+r2/CXawhT7Ok1bcupF4tFoPLRe7fJIck
         IFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tK1+5HlOuiSkOMddGgoV7U/XOQaHtx3v2HgHVD1iYN8=;
        b=fw0IYichS4mtq4UA0wcOy0x54KION4q5CgKHB+K5FrtTvfP9rCtj7hPRgpaQpz9T9y
         4kwtIQgNU0UTXqLii1ALc0H9SW39UJe3dK/VcShUUhq4So6Tg7qR7qHZ/EKokc7tcr9A
         oBX71dxbyZq7v8xa3XTjOw6q3DrUVSb1E5XaofVsAoOrvPf9RBJOsRjv3JDaIl8dsySn
         HXDGvpAz7EsDUOceQ2IKpO4riSSL3qtHKsogRYveMLs0zoIbrP7TuWsxeUtVRxsWmMJ3
         0P2956Ya+tQzKVzryHTWhKyU+oC+GbSdWaM/B/Lwu/aVBdkIFlKvqGel/h0Ug7dpY4+L
         s5Tw==
X-Gm-Message-State: AOAM532WFHAnGUsk9X3e92K3lDXE5UW7OkWT0SKkNTHk8jM9FIgF4ONn
        DG/wOHBq2+6ww4Qg6WqScM92QXjvWzHlVU6uhlauJg==
X-Google-Smtp-Source: ABdhPJxyo7q9vBF/AuGwxupKSSnuSRqNqUaOic6kixIS9BztJFEpi+9u+HwsTdYOpdH0TWlimS0TX3kOl+GrKjV/dB0=
X-Received: by 2002:a05:6e02:190f:: with SMTP id w15mr5046526ilu.121.1635460592112;
 Thu, 28 Oct 2021 15:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211028064154.2301049-1-davidgow@google.com> <20211028064154.2301049-2-davidgow@google.com>
In-Reply-To: <20211028064154.2301049-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 28 Oct 2021 15:36:20 -0700
Message-ID: <CAGS_qxoOj+sDOHY8VZv4fw7_XiXqDWcYEC1LAiSUHv38dXh_uw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] kunit: tool: Report an error if any test has no subtests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 27, 2021 at 11:42 PM David Gow <davidgow@google.com> wrote:
>
> It's possible for a test to have a subtest header, but zero valid
> subtests. We used to error on this if the test plan had no subtests
> listed, but it's possible to have subtests without a test plan (indeed,
> this is how parameterised tests work).
>
> Tests with 0 subtests now have the result NO_TESTS, and will report an
> error (which does not halt test execution, but is printed in a scary red
> colour and is noted in the results summary).

Tested by tweaking ext4 tests (and running with patch 3)

[15:04:33] =============== ext4_inode_test (1 subtest) ================
[15:04:33] ============== inode_test_xtimestamp_decoding ==============
[15:04:33] [ERROR] Test inode_test_xtimestamp_decoding: 0 tests run!
[15:04:33] ====== [NO TESTS RUN] inode_test_xtimestamp_decoding =======
[15:04:33] ================ [SKIPPED] ext4_inode_test =================
[15:04:33] ============================================================
[15:04:33] Testing complete. Passed: 0, Failed: 0, Crashed: 0,
Skipped: 1, Errors: 1
[15:04:33] Elapsed time: 48.581s total, 0.000s configuring, 45.486s
building, 2.992s running

It's maybe a bit confusing to have ERROR, NO TESTS RUN, and SKIPPED
all printed for the same thing.

An alternative would be to drop the error, giving
[15:04:33] =============== ext4_inode_test (1 subtest) ================
[15:04:33] ============== inode_test_xtimestamp_decoding ==============
[15:04:33] ====== [NO TESTS RUN] inode_test_xtimestamp_decoding =======
[15:04:33] ================ [SKIPPED] ext4_inode_test =================
[15:04:33] ============================================================

But looking at it, I think I prefer the more explicit ERROR being there.

>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

A few optional nits below.

> ---
>
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20211027013702.2039566-2-davidgow@google.com/
> - Report NO_TESTS as '[NO TESTS RUN]' in yellow, instead of '[FAILED]'
>   in red, particularly since it doesn't get counted as a failure.
>
>  tools/testing/kunit/kunit_parser.py              | 16 +++++++++++-----
>  tools/testing/kunit/kunit_tool_test.py           |  9 +++++++++
>  .../test_is_test_passed-no_tests_no_plan.log     |  7 +++++++
>  3 files changed, 27 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 50ded55c168c..68c847e8ca58 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -360,9 +360,6 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
>         test.log.append(lines.pop())
>         expected_count = int(match.group(1))
>         test.expected_count = expected_count
> -       if expected_count == 0:
> -               test.status = TestStatus.NO_TESTS
> -               test.add_error('0 tests run!')
>         return True
>
>  TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
> @@ -589,6 +586,8 @@ def format_test_result(test: Test) -> str:
>                 return (green('[PASSED] ') + test.name)
>         elif test.status == TestStatus.SKIPPED:
>                 return (yellow('[SKIPPED] ') + test.name)
> +       elif test.status == TestStatus.NO_TESTS:
> +               return (yellow('[NO TESTS RUN] ') + test.name)
>         elif test.status == TestStatus.TEST_CRASHED:
>                 print_log(test.log)
>                 return (red('[CRASHED] ') + test.name)
> @@ -731,6 +730,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>                 # test plan
>                 test.name = "main"
>                 parse_test_plan(lines, test)
> +               parent_test = True
>         else:
>                 # If KTAP/TAP header is not found, test must be subtest
>                 # header or test result line so parse attempt to parser
> @@ -744,7 +744,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>         expected_count = test.expected_count
>         subtests = []
>         test_num = 1
> -       while expected_count is None or test_num <= expected_count:
> +       while parent_test and (expected_count is None or test_num <= expected_count):
>                 # Loop to parse any subtests.
>                 # Break after parsing expected number of tests or
>                 # if expected number of tests is unknown break when test
> @@ -779,9 +779,15 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>                         parse_test_result(lines, test, expected_num)
>                 else:
>                         test.add_error('missing subtest result line!')
> +
> +       # Check for there being no tests
> +       if parent_test and len(subtests) == 0:
> +               test.status = TestStatus.NO_TESTS
> +               test.add_error('0 tests run!')
> +
>         # Add statuses to TestCounts attribute in Test object
>         bubble_up_test_results(test)
> -       if parent_test:
> +       if parent_test and not main:
>                 # If test has subtests and is not the main test object, print
>                 # footer.
>                 print_test_footer(test)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index bc8793145713..c59fe0777387 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -208,6 +208,15 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(
>                         kunit_parser.TestStatus.NO_TESTS,
>                         result.status)

I'd prefer we split these test cases out.
Perhaps:

def test_no_tests_empty_plan(self):
   ...

def test_no_tests_no_plan(self):
  ... # this new test

> +               no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
> +               with open(no_plan_log) as file:
> +                       result = kunit_parser.parse_run_tests(
> +                               kunit_parser.extract_tap_lines(file.readlines()))
> +               self.assertEqual(0, len(result.test.subtests[0].subtests[0].subtests))
> +               self.assertEqual(
> +                       kunit_parser.TestStatus.NO_TESTS,
> +                       result.test.subtests[0].subtests[0].status)

optional:
self.assertEqual(1, result.test.counts.errors)

> +
>
>         def test_no_kunit_output(self):
>                 crash_log = test_data_path('test_insufficient_memory.log')
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
> new file mode 100644
> index 000000000000..dd873c981108
> --- /dev/null
> +++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
> @@ -0,0 +1,7 @@
> +TAP version 14
> +1..1
> +  # Subtest: suite
> +  1..1
> +    # Subtest: case
> +  ok 1 - case # SKIP
> +ok 1 - suite
> --
> 2.33.0.1079.g6e70778dc9-goog
>
