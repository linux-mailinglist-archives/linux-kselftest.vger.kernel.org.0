Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0BF39C0FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jun 2021 22:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhFDUDC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Jun 2021 16:03:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39208 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDUDB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Jun 2021 16:03:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 7D2901F43C76
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     acme@kernel.org, Andrey Semashev <andrey.semashev@gmail.com>,
        corbet@lwn.net, Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        malteskarupke@fastmail.fm, pgriffais@valvesoftware.com,
        Peter Oskolkov <posk@posk.io>, shuah@kernel.org,
        z.figura12@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
Date:   Fri, 4 Jun 2021 17:01:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622799088.hsuspipe84.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Às 08:36 de 04/06/21, Nicholas Piggin escreveu:
> Excerpts from André Almeida's message of June 4, 2021 5:59 am:
>> Hi,
>>
>> This patch series introduces the futex2 syscalls.
>>
>> * What happened to the current futex()?
>>
>> For some years now, developers have been trying to add new features to
>> futex, but maintainers have been reluctant to accept then, given the
>> multiplexed interface full of legacy features and tricky to do big
>> changes. Some problems that people tried to address with patchsets are:
>> NUMA-awareness[0], smaller sized futexes[1], wait on multiple futexes[2].
>> NUMA, for instance, just doesn't fit the current API in a reasonable
>> way. Considering that, it's not possible to merge new features into the
>> current futex.
>>
>>  ** The NUMA problem
>>
>>  At the current implementation, all futex kernel side infrastructure is
>>  stored on a single node. Given that, all futex() calls issued by
>>  processors that aren't located on that node will have a memory access
>>  penalty when doing it.
>>
>>  ** The 32bit sized futex problem
>>
>>  Futexes are used to implement atomic operations in userspace.
>>  Supporting 8, 16, 32 and 64 bit sized futexes allows user libraries to
>>  implement all those sizes in a performant way. Thanks Boost devs for
>>  feedback: https://lists.boost.org/Archives/boost/2021/05/251508.php
>>
>>  Embedded systems or anything with memory constrains could benefit of
>>  using smaller sizes for the futex userspace integer.
>>
>>  ** The wait on multiple problem
>>
>>  The use case lies in the Wine implementation of the Windows NT interface
>>  WaitMultipleObjects. This Windows API function allows a thread to sleep
>>  waiting on the first of a set of event sources (mutexes, timers, signal,
>>  console input, etc) to signal.  Considering this is a primitive
>>  synchronization operation for Windows applications, being able to quickly
>>  signal events on the producer side, and quickly go to sleep on the
>>  consumer side is essential for good performance of those running over Wine.
>>
>> [0] https://lore.kernel.org/lkml/20160505204230.932454245@linutronix.de/
>> [1] https://lore.kernel.org/lkml/20191221155659.3159-2-malteskarupke@web.de/
>> [2] https://lore.kernel.org/lkml/20200213214525.183689-1-andrealmeid@collabora.com/
>>
>> * The solution
>>
>> As proposed by Peter Zijlstra and Florian Weimer[3], a new interface
>> is required to solve this, which must be designed with those features in
>> mind. futex2() is that interface. As opposed to the current multiplexed
>> interface, the new one should have one syscall per operation. This will
>> allow the maintainability of the API if it gets extended, and will help
>> users with type checking of arguments.
>>
>> In particular, the new interface is extended to support the ability to
>> wait on any of a list of futexes at a time, which could be seen as a
>> vectored extension of the FUTEX_WAIT semantics.
>>
>> [3] https://lore.kernel.org/lkml/20200303120050.GC2596@hirez.programming.kicks-ass.net/
>>
>> * The interface
>>
>> The new interface can be seen in details in the following patches, but
>> this is a high level summary of what the interface can do:
>>
>>  - Supports wake/wait semantics, as in futex()
>>  - Supports requeue operations, similarly as FUTEX_CMP_REQUEUE, but with
>>    individual flags for each address
>>  - Supports waiting for a vector of futexes, using a new syscall named
>>    futex_waitv()
>>  - Supports variable sized futexes (8bits, 16bits, 32bits and 64bits)
>>  - Supports NUMA-awareness operations, where the user can specify on
>>    which memory node would like to operate
> 
> A few comments.
> 
> - Do you need a syscall for wait and for waitv, or can wait just be a
> degenerate case of waitv (which could use the stack variable)?  I guess
> it does save the user access unlock.
> 

Yes. waitv with one element has a overhead compared to wait, given the
extra user_copy(). Given that waiting on a single futex is the common
case, I think it's worth to have it.

> - Did you consider a wakev interface? An example is a read-write mutex 
> which has read-blocking futexes split (e.g., per-node) for scalability 
> then the writer may unlock and wake all readers with one call. We 
> actually have some scalability challenges of this nature with certain 
> large database programs.
> 

Not really, I haven't heard any use case for that until now. It should
be easy to implement it, though, and I think you have an interesting use
case here. Could you point me some of those database programs?

> - Great to see 64-bit support in, it is helpful to do some interesting 
> things with locks without hacks (e.g., putting an address in the lock 
> word).
> 
> - Are we really keen on squashing node ID into flags in this day and age?
> I guess okay but seems like it would be nice to allow a bit more space
> in general for the operations. I don't want to turn it into a whole big
> multiplexing nightmare again with lots of such flags, or propose
> complexity with no code behind it, but I think we need a bit of leeway
> for unforeseen locking innovations to be added carefully. The pthread
> locking today is still fairly primitive really, I don't think we know
> what will work best for the next 10 years.

In the interface that I'd proposed, the node ID isn't part of the flags.
You have a flag FUTEX_FLAG_NUMA, and when that is used, you pass in
`void *uaddr` a pointer to a `struct futex_numa { int value, int hint
}`, where hint should be the node ID you would like to work on, and
value is just the userspace futex. This is documented in more details in
patch 7 "docs: locking: futex2: Add documentation".

If you have any feedback about how this NUMA interface looks like, I
would like to hear.

Also, did something in my writing indicated that the node ID would be
part of the flags? I'll improve this it if so.

> 
> One scalability issue we are starting to hit and will only get worse is 
> futex queue spinlock contention. Perhaps this is better addressed in 
> userspace but the kernel could play a part so I like to leave some doors
> open. One example is that the wait (or wake) side may like to depend not
> just on the memory value, but on the success of a cmpxchg to avoid 
> unqueueing and queueing spuriously, which increases lock contention but
> also ends up putting the poor task on the back of the list -- yes RT
> priorities can help the realtime case, but non-RT cases can get bad
> outlier latencies if lock stealing is allowed (which can be very good
> for performance).
> 

Sorry, I'm not sure what do you mean here. Are you proposing to have a
cmpxchg in kernel side, so the lock would be taken by the kernel, and
not by the userspace like it's now?

> - The private global futex hash table sucks for various reasons, and
> having 128 waiters per thread makes it orders of magnitude easier for
> userspace to DoS stuff with hash collisions. NUMA doesn't fix that, the
> per process hashing that Thomas suggested does fix the DoS but the
> non-deterministic hash collisions still seem to be a problem for real
> time response, and at the other end of the scale some apps (certain 
> databases, etc) can have ten thousand futex waiters at once so birthday
> paradox can also lead to guaranteed (low level) variable beahviour 
> within a single process.
> 
> I know the kernel in general is not very robust against this kind of 
> DoS/nondeterminism, but it's a bit sad to introduce new APIs with the 
> problem still there. Yes we could address it later, but I think it's 
> better done first because the solution might influence what the best 
> syscall API is.
> 
> For example the idea of using the address as the handle for the wait 
> queue _and_ the value is very convenient but hashing is annoying for
> all the above reasons and the shared wait queue case is pretty clunky. 
> It's also constraining in some corner cases to have the wait queue 
> associated with the address 1:1. For example a type of NUMA mutex might 
> want to have per-node waitqueues associated with a lock word, and wake
> local node waiters 99% of the time. Not trivial to do with futexes and
> seems to at least require bouncing of more cache lines, possibly more
> atomics, etc.
> 
> Could anything else be done?

I wasn't aware that userspace doing DoS is something to be concerned
from the kernel point of view. Is this scenario considering a malicious
actor? If so, there are plenty of resources to be denied, so not sure
how futex could be protected of this. Or is this just a program that
uses tons of futexes?

> 
> I'll be burned at the stake for suggesting it but it would be great if 
> we could use file descriptors. At least for the shared futex, maybe 
> private could use a per-process futex allocator. It solves all of the
> above, although I'm sure has many of its own problem. It may not play
> so nicely with the pthread mutex API because of the whole static
> initialiser problem, but the first futex proposal did use fds. But it's
> an example of an alternate API.
> 

FDs and futex doesn't play well, because for futex_wait() you need to
tell the kernel the expected value in the futex address to avoid
sleeping in a free lock. FD operations (poll, select) don't have this
`value` argument, so they could sleep forever, but I'm not sure if you
had taken this in consideration.

> And.. thanks for the great work, apologies if I missed some discussion
> related to the above comments, I did some reading but I know there has
> been a lot of discussions going on.
> 

:) and thank you for the valuable feedback and detailed ideas!

> Thanks,
> Nick
> 
