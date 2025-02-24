Return-Path: <linux-kselftest+bounces-27353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5B5A424F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 16:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C664425EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6F254879;
	Mon, 24 Feb 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgJOrNe6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D9B2505A4
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408457; cv=none; b=LX/G9qCY3KfsaRzp1TV2ZszhNYzbGMHlmPISOG4aP+5d4sLhAIxubjRpJRGx3hJxYakWqzEnUnDpLIeBJAvLqhQUTXZd2m789uIKwgWY8HiQ+detmBVQqgEkV8YsttfCMtbubDNsaIbZz5UXMo5EKeNb9jXdQ0D7CAFrwMCmCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408457; c=relaxed/simple;
	bh=bsZtGhyxbFaKi4/+REsOrdbX8Dfsls7gV0tJI//lXz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HTu2FV6vszUzHHvpjtK+kyKAo5jkrL9McQvwNp+fdMZ5raAVt0Q3VTnlUZgAmin6JYqLNPa5/EB11TWbiadeh+5pg3ppRR+E8rUD9bs9koj4sfM7lhc75nqpYW5vlvK2VBO1WGhWmjYrD+7FR2tqaikFF3VhZJfeuq++kxkAgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MgJOrNe6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso38277795e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740408453; x=1741013253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sXFXBg+7MhZsXsNbEHU7cZAUpeJWSKspLCJpInfPLA=;
        b=MgJOrNe66EKtMDNwunppAFDc1c8tSTlQfiLQsDwQTzpZkBrzKVkNajWp8g+JPbn9fA
         pT4P21UvCsmMdkOKnsxMwvLme768VaD1mbmS8WuLpGHxAfKDgwQlSvyvlIDgbF/Vx36K
         NYsWnLMrfTpZJSquc1RUyH4pQpEcxPOyprRfdez/zii3ymWeTOMLmZh32lpNyJDWod18
         OG4MCAXSIcuiGTCqRTqCSVZZp4iIo36hzjC6/MDpZzt8DFnTZH+p1OqwYIaMiCmDhaTe
         WW8MWXTWA5pEW2rShBrJ650mOxf1Gg0hhqY2teYv8+D7XaE0on3FihpIt5/oGS4R1DtJ
         zxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740408453; x=1741013253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sXFXBg+7MhZsXsNbEHU7cZAUpeJWSKspLCJpInfPLA=;
        b=ZBbYaWl8AxEdtih062Bjp7yZ1gr8rTAFyPFtY5Vrtih0o4gttsg9vBgIueeo3VRlXQ
         n5M6SlzCNzMZbZkJm3MKTxj3aUxn5gpuGqqkzKHUmZOexwoQ1aAxPLpH+cr/OiFU64Yk
         XPXx2Qh82sRBFoy/K0n3MPJqWut5G09tUxUQ0hfNwgPS//Jty7904+XMe0liAn58ky75
         9zX4zrsgddzHnh5SLQtRuJKlSKY5ko+ew6pouuh0hZIbxRslxGANk9XmN2mAu2zrnPHR
         I97SH9h11yYKTP9AUg6WQ8NSmLBUhwu7yPnGG53WDFu/EA1W2LGpNa4kdb2xyfk0V3rR
         MHaw==
X-Forwarded-Encrypted: i=1; AJvYcCXQf6ZOHfqlZm5lrrWEH7atK5eoFRG4L0CiEa2/rMUANqLh+1zGsWzJaW7GctxaGWXqIT2hqPhY0FAH28rS7RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OVeYSUbgI/JaypvQh09Lz8lVEyt7qVUaeaKbFY8OIs26mykZ
	35V21D0DmZ96LF0E4EmBFDuYq2G6OSMw9WE68vIA+HEvVHEUV3KDYF6KqvzpxL0uaE/YV1uKdOP
	DMPMqBSk49g==
X-Google-Smtp-Source: AGHT+IHO7N6qYrH/BUokoWLhGYhgqcjpGiqKJ3qIp+kO3mhMur74Ev86E0j6gIXIm+MPWKLOpxpEcFg/elTSuA==
X-Received: from wmpz20.prod.google.com ([2002:a05:600c:a14:b0:439:7ebc:1bdd])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d21:b0:439:9b39:b31 with SMTP id 5b1f17b1804b1-439b411c2bcmr91798975e9.8.1740408453303;
 Mon, 24 Feb 2025 06:47:33 -0800 (PST)
Date: Mon, 24 Feb 2025 14:47:13 +0000
In-Reply-To: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250224-page-alloc-kunit-v1-3-d337bb440889@google.com>
Subject: [PATCH RFC 3/4] mm/page_alloc_test: Add logic to isolate a node for testing
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Brendan Jackman <jackmanb@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

In order to test the page allocator, we need an "instance" of the page
allocator that is not subject to unpredictable perturbation by the live
system. The closest thing that we have to an "instance" of the allocator
is a NUMA node.

So, introduce a new concept of an "isolated" node. This is an extension
of the existing concept of a "fake" node, with the addition that nothing
else in the system will touch it unless instructed to by the test code.

The node is created during boot but has no memory nor any CPUs attached.
It is not on any other node's fallback lists. Any code that pays general
attention to NODE_DATA in such a way that might cause the page allocator
data structures to be modified asynchronously to the test, is
enlightened to ignore it via the node_isolated() helper.

Then, during initialization of the allocator test suite, hotplug out
some memory and then plug it back in to the isolated node. The node can
then be used for testing.

Because it's easy to miss code that needs enlightenment, which can lead
to confusing test behaviour, also add some defensive checks to try and
interference with the isolated node before the start of the test.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 drivers/base/memory.c    |   5 +-
 include/linux/memory.h   |   4 ++
 include/linux/nodemask.h |  13 +++++
 kernel/kthread.c         |   3 +
 mm/.kunitconfig          |  10 +++-
 mm/Kconfig               |   2 +-
 mm/internal.h            |  11 ++++
 mm/memory_hotplug.c      |  26 ++++++---
 mm/numa_memblks.c        |  22 ++++++++
 mm/page_alloc.c          |  37 +++++++++++-
 mm/page_alloc_test.c     | 142 ++++++++++++++++++++++++++++++++++++++++++++++-
 11 files changed, 260 insertions(+), 15 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 348c5dbbfa68ad30d34b344ace1dd8deac0e1947..cdb893d7f13324862ee0943df080440d19fbd957 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -26,6 +26,8 @@
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
 
+#include <kunit/visibility.h>
+
 #define MEMORY_CLASS_NAME	"memory"
 
 static const char *const online_type_to_str[] = {
@@ -183,7 +185,7 @@ static inline unsigned long memblk_nr_poison(struct memory_block *mem)
 /*
  * Must acquire mem_hotplug_lock in write mode.
  */
-static int memory_block_online(struct memory_block *mem)
+VISIBLE_IF_KUNIT int memory_block_online(struct memory_block *mem)
 {
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
@@ -250,6 +252,7 @@ static int memory_block_online(struct memory_block *mem)
 	mem_hotplug_done();
 	return ret;
 }
+EXPORT_SYMBOL_IF_KUNIT(memory_block_online);
 
 /*
  * Must acquire mem_hotplug_lock in write mode.
diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126ef65d420770e1f8669842c499c8de..99139a6e9c11a407a8d7bfb17b7bbe3d276048ff 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -177,6 +177,10 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 	register_memory_notifier(&fn##_mem_nb);			\
 })
 
+#ifdef CONFIG_KUNIT
+int memory_block_online(struct memory_block *mem);
+#endif
+
 #ifdef CONFIG_NUMA
 void memory_block_add_nid(struct memory_block *mem, int nid,
 			  enum meminit_context context);
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 9fd7a0ce9c1a7336df46f12622867e6786a5c0a9..6ea38963487e1fbb800eab69e5e6413aa17a8047 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -536,6 +536,19 @@ static __always_inline int node_random(const nodemask_t *maskp)
 #define for_each_node(node)	   for_each_node_state(node, N_POSSIBLE)
 #define for_each_online_node(node) for_each_node_state(node, N_ONLINE)
 
+
+#ifdef CONFIG_PAGE_ALLOC_KUNIT_TEST
+/*
+ * An isolated node is a fake node for testing, that boots with no memory and no
+ * attached CPUs, and nothing should touch it except for test code.
+ */
+extern bool node_isolated(int node);
+/* Only one isolated node is supported at present and it cannot be un-isolated. */
+extern void node_set_isolated(int node);
+#else
+static inline bool node_isolated(int node) { return false; }
+#endif /* CONFIG_PAGE_ALLOC_KUNIT_TEST */
+
 /*
  * For nodemask scratch area.
  * NODEMASK_ALLOC(type, name) allocates an object with a specified type and
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5dc5b0d7238e85ad4074076e4036062c7bfcae74..93f65c5935cba8a59c7d3df2e36335130c3e1f71 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -9,6 +9,7 @@
  */
 #include <uapi/linux/sched/types.h>
 #include <linux/mm.h>
+#include <linux/mmdebug.h>
 #include <linux/mmu_context.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
@@ -511,6 +512,8 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	struct kthread_create_info *create = kmalloc(sizeof(*create),
 						     GFP_KERNEL);
 
+	VM_WARN_ON(node != NUMA_NO_NODE && node_isolated(node));
+
 	if (!create)
 		return ERR_PTR(-ENOMEM);
 	create->threadfn = threadfn;
diff --git a/mm/.kunitconfig b/mm/.kunitconfig
index fcc28557fa1c1412b21f9dbddbf6a63adca6f2b4..4ff4e1654c3e9b364072d33bfffb3a2336825859 100644
--- a/mm/.kunitconfig
+++ b/mm/.kunitconfig
@@ -1,2 +1,10 @@
 CONFIG_KUNIT=y
-CONFIG_PAGE_ALLOC_KUNIT_TEST=y
\ No newline at end of file
+CONFIG_PAGE_ALLOC_KUNIT_TEST=y
+
+# Required for NUMA
+CONFIG_SMP=y
+# Used by tests to carve out fake node for isolating page_alloc data.
+CONFIG_NUMA=y
+CONFIG_NUMA_EMU=y
+CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTREMOVE=y
\ No newline at end of file
diff --git a/mm/Kconfig b/mm/Kconfig
index 1fac51c536c66243a1321195a78eb40668386158..64c3794120002a839f56e3feb284c6d5c2635f40 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1360,7 +1360,7 @@ config PT_RECLAIM
 
 config PAGE_ALLOC_KUNIT_TEST
 	tristate "KUnit test for page allocator" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && NUMA && MEMORY_HOTREMOVE
 	default KUNIT_ALL_TESTS
 	help
 	  Builds unit tests for page allocator.
diff --git a/mm/internal.h b/mm/internal.h
index 109ef30fee11f8b399f6bac42eab078cd51e01a5..9dbe5853b90b53ff261ba1b2fca12eabfda1a9de 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1545,5 +1545,16 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 }
 #endif /* CONFIG_PT_RECLAIM */
 
+#ifdef CONFIG_PAGE_ALLOC_KUNIT_TEST
+/*
+ * Note that node_isolated() is separate, that's a "public API". But only
+ * test code needs to look up which node is isolated.
+ */
+extern int isolated_node;
+#endif
+
+#ifdef CONFIG_KUNIT
+void drain_pages(unsigned int cpu);
+#endif
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e3655f07dd6e33efb3e811cab07f240649487441..968c23b6f347cf6a0c30d00cb556166b8df9c9c3 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1198,10 +1198,12 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	arg.nr_pages = nr_pages;
 	node_states_check_changes_online(nr_pages, zone, &arg);
 
-	ret = memory_notify(MEM_GOING_ONLINE, &arg);
-	ret = notifier_to_errno(ret);
-	if (ret)
-		goto failed_addition;
+	if (!node_isolated(nid)) {
+		ret = memory_notify(MEM_GOING_ONLINE, &arg);
+		ret = notifier_to_errno(ret);
+		if (ret)
+			goto failed_addition;
+	}
 
 	/*
 	 * Fixup the number of isolated pageblocks before marking the sections
@@ -1242,19 +1244,27 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
-	kswapd_run(nid);
-	kcompactd_run(nid);
+	/*
+	 * Don't run daemons on the special test node, if that needs to be
+	 * tested the test should run it.
+	 */
+	if (!node_isolated(nid)) {
+		kswapd_run(nid);
+		kcompactd_run(nid);
+	}
 
 	writeback_set_ratelimit();
 
-	memory_notify(MEM_ONLINE, &arg);
+	if (!node_isolated(nid))
+		memory_notify(MEM_ONLINE, &arg);
 	return 0;
 
 failed_addition:
 	pr_debug("online_pages [mem %#010llx-%#010llx] failed\n",
 		 (unsigned long long) pfn << PAGE_SHIFT,
 		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
-	memory_notify(MEM_CANCEL_ONLINE, &arg);
+	if (!node_isolated(nid))
+		memory_notify(MEM_CANCEL_ONLINE, &arg);
 	remove_pfn_range_from_zone(zone, pfn, nr_pages);
 	return ret;
 }
diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index ff4054f4334dae42ee3b3668da18bba01dc3cd8b..190c879af2c779df1be448c45c43b0570bb6c308 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -7,6 +7,8 @@
 #include <linux/numa.h>
 #include <linux/numa_memblks.h>
 
+#include "internal.h"
+
 int numa_distance_cnt;
 static u8 *numa_distance;
 
@@ -371,6 +373,24 @@ static void __init numa_clear_kernel_node_hotplug(void)
 	}
 }
 
+#ifdef CONFIG_PAGE_ALLOC_KUNIT_TEST
+static inline void make_isolated_node(void)
+{
+	int node;
+
+	node = num_possible_nodes();
+	if (!numa_valid_node(node)) {
+		pr_err("All node IDs used, can't fake another.\n");
+	} else {
+		node_set(num_possible_nodes(), node_possible_map);
+		node_set_isolated(node);
+	}
+}
+#else
+static inline void make_isolated_node(void) { }
+#endif
+
+
 static int __init numa_register_meminfo(struct numa_meminfo *mi)
 {
 	int i;
@@ -381,6 +401,8 @@ static int __init numa_register_meminfo(struct numa_meminfo *mi)
 	if (WARN_ON(nodes_empty(node_possible_map)))
 		return -EINVAL;
 
+	make_isolated_node();
+
 	for (i = 0; i < mi->nr_blks; i++) {
 		struct numa_memblk *mb = &mi->blk[i];
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 579789600a3c7bfb7b0d847d51af702a9d4b139a..9472da738119589150db26126dfcf808e2dc9371 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -56,6 +56,7 @@
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
 #include <asm/div64.h>
+#include <kunit/visibility.h>
 #include "internal.h"
 #include "shuffle.h"
 #include "page_reporting.h"
@@ -291,6 +292,26 @@ static bool __free_unaccepted(struct page *page);
 
 int page_group_by_mobility_disabled __read_mostly;
 
+/*
+ * Test harness for KUnit - pick a node that we will never allocate from, except
+ * for in the page allocator tests.
+ */
+#ifdef CONFIG_PAGE_ALLOC_KUNIT_TEST
+int isolated_node = NUMA_NO_NODE;
+EXPORT_SYMBOL(isolated_node);
+
+void node_set_isolated(int node)
+{
+	WARN_ON(isolated_node != NUMA_NO_NODE);
+	isolated_node = node;
+}
+
+bool node_isolated(int node)
+{
+	return node == isolated_node;
+}
+#endif /* CONFIG_POAGE_ALLOC_KUNIT_TEST */
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /*
  * During boot we initialize deferred pages on-demand, as needed, but once
@@ -2410,7 +2431,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 /*
  * Drain pcplists of all zones on the indicated processor.
  */
-static void drain_pages(unsigned int cpu)
+VISIBLE_IF_KUNIT void drain_pages(unsigned int cpu)
 {
 	struct zone *zone;
 
@@ -2418,6 +2439,7 @@ static void drain_pages(unsigned int cpu)
 		drain_pages_zone(cpu, zone);
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(drain_pages);
 
 /*
  * Spill all of this CPU's per-cpu pages back into the buddy allocator.
@@ -5087,6 +5109,8 @@ int find_next_best_node(int node, nodemask_t *used_node_mask)
 	}
 
 	for_each_node_state(n, N_MEMORY) {
+		if (node_isolated(n))
+			continue;
 
 		/* Don't want a node to appear more than once */
 		if (node_isset(n, *used_node_mask))
@@ -5134,8 +5158,17 @@ static void build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
 
 	for (i = 0; i < nr_nodes; i++) {
 		int nr_zones;
+		int other_nid = node_order[i];
+		pg_data_t *node = NODE_DATA(other_nid);
 
-		pg_data_t *node = NODE_DATA(node_order[i]);
+		/*
+		 * Never fall back to the isolated node. The isolated node has
+		 * to be able to fall back to other nodes because that fallback
+		 * is relied on for allocating data structures that describe the
+		 * node.
+		 */
+		if (node_isolated(other_nid) && other_nid != pgdat->node_id)
+			continue;
 
 		nr_zones = build_zonerefs_node(node, zonerefs);
 		zonerefs += nr_zones;
diff --git a/mm/page_alloc_test.c b/mm/page_alloc_test.c
index 377dfdd50a3c6928e15210cc87d5399c1db80da7..c6bcfcaf61b57ca35ad1b5fc48fd07d0402843bc 100644
--- a/mm/page_alloc_test.c
+++ b/mm/page_alloc_test.c
@@ -3,19 +3,157 @@
 #include <linux/list.h>
 #include <linux/gfp.h>
 #include <linux/memory.h>
+#include <linux/memory_hotplug.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
 #include <linux/smp.h>
 
 #include <kunit/test.h>
 
+#include "internal.h"
+
+#define EXPECT_PCPLIST_EMPTY(test, zone, cpu, pindex) ({			\
+	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);	\
+	struct page *page;							\
+										\
+	lockdep_assert_held(&pcp->lock);					\
+	page = list_first_entry_or_null(					\
+		&pcp->lists[pindex], struct page, pcp_list);			\
+										\
+	if (page) {								\
+		KUNIT_FAIL(test, "PCPlist %d on CPU %d wasn't empty", i, cpu);	\
+		dump_page(page, "unexpectedly on pcplist");			\
+	}									\
+})
+
+static void action_drain_pages_all(void *unused)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		drain_pages(cpu);
+}
+
+/* Runs before each test. */
+static int test_init(struct kunit *test)
+{
+	struct zone *zone_normal;
+	int cpu;
+
+	if (isolated_node == NUMA_NO_NODE)
+		kunit_skip(test, "No fake NUMA node ID allocated");
+
+	zone_normal = &NODE_DATA(isolated_node)->node_zones[ZONE_NORMAL];
+
+	/*
+	 * Nothing except these tests should be allocating from the fake node so
+	 * the pcplists should be empty. Obviously this is racy but at least it
+	 * can probabilistically detect issues that would otherwise make for
+	 * really confusing test results.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct per_cpu_pages *pcp = per_cpu_ptr(zone_normal->per_cpu_pageset, cpu);
+		unsigned long flags;
+		int i;
+
+		spin_lock_irqsave(&pcp->lock, flags);
+		for (i = 0; i < ARRAY_SIZE(pcp->lists); i++)
+			EXPECT_PCPLIST_EMPTY(test, zone_normal, cpu, i);
+		spin_unlock_irqrestore(&pcp->lock, flags);
+	}
+
+	/* Also ensure we don't leave a mess for the next test. */
+	kunit_add_action(test, action_drain_pages_all, NULL);
+
+	return 0;
+}
+
+static int memory_block_online_cb(struct memory_block *mem, void *unused)
+{
+	return memory_block_online(mem);
+}
+
+struct region {
+	int node;
+	unsigned long start;
+	unsigned long size;
+};
+
+/*
+ * Unplug some memory from a "real" node and plug it into the isolated node, for
+ * use during the tests.
+ */
+static int populate_isolated_node(struct kunit_suite *suite)
+{
+	struct zone *zone_movable = &NODE_DATA(0)->node_zones[ZONE_MOVABLE];
+	phys_addr_t zone_start = zone_movable->zone_start_pfn << PAGE_SHIFT;
+	phys_addr_t zone_size = zone_movable->spanned_pages << PAGE_SHIFT;
+	unsigned long bs = memory_block_size_bytes();
+	u64 start = round_up(zone_start, bs);
+	/* Plug a memory block if we can find it. */
+	unsigned long size = round_down(min(zone_size, bs), bs);
+	int err;
+
+	if (!size) {
+		pr_err("Couldn't find ZONE_MOVABLE block to offline\n");
+		pr_err("Try setting/expanding movablecore=\n");
+		return -1;
+	}
+
+	err = offline_and_remove_memory(start, size);
+	if (err) {
+		pr_notice("Couldn't offline PFNs 0x%llx - 0x%llx\n",
+			start >> PAGE_SHIFT, (start + size) >> PAGE_SHIFT);
+		return err;
+	}
+	err = add_memory(isolated_node, start, size, MMOP_ONLINE);
+	if (err) {
+		pr_notice("Couldn't add PFNs 0x%llx - 0x%llx\n",
+			start >> PAGE_SHIFT, (start + size) >> PAGE_SHIFT);
+		goto add_and_online_memory;
+	}
+	err = walk_memory_blocks(start, size, NULL, memory_block_online_cb);
+	if (err) {
+		pr_notice("Couldn't online PFNs 0x%llx - 0x%llx\n",
+			start >> PAGE_SHIFT, (start + size) >> PAGE_SHIFT);
+		goto remove_memory;
+	}
+
+	return 0;
+
+remove_memory:
+	if (WARN_ON(remove_memory(start, size)))
+		return err;
+add_and_online_memory:
+	if (WARN_ON(add_memory(0, start, size, MMOP_ONLINE)))
+		return err;
+	WARN_ON(walk_memory_blocks(start, size, NULL, memory_block_online_cb));
+	return err;
+}
+
+static void depopulate_isolated_node(struct kunit_suite *suite)
+{
+	unsigned long start, size = memory_block_size_bytes();
+
+	if (suite->suite_init_err)
+		return;
+
+	start = NODE_DATA(isolated_node)->node_start_pfn << PAGE_SHIFT;
+
+	WARN_ON(remove_memory(start, size));
+	WARN_ON(add_memory(0, start, size, MMOP_ONLINE));
+	WARN_ON(walk_memory_blocks(start, size, NULL, memory_block_online_cb));
+}
 static struct kunit_case test_cases[] = { {} };
 
-static struct kunit_suite test_suite = {
+struct kunit_suite page_alloc_test_suite = {
 	.name = "page_alloc",
 	.test_cases = test_cases,
+	.suite_init = populate_isolated_node,
+	.suite_exit = depopulate_isolated_node,
+	.init = test_init,
 };
-kunit_test_suite(test_suite);
+kunit_test_suite(page_alloc_test_suite);
 
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");

-- 
2.48.1.601.g30ceb7b040-goog


