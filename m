Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C833EA979
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Aug 2021 19:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhHLRbR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Aug 2021 13:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhHLRbO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Aug 2021 13:31:14 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE2C061756
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Aug 2021 10:30:49 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r72so9464272iod.6
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Aug 2021 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bU1TEUKnSS2Vb5WitiqttPECUCgD2Zox5kX0NxOhxs=;
        b=GgYERin3f6czP7m1aj3Pzmd5a5FhEu2VzwdjijONGPqsVxgP4epz62VObPzK2f5DfA
         MnYE1v9kLBrJwNlyHPBgPHWfn9CNBP4TJdCb7Vl+bgWFqrd0B/eUooITqfiXdTCVUahS
         YA0gETJRL9e+wzRY67xgtJz8kwwDJ0QWAIKivF1PQ9MWrGBFjOHT7d3Wei4WHwZdXVXG
         LkR5d5OaV//FfM0nk2+0lzREYcjyhd1YIokAEoEluka6MJ8Ut0eDDRt4g+M5kpIjU/GK
         C8sX2xEHKcjw3yLbQFv4AdwYNGY4BiXLWxUDn2Yj0fVIp62fs291s1xWU+RUQjYeudU3
         V2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bU1TEUKnSS2Vb5WitiqttPECUCgD2Zox5kX0NxOhxs=;
        b=nEUxNveyiBaoxbbQg/f9gHPRSO5BjWbIoQVJRHETrazxuTEYuoEc+DVsRgcrtdE4SF
         HTWyeUel7i/UapNMSKsWr5Cm7am9YzZVP7Knb+t3fnZvwCtanQ79Q4DU5hxw57SgLLqt
         LXxWw/g5bybci9hpOEFAROGfFGviotXw1XO9hYoiAKJOwBA4+vDbjN+OcLYxonQf4r93
         HsHAAvJJnpFlIYxjNCz5408J35rVmo8PK2y/oURmvvuYZLqMCxHHmoJJD/zsSHO6SRaH
         ELnELWxz+UX6Un1JGxBKrD3CVUbR84Wrmj/2n+OmEcPfYv0bdeDwpqyNwGjvbZnFdsMr
         QHqQ==
X-Gm-Message-State: AOAM531VvYCqyQAzK0mfaZPr80eH9OJ32M/oY5ZWT09d8mA+cZcLbVr3
        GDYsSKw8W7MjmpJZa/QZAFW2YmuwlLBmrS5xEIa96g==
X-Google-Smtp-Source: ABdhPJxf+4hkz4MdlAPctqxAB/dvL35GV9zmiToS7vB9pdow7QCCHr/qplf9lz+N4YHFRA5gtT87tfLTmzN6oUqJW3c=
X-Received: by 2002:a05:6638:11cd:: with SMTP id g13mr4544213jas.66.1628789448695;
 Thu, 12 Aug 2021 10:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210805235145.2528054-1-dlatypov@google.com> <20210805235145.2528054-2-dlatypov@google.com>
 <CABVgOSmoNaYVcckw3PX7Cf32NjYPSpX3JqGESCqYJvTi6dwAsQ@mail.gmail.com>
In-Reply-To: <CABVgOSmoNaYVcckw3PX7Cf32NjYPSpX3JqGESCqYJvTi6dwAsQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 12 Aug 2021 10:30:37 -0700
Message-ID: <CAGS_qxqJ9TNbyKg2B2XP75VSBnvCyL+Xbz=TUGNOuHkEoCgGjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: add 'kunit.action' param to allow listing
 out tests
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

On Thu, Aug 12, 2021 at 12:09 AM David Gow <davidgow@google.com> wrote:
>
> On Fri, Aug 6, 2021 at 7:51 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Context:
> > It's difficult to map a given .kunitconfig => set of enabled tests.
> >
> > Having a standard, easy way of getting the list could be useful in a
> > number of ways. For example, if we also extended kunit.filter_glob to
> > allow filtering on tests, this would allow users to run tests cases one
> > by one if they wanted to debug hermeticity issues.
> >
> > This patch:
> > * adds a kunit.action module param with one valid non-null value, "list"
> > * for the "list" action, it simply prints out "<suite>.<test>"
> > * does not itself introduce kunit.py changes to make use of this [1].
>
> I really like this feature, and could live with the implementation,
> but do feel like we should probably have a more detailed idea of how
> the kunit_tool changes are going to work before settling on it for
> sure.
>
> In particular, is the "<suite>.<test>" format the best way of giving
> test information, or do we want something more (K)TAP-like. (e.g., a
> test hierarchy with all tests marked SKIPed, or otherwise limited in
> some way). Maybe that'd allow some of the parser code to be re-used,
> and have fewer issues with having two separate ways of representing
> the test hierarchy. (What if, e.g., there were test or suite names
> with '.' in them?)
>
> On the other hand, this format does make it easier to use the
> filter_glob stuff, so it could go either way...

Yeah, the main point of this is to be consistent with filter_glob and
test-level filtering.
If we can come up with a more generic, "TAP-like" identifier for
tests, we could use that for here and for filtering.

Using "suite.test" seems to be relatively standard, hence why I've
gone with that for both.
E.g. in python:
https://docs.python.org/3/library/unittest.html#command-line-interface

$ python -m unittest test_module.TestClass.test_method

Though I've only ever used that without "test_module" as

$ ./tools/testing/kunit/kunit_tool_test.py KconfigTest
...
----------------------------------------------------------------------
Ran 3 tests in 0.001s

OK
$ ./tools/testing/kunit/kunit_tool_test.py KconfigTest.test_is_subset_of
.
----------------------------------------------------------------------
Ran 1 test in 0.001s

OK

So I'd really prefer we stick with the current format, tbh.

>
> > Note: kunit.filter_glob is respected for this and all future actions.
> > Note: we need a TAP header for kunit.py to isolate the KUnit output.
>
> I don't mind having a TAP header here, but we could either:
> (a) have a separate header for a test list, and have kunit_tool look
> for that as well, to avoid treating this as TAP when it isn't; or
> (b) try to standardise a "test list" format as part of KTAP:
> https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/

b. feels a bit overkill.

I agree it's very hacky.
I didn't want to mess around too much with the parser code while Rae
was working on it.

But we could change the parser code:
* `func extract_tap_lines()` => `func extract_kunit_lines()`
* kunit_start_re => `TAP...|KUNIT OTHER OUTPUT START MARKER`

and use that marker here.

I'm fine with adding a new marker, but I assumed we'd probably need to
spend a good amount of time bikeshedding what exactly this new header
would be :P
Whereas this works right now and is ugly in a way that I don't think
most people would notice.

>
> >
> > Go with a more generic "action" param, since it seems like we might
> > eventually have more modes besides just running or listing tests, e.g.
> > * perhaps a benchmark mode that reruns test cases and reports timing
> > * perhaps a deflake mode that reruns test cases that failed
> > * perhaps a mode where we randomize test order to try and catch
> >   hermeticity bugs like "test a only passes if run after test b"
> >
>
> The "action" parameter is fine by me. Do we want to give the default
> "run" action a name as well as making it the default?

I originally did that, but then realized we'd probably never use an
explicit "run" action ever.
I've added it back in locally and will include it in a v2.

>
> > Tested:
> > $ ./tools/testing/kunit/kunit.py run --kernel_arg=kunit.action=list --raw_output=kunit
> > ...
> > TAP version 14
> > 1..1
>
> I really don't like the test plan line combined with the
> "<suite>.<test>" format, particularly since this example notes that
> there's only one test (presumably the suite), and then proceeds to
> have three top-level things afterwards. It seems pretty misleading to
> me.
>
> > example.example_simple_test
> > example.example_skip_test
> > example.example_mark_skipped_test
> > reboot: System halted
> >
> > [1] The interface for this can work in a few ways. We could add a
> > --list_tests flag or a new subcommand. But this change is enough to
> > allow people to split each suite into its own invocation, e.g. via a
> > short script like:
> >
> >   #!/bin/bash
> >
> >   cd $(git rev-parse --show-toplevel)
> >
> >   for suite in $(
> >     ./tools/testing/kunit/kunit.py run --kernel_args=kunit.action=list --raw_output=kunit |
> >     sed -n '/^TAP version/,$p' | grep -P -o '^[a-z][a-z0-9_-]+\.' | tr -d '.' | sort -u);
> >   do
> >     ./tools/testing/kunit/kunit.py run "${suite}"
> >   done
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> > v1 -> v2: write about potential other "actions" in commit desc.
> > ---
> >  lib/kunit/executor.c | 46 +++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 41 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index acd1de436f59..77d99ee5ed64 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -15,9 +15,16 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
> >  #if IS_BUILTIN(CONFIG_KUNIT)
> >
> >  static char *filter_glob_param;
> > +static char *action_param;
> > +
> >  module_param_named(filter_glob, filter_glob_param, charp, 0);
> >  MODULE_PARM_DESC(filter_glob,
> > -               "Filter which KUnit test suites run at boot-time, e.g. list*");
> > +                "Filter which KUnit test suites run at boot-time, e.g. list*");
> > +module_param_named(action, action_param, charp, 0);
> > +MODULE_PARM_DESC(action,
> > +                "Changes KUnit executor behavior, valid values are:\n"
> > +                "<none>: run the tests like normal\n"
> > +                "'list' to list test names instead of running them.\n");
> >
> >  static char *kunit_shutdown;
> >  core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> > @@ -109,6 +116,33 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
> >         pr_info("1..%d\n", num_of_suites);
> >  }
> >
> > +static void kunit_exec_run_tests(struct suite_set *suite_set)
> > +{
> > +       struct kunit_suite * const * const *suites;
> > +
> > +       kunit_print_tap_header(suite_set);
> > +
> > +       for (suites = suite_set->start; suites < suite_set->end; suites++)
> > +               __kunit_test_suites_init(*suites);
> > +}
> > +
> > +static void kunit_exec_list_tests(struct suite_set *suite_set)
> > +{
> > +       unsigned int i;
> > +       struct kunit_suite * const * const *suites;
> > +       struct kunit_case *test_case;
> > +
> > +       /* Hack: print a tap header so kunit.py can find the start of KUnit output. */
> > +       kunit_print_tap_header(suite_set);
> > +
> > +       for (suites = suite_set->start; suites < suite_set->end; suites++)
> > +               for (i = 0; (*suites)[i] != NULL; i++) {
> > +                       kunit_suite_for_each_test_case((*suites)[i], test_case) {
> > +                               pr_info("%s.%s\n", (*suites)[i]->name, test_case->name);
> > +                       }
> > +               }
> > +}
> > +
> >  int kunit_run_all_tests(void)
> >  {
> >         struct kunit_suite * const * const *suites;
> > @@ -120,10 +154,12 @@ int kunit_run_all_tests(void)
> >         if (filter_glob_param)
> >                 suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
> >
> > -       kunit_print_tap_header(&suite_set);
> > -
> > -       for (suites = suite_set.start; suites < suite_set.end; suites++)
> > -               __kunit_test_suites_init(*suites);
> > +       if (!action_param)
> > +               kunit_exec_run_tests(&suite_set);
> > +       else if (strcmp(action_param, "list") == 0)
> > +               kunit_exec_list_tests(&suite_set);
> > +       else
> > +               pr_err("kunit executor: unknown action '%s'\n", action_param);
> >
> >         if (filter_glob_param) { /* a copy was made of each array */
> >                 for (suites = suite_set.start; suites < suite_set.end; suites++)
> > --
> > 2.32.0.605.g8dce9f2422-goog
> >
