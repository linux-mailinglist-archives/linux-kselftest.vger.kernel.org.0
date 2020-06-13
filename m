Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3A21F810D
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jun 2020 07:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgFMFH3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Jun 2020 01:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgFMFH2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Jun 2020 01:07:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5575C08C5C1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 22:07:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r15so9797383wmh.5
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 22:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZedxNbSR5Y6VCQFoU4t/WUj3cun+Lor1CUMdsSMaZs=;
        b=Chn2MsdPxPFoQe+xVK24PTksspNNpO8iIfWYSZ3H6hBeOAFBoT96xkxhH2ML+UQQAk
         R0cTK+X+mKd7TKDdi5wYmzqDyMK4zgUJvqs3ZNdJBbiZVcqUl7XXj2xxPjKzckxPmSAu
         7OTTpTiatHoW7HSZy/APK9frF9qIziqL57lVhkoEbVWEj+LWGn2HMlv8+WSLhxjNj3XC
         9NnPRgjM0Z5I4Uf8m0JkFw149NAveMUNQGopbNHu9haI+oBeSr3pW/ElsQvFt0JnKHbq
         pzXK1IOmOB7MS/HE2N/R87vXAi8O3I4LWGJNE1ndyTx7t4rKcqx3q8SuYZunIofS0yCJ
         MuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZedxNbSR5Y6VCQFoU4t/WUj3cun+Lor1CUMdsSMaZs=;
        b=Y83v0qXqgWuEjXVdtWpcTMMYE0Uh19HmH3U8q3/lDG77J7vaO1cnkB4leCmUBI4tFS
         TjGxOkJWmU3L2cCW0hAyDITGQWmvVJqp6yXerOycgqTsar5YOReqacqwfyiIT2XeRvk6
         K8vLMnvxGRaX5RCTpjn/tKeZRRbtiircm60RwPdo+n988lv9ScGotHEaok8EObGnWEaF
         UP022IGz1uxUZz4PNSZHFfEyJ8BfQoEyB0qIA1ets9yJPaCNjouUUBqE4zwHOrIhx8U6
         RIRVT6YHEDKhctjV2b4uHRZwpI+vTDXlZpinYO3PYx/MHZZxCFYUq1QzGGas4JeM6m7j
         Ipog==
X-Gm-Message-State: AOAM530UhRrwG2vkJkzrLTZBRNiHM4eq8RTAl9wh0PydYiLd18+hofi5
        pDkf1BwfiCcK9NsPXzkUPHVOJW4jeGO5e0XE9TWfgDz3jcYW/A==
X-Google-Smtp-Source: ABdhPJyHy226Pv9kgYPx9qtbckz6fLn1TG6uAzEeWT+pMDYxzH6S/6xCEGmX6/UUBoYt8p1UNeQyXhNvKN4/ZjAq9lQ=
X-Received: by 2002:a1c:a444:: with SMTP id n65mr2086921wme.99.1592024843427;
 Fri, 12 Jun 2020 22:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
In-Reply-To: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 13 Jun 2020 13:07:11 +0800
Message-ID: <CABVgOSkrKHs_uWLZ++_fBC_mfe3RgDxmCvnkcyn1P_wjXTV9Og@mail.gmail.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 11, 2020 at 2:11 AM Bird, Tim <Tim.Bird@sony.com> wrote:
>
> Some months ago I started work on a document to formalize how
> kselftest implements the TAP specification.  However, I didn't finish
> that work.  Maybe it's time to do so now.
>
> kselftest has developed a few differences from the original
> TAP specification, and  some extensions that I believe are worth
> documenting.
>
> Essentially, we have created our own KTAP (kernel TAP)
> format.  I think it is worth documenting our conventions, in order to
> keep everyone on the same page.
>
> Below is a partially completed document on my understanding
> of KTAP, based on examination of some of the kselftest test
> output.  I have not reconciled this with the kunit output format,
> which I believe has some differences (which maybe we should
> resolve before we get too far into this).

Thanks for doing this! This is something we've wanted to have for a while!

On the KUnit side of things, we've not (intentionally) deviated too
much from TAP/kselftest
It's certainly our intention to hew as close as possible to what
kselftest is doing: I don't think there are any real conflicts
conceptually (at least at the moment), but we're almost certainly
handling a few details differently.

One other thing worth noting is that KUnit has a parser for our TAP
results: './tools/testing/kunit/kunit.py parse' will do some basic
parsing and print out results, a summary, etc.

A few other comments below:

> I submit the document now, before it is finished, because a patch
> was recently introduced to alter one of the result conventions
> (from SKIP='not ok' to SKIP='ok').
>
> See the document include inline below
>
> ====== start of ktap-doc-rfc.txt ======
> Selftest preferred output format
> --------------------------------
>
> The linux kernel selftest system uses TAP (Test Anything Protocol)
> output to make testing results consumable by automated systems.  A
> number of Continuous Integration (CI) systems test the kernel every
> day.  It is useful for these systems that output from selftest
> programs be consistent and machine-parsable.
>
> At the same time, it is useful for test results to be human-readable
> as well.
>
> The kernel test result format is based on a variation TAP
> TAP is a simple text-based format that is
> documented on the TAP home page (http://testanything.org/).  There
> is an official TAP13 specification here:
> http://testanything.org/tap-version-13-specification.html
>
> The kernel test result format consists of 5 major elements,
> 4 of which are line-based:
>  * the output version line
>  * the plan line
>  * one or more test result lines (also called test result lines)
>  * a possible "Bail out!" line
>
> optional elements:
>  * diagnostic data
>
> The 5th element is diagnostic information, which is used to describe
> items running in the test, and possibly to explain test results.
> A sample test result is show below:
>
> Some other lines may be placed the test harness, and are not emitted
> by individual test programs:
>  * one or more test identification lines
>  * a possible results summary line
>
> Here is an example:
>
>         TAP version 13
>         1..1
>         # selftests: cpufreq: main.sh
>         # pid 8101's current affinity mask: fff
>         # pid 8101's new affinity mask: 1
>         ok 1 selftests: cpufreq: main.sh
>
> The output version line is: "TAP version 13"
>
> The test plan is "1..1".
>
> Element details
> ===============
>
> Output version line
> -------------------
> The output version line is always "TAP version 13".
>
> Although the kernel test result format has some additions
> to the TAP13 format, the version line reported by kselftest tests
> is (currently) always the exact string "TAP version 13"
>
> This is always the first line of test output.

KUnit is currently outputting "TAP version 14", as we were hoping some
of our changes would get into the TAP14 spec. (Any comments, Brendan?)
Maybe this should end up saying "KTAP version 1" or something?

> Test plan line
> --------------
> The test plan indicates the number of individual test cases intended to
> be executed by the test. It always starts with "1.." and is followed
> by the number of tests cases.  In the example above, 1..1", indicates
> that this test reports only 1 test case.
>
> The test plan line can be placed in two locations:
>  * the second line of test output, when the number of test cases is known
>    in advance
>  * as the last line of test output, when the number of test cases is not
>    known in advance.
>
> Most often, the number of test cases is known in advance, and the test plan
> line appears as the second line of test output, immediately following
> the output version line.  The number of test cases might not be known
> in advance if the number of tests is calculated from runtime data.
> In this case, the test plan line is emitted as the last line of test
> output.

KUnit is currently including the test plan line only for subtests, as
the current version doesn't actually know how many test suites will
run in advance.
This is something there's work underway to fix, though.

> Test result lines
> -----------------
> The test output consists of one or more test result lines that indicate
> the actual results for the test.  These have the format:
>
>   <result> <number> <description> [<directive>] [<diagnostic data>]
>
> The ''result'' must appear at the start of a line (except for when a
> test is nested, see below), and must consist of one of the following
> two phrases:
>   * ok
>   * not ok
>
> If the test passed, then the result is reported as "ok".  If the test
> failed, then the result is reported as "not ok".  These must be in
> lower case, exactly as shown.
>
> The ''number'' in the test result line represents the number of the
> test case being performed by the test program.  This is often used by
> test harnesses as a unique identifier for each test case.  The test
> number is a base-10 number, starting with 1.  It should increase by
> one for each new test result line emitted.  If possible the number
> for a test case should be kept the same over the lifetime of the test.
>
> The ''description'' is a short description of the test case.
> This can be any string of words, but should avoid using colons (':')
> except as part of a fully qualifed test case name (see below).
>
> Finally, it is possible to use a test directive to indicate another
> possible outcome for a test: that it was skipped.  To report that
> a test case was skipped, the result line should start with the
> result "not ok", and the directive "# SKIP" should be placed after
> the test description. (Note that this deviates from the TAP13
> specification).
>
> A test may be skipped for a variety of reasons, ranging for
> insufficient privileges to missing features or resources required
> to execute that test case.
>
> It is usually helpful if a diagnostic message is emitted to explain
> the reasons for the skip.  If the message is a single line and is
> short, the diagnostic message may be placed after the '# SKIP'
> directive on the same line as the test result.  However, if it is
> not on the test result line, it should precede the test line (see
> diagnostic data, next).

We're in the process of supporting test skipping in KUnit at the
moment[1], and haven't totally formalised what the syntax here should
be. The only output issues thus far have been on the "ok"/"not ok"
point (my in-progress patch is using 'ok', the previous RFC could
output either). At the moment, the reason a test is skipped has to be
on the same line as the result for the tools to pick it up (and the
KUnit API always requests such a 'status comment', even if it ends up
as the empty string).

We'll probably follow whatever kselftest does here, though, but will
be able to do more with skip reasons on the reult line.

> Diagnostic data
> ---------------
> Diagnostic data is text that reports on test conditions or test
> operations, or that explains test results.  In the kernel test
> result format, diagnostic data is placed on lines that start with a
> hash sign, followed by a space ('# ').
>
> One special format of diagnostic data is a test identification line,
> that has the fully qualified name of a test case.  Such a test
> identification line marks the start of test output for a test case.
>
> In the example above, there are three lines that start with '#'
> which precede the test result line:
>         # selftests: cpufreq: main.sh
>         # pid 8101's current affinity mask: fff
>         # pid 8101's new affinity mask: 1
> These are used to indicate diagnostic data for the test case
> 'selftests: cpufreq: main.sh'
>
> Material in comments between the identification line and the test
> result line are diagnostic data that can help to interpret the
> results of the test.
>
> The TAP specification indicates that automated test harnesses may
> ignore any line that is not one of the mandatory prescribed lines
> (that is, the output format version line, the plan line, a test
> result line, or a "Bail out!" line.)
>
> Bail out!
> ---------
> If a line in the test output starts with 'Bail out!', it indicates
> that the test was aborted for some reason.  It indicates that
> the test is unable to proceed, and no additional tests will be
> performed.
>
> This can be used at the very beginning of a test, or anywhere in the
> middle of the test, to indicate that the test can not continue.
>
> --- from here on is not-yet-organized material
>
> Tip:
>  - don't change the test plan based on skipped tests.
>    - it is better to report that a test case was skipped, than to
>      not report it
>    - that is, don't adjust the number of test cases based on skipped
>      tests
>
> Other things to mention:
> TAP13 elements not used:
>  - yaml for diagnostic messages
>    - reason: try to keep things line-based, since output from other things
>    may be interspersed with messages from the test itself
We're not using this in KUnit, either.
>  - TODO directive
Ditto: the upcoming SKIP support leaves room for this to easily be
added, though.
>
> KTAP Extensions beyond TAP13:
>  - nesting
>    - via indentation
>      - indentation makes it easier for humans to read
We're using this a lot in KUnit, as all tests are split into suites.
The syntax is basically a full nested TAP document, indented with four
spaces. (There are a couple of tests which output some non-indented
lines to our log, though.)

I've included some example output at the end of this email of what
we're doing currently.

>  - test identifier
>     - multiple parts, separated by ':'

>  - summary lines
>    - can be skipped by CI systems that do their own calculations

We're not outputting any summary lines for the tests as a whole, but
the success of a test suite is determined from the success of nested
tests.

> Other notes:
>  - automatic assignment of result status based on exit code
>
> Tips:
>  - do NOT describe the result in the test line
>    - the test case description should be the same whether the test
>      succeeds or fails
>    - use diagnostic lines to describe or explain results, if this is
>      desirable
>  - test numbers are considered harmful
>    - test harnesses should use the test description as the identifier
>    - test numbers change when testcases are added or removed
>      - which means that results can't be compared between different
>        versions of the test
>  - recommendations for diagnostic messages:
>    - reason for failure
>    - reason for skip
>    - diagnostic data should always preceding the result line
>      - problem: harness may emit result before test can do assessment
>        to determine reason for result
>      - this is what the kernel uses
>
> Differences between kernel test result format and TAP13:
>  - in KTAP the "# SKIP" directive is placed after the description on
>    the test result line

That's what we're planning to do with KUnit as well: clearly I didn't
read the TAP13 spec as thoroughly as I'd intended, as I'd naively
assumed that this was TAP13 spec compliant. Oops.
I'm very much in favour of this change.

>
> ====== start of ktap-doc-rfc.txt ======
> OK - that's the end of the RFC doc.
>
> Here are a few questions:
>  - is this document desired or not?

This is definitely a good thing for us: thanks a lot!

>     - is it too long or too short?
>  - if the document is desired, where should it be placed?
>    I assume somewhere under Documentation, and put into
>    .rst format. Suggestions for a name and location are welcome.
>  - is this document accurate?
>    I think KUNIT does a few things differently than this description.
>    - is the intent to have kunit and kselftest have the same output format?
>       if so, then these should be rationalized.

As above, we'd love to at least try to have kunit and kselftest using
the same format.


> Finally,
>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
> See https://testanything.org/tap-version-13-specification.html

I have a very mild preference for 'ok': but it doesn't really matter
much one way or the other. Our tooling throws the result away if it
sees a SKIP.

> Regards,
>  -- Tim
>
>

Example KUnit output (including the in-progress "skip test" support):
TAP version 14
   # Subtest: kunit-try-catch-test
   1..2
   ok 1 - kunit_test_try_catch_successful_try_no_catch
   ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch
ok 1 - kunit-try-catch-test
    # Subtest: example
   1..2
   # example_simple_test: initializing
   ok 1 - example_simple_test
   # example_skip_test: initializing
   ok 2 - example_skip_test # SKIP this test should be skipped
ok 2 - example



[1]: https://lore.kernel.org/linux-kselftest/20200513042956.109987-1-davidgow@google.com/T/#u
