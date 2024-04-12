Return-Path: <linux-kselftest+bounces-7738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1E8A2306
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 02:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375571C221BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 00:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB25D1FB2;
	Fri, 12 Apr 2024 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="OTCVGLXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433F17E9;
	Fri, 12 Apr 2024 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712882949; cv=none; b=n/dWn4F7YvgKZAHUU10wABjGOWJtsMio9taJ2r+yu6IOClE2BYifhTnZ87r8f37Dz7R2SiQE0+lHW7gWsKuPxkcxS5IPEfGnY3/y3TKazM8pn2bT/3oOCP0lDQ4SUVVYCxxH2I1D90mTSE+IPv9dm+ZagRHYTaA8osr9GE3IJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712882949; c=relaxed/simple;
	bh=GII8TFwTY6x2+9aqL4mQgvsbHfCJTNgY4FJ84BO0oBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbawKa7sFO1olG0o1VYjDlRQz237640xpo1VKhdG4sg7nA1TmeOcGCn0waPW+LQEgKl5QjvXlR3NmBCzgzAY/uPxPixlCyPt/MaeCLO1R8qyoU7iLSuA108WF2ZIOnloQE0aQ2M6HQBFkja5O2WcTgrB2iH0burZtI73Jnkjc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=OTCVGLXi; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=aoTD21VyMjzl2I/9QY+3XQkPooV4se1A6y8TQ08xYng=; b=OTCVGLXixSu/XU6hGP/HK6VTih
	mSDP9y2mw/y7/4nHyzthmC6QLFZVfLCc6GviWq9CcGAAAPsr+F+ox7qfH+YYofPFloGvr+7dhNtqh
	eleR1elJse7QE3fHwDuZh3zDIvT863QWCC1k2pDyubv6+17MtcBdTb9WZf1BhIasIBCLHW1m3CaaK
	x6JLcdlnQSuyZ4OU/Vc3RazaGHjSO6Q+uCaiQ7ssd94UD/B0wOuROH6K9Efr1eeZRDNME+g2udM+4
	SHcpJo4Yuyxqy8ZoZux/zu3/NF2zuDMiu1Eo+GT4AQe6L3+Wr1eo0czOkRWhZ60TnLezn1oXzL8gX
	BDJi99yw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rv4qp-00CL4w-1E;
	Thu, 11 Apr 2024 19:33:07 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 04/30] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Date: Thu, 11 Apr 2024 19:33:07 -0500
Message-ID: <25522541.6Emhk5qWAg@camazotz>
In-Reply-To: <2024041111-handsaw-scruffy-27f3@gregkh>
References:
 <20240329000621.148791-1-zfigura@codeweavers.com>
 <20240329000621.148791-5-zfigura@codeweavers.com>
 <2024041111-handsaw-scruffy-27f3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 11 April 2024 08:34:23 CDT Greg Kroah-Hartman wrote:
> On Thu, Mar 28, 2024 at 07:05:55PM -0500, Elizabeth Figura wrote:
> > This corresponds to part of the functionality of the NT syscall
> > NtWaitForMultipleObjects(). Specifically, it implements the behaviour where
> > the third argument (wait_any) is TRUE, and it does not handle alertable waits.
> > Those features have been split out into separate patches to ease review.
> > 
> > NTSYNC_IOC_WAIT_ANY is a vectored wait function similar to poll(). Unlike
> > poll(), it "consumes" objects when they are signaled. For semaphores, this means
> > decreasing one from the internal counter. At most one object can be consumed by
> > this function.
> > 
> > Up to 64 objects can be waited on at once. As soon as one is signaled, the
> > object with the lowest index is consumed, and that index is returned via the
> > "index" field.
> 
> So it's kind of like our internal locks already?  Or futex?

Striking the right balance of explaining the problem space without
inundating the reader with information has been tricky; I'll do my best
to try to explain here.

The primitives include mutexes and semaphores, like our internal locks.
I don't really want to compare them to futexes because futexes don't
have internal state.

However NT's primitives are *way* more complicated. The big part of it
is they consume state in a way that usual wait functions don't, and as
if that weren't enough, you can do operations with them like
wait-for-all (wait for all objects to be simultaneously signaled and
atomically consume them) or pulse (signal an object without changing
its state). None of this can be expressed with poll or futex.

You can't even express those operations with wait_event() etc. We
really need to replace the entire wait queue and use schedule() +
wake_up_process() directly. ntsync_q is the wait queue struct in this.

They're also really ugly things to do; they only exist for
compatibility reasons, and retrofitting support into anything would
complicate and slow down hot paths.

> > A timeout is supported. The timeout is passed as a u64 nanosecond value, which
> > represents absolute time measured against either the MONOTONIC or REALTIME clock
> > (controlled by the flags argument). If U64_MAX is passed, the ioctl waits
> > indefinitely.
> > 
> > This ioctl validates that all objects belong to the relevant device. This is not
> > necessary for any technical reason related to NTSYNC_IOC_WAIT_ANY, but will be
> > necessary for NTSYNC_IOC_WAIT_ALL introduced in the following patch.
> > 
> > Two u32s of padding are left in the ntsync_wait_args structure; one will be used
> > by a patch later in the series (which is split out to ease review).
> > 
> > Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> > ---
> >  drivers/misc/ntsync.c       | 250 ++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/ntsync.h |  16 +++
> >  2 files changed, 266 insertions(+)
> > 
> > diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> > index 3c2f743c58b0..c6f84a5fc8c0 100644
> > --- a/drivers/misc/ntsync.c
> > +++ b/drivers/misc/ntsync.c
> > @@ -6,11 +6,16 @@
> >   */
> >  
> >  #include <linux/anon_inodes.h>
> > +#include <linux/atomic.h>
> >  #include <linux/file.h>
> >  #include <linux/fs.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/ktime.h>
> >  #include <linux/miscdevice.h>
> >  #include <linux/module.h>
> >  #include <linux/overflow.h>
> > +#include <linux/sched.h>
> > +#include <linux/sched/signal.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <uapi/linux/ntsync.h>
> > @@ -30,6 +35,8 @@ enum ntsync_type {
> >   *
> >   * Both rely on struct file for reference counting. Individual
> >   * ntsync_obj objects take a reference to the device when created.
> > + * Wait operations take a reference to each object being waited on for
> > + * the duration of the wait.
> >   */
> >  
> >  struct ntsync_obj {
> > @@ -47,12 +54,56 @@ struct ntsync_obj {
> >  			__u32 max;
> >  		} sem;
> >  	} u;
> > +
> > +	struct list_head any_waiters;
> > +};
> > +
> > +struct ntsync_q_entry {
> > +	struct list_head node;
> > +	struct ntsync_q *q;
> > +	struct ntsync_obj *obj;
> > +	__u32 index;
> > +};
> > +
> > +struct ntsync_q {
> > +	struct task_struct *task;
> > +	__u32 owner;
> > +
> > +	/*
> > +	 * Protected via atomic_try_cmpxchg(). Only the thread that wins the
> > +	 * compare-and-swap may actually change object states and wake this
> > +	 * task.
> > +	 */
> > +	atomic_t signaled;
> 
> This feels odd, why are you duplicating a normal lock functionality
> here?

ntsync_q represents a single waiter (like struct wait_queue_entry).

In short, waiting is a destructive operation; it changes the state of
the primitives waited on. If a waiter is woken successfully then it
must have consumed the state of exactly one object.

Therefore, if task A is waiting on two primitives X and Y, and those
primitives are respectively woken at the same time by tasks B and C, we
need a way to ensure that B and C don't both wake A and consume the
state of X and Y. Only one of them should win.

We could do that with a lock on the ntsync_q struct, but having a
single variable with atomic-test-and-set achieves the same thing while
being lock-free.

> > +
> > +	__u32 count;
> > +	struct ntsync_q_entry entries[];
> >  };
> >  
> >  struct ntsync_device {
> >  	struct file *file;
> >  };
> >  
> > +static void try_wake_any_sem(struct ntsync_obj *sem)
> > +{
> > +	struct ntsync_q_entry *entry;
> > +
> > +	lockdep_assert_held(&sem->lock);
> > +
> > +	list_for_each_entry(entry, &sem->any_waiters, node) {
> > +		struct ntsync_q *q = entry->q;
> > +		int signaled = -1;
> > +
> > +		if (!sem->u.sem.count)
> > +			break;
> > +
> > +		if (atomic_try_cmpxchg(&q->signaled, &signaled, entry->index)) {
> > +			sem->u.sem.count--;
> > +			wake_up_process(q->task);
> > +		}
> 
> You are waking up _all_ "locks" that with the atomic_try_cmpxchg() call,
> right?  Not just the "first".
> 
> Or am I confused?

This is looping over all tasks trying to lock / acquire "sem", and
waking them (assuming something else didn't wake them first) while
decrementing "sem" state accordingly.

> > +	}
> > +}
> > +
> >  /*
> >   * Actually change the semaphore state, returning -EOVERFLOW if it is made
> >   * invalid.
> > @@ -88,6 +139,8 @@ static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
> >  
> >  	prev_count = sem->u.sem.count;
> >  	ret = post_sem_state(sem, args);
> > +	if (!ret)
> > +		try_wake_any_sem(sem);
> >  
> >  	spin_unlock(&sem->lock);
> >  
> > @@ -141,6 +194,7 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
> >  	obj->dev = dev;
> >  	get_file(dev->file);
> >  	spin_lock_init(&obj->lock);
> > +	INIT_LIST_HEAD(&obj->any_waiters);
> >  
> >  	return obj;
> >  }
> > @@ -191,6 +245,200 @@ static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
> >  	return put_user(fd, &user_args->sem);
> >  }
> >  
> > +static struct ntsync_obj *get_obj(struct ntsync_device *dev, int fd)
> > +{
> > +	struct file *file = fget(fd);
> > +	struct ntsync_obj *obj;
> > +
> > +	if (!file)
> > +		return NULL;
> > +
> > +	if (file->f_op != &ntsync_obj_fops) {
> > +		fput(file);
> > +		return NULL;
> > +	}
> > +
> > +	obj = file->private_data;
> > +	if (obj->dev != dev) {
> > +		fput(file);
> > +		return NULL;
> > +	}
> > +
> > +	return obj;
> > +}
> > +
> > +static void put_obj(struct ntsync_obj *obj)
> > +{
> > +	fput(obj->file);
> > +}
> > +
> > +static int ntsync_schedule(const struct ntsync_q *q, const struct ntsync_wait_args *args)
> > +{
> > +	ktime_t timeout = ns_to_ktime(args->timeout);
> > +	clockid_t clock = CLOCK_MONOTONIC;
> > +	ktime_t *timeout_ptr;
> > +	int ret = 0;
> > +
> > +	timeout_ptr = (args->timeout == U64_MAX ? NULL : &timeout);
> > +
> > +	if (args->flags & NTSYNC_WAIT_REALTIME)
> > +		clock = CLOCK_REALTIME;
> > +
> > +	do {
> > +		if (signal_pending(current)) {
> > +			ret = -ERESTARTSYS;
> > +			break;
> > +		}
> > +
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		if (atomic_read(&q->signaled) != -1) {
> > +			ret = 0;
> > +			break;
> 
> What happens if the value changes right after you read it?

The corresponding wake code flips signaled and then does
wake_up_process(), so schedule() returns immediately (and we see
q->signaled set and exit the loop.)

> Rolling your own lock is tricky, and needs review from the locking
> maintainers.  And probably some more documentation as to what is
> happening and why our normal types of locks can't be used here?

Definitely. (Unfortunately this hasn't gotten attention from any locking
maintainer yet since your last call for review; not sure if there's
anything I can do there.)

Hopefully my comment at the top of this mail explains why we're rolling
our own everything, but if not please let me know and I can try to
explain more clearly.

--Zeb



