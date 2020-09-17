Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6904A26E0C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Sep 2020 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgIQQ2u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 12:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbgIQQ2p (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 12:28:45 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D8B2078D;
        Thu, 17 Sep 2020 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600360116;
        bh=aMFXA6dujAeFH2LkCq1Js2d4JSd24Yo67kBaDY8oEtE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0JMcW2qGu3G1e5DVBtzJABiddeYBZnLe86UtPsGxTUL/4ALcJgIf+j3ymeD7EPM2P
         6kaOd5bIdCt+s6hbZKXuLz52eYjpLqZ8ZyEpCbKf1UrpJVe2pWmLkdF4dkyyeOqgTy
         aFd4GM66CCyEMI5keOxMq1USdAbb5ATC2PcNgjU0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0E5CF35225FA; Thu, 17 Sep 2020 09:28:36 -0700 (PDT)
Date:   Thu, 17 Sep 2020 09:28:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Message-ID: <20200917162836.GJ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
 <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com>
 <20200916152956.GV29330@paulmck-ThinkPad-P72>
 <CAKMK7uGFyfhEyt=jmdk2jDO-hq0_Pf0ck+cKSELHjr2U3rPuYQ@mail.gmail.com>
 <20200916205840.GD29330@paulmck-ThinkPad-P72>
 <CAKMK7uHL2dMv80b8uBXr=BqHD2TQeODQQM1MGYhAfCYbX7sLrA@mail.gmail.com>
 <20200916223951.GG29330@paulmck-ThinkPad-P72>
 <CAKMK7uFXD7FzGZJZx0QAR2WdbewGmLnsSVaH7+HD0XSr--f0kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFXD7FzGZJZx0QAR2WdbewGmLnsSVaH7+HD0XSr--f0kw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 17, 2020 at 09:52:30AM +0200, Daniel Vetter wrote:
> On Thu, Sep 17, 2020 at 12:39 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Sep 16, 2020 at 11:43:02PM +0200, Daniel Vetter wrote:
> > > On Wed, Sep 16, 2020 at 10:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Wed, Sep 16, 2020 at 10:29:06PM +0200, Daniel Vetter wrote:
> > > > > On Wed, Sep 16, 2020 at 5:29 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Sep 16, 2020 at 09:37:17AM +0200, Daniel Vetter wrote:
> > > > > > > On Tue, Sep 15, 2020 at 7:35 PM Linus Torvalds
> > > > > > > <torvalds@linux-foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, Sep 15, 2020 at 1:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > > > > >
> > > > > > > > > OTOH, having a working 'preemptible()' or maybe better named
> > > > > > > > > 'can_schedule()' check makes tons of sense to make decisions about
> > > > > > > > > allocation modes or other things.
> > > > > > > >
> > > > > > > > No. I think that those kinds of decisions about actual behavior are
> > > > > > > > always simply fundamentally wrong.
> > > > > > > >
> > > > > > > > Note that this is very different from having warnings about invalid
> > > > > > > > use. THAT is correct. It may not warn in all configurations, but that
> > > > > > > > doesn't matter: what matters is that it warns in common enough
> > > > > > > > configurations that developers will catch it.
> > > > > > > >
> > > > > > > > So having a warning in "might_sleep()" that doesn't always trigger,
> > > > > > > > because you have a limited configuration that can't even detect the
> > > > > > > > situation, that's fine and dandy and intentional.
> > > > > > > >
> > > > > > > > But having code like
> > > > > > > >
> > > > > > > >        if (can_schedule())
> > > > > > > >            .. do something different ..
> > > > > > > >
> > > > > > > > is fundamentally complete and utter garbage.
> > > > > > > >
> > > > > > > > It's one thing if you test for "am I in hardware interrupt context".
> > > > > > > > Those tests aren't great either, but at least they make sense.
> > > > > > > >
> > > > > > > > But a driver - or some library routine - making a difference based on
> > > > > > > > some nebulous "can I schedule" is fundamentally and basically WRONG.
> > > > > > > >
> > > > > > > > If some code changes behavior, it needs to be explicit to the *caller*
> > > > > > > > of that code.
> > > > > > > >
> > > > > > > > So this is why GFP_ATOMIC is fine, but "if (!can_schedule())
> > > > > > > > do_something_atomic()" is pure shite.
> > > > > > > >
> > > > > > > > And I am not IN THE LEAST interested in trying to help people doing
> > > > > > > > pure shite. We need to fix them. Like the crypto code is getting
> > > > > > > > fixed.
> > > > > > >
> > > > > > > Just figured I'll throw my +1 in from reading too many (gpu) drivers.
> > > > > > > Code that tries to cleverly adjust its behaviour depending upon the
> > > > > > > context it's running in is harder to understand and blows up in more
> > > > > > > interesting ways. We still have drm_can_sleep() and it's mostly just
> > > > > > > used for debug code, and I've largely ended up just deleting
> > > > > > > everything that used it because when you're driver is blowing up the
> > > > > > > last thing you want is to realize your debug code and output can't be
> > > > > > > relied upon. Or worse, that the only Oops you have is the one in the
> > > > > > > debug code, because the real one scrolled away - the original idea
> > > > > > > behind drm_can_sleep was to make all the modeset code work
> > > > > > > automagically both in normal ioctl/kworker context and in the panic
> > > > > > > handlers or kgdb callbacks. Wishful thinking at best.
> > > > > > >
> > > > > > > Also at least for me that extends to everything, e.g. I much prefer
> > > > > > > explicit spin_lock and spin_lock_irq vs magic spin_lock_irqsave for
> > > > > > > locks shared with interrupt handlers, since the former two gives me
> > > > > > > clear information from which contexts such function can be called.
> > > > > > > Other end is the memalloc_no*_save/restore functions, where I recently
> > > > > > > made a real big fool of myself because I didn't realize how much that
> > > > > > > impacts everything that's run within - suddenly "GFP_KERNEL for small
> > > > > > > stuff never fails" is wrong everywhere.
> > > > > > >
> > > > > > > It's all great for debugging and sanity checks (and we run with all
> > > > > > > that stuff enabled in our CI), but really semantic changes depending
> > > > > > > upon magic context checks freak my out :-)
> > > > > >
> > > > > > All fair, but some of us need to write code that must handle being
> > > > > > invoked from a wide variety of contexts.  Now perhaps you like the idea of
> > > > > > call_rcu() for schedulable contexts, call_rcu_nosched() when preemption
> > > > > > is disabled, call_rcu_irqs_are_disabled() when interrupts are disabled,
> > > > > > call_rcu_raw_atomic() from contexts where (for example) raw spinlocks
> > > > > > are held, and so on.  However, from what I can see, most people instead
> > > > > > consistently prefer that the RCU API instead be consolidated.
> > > > > >
> > > > > > Some in-flight cache-efficiency work for kvfree_rcu() and call_rcu()
> > > > > > needs to be able to allocate memory occasionally.  It can do that when
> > > > > > invoked from some contexts, but not when invoked from others.  Right now,
> > > > > > in !PREEMPT kernels, it cannot tell, and must either do things to the
> > > > > > memory allocators that some of the MM hate or must unnecessarily invoke
> > > > > > workqueues.  Thomas's patches would allow the code to just allocate in
> > > > > > the common case when these primitives are invoked from contexts where
> > > > > > allocation is permitted.
> > > > > >
> > > > > > If we want to restrict access to the can_schedule() or whatever primitive,
> > > > > > fine and good.  We can add a check to checkpatch.pl, for example.  Maybe
> > > > > > we can go back to the old brlock approach of requiring certain people's
> > > > > > review for each addition to the kernel.
> > > > > >
> > > > > > But there really are use cases that it would greatly help.
> > > > >
> > > > > We can deadlock in random fun places if random stuff we're calling
> > > > > suddenly starts allocating. Sometimes. Maybe once in a blue moon, to
> > > > > make it extra fun to reproduce. Maybe most driver subsystems are less
> > > > > brittle, but gpu drivers definitely need to know about the details for
> > > > > exactly this example. And yes gpu drivers use rcu for freeing
> > > > > dma_fence structures, and that tends to happen in code that we only
> > > > > recently figured out should really not allocate memory.
> > > > >
> > > > > I think minimally you need to throw in an unconditional
> > > > > fs_reclaim_acquire();fs_reclaim_release(); so that everyone who runs
> > > > > with full debugging knows what might happen. It's kinda like
> > > > > might_sleep, but a lot more specific. might_sleep() alone is not
> > > > > enough, because in the specific code paths I'm thinking of (and
> > > > > created special lockdep annotations for just recently) sleeping is
> > > > > allowed, but any memory allocations with GFP_RECLAIM set are no-go.
> > > >
> > > > Completely agreed!  Any allocation on any free path must be handled
> > > > -extremely- carefully.  To that end...
> > > >
> > > > First, there is always a fallback in case the allocation fails.  Which
> > > > might have performance or corner-case robustness issues, but which will
> > > > at least allow forward progress.  Second, we consulted with a number of
> > > > MM experts to arrive at appropriate GFP_* flags (and their patience is
> > > > greatly appreciated).  Third, the paths that can allocate will do so about
> > > > one time of 500, so any issues should be spotted sooner rather than later.
> > > >
> > > > So you are quite right to be concerned, but I believe we will be doing the
> > > > right things.  And based on his previous track record, I am also quite
> > > > certain that Mr. Murphy will be on hand to provide me any additional
> > > > education that I might require.
> > > >
> > > > Finally, I have noted down your point about fs_reclaim_acquire() and
> > > > fs_reclaim_release().  Whether or not they prove to be needed, I do
> > > > appreciate your calling them to my attention.
> > >
> > > I just realized that since these dma_fence structs are refcounted and
> > > userspace can hold references (directly, it can pass them around
> > > behind file descriptors) we might never hit such a path until slightly
> > > unusual or evil userspace does something interesting. Do you have
> > > links to those patches? Some googling didn't turn up anything. I can
> > > then figure out whether it's better to risk not spotting issues with
> > > call_rcu vs slapping a memalloc_noio_save/restore around all these
> > > critical section which force-degrades any allocation to GFP_ATOMIC at
> > > most, but has the risk that we run into code that assumes "GFP_KERNEL
> > > never fails for small stuff" and has a decidedly less tested fallback
> > > path than rcu code.
> >
> > Here is the previous early draft version, which will change considerably
> > for the next version:
> >
> >         lore.kernel.org/lkml/20200809204354.20137-1-urezki@gmail.com
> >
> > This does kvfree_rcu(), but we expect to handle call_rcu() similarly.
> >
> > The version in preparation will use workqueues to do the allocation in a
> > known-safe environment and also use lockless access to certain portions
> > of the allocator caches (as noted earlier, this last is not much loved
> > by some of the MM guys).  Given Thomas's patch, we could with high
> > probability allocate directly, perhaps even not needing memory-allocator
> > modifications.
> >
> > Either way, kvfree_rcu(), and later call_rcu(), will avoid asking the
> > allocator to do anything that the calling context prohibits.  So what
> > types of bugs are you looking for?  Where reclaim calls back into the
> > driver or some such?
> 
> Yeah pretty much. It's a problem for gpu, fs, block drivers and really
> anything else that's remotely involved in memory reclaim somehow.
> Generally this is all handled explicitly by passing gfp_t flags down
> any call chain, but in some cases it's instead solved with the
> memalloc_no* functions. E.g. sunrpc uses that to make sure the network
> stack (which generally just assumes it can allocate memory) doesn't,
> to avoid recursions back into nfs/sunrpc. To my knowledge there's no
> way to check at runtime with which gfp flags you're allowed to
> allocate memory, a preemptible check is definitely not enough.
> Disabled preemption implies only GFP_ATOMIC is allowed (ignoring nmi
> and stuff like that), but the inverse is not true.

Thank you for the confirmation!

> So if you want the automagic in call_rcu I think either
> - we need to replace all explicit gfp flags with the context marking
> memalloc_no* across the entire kernel, or at least anywhere rcu might
> be used.
> - audit all callchains and make sure a call_rcu_noalloc is used
> anywhere there might be a problem. probably better to have a
> call_rcu_gfp with explicit gfp flags parameter, since generally that
> needs to be passed down.
> 
> But at least to me the lockless magic in mm sounds a lot safer, since
> it contains the complexity and doesn't leak it out to callers of
> call_rcu.

Agreed, I greatly prefer Peter Zijlstra's lockless-allocation patch
myself.

In the meantime, it looks like we will start by causing the allocation to
happen in a safe environment.  That may have issues with delays, but is
at least something that can be done entirely within the confines of RCU.

							Thanx, Paul
