Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5DF242019
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgHKTF1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Aug 2020 15:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKTF1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Aug 2020 15:05:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F13C06174A;
        Tue, 11 Aug 2020 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=REGRP0wT2GfbQ/FutuiotQ+2f7Plfx/4XOzG7gnERs4=; b=PK5m21KGU3UK/ex0YwGzUQ/S2z
        UvXnuXDgbUrj2i7OxztELNv/S2/KxgsmT/37rIAgr/cDDhreyKyUT4BAya5PQX6coI+oJdCOXLVSP
        HqNt+HaSfdciCw5A3/CENvWdghUPtPr+l8nMRJtz8YMKiQ6Izz12jWePewymRvIdI2V3isy3tdL5N
        yBSWjrF0s27WvJ2GiqhEEMcvG41vBLQSsGvY5hVnMe7rJ+juNV1LrsaW6ZS6AfbNR8r8Wp8uiJUNj
        eUndKylrBKDxZwZgydybz4O5f+Ddk3AWzCHga/llUPkJsvXkdmxX0hMhPg/BRRCpkT3Od8DrdebV8
        UZA3ZvLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5ZaI-0001MX-Ng; Tue, 11 Aug 2020 19:05:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E2CD3028C8;
        Tue, 11 Aug 2020 21:05:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1604B2110CB33; Tue, 11 Aug 2020 21:05:17 +0200 (CEST)
Date:   Tue, 11 Aug 2020 21:05:17 +0200
From:   peterz@infradead.org
To:     Uriel Guajardo <urielguajardo@google.com>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, mingo@redhat.com,
        will@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kunit: added lockdep support
Message-ID: <20200811190517.GG2674@hirez.programming.kicks-ass.net>
References: <20200810213257.438861-1-urielguajardojr@gmail.com>
 <20200810214328.GM3982@worktop.programming.kicks-ass.net>
 <CAG30EecPEzM7hkPxagCD8GQb=JUZhatyW50KAoaHjrHoj4BiFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG30EecPEzM7hkPxagCD8GQb=JUZhatyW50KAoaHjrHoj4BiFw@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 11, 2020 at 12:03:51PM -0500, Uriel Guajardo wrote:
> On Mon, Aug 10, 2020 at 4:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Aug 10, 2020 at 09:32:57PM +0000, Uriel Guajardo wrote:
> > > +static inline void kunit_check_locking_bugs(struct kunit *test,
> > > +                                         unsigned long saved_preempt_count)
> > > +{
> > > +     preempt_count_set(saved_preempt_count);
> > > +#ifdef CONFIG_TRACE_IRQFLAGS
> > > +     if (softirq_count())
> > > +             current->softirqs_enabled = 0;
> > > +     else
> > > +             current->softirqs_enabled = 1;
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_LOCKDEP)
> > > +     local_irq_disable();
> > > +     if (!debug_locks) {
> > > +             kunit_set_failure(test);
> > > +             lockdep_reset();
> > > +     }
> > > +     local_irq_enable();
> > > +#endif
> > > +}
> >
> > Unless you can guarantee this runs before SMP brinup, that
> > lockdep_reset() is terminally broken.
> 
> Good point. KUnit is initialized after SMP is set up, and KUnit can
> also be built as a module, so it's not a guarantee that we can make.

Even if you could, there's still the question of wether throwing out all
the dependencies learned during boot is a sensible idea.

> Is there any other way to turn lockdep back on after we detect a
> failure? It would be ideal if lockdep could still run in the next test
> case after a failure in a previous one.

Not really; the moment lockdep reports a failure it turns off all
tracking and we instantly loose state.

You'd have to:

 - delete the 'mistaken' dependency from the graph such that we loose
   the cycle, otherwise it will continue to find and report the cycle.

 - put every task through a known empty state which turns the tracking
   back on.

Bart implemented most of what you need for the first item last year or
so, but the remaining bit and the second item would still be a fair
amount of work.

Also, I'm really not sure it's worth it, the kernel should be free of
lock cycles, so just fix one, reboot and continue.

> I suppose we could only display the first failure that occurs, similar
> to how lockdep does it. But it could also be useful to developers if
> they saw failures in subsequent test cases, with the knowledge that
> those failures may be unreliable.

People already struggle with lockdep reports enough; I really don't want
to given them dodgy report to worry about.
