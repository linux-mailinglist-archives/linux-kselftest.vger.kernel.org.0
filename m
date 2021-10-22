Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3D643718D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Oct 2021 08:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhJVGMw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Oct 2021 02:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhJVGMw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Oct 2021 02:12:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0ADC061764
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 23:10:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v17so1256865wrv.9
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 23:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ri37NUrCIz+RJ7u4QEcy6nQ+rRdgNnFnx1wBKzaAWuA=;
        b=bFqJmuq0jQzmYQ7F6KHJD/td/GbSkeTqYnfmqlUzMMBZLE6Ybhx0EHdanecOqJUyNz
         evGZdKg8hKjc3k2JAzENDx8cVTLI834bc39bNVP+aQPWv7pdV19smsK16axTKD6CARqV
         yGH29I3m+Ys4MbTt6rTU+NfGQBGBURzJoILck/dr1Anauk5qv0H7pLNFI/5pzoH12eH8
         8Z5ce+M9u2o42YUwQCI+QVuAdXjPBrPPKbaJXZcVITu1DkSAAh2dOv8MOyBDQfx+/7/i
         UkiNkmDgi5p2R4LJxSVmKOVXz01B9MPqqCLP87NeMGHmyrif5vNVGM++o6cQ7yX/dIE4
         g7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ri37NUrCIz+RJ7u4QEcy6nQ+rRdgNnFnx1wBKzaAWuA=;
        b=nD05jYaYeTt8e1SszwVkNkfykVQX0O0USFnnwxpj/Dve3TLZY7284OJmeNQPO6iPXZ
         0RoGE3Xcieg9Zx0oMsBqCMGUNCdYGjT1sqh/5o8oeJWfDxFP9FWzrKMDld6EDBcnEnKU
         Eem+4nGmOjQvvh7hbLicimzTAexwO1Lb50aDJZKGrl5O9OKX/A0w/OHLEAVvFVEOxC6A
         99COR4P5X+brQG2YgAXV2GsHhqKTVFS2jAZ119iQk8muspxYwJd426gTmvBWXE4govci
         xAa5TqGMnwbs4iKinsVFecXWU58IJa4tQlNRc21+LrPRmwTRzaz691NOBxfCh/X7zZy+
         tLPQ==
X-Gm-Message-State: AOAM530vLQ3H55aS9/Ng3PfVOM86vPvOEaRdrcJavKBmpdhyC6KGcqfW
        3I9mjtYRV2FosolwDikt/cf5SGBzGom/C3qqvJejHg==
X-Google-Smtp-Source: ABdhPJxvrczJ9+DQW8gBEzNqRUvxfcxtz52+XgprBBJrXGoTJnrdJVFvTgEgcl8VPgfr+Z+AjJ1I7R1I6ysaE+uafn8=
X-Received: by 2002:a5d:4882:: with SMTP id g2mr12929352wrq.399.1634883033051;
 Thu, 21 Oct 2021 23:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211021062819.1313964-1-davidgow@google.com> <CAGS_qxoBhfaE7NLzKWrsxwwz9BFeLRzb9Ycc-6U29pmtceqCTQ@mail.gmail.com>
In-Reply-To: <CAGS_qxoBhfaE7NLzKWrsxwwz9BFeLRzb9Ycc-6U29pmtceqCTQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Oct 2021 14:10:21 +0800
Message-ID: <CABVgOS=vbqNnc_uW9czL6+vD55+XVa0X+=VPH+Tz0nGg0EF2gA@mail.gmail.com>
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

On Fri, Oct 22, 2021 at 9:29 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, Oct 20, 2021 at 11:28 PM David Gow <davidgow@google.com> wrote:
> >
> > The (K)TAP spec encourages test output to begin with a 'test plan': a
> > count of the number of tests being run of the form:
> > 1..n
> >
> > However, some test suites might not know the number of subtests in
> > advance (for example, KUnit's parameterised tests use a generator
> > function). In this case, it's not possible to print the test plan in
> > advance.
> >
> > kunit_tool already parses test output which doesn't contain a plan, but
> > reports an error. Since we want to use nested subtests with KUnit
> > paramterised tests, remove this error.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  tools/testing/kunit/kunit_parser.py    | 5 ++---
> >  tools/testing/kunit/kunit_tool_test.py | 5 ++++-
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > index 3355196d0515..50ded55c168c 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -340,8 +340,8 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
> >         """
> >         Parses test plan line and stores the expected number of subtests in
> >         test object. Reports an error if expected count is 0.
> > -       Returns False and reports missing test plan error if fails to parse
> > -       test plan.
> > +       Returns False and sets expected_count to None if there is no valid test
> > +       plan.
> >
> >         Accepted format:
> >         - '1..[number of subtests]'
> > @@ -356,7 +356,6 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
> >         match = TEST_PLAN.match(lines.peek())
> >         if not match:
> >                 test.expected_count = None
> > -               test.add_error('missing plan line!')
>
> This works well, but there's an edge case.
>
> This patch means we no longer print an error when there are no test
> cases in a subtest.
> We relied on a check just a bit lower in this function.
>
> Consider
>
> $ ./tools/testing/kunit/kunit.py parse <<EOF
> TAP version 14
> 1..1
>   # Subtest: suite
>   1..1
>     # Subtest: case
>   ok 1 - case
> ok 1 - suite
> EOF
>
> This produces the following output (timestamps removed)
>
> ============================================================
> ==================== suite (1 subtest) =====================
> =========================== case ===========================
> ====================== [PASSED] case =======================
> ====================== [PASSED] suite ======================
> ============================================================
>
> Should we surface some sort of error here?

I thought about this a bit (and started prototyping it), and think the
answer is probably "no" (or, perhaps, "optionally"). Largely because I
think it'd be technically valid to have, e.g., a parameterised test
whose generator function can legitimately provide zero subtests. And
while that's probably worth warning about if it's the only test
running, if you're trying to run all tests, and one random subtest of
a test of a suite has no subtests, that seems like it'd be more
annoying to error on than anything else.

That being said, I'm not opposed to implementing it as an option, or
at least having the test status set to NO_ERROR. The implementation
I've experimented with basically moves the check to "parse_test", and
errors if the number of subtests is 0 after parsing, if parent_test is
true (or main, but my rough plan was to make main imply parent_test,
and adjust the various conditions to match). I haven't looked into
exactly how this is bubbled up yet, but I'd be okay with having an
error if there are no tests run at all.

I'll keep playing with this anyway: it's definitely a bit more of a
minefield than I'd originally thought. :-)

-- David

>
>
> >                 return False
> >         test.log.append(lines.pop())
> >         expected_count = int(match.group(1))
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 9c4126731457..bc8793145713 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -191,7 +191,10 @@ class KUnitParserTest(unittest.TestCase):
> >                         result = kunit_parser.parse_run_tests(
> >                                 kunit_parser.extract_tap_lines(
> >                                 file.readlines()))
> > -               self.assertEqual(2, result.test.counts.errors)
> > +               # A missing test plan is not an error.
> > +               self.assertEqual(0, result.test.counts.errors)
> > +               # All tests should be accounted for.
> > +               self.assertEqual(10, result.test.counts.total())
> >                 self.assertEqual(
> >                         kunit_parser.TestStatus.SUCCESS,
> >                         result.status)
> > --
> > 2.33.0.1079.g6e70778dc9-goog
> >
