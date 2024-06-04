Return-Path: <linux-kselftest+bounces-11163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94408FA825
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 04:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8083328C20F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 02:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81913F453;
	Tue,  4 Jun 2024 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frO1Vxxv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24513E3F2
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466779; cv=none; b=NnZ//n80Hs4tGeoT8jA96hq1IBgb0lITmQ/gqWH1oTwSUA/y3mUyjOmOsTBB86mR+WmN0PfmkCEgGSF70mDNY5YtyJE2XsNbPeH/Ooz0rnlj53h9vBU7R8+6rbq5gWmjeCwE4f1/+JIVesOluLfiIGu8d/6kMuR1jsAXzqo0F4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466779; c=relaxed/simple;
	bh=WzqkPugbOiVbWg+Bz3/39mPsvZeHjQJkUc7aNbm+ez4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMxMf3sAc+ERjQdXnbNI9TF/TqESYtRqNjUUDIcjXNeqcpARKTZ2jPNrzgDrzpHJ3oYUW4h93b4gW9CVNIYwjSLGwXQTeVkWKxdJcuE1F3BqTD3v5DHyT5CAwKQ1P6JvMG6rczKnW9Q8Bc0cB6x5jcaNvE1iIWVPNTQDINYG+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frO1Vxxv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627ee6339d6so85448767b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2024 19:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717466776; x=1718071576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRO4mHrw3JGh6nKhs6HXawOt4KQi22Ngkfo+vgcJs3s=;
        b=frO1VxxvzOztPw+gmxtFxjLugPMt7kPdrfiC5gbHQEKhke8UM0waezUQ8uiIxbZIvQ
         A2sR5dzsJ/eRqFThahsNDdm2cCH7YEheOsgdFhaaylfm+7sYTy02pwlVXCEmvEa4vg9V
         4k/AVLRzgUzFG+Pp6wUNOMjLg09unZ7JSZhv2xVEF8oMucfgda5Qh8SC3Dwpe73RgUHy
         Zh7pjh7lQ9JsxpjS+w/2uqE+t7Z3Sy6dseD678ijc8yo3YmQQGZcnChtY+M2R9nfndeV
         n7v8QqRLpYPrs9CnzIM0UPL0qvixINQ2E2v8EUWcxdqFwXff7RoYTIVRkk0RNiSzTAQ6
         dOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717466776; x=1718071576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRO4mHrw3JGh6nKhs6HXawOt4KQi22Ngkfo+vgcJs3s=;
        b=hxpr0YPKibUw0VhoMz5mmVeIaQ0GaMz/wtqIm02WQzE+/hsLKewBbkeo6rfKj0sGLo
         +8L+n9KcbD8lTHnX4DRmong3Gsz884TknnCNecxTbgh6VYXqmvYdkbru/e/X0vJkSz3D
         lfUgTV1Gv6nM1wUM0acytHKNuTXreVyR7tsjB1cR9qbSJCHyLD0ohFEFqnD5A/eK3YMz
         +sARwQ95LaE0fwFyVxmF6z40IfXQuo3QpnE0z+iWkmrBgD1uW/kGgZxl0nYJH4Kluaa1
         Z7IQ2UD2T5vBGmtuv38zEEu2BZDkH5PuF4jV7DjDNfOCN4Jrzla4N6Swz5GAxHQqfChu
         5g2g==
X-Forwarded-Encrypted: i=1; AJvYcCUA4VdiQM/38UzXOW6jMlCZ9ZQn4Dct1r0e4gxc5f/gplXRsHnSNk70YKggdg/5DO9Vjeigbs9mtvaszYDNS3gEkCQSZxZYJ4t5LFGEcLSf
X-Gm-Message-State: AOJu0YyfxWSI+3VLU5/bVHvZi55R8e9UWR6RquPSfbict7S/6FcWk80R
	GRHkmpvnBq8zQ0KktfWBeSshKWP+h5umMnacgq1ssjs3Kzyk/a/H5714aFHyJcCjScU+Pc7z6yi
	+uSCJNQ==
X-Google-Smtp-Source: AGHT+IEA7IxV4E1j3KloZIYFfUw/fULB2Z+7pThTKaRON0/8bQkhXcDdKIm+z8+ZQ9n1pMUXwDRfYO5MgVc/
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:367f:7387:3dd2:73f1])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:fd5:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-62c794a2504mr34231327b3.0.1717466776247; Mon, 03 Jun 2024
 19:06:16 -0700 (PDT)
Date: Mon,  3 Jun 2024 19:05:46 -0700
In-Reply-To: <20240604020549.1017540-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240604020549.1017540-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240604020549.1017540-6-yuanchu@google.com>
Subject: [PATCH v2 5/8] mm: extend working set reporting to memcgs
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
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
index 030d34e9d117..91b08123950b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -319,6 +319,11 @@ struct mem_cgroup {
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
index 3246384317f6..cf523a7c2048 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -404,6 +404,8 @@ void set_task_reclaim_state(struct task_struct *task, struct reclaim_state *rs);
  * in mm/wsr.c
  */
 void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat);
+int workingset_report_intervals_parse(char *src,
+				      struct wsr_report_bins *bins);
 #else
 static inline void notify_workingset(struct mem_cgroup *memcg,
 				     struct pglist_data *pgdat)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f973679e4a24..48cdc9422794 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7226,6 +7226,162 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
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
@@ -7294,7 +7450,27 @@ static struct cftype memory_files[] = {
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
index 801ac8e5c1da..72f2cad85a0d 100644
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
2.45.1.467.gbab1589fc0-goog


