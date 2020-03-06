Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6F17C357
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Mar 2020 17:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCFQ57 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 11:57:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:57193 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgCFQ57 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 11:57:59 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-20-vOmmemdGMmSebKCtFim0sQ-1; Fri, 06 Mar 2020 16:57:55 +0000
X-MC-Unique: vOmmemdGMmSebKCtFim0sQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 6 Mar 2020 16:57:55 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 6 Mar 2020 16:57:55 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@collabora.com>
CC:     Florian Weimer <fweimer@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ryao@gentoo.org" <ryao@gentoo.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "z.figura12@gmail.com" <z.figura12@gmail.com>,
        "steven@valvesoftware.com" <steven@valvesoftware.com>,
        "steven@liquorix.net" <steven@liquorix.net>,
        "malteskarupke@web.de" <malteskarupke@web.de>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: RE: 'simple' futex interface [Was: [PATCH v3 1/4] futex: Implement
 mechanism to wait on any of several futexes]
Thread-Topic: 'simple' futex interface [Was: [PATCH v3 1/4] futex: Implement
 mechanism to wait on any of several futexes]
Thread-Index: AQHV8x8l7LKRap7vfU2BMMqcavNvO6g7ya9A
Date:   Fri, 6 Mar 2020 16:57:54 +0000
Message-ID: <0271e473ddcf463bb030eb4cbecbe888@AcuMS.aculab.com>
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
 <20200305185136.GB3348@worktop.programming.kicks-ass.net>
In-Reply-To: <20200305185136.GB3348@worktop.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Peter Zijlstra
> Sent: 05 March 2020 18:52
+> On Thu, Mar 05, 2020 at 01:14:17PM -0300, André Almeida wrote:
> 
> > >   sys_futex_wait(void *uaddr, u64 val, unsigned long flags, ktime_t *timo);
> > >   struct futex_wait {
> > > 	  void *uaddr;
> > > 	  u64 val;
> > > 	  u64 flags;
> > >   };
> > >   sys_futex_waitv(struct futex_wait *waiters, unsigned int nr_waiters,
> > > 		  u64 flags, ktime_t *timo);
> > >   sys_futex_wake(void *uaddr, unsigned int nr, u64 flags);
> > >   sys_futex_cmp_requeue(void *uaddr1, void *uaddr2, unsigned int nr_wake,
> > > 		  unsigned int nr_requeue, u64 cmpval, unsigned long flags);
> > >
> > > And that makes 7 arguments for cmp_requeue, which can't be. Maybe we if
> > > combine nr_wake and nr_requeue in one as 2 u16... ?
> > >
> > > And then we need to go detector if the platform supports it or not..
> > >
> >
> > Thanks everyone for the feedback around our mechanism. Are the
> > performance benefits of implementing a syscall to wait on a single futex
> > significant enough to maintain it instead of just using
> > `sys_futex_waitv()` with `nr_waiters = 1`? If we join both cases in a
> > single interface, we may even add a new member for NUMA hint in `struct
> > futex_wait`.
> 
> My consideration was that avoiding the get_user/copy_from_user might
> become measurable on !PTI systems with SMAP.
> 
> But someone would have to build it and measure it before we can be sure
> of course.

An extra copy_from_user is likely to be noticable.
It certainly makes recvmsg() slower than recv().
Especially if the hardended usercopy crap gets involved.

	David
 

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

