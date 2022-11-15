Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1C162926D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 08:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiKOH2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 02:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiKOH2C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 02:28:02 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9591B1E1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 23:27:58 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id w2so2737297uap.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 23:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX7ePePki+BrAPhZ2eV+ncBSgk624PXA7VJDNChT5N8=;
        b=qxCAX0E8iq18XrGOLf+dr61/d76I0YcY/oZg9Hw3QV59eeyF+0ZBfuuhhZWWT/Vf2i
         wiSF8c5hF1RfbY3P26y8+0gSO44GS1T9rDPFr462sDCs5IbDjMxffDpr6840cLlWj7zq
         etQVIkENm3TGtxGUJhcQMsbNVK3cxw2e2RP+JydB4SHLDaYNA5RJOE8xCJsxLn0Aw386
         BCqaNCcAoiIRVQqD83C6SR7XXrgTlOfBaaDZZ8DMaZvDxZcEi9TpRAFZhCvGKsJNefho
         XsA089hjt8WRiWquiEYsjZTCxpd/aAvrtbQWBQAHflQua+5OsK2RMcXmKR9fqr2vltkO
         MW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZX7ePePki+BrAPhZ2eV+ncBSgk624PXA7VJDNChT5N8=;
        b=tgZXYyjDFNcDAMHfpEeTsPBcue8JsEtBESJfbHryzAx0W2UG34tTkZNRCewtMQvHvC
         vxAcUlaCI0AuRCodHvALpuOEresU/wkvONn87DDDiDhCi8PHkRZPqB1eupR3zB9wIj6p
         2xjDVa1XzG/dxsn6LZ4Swof9ODlGnNGjk8b1Gf+2Pw76uJ8bwjTzJ1ovrOvZs9SpSSQf
         UmAFS1RNkLmQDe1TAvOCW1y5L8xxmQEzSb98OM1WJAs/Y5/SlDqLK/9uu6h2ip+l7j1a
         5aEm0Ku6Geyf90hUP9cpMFhXYzfDID9+mysKic/sT5Um2dBj6q69qn6V3OnXllwaC78s
         mpNQ==
X-Gm-Message-State: ANoB5pm+mD4QhvZ9Y7niBFD/Pn/t/iRVCene5JNdODN3ciSwWzlSJnD6
        O2y5PHw1zSLA3Olp/NQarQD0tbz3T3YI+Y1If61KzQ==
X-Google-Smtp-Source: AA0mqf6V1rB9xGXsEmogrGXur/EgDRBUOXvbMw2BlVxn/wS6RDKujzJCRbERtQctSmEY3t2sU+RruJ3/afZGLFMYxxQ=
X-Received: by 2002:ab0:4ac7:0:b0:411:968:212 with SMTP id t7-20020ab04ac7000000b0041109680212mr9261443uae.107.1668497277053;
 Mon, 14 Nov 2022 23:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com> <20221104194705.3245738-2-rmoar@google.com>
In-Reply-To: <20221104194705.3245738-2-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Nov 2022 15:27:45 +0800
Message-ID: <CABVgOS=eq0RnnP=MGMb-mZntA7+yZ=pe3U_dOq1gxoTPTeC8Bw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kunit: tool: parse KTAP compliant test output
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000087fd3a05ed7d4b48"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000087fd3a05ed7d4b48
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 5, 2022 at 3:48 AM Rae Moar <rmoar@google.com> wrote:
>
> Change the KUnit parser to be able to parse test output that complies with
> the KTAP version 1 specification format found here:
> https://kernel.org/doc/html/latest/dev-tools/ktap.html. Ensure the parser
> is able to parse tests with the original KUnit test output format as
> well.
>
> KUnit parser now accepts any of the following test output formats:
>
> Original KUnit test output format:
>
>  TAP version 14
>  1..1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 - kunit_test_1
>    ok 2 - kunit_test_2
>    ok 3 - kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 - kunit-test-suite
>
> KTAP version 1 test output format:
>
>  KTAP version 1
>  1..1
>    KTAP version 1
>    1..3
>    ok 1 kunit_test_1
>    ok 2 kunit_test_2
>    ok 3 kunit_test_3
>  ok 1 kunit-test-suite
>
> New KUnit test output format (preferred for KUnit tests):
>
>  KTAP version 1
>  1..1
>    # Subtest: kunit-test-suite
>    KTAP version 1
>    1..3
>    ok 1 kunit_test_1
>    ok 2 kunit_test_2
>    ok 3 kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 kunit-test-suite
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
> Note: this patch is based on the linux-kselftest/kunit branch.
> ---

Looks good to me. Some minor thoughts:
- As Daniel mentioned, can we think of a better placeholder name for
tests without Subtest lines? One thought is to just leave it as the
empty string?
- Would it make sense to support the case where the "Subtest" line
sits between the KTAP version line and the test plan as well. While
that's not necessary (and does violate v1 of the KTAP spec), I suspect
something similar would be useful in KTAP v2 for, e.g., individual
module results.
- As mentioned in patch 1, it'd be nice to swap the ordering of the two patches.

None of those are showstoppers, so if you disagree, we can probably
accept them as-is, but they might make future changes easier.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


> tools/testing/kunit/kunit_parser.py           | 69 ++++++++++++-------
>  tools/testing/kunit/kunit_tool_test.py        |  8 +++
>  .../test_data/test_parse_ktap_output.log      |  8 +++
>  3 files changed, 60 insertions(+), 25 deletions(-)
>  create mode 100644 tools/testing/kunit/test_data/test_parse_ktap_output.log
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index a56c75a973b5..abb69f898263 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -441,6 +441,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
>         - '# Subtest: [test name]'
>         - '[ok|not ok] [test number] [-] [test name] [optional skip
>                 directive]'
> +       - 'KTAP version [version number]'
>
>         Parameters:
>         lines - LineStream of KTAP output to parse
> @@ -449,8 +450,9 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
>         Log of diagnostic lines
>         """
>         log = []  # type: List[str]
> -       while lines and not TEST_RESULT.match(lines.peek()) and not \
> -                       TEST_HEADER.match(lines.peek()):
> +       non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START]
> +       while lines and not any(re.match(lines.peek())
> +                       for re in non_diagnostic_lines):
>                 log.append(lines.pop())
>         return log
>
> @@ -496,6 +498,12 @@ def print_test_header(test: Test) -> None:
>         test - Test object representing current test being printed
>         """
>         message = test.name
> +       if message == "":
> +               # KUnit tests print a Subtest header line that provides the name
> +               # of the test suite. But the subtest header line isn't required
> +               # by the KTAP spec, so use a placeholder name "Test suite" in that
> +               # case.
> +               message = "Test suite"
>         if test.expected_count:
>                 if test.expected_count == 1:
>                         message += ' (1 subtest)'
> @@ -647,13 +655,13 @@ def bubble_up_test_results(test: Test) -> None:
>         elif test.counts.get_status() == TestStatus.TEST_CRASHED:
>                 test.status = TestStatus.TEST_CRASHED
>
> -def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
> +def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool) -> Test:
>         """
>         Finds next test to parse in LineStream, creates new Test object,
>         parses any subtests of the test, populates Test object with all
>         information (status, name) about the test and the Test objects for
>         any subtests, and then returns the Test object. The method accepts
> -       three formats of tests:
> +       four formats of tests:
>
>         Accepted test formats:
>
> @@ -674,6 +682,16 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>         [subtests]
>         ok 1 name
>
> +       - KTAP subtest header (in compliance with KTAP specification)
> +
> +       Example:
> +
> +    # May include subtest header line here
> +       KTAP version 1
> +       1..3
> +       [subtests]
> +       ok 1 name
> +
>         - Test result line
>
>         Example:
> @@ -685,6 +703,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>         expected_num - expected test number for test to be parsed
>         log - list of strings containing any preceding diagnostic lines
>                 corresponding to the current test
> +       is_subtest - boolean indicating whether test is a subtest
>
>         Return:
>         Test object populated with characteristics and any subtests
> @@ -692,21 +711,22 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>         test = Test()
>         test.log.extend(log)
>         parent_test = False
> -       main = parse_ktap_header(lines, test)
> -       if main:
> -               # If KTAP/TAP header is found, attempt to parse
> -               # test plan
> +       if not is_subtest:
> +               # If parsing the main test, attempt to parse KTAP/TAP header
> +               # and test plan
>                 test.name = "main"
> +               parse_ktap_header(lines, test)
>                 parse_test_plan(lines, test)
>                 parent_test = True
>         else:
> -               # If KTAP/TAP header is not found, test must be subtest
> -               # header or test result line so parse attempt to parser
> -               # subtest header
> -               parent_test = parse_test_header(lines, test)
> +               # If test is a subtest, attempt to parse test suite header
> +               # (either subtest line and/or KTAP/TAP version line)
> +               subtest_line = parse_test_header(lines, test)
> +               ktap_line = parse_ktap_header(lines, test)
> +               parent_test = subtest_line or ktap_line
>                 if parent_test:
> -                       # If subtest header is found, attempt to parse
> -                       # test plan and print header
> +                       # If subtest header and/or KTAP/version line is found, attempt
> +                       # to parse test plan and print header
>                         parse_test_plan(lines, test)
>                         print_test_header(test)
>         expected_count = test.expected_count
> @@ -721,7 +741,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>                 sub_log = parse_diagnostic(lines)
>                 sub_test = Test()
>                 if not lines or (peek_test_name_match(lines, test) and
> -                               not main):
> +                               is_subtest):
>                         if expected_count and test_num <= expected_count:
>                                 # If parser reaches end of test before
>                                 # parsing expected number of subtests, print
> @@ -735,20 +755,19 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>                                 test.log.extend(sub_log)
>                                 break
>                 else:
> -                       sub_test = parse_test(lines, test_num, sub_log)
> +                       sub_test = parse_test(lines, test_num, sub_log, True)
>                 subtests.append(sub_test)
>                 test_num += 1
>         test.subtests = subtests
> -       if not main:
> +       if is_subtest:
>                 # If not main test, look for test result line
>                 test.log.extend(parse_diagnostic(lines))
> -               if (parent_test and peek_test_name_match(lines, test)) or \
> -                               not parent_test:
> -                       parse_test_result(lines, test, expected_num)
> -               else:
> +               if subtest_line and not peek_test_name_match(lines, test):
>                         test.add_error('missing subtest result line!')
> +               else:
> +                       parse_test_result(lines, test, expected_num)
>
> -       # Check for there being no tests
> +       # Check for there being no subtests within parent test
>         if parent_test and len(subtests) == 0:
>                 # Don't override a bad status if this test had one reported.
>                 # Assumption: no subtests means CRASHED is from Test.__init__()
> @@ -758,11 +777,11 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>
>         # Add statuses to TestCounts attribute in Test object
>         bubble_up_test_results(test)
> -       if parent_test and not main:
> +       if parent_test and is_subtest:
>                 # If test has subtests and is not the main test object, print
>                 # footer.
>                 print_test_footer(test)
> -       elif not main:
> +       elif is_subtest:
>                 print_test_result(test)
>         return test
>
> @@ -785,7 +804,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
>                 test.add_error('could not find any KTAP output!')
>                 test.status = TestStatus.FAILURE_TO_PARSE_TESTS
>         else:
> -               test = parse_test(lines, 0, [])
> +               test = parse_test(lines, 0, [], False)
>                 if test.status != TestStatus.NO_TESTS:
>                         test.status = test.counts.get_status()
>         stdout.print_with_timestamp(DIVIDER)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 90c65b072be9..7c2e2a45f330 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -312,6 +312,14 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(kunit_parser._summarize_failed_tests(result),
>                         'Failures: all_failed_suite, some_failed_suite.test2')
>
> +       def test_ktap_format(self):
> +               ktap_log = test_data_path('test_parse_ktap_output.log')
> +               with open(ktap_log) as file:
> +                       result = kunit_parser.parse_run_tests(file.readlines())
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=3))
> +               self.assertEqual('suite', result.subtests[0].name)
> +               self.assertEqual('case_1', result.subtests[0].subtests[0].name)
> +               self.assertEqual('case_2', result.subtests[0].subtests[1].name)
>
>  def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
>         return kunit_parser.LineStream(enumerate(strs, start=1))
> diff --git a/tools/testing/kunit/test_data/test_parse_ktap_output.log b/tools/testing/kunit/test_data/test_parse_ktap_output.log
> new file mode 100644
> index 000000000000..ccdf244e5303
> --- /dev/null
> +++ b/tools/testing/kunit/test_data/test_parse_ktap_output.log
> @@ -0,0 +1,8 @@
> +KTAP version 1
> +1..1
> +  KTAP version 1
> +  1..3
> +  ok 1 case_1
> +  ok 2 case_2
> +  ok 3 case_3
> +ok 1 suite
> --
> 2.38.1.431.g37b22c650d-goog
>

--00000000000087fd3a05ed7d4b48
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCe
zAL/NpAJcPzGPD0x0X+oy7PT2WIOvXn6cZcmPWPD+jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMTUwNzI3NTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALIyEagOqLfA/DPE4JJI9
vlGTTFNVrzjaYDmSpFK4DpVIxP4FO7a6ACSfB1Zxf84wDV6El1Ur34QldWOWqnU5QrkDPQNF8LNA
S7CLNschuTMYZZMVJhIImwDStVBpq2SLefwKGlNLLzmIaI20Viujy0aYSLLbBtNSW5AH/x32KhU1
a6EzoKScn047r6d17W1MZJKbBFArIh2Iuv1R4u49luawDqkOFuULdE93KnOyEay1Wj0ozZPxS/w5
hBpMukWfoZ/SwFdPDblevsYqhytxwhymXaQtyyIZTrer97nmUqBhX/p9iPNaZL6EtNF2hknZdCBU
uZXuuc/50vdWFacqrg==
--00000000000087fd3a05ed7d4b48--
