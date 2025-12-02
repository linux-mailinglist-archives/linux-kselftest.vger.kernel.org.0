Return-Path: <linux-kselftest+bounces-46885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB3AC9BF53
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53CE8349381
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5222B2FDC5A;
	Tue,  2 Dec 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lQgmhnic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16E2727E6
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689484; cv=none; b=BRkvXam5aNVVwfnr66aQxYf2LB7g9JSOGZhnVDB8b3aipwUF/6GEYBlhfRmY05/icq+vdClOxU98/CzfM1EoUjWWc9LR4aRcdJR4fHKpnu7Ho9iZzK8i1gkeTK7bk+2XwvmXAE9vJbK31I0j/+mr/EcwC2ILWJGslXKCx/kQu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689484; c=relaxed/simple;
	bh=F+UplCImDF/kps8pu9STR2+AOE67Uk7IX90+jmF8uFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHvxIKTNSPWP7ShDBZD4+dE0Ry6WlQbhH1Fr9AluhIu1IUWdLR+eie9JWuROHuBWid6ODztP2LBhZF5EJC0IH6zqQ+MIBKfRI1ravfyhmcMQC2DtbLmT6bodY5AdYhKw9MTHnN+p3T9KfEio7bn8VAFa1OTXXGb+etNi6t7dGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lQgmhnic; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764689480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEr1mCiRT8TYyqQLuCagLUjWOsUAHJwvRmp0JqhDR2c=;
	b=lQgmhnic9aVt/qEbIMxv/+68hq0XXMdDuTZIRsWHCQRWx6CRMOjNXNuN/im2k70mSS6GXj
	N4tgyYkEDBdrUtslhMBYPv5tweKzQGqTEd0hCdsAAphIYDByU4lYZ4WQc0XmDMoWPwJ8JD
	/kaM5A+710uApbzEytUKev+Q5BOJ22s=
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
Subject: [PATCH bpf-next 2/3] bpf: Avoid unintended eviction when updating lru_percpu_hash maps
Date: Tue,  2 Dec 2025 23:30:31 +0800
Message-ID: <20251202153032.10118-3-leon.hwang@linux.dev>
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

Similar to the previous fix for lru_hash maps, the lru_percpu_hash map
implementation also suffers from unnecessary eviction when updating
existing elements.

When updating a key that already exists in a full lru_percpu_hash map,
the current code path calls prealloc_lru_pop() before checking for the
existing key (unless map_flags is BPF_EXIST). This can evict an unrelated
element even though the update is just modifying the per-CPU value of an
existing entry.

Fix this by looking up the key first. If found, update the per-CPU value
in-place using pcpu_copy_value(), refresh the LRU reference, and return
early. Only proceed with node allocation if the key does not exist.

Fixes: 8f8449384ec3 ("bpf: Add BPF_MAP_TYPE_LRU_PERCPU_HASH")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/hashtab.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index fb624aa76573..af54fc3a9ba9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1358,6 +1358,28 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
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
+		/* per-cpu hash map can update value in-place */
+		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
+				value, onallcpus);
+	}
+
+	htab_unlock_bucket(b, flags);
+
+	if (l_old)
+		return 0;
+
 	/* For LRU, we need to alloc before taking bucket's
 	 * spinlock because LRU's elem alloc may need
 	 * to remove older elem from htab and this removal
-- 
2.52.0


