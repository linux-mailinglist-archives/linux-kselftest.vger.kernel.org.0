Return-Path: <linux-kselftest+bounces-6739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C54488F0FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 22:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101511F307A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 21:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEE6154432;
	Wed, 27 Mar 2024 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPEWaDx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAD153BE4
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575100; cv=none; b=V2Jzqb9ZmExJfSfJuP5WDZVXshkvG2jJkuOgJYWnd9c1Ybl5xX56i1rfqGIIsO2/yg+r4V2R3/BfBQGRRybhVq31qczMe+MAN8lgnnaLTNYvEdAGmqf8yp9t4H8gLdYt0Dr+xE+0bOG/IHt8VOXvKXXsQHoWN4fKXUD58l7JUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575100; c=relaxed/simple;
	bh=bBIE5Ow/pYwgtpsi8Q9h2nMAHvXb3FBjBYB5fON9v+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O5wiPpt2zQid3j8VlPMzW6xIpC5uQrixGHn3r74gMYtsxqsWZEJQdN5i2dYI7vlwV12UEk3nWzv8i8I+esRJ4eSPIVyxd7V8PixygDbq9JBP7Wf7o+tsT+ZAtXV64MsRfDWtCialH8skcAs3j3UcruD+TDzMssVkqT9cdRnl76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPEWaDx5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a03635590so6026197b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575097; x=1712179897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xaCDmpnOXna8KuNDUqa6ynYFsa6ZfJ9LVAHJUw2Aofg=;
        b=wPEWaDx5HTkYByOae+MOT/UVhBJ84y2h9ndPFVFYN/t7E3lZlwxr6f8Zkk8cGaabvf
         2iRZ0EjXD7q0I+Eb7S3/TCCVMM8AZwsqvD+6V7ulSGgq5nEPRt9Ys0UHcxAQiGM6punv
         U8gkabHKRFn7zSYiLDOtvgM4yYxj5eAZ4KITpIwlaKfv5YOItTtS57b1ieuxrvSCRAI5
         79EPa8+i9BEpKAHRiqn7f5stprOM/FptmIpY9fKCrUx3gWXRN+CBEgcLs/yrBkIkiT+6
         yA0WVTfTakDWsGZZA7ZwvvGYZMdMA1ARb1X3vCl+IWyqf//nLWGH3TPkvk4XU5prYHeU
         Hf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575097; x=1712179897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaCDmpnOXna8KuNDUqa6ynYFsa6ZfJ9LVAHJUw2Aofg=;
        b=QFsnlMi3QtisSifW6It5J80OKK6C4GGBVCG0kKUgbqaWn3U+mvlq4LVuJcIpChl5Ni
         fAnZzJ8MLnFmc7u33Gi0w6A2M9Xn3a6IhTZwbZkuE6iZekBmWc901PjqrtxHYeyhoYR4
         nQ2IPCwJEPHSfm1CqNOjROddGjQ/twBxvT67pMT8tCB1S/GkRpioBVZSNG1wR2cxVKl4
         tkcYjY7joho0nd9SoJ0ovX+VpbBrblsVeyvSTfLppbRs2FjtKB4jN1QiwlItju7NCQJR
         i360h/in5wiUKBtwUsJxZs5ELg/M9aqGhmXlU9zYjCohdn2eIcYfPR/A1zOLyX1Ual5N
         KdxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlZtnX2RN/xlrNsdQahqajYV96/wgnDaxOX9CFDqGjx7e5T5JRo0lqjWCwHjvEu6dw/xXcmKqadT+URANf/nL9tF5t3COjp+A/5tgTnmBE
X-Gm-Message-State: AOJu0YwFZC9rLp3VQCWCG6kW8CyLHAQkpgDO4Ayep2jsqxWuz0BZzvaN
	Mk4CwlQV1BlMPXxUXl7Ewt2jIVWkncjxDekhPtlDfJQtqJxtYcpJqHu3uM7WMeOFY8WrH1SdMSt
	IfQt8hQ==
X-Google-Smtp-Source: AGHT+IHPhGifJWkaGVpVQkyYgUvbZ7gXC3zKKNE+5jad1F4KE6vLxnBUAJz0fdIi3IF4p9BgtNJpeDc4GOj3
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6df3:ef42:a58e:a6b1])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:b9a:b0:610:dc1b:8f39 with SMTP id
 ck26-20020a05690c0b9a00b00610dc1b8f39mr216073ywb.0.1711575097511; Wed, 27 Mar
 2024 14:31:37 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:31:04 -0700
In-Reply-To: <20240327213108.2384666-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327213108.2384666-1-yuanchu@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327213108.2384666-6-yuanchu@google.com>
Subject: [RFC PATCH v3 5/8] mm: extend working set reporting to memcgs
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

Break down the system-wide working set reporting into
per-memcg reports, which aggregages its children hierarchically.
The per-node working set reporting histograms and refresh/report
threshold files are presented as memcg files, showing a report
containing all the nodes.

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

/sys/fs/cgroup/.../memory.workingset.page_age_intervals
	Configures the intervals for the page age histogram. This file
	operates on a per-node basis, allowing for different intervals
	for each node.
	e.g.
	echo N0=1000,2000,3000,4000,5000 > memory.workingset.page_age_intervals

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
 mm/memcontrol.c                   | 267 +++++++++++++++++++++++++++++-
 mm/workingset_report.c            |  10 +-
 5 files changed, 286 insertions(+), 4 deletions(-)

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
index 589d240d6251..502542c812b3 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -9,6 +9,7 @@ struct mem_cgroup;
 struct pglist_data;
 struct node;
 struct lruvec;
+struct cgroup_file;
 
 #ifdef CONFIG_WORKINGSET_REPORT
 
@@ -38,7 +39,10 @@ struct wsr_state {
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
index 2f07141de16c..75bda5f7994d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7005,6 +7005,245 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+#ifdef CONFIG_WORKINGSET_REPORT
+static int memory_ws_page_age_intervals_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr_state *wsr;
+		struct wsr_page_age_histo *page_age;
+		int i, nr_bins;
+
+		wsr = &mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+		mutex_lock(&wsr->page_age_lock);
+		page_age = wsr->page_age;
+		if (!page_age)
+			goto no_page_age;
+		seq_printf(m, "N%d=", nid);
+		nr_bins = page_age->bins.nr_bins;
+		for (i = 0; i < nr_bins; ++i) {
+			struct wsr_report_bin *bin =
+				&page_age->bins.bins[i];
+
+			seq_printf(m, "%u", jiffies_to_msecs(bin->idle_age));
+			if (i + 1 < nr_bins)
+				seq_putc(m, ',');
+		}
+		seq_putc(m, ' ');
+no_page_age:
+		mutex_unlock(&wsr->page_age_lock);
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_wsr_interval_parse(struct kernfs_open_file *of, char *buf,
+					 size_t nbytes, unsigned int *nid_out,
+					 struct wsr_report_bins *bins)
+{
+	char *node, *intervals;
+	unsigned int nid;
+	int err;
+
+	buf = strstrip(buf);
+	intervals = buf;
+	node = strsep(&intervals, "=");
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
+	err = workingset_report_intervals_parse(intervals, bins);
+	if (err < 0)
+		return err;
+
+	*nid_out = nid;
+	return err;
+}
+
+static ssize_t memory_ws_page_age_intervals_write(struct kernfs_open_file *of,
+						  char *buf, size_t nbytes,
+						  loff_t off)
+{
+	unsigned int nid;
+	int err;
+	struct wsr_page_age_histo *page_age = NULL, *old;
+	struct wsr_state *wsr;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	page_age =
+		kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL_ACCOUNT);
+
+	if (!page_age) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	err = memory_wsr_interval_parse(of, buf, nbytes, &nid, &page_age->bins);
+	if (err < 0)
+		goto failed;
+
+	if (err == 0) {
+		kfree(page_age);
+		page_age = NULL;
+	}
+
+	wsr = &mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+	mutex_lock(&wsr->page_age_lock);
+	old = xchg(&wsr->page_age, page_age);
+	mutex_unlock(&wsr->page_age_lock);
+	kfree(old);
+	return nbytes;
+failed:
+	kfree(page_age);
+	return err;
+}
+
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
+	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(msecs));
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
+		for (bin = wsr->page_age->bins.bins;
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
@@ -7073,7 +7312,33 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
-	{ }	/* terminate */
+#ifdef CONFIG_WORKINGSET_REPORT
+	{
+		.name = "workingset.page_age_intervals",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_ws_page_age_intervals_show,
+		.write = memory_ws_page_age_intervals_write,
+	},
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
index 3ed3b0e8f8ad..b00ffbfebcab 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -20,9 +20,12 @@
 void wsr_init(struct lruvec *lruvec)
 {
 	struct wsr_state *wsr = &lruvec->wsr;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
 	memset(wsr, 0, sizeof(*wsr));
 	mutex_init(&wsr->page_age_lock);
+	if (memcg && !mem_cgroup_is_root(memcg))
+		wsr->page_age_cgroup_file = &memcg->workingset_page_age_file;
 }
 
 void wsr_destroy(struct lruvec *lruvec)
@@ -34,7 +37,7 @@ void wsr_destroy(struct lruvec *lruvec)
 	memset(wsr, 0, sizeof(*wsr));
 }
 
-static int workingset_report_intervals_parse(char *src,
+int workingset_report_intervals_parse(char *src,
 				      struct wsr_report_bins *bins)
 {
 	int err = 0, i = 0;
@@ -490,5 +493,8 @@ void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat)
 {
 	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
 
-	kernfs_notify(wsr->page_age_sys_file);
+	if (mem_cgroup_is_root(memcg))
+		kernfs_notify(wsr->page_age_sys_file);
+	else
+		cgroup_file_notify(wsr->page_age_cgroup_file);
 }
-- 
2.44.0.396.g6e790dbe36-goog


