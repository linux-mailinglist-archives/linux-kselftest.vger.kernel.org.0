Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE083C92F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jul 2021 23:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhGNVWD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jul 2021 17:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhGNVWD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jul 2021 17:22:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DC9C06175F;
        Wed, 14 Jul 2021 14:19:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 9999C1F41F83
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
        corbet@lwn.net, Peter Oskolkov <posk@posk.io>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH v5 02/11] futex2: Implement vectorized wait
Organization: Collabora
References: <20210709001328.329716-1-andrealmeid@collabora.com>
        <20210709001328.329716-3-andrealmeid@collabora.com>
Date:   Wed, 14 Jul 2021 17:19:05 -0400
In-Reply-To: <20210709001328.329716-3-andrealmeid@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Thu, 8 Jul 2021 21:13:19 -0300")
Message-ID: <87zguomw52.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

> Add support to wait on multiple futexes. This is the interface
> implemented by this syscall:
>
> futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
> 	    unsigned int flags, struct timespec *timo)
>
> struct futex_waitv {
> 	__u64 val;
> 	void *uaddr;
> 	unsigned int flags;
> };
>
> Given an array of struct futex_waitv, wait on each uaddr. The thread
> wakes if a futex_wake() is performed at any uaddr. The syscall returns
> immediately if any waiter has *uaddr != val. *timo is an optional
> timeout value for the operation. The flags argument of the syscall
> should be used solely for specifying the timeout clock as realtime, if
> needed.  Flags for shared futexes, sizes, etc. should be used on the
> individual flags of each waiter.
>
> Returns the array index of one of the awakened futexes. There’s no given
> information of how many were awakened, or any particular attribute of it
> (if it’s the first awakened, if it is of the smaller index...).
>
> Signed-off-by: André Almeida <andrealmeid@collabora.com>

Hi,

First of all, half of this patch is simply moving code to a header file
to make it available on futex2.c.  In turn, futex2.c is simply a wrapper
to invoke the actual implementation in futex.c.  Still, these changes
are intermixed with the actual futex_wait_multiple code, making this
patch much, much harder to review.  If you drop those, this patch is almost
exactly the same I sent over one year ago, except it doesn't use the
multiplex interface.

Now, I get the desire to have a fully functional new interface.  But I
hate that an actual feature is being hidden in the middle of a series to
rewrite an interface.

Futex Wait Multiple is a new feature with valid use cases and the only
new semantics implemented in this patchset.  We know what its interface
should look like, and it doesn't have any real dependencies on wait/wake
functions.  So why make wait/wake part of the discussion? It should be a
different discussion.

Can we split these two?  Futex wait multiple, or futexv, however we call
it, IS a new feature, implemented by a new system call.  Can we see a
patchset that only does that, with proper documentation and testing?
That is, without it having to reinvent the wheel for
wait/wake/requeue at the same time?

Otherwise, I feel this is just going to spin forever on issues that are
completely unrelated to futex_wait_multiple for no good reasons.

> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  include/linux/compat.h                 |   9 +
>  include/linux/futex.h                  | 108 ++++++--
>  include/uapi/asm-generic/unistd.h      |   4 +-
>  include/uapi/linux/futex.h             |  15 ++
>  kernel/futex.c                         |  72 +-----
>  kernel/futex2.c                        | 345 +++++++++++++++++++++++++
>  kernel/sys_ni.c                        |   2 +
>  9 files changed, 477 insertions(+), 80 deletions(-)
>
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index e3b827a9c094..5573437c1914 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -453,3 +453,4 @@
>  446	i386	landlock_restrict_self	sys_landlock_restrict_self
>  447	i386	futex_wait		sys_futex_wait			compat_sys_futex_wait
>  448	i386	futex_wake		sys_futex_wake
> +449	i386	futex_waitv		sys_futex_waitv			compat_sys_futex_waitv
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 63b447255df2..bad4aca3e9ba 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -370,6 +370,7 @@
>  446	common	landlock_restrict_self	sys_landlock_restrict_self
>  447	common	futex_wait		sys_futex_wait
>  448	common	futex_wake		sys_futex_wake
> +449	common	futex_waitv		sys_futex_waitv
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 5a910e0c437a..75b90e41e05b 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -368,6 +368,12 @@ struct compat_robust_list_head {
>  	compat_uptr_t			list_op_pending;
>  };
>  
> +struct compat_futex_waitv {
> +	compat_u64 val;
> +	compat_uptr_t uaddr;
> +	compat_uint_t flags;
> +};
> +
>  #ifdef CONFIG_COMPAT_OLD_SIGACTION
>  struct compat_old_sigaction {
>  	compat_uptr_t			sa_handler;
> @@ -696,6 +702,9 @@ compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
>  asmlinkage long compat_sys_futex_wait(void __user *uaddr, compat_u64 val,
>  				      unsigned int flags,
>  				      struct __kernel_timespec __user *timo);
> +asmlinkage long compat_sys_futex_waitv(struct compat_futex_waitv *waiters,
> +				       compat_uint_t nr_futexes, compat_uint_t flags,
> +				       struct __kernel_timespec __user *timo);
>  /* kernel/itimer.c */
>  asmlinkage long compat_sys_getitimer(int which,
>  				     struct old_itimerval32 __user *it);
> diff --git a/include/linux/futex.h b/include/linux/futex.h
> index f0eaa05ec8bc..7afef5bb3da2 100644
> --- a/include/linux/futex.h
> +++ b/include/linux/futex.h
> @@ -29,6 +29,22 @@ struct task_struct;
>  #define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inode */
>  #define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm */
>  
> +/*
> + * Futex flags used to encode options to functions and preserve them across
> + * restarts.
> + */
> +#ifdef CONFIG_MMU
> +# define FLAGS_SHARED		0x01
> +#else
> +/*
> + * NOMMU does not have per process address space. Let the compiler optimize
> + * code away.
> + */
> +# define FLAGS_SHARED		0x00
> +#endif
> +#define FLAGS_CLOCKRT		0x02
> +#define FLAGS_HAS_TIMEOUT	0x04
> +
>  union futex_key {
>  	struct {
>  		u64 i_seq;
> @@ -50,6 +66,63 @@ union futex_key {
>  	} both;
>  };
>  
> +/**
> + * struct futex_q - The hashed futex queue entry, one per waiting task
> + * @list:		priority-sorted list of tasks waiting on this futex
> + * @task:		the task waiting on the futex
> + * @lock_ptr:		the hash bucket lock
> + * @key:		the key the futex is hashed on
> + * @pi_state:		optional priority inheritance state
> + * @rt_waiter:		rt_waiter storage for use with requeue_pi
> + * @requeue_pi_key:	the requeue_pi target futex key
> + * @bitset:		bitset for the optional bitmasked wakeup
> + *
> + * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
> + * we can wake only the relevant ones (hashed queues may be shared).
> + *
> + * A futex_q has a woken state, just like tasks have TASK_RUNNING.
> + * It is considered woken when plist_node_empty(&q->list) || q->lock_ptr == 0.
> + * The order of wakeup is always to make the first condition true, then
> + * the second.
> + *
> + * PI futexes are typically woken before they are removed from the hash list via
> + * the rt_mutex code. See unqueue_me_pi().
> + */
> +struct futex_q {
> +	struct plist_node list;
> +
> +	struct task_struct *task;
> +	spinlock_t *lock_ptr;
> +	union futex_key key;
> +	struct futex_pi_state *pi_state;
> +	struct rt_mutex_waiter *rt_waiter;
> +	union futex_key *requeue_pi_key;
> +	u32 bitset;
> +} __randomize_layout;
> +
> +/**
> + * struct futex_vector - Auxiliary struct for futex_waitv()
> + * @w: Userspace provided data
> + * @q: Kernel side data
> + *
> + * Struct used to build an array with all data need for futex_waitv()
> + */
> +struct futex_vector {
> +	struct futex_waitv w;
> +	struct futex_q q;
> +};
> +
> +/*
> + * Hash buckets are shared by all the futex_keys that hash to the same
> + * location.  Each key may have multiple futex_q structures, one for each task
> + * waiting on a futex.
> + */
> +struct futex_hash_bucket {
> +	atomic_t waiters;
> +	spinlock_t lock;
> +	struct plist_head chain;
> +} ____cacheline_aligned_in_smp;
> +
>  #define FUTEX_KEY_INIT (union futex_key) { .both = { .ptr = 0ULL } }
>  
>  #ifdef CONFIG_FUTEX
> @@ -59,6 +132,11 @@ enum {
>  	FUTEX_STATE_DEAD,
>  };
>  
> +enum futex_access {
> +	FUTEX_READ,
> +	FUTEX_WRITE
> +};
> +
>  static inline void futex_init_task(struct task_struct *tsk)
>  {
>  	tsk->robust_list = NULL;
> @@ -81,22 +159,22 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
>  int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset);
>  int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time,
>  	       u32 bitset);
> +void queue_me(struct futex_q *q, struct futex_hash_bucket *hb);
> +int unqueue_me(struct futex_q *q);
> +void queue_unlock(struct futex_hash_bucket *hb);
> +int get_futex_value_locked(u32 *dest, u32 __user *from);
> +int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
> +		  enum futex_access rw);
> +struct futex_hash_bucket *queue_lock(struct futex_q *q);
> +struct hrtimer_sleeper *futex_setup_timer(ktime_t *time,
> +					  struct hrtimer_sleeper *timeout,
> +					  int flags, u64 range_ns);
>  
> -/*
> - * Futex flags used to encode options to functions and preserve them across
> - * restarts.
> - */
> -#ifdef CONFIG_MMU
> -# define FLAGS_SHARED		0x01
> -#else
> -/*
> - * NOMMU does not have per process address space. Let the compiler optimize
> - * code away.
> - */
> -# define FLAGS_SHARED		0x00
> -#endif
> -#define FLAGS_CLOCKRT		0x02
> -#define FLAGS_HAS_TIMEOUT	0x04
> +static const struct futex_q futex_q_init = {
> +	/* list gets initialized in queue_me()*/
> +	.key = FUTEX_KEY_INIT,
> +	.bitset = FUTEX_BITSET_MATCH_ANY
> +};

All of these changes should either disappear if you merge futex2.c and
futex.c or they should go in a new commit, to avoid the noise in the review.


>  #else
>  static inline void futex_init_task(struct task_struct *tsk) { }
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index df9fe2e23ee0..57acb3a0f69f 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -876,9 +876,11 @@ __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
>  __SC_COMP(__NR_futex_wait, sys_futex_wait, compat_sys_futex_wait)
>  #define __NR_futex_wake 448
>  __SYSCALL(__NR_futex_wake, sys_futex_wake)
> +#define __NR_futex_waitv 449
> +__SC_COMP(__NR_futex_waitv, sys_futex_waitv, compat_sys_futex_waitv)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 449
> +#define __NR_syscalls 450
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
> index 44750caa261e..daa135bdedda 100644
> --- a/include/uapi/linux/futex.h
> +++ b/include/uapi/linux/futex.h
> @@ -45,6 +45,21 @@
>  #define FUTEX_32	2
>  #define FUTEX_SHARED_FLAG 8
>  #define FUTEX_SIZE_MASK	0x3
> +
> +#define FUTEX_WAITV_MAX 128
> +
> +/**
> + * struct futex_waitv - A waiter for vectorized wait
> + * @val:   Expected value at uaddr
> + * @uaddr: User address to wait on
> + * @flags: Flags for this waiter
> + */
> +struct futex_waitv {
> +	__u64 val;
> +	void __user *uaddr;
> +	unsigned int flags;
> +};
> +
>  /*
>   * Support for robust futexes: the kernel cleans up held futexes at
>   * thread exit time.
> diff --git a/kernel/futex.c b/kernel/futex.c
> index ef7131bd8bc4..135782fc3461 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -171,57 +171,6 @@ struct futex_pi_state {
>  	union futex_key key;
>  } __randomize_layout;
>  
> -/**
> - * struct futex_q - The hashed futex queue entry, one per waiting task
> - * @list:		priority-sorted list of tasks waiting on this futex
> - * @task:		the task waiting on the futex
> - * @lock_ptr:		the hash bucket lock
> - * @key:		the key the futex is hashed on
> - * @pi_state:		optional priority inheritance state
> - * @rt_waiter:		rt_waiter storage for use with requeue_pi
> - * @requeue_pi_key:	the requeue_pi target futex key
> - * @bitset:		bitset for the optional bitmasked wakeup
> - *
> - * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
> - * we can wake only the relevant ones (hashed queues may be shared).
> - *
> - * A futex_q has a woken state, just like tasks have TASK_RUNNING.
> - * It is considered woken when plist_node_empty(&q->list) || q->lock_ptr == 0.
> - * The order of wakeup is always to make the first condition true, then
> - * the second.
> - *
> - * PI futexes are typically woken before they are removed from the hash list via
> - * the rt_mutex code. See unqueue_me_pi().
> - */
> -struct futex_q {
> -	struct plist_node list;
> -
> -	struct task_struct *task;
> -	spinlock_t *lock_ptr;
> -	union futex_key key;
> -	struct futex_pi_state *pi_state;
> -	struct rt_mutex_waiter *rt_waiter;
> -	union futex_key *requeue_pi_key;
> -	u32 bitset;
> -} __randomize_layout;
> -
> -static const struct futex_q futex_q_init = {
> -	/* list gets initialized in queue_me()*/
> -	.key = FUTEX_KEY_INIT,
> -	.bitset = FUTEX_BITSET_MATCH_ANY
> -};
> -
> -/*
> - * Hash buckets are shared by all the futex_keys that hash to the same
> - * location.  Each key may have multiple futex_q structures, one for each task
> - * waiting on a futex.
> - */
> -struct futex_hash_bucket {
> -	atomic_t waiters;
> -	spinlock_t lock;
> -	struct plist_head chain;
> -} ____cacheline_aligned_in_smp;
> -
>  /*
>   * The base of the bucket array and its size are always used together
>   * (after initialization only in hash_futex()), so ensure that they
> @@ -364,11 +313,6 @@ static inline int match_futex(union futex_key *key1, union futex_key *key2)
>  		&& key1->both.offset == key2->both.offset);
>  }
>  
> -enum futex_access {
> -	FUTEX_READ,
> -	FUTEX_WRITE
> -};
> -
>  /**
>   * futex_setup_timer - set up the sleeping hrtimer.
>   * @time:	ptr to the given timeout value
> @@ -379,7 +323,7 @@ enum futex_access {
>   * Return: Initialized hrtimer_sleeper structure or NULL if no timeout
>   *	   value given
>   */
> -static inline struct hrtimer_sleeper *
> +inline struct hrtimer_sleeper *
>  futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
>  		  int flags, u64 range_ns)
>  {
> @@ -465,8 +409,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
>   *
>   * lock_page() might sleep, the caller should not hold a spinlock.
>   */
> -static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
> -			 enum futex_access rw)
> +int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
> +		  enum futex_access rw)
>  {
>  	unsigned long address = (unsigned long)uaddr;
>  	struct mm_struct *mm = current->mm;
> @@ -698,7 +642,7 @@ static int cmpxchg_futex_value_locked(u32 *curval, u32 __user *uaddr,
>  	return ret;
>  }
>  
> -static int get_futex_value_locked(u32 *dest, u32 __user *from)
> +inline int get_futex_value_locked(u32 *dest, u32 __user *from)
>  {
>  	int ret;
>  
> @@ -2173,7 +2117,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
>  }
>  
>  /* The key must be already stored in q->key. */
> -static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
> +inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
>  	__acquires(&hb->lock)
>  {
>  	struct futex_hash_bucket *hb;
> @@ -2196,7 +2140,7 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
>  	return hb;
>  }
>  
> -static inline void
> +inline void
>  queue_unlock(struct futex_hash_bucket *hb)
>  	__releases(&hb->lock)
>  {
> @@ -2235,7 +2179,7 @@ static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
>   * state is implicit in the state of woken task (see futex_wait_requeue_pi() for
>   * an example).
>   */
> -static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
> +inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
>  	__releases(&hb->lock)
>  {
>  	__queue_me(q, hb);
> @@ -2253,7 +2197,7 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
>   *  - 1 - if the futex_q was still queued (and we removed unqueued it);
>   *  - 0 - if the futex_q was already removed by the waking thread
>   */
> -static int unqueue_me(struct futex_q *q)
> +int unqueue_me(struct futex_q *q)
>  {
>  	spinlock_t *lock_ptr;
>  	int ret = 0;
> diff --git a/kernel/futex2.c b/kernel/futex2.c
> index 990c665280fd..cc1f31afb281 100644
> --- a/kernel/futex2.c
> +++ b/kernel/futex2.c
> @@ -7,6 +7,7 @@
>  
>  #include <asm/futex.h>
>  
> +#include <linux/freezer.h>
>  #include <linux/syscalls.h>
>  
>  /*
> @@ -14,6 +15,350 @@
>   */
>  #define FUTEX2_MASK (FUTEX_SIZE_MASK | FUTEX_SHARED_FLAG | FUTEX_CLOCK_REALTIME)
>  
> +/* Mask for each futex in futex_waitv list */
> +#define FUTEXV_WAITER_MASK (FUTEX_SIZE_MASK | FUTEX_SHARED_FLAG)
> +
> +/* Mask for sys_futex_waitv flag */
> +#define FUTEXV_MASK (FUTEX_CLOCK_REALTIME)
> +
> +/**
> + * unqueue_multiple() - Remove various futexes from their futex_hash_bucket
> + * @v:	   The list of futexes to unqueue
> + * @count: Number of futexes in the list
> + *
> + * Helper to unqueue a list of futexes. This can't fail.
> + *
> + * Return:
> + *  - >=0 - Index of the last futex that was awoken;
> + *  - -1  - No futex was awoken
> + */
> +static int unqueue_multiple(struct futex_vector *v, int count)
> +{
> +	int ret = -1, i;
> +
> +	for (i = 0; i < count; i++) {
> +		if (!unqueue_me(&v[i].q))
> +			ret = i;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * futex_wait_multiple_setup() - Prepare to wait and enqueue multiple futexes
> + * @vs:		The corresponding futex list
> + * @count:	The size of the list
> + * @awaken:	Index of the last awoken futex (return parameter)
> + *
> + * Prepare multiple futexes in a single step and enqueue them. This may fail if
> + * the futex list is invalid or if any futex was already awoken. On success the
> + * task is ready to interruptible sleep.
> + *
> + * Return:
> + *  -  1 - One of the futexes was awaken by another thread
> + *  -  0 - Success
> + *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
> + */
> +static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *awaken)
> +{
> +	struct futex_hash_bucket *hb;
> +	int ret, i;
> +	u32 uval;
> +
> +	/*
> +	 * Enqueuing multiple futexes is tricky, because we need to
> +	 * enqueue each futex in the list before dealing with the next
> +	 * one to avoid deadlocking on the hash bucket.  But, before
> +	 * enqueuing, we need to make sure that current->state is
> +	 * TASK_INTERRUPTIBLE, so we don't absorb any awake events, which
> +	 * cannot be done before the get_futex_key of the next key,
> +	 * because it calls get_user_pages, which can sleep.  Thus, we
> +	 * fetch the list of futexes keys in two steps, by first pinning
> +	 * all the memory keys in the futex key, and only then we read
> +	 * each key and queue the corresponding futex.
> +	 */
> +retry:
> +	for (i = 0; i < count; i++) {
> +		ret = get_futex_key(vs[i].w.uaddr,
> +				    vs[i].w.flags & FUTEX_SHARED_FLAG,
> +				    &vs[i].q.key, FUTEX_READ);
> +		if (unlikely(ret))
> +			return ret;
> +	}
> +
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	for (i = 0; i < count; i++) {
> +		struct futex_q *q = &vs[i].q;
> +		struct futex_waitv *waitv = &vs[i].w;
> +
> +		hb = queue_lock(q);
> +		ret = get_futex_value_locked(&uval, waitv->uaddr);
> +		if (ret) {
> +			/*
> +			 * We need to try to handle the fault, which
> +			 * cannot be done without sleep, so we need to
> +			 * undo all the work already done, to make sure
> +			 * we don't miss any wake ups.  Therefore, clean
> +			 * up, handle the fault and retry from the
> +			 * beginning.
> +			 */
> +			queue_unlock(hb);
> +			__set_current_state(TASK_RUNNING);
> +
> +			*awaken = unqueue_multiple(vs, i);
> +			if (*awaken >= 0)
> +				return 1;
> +
> +			if (get_user(uval, (u32 __user *)waitv->uaddr))
> +				return -EINVAL;
> +
> +			goto retry;
> +		}
> +
> +		if (uval != waitv->val) {
> +			queue_unlock(hb);
> +			__set_current_state(TASK_RUNNING);
> +
> +			/*
> +			 * If something was already awaken, we can
> +			 * safely ignore the error and succeed.
> +			 */
> +			*awaken = unqueue_multiple(vs, i);
> +			if (*awaken >= 0)
> +				return 1;
> +
> +			return -EWOULDBLOCK;
> +		}
> +
> +		/*
> +		 * The bucket lock can't be held while dealing with the
> +		 * next futex. Queue each futex at this moment so hb can
> +		 * be unlocked.
> +		 */
> +		queue_me(&vs[i].q, hb);
> +	}
> +	return 0;
> +}

I think futex_wait_setup should be modified to work with multiple
futexes.  Then you can just use it on both, single and multiple pathes
without any problem and avoid some code duplication.

Note the futex vector will already have been loaded from userspace, so
there is not the performance penalty of the extra get_user that would
exist when using futex_wait_multiple for a single futex.

> +
> +/**
> + * futex_wait_multiple() - Prepare to wait on and enqueue several futexes
> + * @vs:		The list of futexes to wait on
> + * @count:	The number of objects
> + * @to:		Timeout before giving up and returning to userspace
> + *
> + * Entry point for the FUTEX_WAIT_MULTIPLE futex operation, this function
> + * sleeps on a group of futexes and returns on the first futex that
> + * triggered, or after the timeout has elapsed.
> + *
> + * Return:
> + *  - >=0 - Hint to the futex that was awoken
> + *  - <0  - On error
> + */
> +static int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
> +			       struct hrtimer_sleeper *to)
> +{
> +	int ret, hint = 0;
> +	unsigned int i;
> +
> +	while (1) {
> +		ret = futex_wait_multiple_setup(vs, count, &hint);
> +		if (ret) {
> +			if (ret > 0) {
> +				/* A futex was awaken during setup */
> +				ret = hint;
> +			}
> +			return ret;
> +		}
> +
> +		if (to)
> +			hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
> +
> +		/*
> +		 * Avoid sleeping if another thread already tried to
> +		 * wake us.
> +		 */
> +		for (i = 0; i < count; i++) {
> +			if (plist_node_empty(&vs[i].q.list))
> +				break;
> +		}
> +
> +		if (i == count && (!to || to->task))
> +			freezable_schedule();
> +
> +		__set_current_state(TASK_RUNNING);
> +
> +		ret = unqueue_multiple(vs, count);
> +		if (ret >= 0)
> +			return ret;
> +
> +		if (to && !to->task)
> +			return -ETIMEDOUT;
> +		else if (signal_pending(current))
> +			return -ERESTARTSYS;
> +		/*
> +		 * The final case is a spurious wakeup, for
> +		 * which just retry.
> +		 */
> +	}
> +}
> +
> +#ifdef CONFIG_COMPAT
> +/**
> + * compat_futex_parse_waitv - Parse a waitv array from userspace
> + * @futexv:	Kernel side list of waiters to be filled
> + * @uwaitv:     Userspace list to be parsed
> + * @nr_futexes: Length of futexv
> + *
> + * Return: Error code on failure, pointer to a prepared futexv otherwise
> + */
> +static int compat_futex_parse_waitv(struct futex_vector *futexv,
> +				    struct compat_futex_waitv __user *uwaitv,
> +				    unsigned int nr_futexes)
> +{
> +	struct compat_futex_waitv aux;
> +	unsigned int i;
> +
> +	for (i = 0; i < nr_futexes; i++) {
> +		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
> +			return -EFAULT;
> +
> +		if ((aux.flags & ~FUTEXV_WAITER_MASK) ||
> +		    (aux.flags & FUTEX_SIZE_MASK) != FUTEX_32)
> +			return -EINVAL;
> +
> +		futexv[i].w.flags = aux.flags;
> +		futexv[i].w.val = aux.val;
> +		futexv[i].w.uaddr = compat_ptr(aux.uaddr);
> +		futexv[i].q = futex_q_init;
> +	}
> +
> +	return 0;
> +}
> +
> +COMPAT_SYSCALL_DEFINE4(futex_waitv, struct compat_futex_waitv __user *, waiters,
> +		       unsigned int, nr_futexes, unsigned int, flags,
> +		       struct __kernel_timespec __user *, timo)
> +{
> +	struct hrtimer_sleeper to;
> +	struct futex_vector *futexv;
> +	struct timespec64 ts;
> +	ktime_t time;
> +	int ret;
> +
> +	if (flags & ~FUTEXV_MASK)
> +		return -EINVAL;
> +
> +	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
> +		return -EINVAL;
> +
> +	if (timo) {
> +		int flag_clkid = 0;
> +
> +		if (get_timespec64(&ts, timo))
> +			return -EFAULT;
> +
> +		if (!timespec64_valid(&ts))
> +			return -EINVAL;
> +
> +		if (flags & FUTEX_CLOCK_REALTIME)
> +			flag_clkid = FLAGS_CLOCKRT;
> +
> +		time = timespec64_to_ktime(ts);
> +		futex_setup_timer(&time, &to, flag_clkid, 0);
> +	}
> +
> +	futexv = kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
> +	if (!futexv)
> +		return -ENOMEM;
> +
> +	ret = compat_futex_parse_waitv(futexv, waiters, nr_futexes);
> +	if (!ret)
> +		ret = futex_wait_multiple(futexv, nr_futexes, timo ? &to : NULL);
> +
> +	if (timo) {
> +		hrtimer_cancel(&to.timer);
> +		destroy_hrtimer_on_stack(&to.timer);
> +	}
> +
> +	kfree(futexv);
> +	return ret;
> +}
> +#endif
> +
> +static int futex_parse_waitv(struct futex_vector *futexv,
> +			     struct futex_waitv __user *uwaitv,
> +			     unsigned int nr_futexes)
> +{
> +	struct futex_waitv aux;
> +	unsigned int i;
> +
> +	for (i = 0; i < nr_futexes; i++) {
> +		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
> +			return -EFAULT;
> +
> +		if ((aux.flags & ~FUTEXV_WAITER_MASK) ||
> +		    (aux.flags & FUTEX_SIZE_MASK) != FUTEX_32)
> +			return -EINVAL;
> +
> +		futexv[i].w.flags = aux.flags;
> +		futexv[i].w.val = aux.val;
> +		futexv[i].w.uaddr = aux.uaddr;
> +		futexv[i].q = futex_q_init;
> +	}
> +
> +	return 0;
> +}
> +
> +SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
> +		unsigned int, nr_futexes, unsigned int, flags,
> +		struct __kernel_timespec __user *, timo)
> +{
> +	struct hrtimer_sleeper to;
> +	struct futex_vector *futexv;
> +	struct timespec64 ts;
> +	ktime_t time;
> +	int ret;
> +
> +	if (flags & ~FUTEXV_MASK)
> +		return -EINVAL;
> +
> +	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
> +		return -EINVAL;
> +
> +	if (timo) {
> +		int flag_clkid = 0;
> +
> +		if (get_timespec64(&ts, timo))
> +			return -EFAULT;
> +
> +		if (!timespec64_valid(&ts))
> +			return -EINVAL;
> +
> +		if (flags & FUTEX_CLOCK_REALTIME)
> +			flag_clkid = FLAGS_CLOCKRT;
> +
> +		time = timespec64_to_ktime(ts);
> +		futex_setup_timer(&time, &to, flag_clkid, 0);
> +	}
> +
> +	futexv = kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
> +	if (!futexv)
> +		return -ENOMEM;
> +
> +	ret = futex_parse_waitv(futexv, waiters, nr_futexes);
> +	if (!ret)
> +		ret = futex_wait_multiple(futexv, nr_futexes, timo ? &to : NULL);
> +
> +	if (timo) {
> +		hrtimer_cancel(&to.timer);
> +		destroy_hrtimer_on_stack(&to.timer);
> +	}
> +
> +	kfree(futexv);
> +	return ret;
> +}
> +
>  static long ksys_futex_wait(void __user *uaddr, u64 val, unsigned int flags,
>  			    struct __kernel_timespec __user *timo)
>  {
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index dbe397eaea46..93807bb7be51 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -155,6 +155,8 @@ COND_SYSCALL_COMPAT(get_robust_list);
>  COND_SYSCALL(futex_wait);
>  COND_SYSCALL_COMPAT(futex_wait);
>  COND_SYSCALL(futex_wake);
> +COND_SYSCALL(futex_waitv);
> +COND_SYSCALL_COMPAT(futex_waitv);
>  
>  /* kernel/hrtimer.c */

-- 
Gabriel Krisman Bertazi
