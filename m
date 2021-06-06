Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15D039D0E2
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jun 2021 21:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFFTPl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Jun 2021 15:15:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55108 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhFFTOi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Jun 2021 15:14:38 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF06921A83;
        Sun,  6 Jun 2021 19:12:44 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A8D70118DD;
        Sun,  6 Jun 2021 19:12:39 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 1dwyHycevWBQXAAALh3uQQ
        (envelope-from <dave@stgolabs.net>); Sun, 06 Jun 2021 19:12:39 +0000
Date:   Sun, 6 Jun 2021 12:12:33 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     =?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net,
        Peter Oskolkov <posk@posk.io>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v4 05/15] futex2: Implement support for different futex
 sizes
Message-ID: <20210606191233.asjaichvylpryser@offworld>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <20210603195924.361327-6-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210603195924.361327-6-andrealmeid@collabora.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 03 Jun 2021, Andrï¿½ Almeida wrote:

>Implement support for 8, 16 and 64 bit futexes, along with the existing
>32 bit support. Userspace should use flags to specify in the syscall
>the size of the *uaddr they are operating on.
>
>Variable sized futexes are useful for implementing atomic primitives in
>userspace in an efficient manner. 64bit sized futexes are also
>particularly useful when userspace stores information to be used in an
>atomic fashion on the futex value, given more room for flexibility.

Note that at least in the past, Linus has been vehemently against 64-bit
futexes.

Basically this additional data, like for implementing read/write locks,
does not need to be in the futex atomic wait/wake parts. You can instead
split the userspace lock into two adjacent 32-bit words and do 64-bit
atomic ops on it.

Of course, this is a new interface altogether, so this time it might
be fair game.

Thanks,
Davidlohr

>
>Overlapping futexes are not allowed, so userspace can't wait and wake on
>the same memory address if the are using different sizes.
>
>Signed-off-by: André Almeida <andrealmeid@collabora.com>
>---
> include/uapi/linux/futex.h |   3 +
> kernel/futex2.c            | 124 ++++++++++++++++++++++++-------------
> 2 files changed, 84 insertions(+), 43 deletions(-)
>
>diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
>index 06ea9bdfa69e..5786270b0c75 100644
>--- a/include/uapi/linux/futex.h
>+++ b/include/uapi/linux/futex.h
>@@ -42,7 +42,10 @@
>					 FUTEX_PRIVATE_FLAG)
>
> /* Size argument to futex2 syscall */
>+#define FUTEX_8		0
>+#define FUTEX_16	1
> #define FUTEX_32	2
>+#define FUTEX_64	3
>
> #define FUTEX_SIZE_MASK	0x3
>
>diff --git a/kernel/futex2.c b/kernel/futex2.c
>index 012d7f7fc17a..1e97e5f2e793 100644
>--- a/kernel/futex2.c
>+++ b/kernel/futex2.c
>@@ -89,9 +89,11 @@ struct futex_bucket {
> #define FUTEXV_WAITER_MASK (FUTEX_SIZE_MASK | FUTEX_SHARED_FLAG)
>
> #define is_object_shared ((futexv->objects[i].flags & FUTEX_SHARED_FLAG) ? true : false)
>+#define object_size (futexv->objects[i].flags & FUTEX_SIZE_MASK)
>
>-#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inode */
>-#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm */
>+#define FUT_OFF_INODE    PAGE_SIZE
>+#define FUT_OFF_MMSHARED (PAGE_SIZE << 1)
>+#define FUT_OFF_SIZE     1
>
> static struct futex_bucket *futex_table;
> static unsigned int futex2_hashsize;
>@@ -321,6 +323,7 @@ static int futex_get_shared_key(uintptr_t address, struct mm_struct *mm,
>  * @uaddr:   futex user address
>  * @key:     data that uniquely identifies a futex
>  * @shared:  is this a shared futex?
>+ * @flags:   flags for the size
>  *
>  * For private futexes, each uaddr will be unique for a given mm_struct, and it
>  * won't be freed for the life time of the process. For shared futexes, check
>@@ -330,21 +333,41 @@ static int futex_get_shared_key(uintptr_t address, struct mm_struct *mm,
>  */
> static struct futex_bucket *futex_get_bucket(void __user *uaddr,
>					     struct futex_key *key,
>-					     bool shared)
>+					     bool shared, unsigned int flags)
> {
>	uintptr_t address = (uintptr_t)uaddr;
>	u32 hash_key;
>
>+	size_t size;
>+
>+	switch (flags) {
>+	case FUTEX_8:
>+		size = sizeof(u8);
>+		break;
>+	case FUTEX_16:
>+		size = sizeof(u16);
>+		break;
>+	case FUTEX_32:
>+		size = sizeof(u32);
>+		break;
>+	case FUTEX_64:
>+		size = sizeof(u64);
>+		break;
>+	default:
>+		return ERR_PTR(-EINVAL);
>+	}
>+
>	/* Checking if uaddr is valid and accessible */
>-	if (unlikely(!IS_ALIGNED(address, sizeof(u32))))
>+	if (unlikely(!IS_ALIGNED(address, size)))
>		return ERR_PTR(-EINVAL);
>-	if (unlikely(!access_ok(uaddr, sizeof(u32))))
>+	if (unlikely(!access_ok(uaddr, size)))
>		return ERR_PTR(-EFAULT);
>
>	key->offset = address % PAGE_SIZE;
>	address -= key->offset;
>	key->pointer = (u64)address;
>	key->index = (unsigned long)current->mm;
>+	key->offset |= FUT_OFF_SIZE << (size - sizeof(u8));
>
>	if (shared)
>		futex_get_shared_key(address, current->mm, key);
>@@ -358,18 +381,39 @@ static struct futex_bucket *futex_get_bucket(void __user *uaddr,
>
> /**
>  * futex_get_user - Get the userspace value on this address
>- * @uval:  variable to store the value
>- * @uaddr: userspace address
>+ * @uval:	variable to store the value
>+ * @uaddr:	userspace address
>+ * @pagefault:	true if pagefault should be disabled
>+ * @flags:	flags for the size
>  *
>  * Check the comment at futex_enqueue() for more information.
>  */
>-static int futex_get_user(u32 *uval, u32 __user *uaddr)
>+static int futex_get_user(u64 *uval, void __user *uaddr, unsigned int flags, bool pagefault)
> {
>	int ret;
>
>-	pagefault_disable();
>-	ret = __get_user(*uval, uaddr);
>-	pagefault_enable();
>+	if (pagefault)
>+		pagefault_disable();
>+
>+	switch (flags) {
>+	case FUTEX_8:
>+		ret = __get_user(*uval, (u8 __user *)uaddr);
>+		break;
>+	case FUTEX_16:
>+		ret = __get_user(*uval, (u16 __user *)uaddr);
>+		break;
>+	case FUTEX_32:
>+		ret = __get_user(*uval, (u32 __user *)uaddr);
>+		break;
>+	case FUTEX_64:
>+		ret = __get_user(*uval, (u64 __user *)uaddr);
>+		break;
>+	default:
>+		BUG();
>+	}
>+
>+	if (pagefault)
>+		pagefault_enable();
>
>	return ret;
> }
>@@ -484,8 +528,8 @@ static int futex_enqueue(struct futex_waiter_head *futexv, unsigned int nr_futex
>			 int *awakened)
> {
>	int i, ret;
>-	u32 uval, val;
>-	u32 __user *uaddr;
>+	u64 uval, val;
>+	void __user *uaddr;
>	bool retry = false;
>	struct futex_bucket *bucket;
>
>@@ -493,13 +537,14 @@ static int futex_enqueue(struct futex_waiter_head *futexv, unsigned int nr_futex
>	set_current_state(TASK_INTERRUPTIBLE);
>
>	for (i = 0; i < nr_futexes; i++) {
>-		uaddr = (u32 __user *)futexv->objects[i].uaddr;
>-		val = (u32)futexv->objects[i].val;
>+		uaddr = futexv->objects[i].uaddr;
>+		val = (u64)futexv->objects[i].val;
>
>		if (is_object_shared && retry) {
>			struct futex_bucket *tmp =
>				futex_get_bucket((void __user *)uaddr,
>-						 &futexv->objects[i].key, true);
>+						 &futexv->objects[i].key, true,
>+						 object_size);
>			if (IS_ERR(tmp)) {
>				__set_current_state(TASK_RUNNING);
>				futex_dequeue_multiple(futexv, i);
>@@ -513,7 +558,7 @@ static int futex_enqueue(struct futex_waiter_head *futexv, unsigned int nr_futex
>		bucket_inc_waiters(bucket);
>		spin_lock(&bucket->lock);
>
>-		ret = futex_get_user(&uval, uaddr);
>+		ret = futex_get_user(&uval, uaddr, object_size, true);
>
>		if (unlikely(ret)) {
>			spin_unlock(&bucket->lock);
>@@ -525,7 +570,7 @@ static int futex_enqueue(struct futex_waiter_head *futexv, unsigned int nr_futex
>			if (*awakened >= 0)
>				return 1;
>
>-			if (__get_user(uval, uaddr))
>+			if (futex_get_user(&uval, uaddr, object_size, false))
>				return -EFAULT;
>
>			retry = true;
>@@ -656,9 +701,6 @@ static long ksys_futex_wait(void __user *uaddr, u64 val, unsigned int flags,
>	if (flags & ~FUTEX2_MASK)
>		return -EINVAL;
>
>-	if (size != FUTEX_32)
>-		return -EINVAL;
>-
>	futexv = &wait_single.futexv;
>	futexv->task = current;
>	futexv->hint = false;
>@@ -667,12 +709,13 @@ static long ksys_futex_wait(void __user *uaddr, u64 val, unsigned int flags,
>	waiter->index = 0;
>	waiter->val = val;
>	waiter->uaddr = uaddr;
>+	waiter->flags = flags;
>	memset(&wait_single.waiter.key, 0, sizeof(struct futex_key));
>
>	INIT_LIST_HEAD(&waiter->list);
>
>	/* Get an unlocked hash bucket */
>-	waiter->bucket = futex_get_bucket(uaddr, &waiter->key, shared);
>+	waiter->bucket = futex_get_bucket(uaddr, &waiter->key, shared, size);
>	if (IS_ERR(waiter->bucket))
>		return PTR_ERR(waiter->bucket);
>
>@@ -728,8 +771,7 @@ static int compat_futex_parse_waitv(struct futex_waiter_head *futexv,
>		if (copy_from_user(&waitv, &uwaitv[i], sizeof(waitv)))
>			return -EFAULT;
>
>-		if ((waitv.flags & ~FUTEXV_WAITER_MASK) ||
>-		    (waitv.flags & FUTEX_SIZE_MASK) != FUTEX_32)
>+		if (waitv.flags & ~FUTEXV_WAITER_MASK)
>			return -EINVAL;
>
>		futexv->objects[i].key.pointer = 0;
>@@ -740,7 +782,7 @@ static int compat_futex_parse_waitv(struct futex_waiter_head *futexv,
>
>		bucket = futex_get_bucket(compat_ptr(waitv.uaddr),
>					  &futexv->objects[i].key,
>-					  is_object_shared);
>+					  is_object_shared, object_size);
>
>		if (IS_ERR(bucket))
>			return PTR_ERR(bucket);
>@@ -805,8 +847,7 @@ static int futex_parse_waitv(struct futex_waiter_head *futexv,
>		if (copy_from_user(&waitv, &uwaitv[i], sizeof(waitv)))
>			return -EFAULT;
>
>-		if ((waitv.flags & ~FUTEXV_WAITER_MASK) ||
>-		    (waitv.flags & FUTEX_SIZE_MASK) != FUTEX_32)
>+		if (waitv.flags & ~FUTEXV_WAITER_MASK)
>			return -EINVAL;
>
>		futexv->objects[i].key.pointer = 0;
>@@ -816,7 +857,7 @@ static int futex_parse_waitv(struct futex_waiter_head *futexv,
>		futexv->objects[i].index  = i;
>
>		bucket = futex_get_bucket(waitv.uaddr, &futexv->objects[i].key,
>-					  is_object_shared);
>+					  is_object_shared, object_size);
>
>		if (IS_ERR(bucket))
>			return PTR_ERR(bucket);
>@@ -947,10 +988,7 @@ SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
>	if (flags & ~FUTEX2_MASK)
>		return -EINVAL;
>
>-	if (size != FUTEX_32)
>-		return -EINVAL;
>-
>-	bucket = futex_get_bucket(uaddr, &waiter.key, shared);
>+	bucket = futex_get_bucket(uaddr, &waiter.key, shared, size);
>	if (IS_ERR(bucket))
>		return PTR_ERR(bucket);
>
>@@ -987,28 +1025,30 @@ static inline int __futex_requeue(struct futex_requeue rq1,
>	bool retry = false;
>	struct futex_bucket *b1, *b2;
>	DEFINE_WAKE_Q(wake_q);
>-	u32 uval;
>+	u64 uval;
>	int ret;
>	bool shared1 = (rq1.flags  & FUTEX_SHARED_FLAG) ? true : false;
>	bool shared2 = (rq2.flags  & FUTEX_SHARED_FLAG) ? true : false;
>+	unsigned int size1 = (rq1.flags  & FUTEX_SIZE_MASK);
>+	unsigned int size2 = (rq2.flags  & FUTEX_SIZE_MASK);
>
>-	b1 = futex_get_bucket(rq1.uaddr, &w1.key, shared1);
>+	b1 = futex_get_bucket(rq1.uaddr, &w1.key, shared1, size1);
>	if (IS_ERR(b1))
>		return PTR_ERR(b1);
>
>-	b2 = futex_get_bucket(rq2.uaddr, &w2.key, shared2);
>+	b2 = futex_get_bucket(rq2.uaddr, &w2.key, shared2, size2);
>	if (IS_ERR(b2))
>		return PTR_ERR(b2);
>
> retry:
>	if (shared1 && retry) {
>-		b1 = futex_get_bucket(rq1.uaddr, &w1.key, shared1);
>+		b1 = futex_get_bucket(rq1.uaddr, &w1.key, shared1, size1);
>		if (IS_ERR(b1))
>			return PTR_ERR(b1);
>	}
>
>	if (shared2 && retry) {
>-		b2 = futex_get_bucket(rq2.uaddr, &w2.key, shared2);
>+		b2 = futex_get_bucket(rq2.uaddr, &w2.key, shared2, size2);
>		if (IS_ERR(b2))
>			return PTR_ERR(b2);
>	}
>@@ -1027,11 +1067,11 @@ static inline int __futex_requeue(struct futex_requeue rq1,
>		spin_lock_nested(&b1->lock, SINGLE_DEPTH_NESTING);
>	}
>
>-	ret = futex_get_user(&uval, rq1.uaddr);
>+	ret = futex_get_user(&uval, rq1.uaddr, size1, true);
>
>	if (unlikely(ret)) {
>		futex_double_unlock(b1, b2);
>-		if (__get_user(uval, (u32 __user *)rq1.uaddr))
>+		if (futex_get_user(&uval, rq1.uaddr, size1, false))
>			return -EFAULT;
>
>		bucket_dec_waiters(b2);
>@@ -1088,8 +1128,7 @@ static int compat_futex_parse_requeue(struct futex_requeue *rq,
>	if (copy_from_user(&tmp, uaddr, sizeof(tmp)))
>		return -EFAULT;
>
>-	if (tmp.flags & ~FUTEXV_WAITER_MASK ||
>-	    (tmp.flags & FUTEX_SIZE_MASK) != FUTEX_32)
>+	if (tmp.flags & ~FUTEXV_WAITER_MASK)
>		return -EINVAL;
>
>	rq->uaddr = compat_ptr(tmp.uaddr);
>@@ -1134,8 +1173,7 @@ static int futex_parse_requeue(struct futex_requeue *rq,
>	if (copy_from_user(rq, uaddr, sizeof(*rq)))
>		return -EFAULT;
>
>-	if (rq->flags & ~FUTEXV_WAITER_MASK ||
>-	    (rq->flags & FUTEX_SIZE_MASK) != FUTEX_32)
>+	if (rq->flags & ~FUTEXV_WAITER_MASK)
>		return -EINVAL;
>
>	return 0;
>--
>2.31.1
>
