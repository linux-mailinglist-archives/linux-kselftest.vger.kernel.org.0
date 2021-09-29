Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF10641CAB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 18:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbhI2Q5d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbhI2Q5c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 12:57:32 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B31C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 09:55:51 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id b12so3580476ilf.11
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9u7CdhA82OTxhiNjh8zFGVUr+YVkwKJl8XJaXfF7/w=;
        b=BHqBuXTTFAG0/Uo7tjBlKpHuoamjjqMPc9oxmBVteM1aCxv7dKtXvyjmCRWf7zCP8X
         ZmUwHnNtF6Q5FQa571WYQktvZeuOU2nw8yyBgXa6dci8toUuKUVBrPxaibQ59riRmCWl
         tIs25tTza3WOJE+q41ZAx5LswjcIcnjCEgM5JT8ifUc5Yyd2FUuEsIVo2QwTH9/f/vt9
         NxXTFqKx3fIuHtJwJkmcP4QMsLjCstXef24T00HX8+384TGPSNVHaIo+IObKZxOSzMfq
         DEBmrVi7U49wa81q9knGq4MJJZbqbB8mGQ1kvgqS+TJYjjnbRG1Pvt12IVaeajkOZmjH
         H+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9u7CdhA82OTxhiNjh8zFGVUr+YVkwKJl8XJaXfF7/w=;
        b=Y81of3XI6o9X9pgpdSe6tR+CPiGJ751j7ivs62gPkQOhq76KAUxlz5MAvt5yq9KH+x
         Lgoz1RhDOtr7hFJGbhghjD9E3tx4rqSYc+aamDJlQhcvYJnZXzn0MkVwNDMVOv2LXIWw
         xXsNvthxeK/s9PiNaHMfiwFu+cEtX/09uEklB6dsQkohjSl3acxgudByHgkjDbH8SQbq
         Ve3hmYQcRmC8b3Zr+EH/GxsPcuOiFMFkctSC72Q/eV5e01pnGOgrxgr2zioBfran8y5L
         0lGyWvIQBufcGW+JQNW3pn5vjInQcL13s3w0AqQJQrD8vJEwpGapM/Vy7AlTRu46j4oc
         o1ag==
X-Gm-Message-State: AOAM532TkHD8HyMcW70EfiZZlt8KKr8rvlsqDO5eXGbfwxYumKCmuMoR
        hpa/ihtzaEwLlHXJ/Fnsk2o5oFyn6TBRGtW5jf5uvQ==
X-Google-Smtp-Source: ABdhPJz7UcccOWEBaJmnPyOL9Nqa48Gmrl5N34vyOIihW623wH6slZbZVT6p4sSRqjOgbCjRqwCBDAmEwoVesgG/hP4=
X-Received: by 2002:a92:b301:: with SMTP id p1mr539248ilh.10.1632934550387;
 Wed, 29 Sep 2021 09:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210928222926.1180749-1-dlatypov@google.com> <20210928222926.1180749-2-dlatypov@google.com>
 <CABVgOSmbROsRBgA+rfJGwTcsFCmgUmrEgLLVxxr7A-EKLvcj_Q@mail.gmail.com>
In-Reply-To: <CABVgOSmbROsRBgA+rfJGwTcsFCmgUmrEgLLVxxr7A-EKLvcj_Q@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 29 Sep 2021 09:55:38 -0700
Message-ID: <CAGS_qxpDACGJ=sW7-3ivVw5X92K7rrmoiLyj+SS-OdvGg0i1rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kunit: add 'kunit.action' param to allow listing
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

On Tue, Sep 28, 2021 at 9:38 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, Sep 29, 2021 at 6:29 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Context:
> > It's difficult to map a given .kunitconfig => set of enabled tests.
> > Letting kunit.py figure that out would be useful.
> >
> > This patch:
> > * is intended to be an implementation detail used only by kunit.py
> > * adds a kunit.action module param with one valid non-null value, "list"
> > * for the "list" action, it simply prints out "<suite>.<test>"
> > * leaves the kunit.py changes to make use of this for another patch.
> >
> > Note: kunit.filter_glob is respected for this and all future actions.
> >
> > Hack: we print a TAP header and fake test plan to allow kunit.py to
> > use the same code to pick up KUnit output that it does for normal tests.
> > Since this is intended to be an implementation detail, it seems fine for
> > now. Maybe in the future we ouptut each test as SKIPPED or the like.
>
> I'm still a little uneasy using the "TAP version 14" header here, and
> then proceeding to include a list of tests which, in and of itself,
> isn't valid TAP.
> I don't think we need to solve this perfectly now: we can always
> change it if something comes out of, e.g., the KTAP standardisation,
> but I'd rather we have something -- even something temporary -- which
> is easily distinguishable from an actual TAP result.
>
> Even if we had "TAP version 14 - test list" or something so that

Currently, the regex kunit_parser.py uses is anchored with $.
So I'm not able to add anything at the end of the line.

We could potentially add a new line afterwards with "# KUnit Test
List" or similar?

I'd prefer not to since I'm not sure it matters _too_ much.
Someone would have to go out of their way to print the list of tests,
and if so, I'm not sure they should be trying to parse TAP output from
it.

> kunit_tool picked up on it without further changes, that'd be fine,
> though something like "KUnit Test List" would be better.
>
> Also, I'd still rather we lose the "1..1" test suite list, though I
> can live without if I have to, given that it is actually giving the
> correct number of suites.
>
> From the kernel side, all this should take is replacing the call to
> kunit_print_tap_header() with a direct pr_info() call. Maybe there'd
> need to be some minor kunit_tool changes in patch 3, too, but nothing
> excessive.

That's fair. I had mainly just wanted to avoid hard-copying a copy of
the TAP version.

I've made the change so it doesn't print the test plan and it works.

The only change needed in patch 3 is
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e7b92caba53d..ca4f877234c2 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -101,8 +101,7 @@ def _list_tests(linux:
kunit_kernel.LinuxSourceTree, request: KunitExecRequest)
                           filter_glob=request.filter_glob,
                           build_dir=request.build_dir)
        output = kunit_parser.extract_tap_lines(output)
-       # Hack! Drop the TAP version header and top-level test plan.
-       output.pop()
+       # Hack! Drop the dummy TAP version header that the executor prints out.
        output.pop()
        return list(output)

>
> Also, nit: "ouptut" should be "output"

Ah, fixed.

> >
> > Go with a more generic "action" param, since it seems like we might
> > eventually have more modes besides just running or listing tests, e.g.
> > * perhaps a benchmark mode that reruns test cases and reports timing
> > * perhaps a deflake mode that reruns test cases that failed
> > * perhaps a mode where we randomize test order to try and catch
> >   hermeticity bugs like "test a only passes if run after test b"
> >
> > Tested:
> > $ ./tools/testing/kunit/kunit.py run --kernel_arg=kunit.action=list --raw_output=kunit
> > ...
> > TAP version 14
> > 1..1
> > example.example_simple_test
> > example.example_skip_test
> > example.example_mark_skipped_test
> > reboot: System halted
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Otherwise, I'm quite happy with this: it works well on my end, and the
> implementation makes sense.
>
> So this is:
> Reviewed-by: David Gow <davidgow@google.com>
>
> (But I'd rather the TAP header bit change if possible...)
>
> -- David
>
> >  lib/kunit/executor.c | 45 +++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 40 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index bab3ab940acc..8b38c91b4fac 100644
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
> >                 "Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
> > +module_param_named(action, action_param, charp, 0);
> > +MODULE_PARM_DESC(action,
> > +                "Changes KUnit executor behavior, valid values are:\n"
> > +                "<none>: run the tests like normal\n"
> > +                "'list' to list test names instead of running them.\n");
> >
> >  /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
> >  struct kunit_test_filter {
> > @@ -196,9 +203,35 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
> >         pr_info("1..%d\n", num_of_suites);
> >  }
> >
> > -int kunit_run_all_tests(void)
> > +static void kunit_exec_run_tests(struct suite_set *suite_set)
> >  {
> >         struct kunit_suite * const * const *suites;
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
>
> As noted, would rather this be something like
> pr_info("KUnit Test List");
>
>
> > +
> > +       for (suites = suite_set->start; suites < suite_set->end; suites++)
> > +               for (i = 0; (*suites)[i] != NULL; i++) {
> > +                       kunit_suite_for_each_test_case((*suites)[i], test_case) {
> > +                               pr_info("%s.%s\n", (*suites)[i]->name, test_case->name);
> > +                       }
> > +               }
> > +}
> > +
> > +int kunit_run_all_tests(void)
> > +{
> >         struct suite_set suite_set = {
> >                 .start = __kunit_suites_start,
> >                 .end = __kunit_suites_end,
> > @@ -207,10 +240,12 @@ int kunit_run_all_tests(void)
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
> >                 kunit_free_suite_set(suite_set);
> > --
> > 2.33.0.685.g46640cef36-goog
> >
