Return-Path: <linux-kselftest+bounces-13993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A3D939195
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 17:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A50281532
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0012716DED8;
	Mon, 22 Jul 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="lWrz5ZUR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m35-116.mailgun.net (m35-116.mailgun.net [69.72.35.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB116DEC0
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.35.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661454; cv=none; b=RA0Gi6tDnOvXwJOvfFL/vG1y1E7o2qOIhQLplKHauO6lON1NdgR4WoDymHR8QYIYP56TETefh8R4cNSRkxDb/wqpxrYiOrhoH6ZQ8PtfZ0dWqqZxx7r1/4gKpCOOzNAnSqIB/Hg2KBPqjHOuaSrhe2KrqP1Vu8pGItW+kw6zSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661454; c=relaxed/simple;
	bh=JxmHOQgswI4mg5M9SnaHfl9cCm2tQUH/RO5zUIw6lUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BjO+u9Yb2JJPx3l93qnHuTkXUy0PoPlI3InjG9iiACVQ1NryeRThfWIwAeHWWD1ob8iRFxSQ/xeAowg1C4Os9Kg6LoJF0HLFgigsqq7IKghs4EMWS2Ykweqfr4MAd5UMzxca/z0Klu/blAJfdxIuncZDAxLgAlJ1nAIzFzyhFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=lWrz5ZUR; arc=none smtp.client-ip=69.72.35.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1721661451; x=1721668651;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=cImfnuMGeUDF4Q6qZ+xZU+kXOKo78kuoouYFrpAqlec=;
 b=lWrz5ZURxPlbZJX6cay8ny1TZPuDJsorcTa/S1nDpx1RErUxLYEBOcVGCW1DwxnA+ZBP5qpS1OotvLAtvF6KlOdulJ5hH7mzgZ6JrqTa62wa6ogSreu5UaGR75uj+4GUc5H1QNKrmkhMJoTlmKu/q0SfenT7luKgNJ3gKRwQwpU=
X-Mailgun-Sending-Ip: 69.72.35.116
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 7f195ee39b8b with SMTP id 669e780acb8a873c2eb7ac47 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jul 2024 15:17:30 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-4c35368b-g75q.c.vimeo-core.internal [10.56.27.204])
	by smtp.vimeo.com (Postfix) with ESMTP id B8AEB63DD6;
	Mon, 22 Jul 2024 15:17:30 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id 8F2F7B4090E; Mon, 22 Jul 2024 11:17:30 -0400 (EDT)
From: David Finkel <davidf@vimeo.com>
To: Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Finkel <davidf@vimeo.com>
Subject: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Mon, 22 Jul 2024 11:17:13 -0400
Message-Id: <20240722151713.2724855-2-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240722151713.2724855-1-davidf@vimeo.com>
References: <20240722151713.2724855-1-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other mechanisms for querying the peak memory usage of either a process
or v1 memory cgroup allow for resetting the high watermark. Restore
parity with those mechanisms, but with a less racy API.

For example:
 - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
   the high watermark.
 - writing "5" to the clear_refs pseudo-file in a processes's proc
   directory resets the peak RSS.

This change is an evolution of a previous patch, which mostly copied the
cgroup v1 behavior, however, there were concerns about races/ownership
issues with a global reset, so instead this change makes the reset
filedescriptor-local.

Writing a specific string to the memory.peak and memory.swap.peak
pseudo-files reset the high watermark to the current usage for
subsequent reads through that same fd.

Notably, following Johannes's suggestion, this implementation moves the
O(fds that have written) behavior onto the fd write(2) path. Instead, on
the page-allocation path, we simply add one additional watermark to
conditionally bump per-hierarchy level in the page-counter.

This behavior is particularly useful for work scheduling systems that
need to track memory usage of worker processes/cgroups per-work-item.
Since memory can't be squeezed like CPU can (the OOM-killer has
opinions), these systems need to track the peak memory usage to compute
system/container fullness when binpacking workitems.

Most notably, Vimeo's use-case involves a system that's doing global
binpacking across many Kubernetes pods/containers, and while we can use
PSI for some local decisions about overload, we strive to avoid packing
workloads too tightly in the first place. To facilitate this, we track
the peak memory usage. However, since we run with long-lived workers (to
amortize startup costs) we need a way to track the high watermark while
a work-item is executing. Polling runs the risk of missing short spikes
that last for timescales below the polling interval, and peak memory
tracking at the cgroup level is otherwise perfect for this use-case.

As this data is used to ensure that binpacked work ends up with
sufficient headroom, this use-case mostly avoids the inaccuracies
surrounding reclaimable memory.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: David Finkel <davidf@vimeo.com>
---
 Documentation/admin-guide/cgroup-v2.rst       |  26 +-
 include/linux/cgroup.h                        |   7 +
 include/linux/memcontrol.h                    |   5 +
 include/linux/page_counter.h                  |   6 +
 kernel/cgroup/cgroup-internal.h               |   2 +
 kernel/cgroup/cgroup.c                        |   7 +
 mm/memcontrol.c                               | 165 ++++++++++++-
 mm/page_counter.c                             |   4 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  22 ++
 tools/testing/selftests/cgroup/cgroup_util.h  |   2 +
 .../selftests/cgroup/test_memcontrol.c        | 227 +++++++++++++++++-
 11 files changed, 448 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8fbb0519d556..10a2f919128f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1322,11 +1322,16 @@ PAGE_SIZE multiple when read back.
 	reclaim induced by memory.reclaim.
 
   memory.peak
-	A read-only single value file which exists on non-root
-	cgroups.
+	A read-write single value file which exists on non-root cgroups.
+
+	The max memory usage recorded for the cgroup and its descendants since
+	either the creation of the cgroup or the most recent reset for that fd.
 
-	The max memory usage recorded for the cgroup and its
-	descendants since the creation of the cgroup.
+	A write of the string "fd_local_reset" to this file resets it to the
+	current memory usage for subsequent reads through the same
+	file descriptor.
+	Attempts to write any other string will return EINVAL
+	(modulo leading and trailing whitespace).
 
   memory.oom.group
 	A read-write single value file which exists on non-root
@@ -1652,11 +1657,16 @@ PAGE_SIZE multiple when read back.
 	Healthy workloads are not expected to reach this limit.
 
   memory.swap.peak
-	A read-only single value file which exists on non-root
-	cgroups.
+	A read-write single value file which exists on non-root cgroups.
+
+	The max swap usage recorded for the cgroup and its descendants since
+	the creation of the cgroup or the most recent reset for that fd.
 
-	The max swap usage recorded for the cgroup and its
-	descendants since the creation of the cgroup.
+	A write of the string "fd_local_reset" to this file resets it to the
+	current memory usage for subsequent reads through the same
+	file descriptor.
+	Attempts to write any other string will return EINVAL
+	(modulo leading and trailing whitespace).
 
   memory.swap.max
 	A read-write single value file which exists on non-root
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2150ca60394b..9bda441227ea 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -855,4 +855,11 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 
 struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
 
+struct memcg_peak_mem_ctx {
+	long				local_watermark;
+	struct memcg_peak_mem_ctx	*next, *prev;
+};
+
+struct memcg_peak_mem_ctx *memcg_extract_peak_mem_ctx(struct kernfs_open_file *of);
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..6be7507c6fd3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -198,6 +198,11 @@ struct mem_cgroup {
 	struct page_counter kmem;		/* v1 only */
 	struct page_counter tcpmem;		/* v1 only */
 
+	/* lists of memcg peak watching contexts on swap and memory */
+	struct memcg_peak_mem_ctx *peak_memory_local_watermark_watchers;
+	struct memcg_peak_mem_ctx *peak_swap_local_watermark_watchers;
+	spinlock_t pagecounter_peak_watchers_lock;
+
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 8cd858d912c4..047ceaece258 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -26,6 +26,7 @@ struct page_counter {
 	atomic_long_t children_low_usage;
 
 	unsigned long watermark;
+	unsigned long local_watermark; /* track min of fd-local resets */
 	unsigned long failcnt;
 
 	/* Keep all the read most fields in a separete cacheline. */
@@ -81,4 +82,9 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 	counter->watermark = page_counter_read(counter);
 }
 
+static inline void page_counter_reset_local_watermark(struct page_counter *counter)
+{
+	counter->local_watermark = page_counter_read(counter);
+}
+
 #endif /* _LINUX_PAGE_COUNTER_H */
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 520b90dd97ec..5a97ba08e976 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -81,6 +81,8 @@ struct cgroup_file_ctx {
 	struct {
 		struct cgroup_pidlist	*pidlist;
 	} procs1;
+
+	struct memcg_peak_mem_ctx peak;
 };
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e32b6972c478..38b935ffa6cf 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1964,6 +1964,13 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 	return -EINVAL;
 }
 
+struct memcg_peak_mem_ctx *memcg_extract_peak_mem_ctx(struct kernfs_open_file *of)
+{
+	struct cgroup_file_ctx *ctx = of->priv;
+
+	return &ctx->peak;
+}
+
 static void apply_cgroup_root_flags(unsigned int root_flags)
 {
 	if (current->nsproxy->cgroup_ns == &init_cgroup_ns) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f2f1bb18c9c..eb6614236371 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -25,6 +25,7 @@
  * Copyright (C) 2020 Alibaba, Inc, Alex Shi
  */
 
+#include <linux/cgroup-defs.h>
 #include <linux/page_counter.h>
 #include <linux/memcontrol.h>
 #include <linux/cgroup.h>
@@ -5745,6 +5746,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	vmpressure_init(&memcg->vmpressure);
 	INIT_LIST_HEAD(&memcg->event_list);
 	spin_lock_init(&memcg->event_list_lock);
+	spin_lock_init(&memcg->pagecounter_peak_watchers_lock);
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
@@ -6907,12 +6909,130 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
-static u64 memory_peak_read(struct cgroup_subsys_state *css,
-			    struct cftype *cft)
+static struct page_counter *memcg_memory_extract_page_counter(struct mem_cgroup *memcg)
 {
+	return &memcg->memory;
+}
+
+static struct memcg_peak_mem_ctx **memcg_memory_extract_peak_watchers(struct mem_cgroup *memcg)
+{
+	return &memcg->peak_memory_local_watermark_watchers;
+}
+
+inline int swap_memory_peak_show(
+	struct seq_file *sf, void *v,
+	struct page_counter *(*extract_pc)(struct mem_cgroup *memcg))
+{
+	struct cgroup_subsys_state *css = seq_css(sf);
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct page_counter *pc = extract_pc(memcg);
+
+	struct kernfs_open_file *of = sf->private;
+	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
+	s64 fd_peak = ctx->local_watermark;
+
+	if (fd_peak == -1) {
+		seq_printf(sf, "%llu\n", (u64)pc->watermark * PAGE_SIZE);
+		return 0;
+	}
+
+	s64 pc_peak = pc->local_watermark;
+	s64 wm = fd_peak > pc_peak ? fd_peak : pc_peak;
+
+	seq_printf(sf, "%lld\n", wm * PAGE_SIZE);
+	return 0;
+}
+
+static int memory_peak_show(struct seq_file *sf, void *v)
+{
+	return swap_memory_peak_show(sf, v, memcg_memory_extract_page_counter);
+}
+
+static int swap_memory_peak_open(struct kernfs_open_file *of)
+{
+	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
+
+	ctx->local_watermark = -1;
+	return 0;
+}
+
+inline void swap_memory_peak_release(
+	struct kernfs_open_file *of,
+	struct memcg_peak_mem_ctx **(*extract_watchers)(struct mem_cgroup *memcg))
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
+
+	if (ctx->local_watermark == -1) {
+		/* fast path (no writes on this fd)*/
+		return;
+	}
+	spin_lock(&memcg->pagecounter_peak_watchers_lock);
+	if (ctx->next) {
+		ctx->next->prev = ctx->prev;
+	}
+	if (ctx->prev) {
+		ctx->prev->next = ctx->next;
+	} else {
+		struct memcg_peak_mem_ctx **watchers = extract_watchers(memcg);
+
+		*watchers = ctx->next;
+	}
+	spin_unlock(&memcg->pagecounter_peak_watchers_lock);
+}
 
-	return (u64)memcg->memory.watermark * PAGE_SIZE;
+static void memory_peak_release(struct kernfs_open_file *of)
+{
+	swap_memory_peak_release(of, memcg_memory_extract_peak_watchers);
+}
+
+inline ssize_t swap_memory_peak_write(
+	struct kernfs_open_file *of,
+	char *buf, size_t nbytes, loff_t off,
+	struct page_counter* (*extract_pc)(struct mem_cgroup *memcg),
+	struct memcg_peak_mem_ctx **(*extract_watchers)(struct mem_cgroup *memcg))
+{
+	buf = strstrip(buf);
+	/* Only allow "fd_local_reset" to keep the API clear */
+	if (strcmp(buf, "fd_local_reset"))
+		return -EINVAL;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
+
+	spin_lock(&memcg->pagecounter_peak_watchers_lock);
+
+	struct page_counter *pc = extract_pc(memcg);
+
+	page_counter_reset_local_watermark(pc);
+	const unsigned long cur = pc->local_watermark;
+	struct memcg_peak_mem_ctx **watchers = extract_watchers(memcg);
+	struct memcg_peak_mem_ctx *peer_ctx;
+
+	for (peer_ctx = *watchers; peer_ctx; peer_ctx = peer_ctx->next) {
+		if (cur > peer_ctx->local_watermark)
+			peer_ctx->local_watermark = cur;
+	}
+	if (ctx->local_watermark == -1) {
+		/* only append to the list if we're not already there */
+		if (peer_ctx) {
+			ctx->prev = peer_ctx;
+			peer_ctx->next = ctx;
+		} else {
+			*watchers = ctx;
+		}
+	}
+	ctx->local_watermark = cur;
+	spin_unlock(&memcg->pagecounter_peak_watchers_lock);
+
+	return nbytes;
+}
+
+static ssize_t memory_peak_write(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
+{
+	return swap_memory_peak_write(of, buf, nbytes, off,
+				      memcg_memory_extract_page_counter,
+				      memcg_memory_extract_peak_watchers);
 }
 
 static int memory_min_show(struct seq_file *m, void *v)
@@ -7231,7 +7351,10 @@ static struct cftype memory_files[] = {
 	{
 		.name = "peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.read_u64 = memory_peak_read,
+		.open = swap_memory_peak_open,
+		.release = memory_peak_release,
+		.seq_show = memory_peak_show,
+		.write = memory_peak_write,
 	},
 	{
 		.name = "min",
@@ -8193,14 +8316,35 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
 }
 
-static u64 swap_peak_read(struct cgroup_subsys_state *css,
-			  struct cftype *cft)
+
+static struct page_counter *memcg_swap_extract_page_counter(struct mem_cgroup *memcg)
+{
+	return &memcg->swap;
+}
+
+static struct memcg_peak_mem_ctx **memcg_swap_extract_peak_watchers(struct mem_cgroup *memcg)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	return &memcg->peak_swap_local_watermark_watchers;
+}
+
+static int swap_peak_show(struct seq_file *sf, void *v)
+{
+	return swap_memory_peak_show(sf, v, memcg_swap_extract_page_counter);
+}
 
-	return (u64)memcg->swap.watermark * PAGE_SIZE;
+static ssize_t swap_peak_write(struct kernfs_open_file *of, char *buf,
+			       size_t nbytes, loff_t off)
+{
+	return swap_memory_peak_write(of, buf, nbytes, off,
+				      memcg_swap_extract_page_counter,
+				      memcg_swap_extract_peak_watchers);
+}
+static void swap_peak_release(struct kernfs_open_file *of)
+{
+	swap_memory_peak_release(of, memcg_swap_extract_peak_watchers);
 }
 
+
 static int swap_high_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -8282,7 +8426,10 @@ static struct cftype swap_files[] = {
 	{
 		.name = "swap.peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.read_u64 = swap_peak_read,
+		.open = swap_memory_peak_open,
+		.release = swap_peak_release,
+		.seq_show = swap_peak_show,
+		.write = swap_peak_write,
 	},
 	{
 		.name = "swap.events",
diff --git a/mm/page_counter.c b/mm/page_counter.c
index db20d6452b71..40d5f4990218 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -82,6 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		 */
 		if (new > READ_ONCE(c->watermark))
 			WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->local_watermark))
+			WRITE_ONCE(c->local_watermark, new);
 	}
 }
 
@@ -135,6 +137,8 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 */
 		if (new > READ_ONCE(c->watermark))
 			WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->local_watermark))
+			WRITE_ONCE(c->local_watermark, new);
 	}
 	return true;
 
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 432db923bced..1e2d46636a0c 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -141,6 +141,16 @@ long cg_read_long(const char *cgroup, const char *control)
 	return atol(buf);
 }
 
+long cg_read_long_fd(int fd)
+{
+	char buf[128];
+
+	if (pread(fd, buf, sizeof(buf), 0) <= 0)
+		return -1;
+
+	return atol(buf);
+}
+
 long cg_read_key_long(const char *cgroup, const char *control, const char *key)
 {
 	char buf[PAGE_SIZE];
@@ -183,6 +193,18 @@ int cg_write(const char *cgroup, const char *control, char *buf)
 	return ret == len ? 0 : ret;
 }
 
+/*
+ * Returns fd on success, or -1 on failure.
+ * (fd should be closed with close() as usual)
+ */
+int cg_open(const char *cgroup, const char *control, int flags)
+{
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
+	return open(path, flags);
+}
+
 int cg_write_numeric(const char *cgroup, const char *control, long value)
 {
 	char buf[64];
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index e8d04ac9e3d2..19b131ee7707 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -34,9 +34,11 @@ extern int cg_read_strcmp(const char *cgroup, const char *control,
 extern int cg_read_strstr(const char *cgroup, const char *control,
 			  const char *needle);
 extern long cg_read_long(const char *cgroup, const char *control);
+extern long cg_read_long_fd(int fd);
 long cg_read_key_long(const char *cgroup, const char *control, const char *key);
 extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
+extern int cg_open(const char *cgroup, const char *control, int flags);
 int cg_write_numeric(const char *cgroup, const char *control, long value);
 extern int cg_run(const char *cgroup,
 		  int (*fn)(const char *cgroup, void *arg),
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 41ae8047b889..5641c1fd6dae 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -161,12 +161,12 @@ static int alloc_pagecache_50M_check(const char *cgroup, void *arg)
 /*
  * This test create a memory cgroup, allocates
  * some anonymous memory and some pagecache
- * and check memory.current and some memory.stat values.
+ * and checks memory.current, memory.peak, and some memory.stat values.
  */
-static int test_memcg_current(const char *root)
+static int test_memcg_current_peak(const char *root)
 {
 	int ret = KSFT_FAIL;
-	long current;
+	long current, peak, peak_reset;
 	char *memcg;
 
 	memcg = cg_name(root, "memcg_test");
@@ -180,15 +180,109 @@ static int test_memcg_current(const char *root)
 	if (current != 0)
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak != 0)
+		goto cleanup;
+
 	if (cg_run(memcg, alloc_anon_50M_check, NULL))
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(50))
+		goto cleanup;
+
+	/*
+	 * We'll open a few FDs for the same memory.peak file to exercise the free-path
+	 * We need at least three to be closed in a different order than writes occurred to test
+	 * the linked-list handling.
+	 */
+	int peak_fd = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd == -1)
+		goto cleanup;
+
+	bool fd2_closed = false, fd3_closed = false, fd4_closed = false;
+	int peak_fd2 = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd2 == -1)
+		goto cleanup;
+
+	int peak_fd3 = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd3 == -1)
+		goto cleanup;
+
+	static const char reset_string[] = "fd_local_reset\n";
+
+	peak_reset = write(peak_fd, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	peak_reset = write(peak_fd2, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	peak_reset = write(peak_fd3, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	/* Make sure a completely independent read isn't affected by our  FD-local reset above*/
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(50))
+		goto cleanup;
+
+	fd2_closed = true;
+	if (close(peak_fd2))
+		goto cleanup;
+
+	int peak_fd4 = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd4 == -1)
+		goto cleanup;
+
+	peak_reset = write(peak_fd4, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	peak = cg_read_long_fd(peak_fd);
+	if (peak > MB(30) || peak < 0)
+		goto cleanup;
+
 	if (cg_run(memcg, alloc_pagecache_50M_check, NULL))
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(50))
+		goto cleanup;
+
+	/* Make sure everything is back to normal */
+	peak = cg_read_long_fd(peak_fd);
+	if (peak < MB(50))
+		goto cleanup;
+
+	peak = cg_read_long_fd(peak_fd4);
+	if (peak < MB(50))
+		goto cleanup;
+
+	fd3_closed = true;
+	if (close(peak_fd3))
+		goto cleanup;
+
+	fd4_closed = true;
+	if (close(peak_fd4))
+		goto cleanup;
+
+
 	ret = KSFT_PASS;
 
 cleanup:
+	close(peak_fd);
+	if (!fd2_closed)
+		close(peak_fd2);
+	if (!fd3_closed)
+		close(peak_fd3);
+	if (!fd4_closed)
+		close(peak_fd4);
 	cg_destroy(memcg);
 	free(memcg);
 
@@ -817,13 +911,16 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 
 /*
  * This test checks that memory.swap.max limits the amount of
- * anonymous memory which can be swapped out.
+ * anonymous memory which can be swapped out. Additionally, it verifies that
+ * memory.swap.peak reflects the high watermark and can be reset.
  */
-static int test_memcg_swap_max(const char *root)
+static int test_memcg_swap_max_peak(const char *root)
 {
 	int ret = KSFT_FAIL;
 	char *memcg;
-	long max;
+	long max, peak;
+
+	static const char reset_string[] = "fd_local_reset\n";
 
 	if (!is_swap_enabled())
 		return KSFT_SKIP;
@@ -840,6 +937,45 @@ static int test_memcg_swap_max(const char *root)
 		goto cleanup;
 	}
 
+	int swap_peak_fd = cg_open(memcg, "memory.swap.peak",
+				   O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (swap_peak_fd == -1)
+		goto cleanup;
+
+	int mem_peak_fd = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (mem_peak_fd == -1)
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.swap.peak"))
+		goto cleanup;
+
+	if (cg_read_long_fd(swap_peak_fd))
+		goto cleanup;
+
+	/* switch the swap and mem fds into local-peak tracking mode*/
+	int peak_reset = write(swap_peak_fd, reset_string, sizeof(reset_string));
+
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	if (cg_read_long_fd(swap_peak_fd))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.peak"))
+		goto cleanup;
+
+	if (cg_read_long_fd(mem_peak_fd))
+		goto cleanup;
+
+	peak_reset = write(mem_peak_fd, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	if (cg_read_long_fd(mem_peak_fd))
+		goto cleanup;
+
 	if (cg_read_strcmp(memcg, "memory.max", "max\n"))
 		goto cleanup;
 
@@ -862,6 +998,61 @@ static int test_memcg_swap_max(const char *root)
 	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 1)
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long(memcg, "memory.swap.peak");
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long_fd(mem_peak_fd);
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long_fd(swap_peak_fd);
+	if (peak < MB(29))
+		goto cleanup;
+
+	/*
+	 * open, reset and close the peak swap on another FD to make sure
+	 * multiple extant fds don't corrupt the linked-list
+	 */
+	peak_reset = cg_write(memcg, "memory.swap.peak", (char *)reset_string);
+	if (peak_reset)
+		goto cleanup;
+
+	peak_reset = cg_write(memcg, "memory.peak", (char *)reset_string);
+	if (peak_reset)
+		goto cleanup;
+
+	/* actually reset on the fds */
+	peak_reset = write(swap_peak_fd, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	peak_reset = write(mem_peak_fd, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	peak = cg_read_long_fd(swap_peak_fd);
+	if (peak > MB(10))
+		goto cleanup;
+
+	/*
+	 * The cgroup is now empty, but there may be a page or two associated
+	 * with the open FD accounted to it.
+	 */
+	peak = cg_read_long_fd(mem_peak_fd);
+	if (peak > MB(1))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.peak") < MB(29))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.swap.peak") < MB(29))
+		goto cleanup;
+
 	if (cg_run(memcg, alloc_anon_50M_check_swap, (void *)MB(30)))
 		goto cleanup;
 
@@ -869,9 +1060,29 @@ static int test_memcg_swap_max(const char *root)
 	if (max <= 0)
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long(memcg, "memory.swap.peak");
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long_fd(mem_peak_fd);
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long_fd(swap_peak_fd);
+	if (peak < MB(19))
+		goto cleanup;
+
 	ret = KSFT_PASS;
 
 cleanup:
+	if (close(mem_peak_fd))
+		ret = KSFT_FAIL;
+	if (close(swap_peak_fd))
+		ret = KSFT_FAIL;
 	cg_destroy(memcg);
 	free(memcg);
 
@@ -1295,7 +1506,7 @@ struct memcg_test {
 	const char *name;
 } tests[] = {
 	T(test_memcg_subtree_control),
-	T(test_memcg_current),
+	T(test_memcg_current_peak),
 	T(test_memcg_min),
 	T(test_memcg_low),
 	T(test_memcg_high),
@@ -1303,7 +1514,7 @@ struct memcg_test {
 	T(test_memcg_max),
 	T(test_memcg_reclaim),
 	T(test_memcg_oom_events),
-	T(test_memcg_swap_max),
+	T(test_memcg_swap_max_peak),
 	T(test_memcg_sock),
 	T(test_memcg_oom_group_leaf_events),
 	T(test_memcg_oom_group_parent_events),
-- 
2.40.1


