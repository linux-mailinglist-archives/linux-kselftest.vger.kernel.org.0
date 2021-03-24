Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD9D347A69
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Mar 2021 15:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhCXOPi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Mar 2021 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbhCXOP2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Mar 2021 10:15:28 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BDEC0613E0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Mar 2021 07:15:27 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j17so12274386qvo.13
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Mar 2021 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZvbm9pmWdatUwvODu4QKBbBncw4Nm+3D4c7UW8iDYU=;
        b=qR67sYL0JjlICyPA8xRM7pna0dwh1lfO92PYIMGHLz16ttLPb2V+L8eydysv+fu774
         riRxCpmrfWrVN4XppJAqgxMOTJCQ8tVRvyGiT6CJ29+X2cxM+SZWrMeqc7gd+SbBhvYG
         ii25BkrEoJJffnP648Jsh6e9fiSiFCeg8Q87i9bWVVgyIOcMrmBisFDnn6+GwHrSxH6z
         y7BfxjzlK2phJO7aypGbKI2a3mKcTGyFK/pemU2+PcWiKR8ZoLMEYdABkdQNmvDfjE8a
         7rL3BLU8+v4iUGIHfikBOv8eL/I9EC7ltNHHeYbB7mLq3dF7hmH5FhWEz2lay2CTg4BS
         cYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZvbm9pmWdatUwvODu4QKBbBncw4Nm+3D4c7UW8iDYU=;
        b=QI/oTN9sGnVM/pu6wU30roGYjmY67o4VLJU3Z+kMI6lff8aqJfY+RlouC0W9AMEfk0
         qnEr64YHx4kC8AdX/OZQGW333yoxbusPuG7RSpkUaFcYDwPaHzzu/XCd7emIRzq9hBQE
         6uwjSnaSM8minp0lxebuf5c09/GqM20B7ySXPr0V6Xb0inV72wA2DOG4TucZUnFs0Es9
         LGTL4jBxEv+IbOEmwC+yGDyMNCYrG9qaO+0PrUnC/W7U40SgLSZVbc6qITIWlml+XSxb
         z6ygIuUQI1+pTcdpLLZ6beS4wzxWVzQbsPhtFmbDBQSh9uyYhDGS5zZahWaQDbiyQAIE
         mpjQ==
X-Gm-Message-State: AOAM533K7Wrh/EHRKqMjstuO9ECDAWBsnu5kPeGIp/IbHMMJCXcTsUkF
        eeVLg9bNfklaWFvZlsdRvcSvD9G+qwxaPusmjlTTaw==
X-Google-Smtp-Source: ABdhPJwX4Z6gku7c4J8y2QSL1MNzuv8ibu4631B424zir4iG+LBBm+Q0dwsfk+6oUMHCgh1gAFh2sUvQkD9oZZP3PsE=
X-Received: by 2002:ad4:50d0:: with SMTP id e16mr3524290qvq.37.1616595325859;
 Wed, 24 Mar 2021 07:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net> <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
 <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net> <YFtB+Ta9pkMg4C2h@hirez.programming.kicks-ass.net>
 <YFtF8tEPHrXnw7cX@hirez.programming.kicks-ass.net> <CANpmjNPkBQwmNFO_hnUcjYGM=1SXJy+zgwb2dJeuOTAXphfDsw@mail.gmail.com>
 <CACT4Y+aKmdsXhRZi2f3LsX3m=krdY4kPsEUcieSugO2wY=xA-Q@mail.gmail.com>
In-Reply-To: <CACT4Y+aKmdsXhRZi2f3LsX3m=krdY4kPsEUcieSugO2wY=xA-Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 Mar 2021 15:15:14 +0100
Message-ID: <CACT4Y+aRaNSaeWRA2H_q3k9+OpG0Lc3V7JWU8+whZ9s3gob-Kw@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on SIGTRAP
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 24, 2021 at 3:12 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Wed, 24 Mar 2021 at 15:01, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > One last try, I'll leave it alone now, I promise :-)
> >
> > This looks like it does what you suggested, thanks! :-)
> >
> > I'll still need to think about it, because of the potential problem
> > with modify-signal-races and what the user's synchronization story
> > would look like then.
>
> I agree that this looks inherently racy. The attr can't be allocated
> on stack, user synchronization may be tricky and expensive. The API
> may provoke bugs and some users may not even realize the race problem.
>
> One potential alternative is use of an opaque u64 context (if we could
> shove it into the attr). A user can pass a pointer to the attr in
> there (makes it equivalent to this proposal), or bit-pack size/type
> (as we want), pass some sequence number or whatever.

Just to clarify what I was thinking about, but did not really state:
perf_event_attr_t includes u64 ctx, and we return it back to the user
in siginfo_t. Kernel does not treat it in any way. This is a pretty
common API pattern in general.


> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -778,6 +778,9 @@ struct perf_event {
> > >         void *security;
> > >  #endif
> > >         struct list_head                sb_list;
> > > +
> > > +       unsigned long                   si_uattr;
> > > +       unsigned long                   si_data;
> > >  #endif /* CONFIG_PERF_EVENTS */
> > >  };
> > >
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -5652,13 +5652,17 @@ static long _perf_ioctl(struct perf_even
> > >                 return perf_event_query_prog_array(event, (void __user *)arg);
> > >
> > >         case PERF_EVENT_IOC_MODIFY_ATTRIBUTES: {
> > > +               struct perf_event_attr __user *uattr;
> > >                 struct perf_event_attr new_attr;
> > > -               int err = perf_copy_attr((struct perf_event_attr __user *)arg,
> > > -                                        &new_attr);
> > > +               int err;
> > >
> > > +               uattr = (struct perf_event_attr __user *)arg;
> > > +               err = perf_copy_attr(uattr, &new_attr);
> > >                 if (err)
> > >                         return err;
> > >
> > > +               event->si_uattr = (unsigned long)uattr;
> > > +
> > >                 return perf_event_modify_attr(event,  &new_attr);
> > >         }
> > >         default:
> > > @@ -6399,7 +6403,12 @@ static void perf_sigtrap(struct perf_eve
> > >         clear_siginfo(&info);
> > >         info.si_signo = SIGTRAP;
> > >         info.si_code = TRAP_PERF;
> > > -       info.si_errno = event->attr.type;
> > > +       info.si_addr = (void *)event->si_data;
> > > +
> > > +       info.si_perf = event->si_uattr;
> > > +       if (event->parent)
> > > +               info.si_perf = event->parent->si_uattr;
> > > +
> > >         force_sig_info(&info);
> > >  }
> > >
> > > @@ -6414,8 +6423,8 @@ static void perf_pending_event_disable(s
> > >                 WRITE_ONCE(event->pending_disable, -1);
> > >
> > >                 if (event->attr.sigtrap) {
> > > -                       atomic_set(&event->event_limit, 1); /* rearm event */
> > >                         perf_sigtrap(event);
> > > +                       atomic_set_release(&event->event_limit, 1); /* rearm event */
> > >                         return;
> > >                 }
> > >
> > > @@ -9121,6 +9130,7 @@ static int __perf_event_overflow(struct
> > >         if (events && atomic_dec_and_test(&event->event_limit)) {
> > >                 ret = 1;
> > >                 event->pending_kill = POLL_HUP;
> > > +               event->si_data = data->addr;
> > >
> > >                 perf_event_disable_inatomic(event);
> > >         }
> > > @@ -12011,6 +12021,8 @@ SYSCALL_DEFINE5(perf_event_open,
> > >                 goto err_task;
> > >         }
> > >
> > > +       event->si_uattr = (unsigned long)attr_uptr;
> > > +
> > >         if (is_sampling_event(event)) {
> > >                 if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
> > >                         err = -EOPNOTSUPP;
