Return-Path: <linux-kselftest+bounces-48409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D8CFE8F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 16:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0489E30BBA01
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D49350D55;
	Wed,  7 Jan 2026 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bQq5kSME"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F134E74F
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798956; cv=none; b=YWECulxqMQBQMcI6MhmVSj8aylGCbovg9QAOPBJF74Qi+1E0Yx/AJt1JD05Cbtgq6Gdzqv12O5RH5gyTZposNzu5AXMGkFmb3bh7GvKs35EyhzKbcJaZ9XWNw5VgF9DyNkr5J0SSkH5MTlx24xYZzXlxnDdJBEA8bMt4y7UH8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798956; c=relaxed/simple;
	bh=BsSATCGJ1Im8oslMZJNgcC/mdApI3vtxqL3oi85rMJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWV3+BMg45ujL7TUozt/Nt2PPI0HezXVHyLd/GH/m7zNMYeQppf3RS4fx76HLA4cy8a3DbR1+k5hvWm88HXOwmOWfYxvW1CkEM/d+wrobaixtnSUjl/iyeb+U1OeO+KsdQXo2pDlJLX6iZ1e6voDe5hA+ZHc50WM4CAH/+UbQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bQq5kSME; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767798953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmJ+zbdcpVlPidZrh/OBlUAUL4GUVOdG3HOXvMSaLBM=;
	b=bQq5kSMEu4tgBM3gtBjUpyoIbPmBYI80cg8j5SBOOeewvYdD+WZ5aA+gARYdJnqkePJuFP
	C1Z6f/+E0T0VXCEpkAfprMx3GJ4TSQ6LxAkjY01oA78PR9/lHqQIRGqCKM8tNOoiL2EzwV
	zkXvYOmpiw9NpRycvoVMdIqJeRhmZpY=
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
Subject: [PATCH bpf-next v3 3/5] bpf: lru: Factor out bpf_lru_move_next_inactive_rotation helper
Date: Wed,  7 Jan 2026 23:14:54 +0800
Message-ID: <20260107151456.72539-4-leon.hwang@linux.dev>
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

It's to update the 'next_inactive_rotation' for extra node case using
the helper.

No functional change intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_lru_list.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index b17b05f41900..563707af8035 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -61,6 +61,15 @@ static void bpf_lru_list_count_dec(struct bpf_lru_list *l,
 		l->counts[type]--;
 }
 
+static void bpf_lru_move_next_inactive_rotation(struct bpf_lru_list *l, struct bpf_lru_node *node)
+{
+	/* If the removing node is the next_inactive_rotation candidate,
+	 * move the next_inactive_rotation pointer also.
+	 */
+	if (&node->list == l->next_inactive_rotation)
+		l->next_inactive_rotation = l->next_inactive_rotation->prev;
+}
+
 static void __bpf_lru_node_move_to_free(struct bpf_lru_list *l,
 					struct bpf_lru_node *node,
 					struct list_head *free_list,
@@ -69,11 +78,7 @@ static void __bpf_lru_node_move_to_free(struct bpf_lru_list *l,
 	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(node->type)))
 		return;
 
-	/* If the removing node is the next_inactive_rotation candidate,
-	 * move the next_inactive_rotation pointer also.
-	 */
-	if (&node->list == l->next_inactive_rotation)
-		l->next_inactive_rotation = l->next_inactive_rotation->prev;
+	bpf_lru_move_next_inactive_rotation(l, node);
 
 	bpf_lru_list_count_dec(l, node->type);
 
@@ -114,11 +119,7 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 	}
 	bpf_lru_node_clear_ref(node);
 
-	/* If the moving node is the next_inactive_rotation candidate,
-	 * move the next_inactive_rotation pointer also.
-	 */
-	if (&node->list == l->next_inactive_rotation)
-		l->next_inactive_rotation = l->next_inactive_rotation->prev;
+	bpf_lru_move_next_inactive_rotation(l, node);
 
 	list_move(&node->list, &l->lists[tgt_type]);
 }
-- 
2.52.0


