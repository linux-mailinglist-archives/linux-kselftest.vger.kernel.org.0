Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2272243EE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Aug 2020 20:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMSfn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Aug 2020 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHMSfn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Aug 2020 14:35:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD436C061757;
        Thu, 13 Aug 2020 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6WrnnviMlINCC/I1qJoE/0TrMdLOcpZu6CQan/DWMw0=; b=M6n9gFHrfiDJ9ToLAfdZGTAml3
        g3rOaOp0rIofregmcedWd+v1nO/3x0JSV4g+UXWQUhQsVNM8Ibm778Rie2zREOhf22DkvHGUnP0w5
        YTNqFa6Zh0VOQW8gkU09tpGDt45zQyfZ41eOSFCcl/EGpODmAoY+gMx0KzV92wsps0ziggaxVsPaw
        RW/DGPKHrFuXADS3JLBRYNOJ3hjbzdUbfiGrJZk6KX+kzpEV6SWZpv4+eBeLaFY2Vl0x1lTiEYb9y
        tEIrQdgHvyptNq3k7doNKCUwWqf+cXQxw/iL4kDQUlZIKTUVBQz3aBPXxuxC2VZAHCVXNSi1uV/ar
        BmaExiPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6I4e-0001mq-7O; Thu, 13 Aug 2020 18:35:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 622FF3011F0;
        Thu, 13 Aug 2020 20:35:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E5542B929A4C; Thu, 13 Aug 2020 20:35:33 +0200 (CEST)
Date:   Thu, 13 Aug 2020 20:35:33 +0200
From:   peterz@infradead.org
To:     Uriel Guajardo <urielguajardo@google.com>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, mingo@redhat.com,
        will@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kunit: added lockdep support
Message-ID: <20200813183533.GZ2674@hirez.programming.kicks-ass.net>
References: <20200812193332.954395-1-urielguajardojr@gmail.com>
 <20200813103615.GT2674@hirez.programming.kicks-ass.net>
 <CAG30Eec2w1zG7CEd=TVGoNssCZu49TBF+1xXPKrKh+d7hJZfsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG30Eec2w1zG7CEd=TVGoNssCZu49TBF+1xXPKrKh+d7hJZfsg@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 13, 2020 at 08:15:27AM -0500, Uriel Guajardo wrote:
> On Thu, Aug 13, 2020 at 5:36 AM <peterz@infradead.org> wrote:
> >
> > On Wed, Aug 12, 2020 at 07:33:32PM +0000, Uriel Guajardo wrote:
> > > KUnit will fail tests upon observing a lockdep failure. Because lockdep
> > > turns itself off after its first failure, only fail the first test and
> > > warn users to not expect any future failures from lockdep.
> > >
> > > Similar to lib/locking-selftest [1], we check if the status of
> > > debug_locks has changed after the execution of a test case. However, we
> > > do not reset lockdep afterwards.
> > >
> > > Like the locking selftests, we also fix possible preemption count
> > > corruption from lock bugs.
> >
> > > +static void kunit_check_locking_bugs(struct kunit *test,
> > > +                                  unsigned long saved_preempt_count,
> > > +                                  bool saved_debug_locks)
> > > +{
> > > +     preempt_count_set(saved_preempt_count);
> > > +#ifdef CONFIG_TRACE_IRQFLAGS
> > > +     if (softirq_count())
> > > +             current->softirqs_enabled = 0;
> > > +     else
> > > +             current->softirqs_enabled = 1;
> > > +#endif
> >
> > Urgh, don't silently change these... if they're off that's a hard fail.
> >
> >         if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
> >                 preempt_count_set(saved_preempt_count);
> >
> > And by using DEBUG_LOCKS_WARN_ON() it will kill IRQ tracing and trigger
> > the below fail.
> 
> Hmm, I see. My original assumption was that lock related bugs that
> could corrupt preempt_count would always be intervened by lockdep
> (resulting in debug_locks already being off). Is this not always true?
> In any case, I think it's better to explicitly show the failure
> associated with preemption count as you have done, but I'm still
> curious.

Code could have an unbalanced preempt_disable() unrelated to locks.

> Also, for further clarification: the check you have made on
> preempt_count also covers softirq_count, right? 

Correct.

> My understanding is
> that softirqs are re-{enabled/disabled} due to the corruption of the
> preemption count, so no changes should occur if the preemption count
> remains the same. If it does change, we've already failed from
> DEBUG_LOCKS_WARN_ON.

local_bh_enable() might call into softirq handling if it got raised
while disabled, you'll miss that here. The next interrupt will likely
run the softirq after that.

This is best effort error recovery, you got a splat, all we aim for is
living long enough to get the user to see it.
