Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B993B8B6C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jul 2021 02:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbhGAAvD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 20:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbhGAAvC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 20:51:02 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BE2C0617A8
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jun 2021 17:48:32 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id l5so5422983iok.7
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jun 2021 17:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Im56R+xnJFTq67zDpPu8OMBxlFOXYPorOH2M+pwneH4=;
        b=C5xLGf6ismCiaFckX0nYu3DqRVtYlqpRwBlrq/2xI3EQGuT1jMNM/jlPs+WAq/ulQS
         vuuznC27es660FdPk91EvNcs391xSGxuj9wVPBPtdCdH+L0+bSkyuVNcZpdKTPy6Crfb
         NyScKCxQpNNk0f/iuiow7A2L1EWWfGBVNHgJ6mPKgFr6HcXUZMiFLt20gCvXplTRIWT4
         +2MTs40XiK7rIMekol9kBz0Emh/Fngc9WLwofSlzRdo5JJ6mu3TqVnRi0IZJsxXrGZ+L
         pMew2JUOKKcJY78riSZjb/SXRT2ReFMVqcP2SKltfQwDm7hAU3GMD3nIUlQHXfS2e1HW
         jAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Im56R+xnJFTq67zDpPu8OMBxlFOXYPorOH2M+pwneH4=;
        b=EIbXa1QAMDbQZ6RJFpxsEWaf2Z5lsxbKws4fJoF9zGuIOKguswEsSeC9fw4z0J1kW1
         PfcDwZX0yHT0OHeHpXe8PCwCCZNXBjw2w900p6HidFu+yk+ohQnvmSYbjooFNbv5eJd7
         notSDX/k9YIrQlK8UwmDe/lTWdRgL6eaxMmZsdZwSZCGQ9YCQAqEqN0JFIYS1Be0ifZA
         24ffe5gvrYJebaDFtRTJJf4wM//lUEOLuLSwOTWhzD80ZyzaT0cSrbQzV+xcrxQEDic7
         0t9cKKOISiUZbQVBGnSJg6bEDN2Yb3i+x39bSnk+8oJM0COpJv+YO58utqZz2CKZdAgb
         +rzg==
X-Gm-Message-State: AOAM5338rqZM8rf05rDPlWYfeKq7YI0CW+lUFR5F0RjV+dIIUA0I4bm4
        Ka+IKyUdqxfakdIqlA3V+vpycwlqg3U8ElTChYo3UA==
X-Google-Smtp-Source: ABdhPJzOEzBpNjZv/g4VmVSqHwkVl5/bEWCM9dsuEtah+TtfbszV5NSbcI8TPnxExdY5dIbQlDmzDzjNbCKNH74f0Nc=
X-Received: by 2002:a6b:cf12:: with SMTP id o18mr10063502ioa.86.1625100511733;
 Wed, 30 Jun 2021 17:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210630233950.1638536-1-rmoar@google.com>
In-Reply-To: <20210630233950.1638536-1-rmoar@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 30 Jun 2021 17:48:20 -0700
Message-ID: <CAGS_qxoGAw8sSHQDS-xR6M6ocJYY5DTbtHLebsdFE41K1euPNg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix error messages for cases of no tests and
 wrong TAP header
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com, shuah@kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 30, 2021 at 4:40 PM Rae Moar <rmoar@google.com> wrote:
>
> This patch addresses misleading error messages reported by kunit_tool in
> two cases. First, in the case of TAP output having an incorrect header
> format or missing a header, the parser used to output an error message of
> 'no tests run!'. Now the parser outputs an error message of 'could not
> parse test results!'.
>
> As an example:
>
> Before:
> $ ./tools/testing/kunit/kunit.py parse /dev/null
> [ERROR] no tests run!
> ...
>
> After:
> $ ./tools/testing/kunit/kunit.py parse /dev/null
> [ERROR] could not parse test results!
> ...
>
> Second, in the case of TAP output with the correct header but no
> tests, the parser used to output an error message of 'could not parse
> test results!'. Now the parser outputs an error message of 'no tests
> run!'.
>
> As an example:
>
> Before:
> $ echo -e 'TAP version 14\n1..0' | ./tools/testing/kunit/kunit.py parse
> [ERROR] could not parse test results!
>
> After:
> $ echo -e 'TAP version 14\n1..0' | ./tools/testing/kunit/kunit.py parse
> [ERROR] no tests run!
>
> Additionally, this patch also corrects the tests in kunit_tool_test.py
> and adds a test to check the error in the case of TAP output with the
> correct header but no tests (the log for this test was simplified from
> the first version of this patch).

Just as a note: usually people will mention changes between versions
of a patch series just above the diffstat.
Picking a random example from linux-kselftest:
https://lore.kernel.org/linux-kselftest/20210630081202.4423-7-yangbo.lu@nxp.com/

Note the extra "---" above those change notes, just like above the diffstat.

>
> Signed-off-by: Rae Moar <rmoar@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks! Looks good to me.

Just a note to others, this is a v2 of
https://lore.kernel.org/linux-kselftest/20210629223541.1512296-1-rmoar@google.com/

> ---
>  tools/testing/kunit/kunit_parser.py              |  6 ++++--
>  tools/testing/kunit/kunit_tool_test.py           | 16 +++++++++++++---
>  ...st_is_test_passed-no_tests_run_no_header.log} |  0
>  ...t_is_test_passed-no_tests_run_with_header.log |  2 ++
>  4 files changed, 19 insertions(+), 5 deletions(-)
>  rename tools/testing/kunit/test_data/{test_is_test_passed-no_tests_run.log => test_is_test_passed-no_tests_run_no_header.log} (100%)
>  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index c3c524b79db8..b88db3f51dc5 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -338,9 +338,11 @@ def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
>  def parse_test_result(lines: LineStream) -> TestResult:
>         consume_non_diagnostic(lines)
>         if not lines or not parse_tap_header(lines):
> -               return TestResult(TestStatus.NO_TESTS, [], lines)
> +               return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
>         expected_test_suite_num = parse_test_plan(lines)
> -       if not expected_test_suite_num:
> +       if expected_test_suite_num == 0:
> +               return TestResult(TestStatus.NO_TESTS, [], lines)
> +       elif expected_test_suite_num is None:
>                 return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
>         test_suites = []
>         for i in range(1, expected_test_suite_num + 1):
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index bdae0e5f6197..75045aa0f8a1 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -157,8 +157,18 @@ class KUnitParserTest(unittest.TestCase):
>                         kunit_parser.TestStatus.FAILURE,
>                         result.status)
>
> +       def test_no_header(self):
> +               empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
> +               with open(empty_log) as file:
> +                       result = kunit_parser.parse_run_tests(
> +                               kunit_parser.extract_tap_lines(file.readlines()))
> +               self.assertEqual(0, len(result.suites))
> +               self.assertEqual(
> +                       kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
> +                       result.status)
> +
>         def test_no_tests(self):
> -               empty_log = test_data_path('test_is_test_passed-no_tests_run.log')
> +               empty_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
>                 with open(empty_log) as file:
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readlines()))
> @@ -173,7 +183,7 @@ class KUnitParserTest(unittest.TestCase):
>                 with open(crash_log) as file:
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readlines()))
> -               print_mock.assert_any_call(StrContains('no tests run!'))
> +               print_mock.assert_any_call(StrContains('could not parse test results!'))
>                 print_mock.stop()
>                 file.close()
>
> @@ -309,7 +319,7 @@ class KUnitJsonTest(unittest.TestCase):
>                         result["sub_groups"][1]["test_cases"][0])
>
>         def test_no_tests_json(self):
> -               result = self._json_for('test_is_test_passed-no_tests_run.log')
> +               result = self._json_for('test_is_test_passed-no_tests_run_with_header.log')
>                 self.assertEqual(0, len(result['sub_groups']))
>
>  class StrContains(str):
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_no_header.log
> similarity index 100%
> rename from tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
> rename to tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_no_header.log
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log
> new file mode 100644
> index 000000000000..5f48ee659d40
> --- /dev/null
> +++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log
> @@ -0,0 +1,2 @@
> +TAP version 14
> +1..0
> --
> 2.32.0.93.g670b81a890-goog
>
