Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6A63FBB02
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Aug 2021 19:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbhH3RfV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Aug 2021 13:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbhH3RfV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Aug 2021 13:35:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA3AC061575
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 10:34:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q3so8955661plx.4
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xn8V+mnvy6lnTbkvEpd8VlZtzt6ewtqUG/vAZnaH3/s=;
        b=Ir8Or0lSNjXkfhHRHLeNL5uWSK0s4DwomZwfrQqzudc/tsxlLwgLvo+tP/ajZrtHnw
         b8kn7Ov8eSogjwTVmRg8EEKWSR18N69/0eifAC1+lEk+Qx8oElMutFUc78xeCbj10Yi6
         VrEuiiY84ma6Y1APtiWv4kXh6FRb+r+gDD7h4K47HdMxdNpj/wRe+hQLACYee8LOzjiX
         DeqbYjf3ZPJq0sEkk/P9mviQgENFAJOBkuh/xRXWOfvZgrAJkLk+YkDzpFayI02dIcTu
         0VXnampGra6xfzRyeoiSS793oQjw9au5H2X6zJXtRJ0fCy0WJQZKs0ov5bkzwUpHp2pE
         CMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xn8V+mnvy6lnTbkvEpd8VlZtzt6ewtqUG/vAZnaH3/s=;
        b=BtRnACMzbVXnZ05RDywQx62Mys+MRihh+cipP8xWfVZUQWiUg6KURg8LTxSrn4vRda
         k/PhPbYHI9r51JuMKTDHFTZRJ++euDScXhujT2Xw6h+iAe6x48gm75CW5md+SwIiLzQ7
         IVnItxtDSEa6i5AQxyiZS5Lovr4W7G2DFcDI0OXUrm2ZQhE8JCQ4P9xEZegAIVv4vZuA
         aJHh/mRNCxxKBeogiMXZCm7Fjyr3idPhx+VTWNxYNlmfJpKX0kPTsv4ARw/5HB2kshda
         iBeIsc8a4JkbfLDDI7FAGC902p4e56bMADbaBQ7plCU7L/crd7CXARqOFqIXtRfC6cQf
         BPBQ==
X-Gm-Message-State: AOAM533zw7xhOgtnSDfSfG1jS31EjlrP5KGfKy2kC9XvgmeuZz2vIjPJ
        UzKSHPhWJla98WXlLUXUJAgwYb1e7R5qIyaoORFPZw==
X-Google-Smtp-Source: ABdhPJzi8MKIrCjUHTLPx7PTSm5mry11Bl82MHryIpPVeMOv7uAzh5kAv5sOVAl8gq8vIx1BuBLZy0TlDW8maTiqylY=
X-Received: by 2002:a17:90a:1904:: with SMTP id 4mr171261pjg.217.1630344866303;
 Mon, 30 Aug 2021 10:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
 <202108272330.AE55FCD@keescook>
In-Reply-To: <202108272330.AE55FCD@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 30 Aug 2021 10:34:14 -0700
Message-ID: <CAFd5g46etU+AZxUrRxkwb8eiauG2BxTrLSHByOv195A+Afr1iQ@mail.gmail.com>
Subject: Re: RFC - kernel test result specification (KTAP)
To:     Kees Cook <keescook@chromium.org>
Cc:     Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
        Tim.Bird@sony.com, Shuah Khan <shuah@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 28, 2021 at 1:20 AM Kees Cook <keescook@chromium.org> wrote:
>
> [+kernelci, +Guillaume]
>
> Hi!
>
> Please keep me in CC for these kinds of proposals. And thanks for looking

Oh sorry, we will make sure to do that in the future. I figured most
people who were interested who weren't directly CC'ed were on the
kselftest list.

> at this again! Please understand that while I may be coming across as
> rather negative here, I would like to have a rational and documented
> specification for the kernel's test output, too. My main objection here
> is that we already _have_ a specification, and it's already being parsed

We do?! Where is it? Can you link it here?

> by machines, so making changes without strong justification is going to
> be met with resistance. :) So, with that in mind, on to my reply...

Of course, but if there is no specification or it is not being
universally followed, then changes will need to be made, no?

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

Of course, that's why we sent it to the kselftest list. In terms of
LAVA as the biggest consumer, thank you for CCing them. My apologies
for failing to do so.

> The fundamental purpose of the kernel's TAP is to have many independent
> tests runnable and parseable, specifically without any embedded framework
> knowledge (or, even, any knowledge of TAP).
>
> The tests run by kselftest come from 2 different TAP-producing harnesses
> (kselftest.h for C, kselftest/runner.sh for TAP-agnostic tests) as well
> as several hand-rolled instances in Shell, Python, and C. There used to
> be more, but I have been steadily fixing their syntax[2] and merging[3]
> separate implementations for a while now.

Yep! And I believe there are still some inconsistencies - hence part
of the motivation.

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

Yep, and if I recall correctly, there was no resolution to that
thread, so we are trying to pick that conversation back up here.

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

"TAP version Linux.1" would not break existing parsers? If so, that
would be great, I just expect that it would break them too.

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

Why not? I got the impression on the previous thread that everyone was
amenable to this?

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

I think that is probably fine, but I think Rae would probably have a
better idea.

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

Right.

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
> > The directive is used to indicate if a test was skipped. The format
>
> The directive is a single word -- currently only "SKIP" is recognized
> by TAP 14(?), but kselftest uses also XFAIL, XPASS, TIMEOUT, and
> error. (Though I would love to hear what "error" is intended to be used
> for, if different from regular "not ok".)

Can you explain (or link to documentation) on what these other directives mean?

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

Oh yeah, I think that was a typo.

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

Interesting. I think David probably would have some thoughts here.

> > Diagnostic lines can be
> > anywhere in the test output after the first two lines.
>
> I don't see a reason for this strictness. They can be anywhere.
>
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

Cool, any ideas on what we should do then? I personally don't have
strong feelings on it.

> Also, parsers should treat a new "TAP version..." line at the same
> nesting level as indication that the prior test has ended (and any tests
> without result lines should be considered failed).

OK, that is definitely different. I think this will require some
further discussion.

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

Well it doesn't have to, right? The parent test can include the
directive. In anycase, something has to know enough to print a test
plan.

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

What spec? I didn't see a final spec come from the previous discussion.

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

KUnit cannot support indentation being required. We print test results
to dmesg. At anytime something could get printed to dmesg that could
potentially mess up indentation.

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

Wait, what?! An implementation is not a specification. I thought Tim's
attempt at standardizing the TAP that exists under kselftest, KUnit,
and elsewhere was recognized as important or at least worthwhile.

The problem that was recognized, as I understand, was that there are
multiple "interpretations" of TAP floating around the kernel and that
goes against the original point of trying to standardize around TAP.

I know KUnit's usage is pretty minor in comparison to kselftest, but
people do use it and there is no point in us, KUnit, purporting to use
TAP and remain compatible with any particular version of it if it is
incompatible with kselftest's TAP.

Additionally, there is no way that we are going to be able to stay on
a compatible implementation of TAP unless we specify what TAP is
separate from the implementation.

Maybe there is something I am missing here. If so, please explain.

> > If this specification is accepted, where should the specification be documented?
>
> I imagine some .rst file under Documentation/dev-tools/, linked to from
> kselftest.rst and kunit/...rst
>
> --
> Kees Cook
