Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077503FBF7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 01:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbhH3Xkf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Aug 2021 19:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhH3Xkf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Aug 2021 19:40:35 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D98CC061575
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 16:39:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g135so9858224wme.5
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pm6UA6GHOLycqzcfXybYqpBLPvUfJMLS2xahcfJrEIU=;
        b=t+Em1uWy3v7HlN3HDkk8kaRufYeqJio53TdPbFt0G3M7j1cE7+kGL5KftKQMp5pmMJ
         CVrS7h554TmeiLHcGNRLvzxdbRg0blwnZZlHbajz15I45AXnKZf8umpdpeudYJ06AmzC
         w1b58gb6i93Qx6cQRlwI18opg1CAgWiFuJD6smv+4zWAKO9U3JGx+RhVg/RScarmpD3C
         Opvqx1S4CNvjXVC0kvUE1n1WKLX7GB5Hl7Ze//9He7N2seTLoVRPMV4vv+1ueYQ1zLNY
         W776AOl15Rie8nYKCJOetWbuLVhHOBdXjYGRNTderpQBbMhODIQyqhxiCdFrzImBva2+
         TOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pm6UA6GHOLycqzcfXybYqpBLPvUfJMLS2xahcfJrEIU=;
        b=LiJWTLRPV2fXpU9rrQRU/amRjxf15RqJaIzj0tww30M4keX2Dp8DD0k5mbITmTuzku
         +MVXEPfK6hnAFzCqsuQsDznfd6ShyQilcX7oN8GwYPbhrwRoUqL6d6Kua1BruO6byCB1
         SYIgDRkApSvPNzbg7dIOQnvzDUsrv3HuZfsFxFtC4uPuDTTEEHcMN1TADZ3nlBLgO0dd
         tnLpw55SCsv7iQ/YWp+W3ZijVj9n5LcgjL0EYsxUXDUwJkokFI60YYYNkiQ01tILkFoC
         uAq3Kg4hIQP01742vCYmkwDbCqESynTGBoKqYsESRKsfcxY6GroM+BWZuUt2+7l/T1rh
         FyTw==
X-Gm-Message-State: AOAM530v7i1LHycFJhIh/gBLCmSFlRIXEzmxSPJgyXYmMhf9kHjb0gbO
        SAtptkOOINyIE2aA0EGrY1FenS2YlA6FDjvDzg45Ig==
X-Google-Smtp-Source: ABdhPJweWaYRdCtNt3P8BLBnmxC/U27ar8V1/jf6Nv3o0mRfemS2Rk2DRgNFHmpJo1VgBk+AZ1/Tvopyxv8+2XE7tGg=
X-Received: by 2002:a7b:cb02:: with SMTP id u2mr1265971wmj.103.1630366778688;
 Mon, 30 Aug 2021 16:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
 <202108272330.AE55FCD@keescook>
In-Reply-To: <202108272330.AE55FCD@keescook>
From:   David Gow <davidgow@google.com>
Date:   Tue, 31 Aug 2021 07:39:27 +0800
Message-ID: <CABVgOSkOu=h4pC60fn2FrwPd-XbdaDd=_3pV01rtO+bMrncgMQ@mail.gmail.com>
Subject: Re: RFC - kernel test result specification (KTAP)
To:     Kees Cook <keescook@chromium.org>
Cc:     Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Bird, Tim" <Tim.Bird@sony.com>, Shuah Khan <shuah@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 28, 2021 at 4:20 PM Kees Cook <keescook@chromium.org> wrote:
>
> [+kernelci, +Guillaume]
>
> Hi!
>
> Please keep me in CC for these kinds of proposals. And thanks for looking
> at this again! Please understand that while I may be coming across as
> rather negative here, I would like to have a rational and documented
> specification for the kernel's test output, too. My main objection here
> is that we already _have_ a specification, and it's already being parsed
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

Thanks a lot for doing this, by the way!

I think many of the issues here stem from the original TAP spec having
been insufficient for kernel stuff, and a bit of divergent evolution
having occurred between kselftest, KUnit, and the dormant TAP 14 spec.
This proposed spec does approach things more from the KUnit side, just
because that's what we're more familiar with, but I agree that
kselftest and LAVA are the bigger fish in this pond. KUnit's parser
has also been a bit stricter in what it accepts, and the TAP producing
code is shared between all of the KUnit tests, which makes prototyping
changes a bit easier.

Fortunately, most of these differences seem pretty minor in the grand
scheme of things, so I'm sure we can adapt this spec to fit what
kselftest is doing better, while still leaving enough of the structure
the KUnit tooling requires.

In any case, here are some of my initial thoughts:

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
>
> > - Diagnostic lines
>
> This is optional.
>
> > - A bail out line
>
> Bail out should be optional, and possibly not included at all. (See
> below.)
>

Yeah, I'd happily jettison this totally if no-one's using it.

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
>

I'd be okay with this. I personally think "KTAP" better describes how
much of a deviation this is turning out to be from the official TAP
specs, but if this fixes more parsers than it breaks, it's worth
doing.

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

I don't think there's fundamentally a distinction worth preserving
here. "Subtests" is the language used by the TAP 14 spec, but if we
want to reframe it as nested tests, that's not a problem (and I agree
'subtests' is a little misleading here).

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

For the record, KUnit's parser prints an error for each test with the
"wrong number", but still reports its result.

> >
> > The "-" character is optional.
> >
> > The description is a description of the test, generally the name of
> > the test, and can be any string of words (can't include #). The
> > description is optional.
>
> Yes, though the optional "- " is strictly part of the optional
> description.
>

I think the goal of specifying the "- " explicitly is that it's very
ugly to have test names/descriptions start with a "-" if one is used.

> > The directive is used to indicate if a test was skipped. The format
>
> The directive is a single word -- currently only "SKIP" is recognized
> by TAP 14(?), but kselftest uses also XFAIL, XPASS, TIMEOUT, and
> error. (Though I would love to hear what "error" is intended to be used
> for, if different from regular "not ok".)
>
> (This could also be called "context" rather than "directive".)
>

The name here matches the TAP spec, but I don't think we need to be
too beholden to it.

Personally, I think it'd make more sense to have SKIP, XFAIL, etc be
different statuses like "ok" and "not ok", rather than a directive
after the name, but that's possibly too radical a departure from TAP.

> > for the directive is: "# SKIP [<skip_description>]". The
> > skip_description is optional and can be any string of words to
> > describe why the test was skipped.
>
> I would call this "directive details".
>

Agreed.

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
>

I'm in two minds about this. On one hand, I totally agree that there's
a useful distinction here, and that a lot of dmesg output can get
nondeterministically mixed in. On the other, there are some tests for
which the dmesg output which gets mixed in is important output which
shouldn't be stripped out (for example, the KUnit KASAN tests print
KASAN reports, which we want to treat as "diagnostics" because they're
useful to understand what's happening in the tests.

That being said, there's nothing actually stopping us from maintaining
this distinction, and just having the KUnit parser treat "unknown"
lines the same as "diagnostic" lines, while maintaining the
distinction in theory.

> > Diagnostic lines can be
> > anywhere in the test output after the first two lines.
>
> I don't see a reason for this strictness. They can be anywhere.
>

I think this was just there because because we wanted to have room for
the TAP version header (or the 'Subtest' line in this spec/TAP14) and
the test plan, which needed to be the first two lines.

> > There are a few
> > special diagnostic lines.
>
> No; diagnostic lines must have no meaning: they are for humans and nothing
> else. If other details are needed for machines, we should explicitly
> create new format lines. I made a mistake when I used a diagnostic line
> for embedding the test names. :( There is a need for parsers to discover
> the name of a given test, though, so we do likely need something for this.
>

Yeah: the problem here is that we do have a pretty random mix of lines
starting with "#" which need parsing, and those which don't. Some of
this is inherited from the TAP or TAP14 spec. Using "# " for nesting
makes this a bit confusing as well.

Maybe this just needs reframing to something like "lines starting with
'#' which are not parseable as any of the following are diagnostic
lines", rather than the current implication that it's "anything that
starts with '#'".

Or we could try to clean up the mess and get rid of the leading '#'
everywhere else, but that's also a fair bit of work.

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

KUnit has just added a similar line, though it's optional, and is
mainly used as a way of providing sums of nested tests at different
levels:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=acd8e8407b8fcc3229d6d8558cac338bea801aed

It's currently optional, though, so we might want to change that if we
rely on it.

In general, though, I agree that "Bail out!" is pretty useless. I
suspect it's here mostly because "it was in the TAP spec" rather than
"it's something we actually want to use".

>
> Also, parsers should treat a new "TAP version..." line at the same
> nesting level as indication that the prior test has ended (and any tests
> without result lines should be considered failed).
>

I do like this idea as a way of making it possible to just cat test
results together and get a sensibly merged result.
I think we want to count any tests without result lines marked as
"error" (test execution didn't complete/crashed/etc), rather than
"failed", but that's just a detail.

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
>

This originally came from the draft TAP 14 spec here:
https://github.com/TestAnything/testanything.github.io/pull/36/files

On the KUnit side, we were labouring under the impression TAP 14 would
be ratified and implemented, so a lot of TAP 14 things ended up in our
implementation, including this line. Given that it stalled a long time
ago and no-one seems to care, I don't think that compatibility with it
needs to be an explicit goal any more, but it is still something that
KUnit uses at the moment.

The other thing worth noting is that, in KUnit, while nested test
support is limited, the framework does need to keep track of the
nesting depth in order to print the indentation.

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
>
> Whether this is "# " or "  " I don't really care, as long as the change
> is coordinated. "  " is easier for humans to read, but may make parsing of
> "unknown" lines more difficult for machines.
>

As one of the people who has an irrational distaste for syntactically
significant indentation, I'd prefer using something like the TAP
version header or the test plan as a way of indicating nesting. The
TAP 14 spec says that they should be indented four spaces, but "# " is
probably better, even if it doesn't gel perfectly with my mental model
of "#" lines not needing parsing (which went out the window ages ago).

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
>

I think this is actually supported in at least some versions of
TAP...? So maybe this isn't a difference at all.

> > - KTAP allows for an arbitrary number of tests to be nested with
> > specified nested test format
>
> Yup.
>

Again, I think this is actually a difference between TAP14/KTAP and
KUnit's current logic. TAP 14 does support nested tests using this
format, but KUnit only supported one level of nesting (Suite->Test).

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

Like with the "Subtests" line, this came from the draft TAP 14 spec, via KUnit.
Personally, I prefer the whitespace indent from a readability point of
view, and because it gels a bit better with my idea of what the "#"
was supposed to represent: a non-parseable additional diagnostic,
though that's not consistently been the case for ages, so I don't care
too much.

> > ====
> >
> > So what do people think about the above specification?
> > How should we handle the differences with kselftests?
>
> I'm probably a broken record by now, but kselftests _is_ the
> specification. ;) What about it needs changing, and why?
>

I think there's value in describing the spec more explicitly,
particularly since there's also the TAP spec, TAP 14 draft spec, and
KUnit's implementation, all of which are different in some ways. And
while a lot of the implicit spec can be gleaned from reading example
kselftest tests, that only tells you what is valid, not what isn't,
which makes writing parsers a bit trickier.

> > If this specification is accepted, where should the specification be documented?
>
> I imagine some .rst file under Documentation/dev-tools/, linked to from
> kselftest.rst and kunit/...rst
>
Agreed.
