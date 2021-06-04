Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAFF39B815
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jun 2021 13:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDLjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Jun 2021 07:39:44 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:43724 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFDLjo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Jun 2021 07:39:44 -0400
Received: by mail-pl1-f176.google.com with SMTP id v12so4482122plo.10;
        Fri, 04 Jun 2021 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=GzU2v3aT+Nw23r0jUTGJ3BvutVW5lNaWZhLb+0eTIi4=;
        b=DG6FZWQbhgcWIXE1XUTR5KFrj2ugV0Ie/8kI1eo0ETMfeKJ4+NAfmG/CjaPGQusYSS
         GCT98AcwLKSVAuelhv39npnMtx2ObqyHmJf8fIuwXbnXCsFBIXvqr6735JmxdzTmwZM0
         HfBhCiYCSxOq0k3XeQTZfAFRY6eLQ6pxtkcI1DRIzLZaPxIolKWVEi9TTHpj1bZKfbS8
         4w48ce+9ZHuVqOSDknLq2aupVhXSzTjW7lQe2zE7FY9pb4j/dPbqdK8OnLHDEVJ4qid8
         5GdOqHB8TJ54QJfdS/irGQVWWEdl37uHSmPG0giDgiv2TjlCyQ1YnZjdietx8H5nzNw+
         dY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=GzU2v3aT+Nw23r0jUTGJ3BvutVW5lNaWZhLb+0eTIi4=;
        b=YUNQ7kM+YB74cjG5Xe/CY6gMPqnYPu74syusGtssppxkfGLgonSfsITSVRv59Oxq09
         zNvMOUPfTmTQ0D1v4DOEqtbY2C9kuTLpnXfOmZjDbgYHovTZKHEZ6rRHydVj0YkVbKGr
         lUmAVchezRp43uRw+pzetW3QYA8b+LdrBlOuzIeS579Sv8jYaQz8RjN75P57Ao7rncG0
         IlRmkq7cJ/ppGnTAZZTCGwlouWqjzpUqDYyZc3wgUso5/GvdIPbFcOwsQEDsmX/GKZLj
         jCcIr1EezCTWhI42vYrvyn7329DmifsOSL03LDp3ecE4NZ4gSCLxR3iql93dkdIZBu6/
         5tmA==
X-Gm-Message-State: AOAM5338WYmVrEUoXlfdtbULyqrk33TU8aDQvkoFeUgOqJAKQXUBoSuC
        c5vsN6AmofOVFXjZhONoYzQ=
X-Google-Smtp-Source: ABdhPJxGv26HSBDoDlmm5VHiVcZvEybLXxH+/scRH/2Y/osKtOfsOq1LXJ8Au14VmvrRRjeR6GWpkQ==
X-Received: by 2002:a17:90a:2f81:: with SMTP id t1mr16798803pjd.122.1622806603888;
        Fri, 04 Jun 2021 04:36:43 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id gn4sm4622503pjb.16.2021.06.04.04.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 04:36:43 -0700 (PDT)
Date:   Fri, 04 Jun 2021 21:36:38 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     =?iso-8859-1?b?QW5kcuk=?= Almeida <andrealmeid@collabora.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     acme@kernel.org, Andrey Semashev <andrey.semashev@gmail.com>,
        corbet@lwn.net, Davidlohr Bueso <dave@stgolabs.net>,
        fweimer@redhat.com, joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        malteskarupke@fastmail.fm, pgriffais@valvesoftware.com,
        Peter Oskolkov <posk@posk.io>, shuah@kernel.org,
        z.figura12@gmail.com
References: <20210603195924.361327-1-andrealmeid@collabora.com>
In-Reply-To: <20210603195924.361327-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-Id: <1622799088.hsuspipe84.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Excerpts from Andr=C3=A9 Almeida's message of June 4, 2021 5:59 am:
> Hi,
>=20
> This patch series introduces the futex2 syscalls.
>=20
> * What happened to the current futex()?
>=20
> For some years now, developers have been trying to add new features to
> futex, but maintainers have been reluctant to accept then, given the
> multiplexed interface full of legacy features and tricky to do big
> changes. Some problems that people tried to address with patchsets are:
> NUMA-awareness[0], smaller sized futexes[1], wait on multiple futexes[2].
> NUMA, for instance, just doesn't fit the current API in a reasonable
> way. Considering that, it's not possible to merge new features into the
> current futex.
>=20
>  ** The NUMA problem
>=20
>  At the current implementation, all futex kernel side infrastructure is
>  stored on a single node. Given that, all futex() calls issued by
>  processors that aren't located on that node will have a memory access
>  penalty when doing it.
>=20
>  ** The 32bit sized futex problem
>=20
>  Futexes are used to implement atomic operations in userspace.
>  Supporting 8, 16, 32 and 64 bit sized futexes allows user libraries to
>  implement all those sizes in a performant way. Thanks Boost devs for
>  feedback: https://lists.boost.org/Archives/boost/2021/05/251508.php
>=20
>  Embedded systems or anything with memory constrains could benefit of
>  using smaller sizes for the futex userspace integer.
>=20
>  ** The wait on multiple problem
>=20
>  The use case lies in the Wine implementation of the Windows NT interface
>  WaitMultipleObjects. This Windows API function allows a thread to sleep
>  waiting on the first of a set of event sources (mutexes, timers, signal,
>  console input, etc) to signal.  Considering this is a primitive
>  synchronization operation for Windows applications, being able to quickl=
y
>  signal events on the producer side, and quickly go to sleep on the
>  consumer side is essential for good performance of those running over Wi=
ne.
>=20
> [0] https://lore.kernel.org/lkml/20160505204230.932454245@linutronix.de/
> [1] https://lore.kernel.org/lkml/20191221155659.3159-2-malteskarupke@web.=
de/
> [2] https://lore.kernel.org/lkml/20200213214525.183689-1-andrealmeid@coll=
abora.com/
>=20
> * The solution
>=20
> As proposed by Peter Zijlstra and Florian Weimer[3], a new interface
> is required to solve this, which must be designed with those features in
> mind. futex2() is that interface. As opposed to the current multiplexed
> interface, the new one should have one syscall per operation. This will
> allow the maintainability of the API if it gets extended, and will help
> users with type checking of arguments.
>=20
> In particular, the new interface is extended to support the ability to
> wait on any of a list of futexes at a time, which could be seen as a
> vectored extension of the FUTEX_WAIT semantics.
>=20
> [3] https://lore.kernel.org/lkml/20200303120050.GC2596@hirez.programming.=
kicks-ass.net/
>=20
> * The interface
>=20
> The new interface can be seen in details in the following patches, but
> this is a high level summary of what the interface can do:
>=20
>  - Supports wake/wait semantics, as in futex()
>  - Supports requeue operations, similarly as FUTEX_CMP_REQUEUE, but with
>    individual flags for each address
>  - Supports waiting for a vector of futexes, using a new syscall named
>    futex_waitv()
>  - Supports variable sized futexes (8bits, 16bits, 32bits and 64bits)
>  - Supports NUMA-awareness operations, where the user can specify on
>    which memory node would like to operate

A few comments.

- Do you need a syscall for wait and for waitv, or can wait just be a
degenerate case of waitv (which could use the stack variable)?  I guess
it does save the user access unlock.

- Did you consider a wakev interface? An example is a read-write mutex=20
which has read-blocking futexes split (e.g., per-node) for scalability=20
then the writer may unlock and wake all readers with one call. We=20
actually have some scalability challenges of this nature with certain=20
large database programs.

- Great to see 64-bit support in, it is helpful to do some interesting=20
things with locks without hacks (e.g., putting an address in the lock=20
word).

- Are we really keen on squashing node ID into flags in this day and age?
I guess okay but seems like it would be nice to allow a bit more space
in general for the operations. I don't want to turn it into a whole big
multiplexing nightmare again with lots of such flags, or propose
complexity with no code behind it, but I think we need a bit of leeway
for unforeseen locking innovations to be added carefully. The pthread
locking today is still fairly primitive really, I don't think we know
what will work best for the next 10 years.

One scalability issue we are starting to hit and will only get worse is=20
futex queue spinlock contention. Perhaps this is better addressed in=20
userspace but the kernel could play a part so I like to leave some doors
open. One example is that the wait (or wake) side may like to depend not
just on the memory value, but on the success of a cmpxchg to avoid=20
unqueueing and queueing spuriously, which increases lock contention but
also ends up putting the poor task on the back of the list -- yes RT
priorities can help the realtime case, but non-RT cases can get bad
outlier latencies if lock stealing is allowed (which can be very good
for performance).

- The private global futex hash table sucks for various reasons, and
having 128 waiters per thread makes it orders of magnitude easier for
userspace to DoS stuff with hash collisions. NUMA doesn't fix that, the
per process hashing that Thomas suggested does fix the DoS but the
non-deterministic hash collisions still seem to be a problem for real
time response, and at the other end of the scale some apps (certain=20
databases, etc) can have ten thousand futex waiters at once so birthday
paradox can also lead to guaranteed (low level) variable beahviour=20
within a single process.

I know the kernel in general is not very robust against this kind of=20
DoS/nondeterminism, but it's a bit sad to introduce new APIs with the=20
problem still there. Yes we could address it later, but I think it's=20
better done first because the solution might influence what the best=20
syscall API is.

For example the idea of using the address as the handle for the wait=20
queue _and_ the value is very convenient but hashing is annoying for
all the above reasons and the shared wait queue case is pretty clunky.=20
It's also constraining in some corner cases to have the wait queue=20
associated with the address 1:1. For example a type of NUMA mutex might=20
want to have per-node waitqueues associated with a lock word, and wake
local node waiters 99% of the time. Not trivial to do with futexes and
seems to at least require bouncing of more cache lines, possibly more
atomics, etc.

Could anything else be done?

I'll be burned at the stake for suggesting it but it would be great if=20
we could use file descriptors. At least for the shared futex, maybe=20
private could use a per-process futex allocator. It solves all of the
above, although I'm sure has many of its own problem. It may not play
so nicely with the pthread mutex API because of the whole static
initialiser problem, but the first futex proposal did use fds. But it's
an example of an alternate API.

And.. thanks for the great work, apologies if I missed some discussion
related to the above comments, I did some reading but I know there has
been a lot of discussions going on.

Thanks,
Nick
