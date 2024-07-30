Return-Path: <linux-kselftest+bounces-14501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF5942356
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 01:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E0B24655
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 23:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E7192B61;
	Tue, 30 Jul 2024 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="xG7KyUoZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m35-116.mailgun.net (m35-116.mailgun.net [69.72.35.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A218E04B
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.35.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381203; cv=none; b=RLQLE+R2Qsi2q7T6O2M7tTYywqt8JlBpjDsA7NIJykG0q8SQKICYhF3ldolo9lVQ/e9nKR3ZrTU5OmdVyqtA1Ba0BFD2jL2EPNmDxx3FLRWfOSxUwPhFh2pPQmxmLYGmgG+MB+JE6/Xojgk680u8TZrzDLn067a3ANsehfXgZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381203; c=relaxed/simple;
	bh=cGFT2dYDIMB7eo3e53XNnpd8QHP/jr2rlspfGtFkIqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lusaHDTaP8F9RYiulkPn7U9YSDDCrtJfxslVkkP2x36raIEufTcJu3X+vyzTOzKrvhApTXLbMfxq+Gh+rLbb/4H+D24xW7BQIZBX5AlIkfMktITQ9EmyX8xCf9o0KQR2x0f60tjwhaAAHr8lBHTw2GA6SnqEqGYb+XAoGQl+MJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=xG7KyUoZ; arc=none smtp.client-ip=69.72.35.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1722381199; x=1722388399;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=2uOIVuV3D7K8CVMLwDlYoYHv6kG494vY/22/pULUFSA=;
 b=xG7KyUoZ52I4JLgS/Rq2DgXUg2DihSIkHclUeiU0HwHpHSwxrNOM0ze3wLdROc8pO80LYVqNX/3C/gONhYFepunjgZRm+WeX4LtjZ6P/n9shRVzRD00Nduq1ocy44BWx7wUeaeI0A68RGkC0GoiDpZhtOABna/Tlji5M/laT3/Y=
X-Mailgun-Sending-Ip: 69.72.35.116
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 2ad2ce22b2a4 with SMTP id 66a9738f2c8e1673cb6a86c7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jul 2024 23:13:19 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-7f6ba6de-7c30.c.vimeo-core.internal [10.56.27.212])
	by smtp.vimeo.com (Postfix) with ESMTP id 3491665CC2;
	Tue, 30 Jul 2024 23:13:19 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id F366AB40AC9; Tue, 30 Jul 2024 19:13:18 -0400 (EDT)
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
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	David Finkel <davidf@vimeo.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v7 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Tue, 30 Jul 2024 19:13:03 -0400
Message-Id: <20240730231304.761942-2-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240730231304.761942-1-davidf@vimeo.com>
References: <20240730231304.761942-1-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Writing any non-empty string to the memory.peak and memory.swap.peak
pseudo-files reset the high watermark to the current usage for
subsequent reads through that same FD.

Notably, following Johannes's suggestion, this implementation moves the
O(FDs that have written) behavior onto the FD write(2) path. Instead, on
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: David Finkel <davidf@vimeo.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  22 +++--
 include/linux/cgroup-defs.h             |   5 +
 include/linux/cgroup.h                  |   3 +
 include/linux/memcontrol.h              |   5 +
 include/linux/page_counter.h            |  11 ++-
 kernel/cgroup/cgroup-internal.h         |   2 +
 kernel/cgroup/cgroup.c                  |   7 ++
 mm/memcontrol.c                         | 116 ++++++++++++++++++++++--
 mm/page_counter.c                       |  30 ++++--
 9 files changed, 174 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 86311c2907cd3..f0499884124d2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1333,11 +1333,14 @@ The following nested keys are defined.
 	all the existing limitations and potential future extensions.
 
   memory.peak
-	A read-only single value file which exists on non-root
-	cgroups.
+	A read-write single value file which exists on non-root cgroups.
+
+	The max memory usage recorded for the cgroup and its descendants since
+	either the creation of the cgroup or the most recent reset for that FD.
 
-	The max memory usage recorded for the cgroup and its
-	descendants since the creation of the cgroup.
+	A write of any non-empty string to this file resets it to the
+	current memory usage for subsequent reads through the same
+	file descriptor.
 
   memory.oom.group
 	A read-write single value file which exists on non-root
@@ -1663,11 +1666,14 @@ The following nested keys are defined.
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
+	A write of any non-empty string to this file resets it to the
+	current memory usage for subsequent reads through the same
+	file descriptor.
 
   memory.swap.max
 	A read-write single value file which exists on non-root
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ae04035b6cbe5..7fc2d0195f560 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -775,6 +775,11 @@ struct cgroup_subsys {
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
 
+struct cgroup_of_peak {
+	unsigned long		value;
+	struct list_head	list;
+};
+
 /**
  * cgroup_threadgroup_change_begin - threadgroup exclusion for cgroups
  * @tsk: target task
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c60ba0ab14627..3e0563753cc3e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -11,6 +11,7 @@
 
 #include <linux/sched.h>
 #include <linux/nodemask.h>
+#include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/cgroupstats.h>
 #include <linux/fs.h>
@@ -854,4 +855,6 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 
 struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
 
+struct cgroup_of_peak *of_peak(struct kernfs_open_file *of);
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0e5bf25d324f0..cc74d73d3b065 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -193,6 +193,11 @@ struct mem_cgroup {
 		struct page_counter memsw;	/* v1 only */
 	};
 
+	/* registered local peak watchers */
+	struct list_head memory_peaks;
+	struct list_head swap_peaks;
+	spinlock_t	 peaks_lock;
+
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 904c52f97284f..898f562c0b838 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -26,6 +26,8 @@ struct page_counter {
 	atomic_long_t children_low_usage;
 
 	unsigned long watermark;
+	/* Latest cg2 reset watermark */
+	unsigned long local_watermark;
 	unsigned long failcnt;
 
 	/* Keep all the read most fields in a separete cacheline. */
@@ -78,7 +80,14 @@ int page_counter_memparse(const char *buf, const char *max,
 
 static inline void page_counter_reset_watermark(struct page_counter *counter)
 {
-	counter->watermark = page_counter_read(counter);
+	unsigned long usage = page_counter_read(counter);
+
+	/*
+	 * Update local_watermark first, so it's always <= watermark
+	 * (modulo CPU/compiler re-ordering)
+	 */
+	counter->local_watermark = usage;
+	counter->watermark = usage;
 }
 
 void page_counter_calculate_protection(struct page_counter *root,
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 520b90dd97eca..c964dd7ff967a 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -81,6 +81,8 @@ struct cgroup_file_ctx {
 	struct {
 		struct cgroup_pidlist	*pidlist;
 	} procs1;
+
+	struct cgroup_of_peak peak;
 };
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a4..0a97cb2ef1245 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1972,6 +1972,13 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 	return -EINVAL;
 }
 
+struct cgroup_of_peak *of_peak(struct kernfs_open_file *of)
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
index 9603717886877..2663e2108cdbe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -25,6 +25,7 @@
  * Copyright (C) 2020 Alibaba, Inc, Alex Shi
  */
 
+#include <linux/cgroup-defs.h>
 #include <linux/page_counter.h>
 #include <linux/memcontrol.h>
 #include <linux/cgroup.h>
@@ -41,6 +42,7 @@
 #include <linux/rcupdate.h>
 #include <linux/limits.h>
 #include <linux/export.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/slab.h>
@@ -3558,6 +3560,9 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 
 	INIT_WORK(&memcg->high_work, high_work_func);
 	vmpressure_init(&memcg->vmpressure);
+	INIT_LIST_HEAD(&memcg->memory_peaks);
+	INIT_LIST_HEAD(&memcg->swap_peaks);
+	spin_lock_init(&memcg->peaks_lock);
 	memcg->socket_pressure = jiffies;
 	memcg1_memcg_init(memcg);
 	memcg->kmemcg_id = -1;
@@ -3950,14 +3955,91 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
-static u64 memory_peak_read(struct cgroup_subsys_state *css,
-			    struct cftype *cft)
+#define OFP_PEAK_UNSET (((-1UL)))
+
+static int peak_show(struct seq_file *sf, void *v, struct page_counter *pc)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct cgroup_of_peak *ofp = of_peak(sf->private);
+	u64 fd_peak = READ_ONCE(ofp->value), peak;
+
+	/* User wants global or local peak? */
+	if (fd_peak == OFP_PEAK_UNSET)
+		peak = pc->watermark;
+	else
+		peak = max(fd_peak, READ_ONCE(pc->local_watermark));
+
+	seq_printf(sf, "%llu\n", peak * PAGE_SIZE);
+	return 0;
+}
+
+static int memory_peak_show(struct seq_file *sf, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(sf));
+
+	return peak_show(sf, v, &memcg->memory);
+}
+
+static int peak_open(struct kernfs_open_file *of)
+{
+	struct cgroup_of_peak *ofp = of_peak(of);
+
+	ofp->value = OFP_PEAK_UNSET;
+	return 0;
+}
+
+static void peak_release(struct kernfs_open_file *of)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct cgroup_of_peak *ofp = of_peak(of);
+
+	if (ofp->value == OFP_PEAK_UNSET) {
+		/* fast path (no writes on this fd) */
+		return;
+	}
+	spin_lock(&memcg->peaks_lock);
+	list_del(&ofp->list);
+	spin_unlock(&memcg->peaks_lock);
+}
+
+static ssize_t peak_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
+			  loff_t off, struct page_counter *pc,
+			  struct list_head *watchers)
+{
+	unsigned long usage;
+	struct cgroup_of_peak *peer_ctx;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct cgroup_of_peak *ofp = of_peak(of);
+
+	spin_lock(&memcg->peaks_lock);
+
+	usage = page_counter_read(pc);
+	WRITE_ONCE(pc->local_watermark, usage);
+
+	list_for_each_entry(peer_ctx, watchers, list)
+		if (usage > peer_ctx->value)
+			WRITE_ONCE(peer_ctx->value, usage);
+
+	/* initial write, register watcher */
+	if (ofp->value == -1)
+		list_add(&ofp->list, watchers);
+
+	WRITE_ONCE(ofp->value, usage);
+	spin_unlock(&memcg->peaks_lock);
+
+	return nbytes;
+}
+
+static ssize_t memory_peak_write(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 
-	return (u64)memcg->memory.watermark * PAGE_SIZE;
+	return peak_write(of, buf, nbytes, off, &memcg->memory,
+			  &memcg->memory_peaks);
 }
 
+#undef OFP_PEAK_UNSET
+
 static int memory_min_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -4307,7 +4389,10 @@ static struct cftype memory_files[] = {
 	{
 		.name = "peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.read_u64 = memory_peak_read,
+		.open = peak_open,
+		.release = peak_release,
+		.seq_show = memory_peak_show,
+		.write = memory_peak_write,
 	},
 	{
 		.name = "min",
@@ -5099,12 +5184,20 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
 }
 
-static u64 swap_peak_read(struct cgroup_subsys_state *css,
-			  struct cftype *cft)
+static int swap_peak_show(struct seq_file *sf, void *v)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(sf));
+
+	return peak_show(sf, v, &memcg->swap);
+}
+
+static ssize_t swap_peak_write(struct kernfs_open_file *of, char *buf,
+			       size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 
-	return (u64)memcg->swap.watermark * PAGE_SIZE;
+	return peak_write(of, buf, nbytes, off, &memcg->swap,
+			  &memcg->swap_peaks);
 }
 
 static int swap_high_show(struct seq_file *m, void *v)
@@ -5188,7 +5281,10 @@ static struct cftype swap_files[] = {
 	{
 		.name = "swap.peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.read_u64 = swap_peak_read,
+		.open = peak_open,
+		.release = peak_release,
+		.seq_show = swap_peak_show,
+		.write = swap_peak_write,
 	},
 	{
 		.name = "swap.events",
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 0153f5bb31611..ad9bdde5d5d20 100644
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
 
@@ -129,12 +142,13 @@ bool page_counter_try_charge(struct page_counter *counter,
 			goto failed;
 		}
 		propagate_protected_usage(c, new);
-		/*
-		 * Just like with failcnt, we can live with some
-		 * inaccuracy in the watermark.
-		 */
-		if (new > READ_ONCE(c->watermark))
-			WRITE_ONCE(c->watermark, new);
+
+		/* see comment on page_counter_charge */
+		if (new > READ_ONCE(c->local_watermark)) {
+			WRITE_ONCE(c->local_watermark, new);
+			if (new > READ_ONCE(c->watermark))
+				WRITE_ONCE(c->watermark, new);
+		}
 	}
 	return true;
 
-- 
2.40.1


