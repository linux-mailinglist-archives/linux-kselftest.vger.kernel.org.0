Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B411339C4B9
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jun 2021 03:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhFEBLr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Jun 2021 21:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFEBLr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Jun 2021 21:11:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E233C061766;
        Fri,  4 Jun 2021 18:09:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so8380038pjz.3;
        Fri, 04 Jun 2021 18:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=+ymcPBkFzODnVXwuUwD5PtjbB+QQ9q8/HCoXcbiRNhs=;
        b=J79OZPj1yrF4atqaUyHZvNrQpi7R8arRnaxWxYWRcs8cvvkYluOFGH3cVhQb4u/fFB
         /JANEX5qjMf5WpmmaYiI6N4T0ww7ToXIllFLSTzWLeSgMWjZnFl62FJff//Mf9kp67rG
         O64lpPtVIfSgmnP7iCcBRq9HVygJBYdjsJ0Y3MF1Ikr/D1otLP5Wm8qZ7r0CQyyFmotI
         7TocXIb6c5JGvejbCcNs+OO8BJ10zQk78J5GwuD/+UIfu7qJBLM6pJzVFviTgdpNy5xI
         V58VYaz8xvJ/vfeHblpPGzEdDpYG3h9UCn2LojjqgllRriWA30Acii79itxjEt8gAqhV
         8SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=+ymcPBkFzODnVXwuUwD5PtjbB+QQ9q8/HCoXcbiRNhs=;
        b=h5FS9lXqa6QySGn7+ebHBjXXjojepOr2WWi86qapUODZay7TYn65FubxuGeRgde2l+
         4U1fSLcc7SesKsIX/xcUOJNAsP1JO77BieQOztTe1Y5AwzmbXooMa7xqyeLrIjb035Qh
         xChXiHbGvcG+ndeXnny6yHRuYQz00y4WZh0bTPHj8YeNWOOpHAtEBlzriPRC7/W/1ivv
         KMJfr2LOkbz7PhaYPjarODqLxXK+DuQls8/90i3iyFl5Vq1H6Ihh0MChofOsDd/ubQT3
         woWlfd72+QMCXUrUWRNfUiMipAHCucTGt5qqKbG5/z0rZn6KvAsWe3fUepWP0IqchxRg
         x85g==
X-Gm-Message-State: AOAM530iyIZrbNPznb9C1jBVvO6Si/H8kJzRVWx0RDyGsOA5nsoNpII4
        3UJZtf5frDUuUnthiehG1xZEHfNeZtU=
X-Google-Smtp-Source: ABdhPJyB3RkL7XEtTxQkrqNjWJLnPnWa4hmpCz+oxnl97Ql7j+jLd33lGAKu1ki14J3yzUZiH+IRmg==
X-Received: by 2002:a17:90b:33d1:: with SMTP id lk17mr7759723pjb.154.1622855390928;
        Fri, 04 Jun 2021 18:09:50 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id s9sm2607668pfm.120.2021.06.04.18.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:09:50 -0700 (PDT)
Date:   Sat, 05 Jun 2021 11:09:45 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     =?iso-8859-1?b?QW5kcuk=?= Almeida <andrealmeid@collabora.com>
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
In-Reply-To: <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
MIME-Version: 1.0
Message-Id: <1622853816.mokf23xgnt.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Excerpts from Andr=C3=A9 Almeida's message of June 5, 2021 6:01 am:
> =C3=80s 08:36 de 04/06/21, Nicholas Piggin escreveu:
>> Excerpts from Andr=C3=A9 Almeida's message of June 4, 2021 5:59 am:
>>> Hi,
>>>
>>> This patch series introduces the futex2 syscalls.
>>>
>>> * What happened to the current futex()?
>>>
>>> For some years now, developers have been trying to add new features to
>>> futex, but maintainers have been reluctant to accept then, given the
>>> multiplexed interface full of legacy features and tricky to do big
>>> changes. Some problems that people tried to address with patchsets are:
>>> NUMA-awareness[0], smaller sized futexes[1], wait on multiple futexes[2=
].
>>> NUMA, for instance, just doesn't fit the current API in a reasonable
>>> way. Considering that, it's not possible to merge new features into the
>>> current futex.
>>>
>>>  ** The NUMA problem
>>>
>>>  At the current implementation, all futex kernel side infrastructure is
>>>  stored on a single node. Given that, all futex() calls issued by
>>>  processors that aren't located on that node will have a memory access
>>>  penalty when doing it.
>>>
>>>  ** The 32bit sized futex problem
>>>
>>>  Futexes are used to implement atomic operations in userspace.
>>>  Supporting 8, 16, 32 and 64 bit sized futexes allows user libraries to
>>>  implement all those sizes in a performant way. Thanks Boost devs for
>>>  feedback: https://lists.boost.org/Archives/boost/2021/05/251508.php
>>>
>>>  Embedded systems or anything with memory constrains could benefit of
>>>  using smaller sizes for the futex userspace integer.
>>>
>>>  ** The wait on multiple problem
>>>
>>>  The use case lies in the Wine implementation of the Windows NT interfa=
ce
>>>  WaitMultipleObjects. This Windows API function allows a thread to slee=
p
>>>  waiting on the first of a set of event sources (mutexes, timers, signa=
l,
>>>  console input, etc) to signal.  Considering this is a primitive
>>>  synchronization operation for Windows applications, being able to quic=
kly
>>>  signal events on the producer side, and quickly go to sleep on the
>>>  consumer side is essential for good performance of those running over =
Wine.
>>>
>>> [0] https://lore.kernel.org/lkml/20160505204230.932454245@linutronix.de=
/
>>> [1] https://lore.kernel.org/lkml/20191221155659.3159-2-malteskarupke@we=
b.de/
>>> [2] https://lore.kernel.org/lkml/20200213214525.183689-1-andrealmeid@co=
llabora.com/
>>>
>>> * The solution
>>>
>>> As proposed by Peter Zijlstra and Florian Weimer[3], a new interface
>>> is required to solve this, which must be designed with those features i=
n
>>> mind. futex2() is that interface. As opposed to the current multiplexed
>>> interface, the new one should have one syscall per operation. This will
>>> allow the maintainability of the API if it gets extended, and will help
>>> users with type checking of arguments.
>>>
>>> In particular, the new interface is extended to support the ability to
>>> wait on any of a list of futexes at a time, which could be seen as a
>>> vectored extension of the FUTEX_WAIT semantics.
>>>
>>> [3] https://lore.kernel.org/lkml/20200303120050.GC2596@hirez.programmin=
g.kicks-ass.net/
>>>
>>> * The interface
>>>
>>> The new interface can be seen in details in the following patches, but
>>> this is a high level summary of what the interface can do:
>>>
>>>  - Supports wake/wait semantics, as in futex()
>>>  - Supports requeue operations, similarly as FUTEX_CMP_REQUEUE, but wit=
h
>>>    individual flags for each address
>>>  - Supports waiting for a vector of futexes, using a new syscall named
>>>    futex_waitv()
>>>  - Supports variable sized futexes (8bits, 16bits, 32bits and 64bits)
>>>  - Supports NUMA-awareness operations, where the user can specify on
>>>    which memory node would like to operate
>>=20
>> A few comments.
>>=20
>> - Do you need a syscall for wait and for waitv, or can wait just be a
>> degenerate case of waitv (which could use the stack variable)?  I guess
>> it does save the user access unlock.
>>=20
>=20
> Yes. waitv with one element has a overhead compared to wait, given the
> extra user_copy(). Given that waiting on a single futex is the common
> case, I think it's worth to have it.

Okay.

>> - Did you consider a wakev interface? An example is a read-write mutex=20
>> which has read-blocking futexes split (e.g., per-node) for scalability=20
>> then the writer may unlock and wake all readers with one call. We=20
>> actually have some scalability challenges of this nature with certain=20
>> large database programs.
>>=20
>=20
> Not really, I haven't heard any use case for that until now. It should
> be easy to implement it, though, and I think you have an interesting use
> case here. Could you point me some of those database programs?

Not source code unfortunately. I know that's not a very good answer, but=20
they are far ahead of what most open source apps are doing scalability=20
wise today, and they end up rolling their own complex locking. Hopefully
the example I give is simple enough to understand.

>=20
>> - Great to see 64-bit support in, it is helpful to do some interesting=20
>> things with locks without hacks (e.g., putting an address in the lock=20
>> word).
>>=20
>> - Are we really keen on squashing node ID into flags in this day and age=
?
>> I guess okay but seems like it would be nice to allow a bit more space
>> in general for the operations. I don't want to turn it into a whole big
>> multiplexing nightmare again with lots of such flags, or propose
>> complexity with no code behind it, but I think we need a bit of leeway
>> for unforeseen locking innovations to be added carefully. The pthread
>> locking today is still fairly primitive really, I don't think we know
>> what will work best for the next 10 years.
>=20
> In the interface that I'd proposed, the node ID isn't part of the flags.
> You have a flag FUTEX_FLAG_NUMA, and when that is used, you pass in
> `void *uaddr` a pointer to a `struct futex_numa { int value, int hint
> }`, where hint should be the node ID you would like to work on, and
> value is just the userspace futex. This is documented in more details in
> patch 7 "docs: locking: futex2: Add documentation".
>=20
> If you have any feedback about how this NUMA interface looks like, I
> would like to hear.
>=20
> Also, did something in my writing indicated that the node ID would be
> part of the flags? I'll improve this it if so.

Oh I did miss this, thank you. No it wasn't your writing, I think it was=20
me trying to read through a lot of messages and got confused with some
earlier conversations.

I'll look a bit more at the NUMA interface.

>=20
>>=20
>> One scalability issue we are starting to hit and will only get worse is=20
>> futex queue spinlock contention. Perhaps this is better addressed in=20
>> userspace but the kernel could play a part so I like to leave some doors
>> open. One example is that the wait (or wake) side may like to depend not
>> just on the memory value, but on the success of a cmpxchg to avoid=20
>> unqueueing and queueing spuriously, which increases lock contention but
>> also ends up putting the poor task on the back of the list -- yes RT
>> priorities can help the realtime case, but non-RT cases can get bad
>> outlier latencies if lock stealing is allowed (which can be very good
>> for performance).
>>=20
>=20
> Sorry, I'm not sure what do you mean here. Are you proposing to have a
> cmpxchg in kernel side, so the lock would be taken by the kernel, and
> not by the userspace like it's now?

Yes. Only in slow paths, of course, to reduce starvation / erratic
latencies and spurious wait queue manipulations.

Actually one other scalability thing while I remember it:

futex_wait currently requires that the lock word is tested under the=20
queue spin lock (to avoid consuming a wakeup). The problem with this is=20
that the lock word can be a very hot cache line if you have a lot of
concurrency, so accessing it under the queue lock can increase queue
lock hold time.

I would prefer if the new API was relaxed to avoid this restriction
(e.g., any wait call may consume a wakeup so it's up to userspace to
avoid that if it is a problem).

>> - The private global futex hash table sucks for various reasons, and
>> having 128 waiters per thread makes it orders of magnitude easier for
>> userspace to DoS stuff with hash collisions. NUMA doesn't fix that, the
>> per process hashing that Thomas suggested does fix the DoS but the
>> non-deterministic hash collisions still seem to be a problem for real
>> time response, and at the other end of the scale some apps (certain=20
>> databases, etc) can have ten thousand futex waiters at once so birthday
>> paradox can also lead to guaranteed (low level) variable beahviour=20
>> within a single process.
>>=20
>> I know the kernel in general is not very robust against this kind of=20
>> DoS/nondeterminism, but it's a bit sad to introduce new APIs with the=20
>> problem still there. Yes we could address it later, but I think it's=20
>> better done first because the solution might influence what the best=20
>> syscall API is.
>>=20
>> For example the idea of using the address as the handle for the wait=20
>> queue _and_ the value is very convenient but hashing is annoying for
>> all the above reasons and the shared wait queue case is pretty clunky.=20
>> It's also constraining in some corner cases to have the wait queue=20
>> associated with the address 1:1. For example a type of NUMA mutex might=20
>> want to have per-node waitqueues associated with a lock word, and wake
>> local node waiters 99% of the time. Not trivial to do with futexes and
>> seems to at least require bouncing of more cache lines, possibly more
>> atomics, etc.
>>=20
>> Could anything else be done?
>=20
> I wasn't aware that userspace doing DoS is something to be concerned
> from the kernel point of view. Is this scenario considering a malicious
> actor? If so, there are plenty of resources to be denied, so not sure
> how futex could be protected of this. Or is this just a program that
> uses tons of futexes?

Both really. AFAIKS one of the efforts that prompted the futex=20
modernisation work was the RT latency issues from Thomas in 2016 when=20
the per process table was proposed.


>> I'll be burned at the stake for suggesting it but it would be great if=20
>> we could use file descriptors. At least for the shared futex, maybe=20
>> private could use a per-process futex allocator. It solves all of the
>> above, although I'm sure has many of its own problem. It may not play
>> so nicely with the pthread mutex API because of the whole static
>> initialiser problem, but the first futex proposal did use fds. But it's
>> an example of an alternate API.
>>=20
>=20
> FDs and futex doesn't play well, because for futex_wait() you need to
> tell the kernel the expected value in the futex address to avoid
> sleeping in a free lock. FD operations (poll, select) don't have this
> `value` argument, so they could sleep forever, but I'm not sure if you
> had taken this in consideration.

I had. The futex wait API would take a fd additional. The only=20
difference is the waitqueue that is used when a sleep or wake is=20
required is derived from the fd, not from an address.

I think the bigger sticking points would be if it's too heavyweight an=20
object to use (which could be somewhat mitigated with a simpler ida
allocator although that's difficult to do with shared), and whether libc
could sanely use them due to the static initialiser problem of pthread
mutexes.

Thanks,
Nick
