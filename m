Return-Path: <linux-kselftest+bounces-9459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA658BB9CB
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 09:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132411F21C2A
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 07:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCDA1D52D;
	Sat,  4 May 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2l1wn0ax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8C1AACC
	for <linux-kselftest@vger.kernel.org>; Sat,  4 May 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807857; cv=none; b=o6ZjpoSJHuWKKFkozl5JZewkS+ttT6TLRMcuiawQZltfQ1Xvf2HhCI5H0ab6BmaYYQvGE18INLbYBMiNNDGZ6HPwRaOc6zEXSFNoicRfnkzL5+1U4O2+C+CWf3Pl+rpQG/rcDA6hzXFLrbhPYiyzVDccLGor2CTq+cmjDoGya8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807857; c=relaxed/simple;
	bh=MSoymEmtXwkbG+6gY++euyvnqVcaVC3DoNV/ayFTRfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pHiQVU+3nqifPe6rxMZyDFceSm/3wuQsPhYlSnQj7b52Ymwzgt4bx+YlIJBINPk03g3odRzsfXNnyc66lZzyni7edusIrKW8nMN6lj51Ef8o/Z5auf2Ldwf+ROxihzwWEC6w+p4PIcZd8tWJKrTM6Vl2YFAnrNc86ttq0yuu6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2l1wn0ax; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54ccab44aso917788276.3
        for <linux-kselftest@vger.kernel.org>; Sat, 04 May 2024 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714807854; x=1715412654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLxnf5SNOBvzXGjywTGAaG+Rg/LHUrvR7uH9tSjT/P0=;
        b=2l1wn0axjtsq5mBfXMrnHtyYOaqUFpvjrowNAI3N7f3N6ctw1Qn+nip3Gb+moA66s7
         7sM4UB+81hjXu3SVZeUURlZO2Uhrti4X6QCtjynLPUI/cLfiyn3esSKykq9qFytg6+wA
         hs/xcgExL4+f/g/BX0yOP4busbigwusRXWPDJ/WRUmc8go7DFPmI+WrNQi7RWTtgz4tR
         C41W9Db5G+/vo8ruc+hgHvWlMXkB3+Wwje7zWBG5kJok8NPYfk4Sozgr9tFzWnVVZt6I
         9cgwfJI8NOo61GnFr37IroSAImjnyXUng2tW/lovMCbuEwYyO2663Qp7oXD75Mye4Mvy
         oOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714807854; x=1715412654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLxnf5SNOBvzXGjywTGAaG+Rg/LHUrvR7uH9tSjT/P0=;
        b=llm5riPNsf/i5K3g7Hfk17h/Z8jJR6ul4nAwcyVmN/XdOtoGbxWdGK99GhNjFyY+kN
         +4BqCYdYGjCLDJAPpxwk3zdPAi3t2CC5HBzwmXBJ7rt4gTzjzVmOMjRaqYXFZ6YGybEQ
         6ogK4WxtkuKSy7LfpkpeYp96bcR+rU074sgFmF0ngJY3jkUgSqP3e/hgM9lnkDafjix/
         M8uw4coepBwCiFy/mH4woOQSYFtOIukonU0KdtTolrmvi+MqIiXqRPFVhTC3sZhE/w5F
         uFcVdLfxjqkpMniiqer7Pnq+8Fto9PP2Mqa/ACQvr3Cjn4GMgE/2vZ5yISdT1FcHJoer
         1pYw==
X-Forwarded-Encrypted: i=1; AJvYcCX7i72jaagHMf+EBbbAh02xIme/2I13DZsKBha3TtUy+47KgPqnR/e9hdYOh2MIcBuwjULRqkokw71vioLuUNJSCsQ78fkIUC8NoumY9VGX
X-Gm-Message-State: AOJu0Yxd6rOu+p73kGa8aG2BhpdcmVgG6fCfaFdH1SHxgumH/0L8TWz8
	zp+Ja2c30ey7NXrULElaEqWTqGxA19YhvFFaOPFvUt3ppnrp+X2pDchhAtZdN0N9BX8WyjcPQDU
	KTLMlSA==
X-Google-Smtp-Source: AGHT+IFMWIH0/B+L30esndwBVP4G+01F+1D+FQUWzGkdOFH/SC8SF749caf3CDFWxV8mCGfLO0eXl3n/4iIt
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:da8f:bd07:9977:eb21])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:1146:b0:de5:2325:72a1 with SMTP
 id p6-20020a056902114600b00de5232572a1mr1491589ybu.4.1714807854549; Sat, 04
 May 2024 00:30:54 -0700 (PDT)
Date: Sat,  4 May 2024 00:30:09 -0700
In-Reply-To: <20240504073011.4000534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504073011.4000534-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240504073011.4000534-6-yuanchu@google.com>
Subject: [PATCH v1 5/7] mm: extend working set reporting to memcgs
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

Break down the system-wide working set reporting into
per-memcg reports, which aggregages its children hierarchically.
The per-node working set reporting histograms and refresh/report
threshold files are presented as memcg files, showing a report
containing all the nodes.

The per-node page age interval is configurable in sysfs and not
available per-memcg, while the refresh interval and report threshold are
configured per-memcg.

Memcg interface:
/sys/fs/cgroup/.../memory.workingset.page_age
	The memcg equivalent of the sysfs workingset page age histogram,
	breaks down the workingset of this memcg and its children into
	page age intervals. Each node is prefixed with a node header and
	a newline. Non-proactive direct reclaim on this memcg can also
	wake up userspace agents that are waiting on this file.
	e.g.
	N0
	1000 anon=0 file=0
	2000 anon=0 file=0
	3000 anon=0 file=0
	4000 anon=0 file=0
	5000 anon=0 file=0
	18446744073709551615 anon=0 file=0

/sys/fs/cgroup/.../memory.workingset.refresh_interval
	The memcg equivalent of the sysfs refresh interval. A per-node
	number of how much time a page age histogram is valid for, in
	milliseconds.
	e.g.
	echo N0=2000 > memory.workingset.refresh_interval

/sys/fs/cgroup/.../memory.workingset.report_threshold
	The memcg equivalent of the sysfs report threshold. A per-node
	number of how often userspace agent waiting on the page age
	histogram can be woken up, in milliseconds.
	e.g.
	echo N0=1000 > memory.workingset.report_threshold

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/memcontrol.h        |   5 +
 include/linux/workingset_report.h |   6 +-
 mm/internal.h                     |   2 +
 mm/memcontrol.c                   | 178 +++++++++++++++++++++++++++++-
 mm/workingset_report.c            |  12 +-
 5 files changed, 198 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20ff87f8e001..7d7bc0928961 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -335,6 +335,11 @@ struct mem_cgroup {
 	struct lru_gen_mm_list mm_list;
 #endif
 
+#ifdef CONFIG_WORKINGSET_REPORT
+	/* memory.workingset.page_age file */
+	struct cgroup_file workingset_page_age_file;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index 2ec8b927b200..ae412d408037 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -9,6 +9,7 @@ struct mem_cgroup;
 struct pglist_data;
 struct node;
 struct lruvec;
+struct cgroup_file;
 
 #ifdef CONFIG_WORKINGSET_REPORT
 
@@ -40,7 +41,10 @@ struct wsr_state {
 	unsigned long report_threshold;
 	unsigned long refresh_interval;
 
-	struct kernfs_node *page_age_sys_file;
+	union {
+		struct kernfs_node *page_age_sys_file;
+		struct cgroup_file *page_age_cgroup_file;
+	};
 
 	/* breakdown of workingset by page age */
 	struct mutex page_age_lock;
diff --git a/mm/internal.h b/mm/internal.h
index 36480c7ac0dd..3730c8399ad4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -212,6 +212,8 @@ extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason
 void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat);
 /* Requires wsr->page_age_lock held */
 void wsr_refresh_scan(struct lruvec *lruvec, unsigned long refresh_interval);
+int workingset_report_intervals_parse(char *src,
+				      struct wsr_report_bins *bins);
 #else
 static inline void notify_workingset(struct mem_cgroup *memcg,
 				     struct pglist_data *pgdat)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b5b67c93c287..c6c0d2772279 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7005,6 +7005,162 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+#ifdef CONFIG_WORKINGSET_REPORT
+static int memory_ws_refresh_interval_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr_state *wsr =
+			&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+
+		seq_printf(m, "N%d=%u ", nid,
+			   jiffies_to_msecs(READ_ONCE(wsr->refresh_interval)));
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_wsr_threshold_parse(char *buf, size_t nbytes,
+					  unsigned int *nid_out,
+					  unsigned int *msecs)
+{
+	char *node, *threshold;
+	unsigned int nid;
+	int err;
+
+	buf = strstrip(buf);
+	threshold = buf;
+	node = strsep(&threshold, "=");
+
+	if (*node != 'N')
+		return -EINVAL;
+
+	err = kstrtouint(node + 1, 0, &nid);
+	if (err)
+		return err;
+
+	if (nid >= nr_node_ids || !node_state(nid, N_MEMORY))
+		return -EINVAL;
+
+	err = kstrtouint(threshold, 0, msecs);
+	if (err)
+		return err;
+
+	*nid_out = nid;
+
+	return nbytes;
+}
+
+static ssize_t memory_ws_refresh_interval_write(struct kernfs_open_file *of,
+						 char *buf, size_t nbytes,
+						 loff_t off)
+{
+	unsigned int nid, msecs;
+	struct wsr_state *wsr;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	ssize_t ret = memory_wsr_threshold_parse(buf, nbytes, &nid, &msecs);
+
+	if (ret < 0)
+		return ret;
+
+	wsr = &mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+
+	mutex_lock(&wsr->page_age_lock);
+	if (msecs && !wsr->page_age) {
+		struct wsr_page_age_histo *page_age =
+			kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL);
+
+		if (!page_age) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+		wsr->page_age = page_age;
+	}
+	if (!msecs && wsr->page_age) {
+		kfree(wsr->page_age);
+		wsr->page_age = NULL;
+	}
+
+	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(msecs));
+unlock:
+	mutex_unlock(&wsr->page_age_lock);
+	return ret;
+}
+
+static int memory_ws_report_threshold_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr_state *wsr =
+			&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+
+		seq_printf(m, "N%d=%u ", nid,
+			   jiffies_to_msecs(READ_ONCE(wsr->report_threshold)));
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_ws_report_threshold_write(struct kernfs_open_file *of,
+						 char *buf, size_t nbytes,
+						 loff_t off)
+{
+	unsigned int nid, msecs;
+	struct wsr_state *wsr;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	ssize_t ret = memory_wsr_threshold_parse(buf, nbytes, &nid, &msecs);
+
+	if (ret < 0)
+		return ret;
+
+	wsr = &mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+	WRITE_ONCE(wsr->report_threshold, msecs_to_jiffies(msecs));
+	return ret;
+}
+
+static int memory_ws_page_age_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr_state *wsr =
+			&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+		struct wsr_report_bin *bin;
+
+		if (!READ_ONCE(wsr->page_age))
+			continue;
+
+		wsr_refresh_report(wsr, memcg, NODE_DATA(nid));
+		mutex_lock(&wsr->page_age_lock);
+		if (!wsr->page_age)
+			goto unlock;
+		seq_printf(m, "N%d\n", nid);
+		for (bin = wsr->page_age->bins;
+		     bin->idle_age != WORKINGSET_INTERVAL_MAX; bin++)
+			seq_printf(m, "%u anon=%lu file=%lu\n",
+				   jiffies_to_msecs(bin->idle_age),
+				   bin->nr_pages[0] * PAGE_SIZE,
+				   bin->nr_pages[1] * PAGE_SIZE);
+
+		seq_printf(m, "%lu anon=%lu file=%lu\n", WORKINGSET_INTERVAL_MAX,
+			   bin->nr_pages[0] * PAGE_SIZE,
+			   bin->nr_pages[1] * PAGE_SIZE);
+
+unlock:
+		mutex_unlock(&wsr->page_age_lock);
+	}
+
+	return 0;
+}
+#endif
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -7073,7 +7229,27 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
-	{ }	/* terminate */
+#ifdef CONFIG_WORKINGSET_REPORT
+	{
+		.name = "workingset.refresh_interval",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_ws_refresh_interval_show,
+		.write = memory_ws_refresh_interval_write,
+	},
+	{
+		.name = "workingset.report_threshold",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_ws_report_threshold_show,
+		.write = memory_ws_report_threshold_write,
+	},
+	{
+		.name = "workingset.page_age",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.file_offset = offsetof(struct mem_cgroup, workingset_page_age_file),
+		.seq_show = memory_ws_page_age_show,
+	},
+#endif
+	{} /* terminate */
 };
 
 struct cgroup_subsys memory_cgrp_subsys = {
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 7dcf38525016..5a9bf3ebb914 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -37,9 +37,12 @@ void wsr_destroy_pgdat(struct pglist_data *pgdat)
 void wsr_init_lruvec(struct lruvec *lruvec)
 {
 	struct wsr_state *wsr = &lruvec->wsr;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
 	memset(wsr, 0, sizeof(*wsr));
 	mutex_init(&wsr->page_age_lock);
+	if (memcg && !mem_cgroup_is_root(memcg))
+		wsr->page_age_cgroup_file = &memcg->workingset_page_age_file;
 }
 
 void wsr_destroy_lruvec(struct lruvec *lruvec)
@@ -51,8 +54,8 @@ void wsr_destroy_lruvec(struct lruvec *lruvec)
 	memset(wsr, 0, sizeof(*wsr));
 }
 
-static int workingset_report_intervals_parse(char *src,
-					     struct wsr_report_bins *bins)
+int workingset_report_intervals_parse(char *src,
+				      struct wsr_report_bins *bins)
 {
 	int err = 0, i = 0;
 	char *cur, *next = strim(src);
@@ -526,5 +529,8 @@ void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat)
 {
 	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
 
-	kernfs_notify(wsr->page_age_sys_file);
+	if (mem_cgroup_is_root(memcg))
+		kernfs_notify(wsr->page_age_sys_file);
+	else
+		cgroup_file_notify(wsr->page_age_cgroup_file);
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


