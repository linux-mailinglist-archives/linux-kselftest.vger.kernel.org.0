Return-Path: <linux-kselftest+bounces-14027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF41993972F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 01:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795A228239E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B36A342;
	Mon, 22 Jul 2024 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="l/fzxvjy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m35-116.mailgun.net (m35-116.mailgun.net [69.72.35.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A361FF9
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.35.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692565; cv=none; b=VFQkgxXa6eePQWrn8L6CsJ0nUygDUnrbloZZyX2l4vpuwWgaNbC5b5L5KRglmp7wZOssJF+0jqRVLCum9VrQrQ2hx1lqZL1KcNkmBdOoMqMviehBbzCxFv8j5fLjYg+15rNLdf0WqHKGiKieP7Pcrr9OXq7A6h6DW6GqyR/Pk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692565; c=relaxed/simple;
	bh=iraBT6+afLGY4IK6rrJiwFNGQKjFZK3Uf6SZvi8caVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pr1QT6CP1qzeu/TJFygzsg01TmKn4ZIwboQZmBzgBFLZSIy+o+4eUOSxTeSfgIkxj6yKizV/01idwZ4rVi/ZwVRSh/h/Y++iGPfgwkFbqtOHRQN1q9E8gu5qNz2EFWkeNuoPRkWHSRiQMfzb6Stb4wB6Nd6/wwXpPwHuv54GLIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=l/fzxvjy; arc=none smtp.client-ip=69.72.35.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1721692561; x=1721699761;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=Pi1c2hEp2R8PWovebVZMYFE85iEPioP8TIooUVBrJtk=;
 b=l/fzxvjyNtDKVRJU3Ia6XxcPTT9MYkMFNuq05eFZMYBhXbdVj7lZQZk9dJD1UE+hlcn7b4j4448Y5E5gss0PY310pceQBovJZ2UdO3bu0CzklhCSthrBvMzZ6up1+xX9J2BwTUNcHjDRAQwmpLUkI4EZyDV/myRLo4N9w6Eg4q8=
X-Mailgun-Sending-Ip: 69.72.35.116
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 59065f94d682 with SMTP id 669ef1911c3b766f41f09f86 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jul 2024 23:56:01 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-c45160e0-2rrj.c.vimeo-core.internal [10.56.27.206])
	by smtp.vimeo.com (Postfix) with ESMTP id 9950264D5F;
	Mon, 22 Jul 2024 23:56:00 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id 68B3EB4117E; Mon, 22 Jul 2024 19:56:00 -0400 (EDT)
From: David Finkel <davidf@vimeo.com>
To: Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Finkel <davidf@vimeo.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Mon, 22 Jul 2024 19:55:53 -0400
Message-Id: <20240722235554.2911971-2-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240722235554.2911971-1-davidf@vimeo.com>
References: <20240722235554.2911971-1-davidf@vimeo.com>
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

Additionally, this takes Longman's suggestion of nesting the
page-charging-path checks for the two watermarks to reduce the number of
common-case comparisons.

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
Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: David Finkel <davidf@vimeo.com>
---
 Documentation/admin-guide/cgroup-v2.rst      |  26 ++--
 include/linux/cgroup.h                       |   8 ++
 include/linux/memcontrol.h                   |   5 +
 include/linux/page_counter.h                 |  11 +-
 kernel/cgroup/cgroup-internal.h              |   2 +
 kernel/cgroup/cgroup.c                       |   7 +
 mm/memcontrol.c                              | 129 +++++++++++++++++--
 mm/page_counter.c                            |  36 +++++-
 tools/testing/selftests/cgroup/cgroup_util.c |  22 ++++
 tools/testing/selftests/cgroup/cgroup_util.h |   2 +
 10 files changed, 225 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8fbb0519d556..8dd68e07d13d 100644
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
+	either the creation of the cgroup or the most recent reset for that FD.
 
-	The max memory usage recorded for the cgroup and its
-	descendants since the creation of the cgroup.
+	A write of the string "reset" to this file resets it to the
+	current memory usage for subsequent reads through the same
+	file descriptor.
+	Attempts to write any other non-empty string will return EINVAL
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
+	the creation of the cgroup or the most recent reset for that FD.
 
-	The max swap usage recorded for the cgroup and its
-	descendants since the creation of the cgroup.
+	A write of the string "reset" to this file resets it to the
+	current memory usage for subsequent reads through the same
+	file descriptor.
+	Attempts to write any other non-empty string will return EINVAL
+	(modulo leading and trailing whitespace).
 
   memory.swap.max
 	A read-write single value file which exists on non-root
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2150ca60394b..7001ed74e339 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/cpumask.h>
 #include <linux/nodemask.h>
+#include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/cgroupstats.h>
 #include <linux/fs.h>
@@ -855,4 +856,11 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 
 struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
 
+struct memcg_peak_mem_ctx {
+	long				local_watermark;
+	struct list_head		peers;
+};
+
+struct memcg_peak_mem_ctx *memcg_extract_peak_mem_ctx(struct kernfs_open_file *of);
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..cbc390234605 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -198,6 +198,11 @@ struct mem_cgroup {
 	struct page_counter kmem;		/* v1 only */
 	struct page_counter tcpmem;		/* v1 only */
 
+	/* lists of memcg peak watching contexts on swap and memory */
+	struct list_head peak_memory_local_watermark_watchers;
+	struct list_head peak_swap_local_watermark_watchers;
+	spinlock_t swap_memory_peak_watchers_lock;
+
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 8cd858d912c4..06bb84218960 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -26,6 +26,7 @@ struct page_counter {
 	atomic_long_t children_low_usage;
 
 	unsigned long watermark;
+	unsigned long local_watermark; /* track min of fd-local resets */
 	unsigned long failcnt;
 
 	/* Keep all the read most fields in a separete cacheline. */
@@ -78,7 +79,15 @@ int page_counter_memparse(const char *buf, const char *max,
 
 static inline void page_counter_reset_watermark(struct page_counter *counter)
 {
-	counter->watermark = page_counter_read(counter);
+	unsigned long cur = page_counter_read(counter);
+
+	counter->watermark = cur;
+	counter->local_watermark = cur;
+}
+
+static inline void page_counter_reset_local_watermark(struct page_counter *counter)
+{
+	counter->local_watermark = page_counter_read(counter);
 }
 
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
index 8f2f1bb18c9c..306698d32828 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -25,6 +25,7 @@
  * Copyright (C) 2020 Alibaba, Inc, Alex Shi
  */
 
+#include <linux/cgroup-defs.h>
 #include <linux/page_counter.h>
 #include <linux/memcontrol.h>
 #include <linux/cgroup.h>
@@ -42,6 +43,7 @@
 #include <linux/rcupdate.h>
 #include <linux/limits.h>
 #include <linux/export.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/slab.h>
@@ -5745,6 +5747,9 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	vmpressure_init(&memcg->vmpressure);
 	INIT_LIST_HEAD(&memcg->event_list);
 	spin_lock_init(&memcg->event_list_lock);
+	INIT_LIST_HEAD(&memcg->peak_memory_local_watermark_watchers);
+	INIT_LIST_HEAD(&memcg->peak_swap_local_watermark_watchers);
+	spin_lock_init(&memcg->swap_memory_peak_watchers_lock);
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
@@ -6907,12 +6912,109 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
-static u64 memory_peak_read(struct cgroup_subsys_state *css,
-			    struct cftype *cft)
+inline int swap_memory_peak_show(
+	struct seq_file *sf, void *v, bool swap_cg)
 {
+	struct cgroup_subsys_state *css = seq_css(sf);
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct page_counter *pc;
+	struct kernfs_open_file *of = sf->private;
+	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
+	s64 fd_peak = ctx->local_watermark;
 
-	return (u64)memcg->memory.watermark * PAGE_SIZE;
+	if (swap_cg)
+		pc = &memcg->swap;
+	else
+		pc = &memcg->memory;
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
+	return swap_memory_peak_show(sf, v, false);
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
+inline void swap_memory_peak_release(struct kernfs_open_file *of)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
+
+	if (ctx->local_watermark == -1) {
+		/* fast path (no writes on this fd) */
+		return;
+	}
+	spin_lock(&memcg->swap_memory_peak_watchers_lock);
+	list_del(&ctx->peers);
+	spin_unlock(&memcg->swap_memory_peak_watchers_lock);
+}
+
+inline ssize_t swap_memory_peak_write(
+	struct kernfs_open_file *of,
+	char *buf, size_t nbytes, loff_t off, bool swap_cg)
+{
+	unsigned long cur;
+	struct memcg_peak_mem_ctx *peer_ctx;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
+	struct page_counter *pc;
+	struct list_head *watchers, *pos;
+
+	buf = strstrip(buf);
+	/* Only allow "reset" to keep the API clear */
+	if (strcmp(buf, "reset"))
+		return -EINVAL;
+
+	if (swap_cg) {
+		pc = &memcg->swap;
+		watchers = &memcg->peak_swap_local_watermark_watchers;
+	} else {
+		pc = &memcg->memory;
+		watchers = &memcg->peak_memory_local_watermark_watchers;
+	}
+
+	spin_lock(&memcg->swap_memory_peak_watchers_lock);
+
+	page_counter_reset_local_watermark(pc);
+	cur = pc->local_watermark;
+
+	list_for_each(pos, watchers) {
+		peer_ctx = list_entry(pos, typeof(*ctx), peers);
+		if (cur > peer_ctx->local_watermark)
+			peer_ctx->local_watermark = cur;
+	}
+
+	if (ctx->local_watermark == -1)
+		/* only append to the list if we're not already there */
+		list_add_tail(&ctx->peers, watchers);
+
+	ctx->local_watermark = cur;
+	spin_unlock(&memcg->swap_memory_peak_watchers_lock);
+
+	return nbytes;
+}
+
+static ssize_t memory_peak_write(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
+{
+	return swap_memory_peak_write(of, buf, nbytes, off, false);
 }
 
 static int memory_min_show(struct seq_file *m, void *v)
@@ -7231,7 +7333,10 @@ static struct cftype memory_files[] = {
 	{
 		.name = "peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.read_u64 = memory_peak_read,
+		.open = swap_memory_peak_open,
+		.release = swap_memory_peak_release,
+		.seq_show = memory_peak_show,
+		.write = memory_peak_write,
 	},
 	{
 		.name = "min",
@@ -8193,12 +8298,15 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
 }
 
-static u64 swap_peak_read(struct cgroup_subsys_state *css,
-			  struct cftype *cft)
+static int swap_peak_show(struct seq_file *sf, void *v)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	return swap_memory_peak_show(sf, v, true);
+}
 
-	return (u64)memcg->swap.watermark * PAGE_SIZE;
+static ssize_t swap_peak_write(struct kernfs_open_file *of, char *buf,
+			       size_t nbytes, loff_t off)
+{
+	return swap_memory_peak_write(of, buf, nbytes, off, true);
 }
 
 static int swap_high_show(struct seq_file *m, void *v)
@@ -8282,7 +8390,10 @@ static struct cftype swap_files[] = {
 	{
 		.name = "swap.peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.read_u64 = swap_peak_read,
+		.open = swap_memory_peak_open,
+		.release = swap_memory_peak_release,
+		.seq_show = swap_peak_show,
+		.write = swap_peak_write,
 	},
 	{
 		.name = "swap.events",
diff --git a/mm/page_counter.c b/mm/page_counter.c
index db20d6452b71..724d31508664 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -79,9 +79,22 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		/*
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
+		 *
+		 * Notably, we have two watermarks to allow for both a globally
+		 * visible peak and one that can be reset at a smaller scope.
+		 *
+		 * Since we reset both watermarks when the global reset occurs,
+		 * we can guarantee that watermark >= local_watermark, so we
+		 * don't need to do both comparisons every time.
+		 *
+		 * On systems with branch predictors, the inner condition should
+		 * be almost free.
 		 */
-		if (new > READ_ONCE(c->watermark))
-			WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->local_watermark)) {
+			WRITE_ONCE(c->local_watermark, new);
+			if (new > READ_ONCE(c->watermark))
+				WRITE_ONCE(c->watermark, new);
+		}
 	}
 }
 
@@ -131,10 +144,23 @@ bool page_counter_try_charge(struct page_counter *counter,
 		propagate_protected_usage(c, new);
 		/*
 		 * Just like with failcnt, we can live with some
-		 * inaccuracy in the watermark.
+		 * inaccuracy in the watermarks.
+		 *
+		 * Notably, we have two watermarks to allow for both a globally
+		 * visible peak and one that can be reset at a smaller scope.
+		 *
+		 * Since we reset both watermarks when the global reset occurs,
+		 * we can guarantee that watermark >= local_watermark, so we
+		 * don't need to do both comparisons every time.
+		 *
+		 * On systems with branch predictors, the inner condition should
+		 * be almost free.
 		 */
-		if (new > READ_ONCE(c->watermark))
-			WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->local_watermark)) {
+			WRITE_ONCE(c->local_watermark, new);
+			if (new > READ_ONCE(c->watermark))
+				WRITE_ONCE(c->watermark, new);
+		}
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
-- 
2.40.1


