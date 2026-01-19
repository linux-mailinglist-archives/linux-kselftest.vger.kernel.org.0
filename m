Return-Path: <linux-kselftest+bounces-49369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B58D3ABEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2676930049CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9C387570;
	Mon, 19 Jan 2026 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uHxDawZl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6837BE75
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832648; cv=none; b=qhdxXNOCpb+FuPAk3fa58aRPT2r+C8u7M5XRkyPkn6J06PruCVrfY5sEN3UdTDhn3fFV4V4MJtrqmWowPSrAA4j2W0yXeXTC+wqoKCnSj6lG8aakHgVYfRGF/WKdvYPfQ6gnavI9E/Zq2raNBfmqcAl0RFD9AKC7ZLZU7IoXHUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832648; c=relaxed/simple;
	bh=oayvu13mdV7aSgVp1rBKytLvqsfxdo+vvFuy6pb+7uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a88JdSb7HV1M6I3RS40pQhavj7NzsT5Z5mGkmt82gOp2EwyBBC8zIG2PT1J4I2wr1GR1WFjQfQxJOfPPjCZ1WvbTrKQWl4P7H55NvHeU4kiNmEuBdZU5lXG89LG3XqnJ7W638jQcIBQ8heZbQ2T3qNC1cSQhiZSSYGWFF59Q+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uHxDawZl; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768832644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Eq1NLSrw3mzgr+D9bwwnsXLMtRZs1wD5aWZcftrom8=;
	b=uHxDawZl5wKLRvTYnFa2iHf4BpkQMRh6QHtbyUksBI6UNsHnxGh16L+tTDM5PWyTbdTJU4
	xIJN9QYJIiaOCBbwJUG/wsaBnovufi5hb+3BSg65PcAjv14yjxGHglWJljUJmEikLtpJFD
	/N6NnMMvvHbKoVfzY8sK0YqtWlvphng=
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
Subject: [PATCH bpf-next 2/3] bpf: Avoid deadlock using trylock when popping LRU free nodes
Date: Mon, 19 Jan 2026 22:21:19 +0800
Message-ID: <20260119142120.28170-3-leon.hwang@linux.dev>
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

Switch the free-node pop paths to raw_spin_trylock*() to avoid blocking
on contended LRU locks.

If the global or per-CPU LRU lock is unavailable, refuse to refill the
local free list and return NULL instead. This allows callers to back
off safely rather than blocking or re-entering the same lock context.

This change avoids lockdep warnings and potential deadlocks caused by
re-entrant LRU lock acquisition from NMI context, as shown below:

[  418.260323] bpf_testmod: oh no, recursing into test_1, recursion_misses 1
[  424.982207] ================================
[  424.982216] WARNING: inconsistent lock state
[  424.982223] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  424.982314]  *** DEADLOCK ***
[...]

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_lru_list.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index c091f3232cc5..03d37f72731a 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -312,14 +312,15 @@ static void bpf_lru_list_push_free(struct bpf_lru_list *l,
 	raw_spin_unlock_irqrestore(&l->lock, flags);
 }
 
-static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
+static bool bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 					   struct bpf_lru_locallist *loc_l)
 {
 	struct bpf_lru_list *l = &lru->common_lru.lru_list;
 	struct bpf_lru_node *node, *tmp_node;
 	unsigned int nfree = 0;
 
-	raw_spin_lock(&l->lock);
+	if (!raw_spin_trylock(&l->lock))
+		return false;
 
 	__local_list_flush(l, loc_l);
 
@@ -339,6 +340,8 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 				      BPF_LRU_LOCAL_LIST_T_FREE);
 
 	raw_spin_unlock(&l->lock);
+
+	return true;
 }
 
 /*
@@ -418,7 +421,8 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 
 	l = per_cpu_ptr(lru->percpu_lru, cpu);
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	if (!raw_spin_trylock_irqsave(&l->lock, flags))
+		return NULL;
 
 	__bpf_lru_list_rotate(lru, l);
 
@@ -451,13 +455,12 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 
 	loc_l = per_cpu_ptr(clru->local_list, cpu);
 
-	raw_spin_lock_irqsave(&loc_l->lock, flags);
+	if (!raw_spin_trylock_irqsave(&loc_l->lock, flags))
+		return NULL;
 
 	node = __local_list_pop_free(loc_l);
-	if (!node) {
-		bpf_lru_list_pop_free_to_local(lru, loc_l);
+	if (!node && bpf_lru_list_pop_free_to_local(lru, loc_l))
 		node = __local_list_pop_free(loc_l);
-	}
 
 	if (node)
 		__local_list_add_pending(lru, loc_l, cpu, node, hash);
-- 
2.52.0


