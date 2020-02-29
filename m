Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09CF174412
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Feb 2020 02:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB2BJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 20:09:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39942 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2BJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 20:09:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id r17so5289322wrj.7
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2020 17:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SN7G4tCYEshnaGRAM2db2SQakrRhJKUvOkKXHESfWSo=;
        b=WKqJxdxaP6DLs6jiwlJJtTd0WErcLP34u5ymXqYFgJbaMP/bEACze0j7crZ8VA3FpE
         Y3BsoU0SqG6DXnwEiKFUJFU9/WIfrGbAf4f0+jKQ+8LOdWlVnyfoV86VbjafHOsYx/sF
         F979t68lxm+z0kUemuIVU7JfFHKkiYPY+lmE5OnfCrjC4uxAoJLDBZMDs/fmeirtwvNc
         itNHrbqBvV2a3tZg8VI84x92tSj7YcIaJTOoix+eRdZxKhHoQf218baRx4cB1MirsuLT
         pMsfK7cPD3DicE7Fm7aZYJWJu7Rpm0JGifK/4b67WxxKTrCOCBvfzsLOitstebl1qo1S
         B3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SN7G4tCYEshnaGRAM2db2SQakrRhJKUvOkKXHESfWSo=;
        b=CeIjOSZNKwf9P/+ciVtN8/BhwIZ8amHslAfBLBHnFDy6Y17x076cdrb3tFDaVgdTdn
         O7OXJ6ZKWpLS+YArvTCzijDkGGSIf5Cbi5868s8GSjGa+EU5/+dSURenbfvsUqSyYe1z
         rYxBobThFS8hUmW6b14JSXAU845wHUiQQ1VsENiTTLNIj9iUu4Hmm9q6xy8lGzhPR/29
         7a8g9Ow3MV6yogkvM1ZnBDw2OcFmXXkoF0HKj+dT3UpYrPerx6mNOpt3bnCvIlqo1Vwj
         dJXyTIHAwZB3EZUGAn1fwd/hdLnKLjjK28T/usTmdw3C4OY9fBxhr9ZcADL1Aw4xqoGe
         MSmQ==
X-Gm-Message-State: APjAAAW456HmTyXqBkvQwZurInv9LHCigGGkLe8BCiskknCD9eUcmd06
        7I0Uj9U1Ys8xs+sIUwm6NK4GsyVlHqMTEObtQJUckw==
X-Google-Smtp-Source: APXvYqxLoQcjGHdsmqNCSUfGKvuwO4lJf8HCEOOxQ8Ti69YhsLIV+/uNHNSbz25KtqH8ETwZe7ZpX1ULegnX4dKKxHg=
X-Received: by 2002:adf:82ef:: with SMTP id 102mr6964889wrc.23.1582938585758;
 Fri, 28 Feb 2020 17:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+bO7N_80N7NkjOstp=dxGnV1GZUoH3sh6XU90ro0_7M0A@mail.gmail.com>
In-Reply-To: <CACT4Y+bO7N_80N7NkjOstp=dxGnV1GZUoH3sh6XU90ro0_7M0A@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Fri, 28 Feb 2020 17:09:34 -0800
Message-ID: <CAKFsvUKB=S9p6JjRHg=h9d2MM_kb+BoRYO8-wkWPEQex2W1vZA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, vincent.guittot@linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 27, 2020 at 6:39 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Integrate KASAN into KUnit testing framework.
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
> >          * protect it with some type of lock.
> >          */
> >         struct list_head resources; /* Protected by lock. */
> > +
> > +       bool kasan_report_expected;
> > +       bool kasan_report_found;
> >  };
> >
> >  void kunit_init_test(struct kunit *test, const char *name);
> > @@ -941,6 +946,25 @@ do {                                                                              \
> >                                                 ptr,                           \
> >                                                 NULL)
> >
> > +/**
> > + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> > + * not cause a KASAN error.
>
> Oh, I see, this is not a test, but rather an ASSERT-like macro.
> Then maybe we should use it for actual expressions that are supposed
> to trigger KASAN errors?
>
> E.g. KUNIT_EXPECT_KASAN_FAIL(test, *(volatile int*)p);
>

This is one possible approach. I wasn't sure what would be the most
useful. Would it be most useful to assert an error is reported on a
function or assert an error is reported at a specific address?

>
> > + *
> > + */
> > +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do {  \
>
> s/condition/expression/
>
> > +       test->kasan_report_expected = true;     \
>
> Check that kasan_report_expected is unset. If these are nested things
> will break in confusing ways.
> Or otherwise we need to restore the previous value at the end.
>
Good point! I think I was just unsure of where I should set this value
and what the default should be.

> > +       test->kasan_report_found = false; \
> > +       condition; \
> > +       if (test->kasan_report_found == test->kasan_report_expected) { \
>
> We know that kasan_report_expected is true here, so we could just said:
>
> if (!test->kasan_report_found)
>
Good point! This is much more readable

> > +               pr_info("%d has passed", __LINE__); \
> > +       } else { \
> > +               kunit_set_failure(test); \
> > +               pr_info("%d has failed", __LINE__); \
>
> This needs a more readable error.
>
Yes, this was just a stand-in. I was wondering if you might have a
suggestion for the best way to print this failure message? Alan
suggested reusing the KUNIT_EXPECT_EQ() macro so the error message
would look something like:
"Expected kasan_report_expected == kasan_report_found, but
kasan_report_expected == true
kasan_report_found == false"

What do you think of this?

> > +       } \
> > +       test->kasan_report_expected = false;    \
> > +       test->kasan_report_found = false;       \
> > +} while (0)
> > +
> >  /**
> >   * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
> >   * @test: The test context object.
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 04278493bf15..db23d56061e7 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -32,6 +32,8 @@
> >  #include <linux/posix-timers.h>
> >  #include <linux/rseq.h>
> >
> > +#include <kunit/test.h>
> > +
> >  /* task_struct member predeclarations (sorted alphabetically): */
> >  struct audit_context;
> >  struct backing_dev_info;
> > @@ -1178,7 +1180,10 @@ struct task_struct {
> >
> >  #ifdef CONFIG_KASAN
> >         unsigned int                    kasan_depth;
> > -#endif
> > +#ifdef CONFIG_KUNIT
> > +       struct kunit *kasan_kunit_test;
>
> I would assume we will use this for other things as well (failing
> tests on LOCKDEP errors, WARNINGs, etc).
> So I would call this just kunit_test and make non-dependent on KASAN right away.
>
Yeah, I think I just wanted to make it clear that this is only used
for KASAN, but I believe that was before we talked about extending
this.

> > +       if (current->kasan_kunit_test) {
>
> Strictly saying, this also needs to check in_task().
>

I was not aware of in_task()... can you explain its importance to me?

> > +               if (current->kasan_kunit_test->kasan_report_expected) {
> > +                       current->kasan_kunit_test->kasan_report_found = true;
> > +                       return;
> > +               }
> > +               kunit_set_failure(current->kasan_kunit_test);
> > +       }
>
> This chunk is duplicated 2 times. I think it will be more reasonable
> for KASAN code to just notify KUNIT that the error has happened, and
> then KUNIT will figure out what it means and what to do.
>
>
Yeah, I think moving this to the KUnit files is best too. I would like
to keep kunit_set_failure a static function as well.


-- 
Thank you for the comments!

Patricia Alfonso
