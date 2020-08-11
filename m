Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B76242270
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Aug 2020 00:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgHKWWk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Aug 2020 18:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgHKWWj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Aug 2020 18:22:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6EC06174A
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Aug 2020 15:22:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t7so431413otp.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Aug 2020 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/huS475fQsIt3TnWXWCkTB3aVVuQSvTxEVuKvlu6dg=;
        b=j2qZHmegCEhDNspLauyB+kdVvkes8CWrlZcQqRI1LHyAMo5fB60/BzJDDlu07DLbob
         izAX8Dc4i9szyBWt1R7ga4E4pS1VjAfpm1tUutFiNhm2UIc3kJn0W0O6RdI6wzEgnxlH
         /MTvu4zc4HmX78TaVarH5jtHRol934wJjTOCOQDKvg4Bab1J3H96JCcd8SrN9CNNkd5C
         581sNDvs/rxYEFOVfutD8+GyEyM3I25/3MgPbyRn/mfIpNb8EHVJ2YPWFJJz1UORjnNt
         xM2nMDX3m73d0KHhVn4eQPEQXozuBcclCTfOZhc0JSuzY/69fgfuf7ytGCTrZ/E9lZlN
         mslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/huS475fQsIt3TnWXWCkTB3aVVuQSvTxEVuKvlu6dg=;
        b=QKpSJ9ulDK3uN36sqR/4qPppSuf+g2mo+3jkeoU6jSEjD9D1wKH6nG9sweacs85fOz
         ej4oVjMzPpKi7buH23IBUvzIovpt6t5sVbI5kvyyQX4Se1P+4VNYcyrIPIHzN1NtSRCD
         XSljBVerEfnxjcrBJNp90Y9vWjK8r9DhW/e2qMXGzMOzu9aUixSNXQCSKrfLr9hM/c20
         SVfstaNq4zwwps5KU5NnSIQvWN1VV3uR8qeBb80jVi866EBRrf/fRc3EzMgg11yQWjCd
         zqbyU4jc30rAVPfGu14GCEYZdU2vL3qM6O5PRxGWgEtB0jyaod1GrHHLGXZ73xG0Z19I
         M6nQ==
X-Gm-Message-State: AOAM530xWVZiXPkZIsZxmWQUyLVB1X/IWpCNN9sfpJMYt2SFWkThbNnE
        VXbF3YtjHAgyKGEtACwp0Ei93/m5/ZKHpddOeoRckA==
X-Google-Smtp-Source: ABdhPJzo6xFt7EBwhEM5Yh8tY2Vg5XchQe6Al7fpjWcsazLjuKnluCY0+ec2TvIT8FBNQYO/kkPbCza3XAljg/go4qw=
X-Received: by 2002:a9d:450a:: with SMTP id w10mr6980762ote.327.1597184557742;
 Tue, 11 Aug 2020 15:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200810213257.438861-1-urielguajardojr@gmail.com>
 <20200810214328.GM3982@worktop.programming.kicks-ass.net> <CAG30EecPEzM7hkPxagCD8GQb=JUZhatyW50KAoaHjrHoj4BiFw@mail.gmail.com>
 <20200811190517.GG2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200811190517.GG2674@hirez.programming.kicks-ass.net>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Tue, 11 Aug 2020 17:22:26 -0500
Message-ID: <CAG30EeehU=pjZSPDpzM81y1776sM-9XE_vrxJ44QaWU-kVJ=Ug@mail.gmail.com>
Subject: Re: [PATCH] kunit: added lockdep support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, mingo@redhat.com,
        will@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 11, 2020 at 2:05 PM <peterz@infradead.org> wrote:
>
> On Tue, Aug 11, 2020 at 12:03:51PM -0500, Uriel Guajardo wrote:
> > On Mon, Aug 10, 2020 at 4:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Aug 10, 2020 at 09:32:57PM +0000, Uriel Guajardo wrote:
> > > > +static inline void kunit_check_locking_bugs(struct kunit *test,
> > > > +                                         unsigned long saved_preempt_count)
> > > > +{
> > > > +     preempt_count_set(saved_preempt_count);
> > > > +#ifdef CONFIG_TRACE_IRQFLAGS
> > > > +     if (softirq_count())
> > > > +             current->softirqs_enabled = 0;
> > > > +     else
> > > > +             current->softirqs_enabled = 1;
> > > > +#endif
> > > > +#if IS_ENABLED(CONFIG_LOCKDEP)
> > > > +     local_irq_disable();
> > > > +     if (!debug_locks) {
> > > > +             kunit_set_failure(test);
> > > > +             lockdep_reset();
> > > > +     }
> > > > +     local_irq_enable();
> > > > +#endif
> > > > +}
> > >
> > > Unless you can guarantee this runs before SMP brinup, that
> > > lockdep_reset() is terminally broken.
> >
> > Good point. KUnit is initialized after SMP is set up, and KUnit can
> > also be built as a module, so it's not a guarantee that we can make.
>
> Even if you could, there's still the question of wether throwing out all
> the dependencies learned during boot is a sensible idea.
>
> > Is there any other way to turn lockdep back on after we detect a
> > failure? It would be ideal if lockdep could still run in the next test
> > case after a failure in a previous one.
>
> Not really; the moment lockdep reports a failure it turns off all
> tracking and we instantly loose state.
>
> You'd have to:
>
>  - delete the 'mistaken' dependency from the graph such that we loose
>    the cycle, otherwise it will continue to find and report the cycle.
>
>  - put every task through a known empty state which turns the tracking
>    back on.
>
> Bart implemented most of what you need for the first item last year or
> so, but the remaining bit and the second item would still be a fair
> amount of work.
>
> Also, I'm really not sure it's worth it, the kernel should be free of
> lock cycles, so just fix one, reboot and continue.
>
> > I suppose we could only display the first failure that occurs, similar
> > to how lockdep does it. But it could also be useful to developers if
> > they saw failures in subsequent test cases, with the knowledge that
> > those failures may be unreliable.
>
> People already struggle with lockdep reports enough; I really don't want
> to given them dodgy report to worry about.

Ah, ok! Fair enough, thanks for the info. Although resetting lockdep
would be nice to have in the future, I think it's enough to only
report the first failure and warn the user that further test cases
will have lockdep disabled. People can then fix the issue and then
re-run it. I'll follow up with a patch that does this.
