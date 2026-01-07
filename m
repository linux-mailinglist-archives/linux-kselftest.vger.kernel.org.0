Return-Path: <linux-kselftest+bounces-48407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BC9CFE8D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 16:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88D16303C2A6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF1B347FD2;
	Wed,  7 Jan 2026 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qcgnD88U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D841347FCC
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798947; cv=none; b=Yt91mM5rrorwvfGNkgjUyzxil3FoDEXK7uCL0HENJzcrJOLmY7pJ8D9M6fFLoJ7eJqElV1TWEd8KW2cg3uUCOgsGf6BcG4eBcCqki2WqG6Bo+BlW00z0Kl9loMxnQdVEUkLoNDVEtisp2aQ/I1VO1cx3Rlp51fnhGOXsZAb6DWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798947; c=relaxed/simple;
	bh=23m3rAcLaB2DZM9yw4aok4eoFofADdLbKA0w+2C+arw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha/cVla7oVgIhm3Hd81sVsFR/donmi2wCCY5KU1ebyuJNLwyGYeUAJWlbbvG7pUud/XTNMVaK2KtJCVPEB7PuAyg0NtRVTAmnoind0+CtkmdENas037oXie5SnRvKA7nRrLiq8XbPw8/9czG/SG7LsOl/jrbnJh1D7AE7JuUbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qcgnD88U; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767798942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvH6Ji0gbOHAxjNA/hdsc6seIU4NJDne986jm4e6UhQ=;
	b=qcgnD88UxrGTtlz2Z9iC/mkW6cxvzHq9YKnL8c9JN/Pz3cqvLYLNqVHt5BslQKal5pAxzh
	5K16egf4nPzFb5p2opHkPFQSruhmOWUtvbnoc9hP7iMzRVPSaAB4HNlOjeSOYOKO7bB+lu
	B6EUzRaRuUHAErOghkOJdZl2TqTHjAM=
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
Subject: [PATCH bpf-next v3 1/5] bpf: lru: Tidy hash handling in LRU code
Date: Wed,  7 Jan 2026 23:14:52 +0800
Message-ID: <20260107151456.72539-2-leon.hwang@linux.dev>
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

The hash field is not used by the LRU list itself.

Setting hash while manipulating the LRU list also obscures the intent
of the code and makes it harder to follow.

Tidy this up by moving the hash assignment to prealloc_lru_pop(),
where the element is prepared for insertion into the hash table.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_lru_list.c | 24 +++++++++---------------
 kernel/bpf/bpf_lru_list.h |  5 ++---
 kernel/bpf/hashtab.c      |  5 ++---
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index e7a2fc60523f..f4e183a9c28f 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -344,10 +344,8 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 static void __local_list_add_pending(struct bpf_lru *lru,
 				     struct bpf_lru_locallist *loc_l,
 				     int cpu,
-				     struct bpf_lru_node *node,
-				     u32 hash)
+				     struct bpf_lru_node *node)
 {
-	*(u32 *)((void *)node + lru->hash_offset) = hash;
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
 	bpf_lru_node_clear_ref(node);
@@ -393,8 +391,7 @@ __local_list_pop_pending(struct bpf_lru *lru, struct bpf_lru_locallist *loc_l)
 	return NULL;
 }
 
-static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
-						    u32 hash)
+static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru)
 {
 	struct list_head *free_list;
 	struct bpf_lru_node *node = NULL;
@@ -415,7 +412,6 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 
 	if (!list_empty(free_list)) {
 		node = list_first_entry(free_list, struct bpf_lru_node, list);
-		*(u32 *)((void *)node + lru->hash_offset) = hash;
 		bpf_lru_node_clear_ref(node);
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
@@ -425,8 +421,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 	return node;
 }
 
-static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
-						    u32 hash)
+static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru)
 {
 	struct bpf_lru_locallist *loc_l, *steal_loc_l;
 	struct bpf_common_lru *clru = &lru->common_lru;
@@ -446,7 +441,7 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 	}
 
 	if (node)
-		__local_list_add_pending(lru, loc_l, cpu, node, hash);
+		__local_list_add_pending(lru, loc_l, cpu, node);
 
 	raw_spin_unlock_irqrestore(&loc_l->lock, flags);
 
@@ -481,19 +476,19 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 
 	if (node) {
 		raw_spin_lock_irqsave(&loc_l->lock, flags);
-		__local_list_add_pending(lru, loc_l, cpu, node, hash);
+		__local_list_add_pending(lru, loc_l, cpu, node);
 		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
 	}
 
 	return node;
 }
 
-struct bpf_lru_node *bpf_lru_pop_free(struct bpf_lru *lru, u32 hash)
+struct bpf_lru_node *bpf_lru_pop_free(struct bpf_lru *lru)
 {
 	if (lru->percpu)
-		return bpf_percpu_lru_pop_free(lru, hash);
+		return bpf_percpu_lru_pop_free(lru);
 	else
-		return bpf_common_lru_pop_free(lru, hash);
+		return bpf_common_lru_pop_free(lru);
 }
 
 static void bpf_common_lru_push_free(struct bpf_lru *lru,
@@ -643,7 +638,7 @@ static void bpf_lru_list_init(struct bpf_lru_list *l)
 	raw_spin_lock_init(&l->lock);
 }
 
-int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
+int bpf_lru_init(struct bpf_lru *lru, bool percpu,
 		 del_from_htab_func del_from_htab, void *del_arg)
 {
 	int cpu;
@@ -681,7 +676,6 @@ int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
 	lru->percpu = percpu;
 	lru->del_from_htab = del_from_htab;
 	lru->del_arg = del_arg;
-	lru->hash_offset = hash_offset;
 
 	return 0;
 }
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index fe2661a58ea9..29e8300e0fd1 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -57,7 +57,6 @@ struct bpf_lru {
 	};
 	del_from_htab_func del_from_htab;
 	void *del_arg;
-	unsigned int hash_offset;
 	unsigned int target_free;
 	unsigned int nr_scans;
 	bool percpu;
@@ -69,12 +68,12 @@ static inline void bpf_lru_node_set_ref(struct bpf_lru_node *node)
 		WRITE_ONCE(node->ref, 1);
 }
 
-int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
+int bpf_lru_init(struct bpf_lru *lru, bool percpu,
 		 del_from_htab_func del_from_htab, void *delete_arg);
 void bpf_lru_populate(struct bpf_lru *lru, void *buf, u32 node_offset,
 		      u32 elem_size, u32 nr_elems);
 void bpf_lru_destroy(struct bpf_lru *lru);
-struct bpf_lru_node *bpf_lru_pop_free(struct bpf_lru *lru, u32 hash);
+struct bpf_lru_node *bpf_lru_pop_free(struct bpf_lru *lru);
 void bpf_lru_push_free(struct bpf_lru *lru, struct bpf_lru_node *node);
 
 #endif
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 441ff5bc54ac..c2d12db9036a 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -296,12 +296,13 @@ static void htab_free_elems(struct bpf_htab *htab)
 static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 					  u32 hash)
 {
-	struct bpf_lru_node *node = bpf_lru_pop_free(&htab->lru, hash);
+	struct bpf_lru_node *node = bpf_lru_pop_free(&htab->lru);
 	struct htab_elem *l;
 
 	if (node) {
 		bpf_map_inc_elem_count(&htab->map);
 		l = container_of(node, struct htab_elem, lru_node);
+		l->hash = hash;
 		memcpy(l->key, key, htab->map.key_size);
 		return l;
 	}
@@ -342,8 +343,6 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (htab_is_lru(htab))
 		err = bpf_lru_init(&htab->lru,
 				   htab->map.map_flags & BPF_F_NO_COMMON_LRU,
-				   offsetof(struct htab_elem, hash) -
-				   offsetof(struct htab_elem, lru_node),
 				   htab_lru_map_delete_node,
 				   htab);
 	else
-- 
2.52.0


