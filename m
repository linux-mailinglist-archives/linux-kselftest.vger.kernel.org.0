Return-Path: <linux-kselftest+bounces-9460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 057038BB9D1
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 09:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C596B22600
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 07:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA6E2031D;
	Sat,  4 May 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4OXVLhDZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA2FBF0
	for <linux-kselftest@vger.kernel.org>; Sat,  4 May 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807859; cv=none; b=Ncvad+2cdUJoD/HfzFVQKkWGrxFJvCdojToYopNSZGgU9q0Md8R0jp5dnqc/p7cEdNlM0gYMt2zPZ0j91xk1AiymeAdhgcHibW4+zyhTClVWkJK4AOBxOYjLA7Jt3UQokmDuT0jLZWTz/F8yQWZoCmE3JpM6EYUAYVnbvBbrwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807859; c=relaxed/simple;
	bh=behUX3jjuMClKmnueKgHMjdB/LO1/p0zjg69wS3+fro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J6gb0sbM02vRu3NB6yN74zJbZfyIAXLVyMv2w6s0lwPY/yCCzSany+bvoPIAickNy95rmuFwvdtJCKPaHFLHSQ7JzQjTR0FDep6acfLmmOCiFVcul6KAqjLqt5TfMI6YAuGSoVCxhbT2Mh7YR4P+3TEBjx1xXOp0xF3R4catmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4OXVLhDZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de617c7649dso904625276.0
        for <linux-kselftest@vger.kernel.org>; Sat, 04 May 2024 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714807856; x=1715412656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rp6y1AtpkHfeXuTgpbngprvPTppmrZY5FskXOV8DSWk=;
        b=4OXVLhDZ6NRYxuizriSi6cA4LGUsT5EbRG6qIZnzqCIoO/0RXr7nelf6Nhi1kFwIxn
         DCDmsM4l3s/kEvUKtoTQuRXEG1MPUS52fpLTCnfmO3u8uKKBaASuAZCXTU/t8cgcCc5v
         qgCPYl8FRoxOMmI78zYJdGdyCBsV55IckaNZAvFYkXjbh3/qlOYZYPxgB7X4Fz0fsP/S
         NtPEC8F+9NFFJcyHqG3NcZfcxqNYkZlKwhJ1aiOn75zT2i12/pfuqr57uD9PHV4UWVmV
         OF/GrS+xIqA6ZzWZdKhRpHgtrEK/Da+BMcoqtUn6tsCYXEDPSJQmaqU5mUUyo4Ow9cmT
         6JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714807856; x=1715412656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rp6y1AtpkHfeXuTgpbngprvPTppmrZY5FskXOV8DSWk=;
        b=VhDkaHgWGV3oMpVkr2q2pb7bsWtVAn1cI6ztYm5kKuBH+c0A4OcvOOzSrBzM25jV52
         ozp3hKWULqJOBCEtLe+HhNzhP1iIti/jaORD3eD4olMCDeFEGWb5dAwtkShwrhh2iQSv
         7NApgOiSa9wz8BnDR0RAjltRHf9dEpR8B8ih2SUWRFVDAG6+8ed2C72SyKniWTGZf3Sj
         hcFbE4+c4YFoDrk7gD58AZCOHsaiRSDqdyy/Jo/h1Uj8rA2el1ixAIlH2neBZvv6Ot6p
         oEQj1O5lpXJhjgePyl9c9LFJEzOOYLg0zxVm/a7t1RX/HH33N+NRcHPQSnDKxQ7LKJgM
         LgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4OOYtmTr+rofqAiw7qUffiouEfP3M0fZ8UJ9vDXzwbn9AFmepNtmfMmZOIRnIZh1SuEYJh25a/VKfof36pjQpP5uu5Cdr1NGUkl65ojgV
X-Gm-Message-State: AOJu0YwufECeZUVt9ept27tYKvF9+UvQetYQHDaJ0E99Q11Vlf4S0kgI
	oY6QCIfANht0t9WSqlnC9pfLoLMa/AEmSE8W9Pk3DLsk5B91rK5PnHwVuhYTQDlv+D+JsRlhj5K
	Xyt7jog==
X-Google-Smtp-Source: AGHT+IGU6CJeYeCi16Op/dGx3kAMymE/Mcfr7yxitn52cAsdXe0smsbTYAlXgGjRedM+9wSAtFV6UoqmPn5w
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:da8f:bd07:9977:eb21])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:1242:b0:de6:1603:2dd5 with SMTP
 id t2-20020a056902124200b00de616032dd5mr680541ybu.9.1714807856331; Sat, 04
 May 2024 00:30:56 -0700 (PDT)
Date: Sat,  4 May 2024 00:30:10 -0700
In-Reply-To: <20240504073011.4000534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504073011.4000534-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240504073011.4000534-7-yuanchu@google.com>
Subject: [PATCH v1 6/7] mm: add kernel aging thread for workingset reporting
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
index c6c0d2772279..6ada26da6de6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7060,12 +7060,12 @@ static ssize_t memory_ws_refresh_interval_write(struct kernfs_open_file *of,
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
@@ -7084,9 +7084,13 @@ static ssize_t memory_ws_refresh_interval_write(struct kernfs_open_file *of,
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
 
@@ -7137,7 +7141,7 @@ static int memory_ws_page_age_show(struct seq_file *m, void *v)
 		if (!READ_ONCE(wsr->page_age))
 			continue;
 
-		wsr_refresh_report(wsr, memcg, NODE_DATA(nid));
+		wsr_refresh_report(wsr, memcg, NODE_DATA(nid), NULL);
 		mutex_lock(&wsr->page_age_lock);
 		if (!wsr->page_age)
 			goto unlock;
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 5a9bf3ebb914..46bb9469d5b3 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -258,7 +258,7 @@ static void copy_node_bins(struct pglist_data *pgdat,
 }
 
 bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
-			struct pglist_data *pgdat)
+			struct pglist_data *pgdat, unsigned long *refresh_time)
 {
 	struct wsr_page_age_histo *page_age;
 	unsigned long refresh_interval = READ_ONCE(wsr->refresh_interval);
@@ -275,10 +275,14 @@ bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
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
@@ -341,6 +345,7 @@ static ssize_t refresh_interval_store(struct kobject *kobj,
 	unsigned int interval;
 	int err;
 	struct wsr_state *wsr = kobj_to_wsr(kobj);
+	unsigned long old_interval = 0;
 
 	err = kstrtouint(buf, 0, &interval);
 	if (err)
@@ -362,9 +367,13 @@ static ssize_t refresh_interval_store(struct kobject *kobj,
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
 
@@ -454,7 +463,7 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
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
2.45.0.rc1.225.g2a3ae87e7f-goog


