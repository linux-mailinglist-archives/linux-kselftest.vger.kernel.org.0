Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF657392971
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 10:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhE0IYM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 May 2021 04:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhE0IYC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 May 2021 04:24:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C40C061760
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 01:22:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x7so3752855wrt.12
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 01:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLA6FZgMJY2DIo+A3VMQHKtyTcT13DplN/4RsQKhimo=;
        b=CloOD5cnu8I8vdYbop85XBoPbusyC1CasgOVmokJHBN9L5rU09zYn5OLuh+ru6DNk3
         i6gD3N6RtpBpMHMB0ceJsW7+EozHxCjoZYSEUpr2Q+qUf5p/GvHuQK+tRa0EOkQPM6ti
         fo//4NcUCfLw9InU7tO9py8MBnv7RW1XHJyJPqVwWh/QuYFIGStyNWhTUdar/sueQVe4
         xaphGLOVO2OpRm7rjZuY3Sy5DnErHr1USP0ZH19n7T6ZV/A/sLnLougmg7qStmOcn0mn
         V7JtLAJ8Jh/Swcbb51QAM9ei1mcmt38FYhVKWT9vIZy+tzsmYBMtGCqez7FYzx8Pq9c7
         TEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLA6FZgMJY2DIo+A3VMQHKtyTcT13DplN/4RsQKhimo=;
        b=hNInokUaRAzxayA8aPhBzPmP9hVeAb2/lTFeTPb4JwlaCu9wfWIytFtifbxpo+aWE7
         Bg2XdIDzLCl9vaJ8tFxPSqPcKvduzI16ZUhv1tePmV9a7Jl/zqN0vKjuwoQnoLWhfllM
         cirMN3hdQDtQDxf0VZhFiGgpqXnmPyIcuvD+IcopMs5G3jaeCT2Qqyls9YyC6x+er9bm
         cU4IBX2pfHuMjBqcY9B0N/q+F1ANbPmqAIRZu+y3coI4UjjQpFCoxmnNwNZsOE+kIdED
         +VqkVylmrJ8JkiDE36u3uUzgv0nI08FhUNqT/Gq67YKA/W24OI7QT3wWw8juG73AVoT7
         wCZw==
X-Gm-Message-State: AOAM532scJnUnYG91sDI5MRf6ECziCjWNlwq4uXCfPciENTLK91hoTYL
        MhBe+S8WnUlZnZVMqvBQp48tV77v1ivXFJcIBcOz8A==
X-Google-Smtp-Source: ABdhPJzywAoxMjs3cTYVX2UzZOi0RtoEeV1ahv+qYLswxMkqB7rbqAiBFFCCs+psns+k6H8/yP050QFqMIMrpleA2bE=
X-Received: by 2002:a5d:4384:: with SMTP id i4mr2059687wrq.332.1622103747315;
 Thu, 27 May 2021 01:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com> <20210526081112.3652290-2-davidgow@google.com>
 <CAGS_qxrENPsW2Wq=Yk7zsq7nXzsNn50RuFEh683ZSuHs6zPUAw@mail.gmail.com>
In-Reply-To: <CAGS_qxrENPsW2Wq=Yk7zsq7nXzsNn50RuFEh683ZSuHs6zPUAw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 May 2021 16:22:15 +0800
Message-ID: <CABVgOS=TuG0RHr0QqhnOJrcAf7VcZzYg5HDy+FgAA5yWvBgH8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: Support skipped tests in kunit_tool
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
        boundary="000000000000abd05805c34b75b8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000abd05805c34b75b8
Content-Type: text/plain; charset="UTF-8"

On Thu, May 27, 2021 at 3:10 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, May 26, 2021 at 1:11 AM 'David Gow' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Add support for the SKIP directive to kunit_tool's TAP parser.
> >
> > Skipped tests now show up as such in the printed summary. The number of
> > skipped tests is counted, and if all tests in a suite are skipped, the
> > suite is also marked as skipped. Otherwise, skipped tests do affect the
> > suite result.
> >
> > Example output:
> > [00:22:34] ======== [SKIPPED] example_skip ========
> > [00:22:34] [SKIPPED] example_skip_test # SKIP this test should be skipped
> > [00:22:34] [SKIPPED] example_mark_skipped_test # SKIP this test should be skipped
> > [00:22:34] ============================================================
> > [00:22:34] Testing complete. 2 tests run. 0 failed. 0 crashed. 2 skipped.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  tools/testing/kunit/kunit_parser.py    | 47 +++++++++++++++++++-------
> >  tools/testing/kunit/kunit_tool_test.py | 22 ++++++++++++
>
> This seems to be missing the added test files.
>

Whoops, yes: I'll add these back in v2.

> >  2 files changed, 57 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > index e8bcc139702e..6b5dd26b479d 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -43,6 +43,7 @@ class TestCase(object):
> >  class TestStatus(Enum):
> >         SUCCESS = auto()
> >         FAILURE = auto()
> > +       SKIPPED = auto()
> >         TEST_CRASHED = auto()
> >         NO_TESTS = auto()
> >         FAILURE_TO_PARSE_TESTS = auto()
> > @@ -108,6 +109,8 @@ def save_non_diagnostic(lines: List[str], test_case: TestCase) -> None:
> >
> >  OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
> >
> > +OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP(.*)$')
> > +
> >  OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
> >
> >  OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
> > @@ -125,6 +128,10 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
> >         if match:
> >                 test_case.log.append(lines.pop(0))
> >                 test_case.name = match.group(2)
> > +               skip_match = OK_NOT_OK_SKIP.match(line)
> > +               if skip_match:
> > +                       test_case.status = TestStatus.SKIPPED
> > +                       return True
> >                 if test_case.status == TestStatus.TEST_CRASHED:
> >                         return True
> >                 if match.group(1) == 'ok':
> > @@ -188,16 +195,16 @@ def parse_subtest_plan(lines: List[str]) -> Optional[int]:
> >                 return None
> >
> >  def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
> > -       if left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
> > +       if left == right:
> > +               return left
> > +       elif left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
> >                 return TestStatus.TEST_CRASHED
> >         elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
> >                 return TestStatus.FAILURE
> > -       elif left != TestStatus.SUCCESS:
> > -               return left
> > -       elif right != TestStatus.SUCCESS:
> > +       elif left == TestStatus.SKIPPED:
> >                 return right
> >         else:
> > -               return TestStatus.SUCCESS
> > +               return left
> >
> >  def parse_ok_not_ok_test_suite(lines: List[str],
> >                                test_suite: TestSuite,
> > @@ -214,6 +221,9 @@ def parse_ok_not_ok_test_suite(lines: List[str],
> >                         test_suite.status = TestStatus.SUCCESS
> >                 else:
> >                         test_suite.status = TestStatus.FAILURE
> > +               skip_match = OK_NOT_OK_SKIP.match(line)
> > +               if skip_match:
> > +                       test_suite.status = TestStatus.SKIPPED
> >                 suite_index = int(match.group(2))
> >                 if suite_index != expected_suite_index:
> >                         print_with_timestamp(
> > @@ -224,8 +234,8 @@ def parse_ok_not_ok_test_suite(lines: List[str],
> >         else:
> >                 return False
> >
> > -def bubble_up_errors(statuses: Iterable[TestStatus]) -> TestStatus:
> > -       return reduce(max_status, statuses, TestStatus.SUCCESS)
> > +def bubble_up_errors(status_list: Iterable[TestStatus]) -> TestStatus:
> > +       return reduce(max_status, status_list, TestStatus.SKIPPED)
> >
> >  def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
> >         max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
> > @@ -315,9 +325,12 @@ def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
>
> Btw, this type annotation is out of date.

Oops: will fix and/or replace with the below.

> But I think an ever growing Tuple is too cumbersome, how about this?
>

Yeah, this does seem cleaner: I'll put this or something like it in v2.

> diff --git a/tools/testing/kunit/kunit_parser.py
> b/tools/testing/kunit/kunit_parser.py
> index 6b5dd26b479d..055ee1e4d19d 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -6,6 +6,7 @@
>  # Author: Felix Guo <felixguoxiuping@gmail.com>
>  # Author: Brendan Higgins <brendanhiggins@google.com>
>
> +from dataclasses import dataclass
>  import re
>
>  from collections import namedtuple
> @@ -321,11 +322,19 @@ def parse_test_result(lines: List[str]) -> TestResult:
>         else:
>                 return TestResult(TestStatus.NO_TESTS, [], lines)
>
> -def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
> -       total_tests = 0
> -       failed_tests = 0
> -       crashed_tests = 0
> -       skipped_tests = 0
> +#  Note: This would require Python 3.7. We currently only required
> 3.6 (enum.auto). We can do it by hand to avoid that, if we want.

Hmm... I'm generally loath to increase the version requirement for
something this simple, so might look into doing a version of this
without the dataclass.


> +@dataclass
> +class TestCounts:
> +       passed: int = 0
> +       failed: int = 0
> +       skipped: int = 0
> +       crashed: int = 0
> +
> +       def total(self) -> int:
> +               return self.passed + self.failed + self.skipped + self.crashed
> +
> +def print_and_count_results(test_result: TestResult) -> TestCounts:
> +       counts = TestCounts()
>         for test_suite in test_result.suites:
>                 if test_suite.status == TestStatus.SUCCESS:
>                         print_suite_divider(green('[PASSED] ') +
> test_suite.name)
> @@ -336,39 +345,33 @@ def print_and_count_results(test_result:
> TestResult) -> Tuple[int, int, int]:
>                 else:
>                         print_suite_divider(red('[FAILED] ') + test_suite.name)
>                 for test_case in test_suite.cases:
> -                       total_tests += 1
>                         if test_case.status == TestStatus.SUCCESS:
> +                               counts.passed += 1
>                                 print_with_timestamp(green('[PASSED]
> ') + test_case.name)
>                         elif test_case.status == TestStatus.SKIPPED:
> -                               skipped_tests += 1
> +                               counts.skipped += 1
>                                 print_with_timestamp(yellow('[SKIPPED]
> ') + test_case.name)
>                         elif test_case.status == TestStatus.TEST_CRASHED:
> -                               crashed_tests += 1
> +                               counts.crashed += 1
>                                 print_with_timestamp(red('[CRASHED] '
> + test_case.name))
>                                 print_log(map(yellow, test_case.log))
>                                 print_with_timestamp('')
>                         else:
> -                               failed_tests += 1
> +                               counts.failed += 1
>                                 print_with_timestamp(red('[FAILED] ')
> + test_case.name)
>                                 print_log(map(yellow, test_case.log))
>                                 print_with_timestamp('')
> -       return total_tests, failed_tests, crashed_tests, skipped_tests
> +       return counts
>
>  def parse_run_tests(kernel_output) -> TestResult:
> -       total_tests = 0
> -       failed_tests = 0
> -       crashed_tests = 0
> -       skipped_tests = 0
> +       counts = TestCounts()
>         test_result =
> parse_test_result(list(isolate_kunit_output(kernel_output)))
>         if test_result.status == TestStatus.NO_TESTS:
>                 print(red('[ERROR] ') + yellow('no tests run!'))
>         elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
>                 print(red('[ERROR] ') + yellow('could not parse test results!'))
>         else:
> -               (total_tests,
> -                failed_tests,
> -                crashed_tests,
> -                skipped_tests) = print_and_count_results(test_result)
> +               counts = print_and_count_results(test_result)
>         print_with_timestamp(DIVIDER)
>         if test_result.status == TestStatus.SUCCESS:
>                 fmt = green
> @@ -378,5 +381,5 @@ def parse_run_tests(kernel_output) -> TestResult:
>                 fmt =red
>         print_with_timestamp(
>                 fmt('Testing complete. %d tests run. %d failed. %d
> crashed. %d skipped.' %
> -                   (total_tests, failed_tests, crashed_tests, skipped_tests)))
> +                   (counts.total(), counts.failed, counts.crashed,
> counts.skipped)))
>         return test_result
>
> >         total_tests = 0
> >         failed_tests = 0
> >         crashed_tests = 0
> > +       skipped_tests = 0
> >         for test_suite in test_result.suites:
> >                 if test_suite.status == TestStatus.SUCCESS:
> >                         print_suite_divider(green('[PASSED] ') + test_suite.name)
> > +               elif test_suite.status == TestStatus.SKIPPED:
> > +                       print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
> >                 elif test_suite.status == TestStatus.TEST_CRASHED:
> >                         print_suite_divider(red('[CRASHED] ' + test_suite.name))
> >                 else:
> > @@ -326,6 +339,9 @@ def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
> >                         total_tests += 1
> >                         if test_case.status == TestStatus.SUCCESS:
> >                                 print_with_timestamp(green('[PASSED] ') + test_case.name)
> > +                       elif test_case.status == TestStatus.SKIPPED:
> > +                               skipped_tests += 1
> > +                               print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
> >                         elif test_case.status == TestStatus.TEST_CRASHED:
> >                                 crashed_tests += 1
> >                                 print_with_timestamp(red('[CRASHED] ' + test_case.name))
> > @@ -336,12 +352,13 @@ def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
> >                                 print_with_timestamp(red('[FAILED] ') + test_case.name)
> >                                 print_log(map(yellow, test_case.log))
> >                                 print_with_timestamp('')
> > -       return total_tests, failed_tests, crashed_tests
> > +       return total_tests, failed_tests, crashed_tests, skipped_tests
> >
> >  def parse_run_tests(kernel_output) -> TestResult:
> >         total_tests = 0
> >         failed_tests = 0
> >         crashed_tests = 0
> > +       skipped_tests = 0
> >         test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
> >         if test_result.status == TestStatus.NO_TESTS:
> >                 print(red('[ERROR] ') + yellow('no tests run!'))
> > @@ -350,10 +367,16 @@ def parse_run_tests(kernel_output) -> TestResult:
> >         else:
> >                 (total_tests,
> >                  failed_tests,
> > -                crashed_tests) = print_and_count_results(test_result)
> > +                crashed_tests,
> > +                skipped_tests) = print_and_count_results(test_result)
> >         print_with_timestamp(DIVIDER)
> > -       fmt = green if test_result.status == TestStatus.SUCCESS else red
> > +       if test_result.status == TestStatus.SUCCESS:
> > +               fmt = green
> > +       elif test_result.status == TestStatus.SKIPPED:
> > +               fmt = yellow
> > +       else:
> > +               fmt =red
> >         print_with_timestamp(
> > -               fmt('Testing complete. %d tests run. %d failed. %d crashed.' %
> > -                   (total_tests, failed_tests, crashed_tests)))
> > +               fmt('Testing complete. %d tests run. %d failed. %d crashed. %d skipped.' %
> > +                   (total_tests, failed_tests, crashed_tests, skipped_tests)))
> >         return test_result
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 2e809dd956a7..a51e70cafcc1 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -183,6 +183,28 @@ class KUnitParserTest(unittest.TestCase):
> >                         kunit_parser.TestStatus.TEST_CRASHED,
> >                         result.status)
> >
> > +       def test_skipped_test(self):
> > +               skipped_log = test_data_path('test_skip_tests.log')
> > +               file = open(skipped_log)
> > +               result = kunit_parser.parse_run_tests(file.readlines())
> > +
> > +               # A skipped test does not fail the whole suite.
> > +               self.assertEqual(
> > +                       kunit_parser.TestStatus.SUCCESS,
> > +                       result.status)
> > +               file.close()
> > +
> > +       def test_skipped_all_tests(self):
> > +               skipped_log = test_data_path('test_skip_all_tests.log')
> > +               file = open(skipped_log)
> > +               result = kunit_parser.parse_run_tests(file.readlines())
> > +
> > +               self.assertEqual(
> > +                       kunit_parser.TestStatus.SKIPPED,
> > +                       result.status)
> > +               file.close()
> > +
> > +
> >         def test_ignores_prefix_printk_time(self):
> >                 prefix_log = test_data_path('test_config_printk_time.log')
> >                 with open(prefix_log) as file:
> > --
> > 2.31.1.818.g46aad6cb9e-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210526081112.3652290-2-davidgow%40google.com.

--000000000000abd05805c34b75b8
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNUwggO9oAMCAQICEAGb+Q77il3T2Ss3sWOT
zKkwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMTAyMDUy
MzQwMjdaFw0yMTA4MDQyMzQwMjdaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCp88g1fYbjEPVlaL9sUToZwjKCeCIS
JqYR/IR1FgbA8vq7+rNlr9/1AFLZe4/qh3CwWzh42UIERZpqut/ict9jfisWWKnXPaEQkibkZ+NL
OPIT51cC0QX5nv7zFf28tPZ6V4KewX3UtB/8JDcybfVeQlZ0S1UMVfg93wMXe59FKN/QYbLDzQSg
Yc/5ExUVV6UgoEXVbxTuJv45hvdihw6Eme65MfC0CUPeiZ1sfQjfSYi7CY517JOATvD84ZPX0GQV
cRb6N52CERoIy/7ni857uvf5fAmGdzR6VZgtGL5/nO1Jb/KmNMsat7pnRbgHx5qYLLN2+oCS8Jp7
0VoZRTiBAgMBAAGjggHRMIIBzTAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFG2lY2ZX
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
AhABm/kO+4pd09krN7Fjk8ypMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDlvhXA
0E3StgRqZEOE20tNKba/wjUVC2zPiTH4Dfg3JjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA1MjcwODIyMjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAOoC7qMkaYgr8FazuwCPh4xwR
lMylEDGETSoDWlkudeJyux+OfLZq1QPUZR0IMkgKbEM6YiVMFljsWgPs1ARnWP0LZBbX7kcml03C
CZT37MEhdRFgYb/3z0Jv+TD0d4JHjQw8qjF2S08O9ErgZIou44AO4Zake6yxOFI2jx9t/htSMyLp
p4JOA0n2EoVUxMEpy4d8eVfIqB86sdYYxTf3SCHCiUPdCk96yGG+gM9O6SeFyKUEzQaZXSYVICWL
oLQF437rdXq0IGFHl+CYVii4c6g8SMetF+9Lu1X34N0zyt8Ldd3nyNtJ4zp1koq48BHcH9kkJCIV
yQ9Om5znBH5Wtw==
--000000000000abd05805c34b75b8--
