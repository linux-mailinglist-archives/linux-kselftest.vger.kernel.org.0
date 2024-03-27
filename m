Return-Path: <linux-kselftest+bounces-6741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177D388F0FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 22:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD91229DB21
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238BC154C09;
	Wed, 27 Mar 2024 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHwp2kwn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD115445B
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575104; cv=none; b=JyAu3RxgEfuiPRmsZslZI5LHXSK+o06IBogs7cn+Rc29lzGBImpbYaJTOQ8Rv/CpORh3uUxpdYlb8pa64S4Y6FbfQKbdNl3+kgoArqVCUKf7FA5La3q+oU2W3uz2oscB4dnYDfCrFZDfhuRpnZr/uJ1a6nZKqbJ3+A5IjGwP1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575104; c=relaxed/simple;
	bh=lVBINjNVkAHsnoaSqt6PDQAq7kG3nIqmxIKIXIBHmXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZEmL5AJ53M3sgS5tHUmpLe7XSf/geb5oIlEds0V2wJ6TmNPR0o4eZb+KX2ykAFMJKIDKnAJdEmsPB3OnGHMPkjvq5iH63QdL7I+k64/DrWIcqmtc8sTYeS3MOQZsg1CtrFCt6bbYMf6PZfwK6hEZuy63ycmb2ybbF9DG2R2lZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHwp2kwn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so14501677b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575101; x=1712179901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A565PQouZoECoC+bAbMpMjHjbmuhcXoGplNwxvsLI/Q=;
        b=VHwp2kwnIF60mr5EeVW7NxiCPW1QzRnDw7RMa+qY6d6aYgn5UFIgp085//ht1w93jT
         oWkySLf/Lq/9DGbyTw41pmLXiI8B3YFy9OinJAXf3BlUxnaNOV6aC68A6k7gFJx3NL5W
         BSuFmualpHaESi70Pt2SlbrU64+YxsS16xgsteJZ+99dgfJkFkS8s3BKWJj752fcvl9l
         oEfMlzGMUyWSXzte1V7rbQTO9h97vQO222Gf7pUHf/5IYuhQRuh1y3eU5dNpsI+6QmjG
         nLomY9U/2og8m3eV9gT2NunZmvZmk1dkAVO32ZAm+bpp6m7DFbL3qQK7N4bgLgMfgBQN
         8TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575101; x=1712179901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A565PQouZoECoC+bAbMpMjHjbmuhcXoGplNwxvsLI/Q=;
        b=FKVzio2MN7iMd9Nzg4KM7cPu4HU+1dU90bkZv/Us7jzzK61gB6WFvu75uWOFVcMRvq
         u1mCqTfD6CHVpKhuw4Z1bEaGn37Vxsxpz9R7MM7a0haspioRNBQNq0ZVhZAyHulNGSMU
         rDizJp+FKCx9AeJL2qAUJytyDc09t/rqBk2x6JyZBJRcdler4+U9xqPfk3ZGkVZXPXjS
         n4JgW4a3aSEEE4GP0jN3dQ92WefQ7Gs1xj8TPIJsy9SqCF1T33fBt5wkRtwJxNQ0AsLr
         h6pXS3XiRYeorfUku8AzPVfSCF8g2KKyy7gp+nGS32ledSNQmxXqPCCbIWigfEZ7pHfT
         GgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc4E6fJC0o9vsPAxa6oUQKsjJefXkaP+szbi3GUR4XcbHZlWGkO1g7pUBypCUAU5lPkQip5n/F7/M9Z2foN0Wf27Kpuasq/lOQq4NNzGY1
X-Gm-Message-State: AOJu0YyFprjJqhoHmVkfqYg+9+wh8FnCaDws4NxrGnzqKWWTzK8/L3+H
	APYx2X9Kpv1VsipqNayccb59/5pQ8/Tp2edopOlBDmVFox7pLtdeXs0HjrWWawlx6Lcp51uD//x
	3ZS8EiA==
X-Google-Smtp-Source: AGHT+IGWjQUNRXXoGUh5+QqHFNkK8JcuM0kAdyJ/QDj3Y482hU2DxaC1k/t+Vf+seKF4W2aB0l9ObuFk2jZg
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6df3:ef42:a58e:a6b1])
 (user=yuanchu job=sendgmr) by 2002:a0d:df0d:0:b0:611:3077:2de7 with SMTP id
 i13-20020a0ddf0d000000b0061130772de7mr101184ywe.3.1711575101306; Wed, 27 Mar
 2024 14:31:41 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:31:06 -0700
In-Reply-To: <20240327213108.2384666-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327213108.2384666-1-yuanchu@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327213108.2384666-8-yuanchu@google.com>
Subject: [RFC PATCH v3 7/8] mm: add kernel aging thread for workingset reporting
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

For reliable and timely aging on memcgs, one has to read
the page age histograms on time. A kernel thread makes it easier
by aging memcgs with valid page_age_intervals and refresh_interval
when they can be refreshed, and also reduces the latency of any
userspace consumers of the page age histogram.

The kernel aging thread is gated behind CONFIG_WORKINGSET_REPORT_AGING.
Debugging stats may be added in the future for when aging cannot
keep up with the configured refresh_interval.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/workingset_report.h |  11 ++-
 mm/Kconfig                        |   6 ++
 mm/Makefile                       |   1 +
 mm/memcontrol.c                   |  11 ++-
 mm/workingset_report.c            |  14 +++-
 mm/workingset_report_aging.c      | 127 ++++++++++++++++++++++++++++++
 6 files changed, 163 insertions(+), 7 deletions(-)
 create mode 100644 mm/workingset_report_aging.c

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index e908c5678b1e..759486a3a285 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -77,9 +77,18 @@ void wsr_destroy(struct lruvec *lruvec);
  * The next refresh time is stored in refresh_time.
  */
 bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
-			struct pglist_data *pgdat);
+			struct pglist_data *pgdat, unsigned long *refresh_time);
 void wsr_register_node(struct node *node);
 void wsr_unregister_node(struct node *node);
+
+#ifdef CONFIG_WORKINGSET_REPORT_AGING
+void wsr_wakeup_aging_thread(void);
+#else /* CONFIG_WORKINGSET_REPORT_AGING */
+static inline void wsr_wakeup_aging_thread(void)
+{
+}
+#endif /* CONFIG_WORKINGSET_REPORT_AGING */
+
 #else
 static inline void wsr_init(struct lruvec *lruvec)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index 212f203b10b9..1e6aa1bd63f2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1270,6 +1270,12 @@ config WORKINGSET_REPORT
 	  This option exports stats and events giving the user more insight
 	  into its memory working set.
 
+config WORKINGSET_REPORT_AGING
+	bool "Workingset report kernel aging thread"
+	depends on WORKINGSET_REPORT
+	help
+	  Performs aging on memcgs with their configured refresh intervals.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 57093657030d..7caae7f2d6cf 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 obj-$(CONFIG_WORKINGSET_REPORT) += workingset_report.o
+obj-$(CONFIG_WORKINGSET_REPORT_AGING) += workingset_report_aging.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2a39a4445bb7..86e15b9fc8e2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7102,6 +7102,8 @@ static ssize_t memory_ws_page_age_intervals_write(struct kernfs_open_file *of,
 	old = xchg(&wsr->page_age, page_age);
 	mutex_unlock(&wsr->page_age_lock);
 	kfree(old);
+	if (err && READ_ONCE(wsr->refresh_interval))
+		wsr_wakeup_aging_thread();
 	return nbytes;
 failed:
 	kfree(page_age);
@@ -7227,14 +7229,17 @@ static ssize_t memory_ws_refresh_interval_write(struct kernfs_open_file *of,
 {
 	unsigned int nid, msecs;
 	struct wsr_state *wsr;
+	unsigned long old_interval;
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	ssize_t ret = memory_wsr_threshold_parse(buf, nbytes, &nid, &msecs);
 
 	if (ret < 0)
 		return ret;
-
 	wsr = &mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+	old_interval = jiffies_to_msecs(READ_ONCE(wsr->refresh_interval));
 	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(msecs));
+	if (msecs && (!old_interval || jiffies_to_msecs(old_interval) > msecs))
+		wsr_wakeup_aging_thread();
 	return ret;
 }
 
@@ -7285,7 +7290,7 @@ static int memory_ws_page_age_show(struct seq_file *m, void *v)
 		if (!READ_ONCE(wsr->page_age))
 			continue;
 
-		wsr_refresh_report(wsr, memcg, NODE_DATA(nid));
+		wsr_refresh_report(wsr, memcg, NODE_DATA(nid), NULL);
 		mutex_lock(&wsr->page_age_lock);
 		if (!wsr->page_age)
 			goto unlock;
@@ -7325,7 +7330,7 @@ static int memory_ws_reaccess_histogram_show(struct seq_file *m, void *v)
 		if (!reaccess)
 			goto unlock;
 
-		wsr_refresh_report(wsr, memcg, NODE_DATA(nid));
+		wsr_refresh_report(wsr, memcg, NODE_DATA(nid), NULL);
 
 		seq_printf(m, "N%d\n", nid);
 		for (bin = reaccess->bins.bins;
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 504d840bbe6a..da658967eac2 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -234,7 +234,7 @@ static void refresh_aggregate(struct wsr_page_age_histo *page_age,
 }
 
 bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
-			struct pglist_data *pgdat)
+			struct pglist_data *pgdat, unsigned long *refresh_time)
 {
 	struct wsr_page_age_histo *page_age = NULL;
 	unsigned long refresh_interval = READ_ONCE(wsr->refresh_interval);
@@ -253,6 +253,8 @@ bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
 		goto unlock;
 	refresh_scan(wsr, root, pgdat, refresh_interval);
 	refresh_aggregate(page_age, root, pgdat);
+	if (refresh_time)
+		*refresh_time = page_age->timestamp + refresh_interval;
 
 unlock:
 	mutex_unlock(&wsr->page_age_lock);
@@ -564,12 +566,16 @@ static ssize_t refresh_interval_store(struct kobject *kobj,
 	unsigned int interval;
 	int err;
 	struct wsr_state *wsr = kobj_to_wsr(kobj);
+	unsigned long old_interval;
 
 	err = kstrtouint(buf, 0, &interval);
 	if (err)
 		return err;
 
-	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(interval));
+	old_interval = xchg(&wsr->refresh_interval, msecs_to_jiffies(interval));
+	if (interval &&
+	    (!old_interval || jiffies_to_msecs(old_interval) > interval))
+		wsr_wakeup_aging_thread();
 
 	return len;
 }
@@ -642,6 +648,8 @@ static ssize_t page_age_intervals_store(struct kobject *kobj,
 	mutex_unlock(&wsr->page_age_lock);
 	kfree(old);
 	kfree(buf);
+	if (err && READ_ONCE(wsr->refresh_interval))
+		wsr_wakeup_aging_thread();
 	return len;
 failed:
 	kfree(page_age);
@@ -663,7 +671,7 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 	if (!READ_ONCE(wsr->page_age))
 		return -EINVAL;
 
-	wsr_refresh_report(wsr, NULL, kobj_to_pgdat(kobj));
+	wsr_refresh_report(wsr, NULL, kobj_to_pgdat(kobj), NULL);
 
 	mutex_lock(&wsr->page_age_lock);
 	if (!wsr->page_age) {
diff --git a/mm/workingset_report_aging.c b/mm/workingset_report_aging.c
new file mode 100644
index 000000000000..91ad5020778a
--- /dev/null
+++ b/mm/workingset_report_aging.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Workingset report kernel aging thread
+ *
+ * Performs aging on behalf of memcgs with their configured refresh interval.
+ * While a userspace program can periodically read the page age breakdown
+ * per-memcg and trigger aging, the kernel performing aging is less overhead,
+ * more consistent, and more reliable for the use case where every memcg should
+ * be aged according to their refresh interval.
+ */
+#define pr_fmt(fmt) "workingset report aging: " fmt
+
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/memcontrol.h>
+#include <linux/swap.h>
+#include <linux/wait.h>
+#include <linux/mmzone.h>
+#include <linux/workingset_report.h>
+
+static DECLARE_WAIT_QUEUE_HEAD(aging_wait);
+static bool refresh_pending;
+
+static bool do_aging_node(int nid, unsigned long *next_wake_time)
+{
+	struct mem_cgroup *memcg;
+	bool should_wait = true;
+	struct pglist_data *pgdat = NODE_DATA(nid);
+
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+		struct wsr_state *wsr = &lruvec->wsr;
+		unsigned long refresh_time;
+
+		/* use returned time to decide when to wake up next */
+		if (wsr_refresh_report(wsr, memcg, pgdat, &refresh_time)) {
+			if (should_wait) {
+				should_wait = false;
+				*next_wake_time = refresh_time;
+			} else if (time_before(refresh_time, *next_wake_time)) {
+				*next_wake_time = refresh_time;
+			}
+		}
+
+		cond_resched();
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+
+	return should_wait;
+}
+
+static int do_aging(void *unused)
+{
+	while (!kthread_should_stop()) {
+		int nid;
+		long timeout_ticks;
+		unsigned long next_wake_time;
+		bool should_wait = true;
+
+		WRITE_ONCE(refresh_pending, false);
+		for_each_node_state(nid, N_MEMORY) {
+			unsigned long node_next_wake_time;
+
+			if (do_aging_node(nid, &node_next_wake_time))
+				continue;
+			if (should_wait) {
+				should_wait = false;
+				next_wake_time = node_next_wake_time;
+			} else if (time_before(node_next_wake_time,
+					       next_wake_time)) {
+				next_wake_time = node_next_wake_time;
+			}
+		}
+
+		if (should_wait) {
+			wait_event_interruptible(aging_wait, refresh_pending);
+			continue;
+		}
+
+		/* sleep until next aging */
+		timeout_ticks = next_wake_time - jiffies;
+		if (timeout_ticks > 0 &&
+		    timeout_ticks != MAX_SCHEDULE_TIMEOUT) {
+			schedule_timeout_idle(timeout_ticks);
+			continue;
+		}
+	}
+	return 0;
+}
+
+/* Invoked when refresh_interval shortens or changes to a non-zero value. */
+void wsr_wakeup_aging_thread(void)
+{
+	WRITE_ONCE(refresh_pending, true);
+	wake_up_interruptible(&aging_wait);
+}
+
+static struct task_struct *aging_thread;
+
+static int aging_init(void)
+{
+	struct task_struct *task;
+
+	task = kthread_run(do_aging, NULL, "kagingd");
+
+	if (IS_ERR(task)) {
+		pr_err("Failed to create aging kthread\n");
+		return PTR_ERR(task);
+	}
+
+	aging_thread = task;
+	pr_info("module loaded\n");
+	return 0;
+}
+
+static void aging_exit(void)
+{
+	kthread_stop(aging_thread);
+	aging_thread = NULL;
+	pr_info("module unloaded\n");
+}
+
+module_init(aging_init);
+module_exit(aging_exit);
-- 
2.44.0.396.g6e790dbe36-goog


