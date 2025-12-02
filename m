Return-Path: <linux-kselftest+bounces-46883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D56C9BF49
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 16:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41463A9088
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2173264A92;
	Tue,  2 Dec 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dC3O3Vn9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6921DF74F
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689478; cv=none; b=XqlHnswqlRxFAUf8fDk0lwsucx2Yswpnf8OirXl+M5n4SA7y5sQg5oakIFnlccMJ+z4LuS6IXir1jdde6fbeusoo8RKk/uZt/3NMpoJHffKxTdxV31neL0E015BQqh4C4lS3VAIHchhal0PDdYTZxpfEpR44oXUfuLWby/VsP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689478; c=relaxed/simple;
	bh=FN2gA8fkIYUS0LqgXHQnxjlfDHzrt8HJx+BMYr314go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gScfQbTHDMqzjsCJUc4N+IB1ZPo5pOYDDez+YE6Ly+KNqas9HxfP94ChVsBDdvWzWdI4JyUpZAql1ugK2HDxscqjP+BaWvJ6qexBd/wU0D7esSGbipjT5vUcQWRL8ZFKHpo6LV/6StrOfU031KC7gpZb2QadH+ejhnOyhS8neHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dC3O3Vn9; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764689474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4fcPewQ4q2OL49xVGJhdtOlnQP+HPuy19sXc+YDSmk=;
	b=dC3O3Vn9BkO4H9HHemRWPYpHByHl9wkaxIyAunmFQ9DySvEAOXF9shCbVrYAWvZSuCJquU
	X1oRv7XfTQKUJVra5Wem6ySlZ8Td41jdlghcnkDwk3XJ4lzBPnlu14fghILr1mg+7T8V7F
	4col36Vi8Cid4rAO0dpjNU5MkdnkQXc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
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
Subject: [PATCH bpf-next 1/3] bpf: Avoid unintended eviction when updating lru_hash maps
Date: Tue,  2 Dec 2025 23:30:30 +0800
Message-ID: <20251202153032.10118-2-leon.hwang@linux.dev>
In-Reply-To: <20251202153032.10118-1-leon.hwang@linux.dev>
References: <20251202153032.10118-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When updating an existing element in lru_hash maps, the current
implementation always calls prealloc_lru_pop() to get a new node before
checking if the key already exists. If the map is full, this triggers
LRU eviction and removes an existing element, even though the update
operation only needs to modify the value of an existing key in-place.

This is problematic because:
1. Users may unexpectedly lose entries when doing simple value updates
2. The eviction overhead is unnecessary for existing key updates

Fix this by first checking if the key exists before allocating a new
node. If the key is found, update the value in-place, refresh the LRU
reference, and return immediately without triggering any eviction.

Fixes: 29ba732acbee ("bpf: Add BPF_MAP_TYPE_LRU_HASH")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/hashtab.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c8a9b27f8663..fb624aa76573 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1207,6 +1207,27 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
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
+		bpf_lru_node_set_ref(&l_old->lru_node);
+		copy_map_value(&htab->map, htab_elem_value(l_old, map->key_size), value);
+		check_and_free_fields(htab, l_old);
+	}
+
+	htab_unlock_bucket(b, flags);
+
+	if (l_old)
+		return 0;
+
 	/* For LRU, we need to alloc before taking bucket's
 	 * spinlock because getting free nodes from LRU may need
 	 * to remove older elements from htab and this removal
-- 
2.52.0


