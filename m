Return-Path: <linux-kselftest+bounces-7706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB658A15AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 15:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17771C21D35
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E78C1514EA;
	Thu, 11 Apr 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mecmvzr5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D41514C6;
	Thu, 11 Apr 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842467; cv=none; b=nnwKXftJg1oPELOz52AFfu2CuEpKolsd9E931kK2Bzeru7yB5EZM8q9q6hoJWuseGmiSj3KMYtO4M6oZnsu/OTOYr39Sh16B13eBhQuDVYjAptpdPWX1qDcVRl8LSTWgyvMg9teZ2r68lkOPbvObvNbv01QiShrc6LotmG9Lkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842467; c=relaxed/simple;
	bh=jqJuramCDR7jmfxW4yTxzq1cOltP2kf08eFDobz423U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAZeu+IoH5RdLPzjUi/4KnEACq5sMxLjV6SEhuCuQrHcKXZBCNiagbFct6f1dyPK3nmBGGLCWJtGL/bGftXfTE7LP52HP9F40Cbu/H+O6k0UEZpgjAjsGCflhwvM2eJMYWqDn2gTBV9DNetAACsljdO09GFHnJJ4wfW6cYoIecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mecmvzr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD55C113CD;
	Thu, 11 Apr 2024 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712842466;
	bh=jqJuramCDR7jmfxW4yTxzq1cOltP2kf08eFDobz423U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mecmvzr55gWeALLBb1riwK2ND7lPfeh33a0/ekf2kbfDTOXf/IxKv+GLeoYE42W4O
	 N7xqV7WvuRjztComG5Av621tejs8M08DUxThcgc+oz079aylN44EoVnqKm2M7DGcHn
	 Tr2PNbYq1k664b12Ok1PGwxJeEBRfwr4XGwoxa04=
Date: Thu, 11 Apr 2024 15:34:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 04/30] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Message-ID: <2024041111-handsaw-scruffy-27f3@gregkh>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
 <20240329000621.148791-5-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329000621.148791-5-zfigura@codeweavers.com>

On Thu, Mar 28, 2024 at 07:05:55PM -0500, Elizabeth Figura wrote:
> This corresponds to part of the functionality of the NT syscall
> NtWaitForMultipleObjects(). Specifically, it implements the behaviour where
> the third argument (wait_any) is TRUE, and it does not handle alertable waits.
> Those features have been split out into separate patches to ease review.
> 
> NTSYNC_IOC_WAIT_ANY is a vectored wait function similar to poll(). Unlike
> poll(), it "consumes" objects when they are signaled. For semaphores, this means
> decreasing one from the internal counter. At most one object can be consumed by
> this function.
> 
> Up to 64 objects can be waited on at once. As soon as one is signaled, the
> object with the lowest index is consumed, and that index is returned via the
> "index" field.

So it's kind of like our internal locks already?  Or futex?

> 
> A timeout is supported. The timeout is passed as a u64 nanosecond value, which
> represents absolute time measured against either the MONOTONIC or REALTIME clock
> (controlled by the flags argument). If U64_MAX is passed, the ioctl waits
> indefinitely.
> 
> This ioctl validates that all objects belong to the relevant device. This is not
> necessary for any technical reason related to NTSYNC_IOC_WAIT_ANY, but will be
> necessary for NTSYNC_IOC_WAIT_ALL introduced in the following patch.
> 
> Two u32s of padding are left in the ntsync_wait_args structure; one will be used
> by a patch later in the series (which is split out to ease review).
> 
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> ---
>  drivers/misc/ntsync.c       | 250 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/ntsync.h |  16 +++
>  2 files changed, 266 insertions(+)
> 
> diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> index 3c2f743c58b0..c6f84a5fc8c0 100644
> --- a/drivers/misc/ntsync.c
> +++ b/drivers/misc/ntsync.c
> @@ -6,11 +6,16 @@
>   */
>  
>  #include <linux/anon_inodes.h>
> +#include <linux/atomic.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/hrtimer.h>
> +#include <linux/ktime.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/overflow.h>
> +#include <linux/sched.h>
> +#include <linux/sched/signal.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <uapi/linux/ntsync.h>
> @@ -30,6 +35,8 @@ enum ntsync_type {
>   *
>   * Both rely on struct file for reference counting. Individual
>   * ntsync_obj objects take a reference to the device when created.
> + * Wait operations take a reference to each object being waited on for
> + * the duration of the wait.
>   */
>  
>  struct ntsync_obj {
> @@ -47,12 +54,56 @@ struct ntsync_obj {
>  			__u32 max;
>  		} sem;
>  	} u;
> +
> +	struct list_head any_waiters;
> +};
> +
> +struct ntsync_q_entry {
> +	struct list_head node;
> +	struct ntsync_q *q;
> +	struct ntsync_obj *obj;
> +	__u32 index;
> +};
> +
> +struct ntsync_q {
> +	struct task_struct *task;
> +	__u32 owner;
> +
> +	/*
> +	 * Protected via atomic_try_cmpxchg(). Only the thread that wins the
> +	 * compare-and-swap may actually change object states and wake this
> +	 * task.
> +	 */
> +	atomic_t signaled;

This feels odd, why are you duplicating a normal lock functionality
here?

> +
> +	__u32 count;
> +	struct ntsync_q_entry entries[];
>  };
>  
>  struct ntsync_device {
>  	struct file *file;
>  };
>  
> +static void try_wake_any_sem(struct ntsync_obj *sem)
> +{
> +	struct ntsync_q_entry *entry;
> +
> +	lockdep_assert_held(&sem->lock);
> +
> +	list_for_each_entry(entry, &sem->any_waiters, node) {
> +		struct ntsync_q *q = entry->q;
> +		int signaled = -1;
> +
> +		if (!sem->u.sem.count)
> +			break;
> +
> +		if (atomic_try_cmpxchg(&q->signaled, &signaled, entry->index)) {
> +			sem->u.sem.count--;
> +			wake_up_process(q->task);
> +		}

You are waking up _all_ "locks" that with the atomic_try_cmpxchg() call,
right?  Not just the "first".

Or am I confused?

> +	}
> +}
> +
>  /*
>   * Actually change the semaphore state, returning -EOVERFLOW if it is made
>   * invalid.
> @@ -88,6 +139,8 @@ static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
>  
>  	prev_count = sem->u.sem.count;
>  	ret = post_sem_state(sem, args);
> +	if (!ret)
> +		try_wake_any_sem(sem);
>  
>  	spin_unlock(&sem->lock);
>  
> @@ -141,6 +194,7 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
>  	obj->dev = dev;
>  	get_file(dev->file);
>  	spin_lock_init(&obj->lock);
> +	INIT_LIST_HEAD(&obj->any_waiters);
>  
>  	return obj;
>  }
> @@ -191,6 +245,200 @@ static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
>  	return put_user(fd, &user_args->sem);
>  }
>  
> +static struct ntsync_obj *get_obj(struct ntsync_device *dev, int fd)
> +{
> +	struct file *file = fget(fd);
> +	struct ntsync_obj *obj;
> +
> +	if (!file)
> +		return NULL;
> +
> +	if (file->f_op != &ntsync_obj_fops) {
> +		fput(file);
> +		return NULL;
> +	}
> +
> +	obj = file->private_data;
> +	if (obj->dev != dev) {
> +		fput(file);
> +		return NULL;
> +	}
> +
> +	return obj;
> +}
> +
> +static void put_obj(struct ntsync_obj *obj)
> +{
> +	fput(obj->file);
> +}
> +
> +static int ntsync_schedule(const struct ntsync_q *q, const struct ntsync_wait_args *args)
> +{
> +	ktime_t timeout = ns_to_ktime(args->timeout);
> +	clockid_t clock = CLOCK_MONOTONIC;
> +	ktime_t *timeout_ptr;
> +	int ret = 0;
> +
> +	timeout_ptr = (args->timeout == U64_MAX ? NULL : &timeout);
> +
> +	if (args->flags & NTSYNC_WAIT_REALTIME)
> +		clock = CLOCK_REALTIME;
> +
> +	do {
> +		if (signal_pending(current)) {
> +			ret = -ERESTARTSYS;
> +			break;
> +		}
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		if (atomic_read(&q->signaled) != -1) {
> +			ret = 0;
> +			break;

What happens if the value changes right after you read it?

Rolling your own lock is tricky, and needs review from the locking
maintainers.  And probably some more documentation as to what is
happening and why our normal types of locks can't be used here?

thanks,

greg k-h

