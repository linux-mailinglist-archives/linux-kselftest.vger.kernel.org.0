Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D534438056
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Oct 2021 00:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhJVWoU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Oct 2021 18:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhJVWoU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Oct 2021 18:44:20 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D935C061764
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Oct 2021 15:42:02 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x1so5853728ilv.4
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Oct 2021 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GNk0fBaCEoYeSy8vitg/yebGlaA5BrT88ZyfG8oqWiM=;
        b=L6x105+ZMiATEgyeJUUIkPF9vq2Ud7JupQ3G1pLHAHZIwgL/PCWAHIdtN8wV1rYEbh
         NgVhkK8k64ER7pSAwnNvOk9tJSFLWDLrdnWQ8Lam1P/kjooNGatmdZaylhzRoEOI/T1p
         ORy1kLARj8rs46xrecNKSMK77v0C1WdzqZribvK6a5LPLS+c8n3TLPhADHXM1am5Z+T+
         hyycXKQGfRKo7xsVfUk7LaELeel6XwYL351O+dSpfJ+GtnfsjhylAoFex9QlYuqULaBT
         DD3DVFgGeGnPtENS8z/DWOgC4EIc5omDDKqss/2v7HTum9G6ecUKMrheqak9emJ3QU+l
         lrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GNk0fBaCEoYeSy8vitg/yebGlaA5BrT88ZyfG8oqWiM=;
        b=OL74/tBwEoYRszJtiw6K7Qws103cZg5g4OakVZ3j3kdOTHEk6gdf6/EsQf3/3P0wOj
         A7UIkwG9XgcJG3z93gEbPanIFlebWqPL9WXEcCmEIE917shGf9zvuX2yi26JEXvjRo1l
         N50KjTFGA97tRO6WNauxPs1UwvxZKzBlR9pcdsW1bL7c1eN2Zcl8QzPJ3Vc+Gu96tPRf
         bxngonzW0aq3Ad1/b4vpLdtfrjkfYyHQ1diQgoZcgPW4XH2OlvC478tXaSKNRMLUdtWJ
         iIwUjHqdxRWEuVBPjpzsLSuL3bWGIQ39V4zsg7VhD2snesI9i1ZR5fUIYN7LJIKfgDih
         hgng==
X-Gm-Message-State: AOAM533sEP7fFVcyaSgJ7peeYJMWikJPSfgE0pq1J6AvB1RyScT9oAV7
        dDZqbnhi8WshFBz/bFFSBRuWvxfHpWYwIk6uLKdJBQ==
X-Google-Smtp-Source: ABdhPJztfXWnx+5XjWUlgrrA+D8WOZjypohAWFBY/EJLLo+wxeimMNb5XELY8TENM0hNCQzLn1p7jd0+MMadJM05F0Q=
X-Received: by 2002:a05:6e02:148f:: with SMTP id n15mr1589395ilk.121.1634942521382;
 Fri, 22 Oct 2021 15:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211021062819.1313964-1-davidgow@google.com> <CAGS_qxoBhfaE7NLzKWrsxwwz9BFeLRzb9Ycc-6U29pmtceqCTQ@mail.gmail.com>
 <CABVgOS=vbqNnc_uW9czL6+vD55+XVa0X+=VPH+Tz0nGg0EF2gA@mail.gmail.com>
In-Reply-To: <CABVgOS=vbqNnc_uW9czL6+vD55+XVa0X+=VPH+Tz0nGg0EF2gA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 22 Oct 2021 15:41:46 -0700
Message-ID: <CAGS_qxqVWSTPdNs4AedPdHwj_QqUTi5JML4284FQDgD4CRoXHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Do not error on tests without test plans
To:     David Gow <davidgow@google.com>
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

On Thu, Oct 21, 2021 at 11:10 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Oct 22, 2021 at 9:29 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Wed, Oct 20, 2021 at 11:28 PM David Gow <davidgow@google.com> wrote:
> > >
> > > The (K)TAP spec encourages test output to begin with a 'test plan': a
> > > count of the number of tests being run of the form:
> > > 1..n
> > >
> > > However, some test suites might not know the number of subtests in
> > > advance (for example, KUnit's parameterised tests use a generator
> > > function). In this case, it's not possible to print the test plan in
> > > advance.
> > >
> > > kunit_tool already parses test output which doesn't contain a plan, but
> > > reports an error. Since we want to use nested subtests with KUnit
> > > paramterised tests, remove this error.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >  tools/testing/kunit/kunit_parser.py    | 5 ++---
> > >  tools/testing/kunit/kunit_tool_test.py | 5 ++++-
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > > index 3355196d0515..50ded55c168c 100644
> > > --- a/tools/testing/kunit/kunit_parser.py
> > > +++ b/tools/testing/kunit/kunit_parser.py
> > > @@ -340,8 +340,8 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
> > >         """
> > >         Parses test plan line and stores the expected number of subtests in
> > >         test object. Reports an error if expected count is 0.
> > > -       Returns False and reports missing test plan error if fails to parse
> > > -       test plan.
> > > +       Returns False and sets expected_count to None if there is no valid test
> > > +       plan.
> > >
> > >         Accepted format:
> > >         - '1..[number of subtests]'
> > > @@ -356,7 +356,6 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
> > >         match = TEST_PLAN.match(lines.peek())
> > >         if not match:
> > >                 test.expected_count = None
> > > -               test.add_error('missing plan line!')
> >
> > This works well, but there's an edge case.
> >
> > This patch means we no longer print an error when there are no test
> > cases in a subtest.
> > We relied on a check just a bit lower in this function.
> >
> > Consider
> >
> > $ ./tools/testing/kunit/kunit.py parse <<EOF
> > TAP version 14
> > 1..1
> >   # Subtest: suite
> >   1..1
> >     # Subtest: case
> >   ok 1 - case
> > ok 1 - suite
> > EOF
> >
> > This produces the following output (timestamps removed)
> >
> > ============================================================
> > ==================== suite (1 subtest) =====================
> > =========================== case ===========================
> > ====================== [PASSED] case =======================
> > ====================== [PASSED] suite ======================
> > ============================================================
> >
> > Should we surface some sort of error here?
>
> I thought about this a bit (and started prototyping it), and think the
> answer is probably "no" (or, perhaps, "optionally"). Largely because I
> think it'd be technically valid to have, e.g., a parameterised test
> whose generator function can legitimately provide zero subtests. And

That's the question. Should we report PASSED in that case as we do now?

Let's consider parameterised tests, our only current example in KUnit.

I think in most cases, it's a bug that if we got 0 cases and we should
let the user know somehow.
Should it be an error/warning? Maybe not, but wouldn't it be better to
report SKIPPED?
(This would require a change in KUnit on the kernel side, I'm not
suggesting we do this in the parser)

> while that's probably worth warning about if it's the only test
> running, if you're trying to run all tests, and one random subtest of
> a test of a suite has no subtests, that seems like it'd be more
> annoying to error on than anything else.
>
> That being said, I'm not opposed to implementing it as an option, or
> at least having the test status set to NO_ERROR. The implementation
> I've experimented with basically moves the check to "parse_test", and
> errors if the number of subtests is 0 after parsing, if parent_test is
> true (or main, but my rough plan was to make main imply parent_test,
> and adjust the various conditions to match). I haven't looked into
> exactly how this is bubbled up yet, but I'd be okay with having an
> error if there are no tests run at all.
>
> I'll keep playing with this anyway: it's definitely a bit more of a
> minefield than I'd originally thought. :-)
>
> -- David
>
> >
> >
> > >                 return False
> > >         test.log.append(lines.pop())
> > >         expected_count = int(match.group(1))
> > > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > > index 9c4126731457..bc8793145713 100755
> > > --- a/tools/testing/kunit/kunit_tool_test.py
> > > +++ b/tools/testing/kunit/kunit_tool_test.py
> > > @@ -191,7 +191,10 @@ class KUnitParserTest(unittest.TestCase):
> > >                         result = kunit_parser.parse_run_tests(
> > >                                 kunit_parser.extract_tap_lines(
> > >                                 file.readlines()))
> > > -               self.assertEqual(2, result.test.counts.errors)
> > > +               # A missing test plan is not an error.
> > > +               self.assertEqual(0, result.test.counts.errors)
> > > +               # All tests should be accounted for.
> > > +               self.assertEqual(10, result.test.counts.total())
> > >                 self.assertEqual(
> > >                         kunit_parser.TestStatus.SUCCESS,
> > >                         result.status)
> > > --
> > > 2.33.0.1079.g6e70778dc9-goog
> > >
