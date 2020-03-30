Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98313198478
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Mar 2020 21:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgC3TaY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Mar 2020 15:30:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52484 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgC3TaY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Mar 2020 15:30:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id z18so92597wmk.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Mar 2020 12:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nFnsvCKEDa/dsrzABSlGZiV3kPYg9feDGQT4TvurVU=;
        b=iBPtY4oepJEYkAvfRbbU7YRMUkFv1yqWuCpQX+pO9q8Omi5rOKQc/eVaGFAxJxFQfm
         G/XsQyuRqsBi4xUZfsYl0K+KNbGv8FTuQS1ezJjT5wCHOfzcicUvf+FtSLPJv+HPYavJ
         oLc+Iwef89iiAd822jVW2YM+RKZqSibiH2B594aB100wzEAcU7dwi7Z2aaMHIwYC9HlC
         tQwEPLdFfNrlkZak7jRrGq5UMRvkDDiU2xwTL+iYlX+u7xQUbg0RwjfKqn8SCpE7ktnE
         PXWYxhv4RX881mw9lG9i3OmMJMqpZTNlV8PIqJSXuFQy14AuRnJgGOAd5ISVlsQ06mnL
         vNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nFnsvCKEDa/dsrzABSlGZiV3kPYg9feDGQT4TvurVU=;
        b=falaEvaVxrA/i3JE/I4dZvSuhFX6tAWApT5DkC6nqnZlaAy7Or9m8Wq6Gx78/RktxB
         U00FSlF1tfB0qswEbYIAbvR3qFEywbKnBhbvG4117S8nHY4W6BLwguq1csg6KEokCpE2
         HLAf+pKclj4yhkEzBby0LYH7jZrz2WnOooFulyKIxsTIqE1XVewO8U6gEYTiP/PeIa8T
         q6qWI6UVJN524kVGbPN0WjrxXfUHBGVXItg4ELMefQb7SrHMaj6jy0zbPgNvvgugNQeD
         uJ/jkR8wlZrmz9bFXyzILHXtgtQTrVGt1fjpDH9LuvHNZC170HNKRqrAx40Vi3j3VknO
         KFUg==
X-Gm-Message-State: ANhLgQ2m2KBTu9i0gxg0P6SwRu3T9a0dY2Eqr8yeVhZLMvcxuQ9xJ+Do
        YeGzWZwX9p6xTw5cYE6t47xdrgsc981hkCZZheJRwg==
X-Google-Smtp-Source: ADFU+vsp/RyP5+g1X+akjm3lY9xfjCPnWJSUBQHvVMhHBYSUUyMlFlOMzxwaJ1q/Tx7niyWdi91yGz1x7sGCyvLs9ms=
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr865008wmb.112.1585596621197;
 Mon, 30 Mar 2020 12:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
 <20200319164227.87419-2-trishalfonso@google.com> <alpine.LRH.2.21.2003241635230.30637@localhost>
 <CAKFsvULUx3qi_kMGJx69ndzCgq=m2xf4XWrYRYBCViud0P7qqA@mail.gmail.com>
 <alpine.LRH.2.21.2003251242200.9650@localhost> <CAKFsvU+1z-oAX81bNSVkuo_BwgxyykTwW9uJOLL6a1ZaBojJYw@mail.gmail.com>
In-Reply-To: <CAKFsvU+1z-oAX81bNSVkuo_BwgxyykTwW9uJOLL6a1ZaBojJYw@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Mon, 30 Mar 2020 12:30:09 -0700
Message-ID: <CAKFsvUKAThbewNmtA7S4wzXODADwG5XJgiDu9o2o5+xz5ux5fA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] Add KUnit Struct to Current Task
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 25, 2020 at 12:00 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> On Wed, Mar 25, 2020 at 5:42 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> >
> > On Tue, 24 Mar 2020, Patricia Alfonso wrote:
> >
> > > On Tue, Mar 24, 2020 at 9:40 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > >
> > > >
> > > > On Thu, 19 Mar 2020, Patricia Alfonso wrote:
> > > >
> > > > > In order to integrate debugging tools like KASAN into the KUnit
> > > > > framework, add KUnit struct to the current task to keep track of the
> > > > > current KUnit test.
> > > > >
> > > > > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > > > > ---
> > > > >  include/linux/sched.h | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > index 04278493bf15..1fbfa0634776 100644
> > > > > --- a/include/linux/sched.h
> > > > > +++ b/include/linux/sched.h
> > > > > @@ -1180,6 +1180,10 @@ struct task_struct {
> > > > >       unsigned int                    kasan_depth;
> > > > >  #endif
> > > > >
> > > > > +#if IS_BUILTIN(CONFIG_KUNIT)
> > > >
> > > > This patch set looks great! You might have noticed I
> > > > refreshed the kunit resources stuff to incorporate
> > > > feedback from Brendan, but I don't think any API changes
> > > > were made that should have consequences for your code
> > > > (I'm building with your patches on top to make sure).
> > > > I'd suggest promoting from RFC to v3 on the next round
> > > > unless anyone objects.
> > > >
> > > > As Dmitry suggested, the above could likely be changed to be
> > > > "#ifdef CONFIG_KUNIT" as kunit can be built as a
> > > > module also. More on this in patch 2..
> > > >
> > > I suppose this could be changed so that this can be used in possible
> > > future scenarios, but for now, since built-in things can't rely on
> > > modules, the KASAN integration relies on KUnit being built-in.
> > >
> >
> > I think we can get around that. I've tried tweaking the resources
> > patchset such that the functions you need in KASAN (which
> > is builtin) are declared as "static inline" in include/kunit/test.h;
> > doing this allows us to build kunit and test_kasan as a
> > module while supporting the builtin functionality required to
> > retrieve and use kunit resources within KASAN itself.
> >
> Okay, great!
>
> > The impact of this amounts to a few functions, but it would
> > require a rebase of your changes. I'll send out a  v3 of the
> > resources patches shortly; I just want to do some additional
> > testing on them. I can also send you the modified versions of
> > your patches that I used to test with.
> >
> That sounds good.
>
> > With these changes I can run the tests on baremetal
> > x86_64 by modprobe'ing test_kasan. However I see a few failures:
> >
> > [   87.577012]  # kasan_memchr: EXPECTATION FAILED at lib/test_kasan.c:509
> >         Expected kasan_data->report_expected == kasan_data->report_found,
> > but
> >                 kasan_data->report_expected == 1
> >                 kasan_data->report_found == 0
> > [   87.577104]  not ok 30 - kasan_memchr
> > [   87.603823]  # kasan_memcmp: EXPECTATION FAILED at lib/test_kasan.c:523
> >         Expected kasan_data->report_expected == kasan_data->report_found,
> > but
> >                 kasan_data->report_expected == 1
> >                 kasan_data->report_found == 0
> > [   87.603929]  not ok 31 - kasan_memcmp
> > [   87.630644]  # kasan_strings: EXPECTATION FAILED at
> > lib/test_kasan.c:544
> >         Expected kasan_data->report_expected == kasan_data->report_found,
> > but
> >                 kasan_data->report_expected == 1
> >                 kasan_data->report_found == 0
> > [   87.630910]  # kasan_strings: EXPECTATION FAILED at
> > lib/test_kasan.c:546
> >         Expected kasan_data->report_expected == kasan_data->report_found,
> > but
> >                 kasan_data->report_expected == 1
> >                 kasan_data->report_found == 0
> > [   87.654037]  # kasan_strings: EXPECTATION FAILED at
> > lib/test_kasan.c:548
> >         Expected kasan_data->report_expected == kasan_data->report_found,
> > but
> >                 kasan_data->report_expected == 1
> >                 kasan_data->report_found == 0
> > [   87.677179]  # kasan_strings: EXPECTATION FAILED at
> > lib/test_kasan.c:550
> >         Expected kasan_data->report_expected == kasan_data->report_found,
> > but
> >                 kasan_data->report_expected == 1
> >                 kasan_data->report_found == 0
> > [   87.700242]  # kasan_strings: EXPECTATION FAILED at
> > lib/test_kasan.c:552
> >         Expected kasan_data->report_expected == kasan_data->report_found,
> > but
> >                 kasan_data->report_expected == 1
> >                 kasan_data->report_found == 0
> > [   87.723336]  # kasan_strings: EXPECTATION FAILED at
> > lib/test_kasan.c:554
> >         Expected kasan_data->report_expected == kasan_data->report_found,
> > but
> >                 kasan_data->report_expected == 1
> >                 kasan_data->report_found == 0
> > [   87.746304]  not ok 32 - kasan_strings
> >
> > The above three tests consistently fail while everything
> > else passes, and happen irrespective of whether kunit
> > is built as a module or built-in.  Let me know if you
> > need any more info to debug (I built the kernel with
> > CONFIG_SLUB=y if that matters).
> >
> Unfortunately, I have not been able to replicate this issue and I
> don't have a clue why these specific tests would fail with a different
> configuration. I've tried running these tests on UML with KUnit
> built-in with SLUB=y and SLAB=y, and I've done the same in x86_64. Let
> me know if there's anything else that could help me debug this myself.
>
Alan sent me the .config and I was able to replicate the test failures
found above. I traced the problem config to CONFIG_AMD_MEM_ENCRYPT=y.
The interesting part is that I ran the original test module with this
config enabled and the same tests failed there too. I wonder if this
is an expected failure or something in the test that is causing this
problem?

>
> > Thanks!
> >
> > Alan
> >
> >
> > > > > +     struct kunit                    *kunit_test;
> > > > > +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> > > > > +
> > > > >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > > > >       /* Index of current stored address in ret_stack: */
> > > > >       int                             curr_ret_stack;
> > > > > --
> > > > > 2.25.1.696.g5e7596f4ac-goog
> > > > >
> > > > >
> > >
> > > --
> > > Best,
> > > Patricia
> > >
>
>
>
> --
> Best,
> Patricia
