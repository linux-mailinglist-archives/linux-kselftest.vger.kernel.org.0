Return-Path: <linux-kselftest+bounces-22547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0729DA0C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 03:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F728284110
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 02:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069C126C1C;
	Wed, 27 Nov 2024 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYrW2JjC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603216A8D2
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676268; cv=none; b=uKWaUjKgyDxZkflV7QzzKYWCb7rK0pPaXHiPI6LHVCa8HLXBZHkIl8TSuyLhm6O+8RDCzamsKxvsGTxh/yO9mMdm05SeE+Gp52s09YdjhVrqGO5kKq374fP00dr+jWlbFtApwpEdRlDTaO2VutMbwVrywEtGwIDxvVkjJF4sbUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676268; c=relaxed/simple;
	bh=vA7ObHusCpoPtNzRK7HZ0askipOytc7WfktLrhRTw38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BwR4xKul7nRp3E4nF3HcuVK6+i3n/lgUrgHrNr6S2tAn78d19RsxojD30aK3xrQU+GYB0xvIgxfNP3ZSr5Rtgw7KsV1VdFQIe+ZkFZjv6bO0TV9z24by4J2Y5KybZzl9PorDpGXxzKgksmVAdQy3Y8HlqHEpYRUdKPAbuwmYBDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OYrW2JjC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea2b6b08e4so6188252a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 18:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732676265; x=1733281065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMfZReVH6Y6OSe0PATfKlnZ+c8+zk2ht0ykfo5UOUYo=;
        b=OYrW2JjCV/rrmc1d98iVVEPxvyYLl9OmiMV0N/BNHwakw/HnDisjTNL7akEjYzChjs
         wV/jEjppf5F0hs6AXycD2EuE9bl3mu5sxBSeSCdiQ1rDrlOSt7emhsWShUp8Xvntk2lh
         bkZXNtqjE8VUufM9mw3xiZRIgt/fCfzpHzIBjJ2N+I7Aa7qDaQ6k1uUuuqwvqVff04W2
         xGrQ27F1zQqdmA/4RPttKHoH93u0j4M4JBaH9dSnkWzuDmLR0B0vV/i4ghB+ZeS5+ffA
         NINLsGqgiXwDRht5Hscu1se0DUZHqlDkZahcQ+PtcM/5mPfSl8Nag3j0d00OWJUYMTxO
         7kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676265; x=1733281065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMfZReVH6Y6OSe0PATfKlnZ+c8+zk2ht0ykfo5UOUYo=;
        b=EROufp5ybLHUxv76qv13YP/iUjfnibYyhKjJJf001gS5/f1wfIz1PFtnxIldNeOiRF
         Sf461KTLPIia6ytrQxtAyTF5GeTanS3Rja7WdEyIgRzn25+xGZuiWxyjAMVSDc8zEBRp
         3meSmOEQIXEirVbTjT4YUMpUX+z0OzLYipaHanenmfew9chW8eOl6DvOwb8bpn1r7Rrn
         aAUOSI/iD9pFrpVx6kNi72Ncqt68YSIIsPk6h0nEQMZuKxCpesMyst8HdQMtksWZP6+D
         7cRCpGYAL3potjsNwgRXIWzh64PU17dSGSw3O90z+pe3RLwUdJzN1sTXHQ6lcvcAtkMS
         k41A==
X-Forwarded-Encrypted: i=1; AJvYcCX5Ml25Qv3EfOxOhNfj1YqRyrcD0HTsa+18L5c0qopAw5MYqMHFfjPNmYdVhWTJi6iy3qLrrxDwdM/tbaWBrac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDS2DST658Lcr3Fld36kP/ssCbIbGc1X/c6Pbk6bmWU0T/GHzz
	lZjIQgJC1/HWTFO3ehe+zqjLu4DtM112vBWEb6JjDis8uSs5FgkBmJynyaI3PQ/Np5jyO6HImB1
	jVNDyoQ==
X-Google-Smtp-Source: AGHT+IGS3z2xtRaD82Eg6lpZpx9W4L7i5UELBQBxL0/M15PzUsyV5kTYfTLGRUtmYRU55oTDmRTrliUGszQh
X-Received: from pjtd4.prod.google.com ([2002:a17:90b:44:b0:2e2:8d64:6213])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b47:b0:2ea:49a8:917b
 with SMTP id 98e67ed59e1d1-2ee08dab307mr2422606a91.0.1732676264733; Tue, 26
 Nov 2024 18:57:44 -0800 (PST)
Date: Tue, 26 Nov 2024 18:57:20 -0800
In-Reply-To: <20241127025728.3689245-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127025728.3689245-2-yuanchu@google.com>
Subject: [PATCH v4 1/9] mm: aggregate workingset information into histograms
From: Yuanchu Xie <yuanchu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, Yuanchu Xie <yuanchu@google.com>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hierarchically aggregate all memcgs' MGLRU generations and their
page counts into working set page age histograms.
The histograms break down the system's workingset per-node,
per-anon/file.

The sysfs interfaces are as follows:
/sys/devices/system/node/nodeX/workingset_report/page_age
	A per-node page age histogram, showing an aggregate of the
	node's lruvecs. The information is extracted from MGLRU's
	per-generation page counters. Reading this file causes a
	hierarchical aging of all lruvecs, scanning pages and creates a
	new generation in each lruvec.
	For example:
	1000 anon=0 file=0
	2000 anon=0 file=0
	100000 anon=5533696 file=5566464
	18446744073709551615 anon=0 file=0

/sys/devices/system/node/nodeX/workingset_report/page_age_interval
	A comma separated list of time in milliseconds that configures
	what the page age histogram uses for aggregation.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 drivers/base/node.c               |   6 +
 include/linux/mmzone.h            |   9 +
 include/linux/workingset_report.h |  79 ++++++
 mm/Kconfig                        |   9 +
 mm/Makefile                       |   1 +
 mm/internal.h                     |   5 +
 mm/memcontrol.c                   |   2 +
 mm/mm_init.c                      |   2 +
 mm/mmzone.c                       |   2 +
 mm/vmscan.c                       |  10 +-
 mm/workingset_report.c            | 451 ++++++++++++++++++++++++++++++
 11 files changed, 572 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/workingset_report.h
 create mode 100644 mm/workingset_report.c

diff --git a/drivers/base/node.c b/drivers/base/node.c
index eb72580288e6..ba5b8720dbfa 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,6 +20,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/memcontrol.h>
+#include <linux/workingset_report.h>
 
 static const struct bus_type node_subsys = {
 	.name = "node",
@@ -626,6 +628,7 @@ static int register_node(struct node *node, int num)
 	} else {
 		hugetlb_register_node(node);
 		compaction_register_node(node);
+		wsr_init_sysfs(node);
 	}
 
 	return error;
@@ -642,6 +645,9 @@ void unregister_node(struct node *node)
 {
 	hugetlb_unregister_node(node);
 	compaction_unregister_node(node);
+	wsr_remove_sysfs(node);
+	wsr_destroy_lruvec(mem_cgroup_lruvec(NULL, NODE_DATA(node->dev.id)));
+	wsr_destroy_pgdat(NODE_DATA(node->dev.id));
 	node_remove_accesses(node);
 	node_remove_caches(node);
 	device_unregister(&node->dev);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 80bc5640bb60..ee728c0c5a3b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -24,6 +24,7 @@
 #include <linux/local_lock.h>
 #include <linux/zswap.h>
 #include <asm/page.h>
+#include <linux/workingset_report.h>
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
@@ -630,6 +631,9 @@ struct lruvec {
 	struct lru_gen_mm_state		mm_state;
 #endif
 #endif /* CONFIG_LRU_GEN */
+#ifdef CONFIG_WORKINGSET_REPORT
+	struct wsr_state	wsr;
+#endif /* CONFIG_WORKINGSET_REPORT */
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
@@ -1424,6 +1428,11 @@ typedef struct pglist_data {
 	struct lru_gen_memcg memcg_lru;
 #endif
 
+#ifdef CONFIG_WORKINGSET_REPORT
+	struct mutex wsr_update_mutex;
+	struct wsr_report_bins __rcu *wsr_page_age_bins;
+#endif
+
 	CACHELINE_PADDING(_pad2_);
 
 	/* Per-node vmstats */
diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
new file mode 100644
index 000000000000..d7c2ee14ec87
--- /dev/null
+++ b/include/linux/workingset_report.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_WORKINGSET_REPORT_H
+#define _LINUX_WORKINGSET_REPORT_H
+
+#include <linux/types.h>
+#include <linux/mutex.h>
+
+struct mem_cgroup;
+struct pglist_data;
+struct node;
+struct lruvec;
+
+#ifdef CONFIG_WORKINGSET_REPORT
+
+#define WORKINGSET_REPORT_MIN_NR_BINS 2
+#define WORKINGSET_REPORT_MAX_NR_BINS 32
+
+#define WORKINGSET_INTERVAL_MAX ((unsigned long)-1)
+#define ANON_AND_FILE 2
+
+struct wsr_report_bin {
+	unsigned long idle_age;
+	unsigned long nr_pages[ANON_AND_FILE];
+};
+
+struct wsr_report_bins {
+	/* excludes the WORKINGSET_INTERVAL_MAX bin */
+	unsigned long nr_bins;
+	/* last bin contains WORKINGSET_INTERVAL_MAX */
+	unsigned long idle_age[WORKINGSET_REPORT_MAX_NR_BINS];
+	struct rcu_head rcu;
+};
+
+struct wsr_page_age_histo {
+	unsigned long timestamp;
+	struct wsr_report_bin bins[WORKINGSET_REPORT_MAX_NR_BINS];
+};
+
+struct wsr_state {
+	/* breakdown of workingset by page age */
+	struct mutex page_age_lock;
+	struct wsr_page_age_histo *page_age;
+};
+
+void wsr_init_lruvec(struct lruvec *lruvec);
+void wsr_destroy_lruvec(struct lruvec *lruvec);
+void wsr_init_pgdat(struct pglist_data *pgdat);
+void wsr_destroy_pgdat(struct pglist_data *pgdat);
+void wsr_init_sysfs(struct node *node);
+void wsr_remove_sysfs(struct node *node);
+
+/*
+ * Returns true if the wsr is configured to be refreshed.
+ * The next refresh time is stored in refresh_time.
+ */
+bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
+			struct pglist_data *pgdat);
+#else
+static inline void wsr_init_lruvec(struct lruvec *lruvec)
+{
+}
+static inline void wsr_destroy_lruvec(struct lruvec *lruvec)
+{
+}
+static inline void wsr_init_pgdat(struct pglist_data *pgdat)
+{
+}
+static inline void wsr_destroy_pgdat(struct pglist_data *pgdat)
+{
+}
+static inline void wsr_init_sysfs(struct node *node)
+{
+}
+static inline void wsr_remove_sysfs(struct node *node)
+{
+}
+#endif /* CONFIG_WORKINGSET_REPORT */
+
+#endif /* _LINUX_WORKINGSET_REPORT_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 84000b016808..be949786796d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1301,6 +1301,15 @@ config ARCH_HAS_USER_SHADOW_STACK
 	  The architecture has hardware support for userspace shadow call
           stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
 
+config WORKINGSET_REPORT
+	bool "Working set reporting"
+	depends on LRU_GEN && SYSFS
+	help
+	  Report system and per-memcg working set to userspace.
+
+	  This option exports stats and events giving the user more insight
+	  into its memory working set.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index d5639b036166..f5ef0768253a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
+obj-$(CONFIG_WORKINGSET_REPORT) += workingset_report.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/internal.h b/mm/internal.h
index 64c2eb0b160e..bbd3c1501bac 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -470,9 +470,14 @@ extern unsigned long highest_memmap_pfn;
 /*
  * in mm/vmscan.c:
  */
+struct scan_control;
+bool isolate_lru_page(struct page *page);
 bool folio_isolate_lru(struct folio *folio);
 void folio_putback_lru(struct folio *folio);
 extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
+bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq, bool can_swap,
+			bool force_scan);
+void set_task_reclaim_state(struct task_struct *task, struct reclaim_state *rs);
 
 /*
  * in mm/rmap.c:
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 53db98d2c4a1..096856b35fbc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
+#include <linux/workingset_report.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -3453,6 +3454,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
+	wsr_destroy_lruvec(&pn->lruvec);
 	free_percpu(pn->lruvec_stats_percpu);
 	kfree(pn->lruvec_stats);
 	kfree(pn);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607aaf19..b4f7c904ce33 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -30,6 +30,7 @@
 #include <linux/crash_dump.h>
 #include <linux/execmem.h>
 #include <linux/vmstat.h>
+#include <linux/workingset_report.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -1378,6 +1379,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 
 	pgdat_page_ext_init(pgdat);
 	lruvec_init(&pgdat->__lruvec);
+	wsr_init_pgdat(pgdat);
 }
 
 static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
diff --git a/mm/mmzone.c b/mm/mmzone.c
index f9baa8882fbf..0352a2018067 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -90,6 +90,8 @@ void lruvec_init(struct lruvec *lruvec)
 	 */
 	list_del(&lruvec->lists[LRU_UNEVICTABLE]);
 
+	wsr_init_lruvec(lruvec);
+
 	lru_gen_init_lruvec(lruvec);
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 28ba2b06fc7d..89da4d8dfb5f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -57,6 +57,7 @@
 #include <linux/rculist_nulls.h>
 #include <linux/random.h>
 #include <linux/mmu_notifier.h>
+#include <linux/workingset_report.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -271,8 +272,7 @@ static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
 }
 #endif
 
-static void set_task_reclaim_state(struct task_struct *task,
-				   struct reclaim_state *rs)
+void set_task_reclaim_state(struct task_struct *task, struct reclaim_state *rs)
 {
 	/* Check for an overwrite */
 	WARN_ON_ONCE(rs && task->reclaim_state);
@@ -3861,8 +3861,8 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq,
 	return success;
 }
 
-static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq,
-			       bool can_swap, bool force_scan)
+bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq, bool can_swap,
+			bool force_scan)
 {
 	bool success;
 	struct lru_gen_mm_walk *walk;
@@ -5640,6 +5640,8 @@ static int __init init_lru_gen(void)
 	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
 		pr_err("lru_gen: failed to create sysfs group\n");
 
+	wsr_init_sysfs(NULL);
+
 	debugfs_create_file("lru_gen", 0644, NULL, NULL, &lru_gen_rw_fops);
 	debugfs_create_file("lru_gen_full", 0444, NULL, NULL, &lru_gen_ro_fops);
 
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
new file mode 100644
index 000000000000..a4dcf62fcd96
--- /dev/null
+++ b/mm/workingset_report.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include <linux/lockdep.h>
+#include <linux/jiffies.h>
+#include <linux/kernfs.h>
+#include <linux/memcontrol.h>
+#include <linux/rcupdate.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/atomic.h>
+#include <linux/node.h>
+#include <linux/mmzone.h>
+#include <linux/mm.h>
+#include <linux/mm_inline.h>
+#include <linux/workingset_report.h>
+
+#include "internal.h"
+
+void wsr_init_pgdat(struct pglist_data *pgdat)
+{
+	mutex_init(&pgdat->wsr_update_mutex);
+	RCU_INIT_POINTER(pgdat->wsr_page_age_bins, NULL);
+}
+
+void wsr_destroy_pgdat(struct pglist_data *pgdat)
+{
+	struct wsr_report_bins __rcu *bins;
+
+	mutex_lock(&pgdat->wsr_update_mutex);
+	bins = rcu_replace_pointer(pgdat->wsr_page_age_bins, NULL,
+			    lockdep_is_held(&pgdat->wsr_update_mutex));
+	kfree_rcu(bins, rcu);
+	mutex_unlock(&pgdat->wsr_update_mutex);
+	mutex_destroy(&pgdat->wsr_update_mutex);
+}
+
+void wsr_init_lruvec(struct lruvec *lruvec)
+{
+	struct wsr_state *wsr = &lruvec->wsr;
+
+	memset(wsr, 0, sizeof(*wsr));
+	mutex_init(&wsr->page_age_lock);
+}
+
+void wsr_destroy_lruvec(struct lruvec *lruvec)
+{
+	struct wsr_state *wsr = &lruvec->wsr;
+
+	mutex_destroy(&wsr->page_age_lock);
+	kfree(wsr->page_age);
+	memset(wsr, 0, sizeof(*wsr));
+}
+
+static int workingset_report_intervals_parse(char *src,
+					     struct wsr_report_bins *bins)
+{
+	int err = 0, i = 0;
+	char *cur, *next = strim(src);
+
+	if (*next == '\0')
+		return 0;
+
+	while ((cur = strsep(&next, ","))) {
+		unsigned int interval;
+
+		err = kstrtouint(cur, 0, &interval);
+		if (err)
+			goto out;
+
+		bins->idle_age[i] = msecs_to_jiffies(interval);
+		if (i > 0 && bins->idle_age[i] <= bins->idle_age[i - 1]) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (++i == WORKINGSET_REPORT_MAX_NR_BINS) {
+			err = -ERANGE;
+			goto out;
+		}
+	}
+
+	if (i && i < WORKINGSET_REPORT_MIN_NR_BINS - 1) {
+		err = -ERANGE;
+		goto out;
+	}
+
+	bins->nr_bins = i;
+	bins->idle_age[i] = WORKINGSET_INTERVAL_MAX;
+out:
+	return err ?: i;
+}
+
+static unsigned long get_gen_start_time(const struct lru_gen_folio *lrugen,
+					unsigned long seq,
+					unsigned long max_seq,
+					unsigned long curr_timestamp)
+{
+	int younger_gen;
+
+	if (seq == max_seq)
+		return curr_timestamp;
+	younger_gen = lru_gen_from_seq(seq + 1);
+	return READ_ONCE(lrugen->timestamps[younger_gen]);
+}
+
+static void collect_page_age_type(const struct lru_gen_folio *lrugen,
+				  struct wsr_report_bin *bin,
+				  unsigned long max_seq, unsigned long min_seq,
+				  unsigned long curr_timestamp, int type)
+{
+	unsigned long seq;
+
+	for (seq = max_seq; seq + 1 > min_seq; seq--) {
+		int gen, zone;
+		unsigned long gen_end, gen_start, size = 0;
+
+		gen = lru_gen_from_seq(seq);
+
+		for (zone = 0; zone < MAX_NR_ZONES; zone++)
+			size += max(
+				READ_ONCE(lrugen->nr_pages[gen][type][zone]),
+				0L);
+
+		gen_start = get_gen_start_time(lrugen, seq, max_seq,
+					       curr_timestamp);
+		gen_end = READ_ONCE(lrugen->timestamps[gen]);
+
+		while (bin->idle_age != WORKINGSET_INTERVAL_MAX &&
+		       time_before(gen_end + bin->idle_age, curr_timestamp)) {
+			unsigned long gen_in_bin = (long)gen_start -
+						   (long)curr_timestamp +
+						   (long)bin->idle_age;
+			unsigned long gen_len = (long)gen_start - (long)gen_end;
+
+			if (!gen_len)
+				break;
+			if (gen_in_bin) {
+				unsigned long split_bin =
+					size / gen_len * gen_in_bin;
+
+				bin->nr_pages[type] += split_bin;
+				size -= split_bin;
+			}
+			gen_start = curr_timestamp - bin->idle_age;
+			bin++;
+		}
+		bin->nr_pages[type] += size;
+	}
+}
+
+/*
+ * proportionally aggregate Multi-gen LRU bins into a working set report
+ * MGLRU generations:
+ * current time
+ * |         max_seq timestamp
+ * |         |     max_seq - 1 timestamp
+ * |         |     |               unbounded
+ * |         |     |               |
+ * --------------------------------
+ * | max_seq | ... | ... | min_seq
+ * --------------------------------
+ *
+ * Bins:
+ *
+ * current time
+ * |       current - idle_age[0]
+ * |       |     current - idle_age[1]
+ * |       |     |               unbounded
+ * |       |     |               |
+ * ------------------------------
+ * | bin 0 | ... | ... | bin n-1
+ * ------------------------------
+ *
+ * Assume the heuristic that pages are in the MGLRU generation
+ * through uniform accesses, so we can aggregate them
+ * proportionally into bins.
+ */
+static void collect_page_age(struct wsr_page_age_histo *page_age,
+			     const struct lruvec *lruvec)
+{
+	int type;
+	const struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	unsigned long curr_timestamp = jiffies;
+	unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
+	unsigned long min_seq[ANON_AND_FILE] = {
+		READ_ONCE(lruvec->lrugen.min_seq[LRU_GEN_ANON]),
+		READ_ONCE(lruvec->lrugen.min_seq[LRU_GEN_FILE]),
+	};
+	struct wsr_report_bin *bin = &page_age->bins[0];
+
+	for (type = 0; type < ANON_AND_FILE; type++)
+		collect_page_age_type(lrugen, bin, max_seq, min_seq[type],
+				      curr_timestamp, type);
+}
+
+/* First step: hierarchically scan child memcgs. */
+static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
+			 struct pglist_data *pgdat)
+{
+	struct mem_cgroup *memcg;
+	unsigned int flags;
+	struct reclaim_state rs = { 0 };
+
+	set_task_reclaim_state(current, &rs);
+	flags = memalloc_noreclaim_save();
+
+	memcg = mem_cgroup_iter(root, NULL, NULL);
+	do {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+		unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
+
+		/*
+		 * setting can_swap=true and force_scan=true ensures
+		 * proper workingset stats when the system cannot swap.
+		 */
+		try_to_inc_max_seq(lruvec, max_seq, true, true);
+		cond_resched();
+	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
+
+	memalloc_noreclaim_restore(flags);
+	set_task_reclaim_state(current, NULL);
+}
+
+/* Second step: aggregate child memcgs into the page age histogram. */
+static void refresh_aggregate(struct wsr_page_age_histo *page_age,
+			      struct mem_cgroup *root,
+			      struct pglist_data *pgdat)
+{
+	struct mem_cgroup *memcg;
+	struct wsr_report_bin *bin;
+
+	for (bin = page_age->bins;
+	     bin->idle_age != WORKINGSET_INTERVAL_MAX; bin++) {
+		bin->nr_pages[0] = 0;
+		bin->nr_pages[1] = 0;
+	}
+	/* the last used bin has idle_age == WORKINGSET_INTERVAL_MAX. */
+	bin->nr_pages[0] = 0;
+	bin->nr_pages[1] = 0;
+
+	memcg = mem_cgroup_iter(root, NULL, NULL);
+	do {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+
+		collect_page_age(page_age, lruvec);
+		cond_resched();
+	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
+	WRITE_ONCE(page_age->timestamp, jiffies);
+}
+
+static void copy_node_bins(struct pglist_data *pgdat,
+			   struct wsr_page_age_histo *page_age)
+{
+	struct wsr_report_bins *node_page_age_bins;
+	int i = 0;
+
+	rcu_read_lock();
+	node_page_age_bins = rcu_dereference(pgdat->wsr_page_age_bins);
+	if (!node_page_age_bins)
+		goto nocopy;
+	for (i = 0; i < node_page_age_bins->nr_bins; ++i)
+		page_age->bins[i].idle_age = node_page_age_bins->idle_age[i];
+
+nocopy:
+	page_age->bins[i].idle_age = WORKINGSET_INTERVAL_MAX;
+	rcu_read_unlock();
+}
+
+bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
+			struct pglist_data *pgdat)
+{
+	struct wsr_page_age_histo *page_age;
+
+	if (!READ_ONCE(wsr->page_age))
+		return false;
+
+	refresh_scan(wsr, root, pgdat);
+	mutex_lock(&wsr->page_age_lock);
+	page_age = READ_ONCE(wsr->page_age);
+	if (page_age) {
+		copy_node_bins(pgdat, page_age);
+		refresh_aggregate(page_age, root, pgdat);
+	}
+	mutex_unlock(&wsr->page_age_lock);
+	return !!page_age;
+}
+EXPORT_SYMBOL_GPL(wsr_refresh_report);
+
+static struct pglist_data *kobj_to_pgdat(struct kobject *kobj)
+{
+	int nid = IS_ENABLED(CONFIG_NUMA) ? kobj_to_dev(kobj)->id :
+					    first_memory_node;
+
+	return NODE_DATA(nid);
+}
+
+static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
+{
+	return &mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj))->wsr;
+}
+
+static ssize_t page_age_intervals_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	struct wsr_report_bins *bins;
+	int len = 0;
+	struct pglist_data *pgdat = kobj_to_pgdat(kobj);
+
+	rcu_read_lock();
+	bins = rcu_dereference(pgdat->wsr_page_age_bins);
+	if (bins) {
+		int i;
+		int nr_bins = bins->nr_bins;
+
+		for (i = 0; i < bins->nr_bins; ++i) {
+			len += sysfs_emit_at(
+				buf, len, "%u",
+				jiffies_to_msecs(bins->idle_age[i]));
+			if (i + 1 < nr_bins)
+				len += sysfs_emit_at(buf, len, ",");
+		}
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+	rcu_read_unlock();
+
+	return len;
+}
+
+static ssize_t page_age_intervals_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *src, size_t len)
+{
+	struct wsr_report_bins *bins = NULL, __rcu *old;
+	char *buf = NULL;
+	int err = 0;
+	struct pglist_data *pgdat = kobj_to_pgdat(kobj);
+
+	buf = kstrdup(src, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	bins =
+		kzalloc(sizeof(struct wsr_report_bins), GFP_KERNEL);
+
+	if (!bins) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	err = workingset_report_intervals_parse(buf, bins);
+	if (err < 0)
+		goto failed;
+
+	if (err == 0) {
+		kfree(bins);
+		bins = NULL;
+	}
+
+	mutex_lock(&pgdat->wsr_update_mutex);
+	old = rcu_replace_pointer(pgdat->wsr_page_age_bins, bins,
+				  lockdep_is_held(&pgdat->wsr_update_mutex));
+	mutex_unlock(&pgdat->wsr_update_mutex);
+	kfree_rcu(old, rcu);
+	kfree(buf);
+	return len;
+failed:
+	kfree(bins);
+	kfree(buf);
+
+	return err;
+}
+
+static struct kobj_attribute page_age_intervals_attr =
+	__ATTR_RW(page_age_intervals);
+
+static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf)
+{
+	struct wsr_report_bin *bin;
+	int ret = 0;
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+
+
+	mutex_lock(&wsr->page_age_lock);
+	if (!wsr->page_age)
+		wsr->page_age =
+			kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL);
+	mutex_unlock(&wsr->page_age_lock);
+
+	wsr_refresh_report(wsr, NULL, kobj_to_pgdat(kobj));
+
+	mutex_lock(&wsr->page_age_lock);
+	if (!wsr->page_age)
+		goto unlock;
+	for (bin = wsr->page_age->bins;
+	     bin->idle_age != WORKINGSET_INTERVAL_MAX; bin++)
+		ret += sysfs_emit_at(buf, ret, "%u anon=%lu file=%lu\n",
+				     jiffies_to_msecs(bin->idle_age),
+				     bin->nr_pages[0] * PAGE_SIZE,
+				     bin->nr_pages[1] * PAGE_SIZE);
+
+	ret += sysfs_emit_at(buf, ret, "%lu anon=%lu file=%lu\n",
+			     WORKINGSET_INTERVAL_MAX,
+			     bin->nr_pages[0] * PAGE_SIZE,
+			     bin->nr_pages[1] * PAGE_SIZE);
+
+unlock:
+	mutex_unlock(&wsr->page_age_lock);
+	return ret;
+}
+
+static struct kobj_attribute page_age_attr = __ATTR_RO(page_age);
+
+static struct attribute *workingset_report_attrs[] = {
+	&page_age_intervals_attr.attr, &page_age_attr.attr, NULL
+};
+
+static const struct attribute_group workingset_report_attr_group = {
+	.name = "workingset_report",
+	.attrs = workingset_report_attrs,
+};
+
+void wsr_init_sysfs(struct node *node)
+{
+	struct kobject *kobj = node ? &node->dev.kobj : mm_kobj;
+	struct wsr_state *wsr;
+
+	if (IS_ENABLED(CONFIG_NUMA) && !node)
+		return;
+
+	wsr = kobj_to_wsr(kobj);
+
+	if (sysfs_create_group(kobj, &workingset_report_attr_group))
+		pr_warn("Workingset report failed to create sysfs files\n");
+}
+EXPORT_SYMBOL_GPL(wsr_init_sysfs);
+
+void wsr_remove_sysfs(struct node *node)
+{
+	struct kobject *kobj = &node->dev.kobj;
+	struct wsr_state *wsr;
+
+	if (IS_ENABLED(CONFIG_NUMA) && !node)
+		return;
+
+	wsr = kobj_to_wsr(kobj);
+	sysfs_remove_group(kobj, &workingset_report_attr_group);
+}
+EXPORT_SYMBOL_GPL(wsr_remove_sysfs);
-- 
2.47.0.338.g60cca15819-goog


