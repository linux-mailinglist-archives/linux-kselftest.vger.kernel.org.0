Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F431C2BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 21:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBOUAH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 15:00:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34292 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBOUAH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 15:00:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 338351F44FE0
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, pgriffais@valvesoftware.com,
        z.figura12@gmail.com, joel@joelfernandes.org,
        malteskarupke@fastmail.fm, linux-api@vger.kernel.org,
        fweimer@redhat.com, libc-alpha@sourceware.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, acme@kernel.org,
        corbet@lwn.net
Subject: Re: [RFC PATCH 01/13] futex2: Implement wait and wake functions
Organization: Collabora
References: <20210215152404.250281-1-andrealmeid@collabora.com>
        <20210215152404.250281-2-andrealmeid@collabora.com>
Date:   Mon, 15 Feb 2021 14:59:18 -0500
In-Reply-To: <20210215152404.250281-2-andrealmeid@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Mon, 15 Feb 2021 12:23:52 -0300")
Message-ID: <87k0r9w19l.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

> Create a new set of futex syscalls known as futex2. This new interface
> is aimed to implement a more maintainable code, while removing obsolete
> features and expanding it with new functionalities.

Hi André.  Some comments below

> +/* kernel/futex2.c */
> +asmlinkage long sys_futex_wait(void __user *uaddr, unsigned int val,
> +			       unsigned int flags,
> +			       struct __kernel_timespec __user __user *timo);

Duplicated __user attribute

> +asmlinkage long sys_futex_wake(void __user *uaddr, unsigned int nr_wake,
> +			       unsigned int flags);
> +
>  /* kernel/hrtimer.c */
>  asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
>  			      struct __kernel_timespec __user *rmtp);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 728752917785..57e19200f7e4 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -862,8 +862,14 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
>  #define __NR_epoll_pwait2 441
>  __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
>  
> +#define __NR_futex_wait 442
> +__SYSCALL(__NR_futex_wait, sys_futex_wait)
> +
> +#define __NR_futex_wake 443
> +__SYSCALL(__NR_futex_wake, sys_futex_wake)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 442
> +#define __NR_syscalls 444
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
> index a89eb0accd5e..9fbdaaf4f254 100644
> --- a/include/uapi/linux/futex.h
> +++ b/include/uapi/linux/futex.h
> @@ -41,6 +41,62 @@
>  #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
>  					 FUTEX_PRIVATE_FLAG)
>  
> +/* Size argument to futex2 syscall */
> +#define FUTEX_8		0
> +#define FUTEX_16	1
> +#define FUTEX_32	2
> +
> +#define FUTEX_SIZE_MASK	0x3
> +
> +#define FUTEX_SHARED_FLAG 8
> +
> +#define FUTEX_NUMA_FLAG 16
> +
> +/**
> + * struct futexXX_numa - struct for NUMA-aware futex operation
> + * @value: futex value
> + * @hint:  node id to operate
> + */
> +
> +struct futex8_numa {
> +	__u8 value;
> +	__s8 hint;
> +};
> +
> +struct futex16_numa {
> +	__u16 value;
> +	__s16 hint;
> +};
> +
> +struct futex32_numa {
> +	__u32 value;
> +	__s32 hint;
> +};

This patchset doesn't use these structures as far as I can see.  Maybe
these should be on a later patchset, when there is actual support for
numa awareness ?

> +
> +#define FUTEX_WAITV_MAX 128
> +
> +/**
> + * struct futex_waitv - A waiter for vectorized wait
> + * @uaddr: User address to wait on
> + * @val:   Expected value at uaddr
> + * @flags: Flags for this waiter
> + */
> +struct futex_waitv {
> +	void *uaddr;
> +	unsigned int val;
> +	unsigned int flags;
> +};

Shouldn't this be in patch 3?
> +
> +/**
> + * struct futex_requeue - Define an address and its flags for requeue operation
> + * @uaddr: User address of one of the requeue arguments
> + * @flags: Flags for this address
> + */
> +struct futex_requeue {
> +	void *uaddr;
> +	unsigned int flags;
> +};

Shouldn't this be in patch 4?

> +/**
> + * struct futexv_head - List of futexes to be waited
> + * @task:    Task to be awaken
> + * @hint:    Was someone on this list awakened?
> + * @objects: List of futexes
> + */
> +struct futexv_head {
> +	struct task_struct *task;
> +	bool hint;
> +	struct futex_waiter objects[0];
> +};

this structure is also used for a single futex.  maybe struct futex_waiter_head?

> +
> +/**
> + * struct futex_bucket - A bucket of futex's hash table
> + * @waiters: Number of waiters in the bucket
> + * @lock:    Bucket lock
> + * @list:    List of waiters on this bucket
> + */
> +struct futex_bucket {
> +	atomic_t waiters;
> +	spinlock_t lock;
> +	struct list_head list;
> +};
> +
> +/**
> + * struct futex_single_waiter - Wrapper for a futexv_head of one element
> + * @futexv: Single futexv element
> + * @waiter: Single waiter element
> + */
> +struct futex_single_waiter {
> +	struct futexv_head futexv;
> +	struct futex_waiter waiter;
> +} __packed;

Is this struct necessary?  can't you just allocate the necessary space,
i.e. a struct futexv_head with 1 futexv_head->object?
> +
> +/* Mask for futex2 flag operations */
> +#define FUTEX2_MASK (FUTEX_SIZE_MASK | FUTEX_SHARED_FLAG | \
> +		     FUTEX_CLOCK_REALTIME)

SHARED_FLAG should be in patch 2

> +
> +/* Mask for sys_futex_waitv flag */
> +#define FUTEXV_MASK (FUTEX_CLOCK_REALTIME)
> +
> +/* Mask for each futex in futex_waitv list */
> +#define FUTEXV_WAITER_MASK (FUTEX_SIZE_MASK | FUTEX_SHARED_FLAG)
> +
> +struct futex_bucket *futex_table;
> +unsigned int futex2_hashsize;
> +
> +/*
> + * Reflects a new waiter being added to the waitqueue.
> + */
> +static inline void bucket_inc_waiters(struct futex_bucket *bucket)
> +{
> +#ifdef CONFIG_SMP
> +	atomic_inc(&bucket->waiters);
> +	/*
> +	 * Issue a barrier after adding so futex_wake() will see that the
> +	 * value had increased
> +	 */
> +	smp_mb__after_atomic();
> +#endif
> +}
> +
> +/*
> + * Reflects a waiter being removed from the waitqueue by wakeup
> + * paths.
> + */
> +static inline void bucket_dec_waiters(struct futex_bucket *bucket)
> +{
> +#ifdef CONFIG_SMP
> +	atomic_dec(&bucket->waiters);
> +#endif
> +}
> +
> +/*
> + * Get the number of waiters in a bucket
> + */
> +static inline int bucket_get_waiters(struct futex_bucket *bucket)
> +{
> +#ifdef CONFIG_SMP
> +	/*
> +	 * Issue a barrier before reading so we get an updated value from
> +	 * futex_wait()
> +	 */
> +	smp_mb();
> +	return atomic_read(&bucket->waiters);
> +#else
> +	return 1;
> +#endif
> +}
> +
> +/**
> + * futex_get_bucket - Check if the user address is valid, prepare internal
> + *                    data and calculate the hash
> + * @uaddr:   futex user address
> + * @key:     data that uniquely identifies a futex
> + *
> + * Return: address of bucket on success, error code otherwise
> + */
> +static struct futex_bucket *futex_get_bucket(void __user *uaddr,
> +					     struct futex_key *key)
> +{
> +	uintptr_t address = (uintptr_t)uaddr;
> +	u32 hash_key;
> +
> +	/* Checking if uaddr is valid and accessible */
> +	if (unlikely(!IS_ALIGNED(address, sizeof(u32))))
> +		return ERR_PTR(-EINVAL);
> +	if (unlikely(!access_ok(address, sizeof(u32))))
> +		return ERR_PTR(-EFAULT);

This says the code only supports 32-bit.  So, maybe drop the other
FUTEX_SIZE defines for now

> +
> +	key->offset = address % PAGE_SIZE;
> +	address -= key->offset;
> +	key->pointer = (u64)address;
> +	key->index = (unsigned long)current->mm;

Why split the key in offset and pointer and waste 1/3 more space to
store each key?

> +
> +	/* Generate hash key for this futex using uaddr and current->mm */
> +	hash_key = jhash2((u32 *)key, sizeof(*key) / sizeof(u32), 0);
> +
> +	/* Since HASH_SIZE is 2^n, subtracting 1 makes a perfect bit mask */
> +	return &futex_table[hash_key & (futex2_hashsize - 1)];

If someone inadvertely changes futex2_hashsize to something not 2^n this
will silently break.  futex2_hashsize should be constant and you need
a BUILD_BUG_ON().

> +static int futex_enqueue(struct futexv_head *futexv, unsigned int nr_futexes,
> +			 int *awakened)
> +{
> +	int i, ret;
> +	u32 uval, *uaddr, val;
> +	struct futex_bucket *bucket;
> +
> +retry:
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	for (i = 0; i < nr_futexes; i++) {
> +		uaddr = (u32 * __user)futexv->objects[i].uaddr;
> +		val = (u32)futexv->objects[i].val;
> +
> +		bucket = futexv->objects[i].bucket;
> +
> +		bucket_inc_waiters(bucket);
> +		spin_lock(&bucket->lock);
> +
> +		ret = futex_get_user(&uval, uaddr);
> +
> +		if (unlikely(ret)) {
> +			spin_unlock(&bucket->lock);
> +
> +			bucket_dec_waiters(bucket);
> +			__set_current_state(TASK_RUNNING);
> +			*awakened = futex_dequeue_multiple(futexv, i);
> +
> +			if (__get_user(uval, uaddr))
> +				return -EFAULT;
> +
> +			if (*awakened >= 0)
> +				return 1;

If you are awakened, you don't need to waste time with trying to get the
next key.


> +/**
> + * futex_wait - Setup the timer (if there's one) and wait on a list of futexes
> + * @futexv:     List of futexes
> + * @nr_futexes: Length of futexv
> + * @timo:	Timeout
> + * @flags:	Timeout flags
> + *
> + * Return:
> + * * 0 >= - Hint of which futex woke us
> + * * 0 <  - Error code
> + */
> +static int futex_set_timer_and_wait(struct futexv_head *futexv,
> +				    unsigned int nr_futexes,
> +				    struct __kernel_timespec __user *timo,
> +				    unsigned int flags)
> +{
> +	struct hrtimer_sleeper timeout;
> +	int ret;
> +
> +	if (timo) {
> +		ret = futex_setup_time(timo, &timeout, flags);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = __futex_wait(futexv, nr_futexes, timo ? &timeout : NULL);
> +
> +	if (timo)
> +		hrtimer_cancel(&timeout.timer);
> +
> +	return ret;
> +}

I'm having a hard time understanding why this function exists.  part of
the futex is set up outside of it, part inside.  Not sure if this isn't
just part of sys_futex_wait.

Thanks,

-- 
Gabriel Krisman Bertazi
