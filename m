Return-Path: <linux-kselftest+bounces-17578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61104973663
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 13:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA942872AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927A818EFE6;
	Tue, 10 Sep 2024 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4BOl3mX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HNABSjQW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240117BEC8;
	Tue, 10 Sep 2024 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968683; cv=none; b=SawxLwSBBpz8VrEiwtP6elqmhXArRmQDHbM7LxCeVXXTTivDLpZElFz3/NdbP/Dcz6qL3NlzpRXomqqYW3gTWRRpLj4JTSVj3w/cGA+4+tC/NWbWHS08JPN0BH77MzUFek5Cl0gijFAtGkUcR8LRtZcqcPIOz2XYNNYoyMmX/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968683; c=relaxed/simple;
	bh=PUOpnY86OnZ2VvA91FbtPUY1EVMTgumLzJBorCXujWs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qmmGYbq8L8hjKBPDjhi1d49avLfHYD7mDMPLItv5LC4ZeRXbjTzuReqhvkl6vYi3J8wN0w94pkoUesO1GvfZQIPxN8EYzFjfMYTKlv/RMiziCevAEFZp9ck8JBHQVPjBxXjF1z8PwsfgEuFMkcs0BLF+NxfZo80BJNnMtkAN6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4BOl3mX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HNABSjQW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725968678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+PKBISPclHuVmgGgqqN3H4Z6oPjGUAaNao3/R4KQNI=;
	b=q4BOl3mXL4U71Zs8Af5IxaqK5/bn+DNHQYuypxItIwho8Kov0IuN82ZFLR4+Aw45J3KolW
	Vg/dX6pHhRgwFdS4Yq+zDSTKYK0Ins4sZ773xrhyBHWqEfW26WhrrVdcqAe1WDCys1Ozcm
	fvDI8ljr/05LjKfuBxdgt/9nTALigK5Be2k222Tk6e+HLlLJQxie60CbwZ4oQq7F4msPZY
	Vg1TrcC11P+rHlpL0/Dn1yXMuLbQci0ab4iTUtts3r4MF2jTU0IFyI/NhVFjN/NEZi2nXM
	OwSAdhg5L/Z6Kilgapf2Tu+rOo2VNvOhrpPCtHQ9fRZp8N0rFVArLht0dkOVxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725968678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+PKBISPclHuVmgGgqqN3H4Z6oPjGUAaNao3/R4KQNI=;
	b=HNABSjQWz7hxhzxzjW344Ra1zrIFtFzo92WbmCvxxcPrDVPGKnKNZhpd+XORL5fiGoC5Ig
	GiQT3lXKa501xRDw==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, David Gow
 <davidgow@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
Subject: Re: [PATCH 3/3] debugobjects: Use hlist_cut_number() to optimize
 performance and improve readability
In-Reply-To: <5333927d-3f21-b7cc-8c57-6e21f1b4a3e5@huawei.com>
References: <20240904134152.2141-1-thunder.leizhen@huawei.com>
 <20240904134152.2141-4-thunder.leizhen@huawei.com> <87jzfkbrgf.ffs@tglx>
 <5333927d-3f21-b7cc-8c57-6e21f1b4a3e5@huawei.com>
Date: Tue, 10 Sep 2024 13:44:38 +0200
Message-ID: <87bk0vbumx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 10 2024 at 12:00, Leizhen wrote:
> On 2024/9/10 2:41, Thomas Gleixner wrote:
>> All related functions have this problem and all of this code is very
>> strict about boundaries. Instead of accurately doing the refill, purge
>> etc. we should look into proper batch mode mechanisms. Let me think
>> about it.
>
> It may be helpful to add several arrays to record the first node of each batch
> in each free list. Take 'percpu_pool' as an example:
>
> struct debug_percpu_free {
> 	struct hlist_head	free_objs;
> 	int			obj_free;
> +	int			batch_idx;
> +	struct hlist_node	*batch_first[4]; // ODEBUG_POOL_PERCPU_SIZE / ODEBUG_BATCH_SIZE
> };
>
> A new free node is added to the header of the list, and the batch is cut from the tail
> of the list.
>   NodeA<-->...<-->NodeB<-->...<-->NodeC<-->NodeD<--> free_objs
>     |---one batch---|---one batch---|
>                     |               |
>         batch_first[0]  batch_first[1]

The current data structures are not fit for the purpose. Glueing
workarounds into the existing mess makes it just worse.

So the data structures need to be redesigned from ground up to be fit
for the purpose.

allocation:

   1) Using the global pool for single object allocations is wrong

      During boot this can be a completely disconnected list, which does
      not need any accounting, does not need pool_lock and can be just
      protected with irqsave like the per CPU pools. It's effectivly a
      per CPU pool because at that point there is only one CPU and
      everything is single threaded.

   2) The per CPU pool handling is backwards

      If the per CPU pool is empty, then the pool needs to be refilled
      with a batch from the global pool and allocated from there.

      Allocation then always happens from the active per CPU batch slot.

free:

   1) Early boot

      Just put it back on the dedicated boot list and be done

   2) After obj_cache is initialized

      Put it back to the per CPU pool into the active batch slot.  If
      the slot becomes full then make the next slot the active slot. It
      the full slot was the top most slot then move that slot either
      into the global pool when there is a free slot, or move it to the
      to_free pool.

That means the per CPU pool is different from the global pools as it can
allocate/free single objects, while the global pools are strictly stacks
of batches. Any movement between per CPU pools and global pools is batch
based and just moves lists from one head to another.

That minimizes the pool lock contention and the cache foot print. The
global to free pool must have an extra twist to accomodate non-batch
sized drops and to handle the all slots are full case, but that's just a
trivial detail.

See the completely untested combo patch against tip core/debugobjects
below.

Thanks,

        tglx
---
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -21,10 +21,17 @@
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
 
+/* Must be power of two */
+#define ODEBUG_BATCH_SIZE	16
+#define ODEBUG_BATCH_SIZE_MASK	(ODEBUG_BATCH_SIZE - 1)
+
+/* Must all be a multiple of batch size */
 #define ODEBUG_POOL_SIZE	1024
 #define ODEBUG_POOL_MIN_LEVEL	256
 #define ODEBUG_POOL_PERCPU_SIZE	64
-#define ODEBUG_BATCH_SIZE	16
+
+#define ODEBUG_POOL_SLOTS	(NR_CPUS + (ODEBUG_POOL_SIZE / ODEBUG_BATCH_SIZE))
+#define ODEBUG_PCPU_SLOTS	(ODEBUG_POOL_PERCPU_SIZE / ODEBUG_BATCH_SIZE)
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
@@ -43,16 +50,22 @@ struct debug_bucket {
 	raw_spinlock_t		lock;
 };
 
-/*
- * Debug object percpu free list
- * Access is protected by disabling irq
- */
-struct debug_percpu_free {
-	struct hlist_head	free_objs;
-	int			obj_free;
+struct pcpu_pool {
+	unsigned int		slot_idx;
+	unsigned int		cnt;
+	struct hlist_head	slots[ODEBUG_PCPU_SLOTS];
 };
 
-static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
+struct global_pool {
+	unsigned int		slot_idx;
+	unsigned int		tot_cnt;
+	unsigned int		bulk_cnt;
+	struct hlist_head	slots[ODEBUG_POOL_SLOTS];
+	struct hlist_head	bulk;
+} ____cacheline_aligned;
+
+
+static DEFINE_PER_CPU_ALIGNED(struct pcpu_pool, percpu_pool);
 
 static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
 
@@ -60,8 +73,10 @@ static struct debug_obj		obj_static_pool
 
 static DEFINE_RAW_SPINLOCK(pool_lock);
 
-static HLIST_HEAD(obj_pool);
-static HLIST_HEAD(obj_to_free);
+static struct global_pool	pool_global;
+static struct global_pool	pool_to_free;
+
+static HLIST_HEAD(pool_boot);
 
 /*
  * Because of the presence of percpu free pools, obj_pool_free will
@@ -71,12 +86,9 @@ static HLIST_HEAD(obj_to_free);
  * can be off.
  */
 static int __data_racy		obj_pool_min_free = ODEBUG_POOL_SIZE;
-static int __data_racy		obj_pool_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_used;
 static int __data_racy		obj_pool_max_used;
 static bool			obj_freeing;
-/* The number of objs on the global free list */
-static int			obj_nr_tofree;
 
 static int __data_racy			debug_objects_maxchain __read_mostly;
 static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
@@ -125,85 +137,71 @@ static const char *obj_states[ODEBUG_STA
 	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
 };
 
-static void fill_pool(void)
+static bool pool_pop_slot(struct global_pool *src, struct hlist_head *head)
 {
-	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
-	struct debug_obj *obj;
-	unsigned long flags;
+	if (!src->slot_idx)
+		return false;
 
-	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
-		return;
+	hlist_move_list(&src->slots[--src->slot_idx], head);
+	WRITE_ONCE(src->tot_cnt, src->tot_cnt - ODEBUG_BATCH_SIZE);
+	return true;
+}
 
-	/*
-	 * Reuse objs from the global obj_to_free list; they will be
-	 * reinitialized when allocating.
-	 *
-	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
-	 * the WRITE_ONCE() in pool_lock critical sections.
-	 */
-	if (READ_ONCE(obj_nr_tofree)) {
-		raw_spin_lock_irqsave(&pool_lock, flags);
-		/*
-		 * Recheck with the lock held as the worker thread might have
-		 * won the race and freed the global free list already.
-		 */
-		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
-			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-			hlist_del(&obj->node);
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-			hlist_add_head(&obj->node, &obj_pool);
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
-	}
+static bool pool_push_slot(struct global_pool *dst, struct hlist_head *head)
+{
+	if (dst->slot_idx >= ODEBUG_POOL_SLOTS)
+		return false;
 
-	if (unlikely(!obj_cache))
+	hlist_move_list(head, &dst->slots[dst->slot_idx++]);
+	WRITE_ONCE(dst->tot_cnt, dst->tot_cnt + ODEBUG_BATCH_SIZE);
+	return true;
+}
+
+static void pool_move_slot(struct global_pool *dst, struct global_pool *src)
+{
+	hlist_move_list(&src->slots[--src->slot_idx], &dst->slots[dst->slot_idx++]);
+	WRITE_ONCE(src->tot_cnt, src->tot_cnt - ODEBUG_BATCH_SIZE);
+	WRITE_ONCE(dst->tot_cnt, dst->tot_cnt + ODEBUG_BATCH_SIZE);
+}
+
+static void pool_move_slots(struct global_pool *dst, struct global_pool *src, unsigned int cnt)
+{
+	for (; cnt && src->slot_idx > 0 && dst->slot_idx < ODEBUG_POOL_SLOTS; cnt--)
+		pool_move_slot(dst, src);
+}
+
+static void pool_to_free_add_batch(struct hlist_head *head, unsigned int cnt)
+{
+	struct hlist_node *cur, *last = NULL;
+
+	if (!cnt)
 		return;
 
-	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
-		struct debug_obj *new[ODEBUG_BATCH_SIZE];
-		int cnt;
+	/* Fit it into a slot if possible */
+	if (cnt == ODEBUG_BATCH_SIZE && pool_push_slot(&pool_to_free, head))
+		return;
 
-		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
-			if (!new[cnt])
-				break;
-		}
-		if (!cnt)
-			return;
+	/* Should rarely happen */
+	hlist_for_each(cur, head)
+		last = cur;
 
-		raw_spin_lock_irqsave(&pool_lock, flags);
-		while (cnt) {
-			hlist_add_head(&new[--cnt]->node, &obj_pool);
-			debug_objects_allocated++;
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
-	}
+	hlist_splice_init(head, last, &pool_to_free.bulk);
+	WRITE_ONCE(pool_to_free.tot_cnt, pool_to_free.tot_cnt + cnt);
+	pool_to_free.bulk_cnt += cnt;
 }
 
-/*
- * Lookup an object in the hash bucket.
- */
-static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
+static unsigned int pool_to_free_pop_bulk(struct hlist_head *head)
 {
-	struct debug_obj *obj;
-	int cnt = 0;
+	unsigned int cnt = pool_to_free.bulk_cnt;
 
-	hlist_for_each_entry(obj, &b->list, node) {
-		cnt++;
-		if (obj->object == addr)
-			return obj;
+	if (cnt) {
+		hlist_move_list(&pool_to_free.bulk, head);
+		WRITE_ONCE(pool_to_free.tot_cnt, pool_to_free.tot_cnt + cnt);
+		pool_to_free.bulk_cnt = 0;
 	}
-	if (cnt > debug_objects_maxchain)
-		debug_objects_maxchain = cnt;
-
-	return NULL;
+	return cnt;
 }
 
-/*
- * Allocate a new object from the hlist
- */
 static struct debug_obj *__alloc_object(struct hlist_head *list)
 {
 	struct debug_obj *obj = NULL;
@@ -212,206 +210,252 @@ static struct debug_obj *__alloc_object(
 		obj = hlist_entry(list->first, typeof(*obj), node);
 		hlist_del(&obj->node);
 	}
-
 	return obj;
 }
 
-static struct debug_obj *
-alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
+static struct debug_obj *pcpu_alloc(void)
 {
-	struct debug_percpu_free *percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+	struct pcpu_pool *pcp = this_cpu_ptr(&percpu_pool);
 	struct debug_obj *obj;
 
-	if (likely(obj_cache)) {
-		obj = __alloc_object(&percpu_pool->free_objs);
+	lockdep_assert_irqs_disabled();
+
+	for (;;) {
+		/* Try to allocate from the current slot */
+		obj = __alloc_object(&pcp->slots[pcp->slot_idx]);
 		if (obj) {
-			percpu_pool->obj_free--;
-			goto init_obj;
+			pcp->cnt--;
+			return obj;
 		}
-	}
 
-	raw_spin_lock(&pool_lock);
-	obj = __alloc_object(&obj_pool);
-	if (obj) {
-		obj_pool_used++;
-		WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
-
-		/*
-		 * Looking ahead, allocate one batch of debug objects and
-		 * put them into the percpu free pool.
-		 */
-		if (likely(obj_cache)) {
-			int i;
+		/* Is there another slot? */
+		if (pcp->slot_idx) {
+			pcp->slot_idx--;
+			continue;
+		}
 
-			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
-				struct debug_obj *obj2;
+		/* Get a batch from the global pool */
+		guard(raw_spinlock)(&pool_lock);
+		if (!pool_pop_slot(&pool_global, &pcp->slots[0]))
+			return NULL;
 
-				obj2 = __alloc_object(&obj_pool);
-				if (!obj2)
-					break;
-				hlist_add_head(&obj2->node,
-					       &percpu_pool->free_objs);
-				percpu_pool->obj_free++;
-				obj_pool_used++;
-				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
-			}
-		}
+		pcp->cnt = ODEBUG_BATCH_SIZE;
 
+		/* Statistics */
+		WRITE_ONCE(obj_pool_used, obj_pool_used + ODEBUG_BATCH_SIZE);
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
 
-		if (obj_pool_free < obj_pool_min_free)
-			obj_pool_min_free = obj_pool_free;
+		if (pool_global.tot_cnt < obj_pool_min_free)
+			obj_pool_min_free = pool_global.tot_cnt;
 	}
-	raw_spin_unlock(&pool_lock);
+}
 
-init_obj:
-	if (obj) {
-		obj->object = addr;
-		obj->descr  = descr;
-		obj->state  = ODEBUG_STATE_NONE;
-		obj->astate = 0;
-		hlist_add_head(&obj->node, &b->list);
-	}
-	return obj;
+static void pcpu_free(struct debug_obj *obj)
+{
+	struct pcpu_pool *pcp = this_cpu_ptr(&percpu_pool);
+
+	lockdep_assert_irqs_disabled();
+
+	hlist_add_head(&obj->node, &pcp->slots[pcp->slot_idx]);
+	pcp->cnt++;
+
+	/* Did this fill up the current slot? */
+	if (pcp->cnt & ODEBUG_BATCH_SIZE_MASK)
+		return;
+
+	/* Did it fill the last slot? */
+	if (++pcp->slot_idx < ODEBUG_PCPU_SLOTS)
+		return;
+
+	pcp->slot_idx--;
+	pcp->cnt -= ODEBUG_BATCH_SIZE;
+
+	guard(raw_spinlock)(&pool_lock);
+	WRITE_ONCE(obj_pool_used, obj_pool_used - ODEBUG_BATCH_SIZE);
+	/* Try to fit the batch into a free slot of pool_global first. */
+	if (pool_push_slot(&pool_global, &pcp->slots[pcp->slot_idx]))
+		return;
+	/* Schedule it for removal */
+	pool_to_free_add_batch(&pcp->slots[pcp->slot_idx], ODEBUG_BATCH_SIZE);
 }
 
-/*
- * workqueue function to free objects.
- *
- * To reduce contention on the global pool_lock, the actual freeing of
- * debug objects will be delayed if the pool_lock is busy.
- */
-static void free_obj_work(struct work_struct *work)
+static void free_object_list(struct hlist_head *head)
 {
 	struct hlist_node *tmp;
 	struct debug_obj *obj;
-	unsigned long flags;
-	HLIST_HEAD(tofree);
 
-	WRITE_ONCE(obj_freeing, false);
-	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
+	hlist_for_each_entry_safe(obj, tmp, head, node) {
+		hlist_del(&obj->node);
+		kmem_cache_free(obj_cache, obj);
+	}
+}
+
+static void fill_pool_from_freelist(void)
+{
+	static unsigned long state;
+
+	/*
+	 * Reuse objs from the global obj_to_free list; they will be
+	 * reinitialized when allocating.
+	 *
+	 * pool_to_free.tot_cnt is checked locklessly; the READ_ONCE() pairs with
+	 * the WRITE_ONCE() in pool_lock critical sections.
+	 */
+	if (!READ_ONCE(pool_to_free.tot_cnt))
 		return;
 
-	if (obj_pool_free >= debug_objects_pool_size)
-		goto free_objs;
+	/*
+	 * Prevent the context from being scheduled or interrupted after
+	 * setting the state flag;
+	 */
+	guard(irqsave)();
 
 	/*
-	 * The objs on the pool list might be allocated before the work is
-	 * run, so recheck if pool list it full or not, if not fill pool
-	 * list from the global free list. As it is likely that a workload
-	 * may be gearing up to use more and more objects, don't free any
-	 * of them until the next round.
+	 * Avoid lock contention on &pool_lock and avoid making the cache
+	 * line exclusive by testing the bit before attempting to set it.
 	 */
-	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
-		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-		hlist_del(&obj->node);
-		hlist_add_head(&obj->node, &obj_pool);
-		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
-	return;
+	if (test_bit(0, &state) || test_and_set_bit(0, &state))
+		return;
 
-free_objs:
+	guard(raw_spinlock)(&pool_lock);
 	/*
-	 * Pool list is already full and there are still objs on the free
-	 * list. Move remaining free objs to a temporary list to free the
-	 * memory outside the pool_lock held region.
+	 * Recheck with the lock held as the worker thread might have
+	 * won the race and freed the global free list already.
 	 */
-	if (obj_nr_tofree) {
-		hlist_move_list(&obj_to_free, &tofree);
-		debug_objects_freed += obj_nr_tofree;
-		WRITE_ONCE(obj_nr_tofree, 0);
-	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	pool_move_slots(&pool_global, &pool_to_free, ODEBUG_BATCH_SIZE);
 
-	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
-		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
-	}
+	clear_bit(0, &state);
 }
 
-static void __free_object(struct debug_obj *obj)
+static void fill_pool(void)
 {
-	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
-	struct debug_percpu_free *percpu_pool;
-	int lookahead_count = 0;
-	unsigned long flags;
-	bool work;
+	static atomic_t cpus_allocating;
+	HLIST_HEAD(head);
 
-	local_irq_save(flags);
-	if (!obj_cache)
-		goto free_to_obj_pool;
+	if (unlikely(!obj_cache))
+		return;
 
 	/*
-	 * Try to free it into the percpu pool first.
+	 * Avoid allocation and lock contention when
+	 *
+	 *   - the CPU local pool has at least 2 objects left
+	 *   - another CPU is already in the allocation path
+	 *   - the global pool has not reached the critical level yet
 	 */
-	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
-	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
-		hlist_add_head(&obj->node, &percpu_pool->free_objs);
-		percpu_pool->obj_free++;
-		local_irq_restore(flags);
+	if (this_cpu_read(percpu_pool.cnt) > 1 && atomic_read(&cpus_allocating) &&
+	    READ_ONCE(pool_global.tot_cnt) > (debug_objects_pool_min_level / 2))
 		return;
-	}
 
-	/*
-	 * As the percpu pool is full, look ahead and pull out a batch
-	 * of objects from the percpu pool and free them as well.
-	 */
-	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
-		objs[lookahead_count] = __alloc_object(&percpu_pool->free_objs);
-		if (!objs[lookahead_count])
-			break;
-		percpu_pool->obj_free--;
-	}
+	atomic_inc(&cpus_allocating);
+	while (READ_ONCE(pool_global.tot_cnt) < debug_objects_pool_min_level) {
+		struct debug_obj *obj;
+		unsigned int cnt;
 
-free_to_obj_pool:
-	raw_spin_lock(&pool_lock);
-	work = (obj_pool_free > debug_objects_pool_size) && obj_cache &&
-	       (obj_nr_tofree < ODEBUG_FREE_WORK_MAX);
-	obj_pool_used--;
-
-	if (work) {
-		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
-		hlist_add_head(&obj->node, &obj_to_free);
-		if (lookahead_count) {
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + lookahead_count);
-			obj_pool_used -= lookahead_count;
-			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
-					       &obj_to_free);
+		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
+			obj = kmem_cache_zalloc(obj_cache, __GFP_HIGH | __GFP_NOWARN);
+			if (!obj) {
+				/* The global pool requires batch sized fills */
+				pool_to_free_add_batch(&head, cnt);
+				goto out;
 			}
+			hlist_add_head(&obj->node, &head);
 		}
 
-		if ((obj_pool_free > debug_objects_pool_size) &&
-		    (obj_nr_tofree < ODEBUG_FREE_WORK_MAX)) {
-			int i;
-
-			/*
-			 * Free one more batch of objects from obj_pool.
-			 */
-			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
-				obj = __alloc_object(&obj_pool);
-				hlist_add_head(&obj->node, &obj_to_free);
-				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
-				WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
-			}
+		guard(raw_spinlock_irqsave)(&pool_lock);
+		debug_objects_allocated += cnt;
+		/*
+		 * This can race against refills, so if the pool is full
+		 * put the batch into pool_to_free.
+		 */
+		if (!pool_push_slot(&pool_global, &head)) {
+			pool_to_free_add_batch(&head, ODEBUG_BATCH_SIZE);
+			break;
 		}
-	} else {
-		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		hlist_add_head(&obj->node, &obj_pool);
-		if (lookahead_count) {
-			WRITE_ONCE(obj_pool_free, obj_pool_free + lookahead_count);
-			obj_pool_used -= lookahead_count;
-			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
-					       &obj_pool);
-			}
+	}
+out:
+	atomic_dec(&cpus_allocating);
+	return;
+}
+
+/*
+ * Lookup an object in the hash bucket.
+ */
+static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
+{
+	struct debug_obj *obj;
+	int cnt = 0;
+
+	hlist_for_each_entry(obj, &b->list, node) {
+		cnt++;
+		if (obj->object == addr)
+			return obj;
+	}
+	if (cnt > debug_objects_maxchain)
+		debug_objects_maxchain = cnt;
+
+	return NULL;
+}
+
+static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
+				      const struct debug_obj_descr *descr)
+{
+	struct debug_obj *obj;
+
+	if (likely(obj_cache))
+		obj = pcpu_alloc();
+	else
+		obj = __alloc_object(&pool_boot);
+
+	if (likely(obj)) {
+		obj->object = addr;
+		obj->descr  = descr;
+		obj->state  = ODEBUG_STATE_NONE;
+		obj->astate = 0;
+		hlist_add_head(&obj->node, &b->list);
+	}
+	return obj;
+}
+
+/* workqueue function to free objects. */
+static void free_obj_work(struct work_struct *work)
+{
+	HLIST_HEAD(tofree);
+	unsigned int cnt;
+
+	if (!pool_to_free.tot_cnt)
+		return;
+
+	scoped_guard(raw_spinlock_irqsave, &pool_lock)
+		cnt = pool_to_free_pop_bulk(&tofree);
+
+	free_object_list(&tofree);
+
+	for (; cnt < ODEBUG_FREE_WORK_MAX;) {
+		/* Drop the lock for each slot */
+		scoped_guard(raw_spinlock_irqsave, &pool_lock) {
+			if (!pool_to_free.slot_idx)
+				break;
+			/* Refill the global pool if possible */
+			if (pool_global.slot_idx < ODEBUG_POOL_SLOTS)
+				pool_move_slot(&pool_global, &pool_to_free);
+			else
+				cnt += pool_pop_slot(&pool_to_free, &tofree);
 		}
+		free_object_list(&tofree);
 	}
-	raw_spin_unlock(&pool_lock);
-	local_irq_restore(flags);
+
+	WRITE_ONCE(obj_freeing, false);
+}
+
+static void __free_object(struct debug_obj *obj)
+{
+	/* Protects per CPU pool and boot pool */
+	guard(irqsave)();
+	if (likely(obj_cache))
+		pcpu_free(obj);
+	else
+		hlist_add_head(&obj->node, &pool_boot);
 }
 
 /*
@@ -421,37 +465,30 @@ static void __free_object(struct debug_o
 static void free_object(struct debug_obj *obj)
 {
 	__free_object(obj);
-	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
+	if (!READ_ONCE(obj_freeing) && READ_ONCE(pool_to_free.tot_cnt)) {
 		WRITE_ONCE(obj_freeing, true);
 		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
 	}
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int object_cpu_offline(unsigned int cpu)
 {
-	struct debug_percpu_free *percpu_pool;
-	struct hlist_node *tmp;
-	struct debug_obj *obj;
-	unsigned long flags;
-
 	/* Remote access is safe as the CPU is dead already */
-	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
-	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
-		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
-	}
+	struct pcpu_pool *pcp = per_cpu_ptr(&percpu_pool, cpu);
+	int freed = pcp->cnt;
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
-	obj_pool_used -= percpu_pool->obj_free;
-	debug_objects_freed += percpu_pool->obj_free;
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	pcp->cnt = 0;
+	pcp->slot_idx = 0;
 
-	percpu_pool->obj_free = 0;
+	for (int i = 0; i < ODEBUG_PCPU_SLOTS; i++)
+		free_object_list(&pcp->slots[i]);
 
+	scoped_guard(raw_spinlock_irqsave, &pool_lock) {
+		WRITE_ONCE(obj_pool_used, obj_pool_used - freed);
+		debug_objects_freed += freed;
+	}
 	return 0;
 }
-#endif
 
 /*
  * We run out of memory. That means we probably have tons of objects
@@ -460,24 +497,15 @@ static int object_cpu_offline(unsigned i
 static void debug_objects_oom(void)
 {
 	struct debug_bucket *db = obj_hash;
-	struct hlist_node *tmp;
 	HLIST_HEAD(freelist);
-	struct debug_obj *obj;
-	unsigned long flags;
-	int i;
 
 	pr_warn("Out of memory. ODEBUG disabled\n");
 
-	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
-		raw_spin_lock_irqsave(&db->lock, flags);
-		hlist_move_list(&db->list, &freelist);
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+	for (int i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
+		scoped_guard(raw_spinlock_irqsave, &db->lock)
+			hlist_move_list(&db->list, &freelist);
 
-		/* Now free them */
-		hlist_for_each_entry_safe(obj, tmp, &freelist, node) {
-			hlist_del(&obj->node);
-			free_object(obj);
-		}
+		free_object_list(&freelist);
 	}
 }
 
@@ -598,6 +626,15 @@ static struct debug_obj *lookup_object_o
 
 static void debug_objects_fill_pool(void)
 {
+	if (likely(READ_ONCE(pool_global.tot_cnt) >= debug_objects_pool_min_level))
+		return;
+
+	/* Try reusing objects from obj_to_free_list */
+	fill_pool_from_freelist();
+
+	if (likely(READ_ONCE(pool_global.tot_cnt) >= debug_objects_pool_min_level))
+		return;
+
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
 	 * context -- for !RT kernels we rely on the fact that spinlock_t and
@@ -1007,7 +1044,7 @@ static void __debug_check_no_obj_freed(c
 		debug_objects_maxchecked = objs_checked;
 
 	/* Schedule work to actually kmem_cache_free() objects */
-	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
+	if (!READ_ONCE(obj_freeing) && READ_ONCE(pool_to_free.tot_cnt)) {
 		WRITE_ONCE(obj_freeing, true);
 		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
 	}
@@ -1027,18 +1064,18 @@ static int debug_stats_show(struct seq_f
 	int cpu, obj_percpu_free = 0;
 
 	for_each_possible_cpu(cpu)
-		obj_percpu_free += per_cpu(percpu_obj_pool.obj_free, cpu);
+		obj_percpu_free += per_cpu(percpu_pool.cnt, cpu);
 
 	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
 	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
 	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
 	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
-	seq_printf(m, "pool_free     :%d\n", READ_ONCE(obj_pool_free) + obj_percpu_free);
+	seq_printf(m, "pool_free     :%d\n", READ_ONCE(pool_global.tot_cnt) + obj_percpu_free);
 	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
 	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
-	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
+	seq_printf(m, "pool_used     :%d\n", READ_ONCE(obj_pool_used) - obj_percpu_free);
 	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
-	seq_printf(m, "on_free_list  :%d\n", READ_ONCE(obj_nr_tofree));
+	seq_printf(m, "on_free_list  :%d\n", READ_ONCE(pool_to_free.tot_cnt));
 	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
 	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
 	return 0;
@@ -1295,65 +1332,63 @@ void __init debug_objects_early_init(voi
 	for (i = 0; i < ODEBUG_HASH_SIZE; i++)
 		raw_spin_lock_init(&obj_hash[i].lock);
 
+	/* Keep early boot simple and add everything to the boot list */
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
-		hlist_add_head(&obj_static_pool[i].node, &obj_pool);
+		hlist_add_head(&obj_static_pool[i].node, &pool_boot);
 }
 
 /*
  * Convert the statically allocated objects to dynamic ones:
+ *
+ * debug_objects_mem_init() is called early that only one CPU is up and
+ * interrupts have been disabled, so it is safe to replace the active
+ * object references.
  */
-static int __init debug_objects_replace_static_objects(void)
+static bool __init debug_objects_replace_static_objects(void)
 {
 	struct debug_bucket *db = obj_hash;
-	struct hlist_node *tmp;
 	struct debug_obj *obj, *new;
+	struct hlist_node *tmp;
 	HLIST_HEAD(objects);
-	int i, cnt = 0;
+	int i, cnt;
+
+	/* Remove the statically allocated objects from the boot pool first */
+	hlist_for_each_entry_safe(obj, tmp, &pool_boot, node)
+		hlist_del(&obj->node);
 
-	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
+	for (i = 0; i < ODEBUG_POOL_SIZE; ) {
 		obj = kmem_cache_zalloc(obj_cache, GFP_KERNEL);
 		if (!obj)
 			goto free;
 		hlist_add_head(&obj->node, &objects);
+
+		/* If a batch is full add it to the pool. */
+		if (!(++i & ODEBUG_BATCH_SIZE_MASK))
+			pool_push_slot(&pool_global, &objects);
 	}
 
 	debug_objects_allocated += i;
 
-	/*
-	 * debug_objects_mem_init() is now called early that only one CPU is up
-	 * and interrupts have been disabled, so it is safe to replace the
-	 * active object references.
-	 */
-
-	/* Remove the statically allocated objects from the pool */
-	hlist_for_each_entry_safe(obj, tmp, &obj_pool, node)
-		hlist_del(&obj->node);
-	/* Move the allocated objects to the pool */
-	hlist_move_list(&objects, &obj_pool);
-
 	/* Replace the active object references */
-	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
+	for (i = 0, cnt = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
 		hlist_move_list(&db->list, &objects);
 
 		hlist_for_each_entry(obj, &objects, node) {
-			new = hlist_entry(obj_pool.first, typeof(*obj), node);
-			hlist_del(&new->node);
-			/* copy object data */
+			new = pcpu_alloc();
 			*new = *obj;
 			hlist_add_head(&new->node, &db->list);
 			cnt++;
 		}
 	}
 
-	pr_debug("%d of %d active objects replaced\n",
-		 cnt, obj_pool_used);
-	return 0;
+	pr_debug("%d of %d active objects replaced\n", cnt, obj_pool_used);
+	return true;
+
 free:
-	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
-		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
-	}
-	return -ENOMEM;
+	for (i = 0; i < pool_global.slot_idx; i++)
+		free_object_list(&pool_global.slots[i]);
+	object_cpu_offline(smp_processor_id());
+	return false;
 }
 
 /*
@@ -1364,32 +1399,24 @@ static int __init debug_objects_replace_
  */
 void __init debug_objects_mem_init(void)
 {
-	int cpu, extras;
+	int extras;
 
 	if (!debug_objects_enabled)
 		return;
 
-	/*
-	 * Initialize the percpu object pools
-	 *
-	 * Initialization is not strictly necessary, but was done for
-	 * completeness.
-	 */
-	for_each_possible_cpu(cpu)
-		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
-
 	obj_cache = kmem_cache_create("debug_objects_cache",
 				      sizeof (struct debug_obj), 0,
 				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
 				      NULL);
 
-	if (!obj_cache || debug_objects_replace_static_objects()) {
+	if (!obj_cache || !debug_objects_replace_static_objects()) {
 		debug_objects_enabled = 0;
 		kmem_cache_destroy(obj_cache);
 		pr_warn("out of memory.\n");
 		return;
-	} else
+	} else {
 		debug_objects_selftest();
+	}
 
 #ifdef CONFIG_HOTPLUG_CPU
 	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,

