Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7074380F2
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Oct 2021 02:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhJWA1h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Oct 2021 20:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhJWA1g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Oct 2021 20:27:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6A8C061764
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Oct 2021 17:25:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso5363764wmc.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Oct 2021 17:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iy7fPYGW5HLs/VIn/ynMufoWqjwG0wb6agonWTQ+FoQ=;
        b=Tvjwsmwlxs6pVnY2aRnGdOWl2imGADpbfQyDWTZwVNqA4UJ2NQstfeEHJZ1F+vJ260
         Xx4TVqwlY0H+aZEaSBj+Vb/FmU4cc0TQuANCIFIeUtKvuY1+KC71TzOl298KtwwEaURv
         TYR6yQcnsJpSl1Zh8XXUTpSK0vMD1tG2czS8Joj3eYXAGlrmTNyevpS1qqaKKy41IVLN
         W7fBWDo41Wy7tPtdzLlabV+H5JC4Tx4tu+CXoseudK+lYAuWLRcDmIerufcmTe/KROaQ
         bTIIXU83k3CBUbBrHpKV5hr6D6NWxaltnAUt94FMq+3wT+LnIP0Nmu5syysZIYjNnaRx
         idBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iy7fPYGW5HLs/VIn/ynMufoWqjwG0wb6agonWTQ+FoQ=;
        b=hA8emi+8ehdof9fzl2FVcByBgyXI5Yw58ku970Ki8Woj5HZs0xM4GCHu6AiMnUvaqB
         /XOWSq2Wgar/N1yZYLia39gRi9XdrMtiC8oWBkojrrOM83pQ5sGLzEevmgN0k+yGh4J1
         jZzHJhDf3WWeHoUsuEiAL5n2bjKGV0a2BaBjejbTiPaEXtSxNS2h2TCnkATwTiuxOl5h
         x5DCaMEm0hS53dT59V5jFOI0bkt6bIhey2CupT9x36jz58Y/Esz7kWlbzwTU0NmUowhJ
         eKFk6X4UllXv7eRlUnw3Ez+pDxQrBM8WdLXQlKMS3iABd59OGgNkccHfnEtW7yK3xvY7
         IW1Q==
X-Gm-Message-State: AOAM530wMkzwKxnOX7xgklBrKQpD0wLaS60p9n7WYqUKJ7WBA5FhAY6Y
        MZHMWEKypXpx8QFJ8RZ5CWhXuAZ+abLuSIOgvGnbgg==
X-Google-Smtp-Source: ABdhPJwQklsZEJuWq08+1kzT0HS3JK8jYzjpKJeUh6Cvyx/UrQhjBMcLw5pHLGMS0z9LntqJrsyf2ZX9an7Bbi7ouA8=
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr3047127wmc.7.1634948716634;
 Fri, 22 Oct 2021 17:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211021062819.1313964-1-davidgow@google.com> <CAGS_qxoBhfaE7NLzKWrsxwwz9BFeLRzb9Ycc-6U29pmtceqCTQ@mail.gmail.com>
 <CABVgOS=vbqNnc_uW9czL6+vD55+XVa0X+=VPH+Tz0nGg0EF2gA@mail.gmail.com> <CAGS_qxqVWSTPdNs4AedPdHwj_QqUTi5JML4284FQDgD4CRoXHw@mail.gmail.com>
In-Reply-To: <CAGS_qxqVWSTPdNs4AedPdHwj_QqUTi5JML4284FQDgD4CRoXHw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 23 Oct 2021 08:25:05 +0800
Message-ID: <CABVgOSk23AYyFk06rHnZpBDYoLV7UwMwj66wmM268hmvUcdBqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Do not error on tests without test plans
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 23, 2021 at 6:42 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Oct 21, 2021 at 11:10 PM David Gow <davidgow@google.com> wrote:
> >
> > On Fri, Oct 22, 2021 at 9:29 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > On Wed, Oct 20, 2021 at 11:28 PM David Gow <davidgow@google.com> wrote:
> > > >
> > > > The (K)TAP spec encourages test output to begin with a 'test plan': a
> > > > count of the number of tests being run of the form:
> > > > 1..n
> > > >
> > > > However, some test suites might not know the number of subtests in
> > > > advance (for example, KUnit's parameterised tests use a generator
> > > > function). In this case, it's not possible to print the test plan in
> > > > advance.
> > > >
> > > > kunit_tool already parses test output which doesn't contain a plan, but
> > > > reports an error. Since we want to use nested subtests with KUnit
> > > > paramterised tests, remove this error.
> > > >
> > > > Signed-off-by: David Gow <davidgow@google.com>
> > > > ---
> > > >  tools/testing/kunit/kunit_parser.py    | 5 ++---
> > > >  tools/testing/kunit/kunit_tool_test.py | 5 ++++-
> > > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > > > index 3355196d0515..50ded55c168c 100644
> > > > --- a/tools/testing/kunit/kunit_parser.py
> > > > +++ b/tools/testing/kunit/kunit_parser.py
> > > > @@ -340,8 +340,8 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
> > > >         """
> > > >         Parses test plan line and stores the expected number of subtests in
> > > >         test object. Reports an error if expected count is 0.
> > > > -       Returns False and reports missing test plan error if fails to parse
> > > > -       test plan.
> > > > +       Returns False and sets expected_count to None if there is no valid test
> > > > +       plan.
> > > >
> > > >         Accepted format:
> > > >         - '1..[number of subtests]'
> > > > @@ -356,7 +356,6 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
> > > >         match = TEST_PLAN.match(lines.peek())
> > > >         if not match:
> > > >                 test.expected_count = None
> > > > -               test.add_error('missing plan line!')
> > >
> > > This works well, but there's an edge case.
> > >
> > > This patch means we no longer print an error when there are no test
> > > cases in a subtest.
> > > We relied on a check just a bit lower in this function.
> > >
> > > Consider
> > >
> > > $ ./tools/testing/kunit/kunit.py parse <<EOF
> > > TAP version 14
> > > 1..1
> > >   # Subtest: suite
> > >   1..1
> > >     # Subtest: case
> > >   ok 1 - case
> > > ok 1 - suite
> > > EOF
> > >
> > > This produces the following output (timestamps removed)
> > >
> > > ============================================================
> > > ==================== suite (1 subtest) =====================
> > > =========================== case ===========================
> > > ====================== [PASSED] case =======================
> > > ====================== [PASSED] suite ======================
> > > ============================================================
> > >
> > > Should we surface some sort of error here?
> >
> > I thought about this a bit (and started prototyping it), and think the
> > answer is probably "no" (or, perhaps, "optionally"). Largely because I
> > think it'd be technically valid to have, e.g., a parameterised test
> > whose generator function can legitimately provide zero subtests. And
>
> That's the question. Should we report PASSED in that case as we do now?
>
> Let's consider parameterised tests, our only current example in KUnit.
>
> I think in most cases, it's a bug that if we got 0 cases and we should
> let the user know somehow.
> Should it be an error/warning? Maybe not, but wouldn't it be better to
> report SKIPPED?
> (This would require a change in KUnit on the kernel side, I'm not
> suggesting we do this in the parser)
>

Yeah: there are two sorf-of separable decisions here:
1) What result should a test with no subtests return?
2) Do we want to trigger any other errors/warnings.

I think the answer to 1 is that kunit_tool should report the result
printed in the KTAP output. I agree that, for parameterised tests,
though, that SKIPPED makes more sense than PASSED. (kunit_tool has a
separate NO_TESTS result, which we could maybe try to generate and
handle explicitly. I think we might as well leave that for the "no
tests run at all" case for now.)

For 2, I feel that this definitely should count as a "warning", but
all we have at the moment are "errors", which I feel is probably a bit
too strong a term for this. Given errors don't actually halt parsing,
I'm okay with generating them in kunit_tool in this case, but I'd
probably slightly prefer to leave it with SKIPPED, and maybe add a
warning later.

> > while that's probably worth warning about if it's the only test
> > running, if you're trying to run all tests, and one random subtest of
> > a test of a suite has no subtests, that seems like it'd be more
> > annoying to error on than anything else.
> >
> > That being said, I'm not opposed to implementing it as an option, or
> > at least having the test status set to NO_ERROR. The implementation
> > I've experimented with basically moves the check to "parse_test", and
> > errors if the number of subtests is 0 after parsing, if parent_test is
> > true (or main, but my rough plan was to make main imply parent_test,
> > and adjust the various conditions to match). I haven't looked into
> > exactly how this is bubbled up yet, but I'd be okay with having an
> > error if there are no tests run at all.
> >
> > I'll keep playing with this anyway: it's definitely a bit more of a
> > minefield than I'd originally thought. :-)
> >
> > -- David
> >
> > >
> > >
> > > >                 return False
> > > >         test.log.append(lines.pop())
> > > >         expected_count = int(match.group(1))
> > > > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > > > index 9c4126731457..bc8793145713 100755
> > > > --- a/tools/testing/kunit/kunit_tool_test.py
> > > > +++ b/tools/testing/kunit/kunit_tool_test.py
> > > > @@ -191,7 +191,10 @@ class KUnitParserTest(unittest.TestCase):
> > > >                         result = kunit_parser.parse_run_tests(
> > > >                                 kunit_parser.extract_tap_lines(
> > > >                                 file.readlines()))
> > > > -               self.assertEqual(2, result.test.counts.errors)
> > > > +               # A missing test plan is not an error.
> > > > +               self.assertEqual(0, result.test.counts.errors)
> > > > +               # All tests should be accounted for.
> > > > +               self.assertEqual(10, result.test.counts.total())
> > > >                 self.assertEqual(
> > > >                         kunit_parser.TestStatus.SUCCESS,
> > > >                         result.status)
> > > > --
> > > > 2.33.0.1079.g6e70778dc9-goog
> > > >
