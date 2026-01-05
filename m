Return-Path: <linux-kselftest+bounces-48211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76923CF4638
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 16:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456F0316C72F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF38631B83B;
	Mon,  5 Jan 2026 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m7ownR07"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0831B10D
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626355; cv=none; b=kL1QP3c91e2obDOZwOgfFr+NDwUSAre8GGhlIr8p5D9ruXOWcR82s9snFSmXQMx3b/9Km76PbKK17podIpA5mENWmpvuGn6QYoOXEb6QVAs0VhiwifBMDnMQ9hvIo1pE2fVb8vvdAw0f/TNIMNuflgwIytoPy/Mt3GLRhWKAWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626355; c=relaxed/simple;
	bh=NIoKlj4HsNVo49lVc+PMLR4Ylvp1LSZIljGMAzowXKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkiEHKy3vatUpvp8AvKccCqSKwsCmFpm4TTZvLqL7GJT8U1+CAfpG3J2z4SAzUUjgHaODAEFy77nank+0QsURKO14mcCWtaTtT76pdpZerUTvs5F8E8gDwQx3AviFnaIQXWg13d9KaObYQVuoGnbzdRzxtx+Q2AniElzYizir5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m7ownR07; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767626351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0R7druIIXBBqOR3kur07q84s7+FkgECuEa0v6KyiuXA=;
	b=m7ownR07pfMakfapmONcEKFhY0MwdppqDLNXxD/hBWh/25SxQnAEeY3XvcUhID8kJGFlmR
	7LGMOEZzXQK8//TWLIdARMiekW8kRG7adp9rL8n9zyQRJQoPIm9rIGv9Ho1OIBchXol0ms
	vzM9grjXQZoW204j8KA2peeGiIdwJPA=
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
Subject: [PATCH bpf-next v2 3/5] bpf: lru: Factor out bpf_lru_move_next_inactive_rotation helper
Date: Mon,  5 Jan 2026 23:18:11 +0800
Message-ID: <20260105151813.6968-4-leon.hwang@linux.dev>
In-Reply-To: <20260105151813.6968-1-leon.hwang@linux.dev>
References: <20260105151813.6968-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Factor out a bpf_lru_move_next_inactive_rotation() helper to update
next_inactive_rotation when handling the extra-node case.

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


