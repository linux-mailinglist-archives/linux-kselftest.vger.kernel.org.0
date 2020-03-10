Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102F3180A9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 22:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCJVj3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 17:39:29 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33493 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCJVj3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 17:39:29 -0400
Received: by mail-pj1-f67.google.com with SMTP id o21so692817pjs.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Mar 2020 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T26zcDKa3B8Ccgr/TpJ2S305/X5TIZGyLp36trF+POo=;
        b=UlVfj8z2wr/WzpEmGcDaRfms4z9TbAXtAyU2y3qiTLBfcdR4vOgKpoytN1aXHGxzOq
         XDk/3pE6KS2Cuzy3UvR8Vz6WuZtA0ZFyvoRuMhVkW0iPKzUh9kq0R2L1Shu1OAO9na5P
         PoRYXmQ3PZgySKo8VTUGwwOFXBiIB0WPYHB3M1S0nZc7HpdTTVfunIENsKTmb2Mhk9sq
         /UcWyEY/lAB+oPcM9CyTq/ynZq4mvpfEtvyGKzv+z+BQhi7GUik2pSeT0M8V5HmMaOza
         0SlOk/LV5XNbZ2+nn7CVZIzefIKHhxkgt6HDH5i9dAM6RoigIbJuohA7/IN+mspaxwsO
         FO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T26zcDKa3B8Ccgr/TpJ2S305/X5TIZGyLp36trF+POo=;
        b=rVxLvAi3cxrYLyuC1DpXy5rysgJAvjiHQHKXY/zw1PcXc54Srcy38R8oHWBNm/1NaK
         7WFEjvtgTHUyyzc8Ol8y6c9Is18Gks0w+dBeKZoxog1RiVtL5kULpM4y4ZnktmAULfjk
         +eRfl9JFIVl1merX+c02IFb3TGzXjfe0dpYuAbRlk5xDkH9zswQDzDsUMyHRyXukYRuk
         SjbYTdbz4LOfFyy3bJ8nDjukrNyk4G6CLuDrJwAUwtVJ2wqxL+yKF9VqDbfV6FF35W2k
         yJsBivyJN+teniExEkxxCNhG5r+MBk+UrUSmeuQi7eX0Qan6pWUpMU7PRrkxhx6DSw25
         xm1g==
X-Gm-Message-State: ANhLgQ2RYMJYmAx7/zy9ci5XqtjHplVYIuppCxscSpYbziZ/0M8n+mjh
        rUpt/Mu0ZprS6oSzb8CzdEsk7gGK9wUnu+fE+XLA4A==
X-Google-Smtp-Source: ADFU+vsXRA51Z5R8J8QAlzU7dBAeXHMJIO1KbWRLfAi/7Y8ISrxHlkI7cP6T1ce42VyooMGph67CkOVhGhlLFCL8xJY=
X-Received: by 2002:a17:90a:a587:: with SMTP id b7mr33452pjq.18.1583876367719;
 Tue, 10 Mar 2020 14:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <alpine.LRH.2.20.2002271136160.12417@dhcp-10-175-190-15.vpn.oracle.com>
In-Reply-To: <alpine.LRH.2.20.2002271136160.12417@dhcp-10-175-190-15.vpn.oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Mar 2020 14:39:16 -0700
Message-ID: <CAFd5g44gVFyxwo4r=7gpPGdvPQoynfEjHhLfyC3_6uaU2oA0Lg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 27, 2020 at 6:04 AM Alan Maguire <alan.maguire@oracle.com> wrote:

Sorry for the delay in reviews. I have been preoccupied by some Google
internal stuff.

> On Wed, 26 Feb 2020, Patricia Alfonso wrote:
>
> > Integrate KASAN into KUnit testing framework.
>
> This is a great idea! Some comments/suggestions below...
>
> >  - Fail tests when KASAN reports an error that is not expected
> >  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
> >  - KUnit struct added to current task to keep track of the current test
> > from KASAN code
> >  - Booleans representing if a KASAN report is expected and if a KASAN
> >  report is found added to kunit struct
> >  - This prints "line# has passed" or "line# has failed"
> >
> > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > ---
> > If anyone has any suggestions on how best to print the failure
> > messages, please share!
> >
> > One issue I have found while testing this is the allocation fails in
> > kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
> > does cause the test to fail on the KUnit side, as expected, but it
> > seems to skip all the tests before this one because the output starts
> > with this failure instead of with the first test, kmalloc_oob_right().
> >
> >  include/kunit/test.h                | 24 ++++++++++++++++++++++++
> >  include/linux/sched.h               |  7 ++++++-
> >  lib/kunit/test.c                    |  7 ++++++-
> >  mm/kasan/report.c                   | 19 +++++++++++++++++++
> >  tools/testing/kunit/kunit_kernel.py |  2 +-
> >  5 files changed, 56 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 2dfb550c6723..2e388f8937f3 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -21,6 +21,8 @@ struct kunit_resource;
> >  typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
> >  typedef void (*kunit_resource_free_t)(struct kunit_resource *);
> >
> > +void kunit_set_failure(struct kunit *test);
> > +
> >  /**
> >   * struct kunit_resource - represents a *test managed resource*
> >   * @allocation: for the user to store arbitrary data.
> > @@ -191,6 +193,9 @@ struct kunit {
> >        * protect it with some type of lock.
> >        */
> >       struct list_head resources; /* Protected by lock. */
> > +
> > +     bool kasan_report_expected;
> > +     bool kasan_report_found;
> >  };
> >
>
> Is this needed here? You're testing something pretty
> specific so it seems wrong to add to the generic
> kunit resource unless there's a good reason. I see the
> code around setting these values in mm/kasan/report.c,
> but I wonder if we could do something more generic.
>
> How about the concept of a static resource (assuming a
> dynamically allocated one is out because it messes
> with memory allocation tests)? Something like this:
>
> #define kunit_add_static_resource(test, resource_ptr, resource_field)   \
>         do {                                                            \
>                 spin_lock(&test->lock);                                 \
>                 (resource_ptr)->resource_field.init = NULL;             \
>                 (resource_ptr)->resource_field.free = NULL;             \
>                 list_add_tail(&(resource_ptr)->resource_field,          \
>                               &test->resources);                        \
>                 spin_unlock(&test->lock);                               \
>         } while (0)
>
>
> Within your kasan code you could then create a kasan-specific
> structure that embends a kunit_resource, and contains the
> values you need:
>
> struct kasan_report_resource {
>         struct kunit_resource res;
>         bool kasan_report_expected;
>         bool kasan_report_found;
> };
>
> (One thing we'd need to do for such static resources is fix
> kunit_resource_free() to check if there's a free() function,
> and if not assume a static resource)
>
> If you then create an init() function associated with your
> kunit suite (which will be run for every case) it can do this:
>
> int kunit_kasan_test_init(struct kunit *test)
> {
>         kunit_add_static_resource(test, &my_kasan_report_resource, res);
>         ...
> }
>
> The above should also be used to initialize current->kasan_unit_test
> instead of doing that in kunit_try_run_case().  With those
> changes, you don't (I think) need to change anything in core
> kunit (assuming support for static resources).
>
> To retrieve the resource during tests or in kasan context, the
> method seems to be to use kunit_resource_find(). However, that
> requires a match function which seems a bit heavyweight for the
> static case.  We should probably have a default "find by name"
> or similar function here, and add an optional "name" field
> to kunit resources to simplify things.  Anyway here you'd
> use something like:
>
>         kasan_report_resource = kunit_resource_find(test, matchfn,
>                                                     NULL, matchdata);
>
>
> Are there any barriers to taking this sort of approach (apart
> from the support for static resources not being there yet)?

This is a really interesting idea, Alan! I never imagined
kunit_resources being used this way, and I like it. I saw you sent
some patches to implement this stuff, so I will withhold further
comments on that here.
