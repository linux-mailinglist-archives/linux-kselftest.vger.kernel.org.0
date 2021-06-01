Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3551D39770A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jun 2021 17:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhFAPsN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Jun 2021 11:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhFAPsN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Jun 2021 11:48:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EDAC06174A
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Jun 2021 08:46:30 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q7so10040720iob.4
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jun 2021 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzkpMoK025anFl+s6G5Ps0FIBRVqAbi7JbvSN9zWPHk=;
        b=vkt+d/Dcp4O3PlNbrWwLupeypuSQ9zkYpnSMtFmQJLmbUoOuV9YVUa3AKlcnNGjHjx
         RBHmByVWY3mmVAQZ+9fRKYO8s95YMnW2NWZ1a/VGInAl6t70l3wyFUAH3w6YV6wkBx2p
         WV3jX3QNRd0NMKjot2IahHVNYzom3M9Qd71Sesaf2PfsJPC7UHg2JZvQH9hIydUDug8u
         BCXcPv7+ICk5WCTPilryHTsQw+jnoDGYBJxLXMEE6iwHncbhxbhPF45ZC51n2Ybh5l9v
         44tVX66M85t2oXrHK8X3tmnrjDTEiSdifa0JxwDNYOlYBom8lcPfhEusf5nMKkHrzhH6
         Cpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzkpMoK025anFl+s6G5Ps0FIBRVqAbi7JbvSN9zWPHk=;
        b=erOQuVqa7UqyA+n5Yp59qnMyecE5t61YNCp5mYcDFQh2hROPJ4dDVsMSxwVkhQEuyu
         VeOLmgw9G24ISbchBgjKZu/eZXn/hfKy4XZ4XShq1rhnSzeTpNtHjL/q4rFGK4N04rft
         wCU7mgWn+8LMgTOlGUjokhUIHAOVSa+U7o8SvFspRwl6CvvTz4mZZnNK/4UA7IkpdLve
         JzVoNhz1Epp8x10a2SloUj8PRixkwcsOmgBQkxB02aryb6AcImJRrhRZGjFbOOZYW3v+
         NWYIwBc8DFlBqNj6tA3HpsphT9vzd49z+qkqems6lCMVprYOBqmOwWpueecBJ7auIXX9
         PcZQ==
X-Gm-Message-State: AOAM53351K0RrVSmCLw6bO0emCwiU6yY4eEr23f8CP4eAr8nG1NNQyj2
        FOBv8PxO9VsQkWBxRkhiEK2Z4tA/Hm40gYvg3OlSfg==
X-Google-Smtp-Source: ABdhPJxOz9rgM80Sy48JbcZ4GldO30kOzGxGLVIEdLZYFNOPl0HaRE8eQrLdns2g8T+JhD0n6cscn+Y7+KUBDgBUKpk=
X-Received: by 2002:a05:6638:76d:: with SMTP id y13mr25440767jad.25.1622562389742;
 Tue, 01 Jun 2021 08:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210528075932.347154-1-davidgow@google.com> <20210528075932.347154-2-davidgow@google.com>
In-Reply-To: <20210528075932.347154-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 1 Jun 2021 08:46:18 -0700
Message-ID: <CAGS_qxpg7PdGPiP5kmzBthh=eHd+SYmyvUitQV40Weej3wD4QA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kunit: tool: Support skipped tests in kunit_tool
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

On Fri, May 28, 2021 at 12:59 AM David Gow <davidgow@google.com> wrote:
>
> Add support for the SKIP directive to kunit_tool's TAP parser.
>
> Skipped tests now show up as such in the printed summary. The number of
> skipped tests is counted, and if all tests in a suite are skipped, the
> suite is also marked as skipped. Otherwise, skipped tests do affect the
> suite result.
>
> Example output:
> [00:22:34] ======== [SKIPPED] example_skip ========
> [00:22:34] [SKIPPED] example_skip_test # SKIP this test should be skipped
> [00:22:34] [SKIPPED] example_mark_skipped_test # SKIP this test should be skipped
> [00:22:34] ============================================================
> [00:22:34] Testing complete. 2 tests run. 0 failed. 0 crashed. 2 skipped.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Some minor remarks, but this looks good to me.

Though I'm surprised there has not been any bikeshedding done about
the color of the SKIPPED output.
So I'll throw an opinion out there.
I think yellow is fine, but I did somewhat recently change another
similar tool to go from yellow => cyan for SKIPPED. The motivation
there was to have a color for "flaky" tests that stood out, and the
most appropriate ANSI color seemed to be yellow (between green for
PASSED and red for FAILED).
And I don't know if KUnit tool will ever get to the point where we
automatically rerun tests on failure, as I can see an argument for
that logic living a layer above.

> ---
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20210526081112.3652290-2-davidgow@google.com/
> - Include missing test logs for kunit_tool_test
> - Encapsulate test counts in a class (Thanks Daniel Latypov)
>   - Fix a type hinting issue in the process
>
> ---
>  tools/testing/kunit/kunit_parser.py           | 77 +++++++++++++------
>  tools/testing/kunit/kunit_tool_test.py        | 22 ++++++
>  .../kunit/test_data/test_skip_all_tests.log   | 15 ++++
>  .../kunit/test_data/test_skip_tests.log       | 15 ++++
>  4 files changed, 105 insertions(+), 24 deletions(-)
>  create mode 100644 tools/testing/kunit/test_data/test_skip_all_tests.log
>  create mode 100644 tools/testing/kunit/test_data/test_skip_tests.log
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index e8bcc139702e..f07dce1d4146 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -43,6 +43,7 @@ class TestCase(object):
>  class TestStatus(Enum):
>         SUCCESS = auto()
>         FAILURE = auto()
> +       SKIPPED = auto()
>         TEST_CRASHED = auto()
>         NO_TESTS = auto()
>         FAILURE_TO_PARSE_TESTS = auto()
> @@ -108,6 +109,8 @@ def save_non_diagnostic(lines: List[str], test_case: TestCase) -> None:
>
>  OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
>
> +OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP(.*)$')
> +
>  OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
>
>  OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
> @@ -125,6 +128,10 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
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
> @@ -188,16 +195,16 @@ def parse_subtest_plan(lines: List[str]) -> Optional[int]:
>                 return None
>
>  def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
> -       if left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
> +       if left == right:
> +               return left
> +       elif left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
>                 return TestStatus.TEST_CRASHED
>         elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
>                 return TestStatus.FAILURE
> -       elif left != TestStatus.SUCCESS:
> -               return left
> -       elif right != TestStatus.SUCCESS:
> +       elif left == TestStatus.SKIPPED:
>                 return right
>         else:
> -               return TestStatus.SUCCESS
> +               return left
>
>  def parse_ok_not_ok_test_suite(lines: List[str],
>                                test_suite: TestSuite,
> @@ -214,6 +221,9 @@ def parse_ok_not_ok_test_suite(lines: List[str],
>                         test_suite.status = TestStatus.SUCCESS
>                 else:
>                         test_suite.status = TestStatus.FAILURE
> +               skip_match = OK_NOT_OK_SKIP.match(line)
> +               if skip_match:
> +                       test_suite.status = TestStatus.SKIPPED
>                 suite_index = int(match.group(2))
>                 if suite_index != expected_suite_index:
>                         print_with_timestamp(
> @@ -224,8 +234,8 @@ def parse_ok_not_ok_test_suite(lines: List[str],
>         else:
>                 return False
>
> -def bubble_up_errors(statuses: Iterable[TestStatus]) -> TestStatus:
> -       return reduce(max_status, statuses, TestStatus.SUCCESS)
> +def bubble_up_errors(status_list: Iterable[TestStatus]) -> TestStatus:
> +       return reduce(max_status, status_list, TestStatus.SKIPPED)
>
>  def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
>         max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
> @@ -311,49 +321,68 @@ def parse_test_result(lines: List[str]) -> TestResult:
>         else:
>                 return TestResult(TestStatus.NO_TESTS, [], lines)
>
> -def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
> -       total_tests = 0
> -       failed_tests = 0
> -       crashed_tests = 0
> +class TestCounts:
> +       passed: int
> +       failed: int
> +       crashed: int
> +       skipped: int
> +
> +       def __init__(self):
> +               self.passed = 0
> +               self.failed = 0
> +               self.crashed = 0
> +               self.skipped = 0
> +
> +       def total(self) -> int:
> +               return self.passed + self.failed + self.crashed + self.skipped
> +
> +def print_and_count_results(test_result: TestResult) -> TestCounts:
> +       counts = TestCounts()
>         for test_suite in test_result.suites:
>                 if test_suite.status == TestStatus.SUCCESS:
>                         print_suite_divider(green('[PASSED] ') + test_suite.name)
> +               elif test_suite.status == TestStatus.SKIPPED:
> +                       print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
>                 elif test_suite.status == TestStatus.TEST_CRASHED:
>                         print_suite_divider(red('[CRASHED] ' + test_suite.name))
>                 else:
>                         print_suite_divider(red('[FAILED] ') + test_suite.name)
>                 for test_case in test_suite.cases:
> -                       total_tests += 1
>                         if test_case.status == TestStatus.SUCCESS:
> +                               counts.passed += 1
>                                 print_with_timestamp(green('[PASSED] ') + test_case.name)
> +                       elif test_case.status == TestStatus.SKIPPED:
> +                               counts.skipped += 1
> +                               print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
>                         elif test_case.status == TestStatus.TEST_CRASHED:
> -                               crashed_tests += 1
> +                               counts.crashed += 1
>                                 print_with_timestamp(red('[CRASHED] ' + test_case.name))
>                                 print_log(map(yellow, test_case.log))
>                                 print_with_timestamp('')
>                         else:
> -                               failed_tests += 1
> +                               counts.failed += 1
>                                 print_with_timestamp(red('[FAILED] ') + test_case.name)
>                                 print_log(map(yellow, test_case.log))
>                                 print_with_timestamp('')
> -       return total_tests, failed_tests, crashed_tests
> +       return counts
>
>  def parse_run_tests(kernel_output) -> TestResult:
> -       total_tests = 0
> -       failed_tests = 0
> -       crashed_tests = 0
> +       counts = TestCounts()
>         test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
>         if test_result.status == TestStatus.NO_TESTS:
>                 print(red('[ERROR] ') + yellow('no tests run!'))
>         elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
>                 print(red('[ERROR] ') + yellow('could not parse test results!'))
>         else:
> -               (total_tests,
> -                failed_tests,
> -                crashed_tests) = print_and_count_results(test_result)
> +               counts = print_and_count_results(test_result)
>         print_with_timestamp(DIVIDER)
> -       fmt = green if test_result.status == TestStatus.SUCCESS else red
> +       if test_result.status == TestStatus.SUCCESS:
> +               fmt = green
> +       elif test_result.status == TestStatus.SKIPPED:
> +               fmt = yellow
> +       else:
> +               fmt =red
>         print_with_timestamp(
> -               fmt('Testing complete. %d tests run. %d failed. %d crashed.' %
> -                   (total_tests, failed_tests, crashed_tests)))
> +               fmt('Testing complete. %d tests run. %d failed. %d crashed. %d skipped.' %
> +                   (counts.total(), counts.failed, counts.crashed, counts.skipped)))

This looks good to me, just want to comment that we'll probably want
to factor this into a helper in TestCounts the next time we add a
status.
I've written very similar code for other projects, and it can help to reduce
  42 tests run. 0 failed. 0 crashed. 1 skipped.
to something like
  42 tests run. 1 skipped.

But with just these, I think it's fine to leave them entirely as-is.
We can decide later if we want to tersen the output.

E.g. we might decide that we want to have
  42 tests run. 2 timed out. 1 crashed.
in the future.

>         return test_result
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 2e809dd956a7..a51e70cafcc1 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -183,6 +183,28 @@ class KUnitParserTest(unittest.TestCase):
>                         kunit_parser.TestStatus.TEST_CRASHED,
>                         result.status)
>
> +       def test_skipped_test(self):
> +               skipped_log = test_data_path('test_skip_tests.log')
> +               file = open(skipped_log)
> +               result = kunit_parser.parse_run_tests(file.readlines())

This would be slightly safer as

with open(skipped_log) as file:
   result = kunit_parser.parse_run_tests(file.readlines())

As-is, the code will leak FDs if the test fails.

But you've stated a preference before for having tests like this, so I
don't care too much either way.
It's less confusing to someone thinking in a C mindset, since `result`
will more obviously be in scope.


> +
> +               # A skipped test does not fail the whole suite.
> +               self.assertEqual(
> +                       kunit_parser.TestStatus.SUCCESS,
> +                       result.status)
> +               file.close()
> +
> +       def test_skipped_all_tests(self):
> +               skipped_log = test_data_path('test_skip_all_tests.log')
> +               file = open(skipped_log)
> +               result = kunit_parser.parse_run_tests(file.readlines())
> +
> +               self.assertEqual(
> +                       kunit_parser.TestStatus.SKIPPED,
> +                       result.status)
> +               file.close()
> +
> +
>         def test_ignores_prefix_printk_time(self):
>                 prefix_log = test_data_path('test_config_printk_time.log')
>                 with open(prefix_log) as file:
> diff --git a/tools/testing/kunit/test_data/test_skip_all_tests.log b/tools/testing/kunit/test_data/test_skip_all_tests.log
> new file mode 100644
> index 000000000000..2ea6e6d14fff
> --- /dev/null
> +++ b/tools/testing/kunit/test_data/test_skip_all_tests.log
> @@ -0,0 +1,15 @@
> +TAP version 14
> +1..2
> +    # Subtest: string-stream-test
> +    1..3
> +    ok 1 - string_stream_test_empty_on_creation # SKIP all tests skipped
> +    ok 2 - string_stream_test_not_empty_after_add # SKIP all tests skipped
> +    ok 3 - string_stream_test_get_string # SKIP all tests skipped
> +ok 1 - string-stream-test # SKIP
> +    # Subtest: example
> +    1..2
> +    # example_simple_test: initializing
> +    ok 1 - example_simple_test # SKIP all tests skipped
> +    # example_skip_test: initializing
> +    ok 2 - example_skip_test # SKIP this test should be skipped
> +ok 2 - example # SKIP
> diff --git a/tools/testing/kunit/test_data/test_skip_tests.log b/tools/testing/kunit/test_data/test_skip_tests.log
> new file mode 100644
> index 000000000000..79b326e31274
> --- /dev/null
> +++ b/tools/testing/kunit/test_data/test_skip_tests.log
> @@ -0,0 +1,15 @@
> +TAP version 14
> +1..2
> +    # Subtest: string-stream-test
> +    1..3
> +    ok 1 - string_stream_test_empty_on_creation
> +    ok 2 - string_stream_test_not_empty_after_add
> +    ok 3 - string_stream_test_get_string
> +ok 1 - string-stream-test
> +    # Subtest: example
> +    1..2
> +    # example_simple_test: initializing
> +    ok 1 - example_simple_test
> +    # example_skip_test: initializing
> +    ok 2 - example_skip_test # SKIP this test should be skipped
> +ok 2 - example
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
