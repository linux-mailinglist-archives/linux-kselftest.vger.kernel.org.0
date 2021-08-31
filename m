Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C416C3FC0C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 04:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbhHaCQK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Aug 2021 22:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbhHaCQI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Aug 2021 22:16:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C179C06175F
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 19:15:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lc21so35280618ejc.7
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+eoxevLynvAqMQTJnSHjcI7b5GAVpIEQJl/6AQ4odJw=;
        b=AY5c/hcZlOyIi9ELJnU0RSYz9WuGcrZJUFyZeMNQ3waeAEP2ycoBRVdIP+k/Kuz1vH
         bDN5zVpGJ7wr1Yk4lsmQQy5xjPqsUhwQkxn1JRJvMa1S1MeWfW4mpYQHs4TOQw1/FypF
         mAM9Pb8kNwIia86gfhE7nM6zlSZZx50SKsk06KTIE8KPMubucLwleQCZIM0LxvEg6gTY
         RfSYbpPQGFx3uHGsPGN4grB9HJJu4zIj2qGEJ6FlffxxY2smJTKLZWQUaBs4yPWfoBf0
         h3TFLdtlZJYlwIW4DuvYb0tCGhf0dl/+6p/fRKAiMVKUjCUOOn+lDNUimNDdUWkI3eVh
         zVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eoxevLynvAqMQTJnSHjcI7b5GAVpIEQJl/6AQ4odJw=;
        b=EDjWa+gs9xzNJH4SUnrPs1w9iKV3sSm8rihEtWdj9hvv7OrFj8cco7KVf6BBdPgdR3
         rinSWa2YqaBBKqvVOsERVkwFKsIRQ1DYTFmYLNqYdImiZZ+gFA2iydEQ8sTqJkXxu4gX
         PXFs0nsAWUb7jAi6Uilz5HX/Wis6/IFMLRX2Jk7KoorRwQ50MN5IFcDSmcxMJrwJ1muj
         hLljmVbG4XYFUjSM7+ksw0SpnYSG5wPuBPXS9y3Qc41eZYHPrAwiWJLMBTeGQn/Edb//
         wOzG8007DyVFzqb19NX2w8f1RHLD7NeJo2KuHGf0OcUv2alzciQVYy1iY/ldlzueddv0
         3V/w==
X-Gm-Message-State: AOAM532POeAJXBQTb0wTWCvO7DsgFiBkcNIj2xtOuRYaNotvMMOa6KKN
        yHnwAYqhpGMvRj6+7ziCH/ewIZ2zOnV6Atl7jb577w==
X-Google-Smtp-Source: ABdhPJw2xlLws1Ij4fOMzEgIq4PlYDCYVniaH802w2D9yaGOtPZn1XeMZMPEL6gQv12XgU+01BZSFzdOWFbeQAIKz5c=
X-Received: by 2002:a17:907:3393:: with SMTP id zj19mr27465430ejb.535.1630376111593;
 Mon, 30 Aug 2021 19:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
 <202108272330.AE55FCD@keescook>
In-Reply-To: <202108272330.AE55FCD@keescook>
From:   Rae Moar <rmoar@google.com>
Date:   Mon, 30 Aug 2021 22:14:59 -0400
Message-ID: <CA+GJov5cjPapO8fek=hpZR4fTq2pmBRrEpvS-i9hPFOdLwsAWw@mail.gmail.com>
Subject: Re: RFC - kernel test result specification (KTAP)
To:     Kees Cook <keescook@chromium.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Tim.Bird@sony.com,
        Shuah Khan <shuah@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello everyone! Thank you for all of your comments! I am glad to see some
discussion on this email. First of all, my primary goal with this email is to
advocate for a documented specification for the kernel's test output.  I
presented my first email largely from the perspective of KUnit and thus, I
am not surprised there are points of contention in the proposed specification.
That being said my comments are as follows:

On Sat, Aug 28, 2021 at 4:20 AM Kees Cook <keescook@chromium.org> wrote:
>
> [+kernelci, +Guillaume]
>
> Hi!
>
> Please keep me in CC for these kinds of proposals.

Very sorry for not including you as a CC. I will be sure to do this in the
future.

> And thanks for looking
> at this again! Please understand that while I may be coming across as
> rather negative here, I would like to have a rational and documented
> specification for the kernel's test output, too. My main objection here
> is that we already _have_ a specification,

I totally agree that the documented specification should generally follow
the agreed upon formats for kernel test results. However, there seems to be
some prominent differences in the formats of test results between KUnit and
kselftests, as well as within kselftests (requiring test plan line, use of
different directives). So I am primarily advocating for the specification to be
agreed upon and documented.

> and it's already being parsed
> by machines, so making changes without strong justification is going to
> be met with resistance. :) So, with that in mind, on to my reply...
>
> On Tue, Aug 10, 2021 at 04:25:03PM -0700, Rae Moar wrote:
> > We are looking to further standardise the output format used by kernel
> > test frameworks like kselftest and KUnit. Thus far we have used the
> > TAP (Test Anything Protocol) specification, but it has been extended
> > in many different ways, so we would like to agree on a common "Kernel
> > TAP" (KTAP) format to resolve these differences. Thus, below is a
> > draft of a specification of KTAP. Note that this specification is
> > largely based on the current format of test results for KUnit tests.
>
> The kernel's largest producer of TAP is kselftest, and the largest
> consumer is LAVA[1]. I would want buy-in from at least those responsible
> for either side of those two things. (And I'm one of the people working
> on both sides of it.)
>
> The fundamental purpose of the kernel's TAP is to have many independent
> tests runnable and parseable, specifically without any embedded framework
> knowledge (or, even, any knowledge of TAP).
>
> The tests run by kselftest come from 2 different TAP-producing harnesses
> (kselftest.h for C, kselftest/runner.sh for TAP-agnostic tests) as well
> as several hand-rolled instances in Shell, Python, and C. There used to
> be more, but I have been steadily fixing their syntax[2] and merging[3]
> separate implementations for a while now.
>
> [1] https://github.com/Linaro/test-definitions/commit/8bd338bbcfa5a03efcf1d12e25b5d341d5a29cbc
> [2] https://git.kernel.org/linus/b0df366bbd701c45e93af0dcb87ce22398589d1d
> [3] https://git.kernel.org/linus/e80068be21824e4d2726eeea41cac6178d212415
>
> > Additionally, this specification was heavily inspired by the KTAP
> > specification draft by Tim Bird
> > (https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/).
> > However, there are some notable differences to his specification. One
> > such difference is the format of nested tests is more fully specified
> > in the following specification. However, they are specified in a way
> > which may not be compatible with many kselftest nested tests.
>
> I commented extensively on that thread. :)
>
> >
> > =====================
> > Specification of KTAP
> > =====================
> >
> > TAP, or the Test Anything Protocol is a format for specifying test
> > results used by a number of projects. It's website and specification
> > are found at: https://testanything.org/. The Linux Kernel uses TAP
> > output for test results. However, KUnit (and other Kernel testing
> > frameworks such as kselftest) have some special needs for test results
> > which don't gel perfectly with the original TAP specification. Thus, a
> > "Kernel TAP" (KTAP) format is specified to extend and alter TAP to
> > support these use-cases.
> >
> > KTAP Output consists of 5 major elements (all line-based):
> > - The version line
> > - Plan lines
> > - Test case result lines
>
> These are required.

Agreed.

>
> > - Diagnostic lines
>
> This is optional.

Agreed.

>
> > - A bail out line
>
> Bail out should be optional, and possibly not included at all. (See
> below.)

I am fine with the Bail out line being removed if it is not in use.

>
> >
> > An important component in this specification of KTAP is the
> > specification of the format of nested tests. This can be found in the
> > section on nested tests below.
> >
> > The version line
> > ----------------
> >
> > The first line of KTAP output must be the version line. As this
> > specification documents the first version of KTAP,  the recommended
> > version line is "KTAP version 1". However, since all kernel testing
> > frameworks use TAP version lines, "TAP version 14" and "TAP version
> > 13" are all acceptable version lines. Version lines with other
> > versions of TAP or KTAP will not cause the parsing of the test results
> > to fail but it will produce an error.
>
> Maybe "TAP version Linux.1" ? I don't want to needlessly break existing
> parsers.

I think it would be best to maintain a numerical version number. So I
would prefer to either maintain 'TAP version #' or 'KTAP version 1', to
indicate the test results follow the newly specified KTAP. However, I
am flexible on this.

>
> >
> > Plan lines
> > ----------
> >
> > Plan lines must follow the format of "1..N" where N is the number of
> > subtests. The second line of KTAP output must be a plan line, which
> > indicates the number of tests at the highest level, such that the
> > tests do not have a parent. Also, in the instance of a test having
> > subtests, the second line of the test after the subtest header must be
> > a plan line which indicates the number of subtests within that test.
>
> I do not want "subtests" as a specification concept, only "nested
> tests".
>

I am fine changing this concept. It might be slightly clearer.

> >
> > Test case result lines
> > ----------------------
> >
> > Test case result lines must have the format:
> >
> >     <result> <number> [-] [<description>] [<directive>] [<diagnostic data>]
>
> "[<diagnostic data>]" is not defined below. I think what you mean is
> "directive details".

I should have defined the [<diagnostic data>] more fully. My intention was
that the diagnostic data would accommodate including information in the
test result that is not a directive or the description of the test. For example,
this would accommodate the examples that Tim Bird mentioned:
ok 5 - check return code # rcode=0

Note that both the directive and diagnostic data would be after a # symbol.
So the more exact format I was intending would be as follows:

<result> <number> [-] [<description>] [# [<directive>][<diagnostic data>]]

>
> I suggest:
>
> <result> <number>[ [- ]<description>][# <directive> [<directive details>]]
>
> > The result can be either "ok", which indicates the test case passed,
> > or "not ok", which indicates that the test case failed.
>
> Yes.
>
> >
> > The number represents the number of the test case or suite being
> > performed. The first test case or suite must have the number 1 and the
> > number must increase by 1 for each additional test case or result at
> > the same level and within the same testing suite.
>
> Yes, though parsers should handle ordering failures and missed test
> results (this is the purpose of the "plan" line).
>
> >
> > The "-" character is optional.
> >
> > The description is a description of the test, generally the name of
> > the test, and can be any string of words (can't include #). The
> > description is optional.
>
> Yes, though the optional "- " is strictly part of the optional
> description.

Does this mean you would want the "-" parsed as part of
the description? I think having "-" at the beginning of test descriptions
might be confusing.

Additionally, I am flexible on whether the "-" is necessary. I personally
think it looks a bit better with the "-" but that is preference.

>
> > The directive is used to indicate if a test was skipped. The format
>
> The directive is a single word -- currently only "SKIP" is recognized
> by TAP 14(?), but kselftest uses also XFAIL, XPASS, TIMEOUT, and
> error. (Though I would love to hear what "error" is intended to be used
> for, if different from regular "not ok".)
>
> (This could also be called "context" rather than "directive".)
>
> > for the directive is: "# SKIP [<skip_description>]". The
> > skip_description is optional and can be any string of words to
> > describe why the test was skipped.
>
> I would call this "directive details".
>
> > The result of the test case result
> > line can be either "ok" or "not ok" if the skip directive is used.
> > Finally, note that TAP 14 specification includes TODO directives but
> > these are not supported for KTAP.
> >
> > Examples of test case result lines:
> >
> > Test passed:
> >
> >     ok 1 - test_case_name
> >
> > Test was skipped:
> >
> >     not ok 1 - test_case_name # SKIP test_case_name should be skipped
> >
> > Test failed:
> >
> >     not_ok 1 - test_case_name
>
> This isn't valid. No "_" is recognized for "ok" vs "not ok".

Oops. My typo here. I meant:
not ok 1 - test_case_name

>
> >
> > Diagnostic lines
> > ----------------
> >
> > Diagnostic lines are used for description of testing operations.
> > Diagnostic lines are generally formatted as "#
> > <diagnostic_description>", where the description can be any string.
> > However, in practice, diagnostic lines are all lines that don't follow
> > the format of any other KTAP line format.
>
> I still think there should be a distinction between "diagnostic lines"
> and "unknown lines". For example, if kselftest is running on a console,
> the dmesg output may be intermixed, and possibly temporally offset. Such
> lines may not be useful, and may not be strictly correlated, where-as
> the output from kselftest is at least self-consistent.

I would be fine with maintaining that distinction.

>
> > Diagnostic lines can be
> > anywhere in the test output after the first two lines.
>
> I don't see a reason for this strictness. They can be anywhere.
>

This was an attempt to ensure that the first two lines of the KTAP
results are the
version line and the test plan. However, looking back on this, it was a bit too
strict.

> > There are a few
> > special diagnostic lines.
>
> No; diagnostic lines must have no meaning: they are for humans and nothing
> else. If other details are needed for machines, we should explicitly
> create new format lines. I made a mistake when I used a diagnostic line
> for embedding the test names. :( There is a need for parsers to discover
> the name of a given test, though, so we do likely need something for this.
>
> > Diagnostic lines of the format "# Subtest:
> > <test_name>" indicate the start of a test with subtests. Also,
> > diagnostic lines of the format "# <test_name>: <description>" refer to
> > a specific test and tend to occur before the test result line of that
> > test but are optional.
>
> I don't think the above should be included in the spec -- diag lines
> should have no parseable meaning.
>
> >
> > Bail out line
> > -------------
> >
> > A bail out line can occur anywhere in the KTAP output and will
> > indicate that a test has crashed. The format of a bail out line is
> > "Bail out! [<description>]",  where the description can give
> > information on why the bail out occurred and can be any string.
>
> I'm not a fan of the Bail out line. It's not a problem, exactly, but I
> find it redundant. If we want an "end of test" line, let's make one.
> "Bail out" is a special case of exit. If we want to handle test exit,
> let's define it. E.g. make kselftest's test summary lines not
> diagnostic lines:
>
> # FAILED: 85 / 87 tests passed.
> # Totals: pass:83 fail:2 xfail:0 xpass:0 skip:2 error:0
>
> Also, parsers should treat a new "TAP version..." line at the same
> nesting level as indication that the prior test has ended (and any tests
> without result lines should be considered failed).
>
> >
> > Nested tests
> > ------------
> >
> > The new specification for KTAP will support an arbitrary number of
> > nested subtests. Thus, tests can now have subtests and those subtests
> > can have subtests. This can be useful to further categorize tests and
> > organize test results.
> >
> > The new required format for a test with subtests consists of: a
> > subtest header line, a plan line, all subtests, and a final test
> > result line.
> >
> > The first line of the test must be the subtest header line with the
> > format: "# Subtest: <test_name>".
>
> Please no. There is no reason to force a nested test to suddenly have
> to know about its test execution depth/environment. A subtest is just a
> nested TAP result. That it is nested is only meaningful to the parser, not
> the executing test, and it must have the same output, nested or not. (e.g.
> running the test alone or running the test under a full kselftest run,
> the only difference is the indentation level.)

To clarify if this was implemented in kselftests, I believe the parent test
would print this subtest header. So the executing test would not have
this knowledge about the execution depth and thus, if the test was not
nested, it would not print this subtest header. This is my understanding.

Additionally, this is the current format for nested tests for KUnit.
As David mentioned, KUnit adopted this format from the proposed
TAP 14 draft spec
(https://github.com/TestAnything/testanything.github.io/pull/36/files).
Currently KUnit relies on this Subtest header line to parse nested tests.
I hope this is taken into account with discussions.

However, I hope we can decide on a singular format for these nested
tests. I am flexible with this specification. I would be fine with including
the nested version lines.

>
> > The second line of the test must be the plan line, which is formatted
> > as "1..N", where N is the number of subtests.
> >
> > Following the plan line, all lines pertaining to the subtests will follow.
> >
> > Finally, the last line of the test is a final test result line with
> > the format: "(ok|not ok) <number> [-] [<description>] [<directive>]
> > [<diagnostic data>]", which follows the same format as the general
> > test result lines described in this section. The result line should
> > indicate the result of the subtests. Thus, if one of the subtests
> > fail, the test should fail. The description in the final test result
> > line should match the name of the test in the subtest header.
> >
> > An example format:
> >
> > KTAP version 1
> > 1..1
> >     # Subtest: test_suite
> >     1..2
> >     ok 1 - test_1
> >     ok 2 - test_2
> > ok 1 - test_suite
>
> Again, I see only downsides to this. Nesting for the spec is simple
> indentation-based recursion. Let's just keep what we already have:
>
> TAP version 13
> 1..1
> # TAP version 13
> # 1..2
> # ok 1 - test_1
> # ok 2 - test_2
> ok 1 - test_suite
>
>
> > An example format with multiple levels of nested testing:
> >
> > KTAP version 1
> > 1..1
> >     # Subtest: test_suite
> >     1..2
> >         # Subtest: sub_test_suite
> >         1..2
> >         ok 1 - test_1
> >         ok 2 test_2
> >     ok 1 - sub_test_suite
> >     ok 2 - test
> > ok 1 - test_suite
> >
> > In the instance that the plan line is missing, the end of the test
> > will be denoted by the final result line containing a description that
> > matches the name of the test given in the subtest header. Note that
> > thus, if the plan line is missing and one of the subtests have a
> > matching name to the test suite this will cause errors.
>
> A plan line is required. No special cases are needed. :)
>

I am good with this. This was an attempt to be flexible because
it does seem there are tests that leave out the test plan or
place the test plan at the end of the test.

> If nesting level is lost, a parser will understand the nested test to
> have ended, but probably so did the test runner:
>
> TAP version 13
> 1..1
>     TAP version 13
>     1..2
>         TAP version 13
>         1..3
>         ok 1 - test_1
>         ok 2 test_2
>     not ok 1 - sub test unfinished plan
>     ok 2 - test
> not ok 1 - test_suite
>
> > Lastly, indentation is also recommended for improved readability.
>
> Indentation is _required_. :)

I think this could be a little strict to require indentation. For example,
in the instance of a nested test with a prefix, there could be difficulties
with correctly parsing the indentation level:

TAP version 13
1..1
[batch_id 4] TAP version 13
[batch_id 4] 1..2
[batch_id 4] ok 1 - cyclictest with 1000 cycles
[batch_id 4] # problem setting CLOCK_REALTIME
[batch_id 4] not ok 2 - cyclictest with CLOCK_REALTIME
not ok 1 - check realtime

(using a truncated version of an example Tim Bird used - note
he used it for a different point)

This could mostly be corrected with the use of "# " as the indentation. But
I personally prefer "  " as an indentation because the use of "# " can be
confusing with the format of diagnostic lines also starting with "# ". Thus,
I think it is safer to use the version lines or a subtest header lines to parse
nested tests.

>
> Whether this is "# " or "  " I don't really care, as long as the change
> is coordinated. "  " is easier for humans to read, but may make parsing of
> "unknown" lines more difficult for machines.
>
> >
> > Major differences between TAP 14 and KTAP specification
> > -------------------------------------------------------
> >
> > Note that the major differences between TAP 14 and KTAP specification:
> > - yaml and json are not allowed in diagnostic messages
>
> Agreed -- these are overkill (and very difficult to implement as they
> _follow_ the test result line: anything generating them has already
> finished running).
>
> > - TODO directive not allowed
>
> I would just say "unrecognized".

I am good with this change.

>
> > - KTAP allows for an arbitrary number of tests to be nested with
> > specified nested test format
>
> Yup.
>
> >
> > Example of KTAP
> > ---------------
> >
> > KTAP version 1
> > 1..1
> >     # Subtest: test_suite
> >     1..1
> >         # Subtest: sub_test_suite
> >         1..2
> >         ok 1 - test_1
> >         ok 2 test_2
> >     ok 1 - sub_test_suite
> > ok 1 - test_suite
>
> For a good example, please include all the possible combinations (SKIP,
> not ok, diagnostics, etc etc)
>
> >
> > =========================================
> > Note on incompatibilities with kselftests
> > =========================================
> >
> > To my knowledge, the above specification seems to generally accept the
> > TAP format of many non-nested test results of kselftests.
> >
> > An example of a common kselftests TAP format for non-nested test
> > results that are accepted by the above specification:
> >
> > TAP version 13
> > 1..2
> > # selftests: vDSO: vdso_test_gettimeofday
> > # The time is 1628024856.096879
> > ok 1 selftests: vDSO: vdso_test_gettimeofday
> > # selftests: vDSO: vdso_test_getcpu
> > # Could not find __vdso_getcpu
> > ok 2 selftests: vDSO: vdso_test_getcpu # SKIP
> >
> > However, one major difference noted with kselftests is the use of more
> > directives than the "# SKIP" directive. kselftest also supports XPASS
> > and XFAIL directives. Some additional examples found in kselftests:
> >
> >     not ok 5 selftests: netfilter: nft_concat_range.sh # TIMEOUT 45 seconds
> >
> >     not ok 45 selftests: kvm: kvm_binary_stats_test # exit=127
> >
> > Should the specification be expanded to include these directives?
>
> Yes. (Though "exit=" is a mistake in runner.sh -- this should probably
> be reported without the '#')
>

Sounds good. Are there specific directives that should or should not
be included?

> >
> > However, the general format for kselftests with nested test results
> > seems to differ from the above specification. It seems that a general
> > format for nested tests is as follows:
> >
> > TAP version 13
> > 1..2
> > # selftests: membarrier: membarrier_test_single_thread
> > # TAP version 13
> > # 1..2
> > # ok 1 sys_membarrier available
> > # ok 2 sys membarrier invalid command test: command = -1, flags = 0,
> > errno = 22. Failed as expected
> > ok 1 selftests: membarrier: membarrier_test_single_thread
> > # selftests: membarrier: membarrier_test_multi_thread
> > # TAP version 13
> > # 1..2
> > # ok 1 sys_membarrier available
> > # ok 2 sys membarrier invalid command test: command = -1, flags = 0,
> > errno = 22. Failed as expected
> > ok 2 selftests: membarrier: membarrier_test_multi_thread
> >
> > The major differences here, that do not match the above specification,
> > are use of "# " as an indentation and using a TAP version line to
> > denote a new test with subtests rather than the subtest header line
> > described above. If these are widely utilized formats in kselftests,
> > should we include both versions in the specification or should we
> > attempt to agree on a single format for nested tests? I personally
> > believe we should try to agree on a single format for nested tests.
> > This would allow for a cleaner specification of KTAP and would reduce
> > possible confusion.
>
> We already use "# " and the nested TAP lines to denote subtests. Without
> a good reason to change it, we should avoid the churn with the existing
> parsers.
>
> > ====
> >
> > So what do people think about the above specification?
> > How should we handle the differences with kselftests?
>
> I'm probably a broken record by now, but kselftests _is_ the
> specification. ;) What about it needs changing, and why?

I think the change that needs to happen is that the specification is
documented so it is accessible to everyone. Otherwise I hope this
proposed specification helps to incite needed discussion so we
hopefully can create this accepted specification. Again thank you
to everyone for their comments.

>
> > If this specification is accepted, where should the specification be documented?
>
> I imagine some .rst file under Documentation/dev-tools/, linked to from
> kselftest.rst and kunit/...rst
>
> --
> Kees Cook
