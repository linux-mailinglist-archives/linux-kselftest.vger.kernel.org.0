Return-Path: <linux-kselftest+bounces-7468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37B789D2EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 09:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99922843DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E5B7A15C;
	Tue,  9 Apr 2024 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MP0hdsaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D477F3E;
	Tue,  9 Apr 2024 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647252; cv=none; b=TAkeZG2ErLqvxnKKWHQ6IN4Yz2mHIEhpamTHo7RbpR7M10aBt0AUmOMGS9B31D3bkCBH9u7oeGsEpwYlu0hudOFhz2BX/ZkMjqVfq+Z3lSjq93tDsdk9SMY9gZkO6w038XClgoRLbISx2mQciMNj61blmeHQ1GpyaoJ/WEme8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647252; c=relaxed/simple;
	bh=FrmKVdiBVGm8zkaNn+ic0NzmzBH9mdStNkqB78wGuDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I6lgnAObCdVP70SZXdWIVOVvoLJoT0Pb36204mXoDj2SwE4D/bgQi13ypSdMLo7a6trHjBGo6fsjRt4rY4svcTyumql8+lBv2KJItllrRKtIr2tqa6xIeRwzf9fOWc15rGoraFYFet1Zv9+U3ZRxFLMCenxYPB1Epz9nmbGKyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MP0hdsaY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712647250; x=1744183250;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FrmKVdiBVGm8zkaNn+ic0NzmzBH9mdStNkqB78wGuDw=;
  b=MP0hdsaYV0JCssSyMYZQqloTFAiwszJKKsbHqb06KoR1mCS/OAdbyj96
   E/kCm2IzC432ksiUa/kIaHU9Kp8mtSQv0KjTUQ111oIC6LOCaMIo1li+Z
   DPkL4Nt03AKXzxG4qHUtrQaUInElggxvXbHmRh8OvSsC0t4fOIjfo20+K
   GetxUXmfKtnwfrui+UezqbMSWUHwljjBLdceeQRY3cBGtY+t7g5IcL5We
   mG5PkVNlERqQZPYwKxGh9LH2XEH6efiv7lMXOqmbUctt6n7QmZ+V78jMH
   /jqGo18CrUrWFlkVWjrAGp7MnTp9QWron1g3GZY+KrkOi1pbKS7/ymbng
   Q==;
X-CSE-ConnectionGUID: 6tCLbZsDTJ6B6DfgdPTEtg==
X-CSE-MsgGUID: EWIn2MZ/QCinv+WaYvm/qQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19101833"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="19101833"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 00:20:49 -0700
X-CSE-ConnectionGUID: SkDvYLRIRLasl2ogbIEXTA==
X-CSE-MsgGUID: TcQgzps9TrK/pbADaevjCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="51145027"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 00:20:41 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>,  "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>,  Khalid Aziz <khalid.aziz@oracle.com>,
  Henry Huang <henry.hj@antgroup.com>,  Yu Zhao <yuzhao@google.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Gregory Price
 <gregory.price@memverge.com>,  Wei Xu <weixugc@google.com>,  David
 Rientjes <rientjes@google.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Roman Gushchin
 <roman.gushchin@linux.dev>,  Muchun Song <muchun.song@linux.dev>,  Shuah
 Khan <shuah@kernel.org>,  Yosry Ahmed <yosryahmed@google.com>,  Matthew
 Wilcox <willy@infradead.org>,  Sudarshan Rajagopalan
 <quic_sudaraja@quicinc.com>,  Kairui Song <kasong@tencent.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Vasily Averin <vasily.averin@linux.dev>,
  Nhat Pham <nphamcs@gmail.com>,  Miaohe Lin <linmiaohe@huawei.com>,  Qi
 Zheng <zhengqi.arch@bytedance.com>,  Abel Wu <wuyun.abel@bytedance.com>,
  "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/8] mm: aggregate working set information into
 histograms
In-Reply-To: <20240327213108.2384666-3-yuanchu@google.com> (Yuanchu Xie's
	message of "Wed, 27 Mar 2024 14:31:01 -0700")
References: <20240327213108.2384666-1-yuanchu@google.com>
	<20240327213108.2384666-3-yuanchu@google.com>
Date: Tue, 09 Apr 2024 15:18:48 +0800
Message-ID: <871q7f80mf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Yuanchu Xie <yuanchu@google.com> writes:

> Hierarchically aggregate all memcgs' MGLRU generations and their
> page counts into working set page age histograms.
> The histograms break down the system's working set per-node,
> per-anon/file.
>
> The sysfs interfaces are as follows:
> /sys/devices/system/node/nodeX/page_age
> 	A per-node page age histogram, showing an aggregate of the
> 	node's lruvecs. The information is extracted from MGLRU's
> 	per-generation page counters. Reading this file causes a
> 	hierarchical aging of all lruvecs, scanning pages and creates a
> 	new generation in each lruvec.
> 	For example:
> 	1000 anon=0 file=0
> 	2000 anon=0 file=0
> 	100000 anon=5533696 file=5566464
> 	18446744073709551615 anon=0 file=0
>
> /sys/devices/system/node/nodeX/page_age_interval
> 	A comma separated list of time in milliseconds that configures
> 	what the page age histogram uses for aggregation.
>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> ---
>  drivers/base/node.c               |   3 +
>  include/linux/mmzone.h            |   4 +
>  include/linux/workingset_report.h |  69 +++++
>  mm/Kconfig                        |   9 +
>  mm/Makefile                       |   1 +
>  mm/internal.h                     |   9 +
>  mm/memcontrol.c                   |   2 +
>  mm/mmzone.c                       |   2 +
>  mm/vmscan.c                       |  34 ++-
>  mm/workingset_report.c            | 413 ++++++++++++++++++++++++++++++
>  10 files changed, 545 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/workingset_report.h
>  create mode 100644 mm/workingset_report.c
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 1c05640461dd..4f589b8253f4 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
> +#include <linux/workingset_report.h>
>  
>  static const struct bus_type node_subsys = {
>  	.name = "node",
> @@ -625,6 +626,7 @@ static int register_node(struct node *node, int num)
>  	} else {
>  		hugetlb_register_node(node);
>  		compaction_register_node(node);
> +		wsr_register_node(node);
>  	}
>  
>  	return error;
> @@ -641,6 +643,7 @@ void unregister_node(struct node *node)
>  {
>  	hugetlb_unregister_node(node);
>  	compaction_unregister_node(node);
> +	wsr_unregister_node(node);
>  	node_remove_accesses(node);
>  	node_remove_caches(node);
>  	device_unregister(&node->dev);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index a497f189d988..8839931646ee 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -24,6 +24,7 @@
>  #include <linux/local_lock.h>
>  #include <linux/zswap.h>
>  #include <asm/page.h>
> +#include <linux/workingset_report.h>
>  
>  /* Free memory management - zoned buddy allocator.  */
>  #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
> @@ -625,6 +626,9 @@ struct lruvec {
>  	struct lru_gen_mm_state		mm_state;
>  #endif
>  #endif /* CONFIG_LRU_GEN */
> +#ifdef CONFIG_WORKINGSET_REPORT
> +	struct wsr_state	wsr;
> +#endif /* CONFIG_WORKINGSET_REPORT */
>  #ifdef CONFIG_MEMCG
>  	struct pglist_data *pgdat;
>  #endif
> diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
> new file mode 100644
> index 000000000000..0de640cb1ef0
> --- /dev/null
> +++ b/include/linux/workingset_report.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_WORKINGSET_REPORT_H
> +#define _LINUX_WORKINGSET_REPORT_H
> +
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +
> +struct mem_cgroup;
> +struct pglist_data;
> +struct node;
> +struct lruvec;
> +
> +#ifdef CONFIG_WORKINGSET_REPORT
> +
> +#define WORKINGSET_REPORT_MIN_NR_BINS 2
> +#define WORKINGSET_REPORT_MAX_NR_BINS 32
> +
> +#define WORKINGSET_INTERVAL_MAX ((unsigned long)-1)
> +#define ANON_AND_FILE 2
> +
> +struct wsr_report_bin {
> +	unsigned long idle_age;
> +	unsigned long nr_pages[ANON_AND_FILE];
> +};
> +
> +struct wsr_report_bins {
> +	unsigned long nr_bins;
> +	/* last bin contains WORKINGSET_INTERVAL_MAX */
> +	struct wsr_report_bin bins[WORKINGSET_REPORT_MAX_NR_BINS];
> +};
> +
> +struct wsr_page_age_histo {
> +	unsigned long timestamp;
> +	struct wsr_report_bins bins;
> +};
> +
> +struct wsr_state {
> +	/* breakdown of workingset by page age */
> +	struct mutex page_age_lock;
> +	struct wsr_page_age_histo *page_age;
> +};
> +
> +void wsr_init(struct lruvec *lruvec);
> +void wsr_destroy(struct lruvec *lruvec);
> +
> +/*
> + * Returns true if the wsr is configured to be refreshed.
> + * The next refresh time is stored in refresh_time.
> + */
> +bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
> +			struct pglist_data *pgdat);
> +void wsr_register_node(struct node *node);
> +void wsr_unregister_node(struct node *node);
> +#else
> +static inline void wsr_init(struct lruvec *lruvec)
> +{
> +}
> +static inline void wsr_destroy(struct lruvec *lruvec)
> +{
> +}
> +static inline void wsr_register_node(struct node *node)
> +{
> +}
> +static inline void wsr_unregister_node(struct node *node)
> +{
> +}
> +#endif /* CONFIG_WORKINGSET_REPORT */
> +
> +#endif /* _LINUX_WORKINGSET_REPORT_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ffc3a2ba3a8c..212f203b10b9 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1261,6 +1261,15 @@ config LOCK_MM_AND_FIND_VMA
>  config IOMMU_MM_DATA
>  	bool
>  
> +config WORKINGSET_REPORT
> +	bool "Working set reporting"
> +	depends on LRU_GEN && SYSFS
> +	help
> +	  Report system and per-memcg working set to userspace.
> +
> +	  This option exports stats and events giving the user more insight
> +	  into its memory working set.
> +
>  source "mm/damon/Kconfig"
>  
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index e4b5b75aaec9..57093657030d 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> +obj-$(CONFIG_WORKINGSET_REPORT) += workingset_report.o
>  ifdef CONFIG_SWAP
>  obj-$(CONFIG_MEMCG) += swap_cgroup.o
>  endif
> diff --git a/mm/internal.h b/mm/internal.h
> index f309a010d50f..5e0caba64ee4 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -198,12 +198,21 @@ extern unsigned long highest_memmap_pfn;
>  /*
>   * in mm/vmscan.c:
>   */
> +struct scan_control;
>  bool isolate_lru_page(struct page *page);
>  bool folio_isolate_lru(struct folio *folio);
>  void putback_lru_page(struct page *page);
>  void folio_putback_lru(struct folio *folio);
>  extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
>  
> +#ifdef CONFIG_WORKINGSET_REPORT
> +/*
> + * in mm/wsr.c
> + */
> +/* Requires wsr->page_age_lock held */
> +void wsr_refresh_scan(struct lruvec *lruvec);
> +#endif
> +
>  /*
>   * in mm/rmap.c:
>   */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1ed40f9d3a27..2f07141de16c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -65,6 +65,7 @@
>  #include <linux/seq_buf.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/kmemleak.h>
> +#include <linux/workingset_report.h>
>  #include "internal.h"
>  #include <net/sock.h>
>  #include <net/ip.h>
> @@ -5457,6 +5458,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  	if (!pn)
>  		return;
>  
> +	wsr_destroy(&pn->lruvec);
>  	free_percpu(pn->lruvec_stats_percpu);
>  	kfree(pn);
>  }
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index c01896eca736..efca44c1b84b 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -90,6 +90,8 @@ void lruvec_init(struct lruvec *lruvec)
>  	 */
>  	list_del(&lruvec->lists[LRU_UNEVICTABLE]);
>  
> +	wsr_init(lruvec);
> +
>  	lru_gen_init_lruvec(lruvec);
>  }
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1a7c7d537db6..b694d80ab2d1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -56,6 +56,7 @@
>  #include <linux/khugepaged.h>
>  #include <linux/rculist_nulls.h>
>  #include <linux/random.h>
> +#include <linux/workingset_report.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -3815,7 +3816,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
>  	return success;
>  }
>  
> -static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
> +bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
>  			       struct scan_control *sc, bool can_swap, bool force_scan)

It appears that this change isn't necessary.

>  {
>  	bool success;
> @@ -5606,6 +5607,8 @@ static int __init init_lru_gen(void)
>  	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
>  		pr_err("lru_gen: failed to create sysfs group\n");
>  
> +	wsr_register_node(NULL);
> +
>  	debugfs_create_file("lru_gen", 0644, NULL, NULL, &lru_gen_rw_fops);
>  	debugfs_create_file("lru_gen_full", 0444, NULL, NULL, &lru_gen_ro_fops);
>  
> @@ -5613,6 +5616,35 @@ static int __init init_lru_gen(void)
>  };
>  late_initcall(init_lru_gen);
>  
> +/******************************************************************************
> + *                          workingset reporting
> + ******************************************************************************/
> +#ifdef CONFIG_WORKINGSET_REPORT
> +void wsr_refresh_scan(struct lruvec *lruvec)
> +{
> +	DEFINE_MAX_SEQ(lruvec);
> +	struct scan_control sc = {
> +		.may_writepage = true,
> +		.may_unmap = true,
> +		.may_swap = true,
> +		.proactive = true,
> +		.reclaim_idx = MAX_NR_ZONES - 1,
> +		.gfp_mask = GFP_KERNEL,
> +	};
> +	unsigned int flags;
> +
> +	set_task_reclaim_state(current, &sc.reclaim_state);
> +	flags = memalloc_noreclaim_save();
> +	/*
> +	 * setting can_swap=true and force_scan=true ensures
> +	 * proper workingset stats when the system cannot swap.
> +	 */
> +	try_to_inc_max_seq(lruvec, max_seq, &sc, true, true);
> +	memalloc_noreclaim_restore(flags);
> +	set_task_reclaim_state(current, NULL);
> +}
> +#endif /* CONFIG_WORKINGSET_REPORT */
> +
>  #else /* !CONFIG_LRU_GEN */
>  
>  static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
> diff --git a/mm/workingset_report.c b/mm/workingset_report.c
> new file mode 100644
> index 000000000000..98cdaffcb6b4
> --- /dev/null
> +++ b/mm/workingset_report.c
> @@ -0,0 +1,413 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +#include <linux/export.h>
> +#include <linux/lockdep.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernfs.h>
> +#include <linux/memcontrol.h>
> +#include <linux/rcupdate.h>
> +#include <linux/mutex.h>
> +#include <linux/err.h>
> +#include <linux/atomic.h>
> +#include <linux/node.h>
> +#include <linux/mmzone.h>
> +#include <linux/mm.h>
> +#include <linux/mm_inline.h>
> +#include <linux/workingset_report.h>
> +
> +#include "internal.h"
> +
> +void wsr_init(struct lruvec *lruvec)
> +{
> +	struct wsr_state *wsr = &lruvec->wsr;
> +
> +	memset(wsr, 0, sizeof(*wsr));
> +	mutex_init(&wsr->page_age_lock);
> +}
> +
> +void wsr_destroy(struct lruvec *lruvec)
> +{
> +	struct wsr_state *wsr = &lruvec->wsr;
> +
> +	mutex_destroy(&wsr->page_age_lock);
> +	kfree(wsr->page_age);
> +	memset(wsr, 0, sizeof(*wsr));
> +}
> +
> +static int workingset_report_intervals_parse(char *src,
> +				      struct wsr_report_bins *bins)
> +{
> +	int err = 0, i = 0;
> +	char *cur, *next = strim(src);
> +
> +	if (*next == '\0')
> +		return 0;
> +
> +	while ((cur = strsep(&next, ","))) {
> +		unsigned int interval;
> +
> +		err = kstrtouint(cur, 0, &interval);
> +		if (err)
> +			goto out;
> +
> +		bins->bins[i].idle_age = msecs_to_jiffies(interval);
> +		if (i > 0 && bins->bins[i].idle_age <= bins->bins[i - 1].idle_age) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (++i == WORKINGSET_REPORT_MAX_NR_BINS) {
> +			err = -ERANGE;
> +			goto out;
> +		}
> +	}
> +
> +	if (i && i < WORKINGSET_REPORT_MIN_NR_BINS - 1) {
> +		err = -ERANGE;
> +		goto out;
> +	}
> +
> +	bins->nr_bins = i;
> +	bins->bins[i].idle_age = WORKINGSET_INTERVAL_MAX;
> +out:
> +	return err ?: i;
> +}
> +
> +static unsigned long get_gen_start_time(const struct lru_gen_folio *lrugen,
> +					unsigned long seq,
> +					unsigned long max_seq,
> +					unsigned long curr_timestamp)
> +{
> +	int younger_gen;
> +
> +	if (seq == max_seq)
> +		return curr_timestamp;
> +	younger_gen = lru_gen_from_seq(seq + 1);
> +	return READ_ONCE(lrugen->timestamps[younger_gen]);
> +}
> +
> +static void collect_page_age_type(const struct lru_gen_folio *lrugen,
> +				  struct wsr_report_bin *bin,
> +				  unsigned long max_seq, unsigned long min_seq,
> +				  unsigned long curr_timestamp, int type)
> +{
> +	unsigned long seq;
> +
> +	for (seq = max_seq; seq + 1 > min_seq; seq--) {
> +		int gen, zone;
> +		unsigned long gen_end, gen_start, size = 0;
> +
> +		gen = lru_gen_from_seq(seq);
> +
> +		for (zone = 0; zone < MAX_NR_ZONES; zone++)
> +			size += max(
> +				READ_ONCE(lrugen->nr_pages[gen][type][zone]),
> +				0L);
> +
> +		gen_start = get_gen_start_time(lrugen, seq, max_seq,
> +					       curr_timestamp);
> +		gen_end = READ_ONCE(lrugen->timestamps[gen]);
> +
> +		while (bin->idle_age != WORKINGSET_INTERVAL_MAX &&
> +		       time_before(gen_end + bin->idle_age, curr_timestamp)) {
> +			unsigned long gen_in_bin = (long)gen_start -
> +						   (long)curr_timestamp +
> +						   (long)bin->idle_age;
> +			unsigned long gen_len = (long)gen_start - (long)gen_end;
> +
> +			if (!gen_len)
> +				break;
> +			if (gen_in_bin) {
> +				unsigned long split_bin =
> +					size / gen_len * gen_in_bin;
> +
> +				bin->nr_pages[type] += split_bin;
> +				size -= split_bin;
> +			}
> +			gen_start = curr_timestamp - bin->idle_age;
> +			bin++;
> +		}
> +		bin->nr_pages[type] += size;
> +	}
> +}
> +
> +/*
> + * proportionally aggregate Multi-gen LRU bins into a working set report
> + * MGLRU generations:
> + * current time
> + * |         max_seq timestamp
> + * |         |     max_seq - 1 timestamp
> + * |         |     |               unbounded
> + * |         |     |               |
> + * --------------------------------
> + * | max_seq | ... | ... | min_seq
> + * --------------------------------
> + *
> + * Bins:
> + *
> + * current time
> + * |       current - idle_age[0]
> + * |       |     current - idle_age[1]
> + * |       |     |               unbounded
> + * |       |     |               |
> + * ------------------------------
> + * | bin 0 | ... | ... | bin n-1
> + * ------------------------------
> + *
> + * Assume the heuristic that pages are in the MGLRU generation
> + * through uniform accesses, so we can aggregate them
> + * proportionally into bins.
> + */
> +static void collect_page_age(struct wsr_page_age_histo *page_age,
> +			     const struct lruvec *lruvec)
> +{
> +	int type;
> +	const struct lru_gen_folio *lrugen = &lruvec->lrugen;
> +	unsigned long curr_timestamp = jiffies;
> +	unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
> +	unsigned long min_seq[ANON_AND_FILE] = {
> +		READ_ONCE(lruvec->lrugen.min_seq[LRU_GEN_ANON]),
> +		READ_ONCE(lruvec->lrugen.min_seq[LRU_GEN_FILE]),
> +	};
> +	struct wsr_report_bins *bins = &page_age->bins;
> +
> +	for (type = 0; type < ANON_AND_FILE; type++) {
> +		struct wsr_report_bin *bin = &bins->bins[0];
> +
> +		collect_page_age_type(lrugen, bin, max_seq, min_seq[type],
> +				      curr_timestamp, type);
> +	}
> +}
> +
> +/* First step: hierarchically scan child memcgs. */
> +static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
> +			 struct pglist_data *pgdat)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	memcg = mem_cgroup_iter(root, NULL, NULL);
> +	do {
> +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +
> +		wsr_refresh_scan(lruvec);
> +		cond_resched();
> +	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
> +}
> +
> +/* Second step: aggregate child memcgs into the page age histogram. */
> +static void refresh_aggregate(struct wsr_page_age_histo *page_age,
> +			      struct mem_cgroup *root,
> +			      struct pglist_data *pgdat)
> +{
> +	struct mem_cgroup *memcg;
> +	struct wsr_report_bin *bin;
> +
> +	/*
> +	 * page_age_intervals should free the page_age struct
> +	 * if no intervals are provided.
> +	 */
> +	VM_WARN_ON_ONCE(page_age->bins.bins[0].idle_age ==
> +			WORKINGSET_INTERVAL_MAX);
> +
> +	for (bin = page_age->bins.bins;
> +	     bin->idle_age != WORKINGSET_INTERVAL_MAX; bin++) {
> +		bin->nr_pages[0] = 0;
> +		bin->nr_pages[1] = 0;
> +	}
> +	/* the last used bin has idle_age == WORKINGSET_INTERVAL_MAX. */
> +	bin->nr_pages[0] = 0;
> +	bin->nr_pages[1] = 0;
> +
> +	memcg = mem_cgroup_iter(root, NULL, NULL);
> +	do {
> +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +
> +		collect_page_age(page_age, lruvec);
> +		cond_resched();
> +	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
> +	WRITE_ONCE(page_age->timestamp, jiffies);
> +}
> +
> +bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
> +			struct pglist_data *pgdat)
> +{
> +	struct wsr_page_age_histo *page_age;
> +
> +	if (!READ_ONCE(wsr->page_age))
> +		return false;
> +
> +	refresh_scan(wsr, root, pgdat);
> +	mutex_lock(&wsr->page_age_lock);
> +	page_age = READ_ONCE(wsr->page_age);
> +	if (page_age)
> +		refresh_aggregate(page_age, root, pgdat);
> +	mutex_unlock(&wsr->page_age_lock);
> +	return !!page_age;
> +}
> +EXPORT_SYMBOL_GPL(wsr_refresh_report);
> +
> +static struct pglist_data *kobj_to_pgdat(struct kobject *kobj)
> +{
> +	int nid = IS_ENABLED(CONFIG_NUMA) ? kobj_to_dev(kobj)->id :
> +					    first_memory_node;
> +
> +	return NODE_DATA(nid);
> +}
> +
> +static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
> +{
> +	return &mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj))->wsr;
> +}
> +
> +static ssize_t page_age_intervals_show(struct kobject *kobj,
> +				       struct kobj_attribute *attr, char *buf)
> +{
> +	int len = 0;
> +	struct wsr_state *wsr = kobj_to_wsr(kobj);
> +
> +	mutex_lock(&wsr->page_age_lock);
> +
> +	if (!!wsr->page_age) {
> +		int i;
> +		int nr_bins = wsr->page_age->bins.nr_bins;
> +
> +		for (i = 0; i < nr_bins; ++i) {
> +			struct wsr_report_bin *bin =
> +				&wsr->page_age->bins.bins[i];
> +
> +			len += sysfs_emit_at(buf, len, "%u",
> +					     jiffies_to_msecs(bin->idle_age));
> +			if (i + 1 < nr_bins)
> +				len += sysfs_emit_at(buf, len, ",");
> +		}
> +	}
> +	len += sysfs_emit_at(buf, len, "\n");
> +
> +	mutex_unlock(&wsr->page_age_lock);
> +	return len;
> +}
> +
> +static ssize_t page_age_intervals_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *src, size_t len)
> +{
> +	struct wsr_page_age_histo *page_age = NULL, *old;
> +	char *buf = NULL;
> +	int err = 0;
> +	struct wsr_state *wsr = kobj_to_wsr(kobj);
> +
> +	buf = kstrdup(src, GFP_KERNEL);
> +	if (!buf) {
> +		err = -ENOMEM;
> +		goto failed;
> +	}
> +
> +	page_age =
> +		kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL_ACCOUNT);
> +
> +	if (!page_age) {
> +		err = -ENOMEM;
> +		goto failed;
> +	}
> +
> +	err = workingset_report_intervals_parse(buf, &page_age->bins);
> +	if (err < 0)
> +		goto failed;
> +
> +	if (err == 0) {
> +		kfree(page_age);
> +		page_age = NULL;
> +	}
> +
> +	mutex_lock(&wsr->page_age_lock);
> +	old = xchg(&wsr->page_age, page_age);
> +	mutex_unlock(&wsr->page_age_lock);
> +	kfree(old);
> +	kfree(buf);
> +	return len;
> +failed:
> +	kfree(page_age);
> +	kfree(buf);
> +
> +	return err;
> +}
> +
> +static struct kobj_attribute page_age_intervals_attr =
> +	__ATTR_RW(page_age_intervals);
> +
> +static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			     char *buf)
> +{
> +	struct wsr_report_bin *bin;
> +	int ret = 0;
> +	struct wsr_state *wsr = kobj_to_wsr(kobj);
> +
> +	if (!READ_ONCE(wsr->page_age))
> +		return -EINVAL;
> +
> +	wsr_refresh_report(wsr, NULL, kobj_to_pgdat(kobj));
> +
> +	mutex_lock(&wsr->page_age_lock);
> +	if (!wsr->page_age) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	for (bin = wsr->page_age->bins.bins;
> +	     bin->idle_age != WORKINGSET_INTERVAL_MAX; bin++)
> +		ret += sysfs_emit_at(buf, ret, "%u anon=%lu file=%lu\n",
> +				     jiffies_to_msecs(bin->idle_age),
> +				     bin->nr_pages[0] * PAGE_SIZE,
> +				     bin->nr_pages[1] * PAGE_SIZE);
> +
> +	ret += sysfs_emit_at(buf, ret, "%lu anon=%lu file=%lu\n",
> +			     WORKINGSET_INTERVAL_MAX,
> +			     bin->nr_pages[0] * PAGE_SIZE,
> +			     bin->nr_pages[1] * PAGE_SIZE);
> +
> +unlock:
> +	mutex_unlock(&wsr->page_age_lock);
> +	return ret;
> +}
> +
> +static struct kobj_attribute page_age_attr = __ATTR_RO(page_age);
> +
> +static struct attribute *workingset_report_attrs[] = {
> +	&page_age_intervals_attr.attr, &page_age_attr.attr, NULL
> +};
> +
> +static const struct attribute_group workingset_report_attr_group = {
> +	.name = "workingset_report",
> +	.attrs = workingset_report_attrs,
> +};
> +
> +void wsr_register_node(struct node *node)
> +{
> +	struct kobject *kobj = node ? &node->dev.kobj : mm_kobj;
> +	struct wsr_state *wsr;
> +
> +	if (IS_ENABLED(CONFIG_NUMA) && !node)
> +		return;
> +
> +	wsr = kobj_to_wsr(kobj);
> +
> +	if (sysfs_create_group(kobj, &workingset_report_attr_group)) {
> +		pr_warn("WSR failed to created group");
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(wsr_register_node);
> +
> +void wsr_unregister_node(struct node *node)
> +{
> +	struct kobject *kobj = &node->dev.kobj;
> +	struct wsr_state *wsr;
> +
> +	if (IS_ENABLED(CONFIG_NUMA) && !node)
> +		return;
> +
> +	wsr = kobj_to_wsr(kobj);
> +	sysfs_remove_group(kobj, &workingset_report_attr_group);
> +	wsr_destroy(mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj)));
> +}
> +EXPORT_SYMBOL_GPL(wsr_unregister_node);

--
Best Regards,
Huang, Ying

