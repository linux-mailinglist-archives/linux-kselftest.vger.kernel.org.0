Return-Path: <linux-kselftest+bounces-47267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E3CAD38C
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 14:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABD0030039CC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B80313E28;
	Mon,  8 Dec 2025 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="D+RXTaFh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76B2E1722;
	Mon,  8 Dec 2025 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199742; cv=none; b=S5yBpPJfPDDvMbqz4iUJMsB/WSBNVJp0dgzWe5GQ6rXGvmiw2yb1sNc8zTPqb9lQAc10p0XsOWrA2e/fwG8bK3wdwnTzskhN9rKaJPuJHXonT9tkklqjHaxBbA2WSGZa1plCAx2+XWhfcDoz7l1FZvNod3zcu9goVLD3AmahlGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199742; c=relaxed/simple;
	bh=i61VCGgct7ZbnxoPAen6qRvQuOw9UcE0ULJvROFG/2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqt9PX41zjZM6Ag1NDutNtd91HrbAglmGsOxEE6YdNd7XWlgSzTk61b3vEBWfJi76bb3TUhwS3SUsEX+tIi+kDCZe86cEnyYPZmqSqRgZO0gO8zOq/xvaMVE9YTqyytuG2pyFMuf7+K3ZZDwddT1MMffHwFdEFuGlXHHwHdRL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=D+RXTaFh; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765199740; x=1796735740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M1qic90YMioVVvvIfa4uHb6lYGZ/O4MS55qijIHvW2M=;
  b=D+RXTaFhD1oIOK/0ItG9FefTZpTL3up0qJuxM6qEV6BaPy4/JZUwbVLH
   fhgTJb4XIiVsvTuFmJyG+ivzahgx/0Zb/wTVCK2W/hQYebJ17g1O0lF0B
   RPnSqGuoUtDGQ+68S+9h9G2j0N2EV12PBP0wbJ29vTQ+VzWIRQ0YW0WET
   R2Q9mpF7wXk1f0H6ATAwrmRt5XYSaIcssUkx5APdnxiP7n2oV00NpztX5
   xiIR2OUd4NOfyfWEwPDyPrAlVpIGuHTT9zGxq6yTydkPObOiVjzjGqkCf
   6LF9FO0avqJMztwdtp29uBkeldwDI8mGvrQ7q6mC5swgQlIm3KMwuxhX7
   g==;
X-CSE-ConnectionGUID: AEbruf8dSLGzAG/3dCCSgw==
X-CSE-MsgGUID: GRDWGqg6Q/u4XOP0B9/5qg==
X-IronPort-AV: E=Sophos;i="6.20,258,1758585600"; 
   d="scan'208";a="8474291"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 13:15:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:5110]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.243:2525] with esmtp (Farcaster)
 id b3644f35-7ab6-489b-827a-62f171c9b93f; Mon, 8 Dec 2025 13:15:40 +0000 (UTC)
X-Farcaster-Flow-ID: b3644f35-7ab6-489b-827a-62f171c9b93f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 8 Dec 2025 13:15:39 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 8 Dec 2025 13:15:36 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, <kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH bpf-next v2 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
Date: Mon, 8 Dec 2025 22:14:31 +0900
Message-ID: <20251208131449.73036-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251208131449.73036-1-enjuk@amazon.com>
References: <20251208131449.73036-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
errors other than -ENOMEM, such as -EBADF or -EINVAL.

However, __cpu_map_entry_alloc() returns NULL on all failures, and
cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
As a result, user space always receives -ENOMEM regardless of the actual
underlying error.

Examples of unexpected behavior:
  - Nonexistent fd  : -ENOMEM (should be -EBADF)
  - Non-BPF fd      : -ENOMEM (should be -EINVAL)
  - Bad attach type : -ENOMEM (should be -EINVAL)

Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
and have cpu_map_update_elem() propagate this error.

Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 kernel/bpf/cpumap.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..04171fbc39cb 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -430,7 +430,7 @@ static struct bpf_cpu_map_entry *
 __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 		      u32 cpu)
 {
-	int numa, err, i, fd = value->bpf_prog.fd;
+	int numa, err = -ENOMEM, i, fd = value->bpf_prog.fd;
 	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 	struct bpf_cpu_map_entry *rcpu;
 	struct xdp_bulk_queue *bq;
@@ -440,7 +440,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 
 	rcpu = bpf_map_kmalloc_node(map, sizeof(*rcpu), gfp | __GFP_ZERO, numa);
 	if (!rcpu)
-		return NULL;
+		return ERR_PTR(err);
 
 	/* Alloc percpu bulkq */
 	rcpu->bulkq = bpf_map_alloc_percpu(map, sizeof(*rcpu->bulkq),
@@ -468,16 +468,21 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	rcpu->value.qsize  = value->qsize;
 	gro_init(&rcpu->gro);
 
-	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, map, fd))
-		goto free_ptr_ring;
+	if (fd > 0) {
+		err = __cpu_map_load_bpf_program(rcpu, map, fd);
+		if (err)
+			goto free_ptr_ring;
+	}
 
 	/* Setup kthread */
 	init_completion(&rcpu->kthread_running);
 	rcpu->kthread = kthread_create_on_node(cpu_map_kthread_run, rcpu, numa,
 					       "cpumap/%d/map:%d", cpu,
 					       map->id);
-	if (IS_ERR(rcpu->kthread))
+	if (IS_ERR(rcpu->kthread)) {
+		err = PTR_ERR(rcpu->kthread);
 		goto free_prog;
+	}
 
 	/* Make sure kthread runs on a single CPU */
 	kthread_bind(rcpu->kthread, cpu);
@@ -503,7 +508,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	free_percpu(rcpu->bulkq);
 free_rcu:
 	kfree(rcpu);
-	return NULL;
+	return ERR_PTR(err);
 }
 
 static void __cpu_map_entry_free(struct work_struct *work)
@@ -596,8 +601,8 @@ static long cpu_map_update_elem(struct bpf_map *map, void *key, void *value,
 	} else {
 		/* Updating qsize cause re-allocation of bpf_cpu_map_entry */
 		rcpu = __cpu_map_entry_alloc(map, &cpumap_value, key_cpu);
-		if (!rcpu)
-			return -ENOMEM;
+		if (IS_ERR(rcpu))
+			return PTR_ERR(rcpu);
 	}
 	rcu_read_lock();
 	__cpu_map_entry_replace(cmap, key_cpu, rcpu);
-- 
2.51.0


