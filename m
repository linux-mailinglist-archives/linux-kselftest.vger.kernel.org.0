Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8231D046
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Feb 2021 19:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhBPSfB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Feb 2021 13:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhBPSfA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Feb 2021 13:35:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F2DC06174A;
        Tue, 16 Feb 2021 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=eyg+UeV+4Tpex6g1TvIiRZSUpwgPO0gq3ggTbcBo9l0=; b=kO58vtrJ4jUFwByInrufSGbqnp
        MnehCrsT0xbY2b97KlEsjB4e9z6iAHIg2lVn44Hg2k37Ipvudds1spouPhPn2V4cjm9Jew4V8J5RP
        +oVnHwz3B2uAxtl/InlGrZQvdtZbjLSdnmCA7lGQYubWzlgrg9QAtlo9Sv7oJZ64SdVd7shijgpt3
        g65/zZBfmQXVwprCQVZ8WVtjKAPi4v6fgu0rWTtdc9nZMOtG7iKAyX0IXV4XXeo4AuDFl1qXgMpYz
        VPPhAZ7Pf2UKGT8kVwwHfdAXfo5j3zA4jqzSkHtBcev8l2U/oxjXXAibCOVXNbSdMN5hM7NH2Htzc
        PNLyNz6g==;
Received: from [2601:1c0:6280:3f0::b669]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lC5Aq-0000fK-T9; Tue, 16 Feb 2021 18:34:13 +0000
Subject: Re: [RFC PATCH 06/13] docs: locking: futex2: Add documentation
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net
References: <20210215152404.250281-1-andrealmeid@collabora.com>
 <20210215152404.250281-7-andrealmeid@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4e70780e-1a4d-79a9-e183-44a3454e0298@infradead.org>
Date:   Tue, 16 Feb 2021 10:34:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215152404.250281-7-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/15/21 7:23 AM, André Almeida wrote:
> Add a new documentation file specifying both userspace API and internal
> implementation details of futex2 syscalls.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
>  Documentation/locking/futex2.rst | 198 +++++++++++++++++++++++++++++++
>  Documentation/locking/index.rst  |   1 +
>  2 files changed, 199 insertions(+)
>  create mode 100644 Documentation/locking/futex2.rst
> 
> diff --git a/Documentation/locking/futex2.rst b/Documentation/locking/futex2.rst
> new file mode 100644
> index 000000000000..edd47c22f2df
> --- /dev/null
> +++ b/Documentation/locking/futex2.rst
> @@ -0,0 +1,198 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======
> +futex2
> +======
> +
> +:Author: André Almeida <andrealmeid@collabora.com>
> +
> +futex, or fast user mutex, is a set of syscalls to allow the userspace to create

                                                       drop ^^^ "the"

> +performant synchronization mechanisms, such as mutexes, semaphores and
> +conditional variables in userspace. C standard libraries, like glibc, uses it
> +as means to implements more high level interfaces like pthreads.

   as a means to implement

> +
> +The interface
> +=============
> +
> +uAPI functions
> +--------------
> +
> +.. kernel-doc:: kernel/futex2.c
> +   :identifiers: sys_futex_wait sys_futex_wake sys_futex_waitv sys_futex_requeue		
> +
> +uAPI structures
> +---------------
> +
> +.. kernel-doc:: include/uapi/linux/futex.h
> +
> +The ``flag`` argument
> +---------------------
> +
> +The flag is used to specify the size of the futex word
> +(FUTEX_[8, 16, 32]). It's mandatory to define one, since there's no
> +default size.
> +
> +By default, the timeout uses a monotonic clock, but can be used as a realtime
> +one by using the FUTEX_REALTIME_CLOCK flag.
> +
> +By default, futexes are of the private type, that means that this user address
> +will be accessed by threads that shares the same memory region. This allows for

                                    share

> +some internal optimizations, so they are faster. However, if the address needs
> +to be shared with different processes (like using ``mmap()`` or ``shm()``), they
> +need to be defined as shared and the flag FUTEX_SHARED_FLAG is used to set that.
> +
> +By default, the operation has no NUMA-awareness, meaning that the user can't
> +choose the memory node where the kernel side futex data will be stored. The
> +user can choose the node where it wants to operate by setting the
> +FUTEX_NUMA_FLAG and using the following structure (where X can be 8, 16, or
> +32)::
> +
> + struct futexX_numa {
> +         __uX value;
> +         __sX hint;
> + };
> +
> +This structure should be passed at the ``void *uaddr`` of futex functions. The
> +address of the structure will be used to be waited on/waken on, and the
> +``value`` will be compared to ``val`` as usual. The ``hint`` member is used to
> +defined which node the futex will use. When waiting, the futex will be

   define

> +registered on a kernel-side table stored on that node; when waking, the futex
> +will be searched for on that given table. That means that there's no redundancy
> +between tables, and the wrong ``hint`` value will led to undesired behavior.

                                                     lead

> +Userspace is responsible for dealing with node migrations issues that may
> +occur. ``hint`` can range from [0, MAX_NUMA_NODES], for specifying a node, or

                             from [0, MAX_NUMA_NODES)
i.e., what does hint == MAX_NUMA_NODES mean?

> +-1, to use the same node the current process is using.
> +
> +When not using FUTEX_NUMA_FLAG on a NUMA system, the futex will be stored on a
> +global table on some node, defined at compilation time.

   defined how at compilation time?

> +
> +The ``timo`` argument
> +---------------------
> +
> +As per the Y2038 work done in the kernel, new interfaces shouldn't add timeout
> +options known to be buggy. Given that, ``timo`` should be a 64bit timeout at

                                                               64-bit

> +all platforms, using an absolute timeout value.
> +
> +Implementation
> +==============
> +
> +The internal implementation follows a similar design to the original futex.
> +Given that we want to replicate the same external behavior of current futex,
> +this should be somewhat expected.
> +
> +Waiting
> +-------
> +
> +For the wait operations, they are all treated as if you want to wait on N
> +futexes, so the path for futex_wait and futex_waitv is the basically the same.
> +For both syscalls, the first step is to prepare an internal list for the list
> +of futexes to wait for (using struct futexv_head). For futex_wait() calls, this
> +list will have a single object.
> +
> +We have a hash table, were waiters register themselves before sleeping.  Then,

                         where                                              Then <no comma>

> +the wake function checks this table looking for waiters at uaddr.  The hash
> +bucket to be used is determined by a struct futex_key, that stores information
> +to uniquely identify an address from a given process. Given the huge address
> +space, there'll be hash collisions, so we store information to be later used on
> +collision treatment.
> +
> +First, for every futex we want to wait on, we check if (``*uaddr == val``).
> +This check is done holding the bucket lock, so we are correctly serialized with
> +any futex_wake() calls. If any waiter fails the check above, we dequeue all
> +futexes. The check (``*uaddr == val``) can fail for two reasons:
> +
> +- The values are different, and we return -EAGAIN. However, if while
> +  dequeueing we found that some futex were awakened, we prioritize this

                                   futexes

> +  and return success.
> +
> +- When trying to access the user address, we do so with page faults
> +  disabled because we are holding a bucket's spin lock (and can't sleep
> +  while holding a spin lock). If there's an error, it might be a page
> +  fault, or an invalid address. We release the lock, dequeue everyone
> +  (because it's illegal to sleep while there are futexes enqueued, we
> +  could lose wakeups) and try again with page fault enabled. If we
> +  succeeded, this means that the address is valid, but we need to do

     succeed,

> +  all the work again. For serialization reasons, we need to have the
> +  spin lock when getting the user value. Additionally, for shared
> +  futexes, we also need to recalculate the hash, since the underlying
> +  mapping mechanisms could have changed when dealing with page fault.
> +  If, even with page fault enabled, we can't access the address, it
> +  means it's an invalid user address, and we return -EFAULT. For this
> +  case, we prioritize the error, even if some futex were awaken.

                                                 futexes
> +
> +If the check is OK, they are enqueued on a linked list in our bucket, and
> +proceed to the next one. If all waiters succeed, we put the thread to sleep
> +until a futex_wake() call, timeout expires or we get a signal. After waking up,
> +we dequeue everyone, and check if some futex was awaken. This dequeue is done by

                                                was awakened.

> +iteratively walking at each element of struct futex_head list.
> +
> +All enqueuing/dequeuing operations requires to hold the bucket lock, to avoid
> +racing while modifying the list.
> +
> +Waking
> +------
> +
> +We get the bucket that's storing the waiters at uaddr, and wake the required
> +number of waiters, checking for hash collision.
> +
> +There's an optimization that makes futex_wake() not taking the bucket lock if

                                                       take

> +there's no one to be wake on that bucket. It checks an atomic counter that each

                        woken / awakened ?

> +bucket has, if it says 0, than the syscall exits. In order to this work, the

                             then                             for this to work, the

> +waiter thread increases it before taking the lock, so the wake thread will
> +correctly see that there's someone waiting and will continue the path to take
> +the bucket lock. To get the correct serialization, the waiter issues a memory
> +barrier after increasing the bucket counter and the waker issues a memory
> +barrier before checking it.
> +
> +Requeuing
> +---------
> +
> +The requeue path first checks for each struct futex_requeue and their flags.
> +Then, it will compare the excepted value with the one at uaddr1::uaddr.

                             accepted ?

> +Following the same serialization explained at Waking_, we increase the atomic
> +counter for the bucket of uaddr2 before taking the lock. We need to have both
> +buckets locks at same time so we don't race with others futexes operations. To

                                                    other futex operations.

> +ensure the locks are taken in the same order for all threads (and thus avoiding
> +deadlocks), every requeue operation takes the "smaller" bucket first, when
> +comparing both addresses.
> +
> +If the compare with user value succeeds, we proceed by waking ``nr_wake``
> +futexes, and then requeuing ``nr_requeue`` from bucket of uaddr1 to the uaddr2.
> +This consists in a simple list deletion/addition and replacing the old futex key
> +for the new one.

   with the new one.
(I think.)

> +
> +Futex keys
> +----------
> +
> +There are two types of futexes: private and shared ones. The private are futexes
> +meant to be used by threads that shares the same memory space, are easier to be

                                    share

> +uniquely identified an thus can have some performance optimization. The elements

                       and

> +for identifying one are: the start address of the page where the address is,
> +the address offset within the page and the current->mm pointer.
> +
> +Now, for uniquely identifying shared futex:

                                 a shared futex:

> +
> +- If the page containing the user address is an anonymous page, we can
> +  just use the same data used for private futexes (the start address of
> +  the page, the address offset within the page and the current->mm
> +  pointer) that will be enough for uniquely identifying such futex. We

     pointer); that

> +  also set one bit at the key to differentiate if a private futex is
> +  used on the same address (mixing shared and private calls do not

                                                               does not

> +  work).
> +
> +- If the page is file-backed, current->mm maybe isn't the same one for
> +  every user of this futex, so we need to use other data: the
> +  page->index, an UUID for the struct inode and the offset within the

                  a UUID

> +  page.
> +
> +Note that members of futex_key doesn't have any particular meaning after they

                                  don't

> +are part of the struct - they are just bytes to identify a futex.  Given that,
> +we don't need to use a particular name or type that matches the original data,
> +we only need to care about the bitsize of each component and make both private
> +and shared fit in the same memory space.
> +
> +Source code documentation
> +=========================
> +
> +.. kernel-doc:: kernel/futex2.c
> +   :no-identifiers: sys_futex_wait sys_futex_wake sys_futex_waitv sys_futex_requeue


-- 
~Randy

