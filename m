Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DBE247872
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Aug 2020 23:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgHQVBS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Aug 2020 17:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgHQVBM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Aug 2020 17:01:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65E8C061342
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Aug 2020 14:01:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h16so14557709oti.7
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Aug 2020 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=li7/F1QxAHMT3HlXtBKHPKuGkDNlHShRldK1/b2ptEE=;
        b=p1WuDpCoxMkf/1Src7GUIJVwp95M+yStBX9RyIIDTXVnnhPXquUBytkGYr7U5k192s
         Sa/fAAj3vZNZUzntUuHugq4fjEYYBGO1Xbphqfs2WSqzrQrB20TqrV6ulWrPMBvc1h5S
         eacUQLpPVURfdKEGOa3mIwNneS0bOHJsbejOA1D6h/HQt63O2AreYeCnxztJPYV2n4cd
         vb7zqR8mvZagwYWzK4NrbSVqi/06Unl4fx+2GuFZ58kWjz+1RBmyYGKVIQmA+Av3hUQS
         DifBysU4gdtYAjFaDSIxuCcUsZ/yAUT54lnhHy5efkSEsVu1LG30YZeCRoiLBGJM8HGt
         lGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=li7/F1QxAHMT3HlXtBKHPKuGkDNlHShRldK1/b2ptEE=;
        b=Z3rETrJ9YcWp79u1LK+s7lU9RCALo0dLHzW05JgqMVfxerKShMnwAgZC2OcEuwoIF4
         L39gWcZDYynBmVywwUGr4oY50St1+wA6s+s+T/N5Qoy33/2fN81i7lW5RAeImUsypIrN
         pTP6v1cRfGq/QUc49rWyBfOMgZKcU4LjMZKB+l1D/IEsS6N7Y/IbjkDgWumPIIbpDm5K
         r2FN3pPtBBsHQuRaBGEn+DmqvbowbLOveZl6CK5qybbBcsUgTKTW/55CUbMfU8dJMjin
         L/2o6NKlZU8ZyDnRt8xxoTMnvOY1WmJu4WFyBrnTZ0ILt6bznHSlpVqcP6845R3uraHd
         mFHA==
X-Gm-Message-State: AOAM532HvSNDB+K34mbGdSjSNnucRkvAEic3v2gO1LEMNatlhAOLnmp/
        NBbvG5S3DSsd4nsHg7/fDk2CHLC6M3fG+KNlHL47JA==
X-Google-Smtp-Source: ABdhPJw6RaFO/BQHfKJyZcB4TOw93cJ1X820d/Plez6lRk2tja6UMbKLfbMSUvyu2PkFUacStPL6ZdWluVdvfaxxFO4=
X-Received: by 2002:a05:6830:614:: with SMTP id w20mr13272524oti.283.1597698069848;
 Mon, 17 Aug 2020 14:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200814205527.1833459-1-urielguajardojr@gmail.com>
 <20200815083029.GA2430016@gmail.com> <20200815084443.GO3982@worktop.programming.kicks-ass.net>
 <20200815091721.GC2444151@gmail.com>
In-Reply-To: <20200815091721.GC2444151@gmail.com>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Mon, 17 Aug 2020 16:00:59 -0500
Message-ID: <CAG30EecDS+yaW0k62Wu2sHoe2+amTe-=U4NAVHJcCfD2US+Enw@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: added lockdep support
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, mingo@redhat.com,
        will@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 15, 2020 at 4:17 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Sat, Aug 15, 2020 at 10:30:29AM +0200, Ingo Molnar wrote:
> > >
> > > * Uriel Guajardo <urielguajardojr@gmail.com> wrote:
> > >
> > > > From: Uriel Guajardo <urielguajardo@google.com>
> > > >
> > > > KUnit will fail tests upon observing a lockdep failure. Because lockdep
> > > > turns itself off after its first failure, only fail the first test and
> > > > warn users to not expect any future failures from lockdep.
> > > >
> > > > Similar to lib/locking-selftest [1], we check if the status of
> > > > debug_locks has changed after the execution of a test case. However, we
> > > > do not reset lockdep afterwards.
> > > >
> > > > Like the locking selftests, we also fix possible preemption count
> > > > corruption from lock bugs.
> > >
> > > > --- a/lib/kunit/Makefile
> > > > +++ b/lib/kunit/Makefile
> > >
> > > > +void kunit_check_lockdep(struct kunit *test, struct kunit_lockdep *lockdep) {
> > > > + int saved_preempt_count = lockdep->preempt_count;
> > > > + bool saved_debug_locks = lockdep->debug_locks;
> > > > +
> > > > + if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
> > > > +         preempt_count_set(saved_preempt_count);
> > > > +
> > > > +#ifdef CONFIG_TRACE_IRQFLAGS
> > > > + if (softirq_count())
> > > > +         current->softirqs_enabled = 0;
> > > > + else
> > > > +         current->softirqs_enabled = 1;
> > > > +#endif
> > > > +
> > > > + if (saved_debug_locks && !debug_locks) {
> > > > +         kunit_set_failure(test);
> > > > +         kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> > > > +         kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> > > > + }
> > >
> > >
> > > So this basically duplicates what the boot-time locking self-tests do,
> > > in a poor fashion?
> >
> > No, it makes sure that any kunit based self-test fails when it messes up
> > it's locking.
>
> We have a flag for whether lockdep is running though, so is this
> basically a very complicated way to parse /proc/lockdep_debug? :-)
>

I may be missing something here, but what would be the advantage of
using another flag or using other means to find lockdep's status?

This patch is basically checking if debug_locks has changed after a
KUnit test case has executed. It's not sufficient to only check if
debug_locks is off, since it could have already been off many test
cases ago.

I imagine the only difference would be replacing "debug_locks" with
another flag or code checking lockdep's status, and I don't see that
as being any less complicated.
