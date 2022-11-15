Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEBE62A349
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 21:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiKOUq0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 15:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiKOUqZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 15:46:25 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768523E91
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 12:46:23 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so9240393oti.5
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 12:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tPBa5qwvJ4rtaAX/oKA+I9MkV3OhLGJSqX3G1QP1tL8=;
        b=KC7oEXiz8DzbjW+/rTuw0A0I5Fnr7RHISCvgGj0EjArkGhwEpBg7DKhMDc2tJriCdh
         gk99b89/HrjTddSZYVnbLIMEwXJdW26yiM/2g0AMLJs1EAd9MjoIduUQ7RkYYBGWKAbK
         GXnSdCP+vZTdXS149yuE6JCwFHUYDK5YpJz8V/rtD86ZSf+SEDDu+fQKex+J8VsIUETj
         hXMP/Mxzv5fFE43yIh2hlo6BuKi405/vGt0xURPHFtrijMU+gl4qRCKLoQKy9BwCMGkq
         WIBn0tXZPIdtmG4VHuJLHvgiEIgeYD8sD2UdSSLCuVqqKDUPjTYe9xJQHTJaRPmJB5iX
         nmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPBa5qwvJ4rtaAX/oKA+I9MkV3OhLGJSqX3G1QP1tL8=;
        b=ZYtgWnKm6RlZYS6NyQIOCQrz7yxwhTaW9Bd2f1pLmT5ygFFJoAzVJ5eclb86llu/CI
         ariJxi6gMpkZO6cyN4OLAV/s91f3dJucoBNma+cIP42lufDgOEWdB+ge8VVNFmpmSTcU
         RP3oBlcp8V4MWkG34VWs/It59v0gUCJG7YaF4ypF/Y3NmYhE/d3h/5ois0NSkHeN4GVn
         EMrnXxx+T2vYlyzVdjDaVMuyFNjw/NDHQDsQJ9KmiYsF3svcoKRJWQIFqKMaSOmN6yKr
         8WFDlGnXSkEfln7ViO66hQ1kWojkBx8VXTt/JYlgVkj1ZQJiIOV7g/9BMYBQtJFvc/V5
         XOFw==
X-Gm-Message-State: ANoB5plsBmqPs1+s2PTN3+BB7PB3IbPSQ6ofYfW2MttIDkVnkgO+dQeK
        BTWLp60UHBPtIqHz/Jv81Y8snUuJwE1ElTAvXVJAFw==
X-Google-Smtp-Source: AA0mqf6HWrpo7eLF4FhZzrEJ1qt1EzMnBtRm/G38+QbBpv49Fxr1obuXaaEhPKKOgeR4ilp6aFPTQAX0L/Y7k7esx3U=
X-Received: by 2002:a05:6830:14f:b0:668:73ff:e96 with SMTP id
 j15-20020a056830014f00b0066873ff0e96mr9441581otp.256.1668545182942; Tue, 15
 Nov 2022 12:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com> <20221104194705.3245738-2-rmoar@google.com>
 <CABVgOS=eq0RnnP=MGMb-mZntA7+yZ=pe3U_dOq1gxoTPTeC8Bw@mail.gmail.com>
In-Reply-To: <CABVgOS=eq0RnnP=MGMb-mZntA7+yZ=pe3U_dOq1gxoTPTeC8Bw@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 15 Nov 2022 15:46:11 -0500
Message-ID: <CA+GJov7N0gU_a2xNkj_ex9EiuGtDq+7k2zVh4CQ259DL-YMA2Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kunit: tool: parse KTAP compliant test output
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 15, 2022 at 2:27 AM David Gow <davidgow@google.com> wrote:
>
> On Sat, Nov 5, 2022 at 3:48 AM Rae Moar <rmoar@google.com> wrote:
> >
> > Change the KUnit parser to be able to parse test output that complies with
> > the KTAP version 1 specification format found here:
> > https://kernel.org/doc/html/latest/dev-tools/ktap.html. Ensure the parser
> > is able to parse tests with the original KUnit test output format as
> > well.
> >
> > KUnit parser now accepts any of the following test output formats:
> >
> > Original KUnit test output format:
> >
> >  TAP version 14
> >  1..1
> >    # Subtest: kunit-test-suite
> >    1..3
> >    ok 1 - kunit_test_1
> >    ok 2 - kunit_test_2
> >    ok 3 - kunit_test_3
> >  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
> >  # Totals: pass:3 fail:0 skip:0 total:3
> >  ok 1 - kunit-test-suite
> >
> > KTAP version 1 test output format:
> >
> >  KTAP version 1
> >  1..1
> >    KTAP version 1
> >    1..3
> >    ok 1 kunit_test_1
> >    ok 2 kunit_test_2
> >    ok 3 kunit_test_3
> >  ok 1 kunit-test-suite
> >
> > New KUnit test output format (preferred for KUnit tests):
> >
> >  KTAP version 1
> >  1..1
> >    # Subtest: kunit-test-suite
> >    KTAP version 1
> >    1..3
> >    ok 1 kunit_test_1
> >    ok 2 kunit_test_2
> >    ok 3 kunit_test_3
> >  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
> >  # Totals: pass:3 fail:0 skip:0 total:3
> >  ok 1 kunit-test-suite
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> > Note: this patch is based on the linux-kselftest/kunit branch.
> > ---
>
> Looks good to me. Some minor thoughts:
> - As Daniel mentioned, can we think of a better placeholder name for
> tests without Subtest lines? One thought is to just leave it as the
> empty string?

I am definitely open to changing this placeholder name.

The ideas I thought of are: "Test suite", just "Test", or just an
empty string. "Test" or empty string may be less confusing. What do
people prefer?

> - Would it make sense to support the case where the "Subtest" line
> sits between the KTAP version line and the test plan as well. While
> that's not necessary (and does violate v1 of the KTAP spec), I suspect
> something similar would be useful in KTAP v2 for, e.g., individual
> module results.

Similar to the comments on the first patch, I personally think we could
make those changes later in combination with the KTAP v2 development.

> - As mentioned in patch 1, it'd be nice to swap the ordering of the two patches.

Yes, definitely a great idea. Will make a v2 with the patches swapped.

>
> None of those are showstoppers, so if you disagree, we can probably
> accept them as-is, but they might make future changes easier.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
>
> > tools/testing/kunit/kunit_parser.py           | 69 ++++++++++++-------
> >  tools/testing/kunit/kunit_tool_test.py        |  8 +++
> >  .../test_data/test_parse_ktap_output.log      |  8 +++
> >  3 files changed, 60 insertions(+), 25 deletions(-)
> >  create mode 100644 tools/testing/kunit/test_data/test_parse_ktap_output.log
> >
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > index a56c75a973b5..abb69f898263 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -441,6 +441,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
> >         - '# Subtest: [test name]'
> >         - '[ok|not ok] [test number] [-] [test name] [optional skip
> >                 directive]'
> > +       - 'KTAP version [version number]'
> >
> >         Parameters:
> >         lines - LineStream of KTAP output to parse
> > @@ -449,8 +450,9 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
> >         Log of diagnostic lines
> >         """
> >         log = []  # type: List[str]
> > -       while lines and not TEST_RESULT.match(lines.peek()) and not \
> > -                       TEST_HEADER.match(lines.peek()):
> > +       non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START]
> > +       while lines and not any(re.match(lines.peek())
> > +                       for re in non_diagnostic_lines):
> >                 log.append(lines.pop())
> >         return log
> >
> > @@ -496,6 +498,12 @@ def print_test_header(test: Test) -> None:
> >         test - Test object representing current test being printed
> >         """
> >         message = test.name
> > +       if message == "":
> > +               # KUnit tests print a Subtest header line that provides the name
> > +               # of the test suite. But the subtest header line isn't required
> > +               # by the KTAP spec, so use a placeholder name "Test suite" in that
> > +               # case.
> > +               message = "Test suite"
> >         if test.expected_count:
> >                 if test.expected_count == 1:
> >                         message += ' (1 subtest)'
> > @@ -647,13 +655,13 @@ def bubble_up_test_results(test: Test) -> None:
> >         elif test.counts.get_status() == TestStatus.TEST_CRASHED:
> >                 test.status = TestStatus.TEST_CRASHED
> >
> > -def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
> > +def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool) -> Test:
> >         """
> >         Finds next test to parse in LineStream, creates new Test object,
> >         parses any subtests of the test, populates Test object with all
> >         information (status, name) about the test and the Test objects for
> >         any subtests, and then returns the Test object. The method accepts
> > -       three formats of tests:
> > +       four formats of tests:
> >
> >         Accepted test formats:
> >
> > @@ -674,6 +682,16 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
> >         [subtests]
> >         ok 1 name
> >
> > +       - KTAP subtest header (in compliance with KTAP specification)
> > +
> > +       Example:
> > +
> > +    # May include subtest header line here
> > +       KTAP version 1
> > +       1..3
> > +       [subtests]
> > +       ok 1 name
> > +
> >         - Test result line
> >
> >         Example:
> > @@ -685,6 +703,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
> >         expected_num - expected test number for test to be parsed
> >         log - list of strings containing any preceding diagnostic lines
> >                 corresponding to the current test
> > +       is_subtest - boolean indicating whether test is a subtest
> >
> >         Return:
> >         Test object populated with characteristics and any subtests
> > @@ -692,21 +711,22 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
> >         test = Test()
> >         test.log.extend(log)
> >         parent_test = False
> > -       main = parse_ktap_header(lines, test)
> > -       if main:
> > -               # If KTAP/TAP header is found, attempt to parse
> > -               # test plan
> > +       if not is_subtest:
> > +               # If parsing the main test, attempt to parse KTAP/TAP header
> > +               # and test plan
> >                 test.name = "main"
> > +               parse_ktap_header(lines, test)
> >                 parse_test_plan(lines, test)
> >                 parent_test = True
> >         else:
> > -               # If KTAP/TAP header is not found, test must be subtest
> > -               # header or test result line so parse attempt to parser
> > -               # subtest header
> > -               parent_test = parse_test_header(lines, test)
> > +               # If test is a subtest, attempt to parse test suite header
> > +               # (either subtest line and/or KTAP/TAP version line)
> > +               subtest_line = parse_test_header(lines, test)
> > +               ktap_line = parse_ktap_header(lines, test)
> > +               parent_test = subtest_line or ktap_line
> >                 if parent_test:
> > -                       # If subtest header is found, attempt to parse
> > -                       # test plan and print header
> > +                       # If subtest header and/or KTAP/version line is found, attempt
> > +                       # to parse test plan and print header
> >                         parse_test_plan(lines, test)
> >                         print_test_header(test)
> >         expected_count = test.expected_count
> > @@ -721,7 +741,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
> >                 sub_log = parse_diagnostic(lines)
> >                 sub_test = Test()
> >                 if not lines or (peek_test_name_match(lines, test) and
> > -                               not main):
> > +                               is_subtest):
> >                         if expected_count and test_num <= expected_count:
> >                                 # If parser reaches end of test before
> >                                 # parsing expected number of subtests, print
> > @@ -735,20 +755,19 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
> >                                 test.log.extend(sub_log)
> >                                 break
> >                 else:
> > -                       sub_test = parse_test(lines, test_num, sub_log)
> > +                       sub_test = parse_test(lines, test_num, sub_log, True)
> >                 subtests.append(sub_test)
> >                 test_num += 1
> >         test.subtests = subtests
> > -       if not main:
> > +       if is_subtest:
> >                 # If not main test, look for test result line
> >                 test.log.extend(parse_diagnostic(lines))
> > -               if (parent_test and peek_test_name_match(lines, test)) or \
> > -                               not parent_test:
> > -                       parse_test_result(lines, test, expected_num)
> > -               else:
> > +               if subtest_line and not peek_test_name_match(lines, test):
> >                         test.add_error('missing subtest result line!')
> > +               else:
> > +                       parse_test_result(lines, test, expected_num)
> >
> > -       # Check for there being no tests
> > +       # Check for there being no subtests within parent test
> >         if parent_test and len(subtests) == 0:
> >                 # Don't override a bad status if this test had one reported.
> >                 # Assumption: no subtests means CRASHED is from Test.__init__()
> > @@ -758,11 +777,11 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
> >
> >         # Add statuses to TestCounts attribute in Test object
> >         bubble_up_test_results(test)
> > -       if parent_test and not main:
> > +       if parent_test and is_subtest:
> >                 # If test has subtests and is not the main test object, print
> >                 # footer.
> >                 print_test_footer(test)
> > -       elif not main:
> > +       elif is_subtest:
> >                 print_test_result(test)
> >         return test
> >
> > @@ -785,7 +804,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
> >                 test.add_error('could not find any KTAP output!')
> >                 test.status = TestStatus.FAILURE_TO_PARSE_TESTS
> >         else:
> > -               test = parse_test(lines, 0, [])
> > +               test = parse_test(lines, 0, [], False)
> >                 if test.status != TestStatus.NO_TESTS:
> >                         test.status = test.counts.get_status()
> >         stdout.print_with_timestamp(DIVIDER)
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 90c65b072be9..7c2e2a45f330 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -312,6 +312,14 @@ class KUnitParserTest(unittest.TestCase):
> >                 self.assertEqual(kunit_parser._summarize_failed_tests(result),
> >                         'Failures: all_failed_suite, some_failed_suite.test2')
> >
> > +       def test_ktap_format(self):
> > +               ktap_log = test_data_path('test_parse_ktap_output.log')
> > +               with open(ktap_log) as file:
> > +                       result = kunit_parser.parse_run_tests(file.readlines())
> > +               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=3))
> > +               self.assertEqual('suite', result.subtests[0].name)
> > +               self.assertEqual('case_1', result.subtests[0].subtests[0].name)
> > +               self.assertEqual('case_2', result.subtests[0].subtests[1].name)
> >
> >  def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
> >         return kunit_parser.LineStream(enumerate(strs, start=1))
> > diff --git a/tools/testing/kunit/test_data/test_parse_ktap_output.log b/tools/testing/kunit/test_data/test_parse_ktap_output.log
> > new file mode 100644
> > index 000000000000..ccdf244e5303
> > --- /dev/null
> > +++ b/tools/testing/kunit/test_data/test_parse_ktap_output.log
> > @@ -0,0 +1,8 @@
> > +KTAP version 1
> > +1..1
> > +  KTAP version 1
> > +  1..3
> > +  ok 1 case_1
> > +  ok 2 case_2
> > +  ok 3 case_3
> > +ok 1 suite
> > --
> > 2.38.1.431.g37b22c650d-goog
> >
