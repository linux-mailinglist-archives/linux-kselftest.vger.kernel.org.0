Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA182439A55
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhJYPXk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbhJYPXj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 11:23:39 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E492C061745
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 08:21:17 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h196so16012303iof.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1N2MO7N+EoVGOL8rm+6dntk5xyx9uo4x6BVPD8b8i4=;
        b=btnZrTqrV8hWsqiRSBJDRcIPRvsL2WGZqnvIOZq2RGW9ie4jz0jOT2I3L0ta+jakLh
         WT0cIfcm0SYmeQMfPl4M6ksJIWUQT/BAXnMTgGuPgY4yoyxkRSyVk70heUOcpRVwszmt
         RRdkGe8RSY2RjAf5hMxvhGpr9yfChFwYR5qsXpohoRX0vbYJsLmLyn6oAYoeEN0LpvMR
         o9UayIktI8I/JwCPHb9FLmItFtn4JsSP7e1ZgRIEV4KWzwIcKKQT28+MCOxCP7TUPPL4
         s/7/gHBcT4gV39/N+kOsZfX13LTr4yAGEoA7Vvu3JRAUsm4CRCVO76VS2a3TbNF//SoM
         vxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1N2MO7N+EoVGOL8rm+6dntk5xyx9uo4x6BVPD8b8i4=;
        b=7Zjl+eMnexN9abzH6TqIuzOG8vFfkJAkUYz1mVO3DLogCv2W1Y+pLePsHkIwFujcql
         XHYOYScovAcJs9WXeWFLz5xK+qbtNPodbTuLaq3T4O/5xtWZJjZo5yCjwCHi7iFpsV4D
         raMgXo+Lwo4yb6D8r74KK7Bxh/wEyMftl4fcKDc39mV7vLnCOTs7jc8d5hsCqiFlNbyE
         j04lh9yhRyrny7Ys3lwcPHWLClzhgRyRe3rMYgXxVVEYo/z+xzNotv/pGJ5EEJ6ZDN9T
         hkwVkULbLS2c3Lh5WlOLujhRxaP6vKsyL1c1bw3bQ6aVmSOKI9fi7YeFATpa8t0sxFYR
         fvgQ==
X-Gm-Message-State: AOAM53186hd02jxVAMpIZmXd94y0pdgR42H7n/auvsHmsA6r4ceGkzYg
        QM2UfhIRPMhZUYkIEn0eq+f2Ch+WumkoI93OFlOO7w==
X-Google-Smtp-Source: ABdhPJxjROoU61QBEa6QDpH9l7ZSa9Wuo2kqW4KQ5DnUb06qClsiHK4GXPxrZljd/AzSQZishvfxqaGh4IGzWcMeaUM=
X-Received: by 2002:a5e:de46:: with SMTP id e6mr11428803ioq.62.1635175276512;
 Mon, 25 Oct 2021 08:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211021062819.1313964-1-davidgow@google.com> <CAGS_qxoBhfaE7NLzKWrsxwwz9BFeLRzb9Ycc-6U29pmtceqCTQ@mail.gmail.com>
 <CABVgOS=vbqNnc_uW9czL6+vD55+XVa0X+=VPH+Tz0nGg0EF2gA@mail.gmail.com> <CAGS_qxqVWSTPdNs4AedPdHwj_QqUTi5JML4284FQDgD4CRoXHw@mail.gmail.com>
In-Reply-To: <CAGS_qxqVWSTPdNs4AedPdHwj_QqUTi5JML4284FQDgD4CRoXHw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 25 Oct 2021 08:21:05 -0700
Message-ID: <CAGS_qxq=MO_f3Nsm8VbXj5WOu5dPNbj4yeNHwAfZxxVyNgCszw@mail.gmail.com>
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

On Fri, Oct 22, 2021 at 3:41 PM Daniel Latypov <dlatypov@google.com> wrote:
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

Actually, when I tried to pass in an empty parameter array, I get a segfault.
So I guess we *do* let the user know somehow :)

The root cause: we call test_case->run_case(test), but the
test->param_value == NULL.
So the test code will segfault whenever it tries to read from param_value.

A hacky fix:

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 85265f9a66a1..e55f842ae355 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -513,6 +513,8 @@ int kunit_run_tests(struct kunit_suite *suite)
                }

                do {
+                       if (test_case->generate_params && !test.param_value)
+                               break;  // there were no parameters generated!
                        kunit_run_case_catch_errors(suite, test_case, &test);

                        if (test_case->generate_params) {

> Should it be an error/warning? Maybe not, but wouldn't it be better to
> report SKIPPED?
> (This would require a change in KUnit on the kernel side, I'm not
> suggesting we do this in the parser)

Being a bit more concrete, I was originally thinking of the following:

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 85265f9a66a1..3f7141a72308 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -537,6 +537,9 @@ int kunit_run_tests(struct kunit_suite *suite)

                } while (test.param_value);

+               if (param_stats.total == 0)
+                       test_case->status = KUNIT_SKIPPED;
+
                kunit_print_test_stats(&test, param_stats);

                kunit_print_ok_not_ok(&test, true, test_case->status,

But tacking onto the hacky fix above, it could look like

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 85265f9a66a1..a2d93b44ef88 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -513,6 +513,13 @@ int kunit_run_tests(struct kunit_suite *suite)
                }

                do {
+                       if (test_case->generate_params && !test.param_value) {
+                               strncpy(test.status_comment,"No test
parameters generated",
+                                       sizeof(test.status_comment));
+                               test_case->status = KUNIT_SKIPPED;
+                               break;
+                       }
+
                        kunit_run_case_catch_errors(suite, test_case, &test);

                        if (test_case->generate_params) {




>
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
