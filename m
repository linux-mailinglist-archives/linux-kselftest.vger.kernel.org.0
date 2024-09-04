Return-Path: <linux-kselftest+bounces-17130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D0796BF09
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36240B21BB9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5590C1DC074;
	Wed,  4 Sep 2024 13:43:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05326AED;
	Wed,  4 Sep 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457393; cv=none; b=TT0ONfS+JCBkwrZtCfY/HPieoQe7JqznHDZCjOmO7p3xiHypLQPUl/HdxaScN3rJsJa2WV6sJQRCLjoxILH4hVVtklfcC6rv2SbRrljjONm1CGSoVRFKxb4rx+mKcLJZAwa8TuNgmLIEb2UJLEb5e4EHsGCEKzKamsDrS5VZsWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457393; c=relaxed/simple;
	bh=WJruaXu+nUQrcWNfoAkMgZRTsoQ2DFt1JM6CBHiFsG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNmDRcSjQZUDp5gVqP5FOI/fzQ048LCzPHBkVIO1wx19skUn6Inat/R8i22vhjJIIWOAaULh859hl/CZ9N3mRpQr0K+9H+KIfN8amHvBaBp5S0mgBc8CCRggV7ZI/ud46kMD7ovLE0Q4hMzdSbUD454aNsbW1y5S/vHTrmKd7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WzNq664mXz69WX;
	Wed,  4 Sep 2024 21:38:10 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CD0518024B;
	Wed,  4 Sep 2024 21:43:08 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:43:08 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>, David Gow
	<davidgow@google.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 3/3] debugobjects: Use hlist_cut_number() to optimize performance and improve readability
Date: Wed, 4 Sep 2024 21:41:52 +0800
Message-ID: <20240904134152.2141-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20240904134152.2141-1-thunder.leizhen@huawei.com>
References: <20240904134152.2141-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Currently, there are multiple instances where several nodes are extracted
from one list and added to another list. One by one extraction, and then
one by one splicing, not only low efficiency, readability is also poor.
The work can be done well with hlist_cut_number() and hlist_splice_init(),
which move the entire sublist at once.

When the number of nodes expected to be moved is less than or equal to 0,
or the source list is empty, hlist_cut_number() safely returns 0. The
splicing is performed only when the return value of hlist_cut_number() is
greater than 0.

For two calls to hlist_cut_number() in __free_object(), the result is
obviously positive, the check of the return value is omitted.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 115 +++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 67 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index db8f6b4b8b3151a..1cb9458af3d0b4f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -128,8 +128,9 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 static void fill_pool(void)
 {
 	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
-	struct debug_obj *obj;
+	HLIST_HEAD(freelist);
 	unsigned long flags;
+	int cnt;
 
 	/*
 	 * The upper-layer function uses only one node at a time. If there are
@@ -152,17 +153,19 @@ static void fill_pool(void)
 	 * the WRITE_ONCE() in pool_lock critical sections.
 	 */
 	if (READ_ONCE(obj_nr_tofree)) {
+		struct hlist_node *last;
+
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have
 		 * won the race and freed the global free list already.
 		 */
-		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
-			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-			hlist_del(&obj->node);
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-			hlist_add_head(&obj->node, &obj_pool);
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
+		cnt = min(obj_nr_tofree, debug_objects_pool_min_level - obj_pool_free);
+		cnt = hlist_cut_number(&freelist, &obj_to_free, cnt, &last);
+		if (cnt > 0) {
+			hlist_splice_init(&freelist, last, &obj_pool);
+			WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
+			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - cnt);
 		}
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
@@ -172,8 +175,6 @@ static void fill_pool(void)
 
 	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
 		struct debug_obj *new, *last = NULL;
-		HLIST_HEAD(freelist);
-		int cnt;
 
 		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
 			new = kmem_cache_zalloc(obj_cache, gfp);
@@ -245,30 +246,28 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 	raw_spin_lock(&pool_lock);
 	obj = __alloc_object(&obj_pool);
 	if (obj) {
-		obj_pool_used++;
-		WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
+		int cnt = 0;
 
 		/*
 		 * Looking ahead, allocate one batch of debug objects and
 		 * put them into the percpu free pool.
 		 */
 		if (likely(obj_cache)) {
-			int i;
-
-			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
-				struct debug_obj *obj2;
-
-				obj2 = __alloc_object(&obj_pool);
-				if (!obj2)
-					break;
-				hlist_add_head(&obj2->node,
-					       &percpu_pool->free_objs);
-				percpu_pool->obj_free++;
-				obj_pool_used++;
-				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
+			struct hlist_node *last;
+			HLIST_HEAD(freelist);
+
+			cnt = hlist_cut_number(&freelist, &obj_pool, ODEBUG_BATCH_SIZE, &last);
+			if (cnt > 0) {
+				hlist_splice_init(&freelist, last, &percpu_pool->free_objs);
+				percpu_pool->obj_free += cnt;
 			}
 		}
 
+		/* add one for obj */
+		cnt++;
+		obj_pool_used += cnt;
+		WRITE_ONCE(obj_pool_free, obj_pool_free - cnt);
+
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
 
@@ -300,6 +299,7 @@ static void free_obj_work(struct work_struct *work)
 	struct debug_obj *obj;
 	unsigned long flags;
 	HLIST_HEAD(tofree);
+	int cnt;
 
 	WRITE_ONCE(obj_freeing, false);
 	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
@@ -315,12 +315,12 @@ static void free_obj_work(struct work_struct *work)
 	 * may be gearing up to use more and more objects, don't free any
 	 * of them until the next round.
 	 */
-	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
-		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-		hlist_del(&obj->node);
-		hlist_add_head(&obj->node, &obj_pool);
-		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
+	cnt = min(obj_nr_tofree, debug_objects_pool_size - obj_pool_free);
+	cnt = hlist_cut_number(&tofree, &obj_to_free, cnt, &tmp);
+	if (cnt > 0) {
+		hlist_splice_init(&tofree, tmp, &obj_pool);
+		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
+		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - cnt);
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
 	return;
@@ -346,11 +346,12 @@ static void free_obj_work(struct work_struct *work)
 
 static void __free_object(struct debug_obj *obj)
 {
-	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
 	struct debug_percpu_free *percpu_pool;
-	int lookahead_count = 0;
+	struct hlist_node *last;
+	HLIST_HEAD(freelist);
 	unsigned long flags;
 	bool work;
+	int cnt;
 
 	local_irq_save(flags);
 	if (!obj_cache)
@@ -371,56 +372,36 @@ static void __free_object(struct debug_obj *obj)
 	 * As the percpu pool is full, look ahead and pull out a batch
 	 * of objects from the percpu pool and free them as well.
 	 */
-	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
-		objs[lookahead_count] = __alloc_object(&percpu_pool->free_objs);
-		if (!objs[lookahead_count])
-			break;
-		percpu_pool->obj_free--;
-	}
+	cnt = hlist_cut_number(&freelist, &percpu_pool->free_objs, ODEBUG_BATCH_SIZE, &last);
+	percpu_pool->obj_free -= cnt;
+
+	/* add one for obj */
+	cnt++;
+	hlist_add_head(&obj->node, &freelist);
 
 free_to_obj_pool:
 	raw_spin_lock(&pool_lock);
 	work = (obj_pool_free > debug_objects_pool_size) && obj_cache &&
 	       (obj_nr_tofree < ODEBUG_FREE_WORK_MAX);
-	obj_pool_used--;
+	obj_pool_used -= cnt;
 
 	if (work) {
-		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
-		hlist_add_head(&obj->node, &obj_to_free);
-		if (lookahead_count) {
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + lookahead_count);
-			obj_pool_used -= lookahead_count;
-			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
-					       &obj_to_free);
-			}
-		}
+		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + cnt);
+		hlist_splice_init(&freelist, last, &obj_to_free);
 
 		if ((obj_pool_free > debug_objects_pool_size) &&
 		    (obj_nr_tofree < ODEBUG_FREE_WORK_MAX)) {
-			int i;
-
 			/*
 			 * Free one more batch of objects from obj_pool.
 			 */
-			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
-				obj = __alloc_object(&obj_pool);
-				hlist_add_head(&obj->node, &obj_to_free);
-				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
-				WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
-			}
+			cnt = hlist_cut_number(&freelist, &obj_pool, ODEBUG_BATCH_SIZE, &last);
+			hlist_splice_init(&freelist, last, &obj_to_free);
+			WRITE_ONCE(obj_pool_free, obj_pool_free - cnt);
+			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + cnt);
 		}
 	} else {
-		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		hlist_add_head(&obj->node, &obj_pool);
-		if (lookahead_count) {
-			WRITE_ONCE(obj_pool_free, obj_pool_free + lookahead_count);
-			obj_pool_used -= lookahead_count;
-			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
-					       &obj_pool);
-			}
-		}
+		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
+		hlist_splice_init(&freelist, last, &obj_pool);
 	}
 	raw_spin_unlock(&pool_lock);
 	local_irq_restore(flags);
-- 
2.34.1


