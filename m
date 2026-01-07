Return-Path: <linux-kselftest+bounces-48408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8FCFE86C
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 16:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CA253002942
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64034D4DA;
	Wed,  7 Jan 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z+Mw3owt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140D349B01
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798951; cv=none; b=FSWA+RtrtKIy5ATjsJdXSOZtS9mrlInDAIcl11ziI0VkX8ZZmEIb2R0MsDn+lcW+jAXTf/aU6Zq/lxhz46ke79Idk9pE/dZAeGwhih9H0F6CZd4e+r9J3Ul/Me8eiRbBFvjqv9+O3/FNYthXZTJdEvUvMTJeehp2oBUlpTZBuP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798951; c=relaxed/simple;
	bh=MEYCAJTP+gciIEx+Dxm8aAPbsaociGWG+GPRUZbDF6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqo/TWQuxKQ495UDDw7oIvV1rgkz67RlIoCRaB8tPAhEiFna+t2jkSjBQWFbv0UxnGk4wZtwou1XA84UBNlD5BqS0ThzEodJ7iDq4p1suglGlLUbUo/1kcV5bXKEDHaIGnTx581ESLj32JBRTbdogT+KD6uGELEEYo83HOSyD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z+Mw3owt; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767798947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Hk4lLHbn+xMSZg4HI2VBIcbSjPr/5SQlwXAZJ1OODQ=;
	b=Z+Mw3owt42SxUKLYjnexpJDieK+ZyEgU4us+lurEGaL3dHoHWxIhQ4TP0nhCYxmp2aRgLq
	B/JuQq2ugwSkqhdkXmI5oHzhFWAZsXyh/ZS3vohctRNEzcnH4N29zc+cBsgB0+r5mwJAA7
	YUnZoAY2WfM+Tqmr0A0TjgNNUuPT2As=
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
Subject: [PATCH bpf-next v3 2/5] bpf: lru: Factor out bpf_lru_node_reset_state helper
Date: Wed,  7 Jan 2026 23:14:53 +0800
Message-ID: <20260107151456.72539-3-leon.hwang@linux.dev>
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

Introduce the helper bpf_lru_node_reset_state to set type and clear ref.

No functional change intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_lru_list.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index f4e183a9c28f..b17b05f41900 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -41,6 +41,12 @@ static void bpf_lru_node_clear_ref(struct bpf_lru_node *node)
 	WRITE_ONCE(node->ref, 0);
 }
 
+static void bpf_lru_node_reset_state(struct bpf_lru_node *node, enum bpf_lru_list_type type)
+{
+	node->type = type;
+	bpf_lru_node_clear_ref(node);
+}
+
 static void bpf_lru_list_count_inc(struct bpf_lru_list *l,
 				   enum bpf_lru_list_type type)
 {
@@ -85,8 +91,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 		return;
 
 	bpf_lru_list_count_inc(l, tgt_type);
-	node->type = tgt_type;
-	bpf_lru_node_clear_ref(node);
+	bpf_lru_node_reset_state(node, tgt_type);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -347,8 +352,7 @@ static void __local_list_add_pending(struct bpf_lru *lru,
 				     struct bpf_lru_node *node)
 {
 	node->cpu = cpu;
-	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
-	bpf_lru_node_clear_ref(node);
+	bpf_lru_node_reset_state(node, BPF_LRU_LOCAL_LIST_T_PENDING);
 	list_add(&node->list, local_pending_list(loc_l));
 }
 
@@ -513,8 +517,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 			goto check_lru_list;
 		}
 
-		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
-		bpf_lru_node_clear_ref(node);
+		bpf_lru_node_reset_state(node, BPF_LRU_LOCAL_LIST_T_FREE);
 		list_move(&node->list, local_free_list(loc_l));
 
 		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
@@ -559,8 +562,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 		struct bpf_lru_node *node;
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
-		node->type = BPF_LRU_LIST_T_FREE;
-		bpf_lru_node_clear_ref(node);
+		bpf_lru_node_reset_state(node, BPF_LRU_LIST_T_FREE);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
 	}
@@ -588,8 +590,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 again:
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
-		node->type = BPF_LRU_LIST_T_FREE;
-		bpf_lru_node_clear_ref(node);
+		bpf_lru_node_reset_state(node, BPF_LRU_LIST_T_FREE);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
 		buf += elem_size;
-- 
2.52.0


