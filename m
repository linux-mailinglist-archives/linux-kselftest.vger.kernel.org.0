Return-Path: <linux-kselftest+bounces-9456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8E88BB9C4
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 09:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8680AB220E5
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A3322B;
	Sat,  4 May 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ThCMsZtd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E411723
	for <linux-kselftest@vger.kernel.org>; Sat,  4 May 2024 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807852; cv=none; b=McB/9FIoxnHM6vRIZz9893Cjj+vN4mpY7ZCo1hjl6ML+0YPny15tkbcuwunKkB56xUzYMsTMn9TvXbeN6BBiuezXuSmYI6mwWlubDbZTQJxmT8tXE90qhNbaESClYr7B74vS7Pt3MNx7Oni3dzY02/0RG0XDWOf0spA5ivAOJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807852; c=relaxed/simple;
	bh=QVMqH9d0it4qIkcZCQESGKqws1HRsFqpZl0aWCgEt2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yzy5DQe5soLLM/hattKPfdX/gMv1hwa45dLZgfy6v4o9MR3us2ufwMw4UnPLEIr0pv12/58OsyWhNXgiWgWD1uXTkPMnk7YnWz2dlrfXYz+PdHgq/spfcbywXGHzQ/UU/OluvAb+r6L7YhbWQTj3ec2VBPghXjKrzReFavjI3a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ThCMsZtd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be3f082b0so7200877b3.1
        for <linux-kselftest@vger.kernel.org>; Sat, 04 May 2024 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714807849; x=1715412649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dH44YFbsI/wViZnIs4Aonmrz8ZyFoelrelW04d6e1qc=;
        b=ThCMsZtdRG3MuJv/NpClwSOEL2kZ6XRW8x9E8Gx8w35egAU+cbrRltllsD9JxExcxd
         slKrqbUubdnYqGu1H1B2tF9BoJa7xkGziAEK0tiInNcE6vkPUqKzb0Q40+vCGqab3NyL
         KsfodYA5nCw+5UiuxbGtztlGG3f5dnklCgVzdDiYp5ySgTjGrbxVALPBp9LyzM+l4PT0
         YeG6PxjWeH/1C0/nFTEzGoznR7f6KTZK6uc8hKbugw7n/XzzY6p/BiO936vjQdjVJ2zG
         s4Cy0Tdpx7/prR/TVTPajyuxEgOB1pe9W7MTPl9/g6sl9PSyG6T9NRM0IZAnPiSXxvWm
         Mx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714807849; x=1715412649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dH44YFbsI/wViZnIs4Aonmrz8ZyFoelrelW04d6e1qc=;
        b=J/qcn95E+EFJOAbYjyesV6p9d4cHc4WIrQbp8jb6Oc2U7PgXcotzgkjd+4xUxSdPJF
         zWhNuoaTErIAHkAg/0v7y0SVFcujE4SklWc86WIqBBcT4iXVg15adN4wtT0QjbodOs+T
         vnLgdy28SbmC9uV1QBVKq9ZsoRprFjSUYfsfBkn8Ts3cZTnhiiBOpOabiW3T0Xa+YKm4
         OxrknOsO+lmIl2yq6ILVDJqgwqP1vTSz/yvx2oGkhMIXMGViRyvisaRbEgYD+L29BPNr
         jIfq30sLCRM7JE5YldSdvFL2tsozuVCu5VsliqQaldkC0yyinFYsdgbVWXfGSILMW7L/
         roUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB+soqbLs0XC2pfrdy2R8Ja+Oy3da74Hg/0XUKfMcw/SJTC3DUK2qLA9hHi6evo0qf+M79MXD06ojvJtLH5nZaheS2jj48aWaNewTyPW9q
X-Gm-Message-State: AOJu0YzJPK53h6dvJbbc8SJyW9LHqS3Aa0PBmG4EPodtcCsikSz3UDUg
	GNMren6BTfOGQ3GiUsBDY586WjKfyWBCI1w/X034DGn9V9/dkOnZuDk8SmEDK7iZ3NugWyc+q/K
	c0Xkhbw==
X-Google-Smtp-Source: AGHT+IFcMAMPXIkyMkHP8ysggr4nF8ifhyWpORS93sMeo0wY3uA25ty9ehoTDuN2Dk7E8tmJu5w76waYdzEo
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:da8f:bd07:9977:eb21])
 (user=yuanchu job=sendgmr) by 2002:a81:6fc3:0:b0:61b:e6a8:a8a with SMTP id
 k186-20020a816fc3000000b0061be6a80a8amr1032920ywc.6.1714807848626; Sat, 04
 May 2024 00:30:48 -0700 (PDT)
Date: Sat,  4 May 2024 00:30:06 -0700
In-Reply-To: <20240504073011.4000534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504073011.4000534-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240504073011.4000534-3-yuanchu@google.com>
Subject: [PATCH v1 2/7] mm: aggregate working set information into histograms
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hierarchically aggregate all memcgs' MGLRU generations and their
page counts into working set page age histograms.
The histograms break down the system's working set per-node,
per-anon/file.

The sysfs interfaces are as follows:
/sys/devices/system/node/nodeX/page_age
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

/sys/devices/system/node/nodeX/page_age_interval
	A comma separated list of time in milliseconds that configures
	what the page age histogram uses for aggregation.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 drivers/base/node.c               |   6 +
 include/linux/mmzone.h            |   9 +
 include/linux/workingset_report.h |  79 ++++++
 mm/Kconfig                        |   9 +
 mm/Makefile                       |   1 +
 mm/internal.h                     |   9 +
 mm/memcontrol.c                   |   2 +
 mm/mm_init.c                      |   2 +
 mm/mmzone.c                       |   2 +
 mm/vmscan.c                       |  32 +++
 mm/workingset_report.c            | 438 ++++++++++++++++++++++++++++++
 11 files changed, 589 insertions(+)
 create mode 100644 include/linux/workingset_report.h
 create mode 100644 mm/workingset_report.c

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 1c05640461dd..81bf0c68efca 100644
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
@@ -625,6 +627,7 @@ static int register_node(struct node *node, int num)
 	} else {
 		hugetlb_register_node(node);
 		compaction_register_node(node);
+		wsr_init_sysfs(node);
 	}
 
 	return error;
@@ -641,6 +644,9 @@ void unregister_node(struct node *node)
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
index a497f189d988..3e94d76c8f29 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -24,6 +24,7 @@
 #include <linux/local_lock.h>
 #include <linux/zswap.h>
 #include <asm/page.h>
+#include <linux/workingset_report.h>
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
@@ -625,6 +626,9 @@ struct lruvec {
 	struct lru_gen_mm_state		mm_state;
 #endif
 #endif /* CONFIG_LRU_GEN */
+#ifdef CONFIG_WORKINGSET_REPORT
+	struct wsr_state	wsr;
+#endif /* CONFIG_WORKINGSET_REPORT */
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
@@ -1398,6 +1402,11 @@ typedef struct pglist_data {
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
index ffc3a2ba3a8c..212f203b10b9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1261,6 +1261,15 @@ config LOCK_MM_AND_FIND_VMA
 config IOMMU_MM_DATA
 	bool
 
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
index e4b5b75aaec9..57093657030d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
+obj-$(CONFIG_WORKINGSET_REPORT) += workingset_report.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..5e0caba64ee4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -198,12 +198,21 @@ extern unsigned long highest_memmap_pfn;
 /*
  * in mm/vmscan.c:
  */
+struct scan_control;
 bool isolate_lru_page(struct page *page);
 bool folio_isolate_lru(struct folio *folio);
 void putback_lru_page(struct page *page);
 void folio_putback_lru(struct folio *folio);
 extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
 
+#ifdef CONFIG_WORKINGSET_REPORT
+/*
+ * in mm/wsr.c
+ */
+/* Requires wsr->page_age_lock held */
+void wsr_refresh_scan(struct lruvec *lruvec);
+#endif
+
 /*
  * in mm/rmap.c:
  */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1ed40f9d3a27..b5b67c93c287 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -65,6 +65,7 @@
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
+#include <linux/workingset_report.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -5457,6 +5458,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
+	wsr_destroy_lruvec(&pn->lruvec);
 	free_percpu(pn->lruvec_stats_percpu);
 	kfree(pn);
 }
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2c19f5515e36..c741c3f1e3db 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -27,6 +27,7 @@
 #include <linux/swap.h>
 #include <linux/cma.h>
 #include <linux/crash_dump.h>
+#include <linux/workingset_report.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -1368,6 +1369,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 
 	pgdat_page_ext_init(pgdat);
 	lruvec_init(&pgdat->__lruvec);
+	wsr_init_pgdat(pgdat);
 }
 
 static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
diff --git a/mm/mmzone.c b/mm/mmzone.c
index c01896eca736..477cd5ac1d78 100644
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
index 1a7c7d537db6..9af6793a6534 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -56,6 +56,7 @@
 #include <linux/khugepaged.h>
 #include <linux/rculist_nulls.h>
 #include <linux/random.h>
+#include <linux/workingset_report.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -5606,6 +5607,8 @@ static int __init init_lru_gen(void)
 	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
 		pr_err("lru_gen: failed to create sysfs group\n");
 
+	wsr_init_sysfs(NULL);
+
 	debugfs_create_file("lru_gen", 0644, NULL, NULL, &lru_gen_rw_fops);
 	debugfs_create_file("lru_gen_full", 0444, NULL, NULL, &lru_gen_ro_fops);
 
@@ -5613,6 +5616,35 @@ static int __init init_lru_gen(void)
 };
 late_initcall(init_lru_gen);
 
+/******************************************************************************
+ *                          workingset reporting
+ ******************************************************************************/
+#ifdef CONFIG_WORKINGSET_REPORT
+void wsr_refresh_scan(struct lruvec *lruvec)
+{
+	DEFINE_MAX_SEQ(lruvec);
+	struct scan_control sc = {
+		.may_writepage = true,
+		.may_unmap = true,
+		.may_swap = true,
+		.proactive = true,
+		.reclaim_idx = MAX_NR_ZONES - 1,
+		.gfp_mask = GFP_KERNEL,
+	};
+	unsigned int flags;
+
+	set_task_reclaim_state(current, &sc.reclaim_state);
+	flags = memalloc_noreclaim_save();
+	/*
+	 * setting can_swap=true and force_scan=true ensures
+	 * proper workingset stats when the system cannot swap.
+	 */
+	try_to_inc_max_seq(lruvec, max_seq, &sc, true, true);
+	memalloc_noreclaim_restore(flags);
+	set_task_reclaim_state(current, NULL);
+}
+#endif /* CONFIG_WORKINGSET_REPORT */
+
 #else /* !CONFIG_LRU_GEN */
 
 static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
new file mode 100644
index 000000000000..7b872b9fa7da
--- /dev/null
+++ b/mm/workingset_report.c
@@ -0,0 +1,438 @@
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
+
+	memcg = mem_cgroup_iter(root, NULL, NULL);
+	do {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+
+		wsr_refresh_scan(lruvec);
+		cond_resched();
+	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
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
2.45.0.rc1.225.g2a3ae87e7f-goog


