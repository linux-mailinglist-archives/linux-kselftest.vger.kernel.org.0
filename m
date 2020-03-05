Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DBA17AE84
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 19:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCESvx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 13:51:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCESvx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 13:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Yn5/IW3OYHf5EUn3GzmHogT1LV9Dftj667FAvQnTKI4=; b=VVk6ByjsRM3wpWY+qvfeAVvFex
        XSR3Yje5R00vVodKBhThEv3KsINHfdyK4sDscmpZv3NRJq5tIIABEiVi6J/lt6WJh2neZ//CU+xSB
        rECagYV5W63kkDmeLBsfyRon75GkhHqJkKSGoJ46JVs87XqpW19FnOFHt5Pb6lkgecjeDhebwIxD8
        smPH00JfG0iTvdM6x1U4xwQTwATpB7D5Fj+9WzRaT3+tdzn9MRsVeFpcD07fiTbCRWzLw2l4Tv5Mb
        t2hFpnkyadlZ6M6P8MxkYKd60qZwJMVKFn+tMcVe3efktI5e/147Vgg9+G1/63fiSBRGQQW0Z1GBk
        oW6khrUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9vas-0005bE-DZ; Thu, 05 Mar 2020 18:51:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FE8E980EDA; Thu,  5 Mar 2020 19:51:36 +0100 (CET)
Date:   Thu, 5 Mar 2020 19:51:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, dvhart@infradead.org, mingo@redhat.com,
        z.figura12@gmail.com, steven@valvesoftware.com,
        steven@liquorix.net, malteskarupke@web.de, carlos@redhat.com,
        adhemerval.zanella@linaro.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org
Subject: Re: 'simple' futex interface [Was: [PATCH v3 1/4] futex: Implement
 mechanism to wait on any of several futexes]
Message-ID: <20200305185136.GB3348@worktop.programming.kicks-ass.net>
References: <87tv3aflqm.fsf@nanos.tec.linutronix.de>
 <967d5047-2cb6-d6d8-6107-edb99a4c9696@valvesoftware.com>
 <87o8thg031.fsf@nanos.tec.linutronix.de>
 <beb82055-96fa-cb64-a06e-9d7a0946587b@valvesoftware.com>
 <20200303120050.GC2596@hirez.programming.kicks-ass.net>
 <87pndth9ur.fsf@oldenburg2.str.redhat.com>
 <20200303132150.GD2596@hirez.programming.kicks-ass.net>
 <878skhh7og.fsf@oldenburg2.str.redhat.com>
 <20200303150104.GE2596@hirez.programming.kicks-ass.net>
 <52406c54-60b3-dcfe-65d8-4c425459e37b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52406c54-60b3-dcfe-65d8-4c425459e37b@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 05, 2020 at 01:14:17PM -0300, André Almeida wrote:

> >   sys_futex_wait(void *uaddr, u64 val, unsigned long flags, ktime_t *timo);
> >   struct futex_wait {
> > 	  void *uaddr;
> > 	  u64 val;
> > 	  u64 flags;
> >   };
> >   sys_futex_waitv(struct futex_wait *waiters, unsigned int nr_waiters,
> > 		  u64 flags, ktime_t *timo);
> >   sys_futex_wake(void *uaddr, unsigned int nr, u64 flags);
> >   sys_futex_cmp_requeue(void *uaddr1, void *uaddr2, unsigned int nr_wake,
> > 		  unsigned int nr_requeue, u64 cmpval, unsigned long flags);
> > 
> > And that makes 7 arguments for cmp_requeue, which can't be. Maybe we if
> > combine nr_wake and nr_requeue in one as 2 u16... ?
> > 
> > And then we need to go detector if the platform supports it or not..
> > 
> 
> Thanks everyone for the feedback around our mechanism. Are the
> performance benefits of implementing a syscall to wait on a single futex
> significant enough to maintain it instead of just using
> `sys_futex_waitv()` with `nr_waiters = 1`? If we join both cases in a
> single interface, we may even add a new member for NUMA hint in `struct
> futex_wait`.

My consideration was that avoiding the get_user/copy_from_user might
become measurable on !PTI systems with SMAP.

But someone would have to build it and measure it before we can be sure
of course.
