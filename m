Return-Path: <linux-kselftest+bounces-8542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F208ABA88
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B18F1C20823
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BF84502C;
	Sat, 20 Apr 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqMhhIEk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44E41C92;
	Sat, 20 Apr 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604197; cv=none; b=jsMEhmsUGwmwvG8ruPQ924XRIL7hhuSX68vWH8WCmU29p3877CFWUAFfKS50YFLwNg48Dr3/icb7mgCUxdXhrc/JMlnLdBesIofhb7CrSwYZNOxzZlLo6s6I20EoauyM/56LpAui4BuwuT59183AC34ZFij1Vdb8/Uxqaul/ZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604197; c=relaxed/simple;
	bh=/pPhGL5GHZv2QDiEhSiJbAQNPhlb24xjHtULQ76sBVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTlsAmUGCCofA6CGMcSOIfa8mbNumF5ciTT7QaKhPsGN/LScpNIKFN+aN8PpbSlF1UmDxphFzkkBqq8I/91f+At/o/x0asQPftJVH+XA7eWxxmHSGGFVIVjwha7kXAO3IoNi9m5la6OpmTYNvNm5nhWItb43bUjkLtBirV7G4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqMhhIEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F24C3277B;
	Sat, 20 Apr 2024 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604197;
	bh=/pPhGL5GHZv2QDiEhSiJbAQNPhlb24xjHtULQ76sBVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YqMhhIEkDmDwszsNSbM/npZvGmP6c6Ua6R5bnyovdl2PNqcL+zvlLGbKm9KUj3UH4
	 S9Ym7uUPivBFg8hRkt2URozyeb//Z5wRzBiFstO3VndbsgW7uM8Y/945CNBxcAoN05
	 Qz3lIUO9l3W3EjE9MX9hJ3xE/eXIaTpr387kICGA7hxNY/sWc8euuPIGtDoxQrFvnm
	 S36aH0UAt2Nf9GLq66xSYqbLk4QToz6B141fqQdJG1oEb1dzq+tgzpaz+nzpHlQYWG
	 vOfrIEcHyr9xCn4ixnVMmrYpFVbv4Pt3swF5Q1wdmN8wMu73Rusjsi5fKzOTkP/t2j
	 4elJuA8jqzu6g==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:09 +0200
Subject: [PATCH bpf-next v2 09/16] bpf: allow struct bpf_wq to be embedded
 in arraymaps and hashmaps
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-9-6c986a5a741f@kernel.org>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=8853;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=/pPhGL5GHZv2QDiEhSiJbAQNPhlb24xjHtULQ76sBVs=;
 b=adFZ13hV4a4EsYQLhQufuev+QwJLHWhpdIXyaP9SAVFYy0yMBww6uT6KgPCWfOoBWyh08qfKb
 RdoEJ/1cs/RBgSMNoB8qvqBBlM02E+EMIDoHOsa1Ui/gLS3glIDBMJa
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Currently bpf_wq_cancel_and_free() is just a placeholder as there is
no memory allocation for bpf_wq just yet.

Again, duplication of the bpf_timer approach

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- removed extra fallthrough
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/arraymap.c | 18 ++++++++++-------
 kernel/bpf/hashtab.c  | 55 ++++++++++++++++++++++++++++++++++++++++-----------
 kernel/bpf/helpers.c  |  8 ++++++++
 kernel/bpf/syscall.c  |  9 +++++++++
 5 files changed, 73 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c7dcfd395555..64bf0cf3ee95 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -534,6 +534,7 @@ static inline void zero_map_value(struct bpf_map *map, void *dst)
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 			   bool lock_src);
 void bpf_timer_cancel_and_free(void *timer);
+void bpf_wq_cancel_and_free(void *timer);
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock);
 void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
@@ -2204,6 +2205,7 @@ void bpf_map_free_record(struct bpf_map *map);
 struct btf_record *btf_record_dup(const struct btf_record *rec);
 bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
+void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 8c1e6d7654bb..580d07b15471 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -428,17 +428,21 @@ static void *array_map_vmalloc_addr(struct bpf_array *array)
 	return (void *)round_down((unsigned long)array, PAGE_SIZE);
 }
 
-static void array_map_free_timers(struct bpf_map *map)
+static void array_map_free_timers_wq(struct bpf_map *map)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
-	/* We don't reset or free fields other than timer on uref dropping to zero. */
-	if (!btf_record_has_field(map->record, BPF_TIMER))
-		return;
+	/* We don't reset or free fields other than timer and workqueue
+	 * on uref dropping to zero.
+	 */
+	if (btf_record_has_field(map->record, BPF_TIMER))
+		for (i = 0; i < array->map.max_entries; i++)
+			bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
 
-	for (i = 0; i < array->map.max_entries; i++)
-		bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
+	if (btf_record_has_field(map->record, BPF_WORKQUEUE))
+		for (i = 0; i < array->map.max_entries; i++)
+			bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
@@ -782,7 +786,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_alloc = array_map_alloc,
 	.map_free = array_map_free,
 	.map_get_next_key = array_map_get_next_key,
-	.map_release_uref = array_map_free_timers,
+	.map_release_uref = array_map_free_timers_wq,
 	.map_lookup_elem = array_map_lookup_elem,
 	.map_update_elem = array_map_update_elem,
 	.map_delete_elem = array_map_delete_elem,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 83a9a74260e9..4f8590067c6a 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -240,6 +240,26 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 	}
 }
 
+static void htab_free_prealloced_wq(struct bpf_htab *htab)
+{
+	u32 num_entries = htab->map.max_entries;
+	int i;
+
+	if (!btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
+		return;
+	if (htab_has_extra_elems(htab))
+		num_entries += num_possible_cpus();
+
+	for (i = 0; i < num_entries; i++) {
+		struct htab_elem *elem;
+
+		elem = get_htab_elem(htab, i);
+		bpf_obj_free_workqueue(htab->map.record,
+				       elem->key + round_up(htab->map.key_size, 8));
+		cond_resched();
+	}
+}
+
 static void htab_free_prealloced_fields(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
@@ -1495,7 +1515,7 @@ static void delete_all_elements(struct bpf_htab *htab)
 	migrate_enable();
 }
 
-static void htab_free_malloced_timers(struct bpf_htab *htab)
+static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab, bool is_timer)
 {
 	int i;
 
@@ -1507,24 +1527,35 @@ static void htab_free_malloced_timers(struct bpf_htab *htab)
 
 		hlist_nulls_for_each_entry(l, n, head, hash_node) {
 			/* We only free timer on uref dropping to zero */
-			bpf_obj_free_timer(htab->map.record, l->key + round_up(htab->map.key_size, 8));
+			if (is_timer)
+				bpf_obj_free_timer(htab->map.record,
+						   l->key + round_up(htab->map.key_size, 8));
+			else
+				bpf_obj_free_workqueue(htab->map.record,
+						       l->key + round_up(htab->map.key_size, 8));
 		}
 		cond_resched_rcu();
 	}
 	rcu_read_unlock();
 }
 
-static void htab_map_free_timers(struct bpf_map *map)
+static void htab_map_free_timers_and_wq(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
-	/* We only free timer on uref dropping to zero */
-	if (!btf_record_has_field(htab->map.record, BPF_TIMER))
-		return;
-	if (!htab_is_prealloc(htab))
-		htab_free_malloced_timers(htab);
-	else
-		htab_free_prealloced_timers(htab);
+	/* We only free timer and workqueue on uref dropping to zero */
+	if (btf_record_has_field(htab->map.record, BPF_TIMER)) {
+		if (!htab_is_prealloc(htab))
+			htab_free_malloced_timers_or_wq(htab, true);
+		else
+			htab_free_prealloced_timers(htab);
+	}
+	if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE)) {
+		if (!htab_is_prealloc(htab))
+			htab_free_malloced_timers_or_wq(htab, false);
+		else
+			htab_free_prealloced_wq(htab);
+	}
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
@@ -2260,7 +2291,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_alloc = htab_map_alloc,
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
-	.map_release_uref = htab_map_free_timers,
+	.map_release_uref = htab_map_free_timers_and_wq,
 	.map_lookup_elem = htab_map_lookup_elem,
 	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
 	.map_update_elem = htab_map_update_elem,
@@ -2281,7 +2312,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_alloc = htab_map_alloc,
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
-	.map_release_uref = htab_map_free_timers,
+	.map_release_uref = htab_map_free_timers_and_wq,
 	.map_lookup_elem = htab_lru_map_lookup_elem,
 	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
 	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 78847f444f79..9fd12d480b8b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1468,6 +1468,14 @@ void bpf_timer_cancel_and_free(void *val)
 	kfree_rcu(t, cb.rcu);
 }
 
+/* This function is called by map_delete/update_elem for individual element and
+ * by ops->map_release_uref when the user space reference to a map reaches zero.
+ */
+void bpf_wq_cancel_and_free(void *val)
+{
+	BTF_TYPE_EMIT(struct bpf_wq);
+}
+
 BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
 {
 	unsigned long *kptr = map_value;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0848e4141b00..63e368337483 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -661,6 +661,13 @@ void bpf_obj_free_timer(const struct btf_record *rec, void *obj)
 	bpf_timer_cancel_and_free(obj + rec->timer_off);
 }
 
+void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj)
+{
+	if (WARN_ON_ONCE(!btf_record_has_field(rec, BPF_WORKQUEUE)))
+		return;
+	bpf_wq_cancel_and_free(obj + rec->wq_off);
+}
+
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 {
 	const struct btf_field *fields;
@@ -682,6 +689,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 			bpf_timer_cancel_and_free(field_ptr);
 			break;
 		case BPF_WORKQUEUE:
+			bpf_wq_cancel_and_free(field_ptr);
 			break;
 		case BPF_KPTR_UNREF:
 			WRITE_ONCE(*(u64 *)field_ptr, 0);
@@ -1119,6 +1127,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 				}
 				break;
 			case BPF_TIMER:
+			case BPF_WORKQUEUE:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY) {

-- 
2.44.0


