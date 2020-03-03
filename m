Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E763F1776E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 14:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgCCNWP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 08:22:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgCCNWP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 08:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lm1J5n5+hScBLK9U43/eb/xDYPs2lcB12KKqXk5s7Z4=; b=APHzxd1VPHRwDBmvnXDJ0inO2d
        84Aq511ks8CXnnAYNce3jHkai6v1hWnBLyJtWSEk9BRM5Zc1QFl1kqY7EQDRUusPzey5MaU5NK7XS
        HKyaPCLZZZhjWbZfOxbmsbRlr6vwkM6Uer11AigZDjX37lG+HDqJE3PSZ/cxDsNcoBB1pvvbAzlS5
        SXMWFj0ctj6ImQnixJpfC/IfZKJwwFtjHhH//jSed5jzAnlsRiTCOVhNJExhvKCje7Q4Y4JR23rj8
        KaTc7Qw9ZVaAQspH0obkzlY5FwvR/67ec2+xzAahAZOqOeTClJ7IU6jXN0l22KNR+Ctaxooay+za1
        8cALbTRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j97Ug-0006Jh-4i; Tue, 03 Mar 2020 13:21:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFC6E3013A4;
        Tue,  3 Mar 2020 14:19:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E99B0210C2866; Tue,  3 Mar 2020 14:21:50 +0100 (CET)
Date:   Tue, 3 Mar 2020 14:21:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, dvhart@infradead.org, mingo@redhat.com,
        z.figura12@gmail.com, steven@valvesoftware.com,
        steven@liquorix.net, malteskarupke@web.de, carlos@redhat.com,
        adhemerval.zanella@linaro.org, libc-alpha@sourceware.org
Subject: Re: 'simple' futex interface [Was: [PATCH v3 1/4] futex: Implement
 mechanism to wait on any of several futexes]
Message-ID: <20200303132150.GD2596@hirez.programming.kicks-ass.net>
References: <20200213214525.183689-1-andrealmeid@collabora.com>
 <20200213214525.183689-2-andrealmeid@collabora.com>
 <20200228190717.GM18400@hirez.programming.kicks-ass.net>
 <20200228194958.GO14946@hirez.programming.kicks-ass.net>
 <87tv3aflqm.fsf@nanos.tec.linutronix.de>
 <967d5047-2cb6-d6d8-6107-edb99a4c9696@valvesoftware.com>
 <87o8thg031.fsf@nanos.tec.linutronix.de>
 <beb82055-96fa-cb64-a06e-9d7a0946587b@valvesoftware.com>
 <20200303120050.GC2596@hirez.programming.kicks-ass.net>
 <87pndth9ur.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pndth9ur.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 03, 2020 at 02:00:12PM +0100, Florian Weimer wrote:
> * Peter Zijlstra:
> 
> > So how about we introduce new syscalls:
> >
> >   sys_futex_wait(void *uaddr, unsigned long val, unsigned long flags, ktime_t *timo);
> >
> >   struct futex_wait {
> > 	void *uaddr;
> > 	unsigned long val;
> > 	unsigned long flags;
> >   };
> >   sys_futex_waitv(struct futex_wait *waiters, unsigned int nr_waiters,
> > 		  unsigned long flags, ktime_t *timo);
> >
> >   sys_futex_wake(void *uaddr, unsigned int nr, unsigned long flags);
> >
> >   sys_futex_cmp_requeue(void *uaddr1, void *uaddr2, unsigned int nr_wake,
> > 			unsigned int nr_requeue, unsigned long cmpval, unsigned long flags);
> >
> > Where flags:
> >
> >   - has 2 bits for size: 8,16,32,64
> >   - has 2 more bits for size (requeue) ??
> >   - has ... bits for clocks
> >   - has private/shared
> >   - has numa
> 
> What's the actual type of *uaddr?  Does it vary by size (which I assume
> is in bits?)?  Are there alignment constraints?

Yeah, u8, u16, u32, u64 depending on the size specified in flags.
Naturally aligned.

> These system calls seemed to be type-polymorphic still, which is
> problematic for defining a really nice C interface.  I would really like
> to have a strongly typed interface for this, with a nice struct futex
> wrapper type (even if it means that we need four of them).

You mean like: futex_wait1(u8 *,...) futex_wait2(u16 *,...)
futex_wait4(u32 *,...) etc.. ?

I suppose making it 16 or so syscalls (more if we want WAKE_OP or
requeue across size) is a bit daft, so yeah, sucks.

> Will all architectures support all sizes?  If not, how do we probe which
> size/flags combinations are supported?

Up to the native word size (long), IOW ILP32 will not support u64.

Overlapping futexes are expressly forbidden, that is:

{
	u32 var;
	void *addr = &var;
}

P0()
{
	futex_wait4(addr,...);
}

P1()
{
	futex_wait1(addr+1,...);
}

Will have one of them return something bad.


> > For NUMA I propose that when NUMA_FLAG is set, uaddr-4 will be 'int
> > node_id', with the following semantics:
> >
> >  - on WAIT, node_id is read and when 0 <= node_id <= nr_nodes, is
> >    directly used to index into per-node hash-tables. When -1, it is
> >    replaced by the current node_id and an smp_mb() is issued before we
> >    load and compare the @uaddr.
> >
> >  - on WAKE/REQUEUE, it is an immediate index.
> 
> Does this mean the first waiter determines the NUMA index, and all
> future waiters use the same chain even if they are on different nodes?

Every new waiter could (re)set node_id, after all, when its not actually
waiting, nobody cares what's in that field.

> I think documenting this as a node index would be a mistake.  It could
> be an arbitrary hint for locating the corresponding kernel data
> structures.

Nah, it allows explicit placement, after all, we have set_mempolicy()
and sched_setaffinity() and all the other NUMA crud so that programs
that think they know what they're doing, can do explicit placement.

> > Any invalid value with result in EINVAL.
> 
> Using uaddr-4 is slightly tricky with a 64-bit futex value, due to the
> need to maintain alignment and avoid padding.

Yes, but it works, unlike uaddr+4 :-) Also, 1 and 2 byte futexes and
NUMA_FLAG are incompatible due to this, but I feel short futexes and
NUMA don't really make sense anyway, the only reason to use a short
futex is to save space, so you don't want another 4 bytes for numa on
top of that anyway.

