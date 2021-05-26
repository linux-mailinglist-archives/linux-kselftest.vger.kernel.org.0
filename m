Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3604A39209B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhEZTMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 15:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhEZTM3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 15:12:29 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E827C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 12:10:56 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b5so1867694ilc.12
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZJZEcj2VrnKNwv+AvHwpmxd3QA3c3T2pob2c3e+gjU=;
        b=hkWnTsAaQqRMkLKo3sak43TNg6Qfgxqh280m9MlSj+rxNQhTPAr9y4fYtIbLRn6h6m
         XSX1+Ga0LhDuTIO/oJ1eA0nlMiD3KmeJWkM/UwLkKjMh67jf3Ej6tbEanipZuaN4tj8j
         VhLBV6WP5qzs/pV+mks965XnePRrRLgi+i50enudYpu1FLGmmdEYUYKPfapRQllSc5q5
         USnSQLrmWwBjJj2JwLwYfvpiQ0tBuSE4bq7VEG6eljBJIw0xmdhaxs3OCksO7T3BEz7Z
         6c9kA2Hkj8WjSy9lX0HRcc220Gf9P3KTrK2Cpx6ckv0dbYWqP50cWbB7UPq/fw4BP8BO
         goxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZJZEcj2VrnKNwv+AvHwpmxd3QA3c3T2pob2c3e+gjU=;
        b=N2kbOXIKdynZD7Kl/gKtM5jcjp4HEWC/CHHZ94bTHs5Z5HZRmblU4MKTvkSTEerBwy
         BUc7Ghbc/lbd0LWp0FkZNSsERK0EFwbMgLjdb0GANjA5JCpqtCgZZMRNKZ/Tf/pjO7Yx
         2SKIviX7e5Unc44WGQtHPQL5/P21h8cLijth8F9BaSu12X7GIQOrYCRQl51B4tfnr4TY
         vnwZN1i9E73DiYFVU8JeKfbs83KbZZ3aiWqu2w5fIXZD0MHyMngm28kAMUne4GfXtlde
         0dU+GrBLRVz7HWnsQ5v2GLIhbjxr+g10rahaKNI2NY3w0Y03jZ0BYXtM8R1JnH+gPP9V
         jwPQ==
X-Gm-Message-State: AOAM5319OJZl4MKjJyzHPkthl0r0zU+1dji2lxP5h79U8U3TzrqcIesz
        yL8SaIN9DaVQfi6a/GFdFTHACxfQPELpnqPZ6mXtqw==
X-Google-Smtp-Source: ABdhPJwJe8Pf+7dNqabnpUMRsxE6RjFRPJBeS8EQ9sb22XWfk3AflqugaNZ8Bq0EvVXA5/lOCREbG7qHjGPqEORi8Xs=
X-Received: by 2002:a92:c70b:: with SMTP id a11mr30852213ilp.136.1622056255480;
 Wed, 26 May 2021 12:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com> <20210526081112.3652290-2-davidgow@google.com>
In-Reply-To: <20210526081112.3652290-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 26 May 2021 12:10:44 -0700
Message-ID: <CAGS_qxrENPsW2Wq=Yk7zsq7nXzsNn50RuFEh683ZSuHs6zPUAw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: Support skipped tests in kunit_tool
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
> ---
>  tools/testing/kunit/kunit_parser.py    | 47 +++++++++++++++++++-------
>  tools/testing/kunit/kunit_tool_test.py | 22 ++++++++++++

This seems to be missing the added test files.

>  2 files changed, 57 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index e8bcc139702e..6b5dd26b479d 100644
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
> @@ -315,9 +325,12 @@ def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:

Btw, this type annotation is out of date.
But I think an ever growing Tuple is too cumbersome, how about this?

diff --git a/tools/testing/kunit/kunit_parser.py
b/tools/testing/kunit/kunit_parser.py
index 6b5dd26b479d..055ee1e4d19d 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -6,6 +6,7 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>

+from dataclasses import dataclass
 import re

 from collections import namedtuple
@@ -321,11 +322,19 @@ def parse_test_result(lines: List[str]) -> TestResult:
        else:
                return TestResult(TestStatus.NO_TESTS, [], lines)

-def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
-       total_tests = 0
-       failed_tests = 0
-       crashed_tests = 0
-       skipped_tests = 0
+#  Note: This would require Python 3.7. We currently only required
3.6 (enum.auto). We can do it by hand to avoid that, if we want.
+@dataclass
+class TestCounts:
+       passed: int = 0
+       failed: int = 0
+       skipped: int = 0
+       crashed: int = 0
+
+       def total(self) -> int:
+               return self.passed + self.failed + self.skipped + self.crashed
+
+def print_and_count_results(test_result: TestResult) -> TestCounts:
+       counts = TestCounts()
        for test_suite in test_result.suites:
                if test_suite.status == TestStatus.SUCCESS:
                        print_suite_divider(green('[PASSED] ') +
test_suite.name)
@@ -336,39 +345,33 @@ def print_and_count_results(test_result:
TestResult) -> Tuple[int, int, int]:
                else:
                        print_suite_divider(red('[FAILED] ') + test_suite.name)
                for test_case in test_suite.cases:
-                       total_tests += 1
                        if test_case.status == TestStatus.SUCCESS:
+                               counts.passed += 1
                                print_with_timestamp(green('[PASSED]
') + test_case.name)
                        elif test_case.status == TestStatus.SKIPPED:
-                               skipped_tests += 1
+                               counts.skipped += 1
                                print_with_timestamp(yellow('[SKIPPED]
') + test_case.name)
                        elif test_case.status == TestStatus.TEST_CRASHED:
-                               crashed_tests += 1
+                               counts.crashed += 1
                                print_with_timestamp(red('[CRASHED] '
+ test_case.name))
                                print_log(map(yellow, test_case.log))
                                print_with_timestamp('')
                        else:
-                               failed_tests += 1
+                               counts.failed += 1
                                print_with_timestamp(red('[FAILED] ')
+ test_case.name)
                                print_log(map(yellow, test_case.log))
                                print_with_timestamp('')
-       return total_tests, failed_tests, crashed_tests, skipped_tests
+       return counts

 def parse_run_tests(kernel_output) -> TestResult:
-       total_tests = 0
-       failed_tests = 0
-       crashed_tests = 0
-       skipped_tests = 0
+       counts = TestCounts()
        test_result =
parse_test_result(list(isolate_kunit_output(kernel_output)))
        if test_result.status == TestStatus.NO_TESTS:
                print(red('[ERROR] ') + yellow('no tests run!'))
        elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
                print(red('[ERROR] ') + yellow('could not parse test results!'))
        else:
-               (total_tests,
-                failed_tests,
-                crashed_tests,
-                skipped_tests) = print_and_count_results(test_result)
+               counts = print_and_count_results(test_result)
        print_with_timestamp(DIVIDER)
        if test_result.status == TestStatus.SUCCESS:
                fmt = green
@@ -378,5 +381,5 @@ def parse_run_tests(kernel_output) -> TestResult:
                fmt =red
        print_with_timestamp(
                fmt('Testing complete. %d tests run. %d failed. %d
crashed. %d skipped.' %
-                   (total_tests, failed_tests, crashed_tests, skipped_tests)))
+                   (counts.total(), counts.failed, counts.crashed,
counts.skipped)))
        return test_result

>         total_tests = 0
>         failed_tests = 0
>         crashed_tests = 0
> +       skipped_tests = 0
>         for test_suite in test_result.suites:
>                 if test_suite.status == TestStatus.SUCCESS:
>                         print_suite_divider(green('[PASSED] ') + test_suite.name)
> +               elif test_suite.status == TestStatus.SKIPPED:
> +                       print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
>                 elif test_suite.status == TestStatus.TEST_CRASHED:
>                         print_suite_divider(red('[CRASHED] ' + test_suite.name))
>                 else:
> @@ -326,6 +339,9 @@ def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
>                         total_tests += 1
>                         if test_case.status == TestStatus.SUCCESS:
>                                 print_with_timestamp(green('[PASSED] ') + test_case.name)
> +                       elif test_case.status == TestStatus.SKIPPED:
> +                               skipped_tests += 1
> +                               print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
>                         elif test_case.status == TestStatus.TEST_CRASHED:
>                                 crashed_tests += 1
>                                 print_with_timestamp(red('[CRASHED] ' + test_case.name))
> @@ -336,12 +352,13 @@ def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
>                                 print_with_timestamp(red('[FAILED] ') + test_case.name)
>                                 print_log(map(yellow, test_case.log))
>                                 print_with_timestamp('')
> -       return total_tests, failed_tests, crashed_tests
> +       return total_tests, failed_tests, crashed_tests, skipped_tests
>
>  def parse_run_tests(kernel_output) -> TestResult:
>         total_tests = 0
>         failed_tests = 0
>         crashed_tests = 0
> +       skipped_tests = 0
>         test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
>         if test_result.status == TestStatus.NO_TESTS:
>                 print(red('[ERROR] ') + yellow('no tests run!'))
> @@ -350,10 +367,16 @@ def parse_run_tests(kernel_output) -> TestResult:
>         else:
>                 (total_tests,
>                  failed_tests,
> -                crashed_tests) = print_and_count_results(test_result)
> +                crashed_tests,
> +                skipped_tests) = print_and_count_results(test_result)
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
> +                   (total_tests, failed_tests, crashed_tests, skipped_tests)))
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
> --
> 2.31.1.818.g46aad6cb9e-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210526081112.3652290-2-davidgow%40google.com.
