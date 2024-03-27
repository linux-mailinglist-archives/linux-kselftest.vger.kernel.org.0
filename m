Return-Path: <linux-kselftest+bounces-6740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4FB88F0FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 22:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114BAB22AF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E06154BE7;
	Wed, 27 Mar 2024 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4VehKRhS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5C153BC9
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575102; cv=none; b=C3n29yeK1wabbUKviso8C3EHGIAhCc4VE/A0GeKXCpjMDgM40Pg0PMMWPz/G5W5Zg/3sdjhqvzycTVPfICZv1QZ9OiPWvJou0leQe2yfquKdpHONGpEj7zPzIpgtj202lcmIgScNS1jN6PYiBe2ygAUuQ8NNW9ctvM8g4nxqniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575102; c=relaxed/simple;
	bh=9iofqq5XqTy0xSzgNBoBMiZSw9jPsidndoirLIq9dec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VJWNWa8RNdZQAvv6RtCKNsfl5ZYhKCiWNVqND4QHHOKL2vkH6o2zh0G11x7PwF3IEtYuAhJCRA/RS4uJ35DHG9tgAaXb3/kKUl20qqV+W0yA4VO7x/YZ7XAm7X9gD37ICXfUYQTkHoiV8ZdHWx+s500tCiii+pwjg66Uoir45tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4VehKRhS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fe93b5cfso5276757b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575099; x=1712179899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYcWZ+uvnfpBRrJgdHxDGPK9xqtHO7VyC+05VAboBBI=;
        b=4VehKRhSB8dvrqwQqUXbhCMsh8DX0Hw70BAR8m9ymXpcN+zL/DJDc+is9au7vGlKuA
         dePcM174kofMfyyxRuiMAL8eDg3DaI/N/j8b/ip8A3VnIPTLiRIf4k3jUhE28nV4TLdT
         C5LksHQy7mW9FOZtBYCJLfsKXgGvq0lHV0IpeA5OLsg9N3Pm7yF876qaHqg31OtTpe7u
         Jm5dMrMe8qSzPzIlCala4tHA1OfjXg1+/uybudErfrSPvK+TyKqxjvvgsoOcp6qnv1n7
         d7lWYEm/GgRBg1hTOYZtzFGYEibDgkc841QTpm1nySwlEiqFvTy9creeQmU28QKFL9wr
         BWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575099; x=1712179899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYcWZ+uvnfpBRrJgdHxDGPK9xqtHO7VyC+05VAboBBI=;
        b=sB9S5CtAuYUpVgc+3wDAMVlwT9wYsLnHGF/6I5Vr+gk5qrzAkFn/8wFZdjCiqR6bZ0
         A15MkCUWA1Z+OLrLI0uTXgpUEsvBOSnuqZd1Prqn/BADk6u1ago6QjSxJwDrRAY556KR
         x7bH5MRgiwwWGQqWz1m2h4t1OPuui4LPBOS9sfJTFTfJJvm119O6xRXe9E6rUex5vxaz
         0E75zr8TpAWj4QgKujeU3cwVejGdRPbc3r2vydrFWMi1iJqvZBp9hr/C4TTRxOoGz4hm
         H26gFS5ptpSAN1Got9kJ4b6lA9min1Za/P1rJFfeGuVUQEAM5CfyJDT6T4+Rn3vR820O
         knvg==
X-Forwarded-Encrypted: i=1; AJvYcCW0dAc8vtsEMoAqLiDR7zakdSSFNoEICh3npD2Vg4x0DgeRTT0cirVh3P+ITvlhNKCXpohiAgZ2En9iP3GIflqJgS7vi+NiaVn8rxNdU1Xu
X-Gm-Message-State: AOJu0YzBqV0vNzSqdVdo0J5N29qyXmwGxn5TPMQ5CjGq5oyIGgOE1NaC
	iCIsfMbQ/475uzWkpi16qP9MxzQ/ZdGWhx9QB+LcThUhlsfuxeR0Ed48Z/O3JVPUwclYFXphxCh
	O7yL5Ow==
X-Google-Smtp-Source: AGHT+IH29n/bXDk4V5f6G2KmwU71qUf9qBBJl3gumyEah4UzaOtBiCsSyfr3pIgcLollPnQRaMOx5Jjvfzl5
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6df3:ef42:a58e:a6b1])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:2088:b0:dc6:e20f:80cb with SMTP
 id di8-20020a056902208800b00dc6e20f80cbmr89815ybb.3.1711575099385; Wed, 27
 Mar 2024 14:31:39 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:31:05 -0700
In-Reply-To: <20240327213108.2384666-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327213108.2384666-1-yuanchu@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327213108.2384666-7-yuanchu@google.com>
Subject: [RFC PATCH v3 6/8] mm: add per-memcg reaccess histogram
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
Cc: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, Kairui Song <kasong@tencent.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A reaccess refers to detecting an access on a page via refault
or access bit harvesting after the initial access. Similar to
the working set histogram, the reaccess histogram breaks down
reaccesses into user-defined bins.

It tracks reaccesses from MGLRU walks, where a move from older
generations to the young generation counts as a reaccess.
Swapped out pages are tracked with the generation number
encoded in mm/workingset.c, and additional tracking is added
for enabled memory cgroups to track an additional 4 swapped out
generations.

Memcg interfaces:
/sys/fs/cgroup/.../memory.workingset.reaccess
	The format is identical to memory.workingset.page_age, but the
	content breaks down reaccesses into pre-defined intervals.
	e.g.
	N0
	1000 anon=6330 file=0
	2000 anon=72 file=0
	4000 anon=0 file=0
	18446744073709551615 anon=0 file=0
	N1
	18446744073709551615 anon=0 file=0

/sys/fs/cgroup/.../memory.workingset.reaccess_intervals
	Defines the per-node intervals for memory.workingset.reaccess.
	e.g.
	echo N0=120000,240000,480000 > memory.workingset.reaccess_intervals

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/workingset_report.h |  20 +++
 mm/internal.h                     |  28 ++++
 mm/memcontrol.c                   | 112 ++++++++++++++
 mm/vmscan.c                       |   8 +-
 mm/workingset.c                   |   9 +-
 mm/workingset_report.c            | 249 ++++++++++++++++++++++++++++++
 6 files changed, 419 insertions(+), 7 deletions(-)

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index 502542c812b3..e908c5678b1e 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/rcutree.h>
 
 struct mem_cgroup;
 struct pglist_data;
@@ -19,6 +20,12 @@ struct cgroup_file;
 #define WORKINGSET_INTERVAL_MAX ((unsigned long)-1)
 #define ANON_AND_FILE 2
 
+/*
+ * MAX_NR_EVICTED_GENS is set to 4 so we can track the same number of
+ * generations as MGLRU has resident.
+ */
+#define MAX_NR_EVICTED_GENS 4
+
 struct wsr_report_bin {
 	unsigned long idle_age;
 	unsigned long nr_pages[ANON_AND_FILE];
@@ -35,6 +42,18 @@ struct wsr_page_age_histo {
 	struct wsr_report_bins bins;
 };
 
+struct wsr_evicted_gen {
+	unsigned long timestamp;
+	int seq;
+};
+
+struct wsr_reaccess_histo {
+	struct rcu_head rcu;
+	/* evicted gens start from min_seq[LRU_GEN_ANON] - 1 */
+	struct wsr_evicted_gen gens[MAX_NR_EVICTED_GENS];
+	struct wsr_report_bins bins;
+};
+
 struct wsr_state {
 	unsigned long report_threshold;
 	unsigned long refresh_interval;
@@ -47,6 +66,7 @@ struct wsr_state {
 	/* breakdown of workingset by page age */
 	struct mutex page_age_lock;
 	struct wsr_page_age_histo *page_age;
+	struct wsr_reaccess_histo __rcu *reaccess;
 };
 
 void wsr_init(struct lruvec *lruvec);
diff --git a/mm/internal.h b/mm/internal.h
index 3730c8399ad4..077340b526e8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -205,16 +205,44 @@ void putback_lru_page(struct page *page);
 void folio_putback_lru(struct folio *folio);
 extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
 
+/*
+ * in mm/workingset.c
+ */
+#define WORKINGSET_SHIFT 1
+#define EVICTION_SHIFT	((BITS_PER_LONG - BITS_PER_XA_VALUE) +	\
+			 WORKINGSET_SHIFT + NODES_SHIFT + \
+			 MEM_CGROUP_ID_SHIFT)
+#define EVICTION_MASK	(~0UL >> EVICTION_SHIFT)
+
 #ifdef CONFIG_WORKINGSET_REPORT
 /*
  * in mm/wsr.c
  */
+void report_lru_gen_eviction(struct lruvec *lruvec, int type, int min_seq);
+void lru_gen_report_reaccess(struct lruvec *lruvec,
+			     struct lru_gen_mm_walk *walk);
+void report_reaccess_refault(struct lruvec *lruvec, unsigned long token,
+			     int type, int nr_pages);
 void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat);
 /* Requires wsr->page_age_lock held */
 void wsr_refresh_scan(struct lruvec *lruvec, unsigned long refresh_interval);
 int workingset_report_intervals_parse(char *src,
 				      struct wsr_report_bins *bins);
 #else
+struct lru_gen_mm_walk;
+static inline void report_lru_gen_eviction(struct lruvec *lruvec, int type,
+					   int min_seq)
+{
+}
+static inline void lru_gen_report_reaccess(struct lruvec *lruvec,
+					   struct lru_gen_mm_walk *walk)
+{
+}
+static inline void report_reaccess_refault(struct lruvec *lruvec,
+					   unsigned long token, int type,
+					   int nr_pages)
+{
+}
 static inline void notify_workingset(struct mem_cgroup *memcg,
 				     struct pglist_data *pgdat)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75bda5f7994d..2a39a4445bb7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7108,6 +7108,71 @@ static ssize_t memory_ws_page_age_intervals_write(struct kernfs_open_file *of,
 	return err;
 }
 
+static int memory_ws_reaccess_intervals_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr_state *wsr;
+		struct wsr_reaccess_histo *reaccess;
+		int i, nr_bins;
+
+		wsr = &mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+		rcu_read_lock();
+		reaccess = rcu_dereference(wsr->reaccess);
+		if (!reaccess)
+			goto unlock;
+		seq_printf(m, "N%d=", nid);
+		nr_bins = reaccess->bins.nr_bins;
+		for (i = 0; i < nr_bins; ++i) {
+			struct wsr_report_bin *bin = &reaccess->bins.bins[i];
+
+			seq_printf(m, "%u", jiffies_to_msecs(bin->idle_age));
+			if (i + 1 < nr_bins)
+				seq_putc(m, ',');
+		}
+		seq_putc(m, ' ');
+unlock:
+		rcu_read_unlock();
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_ws_reaccess_intervals_write(struct kernfs_open_file *of,
+						  char *buf, size_t nbytes,
+						  loff_t off)
+{
+	unsigned int nid;
+	int err;
+	struct wsr_state *wsr;
+	struct wsr_reaccess_histo *reaccess = NULL, *old;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	reaccess = kzalloc(sizeof(struct wsr_reaccess_histo), GFP_KERNEL);
+	if (!reaccess)
+		return -ENOMEM;
+
+	err = memory_wsr_interval_parse(of, buf, nbytes, &nid, &reaccess->bins);
+	if (err < 0)
+		goto failed;
+
+	if (err == 0) {
+		kfree(reaccess);
+		reaccess = NULL;
+	}
+
+	wsr = &mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+	old = xchg(&wsr->reaccess, reaccess);
+	kfree_rcu(old, rcu);
+	return nbytes;
+failed:
+	kfree(reaccess);
+	return err;
+}
+
 static int memory_ws_refresh_interval_show(struct seq_file *m, void *v)
 {
 	int nid;
@@ -7242,6 +7307,42 @@ static int memory_ws_page_age_show(struct seq_file *m, void *v)
 
 	return 0;
 }
+
+static int memory_ws_reaccess_histogram_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr_state *wsr =
+			&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+		struct wsr_reaccess_histo *reaccess;
+		struct wsr_report_bin *bin;
+
+		rcu_read_lock();
+		reaccess = rcu_dereference(wsr->reaccess);
+
+		if (!reaccess)
+			goto unlock;
+
+		wsr_refresh_report(wsr, memcg, NODE_DATA(nid));
+
+		seq_printf(m, "N%d\n", nid);
+		for (bin = reaccess->bins.bins;
+		     bin->idle_age != WORKINGSET_INTERVAL_MAX; bin++)
+			seq_printf(m, "%u anon=%lu file=%lu\n",
+				   jiffies_to_msecs(bin->idle_age),
+				   bin->nr_pages[0], bin->nr_pages[1]);
+
+		seq_printf(m, "%lu anon=%lu file=%lu\n", WORKINGSET_INTERVAL_MAX,
+			   bin->nr_pages[0], bin->nr_pages[1]);
+
+unlock:
+		rcu_read_unlock();
+	}
+
+	return 0;
+}
 #endif
 
 static struct cftype memory_files[] = {
@@ -7337,6 +7438,17 @@ static struct cftype memory_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, workingset_page_age_file),
 		.seq_show = memory_ws_page_age_show,
 	},
+	{
+		.name = "workingset.reaccess_intervals",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_ws_reaccess_intervals_show,
+		.write = memory_ws_reaccess_intervals_write,
+	},
+	{
+		.name = "workingset.reaccess",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_ws_reaccess_histogram_show,
+	},
 #endif
 	{} /* terminate */
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6acd5265b3f..4d9245e2c0d1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3637,6 +3637,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 		mem_cgroup_unlock_pages();
 
 		if (walk->batched) {
+			lru_gen_report_reaccess(lruvec, walk);
 			spin_lock_irq(&lruvec->lru_lock);
 			reset_batch_size(lruvec, walk);
 			spin_unlock_irq(&lruvec->lru_lock);
@@ -3709,6 +3710,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 	}
 done:
 	reset_ctrl_pos(lruvec, type, true);
+	report_lru_gen_eviction(lruvec, type, lrugen->min_seq[type] + 1);
 	WRITE_ONCE(lrugen->min_seq[type], lrugen->min_seq[type] + 1);
 
 	return true;
@@ -3750,6 +3752,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
 			continue;
 
 		reset_ctrl_pos(lruvec, type, true);
+		report_lru_gen_eviction(lruvec, type, min_seq[type]);
 		WRITE_ONCE(lrugen->min_seq[type], min_seq[type]);
 		success = true;
 	}
@@ -4565,11 +4568,14 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		sc->nr_scanned -= folio_nr_pages(folio);
 	}
 
+	walk = current->reclaim_state->mm_walk;
+	if (walk && walk->batched)
+		lru_gen_report_reaccess(lruvec, walk);
+
 	spin_lock_irq(&lruvec->lru_lock);
 
 	move_folios_to_lru(lruvec, &list);
 
-	walk = current->reclaim_state->mm_walk;
 	if (walk && walk->batched)
 		reset_batch_size(lruvec, walk);
 
diff --git a/mm/workingset.c b/mm/workingset.c
index 226012974328..057fbedd91ea 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -17,6 +17,8 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 
+#include "internal.h"
+
 /*
  *		Double CLOCK lists
  *
@@ -179,12 +181,6 @@
  * refault distance will immediately activate the refaulting page.
  */
 
-#define WORKINGSET_SHIFT 1
-#define EVICTION_SHIFT	((BITS_PER_LONG - BITS_PER_XA_VALUE) +	\
-			 WORKINGSET_SHIFT + NODES_SHIFT + \
-			 MEM_CGROUP_ID_SHIFT)
-#define EVICTION_MASK	(~0UL >> EVICTION_SHIFT)
-
 /*
  * Eviction timestamps need to be able to cover the full range of
  * actionable refaults. However, bits are tight in the xarray
@@ -294,6 +290,7 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 		goto unlock;
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + type, delta);
+	report_reaccess_refault(lruvec, token, type, delta);
 
 	if (!recent)
 		goto unlock;
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index b00ffbfebcab..504d840bbe6a 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -34,6 +34,7 @@ void wsr_destroy(struct lruvec *lruvec)
 
 	mutex_destroy(&wsr->page_age_lock);
 	kfree(wsr->page_age);
+	kfree_rcu(wsr->reaccess, rcu);
 	memset(wsr, 0, sizeof(*wsr));
 }
 
@@ -259,6 +260,254 @@ bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
 }
 EXPORT_SYMBOL_GPL(wsr_refresh_report);
 
+static void lru_gen_collect_reaccess_refault(struct wsr_report_bins *bins,
+					     unsigned long timestamp, int type,
+					     int nr_pages)
+{
+	unsigned long curr_timestamp = jiffies;
+	struct wsr_report_bin *bin = &bins->bins[0];
+
+	while (bin->idle_age != WORKINGSET_INTERVAL_MAX &&
+	       time_before(timestamp + bin->idle_age, curr_timestamp))
+		bin++;
+
+	bin->nr_pages[type] += nr_pages;
+}
+
+static void collect_reaccess_type(struct lru_gen_mm_walk *walk,
+				  const struct lru_gen_folio *lrugen,
+				  struct wsr_report_bin *bin,
+				  unsigned long max_seq, unsigned long min_seq,
+				  unsigned long curr_timestamp, int type)
+{
+	unsigned long seq;
+
+	/* Skip max_seq because a reaccess moves a page from another seq
+	 * to max_seq. We use the negative change in page count from
+	 * other seqs to track the number of reaccesses.
+	 */
+	for (seq = max_seq - 1; seq + 1 > min_seq; seq--) {
+		int younger_gen, gen, zone;
+		unsigned long gen_end, gen_start;
+		long delta = 0;
+
+		gen = lru_gen_from_seq(seq);
+
+		for (zone = 0; zone < MAX_NR_ZONES; zone++) {
+			long nr_pages = walk->nr_pages[gen][type][zone];
+
+			if (nr_pages < 0)
+				delta += -nr_pages;
+		}
+
+		gen_end = READ_ONCE(lrugen->timestamps[gen]);
+		younger_gen = lru_gen_from_seq(seq + 1);
+		gen_start = READ_ONCE(lrugen->timestamps[younger_gen]);
+
+		/* ensure gen_start is within idle_age of bin */
+		while (bin->idle_age != WORKINGSET_INTERVAL_MAX &&
+		       time_before(gen_start + bin->idle_age, curr_timestamp))
+			bin++;
+
+		while (bin->idle_age != WORKINGSET_INTERVAL_MAX &&
+		       time_before(gen_end + bin->idle_age, curr_timestamp)) {
+			unsigned long proportion = (long)gen_start -
+						   (long)curr_timestamp +
+						   (long)bin->idle_age;
+			unsigned long gen_len = (long)gen_start - (long)gen_end;
+
+			if (!gen_len)
+				break;
+			if (proportion) {
+				unsigned long split_bin =
+					delta / gen_len * proportion;
+				bin->nr_pages[type] += split_bin;
+				delta -= split_bin;
+			}
+			gen_start = curr_timestamp - bin->idle_age;
+			bin++;
+		}
+		bin->nr_pages[type] += delta;
+	}
+}
+
+/*
+ * Reaccesses are propagated up the memcg hierarchy during scanning/refault.
+ * Collect the reaccess information from a multi-gen LRU walk.
+ */
+static void lru_gen_collect_reaccess(struct wsr_report_bins *bins,
+				     struct lru_gen_folio *lrugen,
+				     struct lru_gen_mm_walk *walk)
+{
+	int type;
+	unsigned long curr_timestamp = jiffies;
+	unsigned long max_seq = READ_ONCE(walk->max_seq);
+	unsigned long min_seq[ANON_AND_FILE] = {
+		READ_ONCE(lrugen->min_seq[LRU_GEN_ANON]),
+		READ_ONCE(lrugen->min_seq[LRU_GEN_FILE]),
+	};
+
+	for (type = 0; type < ANON_AND_FILE; type++) {
+		struct wsr_report_bin *bin = &bins->bins[0];
+
+		collect_reaccess_type(walk, lrugen, bin, max_seq,
+				      min_seq[type], curr_timestamp, type);
+	}
+}
+
+void lru_gen_report_reaccess(struct lruvec *lruvec, struct lru_gen_mm_walk *walk)
+{
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+
+	for (memcg = lruvec_memcg(lruvec); memcg;
+	     memcg = parent_mem_cgroup(memcg)) {
+		struct lruvec *memcg_lruvec =
+			mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
+		struct wsr_state *wsr = &memcg_lruvec->wsr;
+		struct wsr_reaccess_histo *reaccess;
+
+		rcu_read_lock();
+		reaccess = rcu_dereference(wsr->reaccess);
+		if (!reaccess) {
+			rcu_read_unlock();
+			continue;
+		}
+		lru_gen_collect_reaccess(&reaccess->bins, lrugen, walk);
+		rcu_read_unlock();
+	}
+}
+
+static inline int evicted_gen_from_seq(unsigned long seq)
+{
+	return seq % MAX_NR_EVICTED_GENS;
+}
+
+void report_lru_gen_eviction(struct lruvec *lruvec, int type, int min_seq)
+{
+	int seq;
+	struct wsr_reaccess_histo *reaccess = NULL;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	struct wsr_state *wsr = &lruvec->wsr;
+
+	/*
+	 * Since file can go ahead of anon, min_seq[file] >= min_seq[anon]
+	 * only record evictions when anon moves forward.
+	 */
+	if (type != LRU_GEN_ANON)
+		return;
+
+	/*
+	 * lru_lock is held during eviction, so reaccess accounting
+	 * can be serialized.
+	 */
+	lockdep_assert_held(&lruvec->lru_lock);
+
+	rcu_read_lock();
+	reaccess = rcu_dereference(wsr->reaccess);
+	if (!reaccess)
+		goto unlock;
+
+	for (seq = READ_ONCE(lrugen->min_seq[LRU_GEN_ANON]); seq < min_seq;
+	     ++seq) {
+		int evicted_gen = evicted_gen_from_seq(seq);
+		int gen = lru_gen_from_seq(seq);
+
+		WRITE_ONCE(reaccess->gens[evicted_gen].seq, seq);
+		WRITE_ONCE(reaccess->gens[evicted_gen].timestamp,
+			   READ_ONCE(lrugen->timestamps[gen]));
+	}
+
+unlock:
+	rcu_read_unlock();
+}
+
+/*
+ * May yield an incorrect timestamp if the token collides with
+ * a recently evicted generation.
+ */
+static int timestamp_from_workingset_token(struct lruvec *lruvec,
+					   unsigned long token,
+					   unsigned long *timestamp)
+{
+	int type, err = -EEXIST;
+	unsigned long seq, evicted_min_seq;
+	struct wsr_reaccess_histo *reaccess = NULL;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	struct wsr_state *wsr = &lruvec->wsr;
+	unsigned long min_seq[ANON_AND_FILE] = {
+		READ_ONCE(lrugen->min_seq[LRU_GEN_ANON]),
+		READ_ONCE(lrugen->min_seq[LRU_GEN_FILE])
+	};
+
+	token >>= LRU_REFS_WIDTH;
+
+	/* recent eviction */
+	for (type = 0; type < ANON_AND_FILE; ++type) {
+		if (token ==
+		    (min_seq[type] & (EVICTION_MASK >> LRU_REFS_WIDTH))) {
+			int gen = lru_gen_from_seq(min_seq[type]);
+
+			*timestamp = READ_ONCE(lrugen->timestamps[gen]);
+			return 0;
+		}
+	}
+
+	rcu_read_lock();
+	reaccess = rcu_dereference(wsr->reaccess);
+	if (!reaccess)
+		goto unlock;
+
+	/* look up in evicted gen buffer */
+	evicted_min_seq = min_seq[LRU_GEN_ANON] - MAX_NR_EVICTED_GENS;
+	if (min_seq[LRU_GEN_ANON] < MAX_NR_EVICTED_GENS)
+		evicted_min_seq = 0;
+	for (seq = min_seq[LRU_GEN_ANON]; seq > evicted_min_seq; --seq) {
+		int gen = evicted_gen_from_seq(seq - 1);
+
+		if (token == (reaccess->gens[gen].seq &
+			      (EVICTION_MASK >> LRU_REFS_WIDTH))) {
+			*timestamp = reaccess->gens[gen].timestamp;
+
+			goto unlock;
+		}
+	}
+
+unlock:
+	rcu_read_unlock();
+	return err;
+}
+
+void report_reaccess_refault(struct lruvec *lruvec, unsigned long token,
+			     int type, int nr_pages)
+{
+	unsigned long timestamp;
+	int err;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+
+	err = timestamp_from_workingset_token(lruvec, token, &timestamp);
+	if (err)
+		return;
+
+	for (memcg = lruvec_memcg(lruvec); memcg;
+	     memcg = parent_mem_cgroup(memcg)) {
+		struct lruvec *memcg_lruvec =
+			mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
+		struct wsr_state *wsr = &memcg_lruvec->wsr;
+		struct wsr_reaccess_histo *reaccess = NULL;
+
+		rcu_read_lock();
+		reaccess = rcu_dereference(wsr->reaccess);
+		if (!reaccess) {
+			rcu_read_unlock();
+			continue;
+		}
+		lru_gen_collect_reaccess_refault(&reaccess->bins, timestamp,
+						 type, nr_pages);
+		rcu_read_unlock();
+	}
+}
+
 static struct pglist_data *kobj_to_pgdat(struct kobject *kobj)
 {
 	int nid = IS_ENABLED(CONFIG_NUMA) ? kobj_to_dev(kobj)->id :
-- 
2.44.0.396.g6e790dbe36-goog


