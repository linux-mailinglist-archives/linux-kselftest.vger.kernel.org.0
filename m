Return-Path: <linux-kselftest+bounces-49368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8865DD3ABFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0518C30EA812
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE783387342;
	Mon, 19 Jan 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oJJEhNwI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEF3815D7
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832637; cv=none; b=LrFofoHxCkN5AZQbrCvp20F+ecC+mPRJZ2tJg9xFgcz7LhzM8QcUsV8Sqexo6hu1EcJ3E4soKya+DKmPDzOy8+NXC2OZlnhNVN69FZJiyHpp6ceVRxGNpYm+V/MGk0JHUaRLLnVByNYsn8zSn6JzBf/07Q74tm9jAApbh0XMd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832637; c=relaxed/simple;
	bh=l+kwMUsQimoxGi8L7uWCc3QAdNgoR9d+OzSkHX2cqgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WILwuZn+I8j2wGDZu0e2JyhuD+tXz7gxiLUIcO1tgRuOUMQxz4c96afXjYRQXmp78GhknOiPZCsh8UMoMmdyfVzdP116Mz8geBbq1HI23sUbAPqlsjN1naLCvxzYJi4wAyPUWocV/7x/p5hoIwrsrxqA891vMhGz9pF1kfFle2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oJJEhNwI; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768832632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ny2Dbz5+1e/+8ujacpK/pSGHIZdtzJne97Rc5EYzZe4=;
	b=oJJEhNwI3HdqtrY/iRjl8AyZVFW2Zqc6yAgTfNdIJ0mbOfw6SnIpV43lT1vt9U3t3IhW9q
	AedoTn5RF84LH81JkpDZauxFxDpoMFjjtp/eVB48BQ+URCLP/L+bWSJfp9+I24wTMn4cuV
	ziUTKGl19jXu/luD8sCrwzn0IhCAAEA=
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/3] bpf: Factor out bpf_lru_node_set_hash() helper
Date: Mon, 19 Jan 2026 22:21:18 +0800
Message-ID: <20260119142120.28170-2-leon.hwang@linux.dev>
In-Reply-To: <20260119142120.28170-1-leon.hwang@linux.dev>
References: <20260119142120.28170-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The hash field is not used directly by the LRU list itself; it is
consumed by the 'del_from_htab' callback when removing entries from
the hash map.

The hash initialization must be performed under the LRU lock to avoid
a race where a popped LRU node is evicted and deleted from the hash
map with an uninitialized hash value, if defer the hash setting to
hashtab.c::prealloc_lru_pop().

Factor out a dedicated bpf_lru_node_set_hash() helper and document
this requirement to make the ordering and locking constraints explicit.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_lru_list.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index e7a2fc60523f..c091f3232cc5 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -341,13 +341,27 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 	raw_spin_unlock(&l->lock);
 }
 
+/*
+ * The hash field is consumed by the 'del_from_htab' callback rather than
+ * the LRU list itself. Initialize it while holding the LRU lock to avoid
+ * a race where a popped LRU node is evicted and removed from the hash map
+ * with an uninitialized hash value, if defer the hash setting to
+ * hashtab.c::prealloc_lru_pop().
+ */
+static void bpf_lru_node_set_hash(struct bpf_lru *lru,
+				  struct bpf_lru_node *node,
+				  u32 hash)
+{
+	*(u32 *)((void *)node + lru->hash_offset) = hash;
+}
+
 static void __local_list_add_pending(struct bpf_lru *lru,
 				     struct bpf_lru_locallist *loc_l,
 				     int cpu,
 				     struct bpf_lru_node *node,
 				     u32 hash)
 {
-	*(u32 *)((void *)node + lru->hash_offset) = hash;
+	bpf_lru_node_set_hash(lru, node, hash);
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
 	bpf_lru_node_clear_ref(node);
@@ -415,7 +429,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 
 	if (!list_empty(free_list)) {
 		node = list_first_entry(free_list, struct bpf_lru_node, list);
-		*(u32 *)((void *)node + lru->hash_offset) = hash;
+		bpf_lru_node_set_hash(lru, node, hash);
 		bpf_lru_node_clear_ref(node);
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
-- 
2.52.0


