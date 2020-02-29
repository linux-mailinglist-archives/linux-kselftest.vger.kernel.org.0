Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9008174631
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Feb 2020 11:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgB2K15 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Feb 2020 05:27:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38986 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgB2K14 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Feb 2020 05:27:56 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j7zLG-0006lS-TX; Sat, 29 Feb 2020 11:27:31 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 14CCF1012C4; Sat, 29 Feb 2020 11:27:30 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, dvhart@infradead.org, mingo@redhat.com,
        z.figura12@gmail.com, steven@valvesoftware.com,
        steven@liquorix.net, malteskarupke@web.de
Subject: Re: [PATCH v3 1/4] futex: Implement mechanism to wait on any of several futexes
In-Reply-To: <967d5047-2cb6-d6d8-6107-edb99a4c9696@valvesoftware.com>
References: <20200213214525.183689-1-andrealmeid@collabora.com> <20200213214525.183689-2-andrealmeid@collabora.com> <20200228190717.GM18400@hirez.programming.kicks-ass.net> <20200228194958.GO14946@hirez.programming.kicks-ass.net> <87tv3aflqm.fsf@nanos.tec.linutronix.de> <967d5047-2cb6-d6d8-6107-edb99a4c9696@valvesoftware.com>
Date:   Sat, 29 Feb 2020 11:27:30 +0100
Message-ID: <87o8thg031.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com> writes:
> On 2/28/20 1:25 PM, Thomas Gleixner wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>>> Thomas mentioned something like that, the problem is, ofcourse, that we
>>> then want to fix a whole bunch of historical ills, and the probmem
>>> becomes much bigger.
>> 
>> We keep piling features on top of an interface and mechanism which is
>> fragile as hell and horrible to maintain. Adding vectoring, multi size
>> and whatever is not making it any better.
>> 
>> There is also the long standing issue with NUMA, which we can't address
>> with the current pile at all.
>> 
>> So I'm really advocating that all involved parties sit down ASAP and
>> hash out a new and less convoluted mechanism where all the magic new
>> features can be addressed in a sane way so that the 'F' in Futex really
>> only means Fast and not some other word starting with 'F'.
>
> Are you specifically talking about the interface, or the mechanism 
> itself? Would you be OK with a new syscall that calls into the same code 
> as this patch? It does seem like that's what we want, so if we rewrote a 
> mechanism I'm not convinced it would come out any different. But, the 
> interface itself seems fair-game to rewrite, as the current futex 
> syscall is turning into an ioctl of sorts.

No, you are misreading what I said. How does a new syscall make any
difference? It still adds new crap to a maze which is already in a state
of dubious maintainability. 

> This solves a real problem with a real usecase; so I'd like to stay 
> practical and not go into deeper issues like solving NUMA support for 
> all of futex in the interest of users waiting at the other end. Can you 
> point us to your preferred approach just for the scope of what we're 
> trying to accomplish?

If we go by the argument that something solves a real use case and take
this as justification to proliferate existing crap, then we never get to
the point where things get redesigned from ground up. Quite the
contrary, we are going to duct tape it to death.

It does not matter at all whether the syscall is multiplexing or split
up into 5 different ones. That's a pure cosmetic exercise.

While all the currently proposed extensions (multiple wait, variable
size) make sense conceptually, I'm really uncomfortable to just cram
them into the existing code. They create an ABI which we have to
maintain forever.

From experience I just know that every time we extended the futex
interface we opened another can of worms which hunted us for years if
not for more then a decade. Guess who has to deal with that. Surely not
the people who drive by and solve their real world usecases. Just go and
read the changelog history of futexes very carefully and you might
understand what kind of complex beasts they are.

At some point we simply have to say stop, sit down and figure out which
kind of functionality we really need in order to solve real world user
space problems and which of the gazillion futex (mis)features are just
there as historical ballast and do not have to be supported in a new
implementation, REQUEUE is just the most obvious example.

I completely understand that you want to stay practical and just want to
solve your particular itch, but please understand that the people who
have to deal with the fallout and have dealt with it for 15+ years have
very practical reasons to say no.

Thanks,

        tglx
