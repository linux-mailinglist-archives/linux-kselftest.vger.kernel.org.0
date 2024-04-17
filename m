Return-Path: <linux-kselftest+bounces-8268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCC28A8C8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 22:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6141C22506
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26883B7A8;
	Wed, 17 Apr 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="S7dlYH9k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121736AE4;
	Wed, 17 Apr 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384141; cv=none; b=YFBEbjMolo5fnRVcEfLeE40sS0js/y7GIWYtcGQtvWxlyX1/9qytXuuRJwb2dPdaJA7unZFjaLH41/QXO+ziFp8fmSRwKw8pmg7MJ9rsDCHPK3HeHh6/aBdh+FafT3O9xxGcXGlXgkneDB1C8ZMVjdmKAbeUEn0M6vWRaMH6mIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384141; c=relaxed/simple;
	bh=fu1KnH4c/VTpSvcKIOxwKhhgV2/4wEfj3e3mkV7AXoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnKOJF4lSZSFmAuGkIMF+HKPiCZVA98dmowYHXbPb27PkmTrs9S72kBGXd48qnVQqCwZ7faAeDwYUEIroA8/sTefRIGDNSNINzuqhemDZja3kkciEHLNxPzAGiK60PU/Oa/0QHpgyNyVPPMQ8w5uKHSDuOBBFNzVkO2CsPmYRtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=S7dlYH9k; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Q2CE25/MSu+fYMDDyfXhr7GHVuDXgCjGv6XiP03WocA=; b=S7dlYH9k+f9SQqpQy4pNvhBnoJ
	e+NPLdja3PymU1WpoEnws5tbDWyCXoYM9Bl1EFu+y9ASw+zQCxwZZqIcYsRqOK25LMRHw+A8gzluA
	QAGy6Y5QW1xHiQSnJJTJLz3GV5kJtiUgdr/Bzqq15cBT3w76C7LnJaTgXVtgBfVmO2Tqg4HB1ItuJ
	hXEH7CYyzWT2lIKHBOUQzTLst3e6TJ4TS/p9+tWAYB3rRyll5BR/PerlohJcGErF2XPHJ8a7XmOZw
	GeC8KbRWjHXXoNIB/CTJEmrb49aITevV2lUES8pUNaaxKBBR2qcfqSwPtTSrHmR5Ph9QCegsMjIsG
	D2WW8WdQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rxBTx-00HOfD-34;
	Wed, 17 Apr 2024 15:02:14 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Date: Wed, 17 Apr 2024 15:02:13 -0500
Message-ID: <1790266.VLH7GnMWUR@camazotz>
In-Reply-To: <20240417100132.GK30852@noisy.programming.kicks-ass.net>
References:
 <20240416010837.333694-1-zfigura@codeweavers.com>
 <1856855.atdPhlSkOF@terabithia>
 <20240417100132.GK30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 17 April 2024 05:01:32 CDT Peter Zijlstra wrote:
> > 
> > ===================================
> > NT synchronization primitive driver
> > ===================================
> > 
> > This page documents the user-space API for the ntsync driver.
> > 
> > ntsync is a support driver for emulation of NT synchronization
> > primitives by user-space NT emulators. It exists because implementation
> > in user-space, using existing tools, cannot match Windows performance
> > while offering accurate semantics. It is implemented entirely in
> > software, and does not drive any hardware device.
> > 
> > This interface is meant as a compatibility tool only, and should not
> > be used for general synchronization. Instead use generic, versatile
> > interfaces such as futex(2) and poll(2).
> > 
> > Synchronization primitives
> > ==========================
> > 
> > The ntsync driver exposes three types of synchronization primitives:
> > semaphores, mutexes, and events.
> > 
> > A semaphore holds a single volatile 32-bit counter, and a static 32-bit
> > integer denoting the maximum value. It is considered signaled when the
> > counter is nonzero. The counter is decremented by one when a wait is
> > satisfied. Both the initial and maximum count are established when the
> > semaphore is created.
> > 
> > A mutex holds a volatile 32-bit recursion count, and a volatile 32-bit
> > identifier denoting its owner. A mutex is considered signaled when its
> > owner is zero (indicating that it is not owned). The recursion count is
> > incremented when a wait is satisfied, and ownership is set to the given
> > identifier.
> 
> 'signaled' is used twice now but not defined. For both Semaphore and
> Mutex this seems to indicate uncontended? Edit: seems to be needs-wakeup
> more than uncontended.

Uncontended, yes, or needs-wakeup (I'm not sure what the difference
between the two is?)

> > A mutex also holds an internal flag denoting whether its previous owner
> > has died; such a mutex is said to be abandoned. Owner death is not
> > tracked automatically based on thread death, but rather must be
> > communicated using NTSYNC_IOC_MUTEX_KILL. An abandoned mutex is
> > inherently considered unowned.
> > 
> > Except for the "unowned" semantics of zero, the actual value of the
> > owner identifier is not interpreted by the ntsync driver at all. The
> > intended use is to store a thread identifier; however, the ntsync
> > driver does not actually validate that a calling thread provides
> > consistent or unique identifiers.
> 
> Why not verify it? Seems simple enough to put in a TID check, esp. if NT
> mandates the same.

I mostly figured it'd be simplest to leave the driver completely
agnostic, but I don't think there's any reason we can't use the real
TID for most calls.

> > An event holds a volatile boolean state denoting whether it is signaled
> > or not. There are two types of events, auto-reset and manual-reset. An
> > auto-reset event is designaled when a wait is satisfied; a manual-reset
> > event is not. The event type is specified when the event is created.
> 
> But what is an event? I'm familiar with semaphores and mutexes, but less
> so with events.

It's what I'm trying to define there, a single bit of state that's
either contended or not. It acts broadly like an eventfd, in that you
can wake (write) or wait (read), but without the distinction of having
different nonzero values in the internal counter.

You could also think of it as a semaphore with a maximum count of one.
However, unlike a semaphore it also supports the "pulse" operation, and
you can also have "manual-reset" events that *don't* change state when
you wait on them (no equivalent for regular semaphores).

> > Unless specified otherwise, all operations on an object are atomic and
> > totally ordered with respect to other operations on the same object.
> > 
> > Objects are represented by files. When all file descriptors to an
> > object are closed, that object is deleted.
> > 
> > Char device
> > ===========
> > 
> > The ntsync driver creates a single char device /dev/ntsync. Each file
> > description opened on the device represents a unique instance intended
> > to back an individual NT virtual machine. Objects created by one ntsync
> > instance may only be used with other objects created by the same
> > instance.
> > 
> > ioctl reference
> > ===============
> > 
> > All operations on the device are done through ioctls. There are four
> > structures used in ioctl calls::
> > 
> >    struct ntsync_sem_args {
> >        __u32 sem;
> >        __u32 count;
> >        __u32 max;
> >    };
> > 
> >    struct ntsync_mutex_args {
> >        __u32 mutex;
> >        __u32 owner;
> >        __u32 count;
> >    };
> > 
> >    struct ntsync_event_args {
> >        __u32 event;
> >        __u32 signaled;
> >        __u32 manual;
> >    };
> > 
> >    struct ntsync_wait_args {
> >        __u64 timeout;
> >        __u64 objs;
> >        __u32 count;
> >        __u32 owner;
> >        __u32 index;
> >        __u32 alert;
> >        __u32 flags;
> >        __u32 pad;
> >    };
> > 
> > Depending on the ioctl, members of the structure may be used as input,
> > output, or not at all. All ioctls return 0 on success.
> > 
> > The ioctls on the device file are as follows:
> > 
> > NTSYNC_IOC_CREATE_SEM
> > 
> >   Create a semaphore object. Takes a pointer to struct ntsync_sem_args,
> >   which is used as follows:
> > 
> >      * sem:   On output, contains a file descriptor to the created semaphore.
> >      * count: Initial count of the semaphore.
> >      * max:   Maximum count of the semaphore.
> > 
> >   Fails with EINVAL if `count` is greater than `max`.
> 
> So the implication is that @count and @max are input argument and as
> such should be set before calling the ioctl()?
> 
> It would not have been weird to have the ioctl() return the fd on
> success I suppose, instead of mixing input and output arguments like
> this, but whatever, this works.

I think that would have been fine, and I could still change it
accordingly. The reason I didn't do that was that [1] advises against
it (although I don't know why).

[1] https://docs.kernel.org/driver-api/ioctl.html#return-code

> > The ioctls on the individual objects are as follows:
> > 
> > NTSYNC_IOC_SEM_POST
> > 
> >   Post to a semaphore object. Takes a pointer to a 32-bit integer,
> >   which on input holds the count to be added to the semaphore, and on
> >   output contains its previous count.
> > 
> >   If adding to the semaphore's current count would raise the latter
> >   past the semaphore's maximum count, the ioctl fails with
> >   EOVERFLOW and the semaphore is not affected. If raising the
> >   semaphore's count causes it to become signaled, eligible threads
> >   waiting on this semaphore will be woken and the semaphore's count
> >   decremented appropriately.
> 
> Urg, so this is the traditional V (vrijgeven per Dijkstra, release in
> English), but now 'conveniently' called POST, such that it can be
> readily confused with the P operation (passering, or passing) which it
> is not.
> 
> Glorious :-/
> 
> You're of course going to tell me NT did this and you can't help this
> naming foible.

No, NT calls it "release" (and the operation on a mutex is also
"release" rather than "unlock".) I called it "post" after POSIX
semaphores, on the idea that it'd be more familiar to a Unix developer
(and shorter). I see I was wrong, so I'll rename it to "release".

> > NTSYNC_IOC_MUTEX_UNLOCK
> > 
> >   Release a mutex object. Takes a pointer to struct ntsync_mutex_args,
> >   which is used as follows:
> > 
> >      * mutex: Ignored.
> >      * owner: Specifies the owner trying to release this mutex.
> >      * count: On output, contains the previous recursion count.
> > 
> >   If "owner" is zero, the ioctl fails with EINVAL. If "owner"
> >   is not the current owner of the mutex, the ioctl fails with
> >   EPERM.
> 
> ISTR you having written elsewhere that NT actually demands mutexes to be
> strictly per thread, which for the above would mandate @owner to be
> current, no?

Right. We could replace owner with current everywhere except for 
NTSYNC_IOC_KILL_OWNER.

> >   The mutex's count will be decremented by one. If decrementing the
> >   mutex's count causes it to become zero, the mutex is marked as
> >   unowned and signaled, and eligible threads waiting on it will be
> >   woken as appropriate.
> > 
> > NTSYNC_IOC_SET_EVENT
> > 
> >   Signal an event object. Takes a pointer to a 32-bit integer, which on
> >   output contains the previous state of the event.
> > 
> >   Eligible threads will be woken, and auto-reset events will be
> >   designaled appropriately.
> 
> Hmm, so the event thing is like a simple wait-wake scheme? Where the
> 'signaled' bit is used as the wakeup state?

Yes, exactly.

> > NTSYNC_IOC_RESET_EVENT
> > 
> >   Designal an event object. Takes a pointer to a 32-bit integer, which
> >   on output contains the previous state of the event.
> > 
> > NTSYNC_IOC_PULSE_EVENT
> > 
> >   Wake threads waiting on an event object while leaving it in an
> >   unsignaled state. Takes a pointer to a 32-bit integer, which on
> >   output contains the previous state of the event.
> > 
> >   A pulse operation can be thought of as a set followed by a reset,
> >   performed as a single atomic operation. If two threads are waiting on
> >   an auto-reset event which is pulsed, only one will be woken. If two
> >   threads are waiting a manual-reset event which is pulsed, both will
> >   be woken. However, in both cases, the event will be unsignaled
> >   afterwards, and a simultaneous read operation will always report the
> >   event as unsignaled.
> 
> *groan*

Yep :D

This one is terrible, and it's the only one that Microsoft has come out
and explicitly said "don't use this". Supposedly their kernel is even
coded such that if a waiting thread gets hit by an interrupt that the
pulse will go unnoticed, although I've tried to reproduce this in
practice and been unsuccessful.

But of course it's terrible regardless, because you never know if your
thread is waiting or not. In practice it seems to usually be used on a
timer, though, so that part doesn't matter as much.

> > NTSYNC_IOC_READ_SEM
> > 
> >   Read the current state of a semaphore object. Takes a pointer to
> >   struct ntsync_sem_args, which is used as follows:
> > 
> >      * sem:   Ignored.
> >      * count: On output, contains the current count of the semaphore.
> >      * max:   On output, contains the maximum count of the semaphore.
> 
> This seems inherently racy -- what is the intended purpose of this
> interface?
> 
> Specifically the moment a value is returned, either P or V operations
> can change it, rendering the (as yet unused) return value incorrect.

I have no idea what it's intended for. Actually it's not even exposed
as a documented API, only an undocumented one. But it does work, and
applications use it.

> > NTSYNC_IOC_READ_MUTEX
> > 
> >   Read the current state of a mutex object. Takes a pointer to struct
> >   ntsync_mutex_args, which is used as follows:
> > 
> >      * mutex: Ignored.
> >      * owner: On output, contains the current owner of the mutex, or zero
> >               if the mutex is not currently owned.
> >      * count: On output, contains the current recursion count of the mutex.
> > 
> >   If the mutex is marked as abandoned, the function fails with
> >   EOWNERDEAD. In this case, "count" and "owner" are set to zero.
> 
> Another questionable interface. I suspect you're going to be telling me
> NT has them so you have to have them, but urgh.

Unfortunately yes.

> > NTSYNC_IOC_READ_EVENT
> > 
> >   Read the current state of an event object. Takes a pointer to struct
> >   ntsync_event_args, which is used as follows:
> > 
> >      * event:    Ignored.
> >      * signaled: On output, contains the current state of the event.
> >      * manual:   On output, contains 1 if the event is a manual-reset event,
> >                  and 0 otherwise.
> 
> I can't help but notice all those @sem, @mutex, @event 'output' members
> being unused except for create. Seems like a waste to have them.

Yes, mostly so I could reuse the existing structures.

On the other hand if there's no reason not to return fds from the
create ioctls, then we could just remove those members.

> > NTSYNC_IOC_KILL_OWNER
> > 
> >   Mark a mutex as unowned and abandoned if it is owned by the given
> >   owner. Takes an input-only pointer to a 32-bit integer denoting the
> >   owner. If the owner is zero, the ioctl fails with EINVAL. If the
> >   owner does not own the mutex, the function fails with EPERM.
> > 
> >   Eligible threads waiting on the mutex will be woken as appropriate
> >   (and such waits will fail with EOWNERDEAD, as described below).
> 
> Wine will use this when it detects a thread exit I suppose.

Exactly.

> > NTSYNC_IOC_WAIT_ANY
> > 
> >   Poll on any of a list of objects, atomically acquiring at most one.
> >   Takes a pointer to struct ntsync_wait_args, which is used as follows:
> > 
> >      * timeout: Absolute timeout in nanoseconds. If NTSYNC_WAIT_REALTIME
> >                 is set, the timeout is measured against the REALTIME
> >                 clock; otherwise it is measured against the MONOTONIC
> >                 clock. If the timeout is equal to or earlier than the
> >                 current time, the function returns immediately without
> >                 sleeping. If "timeout" is U64_MAX, the function will
> >                 sleep until an object is signaled, and will not fail
> >                 with ETIMEDOUT.
> > 
> >      * objs:    Pointer to an array of "count" file descriptors
> >                 (specified as an integer so that the structure has the
> >                 same size regardless of architecture). If any object is
> >                 invalid, the function fails with EINVAL.
> > 
> >      * count:   Number of objects specified in the "objs" array. If
> >                 greater than NTSYNC_MAX_WAIT_COUNT, the function fails
> >                 with EINVAL.
> > 
> >      * owner:   Mutex owner identifier. If any object in "objs" is a
> >                 mutex, the ioctl will attempt to acquire that mutex on
> >                 behalf of "owner". If "owner" is zero, the ioctl
> >                 fails with EINVAL.
> 
> Again, should that not be current? That is, why not maintain the NT
> invariant and mandates TIDs and avoid the arguments in both cases?

I don't think there's any particular reason.

> >      * index:   On success, contains the index (into "objs") of the
> >                 object which was signaled. If "alert" was signaled
> >                 instead, this contains "count".
> 
> Could be the actual return value, no? Edit: no it cannot be because
> -EOWNERDEAD case below.

Yeah. Again the advice about "only return zero from an ioctl", too.

Although we could also use a bit in the return value (which is also
kind of what NT does).

> >   A semaphore is considered to be signaled if its count is nonzero, and
> >   is acquired by decrementing its count by one. A mutex is considered
> >   to be signaled if it is unowned or if its owner matches the "owner"
> >   argument, and is acquired by incrementing its recursion count by one
> >   and setting its owner to the "owner" argument. An auto-reset event
> >   is acquired by designaling it; a manual-reset event is not affected
> >   by acquisition.
> > 
> >   Acquisition is atomic and totally ordered with respect to other
> >   operations on the same object. If two wait operations (with different
> >   "owner" identifiers) are queued on the same mutex, only one is
> >   signaled. If two wait operations are queued on the same semaphore,
> >   and a value of one is posted to it, only one is signaled. The order
> >   in which threads are signaled is not specified.
> 
> Note that you do list the lack of guarantee here, but not above. I
> suspect both cases are similar and guarantee nothing.

There's no documented guarantee in either case, but when testing in
controlled well-ordered environments, NtWaitForMultipleObjects() always
acquires the lowest index first, and I think wakes are FIFO. I'm not
really sure why I specified the guarantee for the former but not the
latter.

> >   The "alert" argument is an "extra" event which can terminate the
> >   wait, independently of all other objects. If members of "objs" and
> >   "alert" are both simultaneously signaled, a member of "objs" will
> >   always be given priority and acquired first.
> > 
> >   It is valid to pass the same object more than once, including by
> >   passing the same event in the "objs" array and in "alert". If a
> >   wakeup occurs due to that object being signaled, "index" is set to
> >   the lowest index corresponding to that object.
> 
> Urgh, is this an actual guarantee? This almost seems to imply that at
> [A] above we can indeed guarantee the lowest indexed object is acquired
> first.

It's definitely legal in NT to pass the same object more than once (in
wait-for-any, not wait-for-all though), and it's definitely the case
that (at least in controlled well-ordered environments) the lowest
index is acquired first. I don't know of any application that
definitely depends on either of these, and they're not documented
behaviours, but Wine has implemented those behaviours and it would make
me nervous to break them here.

The part about passing the same event in "alert" and "objs" is not part
of NT exactly (in NT the "alert" isn't even an event; it's a special
bit of thread state; we just use an event for simplicity). I think I
specified it just to avoid coding an extra check (since it should Just
Work), while also making it clear that case was considered.

> >   The function may fail with EINTR if a signal is received.
> 
> In which case @index must be disregarded since nothing will be acquired,
> right?
> 
> So far nothing really weird, and I'm thinking futexes should be able to
> do all this, no?

Even disregarding wait-for-all, futexes aren't really good enough. Wait
operations need to consume state, and while we could put that state in
user space (and in fact we *do* have an out of tree patch set that kind
of does this) that requires all that state to be shared across
processes, which is a problem since we want processes to be isolated
unless they explicitly share objects with each other. There's not
a scalable way to achieve this, especially since you can share objects
lazily.

You also cannot do NtPulseEvent() this way. The aforementioned patch
set badly emulates it and it does in practice break any application
that uses it. Similarly there are some applications that do a weird
"fake pulse" where they set and then immediately reset an event from
the same thread, and expect that to always wake.



