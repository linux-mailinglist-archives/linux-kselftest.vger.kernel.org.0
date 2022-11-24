Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2610637450
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 09:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiKXIpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Nov 2022 03:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKXIpW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Nov 2022 03:45:22 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC7ACEB8
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Nov 2022 00:45:20 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id d185so954861vsd.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Nov 2022 00:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wuRRcFSW6aRgqxy5f45YoRGbIAomB/Qu/NFG31wwsM=;
        b=M30chwsetkvH7qtcnPCHrCZRj0iu7MhDu6QFKTeWe7Y7nEssnHeFzXa7e+s5c+rCqc
         C9KL5K3xU/ULs8mCF1PdD2jCuTPMKjD6AXq+KhW+MdszUoHa/MJPGosp2CNFeFRUsry/
         GOp+usszbMeifQapwoDdWChnBDPHauPH2yem8opkaSfA+/DFZZEpes+OzlBoxmp/N6BY
         mmmRnrNvRIytPu/peynss1VZgFeqBv5DXb7pgQQwApH4rhUT6Yv4Eeq2GPWFr7hLET3m
         LCLgCW5SSnMnmHO5i3iDK1CF8+9xP0A52TfxI2XfDiR9cIBxHEu1kaCfjUGjPZ2/wA6n
         HOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wuRRcFSW6aRgqxy5f45YoRGbIAomB/Qu/NFG31wwsM=;
        b=BiihYDAnT843Fx9IHUN4tRTyE7ffxoDqmkB5zJQb/iU8EUiYeTyQPLXn8FQ03+PKnQ
         xAEGQQmjMOclj1rQhGgwN4ZrKENYvk4X0Oyiwh7m1W4l2h2D3n33Y8XgV+3XVRhFiULw
         7y5l6D9S2np9Ui/IWgaDXKuseS/sapWLhPj6HAsabRARSoPlRdNNiRKTBzcUHI08zDl/
         7bHF8BvjJIwkdWRJ3acVLFtUgCs4fkHTaN56Y7e3dh97Y9w/kL28csPimeD2S0mF84DG
         6dqNmsQYlkZYiMLIueK6V/EPPPYZ5bhfApH/I09X9QzE7kXjJ6U4Fj3vAx/XQRpcuVLj
         icag==
X-Gm-Message-State: ANoB5pn+6RuqljkFJnGlUzVC/5OmQLPgIEBkQUdBRhALx9OOlP/4dLUD
        SNQXWrUWy8w/ELKW4ZWYlx/HmrM6Nd9xfpRvsi5F7g==
X-Google-Smtp-Source: AA0mqf5/0a2q6JgW7Wih23WCqF9TG4kh7Un7g91hOG/vNi8RVPYP4ANbeVDYVhxBYsIciUBRROuwKs8Sr7zkLOlxM8o=
X-Received: by 2002:a05:6102:c0d:b0:3af:2b1c:9908 with SMTP id
 x13-20020a0561020c0d00b003af2b1c9908mr19508533vss.18.1669279519556; Thu, 24
 Nov 2022 00:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20221123182558.2203639-1-rmoar@google.com>
In-Reply-To: <20221123182558.2203639-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 24 Nov 2022 16:45:08 +0800
Message-ID: <CABVgOSmn_uTZQ4OzZQM02QEbmzxvd+gJn1M8S2KGhPSEqcjW7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: tool: parse KTAP compliant test output
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, isabbasso@riseup.net,
        anders.roxell@linaro.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d2d58905ee336cd7"
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

--000000000000d2d58905ee336cd7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2022 at 2:26 AM Rae Moar <rmoar@google.com> wrote:
>
> Change the KUnit parser to be able to parse test output that complies wit=
h
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
> New KUnit test output format (changes made in the next patch of
> this series):
>
>  KTAP version 1
>  1..1
>    KTAP version 1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 kunit_test_1
>    ok 2 kunit_test_2
>    ok 3 kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 kunit-test-suite
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>

Thanks for fixing these things. This still looks good to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


> Changes since v2:
> https://lore.kernel.org/all/CA+GJov4QZ8yrD8sgGeMYJ4zYkg2CEUX8owqzPFE0BQGe=
_f0bFQ@mail.gmail.com/
> - Rebased onto linux-kselftest/kunit to correct merge conflict with
>   recently approved patch
> - Fixed typo
> - Added test_parse_subtest_header to test whether the =E2=80=9C# Subtest:=
=E2=80=9D
>   line is being parsed correctly when using the new test format
>
> Changes since v1:
> https://lore.kernel.org/all/20221104194705.3245738-2-rmoar@google.com/
> - Switch order of patches to make changes to the parser before making
> changes to the test output
> - Change placeholder label for test header from =E2=80=9CTest suite=E2=80=
=9D to empty
> string
> - Change parser to approve the new KTAP version line in the subtest heade=
r
> to be before the subtest header line rather than after.
> - Note: Considered changing parser to allow for the top-level of testing
> to have a '# Subtest' line as discussed in v1 but this breaks the missing
> test plan test. So I think it would be best to add this ability at a late=
r
> time or after top-level test name and result lines are discussed for
> KTAP v2.
>
>  tools/testing/kunit/kunit_parser.py           | 79 ++++++++++++-------
>  tools/testing/kunit/kunit_tool_test.py        | 14 ++++
>  .../test_data/test_parse_ktap_output.log      |  8 ++
>  .../test_data/test_parse_subtest_header.log   |  7 ++
>  4 files changed, 80 insertions(+), 28 deletions(-)
>  create mode 100644 tools/testing/kunit/test_data/test_parse_ktap_output.=
log
>  create mode 100644 tools/testing/kunit/test_data/test_parse_subtest_head=
er.log
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/ku=
nit_parser.py
> index d0ed5dd5cfc4..4cc2f8b7ecd0 100644
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
>         log =3D []  # type: List[str]
> -       while lines and not TEST_RESULT.match(lines.peek()) and not \
> -                       TEST_HEADER.match(lines.peek()):
> +       non_diagnostic_lines =3D [TEST_RESULT, TEST_HEADER, KTAP_START]
> +       while lines and not any(re.match(lines.peek())
> +                       for re in non_diagnostic_lines):
>                 log.append(lines.pop())
>         return log
>
> @@ -496,11 +498,15 @@ def print_test_header(test: Test) -> None:
>         test - Test object representing current test being printed
>         """
>         message =3D test.name
> +       if message !=3D "":
> +               # Add a leading space before the subtest counts only if a=
 test name
> +               # is provided using a "# Subtest" header line.
> +               message +=3D " "
>         if test.expected_count:
>                 if test.expected_count =3D=3D 1:
> -                       message +=3D ' (1 subtest)'
> +                       message +=3D '(1 subtest)'
>                 else:
> -                       message +=3D f' ({test.expected_count} subtests)'
> +                       message +=3D f'({test.expected_count} subtests)'
>         stdout.print_with_timestamp(format_test_divider(message, len(mess=
age)))
>
>  def print_log(log: Iterable[str]) -> None:
> @@ -647,7 +653,7 @@ def bubble_up_test_results(test: Test) -> None:
>         elif test.counts.get_status() =3D=3D TestStatus.TEST_CRASHED:
>                 test.status =3D TestStatus.TEST_CRASHED
>
> -def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> =
Test:
> +def parse_test(lines: LineStream, expected_num: int, log: List[str], is_=
subtest: bool) -> Test:
>         """
>         Finds next test to parse in LineStream, creates new Test object,
>         parses any subtests of the test, populates Test object with all
> @@ -665,15 +671,32 @@ def parse_test(lines: LineStream, expected_num: int=
, log: List[str]) -> Test:
>         1..4
>         [subtests]
>
> -       - Subtest header line
> +       - Subtest header (must include either the KTAP version line or
> +         "# Subtest" header line)
>
> -       Example:
> +       Example (preferred format with both KTAP version line and
> +       "# Subtest" line):
> +
> +       KTAP version 1
> +       # Subtest: name
> +       1..3
> +       [subtests]
> +       ok 1 name
> +
> +       Example (only "# Subtest" line):
>
>         # Subtest: name
>         1..3
>         [subtests]
>         ok 1 name
>
> +       Example (only KTAP version line, compliant with KTAP v1 spec):
> +
> +       KTAP version 1
> +       1..3
> +       [subtests]
> +       ok 1 name
> +
>         - Test result line
>
>         Example:
> @@ -685,28 +708,29 @@ def parse_test(lines: LineStream, expected_num: int=
, log: List[str]) -> Test:
>         expected_num - expected test number for test to be parsed
>         log - list of strings containing any preceding diagnostic lines
>                 corresponding to the current test
> +       is_subtest - boolean indicating whether test is a subtest
>
>         Return:
>         Test object populated with characteristics and any subtests
>         """
>         test =3D Test()
>         test.log.extend(log)
> -       parent_test =3D False
> -       main =3D parse_ktap_header(lines, test)
> -       if main:
> -               # If KTAP/TAP header is found, attempt to parse
> +       if not is_subtest:
> +               # If parsing the main/top-level test, parse KTAP version =
line and
>                 # test plan
>                 test.name =3D "main"
> +               ktap_line =3D parse_ktap_header(lines, test)
>                 parse_test_plan(lines, test)
>                 parent_test =3D True
>         else:
> -               # If KTAP/TAP header is not found, test must be subtest
> -               # header or test result line so parse attempt to parser
> -               # subtest header
> -               parent_test =3D parse_test_header(lines, test)
> +               # If not the main test, attempt to parse a test header co=
ntaining
> +               # the KTAP version line and/or subtest header line
> +               ktap_line =3D parse_ktap_header(lines, test)
> +               subtest_line =3D parse_test_header(lines, test)
> +               parent_test =3D (ktap_line or subtest_line)
>                 if parent_test:
> -                       # If subtest header is found, attempt to parse
> -                       # test plan and print header
> +                       # If KTAP version line and/or subtest header is f=
ound, attempt
> +                       # to parse test plan and print test header
>                         parse_test_plan(lines, test)
>                         print_test_header(test)
>         expected_count =3D test.expected_count
> @@ -721,7 +745,7 @@ def parse_test(lines: LineStream, expected_num: int, =
log: List[str]) -> Test:
>                 sub_log =3D parse_diagnostic(lines)
>                 sub_test =3D Test()
>                 if not lines or (peek_test_name_match(lines, test) and
> -                               not main):
> +                               is_subtest):
>                         if expected_count and test_num <=3D expected_coun=
t:
>                                 # If parser reaches end of test before
>                                 # parsing expected number of subtests, pr=
int
> @@ -735,20 +759,19 @@ def parse_test(lines: LineStream, expected_num: int=
, log: List[str]) -> Test:
>                                 test.log.extend(sub_log)
>                                 break
>                 else:
> -                       sub_test =3D parse_test(lines, test_num, sub_log)
> +                       sub_test =3D parse_test(lines, test_num, sub_log,=
 True)
>                 subtests.append(sub_test)
>                 test_num +=3D 1
>         test.subtests =3D subtests
> -       if not main:
> +       if is_subtest:
>                 # If not main test, look for test result line
>                 test.log.extend(parse_diagnostic(lines))
> -               if (parent_test and peek_test_name_match(lines, test)) or=
 \
> -                               not parent_test:
> -                       parse_test_result(lines, test, expected_num)
> -               else:
> +               if test.name !=3D "" and not peek_test_name_match(lines, =
test):
>                         test.add_error('missing subtest result line!')
> +               else:
> +                       parse_test_result(lines, test, expected_num)
>
> -       # Check for there being no tests
> +       # Check for there being no subtests within parent test
>         if parent_test and len(subtests) =3D=3D 0:
>                 # Don't override a bad status if this test had one report=
ed.
>                 # Assumption: no subtests means CRASHED is from Test.__in=
it__()
> @@ -758,11 +781,11 @@ def parse_test(lines: LineStream, expected_num: int=
, log: List[str]) -> Test:
>
>         # Add statuses to TestCounts attribute in Test object
>         bubble_up_test_results(test)
> -       if parent_test and not main:
> +       if parent_test and is_subtest:
>                 # If test has subtests and is not the main test object, p=
rint
>                 # footer.
>                 print_test_footer(test)
> -       elif not main:
> +       elif is_subtest:
>                 print_test_result(test)
>         return test
>
> @@ -785,7 +808,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> =
Test:
>                 test.add_error('Could not find any KTAP output. Did any K=
Unit tests run?')
>                 test.status =3D TestStatus.FAILURE_TO_PARSE_TESTS
>         else:
> -               test =3D parse_test(lines, 0, [])
> +               test =3D parse_test(lines, 0, [], False)
>                 if test.status !=3D TestStatus.NO_TESTS:
>                         test.status =3D test.counts.get_status()
>         stdout.print_with_timestamp(DIVIDER)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit=
/kunit_tool_test.py
> index 84a08cf07242..d7f669cbf2a8 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -312,6 +312,20 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(kunit_parser._summarize_failed_tests(res=
ult),
>                         'Failures: all_failed_suite, some_failed_suite.te=
st2')
>
> +       def test_ktap_format(self):
> +               ktap_log =3D test_data_path('test_parse_ktap_output.log')
> +               with open(ktap_log) as file:
> +                       result =3D kunit_parser.parse_run_tests(file.read=
lines())
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(p=
assed=3D3))
> +               self.assertEqual('suite', result.subtests[0].name)
> +               self.assertEqual('case_1', result.subtests[0].subtests[0]=
.name)
> +               self.assertEqual('case_2', result.subtests[0].subtests[1]=
.name)
> +
> +       def test_parse_subtest_header(self):
> +               ktap_log =3D test_data_path('test_parse_subtest_header.lo=
g')
> +               with open(ktap_log) as file:
> +                       result =3D kunit_parser.parse_run_tests(file.read=
lines())
> +               self.print_mock.assert_any_call(StrContains('suite (1 sub=
test)'))
>
>  def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStrea=
m:
>         return kunit_parser.LineStream(enumerate(strs, start=3D1))
> diff --git a/tools/testing/kunit/test_data/test_parse_ktap_output.log b/t=
ools/testing/kunit/test_data/test_parse_ktap_output.log
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
> diff --git a/tools/testing/kunit/test_data/test_parse_subtest_header.log =
b/tools/testing/kunit/test_data/test_parse_subtest_header.log
> new file mode 100644
> index 000000000000..216631092e7b
> --- /dev/null
> +++ b/tools/testing/kunit/test_data/test_parse_subtest_header.log
> @@ -0,0 +1,7 @@
> +KTAP version 1
> +1..1
> +  KTAP version 1
> +  # Subtest: suite
> +  1..1
> +  ok 1 test
> +ok 1 suite
> \ No newline at end of file
>
> base-commit: 99c8c9276be71e6bc98979e95d56cdcbe0c2454e
> --
> 2.38.1.584.g0f3c55d4c2-goog
>

--000000000000d2d58905ee336cd7
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAGPil6q1qRMI4xctnaY
SpEwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjEwMjMw
ODQ3MTFaFw0yMzA0MjEwODQ3MTFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDOy5O2GPVtBg1bBqW4oCdA74F9u0dQ
yp4AdicypXD/HnquyuG5F25nYDqJtIueywO1V0kAbUCUNJS002MWjXx329Y1bv0p5GeXQ1isO49U
E86YZb+H0Gjz/kU2EUNllD7499UnJUx/36cMNRZ1BytreL0lLR0XNMJnPNzB6nCnWUf2X3sEZKOD
w+7PhYB7CjsyK8n3MrKkMG3uVxoatKMvdsX3DbllFE/ixNbGLfWTTCaPZYOblLYq7hNuvbb3yGSx
UWkinNXOLCsVGVLeGsQyMCfs8m4u3MBGfRHWc2svYunGHGheG8ErIVL2jl2Ly1nIJpPzZPui17Kd
4TY9v0THAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFCNkhjo/
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBO
x4Lk+6sGHebU1UoLNrdfPhTpADzN879oiOZSBdi6oDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMjQwODQ1MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAdzMLFFO9E/RsYmFEX/tE
HiRJIbWrUY5m53sLNRC80/fL3NB8bssO0wIUBtmwrzukv/JR85YSmCxg0EBoKIOZKGHx/uGyL5mW
I4j3PwQgiFJlafx18YeTNI3nD/V09hDpStNcgJBhGsDakj48fCzTp4BBOt+mCvGXOJUzn9YJ1rBb
ILZ2ZjFA2FzpgtcU2JM4R5SSsBJrvYf/wFtdZy23Lc0ftjJ0zsFx85d8SM+gN6Bxzb7gK4cw8oKZ
CowsKVNbD3IbTdeefwW5okKoAqJ1WUuT+50LExP9Z5LZspxwtAf/BLD4O1G1wqRo0DkJc8u8cbBR
Oac02rHQNAqauQzh2g==
--000000000000d2d58905ee336cd7--
