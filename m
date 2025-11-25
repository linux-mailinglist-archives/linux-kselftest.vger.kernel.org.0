Return-Path: <linux-kselftest+bounces-46443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FADC859D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE303B277F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34434326D76;
	Tue, 25 Nov 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZuWqxPQZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328E327C1A
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082819; cv=none; b=R39kDZjIerUqIpyDqAG2kAt5vaYN7Yo+0Y0ArR4vtsnynZSFuZ6W0JoxciuQjIA8LhFZQmip5nco60qifTT3dYAwpfFFelhNn+zmA6CzyqyKn23OOLYxDs8YIJm1yOubohN1sk6kwuP5s9QhE4F83+EIGBlD4YaQ0yCSZWxsoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082819; c=relaxed/simple;
	bh=YLYaiilqKClYzhytmoz4mvsubaGXwk6JKfgQRJnZwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnD2zEeqbhv/EieFwciDJUn60zTlx84s+KJVYdw3sudO+bP8VBbA74kP2g7Rh+tw4Lb2glL/Mn/nkULZYHPAFp8zQh2Rq0avq64yIgu7PUCU10NjTR5bG135IvBwT89hthK/Q8qF5GCt4cvT2DnAsubHDeAH+dYg2ea13+HZ9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZuWqxPQZ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764082814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CtARq3xEj4HK+Nz5xzCIbjLK7YrBAKPzzKvtA15d36E=;
	b=ZuWqxPQZzjCclZ+o/Lqrb29oFi8JGn9FSNQE6fsR6tZh6beNN0kEhwmd7ROrchcnumcdpo
	Qk69zs2lCttYwE1nfq4Z+C0VFJXgYxDEeqCFcMWKnIQyYQWDd3YYwfuGIP7WoY+eUihGTZ
	p8wayxtc8J5wVGHeep/ytad8aoGoJMc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	shuah@kernel.org,
	kerneljasonxing@gmail.com,
	chen.dylane@linux.dev,
	willemb@google.com,
	paul.chaignon@gmail.com,
	a.s.protopopov@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	tklauser@distanz.ch,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v11 4/8] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps
Date: Tue, 25 Nov 2025 22:58:53 +0800
Message-ID: <20251125145857.98134-5-leon.hwang@linux.dev>
In-Reply-To: <20251125145857.98134-1-leon.hwang@linux.dev>
References: <20251125145857.98134-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce BPF_F_ALL_CPUS flag support for percpu_hash and lru_percpu_hash
maps to allow updating values for all CPUs with a single value for both
update_elem and update_batch APIs.

Introduce BPF_F_CPU flag support for percpu_hash and lru_percpu_hash
maps to allow:

* update value for specified CPU for both update_elem and update_batch
APIs.
* lookup value for specified CPU for both lookup_elem and lookup_batch
APIs.

The BPF_F_CPU flag is passed via:

* map_flags along with embedded cpu info.
* elem_flags along with embedded cpu info.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v10 -> v11:
 - Drop buggy '(u32)map_flags > BPF_F_ALL_CPUS' check in htab_map_check_update_flags().
 - Update 'map_flags != BPF_EXIST' to '!(map_flags & BPF_EXIST)' in
   __htab_lru_percpu_map_update_elem().
---
 include/linux/bpf.h  |  4 +-
 kernel/bpf/hashtab.c | 96 ++++++++++++++++++++++++++++++--------------
 kernel/bpf/syscall.c |  2 +-
 3 files changed, 69 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 01a99e3a3e51..f79d2ae27335 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2761,7 +2761,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
 
-int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
@@ -3833,6 +3833,8 @@ static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 {
 	switch (map_type) {
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 		return true;
 	default:
 		return false;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c8a9b27f8663..c768bf71d60f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -932,7 +932,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 }
 
 static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
-			    void *value, bool onallcpus)
+			    void *value, bool onallcpus, u64 map_flags)
 {
 	void *ptr;
 
@@ -943,19 +943,28 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 		bpf_obj_free_fields(htab->map.record, ptr);
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
-		int off = 0, cpu;
+		void *val;
+		int cpu;
+
+		if (map_flags & BPF_F_CPU) {
+			cpu = map_flags >> 32;
+			ptr = per_cpu_ptr(pptr, cpu);
+			copy_map_value(&htab->map, ptr, value);
+			bpf_obj_free_fields(htab->map.record, ptr);
+			return;
+		}
 
 		for_each_possible_cpu(cpu) {
 			ptr = per_cpu_ptr(pptr, cpu);
-			copy_map_value_long(&htab->map, ptr, value + off);
+			val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
+			copy_map_value(&htab->map, ptr, val);
 			bpf_obj_free_fields(htab->map.record, ptr);
-			off += size;
 		}
 	}
 }
 
 static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
-			    void *value, bool onallcpus)
+			    void *value, bool onallcpus, u64 map_flags)
 {
 	/* When not setting the initial value on all cpus, zero-fill element
 	 * values for other cpus. Otherwise, bpf program has no way to ensure
@@ -973,7 +982,7 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
 		}
 	} else {
-		pcpu_copy_value(htab, pptr, value, onallcpus);
+		pcpu_copy_value(htab, pptr, value, onallcpus, map_flags);
 	}
 }
 
@@ -985,7 +994,7 @@ static bool fd_htab_map_needs_adjust(const struct bpf_htab *htab)
 static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 					 void *value, u32 key_size, u32 hash,
 					 bool percpu, bool onallcpus,
-					 struct htab_elem *old_elem)
+					 struct htab_elem *old_elem, u64 map_flags)
 {
 	u32 size = htab->map.value_size;
 	bool prealloc = htab_is_prealloc(htab);
@@ -1043,7 +1052,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = *(void __percpu **)ptr;
 		}
 
-		pcpu_init_value(htab, pptr, value, onallcpus);
+		pcpu_init_value(htab, pptr, value, onallcpus, map_flags);
 
 		if (!prealloc)
 			htab_elem_set_ptr(l_new, key_size, pptr);
@@ -1147,7 +1156,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 
 	l_new = alloc_htab_elem(htab, key, value, key_size, hash, false, false,
-				l_old);
+				l_old, map_flags);
 	if (IS_ERR(l_new)) {
 		/* all pre-allocated elements are in use or memory exhausted */
 		ret = PTR_ERR(l_new);
@@ -1249,6 +1258,15 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	return ret;
 }
 
+static int htab_map_check_update_flags(bool onallcpus, u64 map_flags)
+{
+	if (unlikely(!onallcpus && map_flags > BPF_EXIST))
+		return -EINVAL;
+	if (unlikely(onallcpus && (map_flags & BPF_F_LOCK)))
+		return -EINVAL;
+	return 0;
+}
+
 static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 					  void *value, u64 map_flags,
 					  bool percpu, bool onallcpus)
@@ -1262,9 +1280,9 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	ret = htab_map_check_update_flags(onallcpus, map_flags);
+	if (unlikely(ret))
+		return ret;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
@@ -1289,7 +1307,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		/* Update value in-place */
 		if (percpu) {
 			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
-					value, onallcpus);
+					value, onallcpus, map_flags);
 		} else {
 			void **inner_map_pptr = htab_elem_value(l_old, key_size);
 
@@ -1298,7 +1316,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		}
 	} else {
 		l_new = alloc_htab_elem(htab, key, value, key_size,
-					hash, percpu, onallcpus, NULL);
+					hash, percpu, onallcpus, NULL, map_flags);
 		if (IS_ERR(l_new)) {
 			ret = PTR_ERR(l_new);
 			goto err;
@@ -1324,9 +1342,9 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	ret = htab_map_check_update_flags(onallcpus, map_flags);
+	if (unlikely(ret))
+		return ret;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
@@ -1342,7 +1360,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	 * to remove older elem from htab and this removal
 	 * operation will need a bucket lock.
 	 */
-	if (map_flags != BPF_EXIST) {
+	if (!(map_flags & BPF_EXIST)) {
 		l_new = prealloc_lru_pop(htab, key, hash);
 		if (!l_new)
 			return -ENOMEM;
@@ -1363,10 +1381,10 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 		/* per-cpu hash map can update value in-place */
 		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
-				value, onallcpus);
+				value, onallcpus, map_flags);
 	} else {
 		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
-				value, onallcpus);
+				value, onallcpus, map_flags);
 		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
 		l_new = NULL;
 	}
@@ -1678,9 +1696,9 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
 	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
 	u32 batch, max_count, size, bucket_size, map_id;
+	u64 elem_map_flags, map_flags, allowed_flags;
 	u32 bucket_cnt, total, key_size, value_size;
 	struct htab_elem *node_to_free = NULL;
-	u64 elem_map_flags, map_flags;
 	struct hlist_nulls_head *head;
 	struct hlist_nulls_node *n;
 	unsigned long flags = 0;
@@ -1690,9 +1708,12 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	int ret = 0;
 
 	elem_map_flags = attr->batch.elem_flags;
-	if ((elem_map_flags & ~BPF_F_LOCK) ||
-	    ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
-		return -EINVAL;
+	allowed_flags = BPF_F_LOCK;
+	if (!do_delete && is_percpu)
+		allowed_flags |= BPF_F_CPU;
+	ret = bpf_map_check_op_flags(map, elem_map_flags, allowed_flags);
+	if (ret)
+		return ret;
 
 	map_flags = attr->batch.flags;
 	if (map_flags)
@@ -1715,7 +1736,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	key_size = htab->map.key_size;
 	value_size = htab->map.value_size;
 	size = round_up(value_size, 8);
-	if (is_percpu)
+	if (is_percpu && !(elem_map_flags & BPF_F_CPU))
 		value_size = size * num_possible_cpus();
 	total = 0;
 	/* while experimenting with hash tables with sizes ranging from 10 to
@@ -1798,10 +1819,17 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			void __percpu *pptr;
 
 			pptr = htab_elem_get_ptr(l, map->key_size);
-			for_each_possible_cpu(cpu) {
-				copy_map_value_long(&htab->map, dst_val + off, per_cpu_ptr(pptr, cpu));
-				check_and_init_map_value(&htab->map, dst_val + off);
-				off += size;
+			if (elem_map_flags & BPF_F_CPU) {
+				cpu = elem_map_flags >> 32;
+				copy_map_value(&htab->map, dst_val, per_cpu_ptr(pptr, cpu));
+				check_and_init_map_value(&htab->map, dst_val);
+			} else {
+				for_each_possible_cpu(cpu) {
+					copy_map_value_long(&htab->map, dst_val + off,
+							    per_cpu_ptr(pptr, cpu));
+					check_and_init_map_value(&htab->map, dst_val + off);
+					off += size;
+				}
 			}
 		} else {
 			value = htab_elem_value(l, key_size);
@@ -2357,7 +2385,7 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 	return NULL;
 }
 
-int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
+int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_flags)
 {
 	struct htab_elem *l;
 	void __percpu *pptr;
@@ -2374,16 +2402,22 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
 	l = __htab_map_lookup_elem(map, key);
 	if (!l)
 		goto out;
+	ret = 0;
 	/* We do not mark LRU map element here in order to not mess up
 	 * eviction heuristics when user space does a map walk.
 	 */
 	pptr = htab_elem_get_ptr(l, map->key_size);
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value);
+		goto out;
+	}
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
 		check_and_init_map_value(map, value + off);
 		off += size;
 	}
-	ret = 0;
 out:
 	rcu_read_unlock();
 	return ret;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 238238086b08..7e6cca641026 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -316,7 +316,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	bpf_disable_instrumentation();
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
-		err = bpf_percpu_hash_copy(map, key, value);
+		err = bpf_percpu_hash_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
-- 
2.51.2


