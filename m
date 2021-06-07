Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231B639E0FD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jun 2021 17:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFGPnO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Jun 2021 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhFGPnB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Jun 2021 11:43:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F40C061283;
        Mon,  7 Jun 2021 08:41:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 4532A1F4156E
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     acme@kernel.org, Andrey Semashev <andrey.semashev@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        pgriffais@valvesoftware.com, Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
Date:   Mon, 7 Jun 2021 12:40:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622853816.mokf23xgnt.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Às 22:09 de 04/06/21, Nicholas Piggin escreveu:
> Excerpts from André Almeida's message of June 5, 2021 6:01 am:
>> Às 08:36 de 04/06/21, Nicholas Piggin escreveu:
>>> Excerpts from André Almeida's message of June 4, 2021 5:59 am:
>>> - Did you consider a wakev interface? An example is a read-write mutex 
>>> which has read-blocking futexes split (e.g., per-node) for scalability 
>>> then the writer may unlock and wake all readers with one call. We 
>>> actually have some scalability challenges of this nature with certain 
>>> large database programs.
>>>
>>
>> Not really, I haven't heard any use case for that until now. It should
>> be easy to implement it, though, and I think you have an interesting use
>> case here. Could you point me some of those database programs?
> 
> Not source code unfortunately. I know that's not a very good answer, but 
> they are far ahead of what most open source apps are doing scalability 
> wise today, and they end up rolling their own complex locking. Hopefully
> the example I give is simple enough to understand.
> 

I see, that's makes things a bit harder. I understood the use case and
the wakev can be implemented without affecting the rest of API, so I
think I'll get back to it later, for now.

>>>
>>> - Are we really keen on squashing node ID into flags in this day and age?
>>> I guess okay but seems like it would be nice to allow a bit more space
>>> in general for the operations. I don't want to turn it into a whole big
>>> multiplexing nightmare again with lots of such flags, or propose
>>> complexity with no code behind it, but I think we need a bit of leeway
>>> for unforeseen locking innovations to be added carefully. The pthread
>>> locking today is still fairly primitive really, I don't think we know
>>> what will work best for the next 10 years.
>>
>> In the interface that I'd proposed, the node ID isn't part of the flags.
>> You have a flag FUTEX_FLAG_NUMA, and when that is used, you pass in
>> `void *uaddr` a pointer to a `struct futex_numa { int value, int hint
>> }`, where hint should be the node ID you would like to work on, and
>> value is just the userspace futex. This is documented in more details in
>> patch 7 "docs: locking: futex2: Add documentation".
>>
>> If you have any feedback about how this NUMA interface looks like, I
>> would like to hear.
>>
>> Also, did something in my writing indicated that the node ID would be
>> part of the flags? I'll improve this it if so.
> 
> Oh I did miss this, thank you. No it wasn't your writing, I think it was 
> me trying to read through a lot of messages and got confused with some
> earlier conversations.
> 
> I'll look a bit more at the NUMA interface.
> 

Thanks!

>>
>>>
>>> One scalability issue we are starting to hit and will only get worse is 
>>> futex queue spinlock contention. Perhaps this is better addressed in 
>>> userspace but the kernel could play a part so I like to leave some doors
>>> open. One example is that the wait (or wake) side may like to depend not
>>> just on the memory value, but on the success of a cmpxchg to avoid 
>>> unqueueing and queueing spuriously, which increases lock contention but
>>> also ends up putting the poor task on the back of the list -- yes RT
>>> priorities can help the realtime case, but non-RT cases can get bad
>>> outlier latencies if lock stealing is allowed (which can be very good
>>> for performance).
>>>
>>
>> Sorry, I'm not sure what do you mean here. Are you proposing to have a
>> cmpxchg in kernel side, so the lock would be taken by the kernel, and
>> not by the userspace like it's now?
> 
> Yes. Only in slow paths, of course, to reduce starvation / erratic
> latencies and spurious wait queue manipulations.

Right, so if we need to go into the kernel to do the cmpxchg, we can't
take a free lock without a syscall, and this goes against the futex
semantics, the "strength" of this interface is to not require context
switch in uncontended cases.

Is not a bad thing itself to go into the kernel to get a lock, other
operating systems do that and if the kernel has more knowledge about who
has the lock, it can even make some smart decisions. But this is not
futex, this probably belongs to another interface (that's probably
slower in the common case than futex).

> 
> Actually one other scalability thing while I remember it:
> 
> futex_wait currently requires that the lock word is tested under the 
> queue spin lock (to avoid consuming a wakeup). The problem with this is 
> that the lock word can be a very hot cache line if you have a lot of
> concurrency, so accessing it under the queue lock can increase queue
> lock hold time.
> 
> I would prefer if the new API was relaxed to avoid this restriction
> (e.g., any wait call may consume a wakeup so it's up to userspace to
> avoid that if it is a problem).

Maybe I'm wrong, but AFAIK the goal of checking the lock word inside the
spin lock is to avoid sleeping forever (in other words, wrongly assuming
that the lock is taken and missing a wakeup call), not to avoid
consuming wakeups. Or at least this is my interpretation of this long
comment in futex.c:

https://elixir.bootlin.com/linux/v5.12.9/source/kernel/futex.c#L51

So removing this requirement of checking the futex word with the lock
taken could led to undesirable behavior.

> 
>>> - The private global futex hash table sucks for various reasons, and
>>> having 128 waiters per thread makes it orders of magnitude easier for
>>> userspace to DoS stuff with hash collisions. NUMA doesn't fix that, the
>>> per process hashing that Thomas suggested does fix the DoS but the
>>> non-deterministic hash collisions still seem to be a problem for real
>>> time response, and at the other end of the scale some apps (certain 
>>> databases, etc) can have ten thousand futex waiters at once so birthday
>>> paradox can also lead to guaranteed (low level) variable beahviour 
>>> within a single process.
>>>
>>> I know the kernel in general is not very robust against this kind of 
>>> DoS/nondeterminism, but it's a bit sad to introduce new APIs with the 
>>> problem still there. Yes we could address it later, but I think it's 
>>> better done first because the solution might influence what the best 
>>> syscall API is.
>>>
>>> For example the idea of using the address as the handle for the wait 
>>> queue _and_ the value is very convenient but hashing is annoying for
>>> all the above reasons and the shared wait queue case is pretty clunky. 
>>> It's also constraining in some corner cases to have the wait queue 
>>> associated with the address 1:1. For example a type of NUMA mutex might 
>>> want to have per-node waitqueues associated with a lock word, and wake
>>> local node waiters 99% of the time. Not trivial to do with futexes and
>>> seems to at least require bouncing of more cache lines, possibly more
>>> atomics, etc.
>>>
>>> Could anything else be done?
>>
>> I wasn't aware that userspace doing DoS is something to be concerned
>> from the kernel point of view. Is this scenario considering a malicious
>> actor? If so, there are plenty of resources to be denied, so not sure
>> how futex could be protected of this. Or is this just a program that
>> uses tons of futexes?
> 
> Both really. AFAIKS one of the efforts that prompted the futex 
> modernisation work was the RT latency issues from Thomas in 2016 when 
> the per process table was proposed.
> 

When I first read Thomas proposal for per table process, I thought that
the main goal there was to solve NUMA locality issues, not RT latency,
but I think you are right. However, re-reading the thread at [0], it
seems that the RT problems where not completely solved in that
interface, maybe the people involved with that patchset can help to shed
some light on it.

Otherwise, this same proposal could be integrated in futex2, given that
we would only need to provide to userland some extra flags and add some
`if`s around the hash table code (in a very similar way the NUMA code
will be implemented in futex2).

[0] https://lore.kernel.org/lkml/20160505204230.932454245@linutronix.de/

> 
>>> I'll be burned at the stake for suggesting it but it would be great if 
>>> we could use file descriptors. At least for the shared futex, maybe 
>>> private could use a per-process futex allocator. It solves all of the
>>> above, although I'm sure has many of its own problem. It may not play
>>> so nicely with the pthread mutex API because of the whole static
>>> initialiser problem, but the first futex proposal did use fds. But it's
>>> an example of an alternate API.
>>>
>>
>> FDs and futex doesn't play well, because for futex_wait() you need to
>> tell the kernel the expected value in the futex address to avoid
>> sleeping in a free lock. FD operations (poll, select) don't have this
>> `value` argument, so they could sleep forever, but I'm not sure if you
>> had taken this in consideration.
> 
> I had. The futex wait API would take a fd additional. The only 
> difference is the waitqueue that is used when a sleep or wake is 
> required is derived from the fd, not from an address.
> 
> I think the bigger sticking points would be if it's too heavyweight an 
> object to use (which could be somewhat mitigated with a simpler ida
> allocator although that's difficult to do with shared), and whether libc
> could sanely use them due to the static initialiser problem of pthread
> mutexes.
> 
> Thanks,
> Nick
> 
