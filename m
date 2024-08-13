Return-Path: <linux-kselftest+bounces-15253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C996A950AEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 19:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAB41C22CA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFE01A38F6;
	Tue, 13 Aug 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjPGFElB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00DA1A38C7
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568386; cv=none; b=coNhaj4wazHzYZsP/jVWYmlVFOvT7y3H/XAjqhwu2YxnG2wVS+b5DxSdpNRnf02q7yA4uyTI8uhS+TtPqL7uzDhDqEMUQMbNSuHchX/BJfFCJozMfFwy6PG8YvlnV/Ha/+vE2PT62WGh4SRG/rQMymz2Zppli+vMG/uvTrXgUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568386; c=relaxed/simple;
	bh=v4o0k/hvkZp0NOHjP3zwNZqrNqtVb/d9j5ZzED2dby8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mpRC6638J0Taz9gEgXgoFjOuBTH/p9iady6o9JLwMVVk2oC3jhNbbjmT0+tujWa1UjGOARgW8VZBlsc+Gq5KeyJZ8GIDIqLffE77kgI0MRn74AZzL3JXEWWERJhW51aLW82cMwsqOPhAE45PA85uYRvDoiiUVK9a9ij0BcAFHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjPGFElB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-672bea19bedso135340867b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723568384; x=1724173184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nX5Or29rWGSYnqI8Mal7bT79wmdNbU4VM0EJZ849BDE=;
        b=gjPGFElBOXW8hFo0GgXOLyAozJnNvOMIU8QgVLuHjvCQmysB982i4f4fdkHRfabKw4
         TXhj1UbH34oRXb8glQlAjD0o/x1u+PXiccyH1uPOtVxIRjd6YTUsjktE9yg/KCvUkC5o
         nBI18micNsWLBTmmnh8bjmTUCmuPkYiQsPZLbZBYdOHFxWwG5HPVSKVRcIeh0mRNWr9B
         iDyl6anDgnNU4ph+QQK0oDiXViUnSgCo5meneHYxyXcxWjoEpk9SZS60nNjfmmzXJfVt
         yyFY/slaWzfogMkaZg7joAFYXxDNdnm/NI9TkMDeVzuBdDb6/fO4KtOLB4wFn+le7qv2
         hBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568384; x=1724173184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nX5Or29rWGSYnqI8Mal7bT79wmdNbU4VM0EJZ849BDE=;
        b=rdd1+3FO2Z5QI84WTNZaqTQ6u4iU04q5AMqc+aLTfkuAZUzHnbEaJGf9Qr61jxWtdb
         lpEPNgDYYwMQaqYSFMK0E2eNmaLP7jMZ+VHRRJhGqI4SiSjEV/zV3/2ezgXm4LeLoNh+
         N6cfUfvlsfcEptFBUlJ2SCLJitQpL5dx42yMkaMd7GM41Pk4qMY9qpEJxObRUuvTHuh2
         tdavaXRg4NLifykwQVLVOg606P1K+tJq5+L2y5hLsS+y15Kw3tAhvr9C9vJ4knzezqL1
         vIGBvsy1c8gSTGI7ZTZdoVV2kqsecvYeSaQLECyr0u9CUqLdygf6qArxTx6aFQQxz8L7
         FExQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsgubOy3wONvVMLfR6/A1s/a4Fr2gyEGEJofPYWi+BnLCZmy7dd58uNamINi+OqzOwEEfU36oiYO8/+IvmV14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpVCsS5P/Ez/BYv6ruG1zAYERTVUKIvYLmgqVkS8OdRL5zOZj
	a32ps6ONBA/cahRcUD1BeQ0Gi2m0YrOJcf6xhjVvq8LGYsKAA7i+yTPrJrx8gfgva9hJDHO1hul
	F4nSprQ==
X-Google-Smtp-Source: AGHT+IEDV077DvpPZgcSOtEG+50DqdAd9HxWks1Jm8Rh/HY1wmqFnkHTld2tYhmnQaOc9LEXewCUzyWTHQqf
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:b50c:66e8:6532:a371])
 (user=yuanchu job=sendgmr) by 2002:a25:a444:0:b0:e05:6e45:84b6 with SMTP id
 3f1490d57ef6-e1155b79891mr171276.8.1723568383787; Tue, 13 Aug 2024 09:59:43
 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:56:15 -0700
In-Reply-To: <20240813165619.748102-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813165619.748102-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813165619.748102-5-yuanchu@google.com>
Subject: [PATCH v3 4/7] mm: extend working set reporting to memcgs
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
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
	The memcg equivalent of the sysfs workingset page age histogram
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
Change-Id: I6c8a39cddd248c031c85f144787c9044912f3c21
---
 include/linux/memcontrol.h        |  21 ++++
 include/linux/workingset_report.h |   6 +-
 mm/internal.h                     |   2 +
 mm/memcontrol.c                   | 178 +++++++++++++++++++++++++++++-
 mm/workingset_report.c            |  12 +-
 5 files changed, 214 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0e5bf25d324f..6d67f1072943 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -315,6 +315,11 @@ struct mem_cgroup {
 	spinlock_t event_list_lock;
 #endif /* CONFIG_MEMCG_V1 */
 
+#ifdef CONFIG_WORKINGSET_REPORT
+	/* memory.workingset.page_age file */
+	struct cgroup_file workingset_page_age_file;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
@@ -1063,6 +1068,16 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 void split_page_memcg(struct page *head, int old_order, int new_order);
 
+static inline struct cgroup_file *
+mem_cgroup_page_age_file(struct mem_cgroup *memcg)
+{
+#ifdef CONFIG_WORKINGSET_REPORT
+	return &memcg->workingset_page_age_file;
+#else
+	return NULL;
+#endif
+}
+
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1470,6 +1485,12 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 static inline void split_page_memcg(struct page *head, int old_order, int new_order)
 {
 }
+
+static inline struct cgroup_file *
+mem_cgroup_page_age_file(struct mem_cgroup *memcg)
+{
+	return NULL;
+}
 #endif /* CONFIG_MEMCG */
 
 /*
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
index 19af882c506e..cc54358ed582 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -421,6 +421,8 @@ void set_task_reclaim_state(struct task_struct *task, struct reclaim_state *rs);
  * in mm/wsr.c
  */
 void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat);
+int workingset_report_intervals_parse(char *src,
+				      struct wsr_report_bins *bins);
 #else
 static inline void notify_workingset(struct mem_cgroup *memcg,
 				     struct pglist_data *pgdat)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5d16fd9d2c3f..56848dc94d48 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4318,6 +4318,162 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
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
@@ -4386,7 +4542,27 @@ static struct cftype memory_files[] = {
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
index 801ac8e5c1da..333e51e3ee12 100644
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
+		wsr->page_age_cgroup_file = mem_cgroup_page_age_file(memcg);
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
@@ -542,5 +545,8 @@ void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat)
 {
 	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
 
-	kernfs_notify(wsr->page_age_sys_file);
+	if (mem_cgroup_is_root(memcg))
+		kernfs_notify(wsr->page_age_sys_file);
+	else
+		cgroup_file_notify(wsr->page_age_cgroup_file);
 }
-- 
2.46.0.76.ge559c4bf1a-goog


