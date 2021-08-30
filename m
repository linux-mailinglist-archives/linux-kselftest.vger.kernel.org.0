Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0793FBD28
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Aug 2021 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhH3Ttw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Aug 2021 15:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbhH3Ttt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Aug 2021 15:49:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F2C061575
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 12:48:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id e21so33514848ejz.12
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rr91QIQZgHgt4QsFYDk3+MItbQ3T7WyCDk7xvMJasLw=;
        b=RhlWtkHCHbYF7YCzzPxHYBLnWQPyC0pbDQn1Bs0Y/SCwHqv031uV7+pParEbpZR4Ox
         EeL6gLb44npyNnBoQtMCeEQI3Uu+ldGzHlpQhnxmHBOAY2N6BVeB6Mb/3zsQp9NXlxAv
         /Ftr0yTPymKB25DAKbZIWHZuJWWkYdLu54BeSYwnXjjvR6Iw5amJBMkcD80+KZCfyy0r
         uE5eP72bE+cK4VFUMMpXkxbn9d152naP9i8rlUAWv83LaCuBgLdTMFWwMzZXf9g+/t5v
         8gYkrSD1QkW9MGS6WXgJIq9S4+Uk7LLVHPpca8l+ocaLMdn/OYKqtDIhb+nN+iIKT55o
         LTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rr91QIQZgHgt4QsFYDk3+MItbQ3T7WyCDk7xvMJasLw=;
        b=lX6C6n0S5SSdPA+xv+qmdTme+jtHxnuVogyWEW2/ZacZC6z/lB79xGkzwHy41m3u1j
         s4ykDLkc+NEwtBiyxA3gpWpN09p/0aBVnw3wpQFS0eJj3bbzZtihu50uXr13jGW48MCQ
         tHVQhtK2MKSyXzRBvurnuthWcrq3izJK5GbnPS44mpLRigiHS8lxW0bY6VQb50muvdEE
         jSg1KtXgb50Alvo5zzNeprIQhKDAeMXxo0cNwe/1q1mvnLopHv6EBxi3rzhOU6aBkbKd
         o2BUBAkXZmzbaO7Ma0Bz6SxNGJ87guZJVfWJr0+4GRQdRFJ2A2Wwcl2RtfwkfoqthwCX
         reHQ==
X-Gm-Message-State: AOAM531XZ1CcePFPM4xwTQC5rHtdLgo+K5ry4uXN+187fiB5L8BfWjYJ
        P8iSmjcssdFc4C2+N5hccj5N3/nIzW6HcUEL501ixA==
X-Google-Smtp-Source: ABdhPJweYgizRgaYSJZHL5JyQ1LWp+VBRBveeZljzPQMXdcmE8nkpz/elZuBQOIW51NsSBdss+QrN87pnSFlA4f7ZNk=
X-Received: by 2002:a17:906:a3c3:: with SMTP id ca3mr26750952ejb.337.1630352931921;
 Mon, 30 Aug 2021 12:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210826195505.3066755-1-rmoar@google.com> <CAGS_qxrrNGPZN0WUpPtaXXYZahCyVyEJMthKBD_XnX6E02zNeQ@mail.gmail.com>
In-Reply-To: <CAGS_qxrrNGPZN0WUpPtaXXYZahCyVyEJMthKBD_XnX6E02zNeQ@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Mon, 30 Aug 2021 15:48:39 -0400
Message-ID: <CA+GJov5Brzc7wgK0nFC0r3rdxQjs1OMF4Dk-r9Jjm=P8AA=z9g@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: improve compatibility of kunit_parser
 with KTAP specification
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com, shuah@kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 26, 2021 at 7:49 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Aug 26, 2021 at 12:55 PM 'Rae Moar' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Update to kunit_parser to improve compatibility with KTAP
> > specification including arbitrarily nested tests. Patch accomplishes
> > three major changes:
> >
> > - Use a general Test object to represent all tests rather than TestCase
> > and TestSuite objects. This allows for easier implementation of arbitrary
> > levels of nested tests and promotes the idea that both test suites and test
> > cases are tests.
> >
> > - Print errors incrementally rather than all at once after the
> > parsing finishes to maximize information given to the user in the
> > case of the parser given invalid input and to increase the helpfulness
> > of the timestamps given during printing. Note that kunit.py parse does
> > not print incrementally yet. However, this fix brings us closer to
> > this feature.
> >
> > - Increase compatibility for different formats of input. Arbitrary levels
> > of nested tests supported. Also, test cases and test suites are now
> > supported to be present on the same level of testing.
> >
> > This patch now implements the KTAP specification as described here:
> > https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/.
> >
> > This patch adjusts the kunit_tool_test.py file to check for
> > the correct outputs from the new parser and adds a new test to check
> > the parsing for a KTAP result log with correct format for multiple nested
> > subtests (test_is_test_passed-all_passed_nested.log).
> >
> > This patch also alters the kunit_json.py file to allow for arbitrarily
> > nested tests.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> Acked-by: Daniel Latypov <dlatypov@google.com>
>
> Looks good to me, some more bikeshedding about comments below.
> pytype does find a minor error (which was actually my fault since I'd
> suggested you annotate `build_dir: str` off-list).
> Also, this patch accidentally adds kunit_parser.raw_output() back in.
>

Thanks for pointing out the pytype error! I will change the annotation in
v3. I will also remove kunit_parser.raw_output() in v3.

> >
> > ---
> >
> > Change log from v1:
> > https://lore.kernel.org/linux-kselftest/20210820200032.2178134-1-rmoar@google.com/
> > - Rebase onto kselftest/kunit branch
> > - Add tests to kunit_tool_test.py to check parser is correctly stripping
> >   hyphen, producing correct json objects with nested tests, correctly
> >   passing kselftest TAP output, and correctly deals with missing test plan.
> > - Fix bug to correctly match test name in instance of a missing test plan.
> > - Fix bug in kunit_tool_test.py pointed out by Daniel where it was not
> >   correctly checking for a proper match to the '0 tests run!' error
> >   message. Reverts changes back to original.
> > - A few minor changes to commit message using Daniel's comments.
> > - Change docstrings using Daniel's comments to reduce:
> >   - Shortens some docstrings to be one-line or just description if it is
> >     self explanatory.
> >   - Remove explicit respecification of types of parameters and returns
> >     because this is already specified in the function annoations. However,
> >     some descriptions of the parameters and returns remain and some contain
> >     the type for context. Additionally, the types of public attributes of
> >     classes remain.
> >   - Remove any documentation of 'Return: None'
> >   - Remove docstrings of helper methods within other methods.
> > ---
> >  tools/testing/kunit/kunit_json.py             |   55 +-
> >  tools/testing/kunit/kunit_parser.py           | 1056 ++++++++++++-----
> >  tools/testing/kunit/kunit_tool_test.py        |  134 ++-
> >  .../test_is_test_passed-all_passed_nested.log |   34 +
> >  .../test_is_test_passed-kselftest.log         |   14 +
> >  .../test_is_test_passed-missing_plan.log      |   31 +
> >  .../kunit/test_data/test_strip_hyphen.log     |   16 +
> >  7 files changed, 951 insertions(+), 389 deletions(-)
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
> >  create mode 100644 tools/testing/kunit/test_data/test_strip_hyphen.log
> >
> > diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
> > index f5cca5c38cac..e7317b4fad9d 100644
> > --- a/tools/testing/kunit/kunit_json.py
> > +++ b/tools/testing/kunit/kunit_json.py
> > @@ -11,47 +11,46 @@ import os
> >
> >  import kunit_parser
> >
> > -from kunit_parser import TestStatus
> > -
> > -def get_json_result(test_result, def_config, build_dir, json_path) -> str:
> > -       sub_groups = []
> > -
> > -       # Each test suite is mapped to a KernelCI sub_group
> > -       for test_suite in test_result.suites:
> > -               sub_group = {
> > -                       "name": test_suite.name,
> > -                       "arch": "UM",
> > -                       "defconfig": def_config,
> > -                       "build_environment": build_dir,
> > -                       "test_cases": [],
> > -                       "lab_name": None,
> > -                       "kernel": None,
> > -                       "job": None,
> > -                       "git_branch": "kselftest",
> > -               }
> > -               test_cases = []
> > -               # TODO: Add attachments attribute in test_case with detailed
> > -               #  failure message, see https://api.kernelci.org/schema-test-case.html#get
> > -               for case in test_suite.cases:
> > -                       test_case = {"name": case.name, "status": "FAIL"}
> > -                       if case.status == TestStatus.SUCCESS:
> > +from kunit_parser import Test, TestResult, TestStatus
> > +from typing import Any, Dict
> > +
> > +JsonObj = Dict[str, Any]
> > +
> > +def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
>
>
> Ah, pytype complains about this.
> Looks like the unit test passes None here.
>
> We can either make this annotation say `build_dir: Optional[str]` or
> change the unit test to pass '' instead of None.
> The former might be preferable to keep this change more focused.
>

Thanks for finding this! I also like 'build_dir: Optional[str]' to keep the
changes limited to the files already being updated.

>
> > +       sub_groups = []  # List[JsonObj]
> > +       test_cases = []  # List[JsonObj]
> > +
> > +       for subtest in test.subtests:
> > +               if len(subtest.subtests):
> > +                       sub_group = _get_group_json(subtest, def_config,
> > +                               build_dir)
> > +                       sub_groups.append(sub_group)
> > +               else:
> > +                       test_case = {"name": subtest.name, "status": "FAIL"}
> > +                       if subtest.status == TestStatus.SUCCESS:
> >                                 test_case["status"] = "PASS"
> > -                       elif case.status == TestStatus.TEST_CRASHED:
> > +                       elif subtest.status == TestStatus.TEST_CRASHED:
> >                                 test_case["status"] = "ERROR"
> >                         test_cases.append(test_case)
> > -               sub_group["test_cases"] = test_cases
> > -               sub_groups.append(sub_group)
> > +
> >         test_group = {
> > -               "name": "KUnit Test Group",
> > +               "name": test.name,
> >                 "arch": "UM",
> >                 "defconfig": def_config,
> >                 "build_environment": build_dir,
> >                 "sub_groups": sub_groups,
> > +               "test_cases": test_cases,
> >                 "lab_name": None,
> >                 "kernel": None,
> >                 "job": None,
> >                 "git_branch": "kselftest",
> >         }
> > +       return test_group
> > +
> > +def get_json_result(test_result: TestResult, def_config: str, build_dir: str,
> > +               json_path: str) -> str:
> > +       test_group = _get_group_json(test_result.test, def_config, build_dir)
> > +       test_group["name"] = "KUnit Test Group"
> >         json_obj = json.dumps(test_group, indent=4)
> >         if json_path != 'stdout':
> >                 with open(json_path, 'w') as result_path:
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > index 6310a641b151..4b6086159c7f 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -1,11 +1,15 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  #
> > -# Parses test results from a kernel dmesg log.
> > +# Parses KTAP test results from a kernel dmesg log and incrementally prints
> > +# results with reader-friendly format. Stores and returns test results in a
> > +# Test object.
> >  #
> >  # Copyright (C) 2019, Google LLC.
> >  # Author: Felix Guo <felixguoxiuping@gmail.com>
> >  # Author: Brendan Higgins <brendanhiggins@google.com>
> > +# Author: Rae Moar <rmoar@google.com>
> >
> > +from __future__ import annotations
> >  import re
> >
> >  from collections import namedtuple
> > @@ -14,33 +18,55 @@ from enum import Enum, auto
> >  from functools import reduce
> >  from typing import Iterable, Iterator, List, Optional, Tuple
> >
> > -TestResult = namedtuple('TestResult', ['status','suites','log'])
> > -
> > -class TestSuite(object):
> > -       def __init__(self) -> None:
> > -               self.status = TestStatus.SUCCESS
> > -               self.name = ''
> > -               self.cases = []  # type: List[TestCase]
> > -
> > -       def __str__(self) -> str:
> > -               return 'TestSuite(' + str(self.status) + ',' + self.name + ',' + str(self.cases) + ')'
> > -
> > -       def __repr__(self) -> str:
> > -               return str(self)
> > -
> > -class TestCase(object):
> > +TestResult = namedtuple('TestResult', ['status','test','log'])
> > +
> > +class Test(object):
> > +       """
> > +       A class to represent a test parsed from KTAP results. All KTAP
> > +       results within a test log are stored in a main Test object as
> > +       subtests.
> > +
> > +       Attributes:
> > +       status : TestStatus - status of the test
> > +       name : str - name of the test
> > +       expected_count : int - expected number of subtests (0 if single
> > +               test case and None if unknown expected number of subtests)
> > +       subtests : List[Test] - list of subtests
> > +       log : List[str] - log of KTAP lines that correspond to the test
> > +       counts : TestCounts - counts of the test statuses and errors of
> > +               subtests or of the test itself if the test is a single
> > +               test case.
> > +       """
> >         def __init__(self) -> None:
> > +               """Constructs the default attributes of a Test class object.
> > +               """
>
> Optional: I think we can still drop documents like this on __init__()
> and __str__() since these are well-known functions.
> __init__() could have a comment if it did anything non-obvious, but
> that's not the case here.
>

I would prefer to keep docstrings for all public methods in classes,
including __init__() and __str__(). This best follows the docstring
conventions (https://www.python.org/dev/peps/pep-0257/#specification).
I have attempted to make the docstrings for simple methods quite simplistic.
I may even change this docstring to be: 'Creates Test object with default
attributes' in order to not refer to the low-level details of constructing the
attributes.

> >                 self.status = TestStatus.SUCCESS
> >                 self.name = ''
> > +               self.expected_count = 0  # type: Optional[int]
> > +               self.subtests = []  # type: List[Test]
> >                 self.log = []  # type: List[str]
> > +               self.counts = TestCounts()
> >
> >         def __str__(self) -> str:
> > -               return 'TestCase(' + str(self.status) + ',' + self.name + ',' + str(self.log) + ')'
> > +               """Returns string representation of a Test class object."""
> > +               return ('Test(' + str(self.status) + ', ' + self.name +
> > +                       ', ' + str(self.expected_count) + ', ' +
> > +                       str(self.subtests) + ', ' + str(self.log) + ', ' +
> > +                       str(self.counts) + ')')
> >
> >         def __repr__(self) -> str:
> > +               """Returns string representation of a Test class object."""
> >                 return str(self)
> >
> > +       def add_error(self, error_message: str) -> None:
> > +               """Adds error to test object by incrementing the error count
> > +               and printing the error message.
> > +               """
>
> nit: this comment explains the low-level details of what the function
> does, which isn't as necessary.
>
> We'd want to document more what the intent of the function is, e.g. perhaps:
>   Records an error that occured while parsing this test.
>
> In the future, we might want to change how errors are printed, hence
> why I don't want to include that in a comment, per se.
>
> E.g. I've seen a case where a user was getting truncated TAP output,
> but it was hard to tell.
> The error message was logged at the top but got lost after the parser
> went on to print out all the test results.
>
> The parser will behave the same way after this patch.
> So we might eventually want to have a follow-up that includes a
> summary of all the encountered errors at the end, for example.

I like this change. I will update the docstring to be:
'Records an error that occurred while parsing this test' in v3.

>
> > +               self.counts.errors += 1
> > +               print_error('Test ' + self.name + ': ' + error_message)
> > +
> >  class TestStatus(Enum):
> > +       """An enumeration class to represent the status of a test."""
> >         SUCCESS = auto()
> >         FAILURE = auto()
> >         SKIPPED = auto()
> > @@ -48,381 +74,769 @@ class TestStatus(Enum):
> >         NO_TESTS = auto()
> >         FAILURE_TO_PARSE_TESTS = auto()
> >
> > +class TestCounts:
> > +       """
> > +       A class to represent the counts of statuses and test errors of
> > +       subtests or of the test itself if the test is a single test case with
> > +       no subtests. Note that the sum of the counts of passed, failed,
> > +       crashed, and skipped should sum to the total number of subtests for
> > +       the test.
>
> optional: can tersen this a bit. e.g. I don't think we need to
> reiterate that this is a class, for example :)
> I'd personally write it a bit more like
>
> Tracks the number of tests that had each status.
> This includes the test itself and all its subtests.
>

I agree this can be shortened. I will definitely be removing the
second sentence.
That can be described in the total() method. I will likely change the
docstring to be:
'Tracks the counts of statuses of all test cases and any errors within a Test.'

This correctly describes that the TestCounts object only tracks the
statuses of test
cases with no subtests. So if the test itself had subtests, it's
status would not be
counted. However, this does use the phrase 'test case', which we were attempting
to move away from. What do you think of this change?

> > +
> > +       Attributes:
> > +       passed : int - the number of tests that have passed
> > +       failed : int - the number of tests that have failed
> > +       crashed : int - the number of tests that have crashed
> > +       skipped : int - the number of tests that have skipped
> > +       errors : int - the number of errors in the test and subtests
> > +       """
> > +       def __init__(self):
> > +               """Contructs the default attributes of a TestCounts class
> > +               object. Sets the counts of all test statuses and test
> > +               errors to be 0.
> > +               """
> > +               self.passed = 0
> > +               self.failed = 0
> > +               self.crashed = 0
> > +               self.skipped = 0
> > +               self.errors = 0
> > +
> > +       def __str__(self) -> str:
> > +               """Returns the string representation of a TestCounts object.
> > +               """
>
> Echoing the comment above, I think comments can be dropped for
> functions like __str__.

See comment above on docstrings.

>
> > +               return ('Passed: ' + str(self.passed) +
> > +                       ', Failed: ' + str(self.failed) +
> > +                       ', Crashed: ' + str(self.crashed) +
> > +                       ', Skipped: ' + str(self.skipped) +
> > +                       ', Errors: ' + str(self.errors))
> > +
> > +       def total(self) -> int:
> > +               """Returns total number of subtests or 1 if the test object
> > +               has no subtests to represent the test itself. This number is
> > +               calculated by the sum of the passed, failed, crashed, and
> > +               skipped subtests.
>
> I think the first sentence would be sufficient here, e.g.
>   Returns the number of subtests, or 1 if the test had none.

I will either just use the first sentence. Or I will change this to be:
'Returns the total number of test cases within a test object.'
I think this more clearly depicts what this method returns.
I may add: 'where a test case is a test with no subtests.' See
above comment on class docstring. Again
is this an issue to be using the term test case?

>
> > +               """
> > +               return (self.passed + self.failed + self.crashed +
> > +                       self.skipped)
> > +
> > +       def add_subtest_counts(self, counts: TestCounts) -> None:
> > +               """
> > +               Adds the counts of another TestCounts object to the current
> > +               TestCounts object. Used to add the counts of a subtest to the
> > +               parent test.
> > +
> > +               Parameters:
> > +               counts - a different TestCounts object whose counts
> > +                       will be added to the counts of the TestCounts object
> > +               """
> > +               self.passed += counts.passed
> > +               self.failed += counts.failed
> > +               self.crashed += counts.crashed
> > +               self.skipped += counts.skipped
> > +               self.errors += counts.errors
> > +
> > +       def get_status(self) -> TestStatus:
> > +               """Returns the expected status of a Test using test counts."""
>
> nit: would "aggregated status" be a bit more accurate than "expected status" ?
>

I like the change to "aggregated status". I will change this is v3 :)

> > +               if self.crashed:
> > +                       # If one of the subtests crash, the expected status
> > +                       # of the Test is crashed.
> > +                       return TestStatus.TEST_CRASHED
> > +               elif self.failed:
> > +                       # Otherwise if one of the subtests fail, the
> > +                       # expected status of the Test is failed.
> > +                       return TestStatus.FAILURE
> > +               elif self.passed:
> > +                       # Otherwise if one of the subtests pass, the
> > +                       # expected status of the Test is passed.
> > +                       return TestStatus.SUCCESS
> > +               else:
> > +                       # Finally, if none of the subtests have failed,
> > +                       # crashed, or passed, the expected status of the
> > +                       # Test is skipped.
> > +                       return TestStatus.SKIPPED
> > +
> > +       def add_status(self, status: TestStatus) -> None:
> > +               """
> > +               Given inputted status, increments corresponding attribute of
> > +               TestCounts object.
> > +
> > +               Parameters:
> > +               status - status to be added to the TestCounts object
> > +               """
> > +               if status == TestStatus.SUCCESS or \
> > +                               status == TestStatus.NO_TESTS:
> > +                       # if status is NO_TESTS the most appropriate
> > +                       # attribute to increment is passed because
> > +                       # the test did not fail, crash or get skipped.
> > +                       self.passed += 1
> > +               elif status == TestStatus.FAILURE:
> > +                       self.failed += 1
> > +               elif status == TestStatus.SKIPPED:
> > +                       self.skipped += 1
> > +               else:
> > +                       self.crashed += 1
> > +
> >  class LineStream:
> > -       """Provides a peek()/pop() interface over an iterator of (line#, text)."""
> > +       """
> > +       A class to represent the lines of kernel output.
> > +       Provides a peek()/pop() interface over an iterator of
> > +       (line#, text).
> > +       """
> >         _lines: Iterator[Tuple[int, str]]
> >         _next: Tuple[int, str]
> >         _done: bool
> >
> >         def __init__(self, lines: Iterator[Tuple[int, str]]):
> > +               """Set defaults for LineStream object and sets _lines
> > +               attribute to lines parameter.
>
> nit: this "initializes" more than "set[s] defaults".
> Perhaps:
>   Creates a new LineStream that wraps the given iterator.
>

Thanks for this suggestion! I will definitely change this in v3.
I prefer this description much more.

>
> > +               """
> >                 self._lines = lines
> >                 self._done = False
> >                 self._next = (0, '')
> >                 self._get_next()
> >
> >         def _get_next(self) -> None:
> > +               """Advances the LineSteam to the next line or sets the _done
> > +               attribute if the LineStream has reached the end of the lines.
> > +               """
> >                 try:
> >                         self._next = next(self._lines)
> >                 except StopIteration:
> >                         self._done = True
> >
> >         def peek(self) -> str:
> > +               """Returns the next line in the LineStream without advancing
> > +               the LineStream.
>
> Looks good to me, thanks!
>
> But perhaps saying "the current line" would be more clear?
>
> I.e.
> peek()
>   Returns the current line, without advancing the LineStream.
>
> pop()
>   Returns the current line and advances the LineStream to the next line.
>
> line_number()
>   Returns the line number of the current line.
>

I like all of these changes. Will change in v3.

> > +               """
> >                 return self._next[1]
> >
> >         def pop(self) -> str:
> > +               """Returns the next line in the LineStream and advances the
> > +               LineStream to the next line.
> > +               """
> >                 n = self._next
> >                 self._get_next()
> >                 return n[1]
> >
> >         def __bool__(self) -> bool:
> > +               """Returns whether the LineStream has reached the end of the
> > +               lines.
> > +               """
>
> Perhaps this (a bit shorter):
>   Checks whether there's any more lines in the stream.

I do think this could be shorter. However, I think 'checks' is a bit inexact.
I prefer 'Returns if stream has any more lines' or
'Returns if stream is at end of lines.'

>
> >                 return not self._done
> >
> >         # Only used by kunit_tool_test.py.
> >         def __iter__(self) -> Iterator[str]:
> > +               """Empties all lines stored in LineStream object into
> > +               Iterator object and returns the Iterator object.
> > +               """
>
> Nit: it doesn't really return an iterator object.
> Given this is another __ function, I think we can leave off the comment.
>
> The behavior is about what one would expect for __iter__().
>

I think it is best to keep the simplistic docstrings for all public methods
(see comment above). However, I thought this function did return an Iterator.
I may be mistaken but since this method uses the yield keyword, this
function would return a generator, which is a type of iterator. Since I
would like to keep the docstring, could you explain further?

> >                 while bool(self):
> >                         yield self.pop()
> >
> >         def line_number(self) -> int:
> > +               """Returns the line number of the next line in the
> > +               LineStream.
> > +               """
> >                 return self._next[0]
> >
> > -kunit_start_re = re.compile(r'TAP version [0-9]+$')
> > -kunit_end_re = re.compile('(List of all partitions:|'
> > -                         'Kernel panic - not syncing: VFS:|reboot: System halted)')
> > +# Parsing helper methods:
> > +
> > +KTAP_START = re.compile(r'KTAP version ([0-9]+)$')
> > +TAP_START = re.compile(r'TAP version ([0-9]+)$')
> > +KTAP_END = re.compile('(List of all partitions:|'
> > +       'Kernel panic - not syncing: VFS:|reboot: System halted)')
> >
> >  def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
> > -       def isolate_kunit_output(kernel_output: Iterable[str]) -> Iterator[Tuple[int, str]]:
> > +       """Extracts KTAP lines from inputted kernel output in LineStream
> > +       object."""
> > +       def isolate_ktap_output(kernel_output: Iterable[str]) \
> > +                       -> Iterator[Tuple[int, str]]:
> >                 line_num = 0
> >                 started = False
> >                 for line in kernel_output:
> >                         line_num += 1
> > -                       line = line.rstrip()  # line always has a trailing \n
> > -                       if kunit_start_re.search(line):
> > +                       line = line.rstrip()  # remove trailing \n
> > +                       if not started and KTAP_START.search(line):
> > +                               # start extracting KTAP lines and set prefix
> > +                               # to number of characters before version line
> > +                               prefix_len = len(
> > +                                       line.split('KTAP version')[0])
> > +                               started = True
> > +                               yield line_num, line[prefix_len:]
> > +                       elif not started and TAP_START.search(line):
> > +                               # start extracting KTAP lines and set prefix
> > +                               # to number of characters before version line
> >                                 prefix_len = len(line.split('TAP version')[0])
> >                                 started = True
> >                                 yield line_num, line[prefix_len:]
> > -                       elif kunit_end_re.search(line):
> > +                       elif started and KTAP_END.search(line):
> > +                               # stop extracting KTAP lines
> >                                 break
> >                         elif started:
> > -                               yield line_num, line[prefix_len:]
> > -       return LineStream(lines=isolate_kunit_output(kernel_output))
> > -
> > -DIVIDER = '=' * 60
> > -
> > -RESET = '\033[0;0m'
> > -
> > -def red(text) -> str:
> > -       return '\033[1;31m' + text + RESET> -
> > -def yellow(text) -> str:
> > -       return '\033[1;33m' + text + RESET
> > -
> > -def green(text) -> str:
> > -       return '\033[1;32m' + text + RESET
> > -
> > -def print_with_timestamp(message) -> None:
> > -       print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
> > -
> > -def format_suite_divider(message) -> str:
> > -       return '======== ' + message + ' ========'
> > -
> > -def print_suite_divider(message) -> None:
> > -       print_with_timestamp(DIVIDER)
> > -       print_with_timestamp(format_suite_divider(message))
> > -
> > -def print_log(log) -> None:
> > -       for m in log:
> > -               print_with_timestamp(m)
> > -
> > -TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*# (Subtest:|.*: kunit test case crashed!)).*$')
> > -
> > -def consume_non_diagnostic(lines: LineStream) -> None:
> > -       while lines and not TAP_ENTRIES.match(lines.peek()):
> > -               lines.pop()
> > -
> > -def save_non_diagnostic(lines: LineStream, test_case: TestCase) -> None:
> > -       while lines and not TAP_ENTRIES.match(lines.peek()):
> > -               test_case.log.append(lines.peek())
> > -               lines.pop()
> > -
> > -OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
> > -
> > -OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP(.*)$')
> > -
> > -OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
> > -
> > -OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
> > -
> > -def parse_ok_not_ok_test_case(lines: LineStream, test_case: TestCase) -> bool:
> > -       save_non_diagnostic(lines, test_case)
> > -       if not lines:
> > -               test_case.status = TestStatus.TEST_CRASHED
> > -               return True
> > -       line = lines.peek()
> > -       match = OK_NOT_OK_SUBTEST.match(line)
> > -       while not match and lines:
> > -               line = lines.pop()
> > -               match = OK_NOT_OK_SUBTEST.match(line)
> > -       if match:
> > -               test_case.log.append(lines.pop())
> > -               test_case.name = match.group(2)
> > -               skip_match = OK_NOT_OK_SKIP.match(line)
> > -               if skip_match:
> > -                       test_case.status = TestStatus.SKIPPED
> > -                       return True
> > -               if test_case.status == TestStatus.TEST_CRASHED:
> > -                       return True
> > -               if match.group(1) == 'ok':
> > -                       test_case.status = TestStatus.SUCCESS
> > -               else:
> > -                       test_case.status = TestStatus.FAILURE
> > -               return True
> > +                               # remove prefix and any indention and yield
> > +                               # line with line number
> > +                               line = line[prefix_len:].lstrip()
> > +                               yield line_num, line
> > +       return LineStream(lines=isolate_ktap_output(kernel_output))
> > +
> > +def raw_output(kernel_output: Iterable[str]) -> None:
> > +       """Prints all lines of kernel output."""
> > +       for line in kernel_output:
> > +               print(line.rstrip())
>
> This accidentally adds back in the raw_output() function.
> We'll want to drop it, since it's no longer used by kunit.py.
>

Great catch! Will remove this for v3. Didn't realize this was
supposed to be removed.

> > +
> > +KTAP_VERSIONS = [1]
> > +TAP_VERSIONS = [13, 14]
> > +
> > +def check_version(version_num: int, accepted_versions: List[int],
> > +                       version_type: str, test: Test) -> None:
>
> Optional: we can make it clearer that this is an internal function by
> prefixing with a _
> E.g. def _check_version
>
> Same can go for all the other helpers here.
> pytype should be able to catch any missed names, so it should be low risk.
>
> But it's also fairly low reward, since we don't really have any other
> users, so the need to clamp down on what's "visible" to other packages
> is small.
>

I might leave off the _ prefix because it would require almost all of the
methods to be prefixed. However, this is reasonable so if others think
this is necessary, I am happy to change all of the methods.

> > +       """
> > +       Adds error to test object if version number is too high or too
> > +       low.
> > +
> > +       Parameters:
> > +       version_num - The inputted version number from the parsed KTAP or TAP
> > +               header line
> > +       accepted_version - List of accepted KTAP or TAP versions
> > +       version_type - 'KTAP' or 'TAP' depending on the type of
> > +               version line.
> > +       test - Test object for current test being parsed
> > +       """
> > +       if version_num < min(accepted_versions):
> > +               test.add_error(version_type +
> > +                       ' version lower than expected!')
> > +       elif version_num > max(accepted_versions):
> > +               test.add_error(
> > +                       version_type + ' version higher than expected!')
> > +
> > +def parse_ktap_header(lines: LineStream, test: Test) -> bool:
> > +       """
> > +       If the next line in LineStream matches the format of KTAP or TAP
> > +       header line, the version number is checked, the line is popped,
> > +       and returns True. Otherwise the method returns False.
> > +
> > +       Accepted formats:
> > +       - 'KTAP version [version number]'
> > +       - 'TAP version [version number]'
> > +
> > +       Parameters:
> > +       lines - LineStream of KTAP output to parse
> > +       test - Test object for current test being parsed
> > +
> > +       Return:
> > +       Boolean that represents if the next line in the LineStream was parsed
> > +               as the KTAP or TAP header line
>
> I think we can simplify these "Boolean that represents" with
>
> Return:
> True if we parsed a KTAP or header line
>

I like this change a lot. I was struggling to get the right wording
with the methods
that returned booleans. I will change this for v3.

> > +       """
> > +       ktap_match = KTAP_START.match(lines.peek())
> > +       tap_match = TAP_START.match(lines.peek())
> > +       if ktap_match:
> > +               version_num = int(ktap_match.group(1))
> > +               check_version(version_num, KTAP_VERSIONS, 'KTAP', test)
> > +       elif tap_match:
> > +               version_num = int(tap_match.group(1))
> > +               check_version(version_num, TAP_VERSIONS, 'TAP', test)
> >         else:
> >                 return False
> > -
> > -SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
> > -DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
> > -
> > -def parse_diagnostic(lines: LineStream, test_case: TestCase) -> bool:
> > -       save_non_diagnostic(lines, test_case)
> > -       if not lines:
> > +       test.log.append(lines.pop())
> > +       return True
> > +
> > +TEST_HEADER = re.compile(r'^# Subtest: (.*)$')
> > +
> > +def parse_test_header(lines: LineStream, test: Test) -> bool:
> > +       """
> > +       If the next line in LineStream matches the format of a test
> > +       header line, the name of test is set, the line is popped,
> > +       and returns True. Otherwise the method returns False.
> > +
> > +       Accepted format:
> > +       - '# Subtest: [test name]'
> > +
> > +       Parameters:
> > +       lines - LineStream of ktap output to parse
> > +       test - Test object for current test being parsed
> > +
> > +       Return:
> > +       Boolean that represents if the next line in the LineStream was parsed
> > +               as a test header
>
> ditto above, this could be
> True if we parsed a test header line.

See above. Will change this for v3.

>
> > +       """
> > +       match = TEST_HEADER.match(lines.peek())
> > +       if not match:
> >                 return False
> > +       test.log.append(lines.pop())
> > +       test.name = match.group(1)
> > +       return True
> > +
> > +TEST_PLAN = re.compile(r'1\.\.([0-9]+)')
> > +
> > +def parse_test_plan(lines: LineStream, test: Test) -> bool:
> > +       """
> > +       If the next line in LineStream matches the format of a test
> > +       plan line, the expected number of subtests is set in test object, an
> > +       error is thrown if there are 0 tests, the line is popped,
> > +       and returns True. Otherwise the method adds an error that the test
> > +       plan is missing to the test object and returns False.
>
> nit: "missing to the test object" => missing for?
>
> Perhaps we can rewrite this as something more like:
>
> Parses a test plan and stores the expected number of subtests in `test`.
> Returns False if the current line doesn't look like a test plan.
>
> It reports an error if the expected count is 0.
>

I definitely agree that 'missing for' is better than 'missing to'.
However, overall
this comment does seem confusing and does not match some of the updated
docstrings. This confusing format is shared by all of the parsing methods.
Thus, I would like to update the parsing method docstrings in v3. For example,
this docstring would be changed to:

Parses test plan line and stores the expected number of subtests in `test`.
Reports an error if expected count is 0.
Returns False and reports missing test plan error if fails to parse test plan.

> > +
> > +       Accepted format:
> > +       - '1..[number of subtests]'
> > +
> > +       Parameters:
> > +       lines - LineStream of ktap output to parse
> > +       test - Test object for current test being parsed
> > +
> > +       Return:
> > +       Boolean that represents if the next line in the LineStream was parsed
> > +               as a test plan
> > +       """
> > +       match = TEST_PLAN.match(lines.peek())
> > +       if not match:
> > +               test.expected_count = None
> > +               test.add_error('missing plan line!')
> > +               return False
> > +       test.log.append(lines.pop())
> > +       expected_count = int(match.group(1))
> > +       test.expected_count = expected_count
> > +       if expected_count == 0:
> > +               test.status = TestStatus.NO_TESTS
> > +               test.add_error('0 tests run!')
> > +       return True
> > +
> > +TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?(.*)$')
> > +
> > +TEST_RESULT_SKIP = re.compile(r'^(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
> > +
> > +def peek_test_name_match(lines: LineStream, test: Test) -> bool:
> > +       """
> > +       If the next line in LineStream matches the format of a test
> > +       result line and the name of the result line matches the name of the
> > +       current test, the method returns True. Otherwise it returns False.
> > +
> > +       Accepted format:
> > +       - '[ok|not ok] [test number] [-] [test name] [optional skip
> > +               directive]'
> > +
> > +       Parameters:
> > +       lines - LineStream of KTAP output to parse
> > +       test - Test object for current test being parsed
> > +
> > +       Return:
> > +       Boolean that represents if the next line in the LineStream matched a
> > +               test result line and the name matched the expected test name
> > +       """
> >         line = lines.peek()
> > -       match = SUBTEST_DIAGNOSTIC.match(line)
> > -       if match:
> > -               test_case.log.append(lines.pop())
> > -               crash_match = DIAGNOSTIC_CRASH_MESSAGE.match(line)
> > -               if crash_match:
> > -                       test_case.status = TestStatus.TEST_CRASHED
> > -               return True
> > -       else:
> > +       match = TEST_RESULT.match(line)
> > +       if not match:
> >                 return False
> > +       name = match.group(4)
> > +       return (name == test.name)
> > +
> > +def parse_test_result(lines: LineStream, test: Test,
> > +                       expected_num: int) -> bool:
> > +       """
> > +       If the next line in LineStream matches the format of a test
> > +       result line, the status in the result line is added to the test
> > +       object, the test number is checked to match the expected test number
> > +       and if not an error is added to the test object, and returns True.
> > +       Otherwise it returns False.
> > +
> > +       Note that the skip diirective is the only
>
> nit: diir => dir
>

Oops. Thanks for catching that. Will change in v3.

>
> > +       directive that causes a change in status and otherwise the directive
> > +       is included in the name of the test.
> > +
> > +       Accepted format:
> > +       - '[ok|not ok] [test number] [-] [test name] [optional skip
> > +               directive]'
> > +
> > +       Parameters:
> > +       lines - LineStream of KTAP output to parse
> > +       test - Test object for current test being parsed
> > +       expected_num - expected test number for current test
> > +
> > +       Return:
> > +       Boolean that represents if the next line in the LineStream was parsed
> > +               as a test result line.
> > +       """
> > +       line = lines.peek()
> > +       match = TEST_RESULT.match(line)
> > +       skip_match = TEST_RESULT_SKIP.match(line)
> >
> > -def parse_test_case(lines: LineStream) -> Optional[TestCase]:
> > -       test_case = TestCase()
> > -       save_non_diagnostic(lines, test_case)
> > -       while parse_diagnostic(lines, test_case):
> > -               pass
> > -       if parse_ok_not_ok_test_case(lines, test_case):
> > -               return test_case
> > -       else:
> > -               return None
> > -
> > -SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
> > +       # Check if line matches test result line format
> > +       if not match:
> > +               return False
> > +       test.log.append(lines.pop())
> >
> > -def parse_subtest_header(lines: LineStream) -> Optional[str]:
> > -       consume_non_diagnostic(lines)
> > -       if not lines:
> > -               return None
> > -       match = SUBTEST_HEADER.match(lines.peek())
> > -       if match:
> > -               lines.pop()
> > -               return match.group(1)
> > +       # Set name of test object
> > +       if skip_match:
> > +               test.name = skip_match.group(4)
> >         else:
> > -               return None
> > +               test.name = match.group(4)
> >
> > -SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
> > +       # Check test num
> > +       num = int(match.group(2))
> > +       if num != expected_num:
> > +               test.add_error('Expected test number ' +
> > +                       str(expected_num) + ' but found ' + str(num))
> >
> > -def parse_subtest_plan(lines: LineStream) -> Optional[int]:
> > -       consume_non_diagnostic(lines)
> > -       match = SUBTEST_PLAN.match(lines.peek())
> > -       if match:
> > -               lines.pop()
> > -               return int(match.group(1))
> > -       else:
> > -               return None
> > -
> > -def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
> > -       if left == right:
> > -               return left
> > -       elif left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
> > -               return TestStatus.TEST_CRASHED
> > -       elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
> > -               return TestStatus.FAILURE
> > -       elif left == TestStatus.SKIPPED:
> > -               return right
> > -       else:
> > -               return left
> > -
> > -def parse_ok_not_ok_test_suite(lines: LineStream,
> > -                              test_suite: TestSuite,
> > -                              expected_suite_index: int) -> bool:
> > -       consume_non_diagnostic(lines)
> > -       if not lines:
> > -               test_suite.status = TestStatus.TEST_CRASHED
> > -               return False
> > -       line = lines.peek()
> > -       match = OK_NOT_OK_MODULE.match(line)
> > -       if match:
> > -               lines.pop()
> > -               if match.group(1) == 'ok':
> > -                       test_suite.status = TestStatus.SUCCESS
> > -               else:
> > -                       test_suite.status = TestStatus.FAILURE
> > -               skip_match = OK_NOT_OK_SKIP.match(line)
> > -               if skip_match:
> > -                       test_suite.status = TestStatus.SKIPPED
> > -               suite_index = int(match.group(2))
> > -               if suite_index != expected_suite_index:
> > -                       print_with_timestamp(
> > -                               red('[ERROR] ') + 'expected_suite_index ' +
> > -                               str(expected_suite_index) + ', but got ' +
> > -                               str(suite_index))
> > +       # Set status of test object
> > +       status = match.group(1)
> > +       if test.status == TestStatus.TEST_CRASHED:
> >                 return True
> > +       elif skip_match:
> > +               test.status = TestStatus.SKIPPED
> > +       elif status == 'ok':
> > +               test.status = TestStatus.SUCCESS
> >         else:
> > -               return False
> > -
> > -def bubble_up_errors(status_list: Iterable[TestStatus]) -> TestStatus:
> > -       return reduce(max_status, status_list, TestStatus.SKIPPED)
> > +               test.status = TestStatus.FAILURE
> > +       return True
> > +
> > +def parse_diagnostic(lines: LineStream) -> List[str]:
> > +       """
> > +       If the next line in LineStream does not match the format of a test
> > +       case line or test header line, the line is checked if the test has
> > +       crashed and if so adds an error message, pops the line and adds it to
> > +       the log.
> > +
> > +       Line formats that are not parsed:
> > +       - '# Subtest: [test name]'
> > +       - '[ok|not ok] [test number] [-] [test name] [optional skip
> > +               directive]'
> > +
> > +       Parameters:
> > +       lines - LineStream of KTAP output to parse
> > +
> > +       Return:
> > +       Log of diagnostic lines
> > +       """
> > +       log = []  # type: List[str]
> > +       while lines and not TEST_RESULT.match(lines.peek()) and not \
> > +                       TEST_HEADER.match(lines.peek()):
> > +               log.append(lines.pop())
> > +       return log
> > +
> > +DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^# .*?: kunit test case crashed!$')
> > +
> > +def parse_crash_in_log(test: Test) -> bool:
> > +       """
> > +       Iterate through the lines of the log to parse for crash message.
> > +       If crash message found, set status to crashed and return True.
> > +       Otherwise return False.
> > +
> > +       Parameters:
> > +       test - Test object for current test being parsed
> > +
> > +       Return:
> > +       Boolean that represents if crash message found in log
> > +       """
> > +       for line in test.log:
> > +               if DIAGNOSTIC_CRASH_MESSAGE.match(line):
> > +                       test.status = TestStatus.TEST_CRASHED
> > +                       return True
> > +       return False
> >
> > -def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
> > -       max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
> > -       return max_status(max_test_case_status, test_suite.status)
> > +# Printing helper methods:
> >
> > -def parse_test_suite(lines: LineStream, expected_suite_index: int) -> Optional[TestSuite]:
> > -       if not lines:
> > -               return None
> > -       consume_non_diagnostic(lines)
> > -       test_suite = TestSuite()
> > -       test_suite.status = TestStatus.SUCCESS
> > -       name = parse_subtest_header(lines)
> > -       if not name:
> > -               return None
> > -       test_suite.name = name
> > -       expected_test_case_num = parse_subtest_plan(lines)
> > -       if expected_test_case_num is None:
> > -               return None
> > -       while expected_test_case_num > 0:
> > -               test_case = parse_test_case(lines)
> > -               if not test_case:
> > -                       break
> > -               test_suite.cases.append(test_case)
> > -               expected_test_case_num -= 1
> > -       if parse_ok_not_ok_test_suite(lines, test_suite, expected_suite_index):
> > -               test_suite.status = bubble_up_test_case_errors(test_suite)
> > -               return test_suite
> > -       elif not lines:
> > -               print_with_timestamp(red('[ERROR] ') + 'ran out of lines before end token')
> > -               return test_suite
> > -       else:
> > -               print(f'failed to parse end of suite "{name}", at line {lines.line_number()}: {lines.peek()}')
> > -               return None
> > +DIVIDER = '=' * 60
> >
> > -TAP_HEADER = re.compile(r'^TAP version 14$')
> > +RESET = '\033[0;0m'
> >
> > -def parse_tap_header(lines: LineStream) -> bool:
> > -       consume_non_diagnostic(lines)
> > -       if TAP_HEADER.match(lines.peek()):
> > -               lines.pop()
> > -               return True
> > -       else:
> > -               return False
> > +def red(text: str) -> str:
> > +       """Returns inputted string with red color code."""
> > +       return '\033[1;31m' + text + RESET
> >
> > -TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
> > +def yellow(text: str) -> str:
> > +       """Returns inputted string with yellow color code."""
> > +       return '\033[1;33m' + text + RESET
> >
> > -def parse_test_plan(lines: LineStream) -> Optional[int]:
> > -       consume_non_diagnostic(lines)
> > -       match = TEST_PLAN.match(lines.peek())
> > -       if match:
> > -               lines.pop()
> > -               return int(match.group(1))
> > -       else:
> > -               return None
> > -
> > -def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
> > -       return bubble_up_errors(x.status for x in test_suites)
> > -
> > -def parse_test_result(lines: LineStream) -> TestResult:
> > -       consume_non_diagnostic(lines)
> > -       if not lines or not parse_tap_header(lines):
> > -               return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
> > -       expected_test_suite_num = parse_test_plan(lines)
> > -       if expected_test_suite_num == 0:
> > -               return TestResult(TestStatus.NO_TESTS, [], lines)
> > -       elif expected_test_suite_num is None:
> > -               return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
> > -       test_suites = []
> > -       for i in range(1, expected_test_suite_num + 1):
> > -               test_suite = parse_test_suite(lines, i)
> > -               if test_suite:
> > -                       test_suites.append(test_suite)
> > -               else:
> > -                       print_with_timestamp(
> > -                               red('[ERROR] ') + ' expected ' +
> > -                               str(expected_test_suite_num) +
> > -                               ' test suites, but got ' + str(i - 2))
> > -                       break
> > -       test_suite = parse_test_suite(lines, -1)
> > -       if test_suite:
> > -               print_with_timestamp(red('[ERROR] ') +
> > -                       'got unexpected test suite: ' + test_suite.name)
> > -       if test_suites:
> > -               return TestResult(bubble_up_suite_errors(test_suites), test_suites, lines)
> > -       else:
> > -               return TestResult(TestStatus.NO_TESTS, [], lines)
> > +def green(text: str) -> str:
> > +       """Returns inputted string with green color code."""
> > +       return '\033[1;32m' + text + RESET
> >
> > -class TestCounts:
> > -       passed: int
> > -       failed: int
> > -       crashed: int
> > -       skipped: int
> > +ANSI_LEN = len(red(''))
> >
> > -       def __init__(self):
> > -               self.passed = 0
> > -               self.failed = 0
> > -               self.crashed = 0
> > -               self.skipped = 0
> > +def print_with_timestamp(message: str) -> None:
> > +       """Prints message with timestamp at beginning."""
> > +       print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
> >
> > -       def total(self) -> int:
> > -               return self.passed + self.failed + self.crashed + self.skipped
> > -
> > -def print_and_count_results(test_result: TestResult) -> TestCounts:
> > -       counts = TestCounts()
> > -       for test_suite in test_result.suites:
> > -               if test_suite.status == TestStatus.SUCCESS:
> > -                       print_suite_divider(green('[PASSED] ') + test_suite.name)
> > -               elif test_suite.status == TestStatus.SKIPPED:
> > -                       print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
> > -               elif test_suite.status == TestStatus.TEST_CRASHED:
> > -                       print_suite_divider(red('[CRASHED] ' + test_suite.name))
> > +def format_test_divider(message: str, len_message: int) -> str:
> > +       """
> > +       Returns string with message centered in fixed width divider.
> > +
> > +       Example:
> > +       '===================== message example ====================='
> > +
> > +       Parameters:
> > +       message - message to be centered in divider line
> > +       len_message - length of the message to be printed such that
> > +               any characters of the color codes are not counted
> > +
> > +       Return:
> > +       String containing message centered in fixed width divider
> > +       """
> > +       default_count = 3  # default number of dashes
> > +       len_1 = default_count
> > +       len_2 = default_count
> > +       difference = len(DIVIDER) - len_message - 2  # 2 spaces added
> > +       if difference > 0:
> > +               # calculate number of dashes for each side of the divider
> > +               len_1 = int(difference / 2)
> > +               len_2 = difference - len_1
> > +       return ('=' * len_1) + ' ' + message + ' ' + ('=' * len_2)
> > +
> > +def print_test_header(test: Test) -> None:
> > +       """
> > +       Prints test header with test name and optionally the expected number
> > +       of subtests.
> > +
> > +       Example:
> > +       '=================== example (2 subtests) ==================='
> > +
> > +       Parameters:
> > +       test - Test object representing current test being printed
> > +       """
> > +       message = test.name
> > +       if test.expected_count:
> > +               message += ' (' + str(test.expected_count) + ' subtests)'
> > +       print_with_timestamp(format_test_divider(message, len(message)))
> > +
> > +def print_log(log: Iterable[str]) -> None:
> > +       """
> > +       Prints all strings in saved log for test in yellow.
> > +
> > +       Parameters:
> > +       log - Iterable object with all strings saved in log for test
> > +       """
> > +       for m in log:
> > +               print_with_timestamp(yellow(m))
> > +       print_with_timestamp('')
> > +
> > +def format_test_result(test: Test) -> str:
> > +       """
> > +       Returns string with formatted test result with colored status and test
> > +       name.
> > +
> > +       Example:
> > +       '[PASSED] example'
> > +
> > +       Parameters:
> > +       test - Test object representing current test being printed
> > +
> > +       Return:
> > +       String containing formatted test result
> > +       """
> > +       if test.status == TestStatus.SUCCESS:
> > +               return (green('[PASSED] ') + test.name)
> > +       elif test.status == TestStatus.SKIPPED:
> > +               return (yellow('[SKIPPED] ') + test.name)
> > +       elif test.status == TestStatus.TEST_CRASHED:
> > +               print_log(test.log)
> > +               return (red('[CRASHED] ') + test.name)
> > +       else:
> > +               print_log(test.log)
> > +               return (red('[FAILED] ') + test.name)
> > +
> > +def print_test_result(test: Test) -> None:
> > +       """
> > +       Prints result line with status of test.
> > +
> > +       Example:
> > +       '[PASSED] example'
> > +
> > +       Parameters:
> > +       test - Test object representing current test being printed
> > +       """
> > +       print_with_timestamp(format_test_result(test))
> > +
> > +def print_test_footer(test: Test) -> None:
> > +       """
> > +       Prints test footer with status of test.
> > +
> > +       Example:
> > +       '===================== [PASSED] example ====================='
> > +
> > +       Parameters:
> > +       test - Test object representing current test being printed
> > +       """
> > +       message = format_test_result(test)
> > +       print_with_timestamp(format_test_divider(message,
> > +               len(message) - ANSI_LEN))
> > +
> > +def print_summary_line(test: Test) -> None:
> > +       """
> > +       Prints summary line of test object. Color of line is dependent on
> > +       status of test. Color is green if test passes, yellow if test is
> > +       skipped, and red if the test fails or crashes. Summary line contains
> > +       counts of the statuses of the tests subtests or the test itself if it
> > +       has no subtests.
> > +
> > +       Example:
> > +       "Testing complete. Passed: 2, Failed: 0, Crashed: 0, Skipped: 0,
> > +       Errors: 0"
> > +
> > +       test - Test object representing current test being printed
> > +       """
> > +       if test.status == TestStatus.SUCCESS or \
> > +                       test.status == TestStatus.NO_TESTS:
> > +               color = green
> > +       elif test.status == TestStatus.SKIPPED:
> > +               color = yellow
> > +       else:
> > +               color = red
> > +       counts = test.counts
> > +       print_with_timestamp(color('Testing complete. ' + str(counts)))
> > +
> > +def print_error(error_message: str) -> None:
> > +       """
> > +       Prints error message with error format.
> > +
> > +       Example:
> > +       "[ERROR] Test example: missing test plan!"
> > +
> > +       Parameters:
> > +       error_message - message describing error
> > +       """
> > +       print_with_timestamp(red('[ERROR] ') + error_message)
> > +
> > +# Other methods:
> > +
> > +def bubble_up_test_results(test: Test) -> None:
> > +       """
> > +       If the test has subtests, add the test counts of the subtests to the
> > +       test and check if any of the tests crashed and if so set the test
> > +       status to crashed. Otherwise if the test has no subtests add the
> > +       status of the test to the test counts.
> > +
> > +       Parameters:
> > +       test - Test object for current test being parsed
> > +       """
> > +       parse_crash_in_log(test)
> > +       subtests = test.subtests
> > +       counts = test.counts
> > +       status = test.status
> > +       for t in subtests:
> > +               counts.add_subtest_counts(t.counts)
> > +       if counts.total() == 0:
> > +               counts.add_status(status)
> > +       elif test.counts.get_status() == TestStatus.TEST_CRASHED:
> > +               test.status = TestStatus.TEST_CRASHED
> > +
> > +def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
> > +       """
> > +       Finds next test to parse in LineStream, creates new Test object,
> > +       parses any subtests of the test, populates Test object with all
> > +       information (status, name) about the test and the Test objects for
> > +       any subtests, and then returns the Test object. The method accepts
> > +       three formats of tests:
> > +
> > +       Accepted test formats:
> > +
> > +       - Main KTAP/TAP header
> > +
> > +       Example:
> > +
> > +       KTAP version 1
> > +       1..4
> > +       [subtests]
> > +
> > +       - Subtest header line
> > +
> > +       Example:
> > +
> > +       # Subtest: name
> > +       1..3
> > +       [subtests]
> > +       ok 1 name
> > +
> > +       - Test result line
> > +
> > +       Example:
> > +
> > +       ok 1 - test
> > +
> > +       Parameters:
> > +       lines - LineStream of KTAP output to parse
> > +       expected_num - expected test number for test to be parsed
> > +       log - list of strings containing any preceding diagnostic lines
> > +               corresponding to the current test
> > +
> > +       Return:
> > +       Test object populated with characteristics and any subtests
> > +       """
> > +       test = Test()
> > +       test.log.extend(log)
> > +       parent_test = False
> > +       main = parse_ktap_header(lines, test)
> > +       if main:
> > +               # If KTAP/TAP header is found, attempt to parse
> > +               # test plan
> > +               test.name = "main"
> > +               parse_test_plan(lines, test)
> > +       else:
> > +               # If KTAP/TAP header is not found, test must be subtest
> > +               # header or test result line so parse attempt to parser
> > +               # subtest header
> > +               parent_test = parse_test_header(lines, test)
> > +               if parent_test:
> > +                       # If subtest header is found, attempt to parse
> > +                       # test plan and print header
> > +                       parse_test_plan(lines, test)
> > +                       print_test_header(test)
> > +       expected_count = test.expected_count
> > +       subtests = []
> > +       test_num = 1
> > +       while main or expected_count is None or test_num <= expected_count:
> > +               # Loop to parse any subtests.
> > +               # If test is main test, do not break until no lines left.
> > +               # Otherwise, break after parsing expected number of tests or
> > +               # if expected number of tests is unknown break when found
> > +               # test result line with matching name to subtest header.
> > +               if not lines:
> > +                       if expected_count and test_num <= expected_count:
> > +                               test.add_error('missing expected subtests!')
> > +                       break
> > +               sub_log = parse_diagnostic(lines)
> > +               if not expected_count and not main and \
> > +                               peek_test_name_match(lines, test):
> > +                       test.log.extend(sub_log)
> > +                       break
> > +               subtests.append(parse_test(lines, test_num, sub_log))
> > +               test_num += 1
> > +       test.subtests = subtests
> > +       if not main:
> > +               # If not main test, look for test result line
> > +               test.log.extend(parse_diagnostic(lines))
> > +               if (parent_test and peek_test_name_match(lines, test)) or \
> > +                               not parent_test:
> > +                       parse_test_result(lines, test, expected_num)
> >                 else:
> > -                       print_suite_divider(red('[FAILED] ') + test_suite.name)
> > -               for test_case in test_suite.cases:
> > -                       if test_case.status == TestStatus.SUCCESS:
> > -                               counts.passed += 1
> > -                               print_with_timestamp(green('[PASSED] ') + test_case.name)
> > -                       elif test_case.status == TestStatus.SKIPPED:
> > -                               counts.skipped += 1
> > -                               print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
> > -                       elif test_case.status == TestStatus.TEST_CRASHED:
> > -                               counts.crashed += 1
> > -                               print_with_timestamp(red('[CRASHED] ' + test_case.name))
> > -                               print_log(map(yellow, test_case.log))
> > -                               print_with_timestamp('')
> > -                       else:
> > -                               counts.failed += 1
> > -                               print_with_timestamp(red('[FAILED] ') + test_case.name)
> > -                               print_log(map(yellow, test_case.log))
> > -                               print_with_timestamp('')
> > -       return counts
> > +                       test.add_error('missing subtest result line!')
> > +       # Add statuses to TestCounts attribute in Test object
> > +       bubble_up_test_results(test)
> > +       if parent_test:
> > +               # If test has subtests and is not the main test object, print
> > +               # footer.
> > +               print_test_footer(test)
> > +       elif not main:
> > +               print_test_result(test)
> > +       return test
> >
> >  def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
> > -       counts = TestCounts()
> > +       """
> > +       Using kernel output, extract KTAP lines, parse the lines for test
> > +       results and print condensed test results and summary line .
> > +
> > +       Parameters:
> > +       kernel_output - Iterable object contains lines of kernel output
> > +
> > +       Return:
> > +       TestResult - Tuple containg status of main test object, main test
> > +               object with all subtests, and log of all KTAP lines.
> > +       """
> > +       print_with_timestamp(DIVIDER)
> >         lines = extract_tap_lines(kernel_output)
> > -       test_result = parse_test_result(lines)
> > -       if test_result.status == TestStatus.NO_TESTS:
> > -               print(red('[ERROR] ') + yellow('no tests run!'))
> > -       elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
> > -               print(red('[ERROR] ') + yellow('could not parse test results!'))
> > +       test = Test()
> > +       if not lines:
> > +               test.add_error('invalid KTAP input!')
> > +               test.status = TestStatus.FAILURE_TO_PARSE_TESTS
> >         else:
> > -               counts = print_and_count_results(test_result)
> > +               test = parse_test(lines, 0, [])
> > +               if test.status != TestStatus.NO_TESTS:
> > +                       test.status = test.counts.get_status()
> >         print_with_timestamp(DIVIDER)
> > -       if test_result.status == TestStatus.SUCCESS:
> > -               fmt = green
> > -       elif test_result.status == TestStatus.SKIPPED:
> > -               fmt = yellow
> > -       else:
> > -               fmt =red
> > -       print_with_timestamp(
> > -               fmt('Testing complete. %d tests run. %d failed. %d crashed. %d skipped.' %
> > -                   (counts.total(), counts.failed, counts.crashed, counts.skipped)))
> > -       return test_result
> > +       print_summary_line(test)
> > +       return TestResult(test.status, test, lines)
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 619c4554cbff..e527b90de8ea 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -106,10 +106,10 @@ class KUnitParserTest(unittest.TestCase):
> >                 with open(log_path) as file:
> >                         result = kunit_parser.extract_tap_lines(file.readlines())
> >                 self.assertContains('TAP version 14', result)
> > -               self.assertContains('   # Subtest: example', result)
> > -               self.assertContains('   1..2', result)
> > -               self.assertContains('   ok 1 - example_simple_test', result)
> > -               self.assertContains('   ok 2 - example_mock_test', result)
> > +               self.assertContains('# Subtest: example', result)
> > +               self.assertContains('1..2', result)
> > +               self.assertContains('ok 1 - example_simple_test', result)
> > +               self.assertContains('ok 2 - example_mock_test', result)
> >                 self.assertContains('ok 1 - example', result)
> >
> >         def test_output_with_prefix_isolated_correctly(self):
> > @@ -117,28 +117,28 @@ class KUnitParserTest(unittest.TestCase):
> >                 with open(log_path) as file:
> >                         result = kunit_parser.extract_tap_lines(file.readlines())
> >                 self.assertContains('TAP version 14', result)
> > -               self.assertContains('   # Subtest: kunit-resource-test', result)
> > -               self.assertContains('   1..5', result)
> > -               self.assertContains('   ok 1 - kunit_resource_test_init_resources', result)
> > -               self.assertContains('   ok 2 - kunit_resource_test_alloc_resource', result)
> > -               self.assertContains('   ok 3 - kunit_resource_test_destroy_resource', result)
> > -               self.assertContains(' foo bar   #', result)
> > -               self.assertContains('   ok 4 - kunit_resource_test_cleanup_resources', result)
> > -               self.assertContains('   ok 5 - kunit_resource_test_proper_free_ordering', result)
> > +               self.assertContains('# Subtest: kunit-resource-test', result)
> > +               self.assertContains('1..5', result)
> > +               self.assertContains('ok 1 - kunit_resource_test_init_resources', result)
> > +               self.assertContains('ok 2 - kunit_resource_test_alloc_resource', result)
> > +               self.assertContains('ok 3 - kunit_resource_test_destroy_resource', result)
> > +               self.assertContains('foo bar    #', result)
> > +               self.assertContains('ok 4 - kunit_resource_test_cleanup_resources', result)
> > +               self.assertContains('ok 5 - kunit_resource_test_proper_free_ordering', result)
> >                 self.assertContains('ok 1 - kunit-resource-test', result)
> > -               self.assertContains(' foo bar   # non-kunit output', result)
> > -               self.assertContains('   # Subtest: kunit-try-catch-test', result)
> > -               self.assertContains('   1..2', result)
> > -               self.assertContains('   ok 1 - kunit_test_try_catch_successful_try_no_catch',
> > +               self.assertContains('foo bar    # non-kunit output', result)
> > +               self.assertContains('# Subtest: kunit-try-catch-test', result)
> > +               self.assertContains('1..2', result)
> > +               self.assertContains('ok 1 - kunit_test_try_catch_successful_try_no_catch',
> >                                     result)
> > -               self.assertContains('   ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch',
> > +               self.assertContains('ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch',
> >                                     result)
> >                 self.assertContains('ok 2 - kunit-try-catch-test', result)
> > -               self.assertContains('   # Subtest: string-stream-test', result)
> > -               self.assertContains('   1..3', result)
> > -               self.assertContains('   ok 1 - string_stream_test_empty_on_creation', result)
> > -               self.assertContains('   ok 2 - string_stream_test_not_empty_after_add', result)
> > -               self.assertContains('   ok 3 - string_stream_test_get_string', result)
> > +               self.assertContains('# Subtest: string-stream-test', result)
> > +               self.assertContains('1..3', result)
> > +               self.assertContains('ok 1 - string_stream_test_empty_on_creation', result)
> > +               self.assertContains('ok 2 - string_stream_test_not_empty_after_add', result)
> > +               self.assertContains('ok 3 - string_stream_test_get_string', result)
> >                 self.assertContains('ok 3 - string-stream-test', result)
> >
> >         def test_parse_successful_test_log(self):
> > @@ -148,6 +148,13 @@ class KUnitParserTest(unittest.TestCase):
> >                 self.assertEqual(
> >                         kunit_parser.TestStatus.SUCCESS,
> >                         result.status)
> > +       def test_parse_successful_nested_tests_log(self):
> > +               all_passed_log = test_data_path('test_is_test_passed-all_passed_nested.log')
> > +               with open(all_passed_log) as file:
> > +                       result = kunit_parser.parse_run_tests(file.readlines())
> > +               self.assertEqual(
> > +                       kunit_parser.TestStatus.SUCCESS,
> > +                       result.status)
> >
> >         def test_parse_failed_test_log(self):
> >                 failed_log = test_data_path('test_is_test_passed-failure.log')
> > @@ -162,17 +169,31 @@ class KUnitParserTest(unittest.TestCase):
> >                 with open(empty_log) as file:
> >                         result = kunit_parser.parse_run_tests(
> >                                 kunit_parser.extract_tap_lines(file.readlines()))
> > -               self.assertEqual(0, len(result.suites))
> > +               self.assertEqual(0, len(result.test.subtests))
> >                 self.assertEqual(
> >                         kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
> >                         result.status)
> >
> > +       def test_missing_test_plan(self):
> > +               missing_plan_log = test_data_path('test_is_test_passed-'
> > +                       'missing_plan.log')
> > +               with open(missing_plan_log) as file:
> > +                       result = kunit_parser.parse_run_tests(
> > +                               kunit_parser.extract_tap_lines(
> > +                               file.readlines()))
> > +               self.assertEqual(2, result.test.counts.errors)
> > +               self.assertEqual(
> > +                       kunit_parser.TestStatus.SUCCESS,
> > +                       result.status)
> > +
> >         def test_no_tests(self):
> > -               empty_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
> > -               with open(empty_log) as file:
> > +               header_log = test_data_path('test_is_test_passed-'
> > +                       'no_tests_run_with_header.log')
> > +               with open(header_log) as file:
> >                         result = kunit_parser.parse_run_tests(
> > -                               kunit_parser.extract_tap_lines(file.readlines()))
> > -               self.assertEqual(0, len(result.suites))
> > +                               kunit_parser.extract_tap_lines(
> > +                               file.readlines()))
> > +               self.assertEqual(0, len(result.test.subtests))
> >                 self.assertEqual(
> >                         kunit_parser.TestStatus.NO_TESTS,
> >                         result.status)
> > @@ -182,15 +203,17 @@ class KUnitParserTest(unittest.TestCase):
> >                 print_mock = mock.patch('builtins.print').start()
> >                 with open(crash_log) as file:
> >                         result = kunit_parser.parse_run_tests(
> > -                               kunit_parser.extract_tap_lines(file.readlines()))
> > -               print_mock.assert_any_call(StrContains('could not parse test results!'))
> > +                               kunit_parser.extract_tap_lines(
> > +                               file.readlines()))
> > +               print_mock.assert_any_call(StrContains('invalid KTAP input!'))
> >                 print_mock.stop()
> >                 file.close()
> >
> >         def test_crashed_test(self):
> >                 crashed_log = test_data_path('test_is_test_passed-crash.log')
> >                 with open(crashed_log) as file:
> > -                       result = kunit_parser.parse_run_tests(file.readlines())
> > +                       result = kunit_parser.parse_run_tests(
> > +                               file.readlines())
> >                 self.assertEqual(
> >                         kunit_parser.TestStatus.TEST_CRASHED,
> >                         result.status)
> > @@ -216,6 +239,23 @@ class KUnitParserTest(unittest.TestCase):
> >                         result.status)
> >                 file.close()
> >
> > +       def test_ignores_hyphen(self):
> > +               hyphen_log = test_data_path('test_strip_hyphen.log')
> > +               file = open(hyphen_log)
> > +               result = kunit_parser.parse_run_tests(file.readlines())
> > +
> > +               # A skipped test does not fail the whole suite.
> > +               self.assertEqual(
> > +                       kunit_parser.TestStatus.SUCCESS,
> > +                       result.status)
> > +               self.assertEqual(
> > +                       "sysctl_test",
> > +                       result.test.subtests[0].name)
> > +               self.assertEqual(
> > +                       "example",
> > +                       result.test.subtests[1].name)
> > +               file.close()
> > +
> >
> >         def test_ignores_prefix_printk_time(self):
> >                 prefix_log = test_data_path('test_config_printk_time.log')
> > @@ -224,7 +264,7 @@ class KUnitParserTest(unittest.TestCase):
> >                         self.assertEqual(
> >                                 kunit_parser.TestStatus.SUCCESS,
> >                                 result.status)
> > -                       self.assertEqual('kunit-resource-test', result.suites[0].name)
> > +                       self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
> >
> >         def test_ignores_multiple_prefixes(self):
> >                 prefix_log = test_data_path('test_multiple_prefixes.log')
> > @@ -233,7 +273,7 @@ class KUnitParserTest(unittest.TestCase):
> >                         self.assertEqual(
> >                                 kunit_parser.TestStatus.SUCCESS,
> >                                 result.status)
> > -                       self.assertEqual('kunit-resource-test', result.suites[0].name)
> > +                       self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
> >
> >         def test_prefix_mixed_kernel_output(self):
> >                 mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
> > @@ -242,7 +282,7 @@ class KUnitParserTest(unittest.TestCase):
> >                         self.assertEqual(
> >                                 kunit_parser.TestStatus.SUCCESS,
> >                                 result.status)
> > -                       self.assertEqual('kunit-resource-test', result.suites[0].name)
> > +                       self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
> >
> >         def test_prefix_poundsign(self):
> >                 pound_log = test_data_path('test_pound_sign.log')
> > @@ -251,16 +291,16 @@ class KUnitParserTest(unittest.TestCase):
> >                         self.assertEqual(
> >                                 kunit_parser.TestStatus.SUCCESS,
> >                                 result.status)
> > -                       self.assertEqual('kunit-resource-test', result.suites[0].name)
> > +                       self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
> >
> >         def test_kernel_panic_end(self):
> >                 panic_log = test_data_path('test_kernel_panic_interrupt.log')
> >                 with open(panic_log) as file:
> >                         result = kunit_parser.parse_run_tests(file.readlines())
> >                         self.assertEqual(
> > -                               kunit_parser.TestStatus.TEST_CRASHED,
> > +                               kunit_parser.TestStatus.SUCCESS,
> >                                 result.status)
> > -                       self.assertEqual('kunit-resource-test', result.suites[0].name)
> > +                       self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
> >
> >         def test_pound_no_prefix(self):
> >                 pound_log = test_data_path('test_pound_no_prefix.log')
> > @@ -269,7 +309,7 @@ class KUnitParserTest(unittest.TestCase):
> >                         self.assertEqual(
> >                                 kunit_parser.TestStatus.SUCCESS,
> >                                 result.status)
> > -                       self.assertEqual('kunit-resource-test', result.suites[0].name)
> > +                       self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
> >
> >  class LinuxSourceTreeTest(unittest.TestCase):
> >
> > @@ -291,6 +331,14 @@ class LinuxSourceTreeTest(unittest.TestCase):
> >                                 pass
> >                         tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
> >
> > +       def test_kselftest_nested(self):
> > +               kselftest_log = test_data_path('test_is_test_passed-kselftest.log')
> > +               with open(kselftest_log) as file:
> > +                       result = kunit_parser.parse_run_tests(file.readlines())
> > +                       self.assertEqual(
> > +                               kunit_parser.TestStatus.SUCCESS,
> > +                               result.status)
> > +
> >         # TODO: add more test cases.
> >
> >
> > @@ -322,6 +370,12 @@ class KUnitJsonTest(unittest.TestCase):
> >                 result = self._json_for('test_is_test_passed-no_tests_run_with_header.log')
> >                 self.assertEqual(0, len(result['sub_groups']))
> >
> > +       def test_nested_json(self):
> > +               result = self._json_for('test_is_test_passed-all_passed_nested.log')
> > +               self.assertEqual(
> > +                       {'name': 'example_simple_test', 'status': 'PASS'},
> > +                       result["sub_groups"][0]["sub_groups"][0]["test_cases"][0])
> > +
> >  class StrContains(str):
> >         def __eq__(self, other):
> >                 return self in other
> > @@ -380,7 +434,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.assertEqual(e.exception.code, 1)
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
> >                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
> > -               self.print_mock.assert_any_call(StrContains(' 0 tests run'))
> > +               self.print_mock.assert_any_call(StrContains('invalid KTAP input!'))
> >
> >         def test_exec_raw_output(self):
> >                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> > @@ -388,7 +442,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
> >                 for call in self.print_mock.call_args_list:
> >                         self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
> > -                       self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
> > +                       self.assertNotEqual(call, mock.call(StrContains(' 0 tests run!')))
> >
> >         def test_run_raw_output(self):
> >                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> > @@ -397,7 +451,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
> >                 for call in self.print_mock.call_args_list:
> >                         self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
> > -                       self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
> > +                       self.assertNotEqual(call, mock.call(StrContains(' 0 tests run!')))
> >
> >         def test_run_raw_output_kunit(self):
> >                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log b/tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log
> > new file mode 100644
> > index 000000000000..9d5b04fe43a6
> > --- /dev/null
> > +++ b/tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log
> > @@ -0,0 +1,34 @@
> > +TAP version 14
> > +1..2
> > +       # Subtest: sysctl_test
> > +       1..4
> > +       # sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
> > +       ok 1 - sysctl_test_dointvec_null_tbl_data
> > +               # Subtest: example
> > +               1..2
> > +       init_suite
> > +               # example_simple_test: initializing
> > +               # example_simple_test: example_simple_test passed
> > +               ok 1 - example_simple_test
> > +               # example_mock_test: initializing
> > +               # example_mock_test: example_mock_test passed
> > +               ok 2 - example_mock_test
> > +       kunit example: all tests passed
> > +       ok 2 - example
> > +       # sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
> > +       ok 3 - sysctl_test_dointvec_table_len_is_zero
> > +       # sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
> > +       ok 4 - sysctl_test_dointvec_table_read_but_position_set
> > +kunit sysctl_test: all tests passed
> > +ok 1 - sysctl_test
> > +       # Subtest: example
> > +       1..2
> > +init_suite
> > +       # example_simple_test: initializing
> > +       # example_simple_test: example_simple_test passed
> > +       ok 1 - example_simple_test
> > +       # example_mock_test: initializing
> > +       # example_mock_test: example_mock_test passed
> > +       ok 2 - example_mock_test
> > +kunit example: all tests passed
> > +ok 2 - example
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
> > new file mode 100644
> > index 000000000000..65d3f27feaf2
> > --- /dev/null
> > +++ b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
> > @@ -0,0 +1,14 @@
> > +TAP version 13
> > +1..2
> > +# selftests: membarrier: membarrier_test_single_thread
> > +# TAP version 13
> > +# 1..2
> > +# ok 1 sys_membarrier available
> > +# ok 2 sys membarrier invalid command test: command = -1, flags = 0, errno = 22. Failed as expected
> > +ok 1 selftests: membarrier: membarrier_test_single_thread
> > +# selftests: membarrier: membarrier_test_multi_thread
> > +# TAP version 13
> > +# 1..2
> > +# ok 1 sys_membarrier available
> > +# ok 2 sys membarrier invalid command test: command = -1, flags = 0, errno = 22. Failed as expected
> > +ok 2 selftests: membarrier: membarrier_test_multi_thread
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
> > new file mode 100644
> > index 000000000000..5cd17b7f818a
> > --- /dev/null
> > +++ b/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
> > @@ -0,0 +1,31 @@
> > +KTAP version 1
> > +       # Subtest: sysctl_test
> > +       # sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
> > +       ok 1 - sysctl_test_dointvec_null_tbl_data
> > +       # sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
> > +       ok 2 - sysctl_test_dointvec_table_maxlen_unset
> > +       # sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
> > +       ok 3 - sysctl_test_dointvec_table_len_is_zero
> > +       # sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
> > +       ok 4 - sysctl_test_dointvec_table_read_but_position_set
> > +       # sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
> > +       ok 5 - sysctl_test_dointvec_happy_single_positive
> > +       # sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
> > +       ok 6 - sysctl_test_dointvec_happy_single_negative
> > +       # sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
> > +       ok 7 - sysctl_test_dointvec_single_less_int_min
> > +       # sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
> > +       ok 8 - sysctl_test_dointvec_single_greater_int_max
> > +kunit sysctl_test: all tests passed
> > +ok 1 - sysctl_test
> > +       # Subtest: example
> > +       1..2
> > +init_suite
> > +       # example_simple_test: initializing
> > +       # example_simple_test: example_simple_test passed
> > +       ok 1 - example_simple_test
> > +       # example_mock_test: initializing
> > +       # example_mock_test: example_mock_test passed
> > +       ok 2 - example_mock_test
> > +kunit example: all tests passed
> > +ok 2 - example
> > diff --git a/tools/testing/kunit/test_data/test_strip_hyphen.log b/tools/testing/kunit/test_data/test_strip_hyphen.log
> > new file mode 100644
> > index 000000000000..92ac7c24b374
> > --- /dev/null
> > +++ b/tools/testing/kunit/test_data/test_strip_hyphen.log
> > @@ -0,0 +1,16 @@
> > +KTAP version 1
> > +1..2
> > +       # Subtest: sysctl_test
> > +       1..1
> > +       # sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
> > +       ok 1 - sysctl_test_dointvec_null_tbl_data
> > +kunit sysctl_test: all tests passed
> > +ok 1 - sysctl_test
> > +       # Subtest: example
> > +       1..1
> > +init_suite
> > +       # example_simple_test: initializing
> > +       # example_simple_test: example_simple_test passed
> > +       ok 1 example_simple_test
> > +kunit example: all tests passed
> > +ok 2 example
> > --
> > 2.33.0.259.gc128427fd7-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210826195505.3066755-1-rmoar%40google.com.
