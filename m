Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5600031BC48
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 16:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBOPZf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 10:25:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60066 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhBOPZV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 10:25:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8B9621F44EFB
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
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
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH 02/13] futex2: Add support for shared futexes
Date:   Mon, 15 Feb 2021 12:23:53 -0300
Message-Id: <20210215152404.250281-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210215152404.250281-1-andrealmeid@collabora.com>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for shared futexes for cross-process resources. This design
relies on the same approach done in old futex to create an unique id for
file-backed shared memory, by using a counter at struct inode.

There are two types of futexes: private and shared ones. The private are
futexes meant to be used by threads that shares the same memory space,
are easier to be uniquely identified an thus can have some performance
optimization. The elements for identifying one are: the start address of
the page where the address is, the address offset within the page and
the current->mm pointer.

Now, for uniquely identifying shared futex:

- If the page containing the user address is an anonymous page, we can
  just use the same data used for private futexes (the start address of
  the page, the address offset within the page and the current->mm
  pointer) that will be enough for uniquely identifying such futex. We
  also set one bit at the key to differentiate if a private futex is
  used on the same address (mixing shared and private calls are not
  allowed).

- If the page is file-backed, current->mm maybe isn't the same one for
  every user of this futex, so we need to use other data: the
  page->index, an UUID for the struct inode and the offset within the
  page.

Note that members of futex_key doesn't have any particular meaning after
they are part of the struct - they are just bytes to identify a futex.
Given that, we don't need to use a particular name or type that matches
the original data, we only need to care about the bitsize of each
component and make both private and shared data fit in the same memory
space.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 fs/inode.c         |   1 +
 include/linux/fs.h |   1 +
 kernel/futex2.c    | 220 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 217 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6442d97d9a4a..886fe11ccdaf 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -139,6 +139,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_blkbits = sb->s_blocksize_bits;
 	inode->i_flags = 0;
 	atomic64_set(&inode->i_sequence, 0);
+	atomic64_set(&inode->i_sequence2, 0);
 	atomic_set(&inode->i_count, 1);
 	inode->i_op = &empty_iops;
 	inode->i_fop = &no_open_fops;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..516bda982b3d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -681,6 +681,7 @@ struct inode {
 	};
 	atomic64_t		i_version;
 	atomic64_t		i_sequence; /* see futex */
+	atomic64_t		i_sequence2; /* see futex2 */
 	atomic_t		i_count;
 	atomic_t		i_dio_count;
 	atomic_t		i_writecount;
diff --git a/kernel/futex2.c b/kernel/futex2.c
index 802578ad695b..27767b2d060a 100644
--- a/kernel/futex2.c
+++ b/kernel/futex2.c
@@ -14,8 +14,10 @@
  */
 
 #include <linux/freezer.h>
+#include <linux/hugetlb.h>
 #include <linux/jhash.h>
 #include <linux/memblock.h>
+#include <linux/pagemap.h>
 #include <linux/sched/wake_q.h>
 #include <linux/spinlock.h>
 #include <linux/syscalls.h>
@@ -23,8 +25,8 @@
 
 /**
  * struct futex_key - Components to build unique key for a futex
- * @pointer: Pointer to current->mm
- * @index: Start address of the page containing futex
+ * @pointer: Pointer to current->mm or inode's UUID for file backed futexes
+ * @index: Start address of the page containing futex or index of the page
  * @offset: Address offset of uaddr in a page
  */
 struct futex_key {
@@ -97,6 +99,11 @@ struct futex_single_waiter {
 /* Mask for each futex in futex_waitv list */
 #define FUTEXV_WAITER_MASK (FUTEX_SIZE_MASK | FUTEX_SHARED_FLAG)
 
+#define is_object_shared ((futexv->objects[i].flags & FUTEX_SHARED_FLAG) ? true : false)
+
+#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inode */
+#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm */
+
 struct futex_bucket *futex_table;
 unsigned int futex2_hashsize;
 
@@ -143,16 +150,200 @@ static inline int bucket_get_waiters(struct futex_bucket *bucket)
 #endif
 }
 
+/**
+ * futex_get_inode_uuid - Gets an UUID for an inode
+ * @inode: inode to get UUID
+ *
+ * Generate a machine wide unique identifier for this inode.
+ *
+ * This relies on u64 not wrapping in the life-time of the machine; which with
+ * 1ns resolution means almost 585 years.
+ *
+ * This further relies on the fact that a well formed program will not unmap
+ * the file while it has a (shared) futex waiting on it. This mapping will have
+ * a file reference which pins the mount and inode.
+ *
+ * If for some reason an inode gets evicted and read back in again, it will get
+ * a new sequence number and will _NOT_ match, even though it is the exact same
+ * file.
+ *
+ * It is important that match_futex() will never have a false-positive, esp.
+ * for PI futexes that can mess up the state. The above argues that false-negatives
+ * are only possible for malformed programs.
+ *
+ * Returns: UUID for the given inode
+ */
+static u64 futex_get_inode_uuid(struct inode *inode)
+{
+	static atomic64_t i_seq;
+	u64 old;
+
+	/* Does the inode already have a sequence number? */
+	old = atomic64_read(&inode->i_sequence2);
+
+	if (likely(old))
+		return old;
+
+	for (;;) {
+		u64 new = atomic64_add_return(1, &i_seq);
+
+		if (WARN_ON_ONCE(!new))
+			continue;
+
+		old = atomic64_cmpxchg_relaxed(&inode->i_sequence2, 0, new);
+		if (old)
+			return old;
+		return new;
+	}
+}
+
+/**
+ * futex_get_shared_key - Get a key for a shared futex
+ * @address: Futex memory address
+ * @mm:      Current process mm_struct pointer
+ * @key:     Key struct to be filled
+ *
+ * Returns: 0 on success, error code otherwise
+ */
+static int futex_get_shared_key(uintptr_t address, struct mm_struct *mm,
+				struct futex_key *key)
+{
+	int ret;
+	struct page *page, *tail;
+	struct address_space *mapping;
+
+again:
+	ret = get_user_pages_fast(address, 1, 0, &page);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The treatment of mapping from this point on is critical. The page
+	 * lock protects many things but in this context the page lock
+	 * stabilizes mapping, prevents inode freeing in the shared
+	 * file-backed region case and guards against movement to swap cache.
+	 *
+	 * Strictly speaking the page lock is not needed in all cases being
+	 * considered here and page lock forces unnecessarily serialization
+	 * From this point on, mapping will be re-verified if necessary and
+	 * page lock will be acquired only if it is unavoidable
+	 *
+	 * Mapping checks require the head page for any compound page so the
+	 * head page and mapping is looked up now. For anonymous pages, it
+	 * does not matter if the page splits in the future as the key is
+	 * based on the address. For filesystem-backed pages, the tail is
+	 * required as the index of the page determines the key. For
+	 * base pages, there is no tail page and tail == page.
+	 */
+	tail = page;
+	page = compound_head(page);
+	mapping = READ_ONCE(page->mapping);
+
+	/*
+	 * If page->mapping is NULL, then it cannot be a PageAnon
+	 * page; but it might be the ZERO_PAGE or in the gate area or
+	 * in a special mapping (all cases which we are happy to fail);
+	 * or it may have been a good file page when get_user_pages_fast
+	 * found it, but truncated or holepunched or subjected to
+	 * invalidate_complete_page2 before we got the page lock (also
+	 * cases which we are happy to fail).  And we hold a reference,
+	 * so refcount care in invalidate_complete_page's remove_mapping
+	 * prevents drop_caches from setting mapping to NULL beneath us.
+	 *
+	 * The case we do have to guard against is when memory pressure made
+	 * shmem_writepage move it from filecache to swapcache beneath us:
+	 * an unlikely race, but we do need to retry for page->mapping.
+	 */
+	if (unlikely(!mapping)) {
+		int shmem_swizzled;
+
+		/*
+		 * Page lock is required to identify which special case above
+		 * applies. If this is really a shmem page then the page lock
+		 * will prevent unexpected transitions.
+		 */
+		lock_page(page);
+		shmem_swizzled = PageSwapCache(page) || page->mapping;
+		unlock_page(page);
+		put_page(page);
+
+		if (shmem_swizzled)
+			goto again;
+
+		return -EFAULT;
+	}
+
+	/*
+	 * Private mappings are handled in a simple way.
+	 *
+	 * If the futex key is stored on an anonymous page, then the associated
+	 * object is the mm which is implicitly pinned by the calling process.
+	 *
+	 * NOTE: When userspace waits on a MAP_SHARED mapping, even if
+	 * it's a read-only handle, it's expected that futexes attach to
+	 * the object not the particular process.
+	 */
+	if (PageAnon(page)) {
+		key->offset |= FUT_OFF_MMSHARED;
+	} else {
+		struct inode *inode;
+
+		/*
+		 * The associated futex object in this case is the inode and
+		 * the page->mapping must be traversed. Ordinarily this should
+		 * be stabilised under page lock but it's not strictly
+		 * necessary in this case as we just want to pin the inode, not
+		 * update the radix tree or anything like that.
+		 *
+		 * The RCU read lock is taken as the inode is finally freed
+		 * under RCU. If the mapping still matches expectations then the
+		 * mapping->host can be safely accessed as being a valid inode.
+		 */
+		rcu_read_lock();
+
+		if (READ_ONCE(page->mapping) != mapping) {
+			rcu_read_unlock();
+			put_page(page);
+
+			goto again;
+		}
+
+		inode = READ_ONCE(mapping->host);
+		if (!inode) {
+			rcu_read_unlock();
+			put_page(page);
+
+			goto again;
+		}
+
+		key->pointer = futex_get_inode_uuid(inode);
+		key->index = (unsigned long)basepage_index(tail);
+		key->offset |= FUT_OFF_INODE;
+
+		rcu_read_unlock();
+	}
+
+	put_page(page);
+
+	return 0;
+}
+
 /**
  * futex_get_bucket - Check if the user address is valid, prepare internal
  *                    data and calculate the hash
  * @uaddr:   futex user address
  * @key:     data that uniquely identifies a futex
+ * @shared:  is this a shared futex?
+ *
+ * For private futexes, each uaddr will be unique for a given mm_struct, and it
+ * won't be freed for the life time of the process. For shared futexes, check
+ * futex_get_shared_key().
  *
  * Return: address of bucket on success, error code otherwise
  */
 static struct futex_bucket *futex_get_bucket(void __user *uaddr,
-					     struct futex_key *key)
+					     struct futex_key *key,
+					     bool shared)
 {
 	uintptr_t address = (uintptr_t)uaddr;
 	u32 hash_key;
@@ -168,6 +359,9 @@ static struct futex_bucket *futex_get_bucket(void __user *uaddr,
 	key->pointer = (u64)address;
 	key->index = (unsigned long)current->mm;
 
+	if (shared)
+		futex_get_shared_key(address, current->mm, key);
+
 	/* Generate hash key for this futex using uaddr and current->mm */
 	hash_key = jhash2((u32 *)key, sizeof(*key) / sizeof(u32), 0);
 
@@ -303,6 +497,7 @@ static int futex_enqueue(struct futexv_head *futexv, unsigned int nr_futexes,
 			 int *awakened)
 {
 	int i, ret;
+	bool retry = false;
 	u32 uval, *uaddr, val;
 	struct futex_bucket *bucket;
 
@@ -313,6 +508,18 @@ static int futex_enqueue(struct futexv_head *futexv, unsigned int nr_futexes,
 		uaddr = (u32 * __user)futexv->objects[i].uaddr;
 		val = (u32)futexv->objects[i].val;
 
+		if (is_object_shared && retry) {
+			struct futex_bucket *tmp =
+				futex_get_bucket((void *)uaddr,
+						 &futexv->objects[i].key, true);
+			if (IS_ERR(tmp)) {
+				__set_current_state(TASK_RUNNING);
+				futex_dequeue_multiple(futexv, i);
+				return PTR_ERR(tmp);
+			}
+			futexv->objects[i].bucket = tmp;
+		}
+
 		bucket = futexv->objects[i].bucket;
 
 		bucket_inc_waiters(bucket);
@@ -333,6 +540,7 @@ static int futex_enqueue(struct futexv_head *futexv, unsigned int nr_futexes,
 			if (*awakened >= 0)
 				return 1;
 
+			retry = true;
 			goto retry;
 		}
 
@@ -474,6 +682,7 @@ static int futex_set_timer_and_wait(struct futexv_head *futexv,
 SYSCALL_DEFINE4(futex_wait, void __user *, uaddr, unsigned int, val,
 		unsigned int, flags, struct __kernel_timespec __user *, timo)
 {
+	bool shared = (flags & FUTEX_SHARED_FLAG) ? true : false;
 	unsigned int size = flags & FUTEX_SIZE_MASK;
 	struct futex_single_waiter wait_single = {0};
 	struct futex_waiter *waiter;
@@ -497,7 +706,7 @@ SYSCALL_DEFINE4(futex_wait, void __user *, uaddr, unsigned int, val,
 	INIT_LIST_HEAD(&waiter->list);
 
 	/* Get an unlocked hash bucket */
-	waiter->bucket = futex_get_bucket(uaddr, &waiter->key);
+	waiter->bucket = futex_get_bucket(uaddr, &waiter->key, shared);
 	if (IS_ERR(waiter->bucket))
 		return PTR_ERR(waiter->bucket);
 
@@ -562,6 +771,7 @@ static inline bool futex_match(struct futex_key key1, struct futex_key key2)
 SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
 		unsigned int, flags)
 {
+	bool shared = (flags & FUTEX_SHARED_FLAG) ? true : false;
 	unsigned int size = flags & FUTEX_SIZE_MASK;
 	struct futex_waiter waiter, *aux, *tmp;
 	struct futex_bucket *bucket;
@@ -574,7 +784,7 @@ SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
 	if (size != FUTEX_32)
 		return -EINVAL;
 
-	bucket = futex_get_bucket(uaddr, &waiter.key);
+	bucket = futex_get_bucket(uaddr, &waiter.key, shared);
 	if (IS_ERR(bucket))
 		return PTR_ERR(bucket);
 
-- 
2.30.1

