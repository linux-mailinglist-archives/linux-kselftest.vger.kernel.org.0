Return-Path: <linux-kselftest+bounces-48001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A72CCE89C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 04:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BB4F3010AA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 03:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BAF2D6E78;
	Tue, 30 Dec 2025 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LbS50Dq8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA52E3B1C
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767063787; cv=none; b=ueLE/W5vW7LMp0umbaedPQ9f2dQ5+gTJ/B4lfe3lAsvEgoijr1y3F4sdyMbu5V/VlfuCa3e7duvzK1JSX55uelyGOF2mbhTe/REyz94H+iGUfFt+ktqmN9MhmGNk8qo4Bs+0Af0nKJhalZfmNRAmAhnkKKnQqvubawKTXfFMatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767063787; c=relaxed/simple;
	bh=8CE4bHdLV8lLziSoqtXC821LThYHqPHGX3lqn4HCbFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVdTUTGCjq+ROuUq3k2Dl3GWjaEdBpOJ8nZCnGUfKoBV2jY1DdmGCPwKtYFHonJi3trb4IfFdMlEOwVyShbuAU/wTFzormXeKbFcu3kQxcBy+obTGPR78QnYAH/P8gRPR+H+ffdZ/T0anN3El1hT7an2+w10GGT//jvJTCVd15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LbS50Dq8; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767063782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VtcimMsMoBuzNlyVHFqq8VFIMzuGENnnPTayXsqF8fw=;
	b=LbS50Dq8vWlThi8fk/HowFttUVckPNgN5f1MxNXOV40MA0B8iD7SxVXZWf5DBjhpuZJZcJ
	8sx3agB0oMLufU1T9uPK9H5d+lntGnMhAdQ9HBr08l8fbsXLDKk+6V4gyFXgC9fRQ58Cil
	NDAz3700sk+nFQJYurn0k7G/YeVp27g=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC PATCH v2 1/3] mm: memcontrol: Add BPF struct_ops for memory  pressure control
Date: Tue, 30 Dec 2025 11:01:59 +0800
Message-ID: <6735b2da78e61e79a5f464b478ba2486f7749a3d.1767012332.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1767012332.git.zhuhui@kylinos.cn>
References: <cover.1767012332.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add BPF struct_ops support to the memory controller, enabling
custom control over memory pressure through the
memcg_nr_pages_over_high mechanism.

This patch introduces a new memcg_bpf_ops struct_ops type that
allows BPF programs to report additional "pages over high" for
specific memory cgroups. This additional count is integrated
into the existing memory pressure calculation, causing affected
cgroups to be throttled more aggressively.

Key components:

1. memcg_bpf_ops structure:
   - memcg_nr_pages_over_high: Returns custom over-high count
   - handle_cgroup_online: Called when cgroup comes online
   - handle_cgroup_offline: Called when cgroup goes offline

2. Integration points:
   - reclaim_high(): Check BPF hook before reclaim decisions
   - calculate_overage(): Add BPF-reported overage to calculation
   - __mem_cgroup_handle_over_high(): Include BPF overage in
     throttling decisions
   - try_charge_memcg(): Trigger handling if BPF reports high
     overage

3. Lifecycle management:
   - Programs inherit from parent during cgroup online
   - SRCU protection for safe concurrent access
   - Clean detachment during cgroup offline
   - Hierarchy-wide attachment/detachment

Use case: A high-priority cgroup experiencing memory pressure
can trigger BPF logic to report additional overage for
low-priority cgroups, causing them to be throttled and free up
memory.

This builds upon Roman Gushchin's BPF OOM patch series:
https://lore.kernel.org/lkml/20251027231727.472628-1-roman.gushchin@linux.dev/

Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 MAINTAINERS                |   1 +
 include/linux/memcontrol.h |   2 +
 mm/bpf_memcontrol.c        | 241 ++++++++++++++++++++++++++++++++++++-
 mm/bpf_memcontrol.h        |  73 +++++++++++
 mm/memcontrol.c            |  27 +++--
 5 files changed, 335 insertions(+), 9 deletions(-)
 create mode 100644 mm/bpf_memcontrol.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 229b5fae7a91..158f3ba63ee7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6349,6 +6349,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/memcontrol.h
 F:	include/linux/page_counter.h
+F:	mm/bpf_memcontrol.h
 F:	mm/memcontrol.c
 F:	mm/memcontrol-v1.c
 F:	mm/memcontrol-v1.h
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b9e08dddd7ad..ea623aee4ca5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -229,6 +229,8 @@ struct mem_cgroup {
 
 #ifdef CONFIG_BPF_SYSCALL
 	struct bpf_oom_ops *bpf_oom;
+
+	struct memcg_bpf_ops *bpf_ops;
 #endif
 
 	int swappiness;
diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 458ad022b036..9a788b1414ad 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -8,6 +8,11 @@
 #include <linux/memcontrol.h>
 #include <linux/bpf.h>
 
+#include "bpf_memcontrol.h"
+
+/* Protects memcg->bpf_ops pointer for read and write. */
+DEFINE_SRCU(memcg_bpf_srcu);
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -162,15 +167,247 @@ static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
 	.set            = &bpf_memcontrol_kfuncs,
 };
 
+/**
+ * memcontrol_bpf_online - Inherit BPF programs for a new online cgroup.
+ * @memcg: The memory cgroup that is coming online.
+ *
+ * When a new memcg is brought online, it inherits the BPF programs
+ * attached to its parent. This ensures consistent BPF-based memory
+ * control policies throughout the cgroup hierarchy.
+ *
+ * After inheriting, if the BPF program has an online handler, it is
+ * invoked for the new memcg.
+ */
+void memcontrol_bpf_online(struct mem_cgroup *memcg)
+{
+	int idx;
+	struct memcg_bpf_ops *ops;
+	struct mem_cgroup *parent_memcg;
+
+	/* The root cgroup does not inherit from a parent. */
+	if (mem_cgroup_is_root(memcg))
+		return;
+
+	parent_memcg = parent_mem_cgroup(memcg);
+
+	idx = srcu_read_lock(&memcg_bpf_srcu);
+
+	/* Inherit the BPF program from the parent cgroup. */
+	ops = READ_ONCE(parent_memcg->bpf_ops);
+	if (!ops)
+		goto out;
+
+	WRITE_ONCE(memcg->bpf_ops, ops);
+
+	/*
+	 * If the BPF program implements it, call the online handler to
+	 * allow the program to perform setup tasks for the new cgroup.
+	 */
+	if (!ops->handle_cgroup_online)
+		goto out;
+
+	ops->handle_cgroup_online(memcg);
+
+out:
+	srcu_read_unlock(&memcg_bpf_srcu, idx);
+}
+
+/**
+ * memcontrol_bpf_offline - Run BPF cleanup for an offline cgroup.
+ * @memcg: The memory cgroup that is going offline.
+ *
+ * If a BPF program is attached and implements an offline handler,
+ * it is invoked to perform cleanup tasks before the memcg goes
+ * completely offline.
+ */
+void memcontrol_bpf_offline(struct mem_cgroup *memcg)
+{
+	int idx;
+	struct memcg_bpf_ops *ops;
+
+	idx = srcu_read_lock(&memcg_bpf_srcu);
+
+	ops = READ_ONCE(memcg->bpf_ops);
+	if (!ops || !ops->handle_cgroup_offline)
+		goto out;
+
+	ops->handle_cgroup_offline(memcg);
+
+out:
+	srcu_read_unlock(&memcg_bpf_srcu, idx);
+}
+
+static int memcg_ops_btf_struct_access(struct bpf_verifier_log *log,
+					const struct bpf_reg_state *reg,
+					int off, int size)
+{
+	return -EACCES;
+}
+
+static bool memcg_ops_is_valid_access(int off, int size, enum bpf_access_type type,
+	const struct bpf_prog *prog,
+	struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+const struct bpf_verifier_ops bpf_memcg_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.btf_struct_access = memcg_ops_btf_struct_access,
+	.is_valid_access = memcg_ops_is_valid_access,
+};
+
+static unsigned int cfi_memcg_nr_pages_over_high(struct mem_cgroup *memcg)
+{
+	return -EINVAL;
+}
+
+static void cfi_handle_cgroup_online(struct mem_cgroup *memcg)
+{
+}
+
+static void cfi_handle_cgroup_offline(struct mem_cgroup *memcg)
+{
+}
+
+static struct memcg_bpf_ops cfi_bpf_memcg_ops = {
+	.memcg_nr_pages_over_high = cfi_memcg_nr_pages_over_high,
+	.handle_cgroup_online = cfi_handle_cgroup_online,
+	.handle_cgroup_offline = cfi_handle_cgroup_offline,
+};
+
+static int bpf_memcg_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_memcg_ops_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct memcg_bpf_ops, memcg_nr_pages_over_high):
+		break;
+	case offsetof(struct memcg_bpf_ops, handle_cgroup_online):
+		break;
+	case offsetof(struct memcg_bpf_ops, handle_cgroup_offline):
+		break;
+	default:
+		if (prog->sleepable)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bpf_memcg_ops_init_member(const struct btf_type *t,
+				const struct btf_member *member,
+				void *kdata, const void *udata)
+{
+	return 0;
+}
+
+/**
+ * clean_memcg_bpf_ops - Detach BPF programs from a cgroup hierarchy.
+ * @memcg: The root of the cgroup hierarchy to clean.
+ * @ops:   The specific ops struct to detach. If NULL, detach any ops.
+ *
+ * Iterates through all descendant cgroups of @memcg (including itself)
+ * and clears their bpf_ops pointer. This is used when a BPF program
+ * is detached or if attachment fails midway.
+ */
+static void clean_memcg_bpf_ops(struct mem_cgroup *memcg,
+				struct memcg_bpf_ops *ops)
+{
+	struct mem_cgroup *iter = NULL;
+
+	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
+		if (ops) {
+			if (!WARN_ON(READ_ONCE(memcg->bpf_ops) != ops))
+				WRITE_ONCE(memcg->bpf_ops, NULL);
+		} else
+			WRITE_ONCE(iter->bpf_ops, NULL);
+	}
+}
+
+static int bpf_memcg_ops_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *ops_link
+		= container_of(link, struct bpf_struct_ops_link, link);
+	struct memcg_bpf_ops *ops = kdata;
+	struct mem_cgroup *memcg, *iter = NULL;
+	int err = 0;
+
+	memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
+	if (IS_ERR_OR_NULL(memcg))
+		return PTR_ERR(memcg);
+
+	cgroup_lock();
+	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
+		if (READ_ONCE(iter->bpf_ops)) {
+			mem_cgroup_iter_break(memcg, iter);
+			err = -EBUSY;
+			break;
+		}
+		WRITE_ONCE(iter->bpf_ops, ops);
+	}
+	if (err)
+		clean_memcg_bpf_ops(memcg, NULL);
+	cgroup_unlock();
+
+	mem_cgroup_put(memcg);
+	return err;
+}
+
+/* Unregister the struct ops instance */
+static void bpf_memcg_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *ops_link
+		= container_of(link, struct bpf_struct_ops_link, link);
+	struct memcg_bpf_ops *ops = kdata;
+	struct mem_cgroup *memcg;
+
+	memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
+	if (IS_ERR_OR_NULL(memcg))
+		goto out;
+
+	cgroup_lock();
+	clean_memcg_bpf_ops(memcg, ops);
+	cgroup_unlock();
+
+	mem_cgroup_put(memcg);
+
+out:
+	synchronize_srcu(&memcg_bpf_srcu);
+}
+
+static struct bpf_struct_ops bpf_memcg_bpf_ops = {
+	.verifier_ops = &bpf_memcg_verifier_ops,
+	.init = bpf_memcg_ops_init,
+	.check_member = bpf_memcg_ops_check_member,
+	.init_member = bpf_memcg_ops_init_member,
+	.reg = bpf_memcg_ops_reg,
+	.unreg = bpf_memcg_ops_unreg,
+	.name = "memcg_bpf_ops",
+	.owner = THIS_MODULE,
+	.cfi_stubs = &cfi_bpf_memcg_ops,
+};
+
 static int __init bpf_memcontrol_init(void)
 {
-	int err;
+	int err, err2;
 
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
 					&bpf_memcontrol_kfunc_set);
 	if (err)
 		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
 
-	return err;
+	err2 = register_bpf_struct_ops(&bpf_memcg_bpf_ops, memcg_bpf_ops);
+	if (err)
+		pr_warn("error while registering memcontrol bpf ops: %d", err2);
+
+	return err ? err : err2;
 }
 late_initcall(bpf_memcontrol_init);
diff --git a/mm/bpf_memcontrol.h b/mm/bpf_memcontrol.h
new file mode 100644
index 000000000000..72598461a922
--- /dev/null
+++ b/mm/bpf_memcontrol.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* memcontrol_bpf.h - Memory Controller eBPF support
+ *
+ * Author: Hui Zhu <zhuhui@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ */
+
+#ifndef _LINUX_BPF_MEMCONTROL_H
+#define _LINUX_BPF_MEMCONTROL_H
+
+#ifdef CONFIG_BPF_SYSCALL
+
+/**
+ * struct memcg_bpf_ops - BPF hooks for the memory controller.
+ *
+ * These hooks allow a BPF program to extend or modify the behavior of
+ * the memory controller for a cgroup.
+ *
+ * @memcg_nr_pages_over_high: A BPF hook to report additional pages over
+ *                            the high limit. This can be used to
+ *                            implement custom pressure calculation.
+ * @handle_cgroup_online:     Called when a cgroup with this program
+ *                            attached comes online.
+ * @handle_cgroup_offline:    Called when a cgroup with this program
+ *                            attached goes offline.
+ */
+struct memcg_bpf_ops {
+	unsigned int (*memcg_nr_pages_over_high)(struct mem_cgroup *memcg);
+
+	void (*handle_cgroup_online)(struct mem_cgroup *memcg);
+
+	void (*handle_cgroup_offline)(struct mem_cgroup *memcg);
+};
+
+extern struct srcu_struct memcg_bpf_srcu;
+
+/*
+ * Calls the BPF program to get a custom "over high" page count, which
+ * contributes to memory pressure calculation.
+ */
+static inline unsigned int
+bpf_memcg_nr_pages_over_high(struct mem_cgroup *memcg)
+{
+	int idx;
+	struct memcg_bpf_ops *ops;
+	unsigned int nr_pages;
+
+	idx = srcu_read_lock(&memcg_bpf_srcu);
+
+	ops = READ_ONCE(memcg->bpf_ops);
+	if (!ops || !ops->memcg_nr_pages_over_high)
+		goto out;
+
+	nr_pages = ops->memcg_nr_pages_over_high(memcg);
+
+out:
+	srcu_read_unlock(&memcg_bpf_srcu, idx);
+	return nr_pages;
+}
+
+extern void memcontrol_bpf_online(struct mem_cgroup *memcg);
+extern void memcontrol_bpf_offline(struct mem_cgroup *memcg);
+
+#else /* CONFIG_BPF_SYSCALL */
+
+static inline unsigned int
+bpf_memcg_nr_pages_over_high(struct mem_cgroup *memcg) { return 0 }
+static inline void memcontrol_bpf_online(struct mem_cgroup *memcg) { }
+static inline void memcontrol_bpf_offline(struct mem_cgroup *memcg) { }
+
+#endif /* CONFIG_BPF_SYSCALL */
+
+#endif /* _LINUX_BPF_MEMCONTROL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d44c1f293e16..5cbb0f343bc3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -69,6 +69,7 @@
 #include <net/ip.h>
 #include "slab.h"
 #include "memcontrol-v1.h"
+#include "bpf_memcontrol.h"
 
 #include <linux/uaccess.h>
 
@@ -2038,7 +2039,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		unsigned long pflags;
 
 		if (page_counter_read(&memcg->memory) <=
-		    READ_ONCE(memcg->memory.high))
+		    READ_ONCE(memcg->memory.high) &&
+		    !bpf_memcg_nr_pages_over_high(memcg))
 			continue;
 
 		memcg_memory_event(memcg, MEMCG_HIGH);
@@ -2116,11 +2118,12 @@ static void high_work_func(struct work_struct *work)
  #define MEMCG_DELAY_PRECISION_SHIFT 20
  #define MEMCG_DELAY_SCALING_SHIFT 14
 
-static u64 calculate_overage(unsigned long usage, unsigned long high)
+static u64 calculate_overage(unsigned long usage, unsigned long high,
+			     unsigned long bpf_over_high)
 {
 	u64 overage;
 
-	if (usage <= high)
+	if (!bpf_over_high && usage <= high)
 		return 0;
 
 	/*
@@ -2130,6 +2133,7 @@ static u64 calculate_overage(unsigned long usage, unsigned long high)
 	high = max(high, 1UL);
 
 	overage = usage - high;
+	overage = max(overage, bpf_over_high);
 	overage <<= MEMCG_DELAY_PRECISION_SHIFT;
 	return div64_u64(overage, high);
 }
@@ -2140,7 +2144,8 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
 
 	do {
 		overage = calculate_overage(page_counter_read(&memcg->memory),
-					    READ_ONCE(memcg->memory.high));
+					    READ_ONCE(memcg->memory.high),
+					    bpf_memcg_nr_pages_over_high(memcg));
 		max_overage = max(overage, max_overage);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2154,7 +2159,7 @@ static u64 swap_find_max_overage(struct mem_cgroup *memcg)
 
 	do {
 		overage = calculate_overage(page_counter_read(&memcg->swap),
-					    READ_ONCE(memcg->swap.high));
+					    READ_ONCE(memcg->swap.high), 0);
 		if (overage)
 			memcg_memory_event(memcg, MEMCG_SWAP_HIGH);
 		max_overage = max(overage, max_overage);
@@ -2210,12 +2215,14 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	unsigned long penalty_jiffies;
 	unsigned long pflags;
 	unsigned long nr_reclaimed;
-	unsigned int nr_pages = current->memcg_nr_pages_over_high;
+	unsigned int nr_pages;
 	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *memcg;
 	bool in_retry = false;
 
 	memcg = get_mem_cgroup_from_mm(current->mm);
+	nr_pages = max(current->memcg_nr_pages_over_high,
+		       bpf_memcg_nr_pages_over_high(memcg));
 	current->memcg_nr_pages_over_high = 0;
 
 retry_reclaim:
@@ -2309,6 +2316,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool raised_max_event = false;
 	unsigned long pflags;
 	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
+	struct mem_cgroup *orig_memcg;
 
 retry:
 	if (consume_stock(memcg, nr_pages))
@@ -2434,6 +2442,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (batch > nr_pages)
 		refill_stock(memcg, batch - nr_pages);
 
+	orig_memcg = memcg;
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
 	 * reclaim on returning to userland.  We can perform reclaim here
@@ -2483,7 +2492,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * kernel. If this is successful, the return path will see it
 	 * when it rechecks the overage and simply bail out.
 	 */
-	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
+	if ((current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH ||
+	     bpf_memcg_nr_pages_over_high(orig_memcg) > MEMCG_CHARGE_BATCH) &&
 	    !(current->flags & PF_MEMALLOC) &&
 	    gfpflags_allow_blocking(gfp_mask))
 		__mem_cgroup_handle_over_high(gfp_mask);
@@ -3867,6 +3877,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	 */
 	xa_store(&mem_cgroup_ids, memcg->id.id, memcg, GFP_KERNEL);
 
+	memcontrol_bpf_online(memcg);
+
 	return 0;
 offline_kmem:
 	memcg_offline_kmem(memcg);
@@ -3887,6 +3899,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	zswap_memcg_offline_cleanup(memcg);
 
 	bpf_oom_memcg_offline(memcg);
+	memcontrol_bpf_offline(memcg);
 	memcg_offline_kmem(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
-- 
2.43.0


