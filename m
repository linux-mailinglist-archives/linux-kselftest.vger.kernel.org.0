Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AAD3E866C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 01:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhHJXZk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 19:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhHJXZj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 19:25:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD179C061765
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Aug 2021 16:25:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id go31so407345ejc.6
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Aug 2021 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lghdrSZtTl0kY+s9Tapi7Mnd/ccHoio1Yid/BdW6bxA=;
        b=qqHlNivY0RYjAbDSQppf902gUAGvosW4KPXXDb7R2q2PmOt51sS7jjilYvsAA2LAo8
         0UE15xzKY8nFx+uXjg5vFC28xwPwjDP9WVcBYFLi+npnBkLBkjWgB/9FhbxclIkMUj0+
         PzTOWJ1G7+mMbBxTcIDP4AbF9jmG90cjObXHXpKUzo8xlKFdyxkCkHd4oKT8kOAN1CPD
         m6AN3kPTONIVauiAZbCFuyWMhyGBhl8zJwUWQw56PPdTb6DaaJfSE0iP3iQciCIGR6mZ
         sz2uETizaVv9M/D5cqZeZ5JwVPQoZLLkAkXjqeFAXgz54DgMsa/+GECZy0EkSDm4Al77
         i4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lghdrSZtTl0kY+s9Tapi7Mnd/ccHoio1Yid/BdW6bxA=;
        b=JjRPNjLZIFUtc7dBPmEQouG0yfD0yeI1wUC6l6p28t+gPbsMWXZYaFOJ87rR82Am6q
         Ow902YuAwu9pHlkYV09vjkTpt3DLI67+MmWZ2HqlzXtUSY0uS58pjsrQFGWK7bIa6TFQ
         v6rQ15cTwSh4qjXmpugAq6con3WThjheMBmpuCO8GRlHpIXqnmtQVRPSSa6EAhnViub8
         j1tXgzyUBjmmmm3lCxlanw3VsFERdCKz7vmmd7zfLXRvYtXcHLZX+DxLiWq3hGwKGUhc
         jmSa6HoM7ncLgEXLjYEoEbYzW7kxER3eM6mPfUVWk7YB+g/oI/jdITHR4PnM5qCA1R5S
         /IiQ==
X-Gm-Message-State: AOAM532D79mYYxNL1SV3NHWPzVRBPkN6PlOubl+ZlILc7PXvHg3z0lVP
        831bxMfaz2ghveDDUg3n/enzLLS0wufNwclag1GV6w==
X-Google-Smtp-Source: ABdhPJwu6KcgH6NQprGnF9kZSkdiTifMLo0YFm1ytSkChZ8KoNEaVImCcNn2ffJre9evpdBt5rgy/qjGaFXJ3QMMbpI=
X-Received: by 2002:a17:906:b0d4:: with SMTP id bk20mr792106ejb.535.1628637915175;
 Tue, 10 Aug 2021 16:25:15 -0700 (PDT)
MIME-Version: 1.0
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 10 Aug 2021 16:25:03 -0700
Message-ID: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
Subject: RFC - kernel test result specification (KTAP)
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Tim.Bird@sony.com,
        shuah@kernel.org, Daniel Latypov <dlatypov@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We are looking to further standardise the output format used by kernel
test frameworks like kselftest and KUnit. Thus far we have used the
TAP (Test Anything Protocol) specification, but it has been extended
in many different ways, so we would like to agree on a common "Kernel
TAP" (KTAP) format to resolve these differences. Thus, below is a
draft of a specification of KTAP. Note that this specification is
largely based on the current format of test results for KUnit tests.

Additionally, this specification was heavily inspired by the KTAP
specification draft by Tim Bird
(https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/).
However, there are some notable differences to his specification. One
such difference is the format of nested tests is more fully specified
in the following specification. However, they are specified in a way
which may not be compatible with many kselftest nested tests.

=====================
Specification of KTAP
=====================

TAP, or the Test Anything Protocol is a format for specifying test
results used by a number of projects. It's website and specification
are found at: https://testanything.org/. The Linux Kernel uses TAP
output for test results. However, KUnit (and other Kernel testing
frameworks such as kselftest) have some special needs for test results
which don't gel perfectly with the original TAP specification. Thus, a
"Kernel TAP" (KTAP) format is specified to extend and alter TAP to
support these use-cases.

KTAP Output consists of 5 major elements (all line-based):
- The version line
- Plan lines
- Test case result lines
- Diagnostic lines
- A bail out line

An important component in this specification of KTAP is the
specification of the format of nested tests. This can be found in the
section on nested tests below.

The version line
----------------

The first line of KTAP output must be the version line. As this
specification documents the first version of KTAP,  the recommended
version line is "KTAP version 1". However, since all kernel testing
frameworks use TAP version lines, "TAP version 14" and "TAP version
13" are all acceptable version lines. Version lines with other
versions of TAP or KTAP will not cause the parsing of the test results
to fail but it will produce an error.

Plan lines
----------

Plan lines must follow the format of "1..N" where N is the number of
subtests. The second line of KTAP output must be a plan line, which
indicates the number of tests at the highest level, such that the
tests do not have a parent. Also, in the instance of a test having
subtests, the second line of the test after the subtest header must be
a plan line which indicates the number of subtests within that test.

Test case result lines
----------------------

Test case result lines must have the format:

    <result> <number> [-] [<description>] [<directive>] [<diagnostic data>]

The result can be either "ok", which indicates the test case passed,
or "not ok", which indicates that the test case failed.

The number represents the number of the test case or suite being
performed. The first test case or suite must have the number 1 and the
number must increase by 1 for each additional test case or result at
the same level and within the same testing suite.

The "-" character is optional.

The description is a description of the test, generally the name of
the test, and can be any string of words (can't include #). The
description is optional.

The directive is used to indicate if a test was skipped. The format
for the directive is: "# SKIP [<skip_description>]". The
skip_description is optional and can be any string of words to
describe why the test was skipped. The result of the test case result
line can be either "ok" or "not ok" if the skip directive is used.
Finally, note that TAP 14 specification includes TODO directives but
these are not supported for KTAP.

Examples of test case result lines:

Test passed:

    ok 1 - test_case_name

Test was skipped:

    not ok 1 - test_case_name # SKIP test_case_name should be skipped

Test failed:

    not_ok 1 - test_case_name

Diagnostic lines
----------------

Diagnostic lines are used for description of testing operations.
Diagnostic lines are generally formatted as "#
<diagnostic_description>", where the description can be any string.
However, in practice, diagnostic lines are all lines that don't follow
the format of any other KTAP line format. Diagnostic lines can be
anywhere in the test output after the first two lines. There are a few
special diagnostic lines. Diagnostic lines of the format "# Subtest:
<test_name>" indicate the start of a test with subtests. Also,
diagnostic lines of the format "# <test_name>: <description>" refer to
a specific test and tend to occur before the test result line of that
test but are optional.

Bail out line
-------------

A bail out line can occur anywhere in the KTAP output and will
indicate that a test has crashed. The format of a bail out line is
"Bail out! [<description>]",  where the description can give
information on why the bail out occurred and can be any string.

Nested tests
------------

The new specification for KTAP will support an arbitrary number of
nested subtests. Thus, tests can now have subtests and those subtests
can have subtests. This can be useful to further categorize tests and
organize test results.

The new required format for a test with subtests consists of: a
subtest header line, a plan line, all subtests, and a final test
result line.

The first line of the test must be the subtest header line with the
format: "# Subtest: <test_name>".

The second line of the test must be the plan line, which is formatted
as "1..N", where N is the number of subtests.

Following the plan line, all lines pertaining to the subtests will follow.

Finally, the last line of the test is a final test result line with
the format: "(ok|not ok) <number> [-] [<description>] [<directive>]
[<diagnostic data>]", which follows the same format as the general
test result lines described in this section. The result line should
indicate the result of the subtests. Thus, if one of the subtests
fail, the test should fail. The description in the final test result
line should match the name of the test in the subtest header.

An example format:

KTAP version 1
1..1
    # Subtest: test_suite
    1..2
    ok 1 - test_1
    ok 2 - test_2
ok 1 - test_suite

An example format with multiple levels of nested testing:

KTAP version 1
1..1
    # Subtest: test_suite
    1..2
        # Subtest: sub_test_suite
        1..2
        ok 1 - test_1
        ok 2 test_2
    ok 1 - sub_test_suite
    ok 2 - test
ok 1 - test_suite

In the instance that the plan line is missing, the end of the test
will be denoted by the final result line containing a description that
matches the name of the test given in the subtest header. Note that
thus, if the plan line is missing and one of the subtests have a
matching name to the test suite this will cause errors.

Lastly, indentation is also recommended for improved readability.


Major differences between TAP 14 and KTAP specification
-------------------------------------------------------

Note that the major differences between TAP 14 and KTAP specification:
- yaml and json are not allowed in diagnostic messages
- TODO directive not allowed
- KTAP allows for an arbitrary number of tests to be nested with
specified nested test format

Example of KTAP
---------------

KTAP version 1
1..1
    # Subtest: test_suite
    1..1
        # Subtest: sub_test_suite
        1..2
        ok 1 - test_1
        ok 2 test_2
    ok 1 - sub_test_suite
ok 1 - test_suite

=========================================
Note on incompatibilities with kselftests
=========================================

To my knowledge, the above specification seems to generally accept the
TAP format of many non-nested test results of kselftests.

An example of a common kselftests TAP format for non-nested test
results that are accepted by the above specification:

TAP version 13
1..2
# selftests: vDSO: vdso_test_gettimeofday
# The time is 1628024856.096879
ok 1 selftests: vDSO: vdso_test_gettimeofday
# selftests: vDSO: vdso_test_getcpu
# Could not find __vdso_getcpu
ok 2 selftests: vDSO: vdso_test_getcpu # SKIP

However, one major difference noted with kselftests is the use of more
directives than the "# SKIP" directive. kselftest also supports XPASS
and XFAIL directives. Some additional examples found in kselftests:

    not ok 5 selftests: netfilter: nft_concat_range.sh # TIMEOUT 45 seconds

    not ok 45 selftests: kvm: kvm_binary_stats_test # exit=127

Should the specification be expanded to include these directives?

However, the general format for kselftests with nested test results
seems to differ from the above specification. It seems that a general
format for nested tests is as follows:

TAP version 13
1..2
# selftests: membarrier: membarrier_test_single_thread
# TAP version 13
# 1..2
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command = -1, flags = 0,
errno = 22. Failed as expected
ok 1 selftests: membarrier: membarrier_test_single_thread
# selftests: membarrier: membarrier_test_multi_thread
# TAP version 13
# 1..2
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command = -1, flags = 0,
errno = 22. Failed as expected
ok 2 selftests: membarrier: membarrier_test_multi_thread

The major differences here, that do not match the above specification,
are use of "# " as an indentation and using a TAP version line to
denote a new test with subtests rather than the subtest header line
described above. If these are widely utilized formats in kselftests,
should we include both versions in the specification or should we
attempt to agree on a single format for nested tests? I personally
believe we should try to agree on a single format for nested tests.
This would allow for a cleaner specification of KTAP and would reduce
possible confusion.

====

So what do people think about the above specification?
How should we handle the differences with kselftests?
If this specification is accepted, where should the specification be documented?
