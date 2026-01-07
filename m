Return-Path: <linux-kselftest+bounces-48410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE219CFEA1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 16:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A414D30096A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 15:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4BA35B156;
	Wed,  7 Jan 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S+yecEhH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B5F35970C
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798963; cv=none; b=PvTyCVQ16aQi/pfUR3O5sZeWyqA6n3gMx8tnO9/Xoc8CIiazCWCAukBrueIGVsBNaUR9VGvysrJf65t4oyKQDo6pX6n8iiQRzKUlFoK5aDc2BTWGgXDHzeVuLGzIjaJaFFxxsh8n6BR9wgO96h0KWwNz5ZHB12tlpHSLsfB2usI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798963; c=relaxed/simple;
	bh=7zfY6E4OYlRQz5H3tswFfUB6WTcCWpY7jL8xMLVMor4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ri3Am5p5g++pj9JUg/1TlCS7p1xFUzSJXPKqWu7XGYuOpg0SHPOkD761G+LC7aeY9ORgTk2MGXBNCnnNtSM9TxINxE2q5ZlFEwArn7/ZinxthJ+3APKL+Gz0PC3eJXv0lirj7MP3DwGkfEYh9GuPk/Mg26aBcBzdR/xEqMZBaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S+yecEhH; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767798958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOYJiC+4W9I02ZkyI5xI7Fklb6i52wrV7BD9k2cFsGY=;
	b=S+yecEhH8js08yr7t5wtOV7zMWSq+vsW2gKDO4y6CDOdClwqDMpMREoVBlqbiDLW6aNkVN
	h763hsZgO3LwBN9GXw6+YATbHMgKppRLo5Uwgs9a2adIoV8gKKoxATwmBwvxxsff6vgDTQ
	uyMFAbtCm+65ggYz1PqRt7hVzyP+rro=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 4/5] bpf: lru: Fix unintended eviction when updating lru hash maps
Date: Wed,  7 Jan 2026 23:14:55 +0800
Message-ID: <20260107151456.72539-5-leon.hwang@linux.dev>
In-Reply-To: <20260107151456.72539-1-leon.hwang@linux.dev>
References: <20260107151456.72539-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When updating an existing element in lru_[percpu_,]hash maps, the current
implementation always calls prealloc_lru_pop() to get a new node before
checking if the key already exists. If the map is full, this triggers
LRU eviction and removes an existing element, even though the update
operation only needs to modify the value of an existing key in-place.

This is problematic because:
1. Users may unexpectedly lose entries when doing simple value updates
2. The eviction overhead is unnecessary for existing key updates

Fix this by first checking if the key exists before allocating a new
node. If the key is found, update the value using the extra lru node
without triggering any eviction.

Fixes: 29ba732acbee ("bpf: Add BPF_MAP_TYPE_LRU_HASH")
Fixes: 8f8449384ec3 ("bpf: Add BPF_MAP_TYPE_LRU_PERCPU_HASH")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_lru_list.c | 164 +++++++++++++++++++++++++++++++++++---
 kernel/bpf/bpf_lru_list.h |   5 +-
 kernel/bpf/hashtab.c      |  91 +++++++++++++++++++--
 3 files changed, 245 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 563707af8035..142b0f10b011 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -124,6 +124,41 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
+static struct bpf_lru_node *__bpf_lru_node_move_from_extra(struct bpf_lru_list *l,
+							   enum bpf_lru_list_type tgt_type)
+{
+	struct bpf_lru_node *node;
+
+	node = list_first_entry_or_null(&l->extra, struct bpf_lru_node, list);
+	if (!node)
+		return NULL;
+
+	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(tgt_type)))
+		return NULL;
+
+	bpf_lru_list_count_inc(l, tgt_type);
+	bpf_lru_node_reset_state(node, tgt_type);
+	list_move(&node->list, &l->lists[tgt_type]);
+	return node;
+}
+
+static bool __bpf_lru_node_move_to_extra(struct bpf_lru_list *l,
+					 struct bpf_lru_node *node)
+{
+	if (!list_empty(&l->extra))
+		return false;
+
+	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(node->type)))
+		return false;
+
+	bpf_lru_move_next_inactive_rotation(l, node);
+
+	bpf_lru_list_count_dec(l, node->type);
+	bpf_lru_node_reset_state(node, BPF_LRU_LIST_T_FREE);
+	list_move(&node->list, &l->extra);
+	return true;
+}
+
 static bool bpf_lru_list_inactive_low(const struct bpf_lru_list *l)
 {
 	return l->counts[BPF_LRU_LIST_T_INACTIVE] <
@@ -305,6 +340,69 @@ static void __local_list_flush(struct bpf_lru_list *l,
 	}
 }
 
+static struct bpf_lru_node *bpf_percpu_lru_pop_extra(struct bpf_lru *lru)
+{
+	int cpu = raw_smp_processor_id();
+	struct bpf_lru_node *node;
+	struct bpf_lru_list *l;
+	unsigned long flags;
+
+	l = per_cpu_ptr(lru->percpu_lru, cpu);
+
+	raw_spin_lock_irqsave(&l->lock, flags);
+
+	node = __bpf_lru_node_move_from_extra(l, BPF_LRU_LIST_T_ACTIVE);
+
+	raw_spin_unlock_irqrestore(&l->lock, flags);
+
+	return node;
+}
+
+static struct bpf_lru_node *bpf_lru_locallist_extra_pop(struct bpf_lru_locallist *l)
+{
+	struct bpf_lru_node *node;
+
+	node = list_first_entry_or_null(&l->extra, struct bpf_lru_node, list);
+	if (node)
+		list_del(&node->list);
+
+	return node;
+}
+
+static void __local_list_add_pending(struct bpf_lru *lru,
+				     struct bpf_lru_locallist *loc_l,
+				     int cpu,
+				     struct bpf_lru_node *node);
+
+static struct bpf_lru_node *bpf_common_lru_pop_extra(struct bpf_lru *lru)
+{
+	struct bpf_common_lru *clru = &lru->common_lru;
+	int cpu = raw_smp_processor_id();
+	struct bpf_lru_locallist *loc_l;
+	struct bpf_lru_node *node;
+	unsigned long flags;
+
+	loc_l = per_cpu_ptr(clru->local_list, cpu);
+
+	raw_spin_lock_irqsave(&loc_l->lock, flags);
+
+	node = bpf_lru_locallist_extra_pop(loc_l);
+	if (node)
+		__local_list_add_pending(lru, loc_l, cpu, node);
+
+	raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+
+	return node;
+}
+
+struct bpf_lru_node *bpf_lru_pop_extra(struct bpf_lru *lru)
+{
+	if (lru->percpu)
+		return bpf_percpu_lru_pop_extra(lru);
+	else
+		return bpf_common_lru_pop_extra(lru);
+}
+
 static void bpf_lru_list_push_free(struct bpf_lru_list *l,
 				   struct bpf_lru_node *node)
 {
@@ -496,6 +594,16 @@ struct bpf_lru_node *bpf_lru_pop_free(struct bpf_lru *lru)
 		return bpf_common_lru_pop_free(lru);
 }
 
+static bool bpf_lru_locallist_extra_push(struct bpf_lru_locallist *loc_l, struct bpf_lru_node *node)
+{
+	if (!list_empty(&loc_l->extra))
+		return false;
+
+	bpf_lru_node_reset_state(node, BPF_LRU_LIST_T_FREE);
+	list_move(&node->list, &loc_l->extra);
+	return true;
+}
+
 static void bpf_common_lru_push_free(struct bpf_lru *lru,
 				     struct bpf_lru_node *node)
 {
@@ -518,8 +626,10 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 			goto check_lru_list;
 		}
 
-		bpf_lru_node_reset_state(node, BPF_LRU_LOCAL_LIST_T_FREE);
-		list_move(&node->list, local_free_list(loc_l));
+		if (!bpf_lru_locallist_extra_push(loc_l, node)) {
+			bpf_lru_node_reset_state(node, BPF_LRU_LOCAL_LIST_T_FREE);
+			list_move(&node->list, local_free_list(loc_l));
+		}
 
 		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
 		return;
@@ -539,7 +649,8 @@ static void bpf_percpu_lru_push_free(struct bpf_lru *lru,
 
 	raw_spin_lock_irqsave(&l->lock, flags);
 
-	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
+	if (!__bpf_lru_node_move_to_extra(l, node))
+		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
 
 	raw_spin_unlock_irqrestore(&l->lock, flags);
 }
@@ -554,9 +665,11 @@ void bpf_lru_push_free(struct bpf_lru *lru, struct bpf_lru_node *node)
 
 static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 				    u32 node_offset, u32 elem_size,
-				    u32 nr_elems)
+				    u32 nr_elems, u32 nr_extra_elems)
 {
-	struct bpf_lru_list *l = &lru->common_lru.lru_list;
+	struct bpf_common_lru *clru = &lru->common_lru;
+	struct bpf_lru_list *l = &clru->lru_list;
+	int cpu;
 	u32 i;
 
 	for (i = 0; i < nr_elems; i++) {
@@ -570,11 +683,26 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 	lru->target_free = clamp((nr_elems / num_possible_cpus()) / 2,
 				 1, LOCAL_FREE_TARGET);
+
+	if (WARN_ON_ONCE(nr_extra_elems != num_possible_cpus()))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct bpf_lru_locallist *loc_l;
+		struct bpf_lru_node *node;
+
+		loc_l = per_cpu_ptr(clru->local_list, cpu);
+		node = (struct bpf_lru_node *)(buf + node_offset);
+		node->cpu = cpu;
+		bpf_lru_node_reset_state(node, BPF_LRU_LIST_T_FREE);
+		list_add(&node->list, &loc_l->extra);
+		buf += elem_size;
+	}
 }
 
 static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 				    u32 node_offset, u32 elem_size,
-				    u32 nr_elems)
+				    u32 nr_elems, u32 nr_extra_elems)
 {
 	u32 i, pcpu_entries;
 	int cpu;
@@ -600,17 +728,31 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		if (i % pcpu_entries)
 			goto again;
 	}
+
+	if (WARN_ON_ONCE(nr_extra_elems != num_possible_cpus()))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct bpf_lru_node *node;
+
+		l = per_cpu_ptr(lru->percpu_lru, cpu);
+		node = (struct bpf_lru_node *)(buf + node_offset);
+		node->cpu = cpu;
+		bpf_lru_node_reset_state(node, BPF_LRU_LIST_T_FREE);
+		list_add(&node->list, &l->extra);
+		buf += elem_size;
+	}
 }
 
 void bpf_lru_populate(struct bpf_lru *lru, void *buf, u32 node_offset,
-		      u32 elem_size, u32 nr_elems)
+		      u32 elem_size, u32 nr_elems, u32 nr_extra_elems)
 {
 	if (lru->percpu)
 		bpf_percpu_lru_populate(lru, buf, node_offset, elem_size,
-					nr_elems);
+					nr_elems, nr_extra_elems);
 	else
 		bpf_common_lru_populate(lru, buf, node_offset, elem_size,
-					nr_elems);
+					nr_elems, nr_extra_elems);
 }
 
 static void bpf_lru_locallist_init(struct bpf_lru_locallist *loc_l, int cpu)
@@ -620,6 +762,8 @@ static void bpf_lru_locallist_init(struct bpf_lru_locallist *loc_l, int cpu)
 	for (i = 0; i < NR_BPF_LRU_LOCAL_LIST_T; i++)
 		INIT_LIST_HEAD(&loc_l->lists[i]);
 
+	INIT_LIST_HEAD(&loc_l->extra);
+
 	loc_l->next_steal = cpu;
 
 	raw_spin_lock_init(&loc_l->lock);
@@ -637,6 +781,8 @@ static void bpf_lru_list_init(struct bpf_lru_list *l)
 
 	l->next_inactive_rotation = &l->lists[BPF_LRU_LIST_T_INACTIVE];
 
+	INIT_LIST_HEAD(&l->extra);
+
 	raw_spin_lock_init(&l->lock);
 }
 
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 29e8300e0fd1..446779341b34 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -33,12 +33,14 @@ struct bpf_lru_list {
 	unsigned int counts[NR_BPF_LRU_LIST_COUNT];
 	/* The next inactive list rotation starts from here */
 	struct list_head *next_inactive_rotation;
+	struct list_head extra; /* for percpu lru */
 
 	raw_spinlock_t lock ____cacheline_aligned_in_smp;
 };
 
 struct bpf_lru_locallist {
 	struct list_head lists[NR_BPF_LRU_LOCAL_LIST_T];
+	struct list_head extra; /* for common lru */
 	u16 next_steal;
 	raw_spinlock_t lock;
 };
@@ -71,9 +73,10 @@ static inline void bpf_lru_node_set_ref(struct bpf_lru_node *node)
 int bpf_lru_init(struct bpf_lru *lru, bool percpu,
 		 del_from_htab_func del_from_htab, void *delete_arg);
 void bpf_lru_populate(struct bpf_lru *lru, void *buf, u32 node_offset,
-		      u32 elem_size, u32 nr_elems);
+		      u32 elem_size, u32 nr_elems, u32 nr_extra_elems);
 void bpf_lru_destroy(struct bpf_lru *lru);
 struct bpf_lru_node *bpf_lru_pop_free(struct bpf_lru *lru);
 void bpf_lru_push_free(struct bpf_lru *lru, struct bpf_lru_node *node);
+struct bpf_lru_node *bpf_lru_pop_extra(struct bpf_lru *lru);
 
 #endif
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c2d12db9036a..a9679fa04b80 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -207,12 +207,12 @@ static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 }
 
 /* Both percpu and fd htab support in-place update, so no need for
- * extra elem. LRU itself can remove the least used element, so
- * there is no need for an extra elem during map_update.
+ * extra elem. LRU requires extra elems to avoid unintended eviction when
+ * updating the existing elems.
  */
 static bool htab_has_extra_elems(struct bpf_htab *htab)
 {
-	return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab(htab);
+	return htab_is_lru(htab) || (!htab_is_percpu(htab) && !is_fd_htab(htab));
 }
 
 static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
@@ -313,6 +313,7 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 static int prealloc_init(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
+	u32 lru_num_entries = num_entries;
 	int err = -ENOMEM, i;
 
 	if (htab_has_extra_elems(htab))
@@ -354,7 +355,8 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (htab_is_lru(htab))
 		bpf_lru_populate(&htab->lru, htab->elems,
 				 offsetof(struct htab_elem, lru_node),
-				 htab->elem_size, num_entries);
+				 htab->elem_size, lru_num_entries,
+				 num_entries - lru_num_entries);
 	else
 		pcpu_freelist_populate(&htab->freelist,
 				       htab->elems + offsetof(struct htab_elem, fnode),
@@ -557,7 +559,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		if (err)
 			goto free_map_locked;
 
-		if (htab_has_extra_elems(htab)) {
+		if (htab_has_extra_elems(htab) && !htab_is_lru(htab)) {
 			err = alloc_extra_elems(htab);
 			if (err)
 				goto free_prealloc;
@@ -1191,6 +1193,75 @@ static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 	bpf_lru_push_free(&htab->lru, &elem->lru_node);
 }
 
+static int htab_lru_map_update_elem_in_place(struct bpf_htab *htab, void *key, void *value,
+					     u64 map_flags, struct bucket *b,
+					     struct hlist_nulls_head *head, u32 hash,
+					     bool percpu, bool onallcpus)
+{
+	struct htab_elem *l_new, *l_old, *l_free;
+	struct bpf_map *map = &htab->map;
+	u32 key_size = map->key_size;
+	struct bpf_lru_node *node;
+	unsigned long flags;
+	void *l_val;
+	int ret;
+
+	node = bpf_lru_pop_extra(&htab->lru);
+	if (!node)
+		return -ENOENT;
+
+	l_new = container_of(node, struct htab_elem, lru_node);
+	l_new->hash = hash;
+	memcpy(l_new->key, key, key_size);
+	if (!percpu) {
+		l_val = htab_elem_value(l_new, key_size);
+		copy_map_value(map, l_val, value);
+		bpf_obj_free_fields(map->record, l_val);
+	}
+
+	ret = htab_lock_bucket(b, &flags);
+	if (ret)
+		goto err_lock_bucket;
+
+	l_old = lookup_elem_raw(head, hash, key, key_size);
+
+	ret = check_flags(htab, l_old, map_flags);
+	if (ret)
+		goto err;
+
+	if (l_old) {
+		bpf_lru_node_set_ref(&l_new->lru_node);
+		if (percpu) {
+			/* per-cpu hash map can update value in-place.
+			 * Keep the same logic in __htab_lru_percpu_map_update_elem().
+			 */
+			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
+					value, onallcpus, map_flags);
+			l_free = l_new;
+		} else {
+			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+			hlist_nulls_del_rcu(&l_old->hash_node);
+			l_free = l_old;
+		}
+	} else {
+		ret = -ENOENT;
+	}
+
+err:
+	htab_unlock_bucket(b, flags);
+
+err_lock_bucket:
+	if (ret) {
+		bpf_lru_push_free(&htab->lru, node);
+	} else {
+		if (l_old && !percpu)
+			bpf_obj_free_fields(map->record, htab_elem_value(l_old, key_size));
+		bpf_lru_push_free(&htab->lru, &l_free->lru_node);
+	}
+
+	return ret;
+}
+
 static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 				     u64 map_flags)
 {
@@ -1215,6 +1286,11 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
+	ret = htab_lru_map_update_elem_in_place(htab, key, value, map_flags, b, head, hash, false,
+						false);
+	if (!ret)
+		return 0;
+
 	/* For LRU, we need to alloc before taking bucket's
 	 * spinlock because getting free nodes from LRU may need
 	 * to remove older elements from htab and this removal
@@ -1354,6 +1430,11 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
+	ret = htab_lru_map_update_elem_in_place(htab, key, value, map_flags, b, head, hash, true,
+						onallcpus);
+	if (!ret)
+		return 0;
+
 	/* For LRU, we need to alloc before taking bucket's
 	 * spinlock because LRU's elem alloc may need
 	 * to remove older elem from htab and this removal
-- 
2.52.0


