Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055C11930C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 20:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCYTA5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 15:00:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44080 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCYTA5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 15:00:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id m17so4569177wrw.11
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Mar 2020 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+glaYb/lBngljiO0dwm1DyooyffnH+1NHphBxBjNzNA=;
        b=Kp/K7lRBVTAHwFSPuzp6rZnN2KkNCQYYAwoof4o19wkr8RpublKATneIaEZN4bpKnO
         pdmyA8mTawMKEit44EouBINbyicWf2NJOgfgvunXeYsBfKuCKEBlnb9EGWv25Fk5Xy2c
         AtlB6daaqKwvaHB765QYvyRaWLuf7OsWRiYuTuOHd+WbS1BhlUFtPRd6VoEIyGyjjPPl
         tAJyJULoZEHre0mch62kxea/iMtMRoTwIGVewaTTgC2fR82fMy6Uu7lCJKmnBaRX+7Fr
         PH+wqpFPFN+CvojoutA0DFg03JvHV+3ugw9nSL1PQckd9E21qKFTtwGlUXfw4SFZdJOd
         qniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+glaYb/lBngljiO0dwm1DyooyffnH+1NHphBxBjNzNA=;
        b=OLb04yCxXD212KYHq0j2sIA/AUE+1aES8ERMS1rk+7xUglysuTj5a3c75LP4t2SMTH
         2yHDWZRXCKgkrSvZi2KvXDmOGFyi1SymZZuhbS1AAZOo2cSPeoywy4feHFZITSXk0IfK
         t7ONd4XZiavVB0FgYkBill9N0x8zLMOCuUhqabHD6JlrFagbRIbA5u3P1tu3nLZX3uiW
         ilhdJU1epOKSFTC8lNGmHWeI0npEo7m2IZCGfpeOUHm65cur7Yl+ak2cZirvseRM8sji
         cBWisgbCE9V10WZ7N2VDAcQ0JeL3IQrhQua4z7dKsN/qZnGwBBnSQ36w7d9Niruv20Bj
         hBPg==
X-Gm-Message-State: ANhLgQ1m0PqfXUfeS7RftS40xTzsAFoYmvdv5OWw+xVPHIhH2Ia6WUnx
        upf5bYr+BdjRlD5krzkoOPVeTWOTBK7VvAnTf5zyyA==
X-Google-Smtp-Source: ADFU+vuVVY6LgLPa+wBvr3enETxOfTw/hoHXiw2mtlWFrKz2VWFzrg5rMS0ewHyb+r6pJ1DrAvH1A+WgoY6vCsaQgqw=
X-Received: by 2002:adf:fb0a:: with SMTP id c10mr4937818wrr.272.1585162853207;
 Wed, 25 Mar 2020 12:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
 <20200319164227.87419-2-trishalfonso@google.com> <alpine.LRH.2.21.2003241635230.30637@localhost>
 <CAKFsvULUx3qi_kMGJx69ndzCgq=m2xf4XWrYRYBCViud0P7qqA@mail.gmail.com> <alpine.LRH.2.21.2003251242200.9650@localhost>
In-Reply-To: <alpine.LRH.2.21.2003251242200.9650@localhost>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Wed, 25 Mar 2020 12:00:41 -0700
Message-ID: <CAKFsvU+1z-oAX81bNSVkuo_BwgxyykTwW9uJOLL6a1ZaBojJYw@mail.gmail.com>
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

On Wed, Mar 25, 2020 at 5:42 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
>
> On Tue, 24 Mar 2020, Patricia Alfonso wrote:
>
> > On Tue, Mar 24, 2020 at 9:40 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > >
> > > On Thu, 19 Mar 2020, Patricia Alfonso wrote:
> > >
> > > > In order to integrate debugging tools like KASAN into the KUnit
> > > > framework, add KUnit struct to the current task to keep track of the
> > > > current KUnit test.
> > > >
> > > > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > > > ---
> > > >  include/linux/sched.h | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > index 04278493bf15..1fbfa0634776 100644
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -1180,6 +1180,10 @@ struct task_struct {
> > > >       unsigned int                    kasan_depth;
> > > >  #endif
> > > >
> > > > +#if IS_BUILTIN(CONFIG_KUNIT)
> > >
> > > This patch set looks great! You might have noticed I
> > > refreshed the kunit resources stuff to incorporate
> > > feedback from Brendan, but I don't think any API changes
> > > were made that should have consequences for your code
> > > (I'm building with your patches on top to make sure).
> > > I'd suggest promoting from RFC to v3 on the next round
> > > unless anyone objects.
> > >
> > > As Dmitry suggested, the above could likely be changed to be
> > > "#ifdef CONFIG_KUNIT" as kunit can be built as a
> > > module also. More on this in patch 2..
> > >
> > I suppose this could be changed so that this can be used in possible
> > future scenarios, but for now, since built-in things can't rely on
> > modules, the KASAN integration relies on KUnit being built-in.
> >
>
> I think we can get around that. I've tried tweaking the resources
> patchset such that the functions you need in KASAN (which
> is builtin) are declared as "static inline" in include/kunit/test.h;
> doing this allows us to build kunit and test_kasan as a
> module while supporting the builtin functionality required to
> retrieve and use kunit resources within KASAN itself.
>
Okay, great!

> The impact of this amounts to a few functions, but it would
> require a rebase of your changes. I'll send out a  v3 of the
> resources patches shortly; I just want to do some additional
> testing on them. I can also send you the modified versions of
> your patches that I used to test with.
>
That sounds good.

> With these changes I can run the tests on baremetal
> x86_64 by modprobe'ing test_kasan. However I see a few failures:
>
> [   87.577012]  # kasan_memchr: EXPECTATION FAILED at lib/test_kasan.c:509
>         Expected kasan_data->report_expected == kasan_data->report_found,
> but
>                 kasan_data->report_expected == 1
>                 kasan_data->report_found == 0
> [   87.577104]  not ok 30 - kasan_memchr
> [   87.603823]  # kasan_memcmp: EXPECTATION FAILED at lib/test_kasan.c:523
>         Expected kasan_data->report_expected == kasan_data->report_found,
> but
>                 kasan_data->report_expected == 1
>                 kasan_data->report_found == 0
> [   87.603929]  not ok 31 - kasan_memcmp
> [   87.630644]  # kasan_strings: EXPECTATION FAILED at
> lib/test_kasan.c:544
>         Expected kasan_data->report_expected == kasan_data->report_found,
> but
>                 kasan_data->report_expected == 1
>                 kasan_data->report_found == 0
> [   87.630910]  # kasan_strings: EXPECTATION FAILED at
> lib/test_kasan.c:546
>         Expected kasan_data->report_expected == kasan_data->report_found,
> but
>                 kasan_data->report_expected == 1
>                 kasan_data->report_found == 0
> [   87.654037]  # kasan_strings: EXPECTATION FAILED at
> lib/test_kasan.c:548
>         Expected kasan_data->report_expected == kasan_data->report_found,
> but
>                 kasan_data->report_expected == 1
>                 kasan_data->report_found == 0
> [   87.677179]  # kasan_strings: EXPECTATION FAILED at
> lib/test_kasan.c:550
>         Expected kasan_data->report_expected == kasan_data->report_found,
> but
>                 kasan_data->report_expected == 1
>                 kasan_data->report_found == 0
> [   87.700242]  # kasan_strings: EXPECTATION FAILED at
> lib/test_kasan.c:552
>         Expected kasan_data->report_expected == kasan_data->report_found,
> but
>                 kasan_data->report_expected == 1
>                 kasan_data->report_found == 0
> [   87.723336]  # kasan_strings: EXPECTATION FAILED at
> lib/test_kasan.c:554
>         Expected kasan_data->report_expected == kasan_data->report_found,
> but
>                 kasan_data->report_expected == 1
>                 kasan_data->report_found == 0
> [   87.746304]  not ok 32 - kasan_strings
>
> The above three tests consistently fail while everything
> else passes, and happen irrespective of whether kunit
> is built as a module or built-in.  Let me know if you
> need any more info to debug (I built the kernel with
> CONFIG_SLUB=y if that matters).
>
Unfortunately, I have not been able to replicate this issue and I
don't have a clue why these specific tests would fail with a different
configuration. I've tried running these tests on UML with KUnit
built-in with SLUB=y and SLAB=y, and I've done the same in x86_64. Let
me know if there's anything else that could help me debug this myself.


> Thanks!
>
> Alan
>
>
> > > > +     struct kunit                    *kunit_test;
> > > > +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> > > > +
> > > >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > > >       /* Index of current stored address in ret_stack: */
> > > >       int                             curr_ret_stack;
> > > > --
> > > > 2.25.1.696.g5e7596f4ac-goog
> > > >
> > > >
> >
> > --
> > Best,
> > Patricia
> >



--
Best,
Patricia
