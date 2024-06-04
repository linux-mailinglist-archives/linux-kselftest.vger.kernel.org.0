Return-Path: <linux-kselftest+bounces-11164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73EC8FA827
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 04:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B81D1F25A05
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6292F13FD9B;
	Tue,  4 Jun 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUL100eE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F113F449
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466781; cv=none; b=eJ1nKUdRrvBAe43uh1LWHbj+35QZLahUZ3XKkOfNlHZTxLB+Km8awEPqkI7JTigoZyMhaus4Ugzy3KOfm/Ncl44F9633t4KcCjHAflr+cSEHuC8DKkYfqevSN0Vs4EF3BMA9CBl2+ACh95w9X2GV9SkyM3mFWUKTGoNm/sRn0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466781; c=relaxed/simple;
	bh=S8VvyqsFvFB13E45h+8KtTwj62d7eCeuVaa+khQBLAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h2cBk4rW8BJLYqzk2geEsh25se6ZtKG13zLiGs4zITA6DrSywopzYm1moTo9E1tI2oOq0aJ3nw6IMTIaJ0QryJTHkrbYQJ39veXBxVv0QF3rb9IlSyfA7dN4qNaSBYxBICiDtSIgRFH0kVKghXQWxJomU1FmsHu0lSWtzv7cQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUL100eE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa73bc81f5so5622841276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2024 19:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717466778; x=1718071578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFb3qAFC4K5HEmXTa3qV09z8mTyiAg8MnrqMh3hMESY=;
        b=bUL100eEgCjxL5OqRvGoXBLg/BNNSrZYDbmQBpZMQHxt+Lj6PuR8RCGtcGGzfuWWsR
         03pUkXIDxf27Vzoss6TEkcxNSDgZmerexSQ1E73oLhqMxZFFPM2/8tZNps5PxZi89C5U
         Ri227KwaiCN2BuZXWhnFVDyEWpZU1bZVBVaEjPdyZD82tkY4AAjphaTRUT2m4P3OFSYq
         hlbc26J5wxDnkFQGGph0DQXi3yUqUgGeDmh1I+6jGvEY7v08rO0Y9pZ2bWEvOid0Iua+
         DjfPPAvfq7ckq69z1PAY29DtxzchWLOhgwFnQbYkqr1dHwG7czx/poPibhWqELSAcUaB
         XN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717466778; x=1718071578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFb3qAFC4K5HEmXTa3qV09z8mTyiAg8MnrqMh3hMESY=;
        b=oNRz1tR1yzsqujbnul4EFqJ6OZHlxG3oBywsGCAnrY77ysBxuFPIUmWcY8wiJA6PTI
         u4liomxTTo2Zh94QLappjq5JetKCNfuA977xKd1l4z/+VGnECi9QCHUFB4mNld9Ix16G
         NAlFYjq9vx9IYa7cam2D2VEyjht1iP9MlrPc5xhB43rmjwRqOdnXTG7LW86LgNmiySez
         Vvt3JfRWu4EuYPfmYpXgrElgo3dkKAkbO3hOummlBqdBl31sr4OsTqr0sI4SHR7fVM11
         e2MSvArMnTvG/n4MaxB+BEHZ+h4aJr6rw8Oa1Q8CSV8D+uGitLy1WKPeB1xs2Ke9TeG4
         L8XA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5qfaz0Gch0VkuLMGpJTik54hUTeSGd2KphC8jJK1hGMrhY2csXi1dXZcMSBuXO5TaZvGJd5gZHQeJ+iMwQAfin9Su+1AnOLVrharADXb
X-Gm-Message-State: AOJu0YyZkYdkDhH5KkihpHzDgdYNruFmp7iQyIdJQDoCRMmmCpXufkI0
	tYfCqQW4CFA+RkOA/ViXkl9j9fE9cjATSWGN1AQIXux4PJnivEkRCh1nXZ8FnDXxfsRg9EeRfNq
	7IpqT4w==
X-Google-Smtp-Source: AGHT+IERBr3rpHyGYQbtWTU2Cnqq5B/QCSj2QzI+uA89IMrXbKRLeHdRMrnyxldq/MA/nBeGIemY82Zq3hyI
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:367f:7387:3dd2:73f1])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:706:b0:dfa:6ea5:c8d5 with SMTP id
 3f1490d57ef6-dfa73d9b762mr2674608276.10.1717466778461; Mon, 03 Jun 2024
 19:06:18 -0700 (PDT)
Date: Mon,  3 Jun 2024 19:05:47 -0700
In-Reply-To: <20240604020549.1017540-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240604020549.1017540-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240604020549.1017540-7-yuanchu@google.com>
Subject: [PATCH v2 6/8] mm: add kernel aging thread for workingset reporting
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

For reliable and timely aging on memcgs, one has to read the page age
histograms on time. A kernel thread makes it easier by aging memcgs with
valid refresh_interval when they can be refreshed, and also reduces the
latency of any userspace consumers of the page age histogram.

The kerne aging thread is gated behind CONFIG_WORKINGSET_REPORT_AGING.
Debugging stats may be added in the future for when aging cannot
keep up with the configured refresh_interval.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/workingset_report.h |  11 ++-
 mm/Kconfig                        |   6 ++
 mm/Makefile                       |   1 +
 mm/memcontrol.c                   |   8 +-
 mm/workingset_report.c            |  15 +++-
 mm/workingset_report_aging.c      | 127 ++++++++++++++++++++++++++++++
 6 files changed, 162 insertions(+), 6 deletions(-)
 create mode 100644 mm/workingset_report_aging.c

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index ae412d408037..9294023db5a8 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -63,7 +63,16 @@ void wsr_remove_sysfs(struct node *node);
  * The next refresh time is stored in refresh_time.
  */
 bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
-			struct pglist_data *pgdat);
+			struct pglist_data *pgdat, unsigned long *refresh_time);
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
 static inline void wsr_init_lruvec(struct lruvec *lruvec)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index 03927ed2adbd..f8ff41408b9c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1258,6 +1258,12 @@ config WORKINGSET_REPORT
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
index ed05af2bb3e3..e9c9048e1e09 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 obj-$(CONFIG_WORKINGSET_REPORT) += workingset_report.o
+obj-$(CONFIG_WORKINGSET_REPORT_AGING) += workingset_report_aging.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 48cdc9422794..547a2161b7e2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7281,12 +7281,12 @@ static ssize_t memory_ws_refresh_interval_write(struct kernfs_open_file *of,
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
 
 	mutex_lock(&wsr->page_age_lock);
@@ -7305,9 +7305,13 @@ static ssize_t memory_ws_refresh_interval_write(struct kernfs_open_file *of,
 		wsr->page_age = NULL;
 	}
 
+	old_interval = READ_ONCE(wsr->refresh_interval);
 	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(msecs));
 unlock:
 	mutex_unlock(&wsr->page_age_lock);
+	if (ret > 0 && msecs &&
+	    (!old_interval || jiffies_to_msecs(old_interval) > msecs))
+		wsr_wakeup_aging_thread();
 	return ret;
 }
 
@@ -7358,7 +7362,7 @@ static int memory_ws_page_age_show(struct seq_file *m, void *v)
 		if (!READ_ONCE(wsr->page_age))
 			continue;
 
-		wsr_refresh_report(wsr, memcg, NODE_DATA(nid));
+		wsr_refresh_report(wsr, memcg, NODE_DATA(nid), NULL);
 		mutex_lock(&wsr->page_age_lock);
 		if (!wsr->page_age)
 			goto unlock;
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 72f2cad85a0d..15118c4aecb1 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -274,7 +274,7 @@ static void copy_node_bins(struct pglist_data *pgdat,
 }
 
 bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
-			struct pglist_data *pgdat)
+			struct pglist_data *pgdat, unsigned long *refresh_time)
 {
 	struct wsr_page_age_histo *page_age;
 	unsigned long refresh_interval = READ_ONCE(wsr->refresh_interval);
@@ -291,10 +291,14 @@ bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
 		goto unlock;
 	if (page_age->timestamp &&
 	    time_is_after_jiffies(page_age->timestamp + refresh_interval))
-		goto unlock;
+		goto time;
 	refresh_scan(wsr, root, pgdat, refresh_interval);
 	copy_node_bins(pgdat, page_age);
 	refresh_aggregate(page_age, root, pgdat);
+
+time:
+	if (refresh_time)
+		*refresh_time = page_age->timestamp + refresh_interval;
 unlock:
 	mutex_unlock(&wsr->page_age_lock);
 	return !!page_age;
@@ -357,6 +361,7 @@ static ssize_t refresh_interval_store(struct kobject *kobj,
 	unsigned int interval;
 	int err;
 	struct wsr_state *wsr = kobj_to_wsr(kobj);
+	unsigned long old_interval = 0;
 
 	err = kstrtouint(buf, 0, &interval);
 	if (err)
@@ -378,9 +383,13 @@ static ssize_t refresh_interval_store(struct kobject *kobj,
 		wsr->page_age = NULL;
 	}
 
+	old_interval = READ_ONCE(wsr->refresh_interval);
 	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(interval));
 unlock:
 	mutex_unlock(&wsr->page_age_lock);
+	if (!err && interval &&
+	    (!old_interval || jiffies_to_msecs(old_interval) > interval))
+		wsr_wakeup_aging_thread();
 	return err ?: len;
 }
 
@@ -470,7 +479,7 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 	int ret = 0;
 	struct wsr_state *wsr = kobj_to_wsr(kobj);
 
-	wsr_refresh_report(wsr, NULL, kobj_to_pgdat(kobj));
+	wsr_refresh_report(wsr, NULL, kobj_to_pgdat(kobj), NULL);
 
 	mutex_lock(&wsr->page_age_lock);
 	if (!wsr->page_age)
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
2.45.1.467.gbab1589fc0-goog


