Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3F42992A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 23:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhJKVyb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 17:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhJKVya (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 17:54:30 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF8AC06161C
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Oct 2021 14:52:30 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e144so21437864iof.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Oct 2021 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qn552UUYAq2mxys4HsWoy0JUvqhzNWzWMRX1kUD0CDI=;
        b=SuoAjQkkfqHeeYrmSWc2V/R30BkZrHot5iLSxjniZPG91s6C2WSsR9DIQ/DRh3jMVm
         66kAOEEkU3Jl+RLUezWKx9zdgoVnzShV9lesGhKrMURL4uYFEuxIdYJTg9sGtlnqL6du
         Lf14aRhq2zxBzk7UvXHdhIrDZ6r9bBOS6x0oS8C16Evqye9CREFE1ha5K9wnLFf2SeBS
         kk2C3vhRt6236YDc5WFDGJJt5kGJP5S90LUuCWs1wHvE7qFVCkJeCma1KnMwckIwRJvV
         mFVOlqmpY8z+Ae2gDSqgTEV0NjWIP19dBBI5gTZDO1zOLwXF/8imYZacN/vWI6mr8WUI
         mSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qn552UUYAq2mxys4HsWoy0JUvqhzNWzWMRX1kUD0CDI=;
        b=l2g7r6O38LBhHMzFgzqr52+iDobfo+i8so/1ykJiDnQf6cIRB9bgMTWAVrd3ijF2uN
         xgjtd4SKkDPMukPBiRupD7MbEcE/ppb3WoMX5U59rcg27Y6VLzm5qEneUfJNEjfCyP3S
         S0QdJ7zL30fu6Wc4QQPIZNvSSWB67wpq3K50IWa9qkTe31dYFjqK9nGrTyOfKRFw7PJZ
         ixZklc6YlLIA7DN4WvhzTm5Kj9ojrr5hMpFsbN+xt8y3MjCpzoTntOSC6P4pTSnIJOis
         mdZDeakbKGJmopgl9x41sqYZBvH94oLGbAEQq00K2nLH+TzbwUAqXMCiT2n2Vs+pOCzP
         krSw==
X-Gm-Message-State: AOAM5306svuhoYKWgIGJKj5hFa9pkfjKGK1Pbzz3LQDJ9OphQ/NAXzz7
        jxaUf/SX/MC8AQyPMo3duNW6zybJ/8aoPCz/5NrdrA==
X-Google-Smtp-Source: ABdhPJzkLIi0YL9wrh95RO4bWOoiiwu/vbUq62d73FAvovcGiK2NXvBAMmACNQvgo4LkuDynU75amCm9nIo/Xwd0CMQ=
X-Received: by 2002:a05:6602:1342:: with SMTP id i2mr15279732iov.153.1633989149317;
 Mon, 11 Oct 2021 14:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211007210324.707912-1-dlatypov@google.com> <CABVgOS=aJ39zpaEZ8-3qPnKe7EoGoNEhrQ=qmdafdjz17oFRng@mail.gmail.com>
 <CAGS_qxoW5h40g24Xsgqu4svFdFxr6592eXygV8NoJxW6ECWRVQ@mail.gmail.com> <CAGS_qxobkgnWOp_mEoSzZ-CV7wqbbLyRcJL2Pd_z5-GvUmBR-w@mail.gmail.com>
In-Reply-To: <CAGS_qxobkgnWOp_mEoSzZ-CV7wqbbLyRcJL2Pd_z5-GvUmBR-w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 11 Oct 2021 14:52:17 -0700
Message-ID: <CAGS_qxpe26UE32gb=r60ROyR3K2i-h_OH=pM4sSkVFnD6Shucw@mail.gmail.com>
Subject: Re: [PATCH v7] kunit: tool: improve compatibility of kunit_parser
 with KTAP specification
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 11, 2021 at 11:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Oct 11, 2021 at 10:14 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Fri, Oct 8, 2021 at 7:35 PM 'David Gow' via KUnit Development
> > <kunit-dev@googlegroups.com> wrote:
> > >
> > > On Fri, Oct 8, 2021 at 5:03 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > >
> > > > From: Rae Moar <rmoar@google.com>
> > > >
> > > > Update to kunit_parser to improve compatibility with KTAP
> > > > specification including arbitrarily nested tests. Patch accomplishes
> > > > three major changes:
> > > >
> > > > - Use a general Test object to represent all tests rather than TestCase
> > > > and TestSuite objects. This allows for easier implementation of arbitrary
> > > > levels of nested tests and promotes the idea that both test suites and test
> > > > cases are tests.
> > > >
> > > > - Print errors incrementally rather than all at once after the
> > > > parsing finishes to maximize information given to the user in the
> > > > case of the parser given invalid input and to increase the helpfulness
> > > > of the timestamps given during printing. Note that kunit.py parse does
> > > > not print incrementally yet. However, this fix brings us closer to
> > > > this feature.
> > > >
> > > > - Increase compatibility for different formats of input. Arbitrary levels
> > > > of nested tests supported. Also, test cases and test suites are now
> > > > supported to be present on the same level of testing.
> > > >
> > > > This patch now implements the draft KTAP specification here:
> > > > https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
> > > > We'll update the parser as the spec evolves.
> > > >
> > > > This patch adjusts the kunit_tool_test.py file to check for
> > > > the correct outputs from the new parser and adds a new test to check
> > > > the parsing for a KTAP result log with correct format for multiple nested
> > > > subtests (test_is_test_passed-all_passed_nested.log).
> > > >
> > > > This patch also alters the kunit_json.py file to allow for arbitrarily
> > > > nested tests.
> > > >
> > > > Signed-off-by: Rae Moar <rmoar@google.com>
> > > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > > Reviewed-by: David Gow <davidgow@google.com>
> > > > ---
> > >
> > > Found a regression here with the KASAN tests and treating "BUG:" as a crash.
> > >
> > > Take this output, for example:
> > > [19:32:07] # Subtest: kasan
> > > [19:32:07] 1..48
> > > [19:32:07] # kasan: pass:42 fail:0 skip:6 total:48
> > > [19:32:07] # Totals: pass:42 fail:0 skip:6 total:48
> > > [19:32:07] ok 1 - kasan
> > > [19:32:07] ===================== [CRASHED] kasan ======================
> > > [19:32:07] ============================================================
> > > [19:32:07] Testing complete. Passed: 4, Failed: 0, Crashed: 38,
> > > Skipped: 6, Errors: 0
> > >
> > > The in-kernel totals are correctly: 42 passed, 7 skipped, 0 failed. In
> > > kunit_tool, only 4 tests are recorded as passed, and 38 are marked as
> > > crashed.
> > >
> > >
> > > > Change log from v6:
> > > > https://lore.kernel.org/linux-kselftest/20211006170049.106852-1-dlatypov@google.com/
> > > > - Rebase onto shuah/linux-kselftest/kunit
> > > > - fix one new unit test failure (s/suites/test.subtests)
> > > >
> > > > Change log from v5:
> > > > https://lore.kernel.org/linux-kselftest/20211006001447.20919-1-dlatypov@google.com/
> > > > - Tweak commit message to reflect the KTAP spec is a draft
> > > > - Add missing Signed-off-by
> > > > - Tweak docstrings
> > > >
> > > > Change log from v3,4:
> > > > https://lore.kernel.org/linux-kselftest/20210901190623.315736-1-rmoar@google.com/
> > > > - Move test_kselftest_nested from LinuxSourceTreeTest => KUnitParserTest.
> > > > - Resolve conflict with hermetic testing patches.
> > > >   - max_status is no longer defined, so we need to use the TestCounts
> > > >     type now. And to keep --raw_output working, we need to set this to
> > > >     SUCCESS to avoid the default assumption that the kernel crashed.
> > > >
> > > > Ignore v4, was accidentally based on v2.
> > > >
> > > > Change log from v2:
> > > > https://lore.kernel.org/linux-kselftest/20210826195505.3066755-1-rmoar@google.com/
> > > > - Fixes bug of type disagreement in kunit_json.py for build_dir
> > > > - Removes raw_output()
> > > > - Changes docstrings in kunit_parser.py (class docstring, LineStream
> > > >   docstrings, add_error(), total(), get_status(), all parsing methods)
> > > > - Fixes bug of not printing diagnostic log in the case of end of lines
> > > > - Sets default status of all tests to TEST_CRASHED
> > > > - Adds and prints empty tests with crashed status in case of missing
> > > >   tests
> > > > - Prints 'subtest' in instance of 1 subtest instead of 'subtests'
> > > > - Includes checking for 'BUG:' message in search of crash messages in
> > > >   log (note that parse_crash_in_log method could be removed but would
> > > >   require deleting tests in kunit_tool_test.py that include the crash
> > > >   message that is no longer used. If removed, parser would still print
> > > >   log in cases of test crashed or failure, which would now include
> > > >   missing subtests)
> > >
> > > So this causes problems with the KASAN tests, because they include
> > > KASAN errors in the log (which are expected), and these messages do
> > > contain "BUG:".
> > > Even though the KASAN integration code then marks the test as success,
> > > and it shows up as "ok" in the KTAP output, kunit_tool now marks it as
> > > crashed.
> > >
> > > There are two obvious solutions to this:
> > > - Update KASAN to not include "BUG" in the message for KASAN failures
> > > which are expected.
> > > - Alter this patch to not mark tests as crashed just because they have
> > > "BUG" in their logs.
> > >
> > > (There are also more complicated solutions, like having a "failure
> > > expected" message added to the log, and only ignoring "BUG:" if that
> > > exists in kunit_tool, but that seems needlessly complicated.)
> > >
> > > I feel that, in the short term, we should revert this change, and not
> > > treat "BUG:" specially. We can add it back in as a separate patch if
> > > we want to fix this issue differently.
> >
> > Will do.
> >
> > I also found another bug relating to test status counting.
> >
> > If there's NO_TESTS, add_status() will increment the counts.passed field.
> > This means if you get
> >
> > $ ./tools/testing/kunit/kunit.py exec 'nomatch'
> > [10:13:34] Starting KUnit Kernel (1/1)...
> > [10:13:34] ============================================================
> > [10:13:37] [ERROR] Test main: 0 tests run!
> > [10:13:37] ============================================================
> > [10:13:37] Testing complete. Passed: 1, Failed: 0, Crashed: 0,
> > Skipped: 0, Errors: 1
> > <exit with status code 0>
> >
>
> I think something like this resolves those two issues.
> I'm just not sure what the intent behind the SUCCESS or NO_TESTS checks was.

Sent out a v8 for both of these.
Slightly tweaked the diff below to make "NO_TESTS" print out in yellow, not red.

https://lore.kernel.org/linux-kselftest/20211011215037.1629208-1-dlatypov@google.com

>
> diff --git a/tools/testing/kunit/kunit_parser.py
> b/tools/testing/kunit/kunit_parser.py
> index f01fd565f978..bd3e859bc4e5 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -156,17 +156,13 @@ class TestCounts:
>                 Parameters:
>                 status - status to be added to the TestCounts object
>                 """
> -               if status == TestStatus.SUCCESS or \
> -                               status == TestStatus.NO_TESTS:
> -                       # if status is NO_TESTS the most appropriate
> -                       # attribute to increment is passed because
> -                       # the test did not fail, crash or get skipped.
> +               if status == TestStatus.SUCCESS:
>                         self.passed += 1
>                 elif status == TestStatus.FAILURE:
>                         self.failed += 1
>                 elif status == TestStatus.SKIPPED:
>                         self.skipped += 1
> -               else:
> +               elif status != TestStatus.NO_TESTS:
>                         self.crashed += 1
>
>  class LineStream:
> @@ -475,8 +471,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
>                 log.append(lines.pop())
>         return log
>
> -DIAGNOSTIC_CRASH_MESSAGE = re.compile(
> -               r'^(BUG:|# .*?: kunit test case crashed!$)')
> +DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^# .*?: kunit test case crashed!$')
>
>  def parse_crash_in_log(test: Test) -> bool:
>         """
> @@ -642,8 +637,7 @@ def print_summary_line(test: Test) -> None:
>
>         test - Test object representing current test being printed
>         """
> -       if test.status == TestStatus.SUCCESS or \
> -                       test.status == TestStatus.NO_TESTS:
> +       if test.status == TestStatus.SUCCESS:
>                 color = green
>         elif test.status == TestStatus.SKIPPED:
>                 color = yellow
