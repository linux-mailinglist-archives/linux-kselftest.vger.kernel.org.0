Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF76202D3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 23:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiKGW66 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 17:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKGW65 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 17:58:57 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5128E2A
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 14:58:54 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id t25so34099577ejb.8
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Nov 2022 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sUwZCDwxMnAkjoqePpUD6650XsgFZMrEmZEKqVeeEao=;
        b=ayODyuGoousx2v6HfI5+YnqQN/a4tPtpddMstewaTMLBoFilQsrp9tNXZwyPLMlzwU
         A4jy4oVX0YGXvCSybGxyLdken2LdedbaebsZaSZxlT0gkTSLu2UBgnDqwY9gnuOos1B6
         ACOu1ZA2BuZZ5vtBLTCk0TXV/eO4JzHsKOsl4qP3VrCMwQYyg7AThJdLN6WfR7NtMmOO
         mjwUq54/hMtGPKadvwI9Njky992b8lx1rF58L6ZuIAahH94GGnOfTL5W4zFnFWAgMWjQ
         lCef9Jd/OntTtL8YvTFq+pxX05RGyjR1/Fx8SON+PXM7kyGOz+Kj3nHmMRXp/NaRzAUk
         ld7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUwZCDwxMnAkjoqePpUD6650XsgFZMrEmZEKqVeeEao=;
        b=Da0txIcCrgoG+2BTsChC6z0SYEX8SxImHwfjHsL7ZG0JYI4nCAQXuc3SBp4GKq0pls
         o729njIZ3TH7u3pU72HR0720nzHDGlvIoi/5VyETsWeH6jM66+0/8Z4oeTGheYLdv60n
         BI9nWOnAsoVDILniEpKKPAAIdSCJHor5Rgiwzvg6HX84KaIs6qxIreJU7xA1b2GH6MiS
         U51NyEJ+jLTCHbvl/7bCAR2tTF9Go3fj5bjV2CO9Y2aqQs1DUC/gT2AGQ8nn76aBtbwP
         VFtmKYzrDWN5Tzk69k5aX21p81o19sYmbdBNXGHQ1fGR0B740nB4VphozfK+JKSxkejC
         PnEg==
X-Gm-Message-State: ACrzQf1epwlfqJtqYziWBIWFfeVPWoe9Z3oI89U6dsu9t34DoksEhfWg
        9sxH8PE7hdeSXHtUDddzF28gUHq5TSMfeA5i7nFrbg==
X-Google-Smtp-Source: AMsMyM5n16cnNQd+UEYr8FtaMxZ4fIDCRjZHVDLMWw6wcx81hsAsWCQuaUJfz+m9gpoEPOo2muW1DLpa6SlPKnC5FgY=
X-Received: by 2002:a17:907:74a:b0:77e:9455:b4e1 with SMTP id
 xc10-20020a170907074a00b0077e9455b4e1mr50055830ejb.462.1667861933168; Mon, 07
 Nov 2022 14:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com> <20221104194705.3245738-2-rmoar@google.com>
In-Reply-To: <20221104194705.3245738-2-rmoar@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Nov 2022 14:58:41 -0800
Message-ID: <CAGS_qxphFQhKHbBDKVVS+0NaEPY=ivysdaTUmvCtjA=XQkx_Aw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kunit: tool: parse KTAP compliant test output
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
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

On Fri, Nov 4, 2022 at 12:48 PM Rae Moar <rmoar@google.com> wrote:
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

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Looks good to me.
Some comments below, but nothing we have to address in this patch, IMO.

> ---
> Note: this patch is based on the linux-kselftest/kunit branch.
> ---
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


(something we can address in a later change)

Hmm, consider the following input

KTAP version 1
1..1
  KTAP version 1
  1..1
    KTAP version 1
    1..1
      ok 1 - subtest1
    ok 1 - test1
  ok 1 - suite

$ ./tools/testing/kunit/kunit.py parse < /tmp/example_nested_ktap
============================================================
================== Test suite (1 subtest) ==================
================== Test suite (1 subtest) ==================
[PASSED] subtest1
====================== [PASSED] test1 ======================
====================== [PASSED] suite ======================
============================================================

I wonder if the duplicate "Test suite" line would be confusing.
This also points to a slightly bigger problem that kunit_parser.py
doesn't have a good way to format 3+ layers of tests atm.

I don't know if there's another placeholder name we can give that
might be less confusing.

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

This change isn't a straightforward change of the logic like
s/main/not is_subtest.
But looking at it, it seems fine.

One example input would be

 KTAP version 1
 1..2
   # Subtest: suite1
   KTAP version 1
   1..1
   ok 1 test1
 # ok 1 suite1
 ok 2 suite2

We get output like this

$ ./tools/testing/kunit/kunit.py parse < /tmp/out
[14:54:44] ============================================================
[14:54:44] ==================== suite1 (1 subtest) ====================
[14:54:44] [PASSED] test1
[14:54:44] [ERROR] Test: suite1: missing subtest result line!
[14:54:44] # Subtest: suite1
[14:54:44] KTAP version 1
[14:54:44] 1..1
[14:54:44] # ok 1 suite1
[14:54:44] ===================== [CRASHED] suite1 =====================
[14:54:44] [PASSED] suite2
[14:54:44] ============================================================

So it handles it about as well as we could expect.

Note: kunit.py is indeed saying the kernel crashed even though there's
"kernel output" after the missing line. But this is a pre-existing
condition. It already doesn't check to see that the output is
truncated before saying "CRASHED"
