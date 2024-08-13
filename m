Return-Path: <linux-kselftest+bounces-15254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55E0950AEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 19:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0592843AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4191A3BD2;
	Tue, 13 Aug 2024 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdVUSwHF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046391A3BA0
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568389; cv=none; b=rsTRC52lobHgsEyVsI98BAoOdCD+P7umR35MBR+rk/oIYCMwTpBoZcS2tAOzz9TddqSAW1gGHmCbyKexeTPqfML3yW455+g4qgaKsd7gKluPz7sl5VmuQpxy2qaihRMie+hdkgH5EsBVJZ6JFJnITqZzF0goR34/qKdeGJuP+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568389; c=relaxed/simple;
	bh=rsGrKoXAc8FxIjTMM2Zmrw32QSBwJqh9XHRtMaAmFmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZpOhhts6XQW+5M1hJeyZeLPG8Dozlw8c3ekdqub+NjKvc/uAC9aGqaMrBodbI4AVHi2EBMCQab0Ky/+7fzGsPIdfG0D5pNPw08QlWett+RhWRbxRsrWrhTORaxTHgGMavF157m/VQjy6FoCMmO+9Q1U0EYzj1HPQ0TVwlfKdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdVUSwHF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-68f95e37bbfso138464627b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723568386; x=1724173186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpAcupGObnfzDmBhsss97bo400nzNISpyaH5VDbdw9g=;
        b=sdVUSwHF3qHrznTWsQNsRWoAg+ZoL/j1lsJWLrQ2fd9/zLssXVbaflnedvOJOld+ex
         u4O1jNfIFWanWEYKgjcGnnc+seAexTiXIQZHnbva28G05/TWUsb/TVBKw6tJxAV0mC2J
         yYQTYdNiPpzFYxDi3E/WtVOiZGZ41PeQXRyGdeb4EPFo+vQouHLFLfSULYmCQSSsJFbR
         Z9IkI947SsfZ+fXm4fvVLXXsfa083BvMF03fd/7nffF4x1ZQH6A53ZIzdqrl1bN6pbHA
         oYAyMYB+G9uy/z85p3BWX+HZ559VpycoanOIPbIrqDcVr9WTM7bB5/HDT8NRvWy5+VoS
         AX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568386; x=1724173186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpAcupGObnfzDmBhsss97bo400nzNISpyaH5VDbdw9g=;
        b=tm8nKNQGq5lCbvEvLXwLkQlL1Hdfgz+h4affHZyy5c/H947SijZCdIvNjbZo/eZ/QT
         Zt5KJalcdLgTwRmPSgSB84lk9hM2JrQZNjeaNspd145yk2uHGwYKEJXRDrm3LtOOzFrz
         uaKWHLubtiyhvkvE9u3hTuIw9t/IoI9BB6UN+fZb4VkxTxpQ+IDU95svvu1Kt1wKMzTd
         iQk9Io7R7Y2PaIGZkL4QH+UNcVnUJr0xMSjN57+ZF3178godP6g28SZsxobw6MdBgAgg
         MU4HMGEFGXVKTjkbXzZTya1Fwq5tBuxos36IluJJXLetDNDf2AyaT19Z+bgr8Bnk2AUZ
         BWow==
X-Forwarded-Encrypted: i=1; AJvYcCX/6v9xxXpbgz7Nd7u+uwZOn7Z88F7f6KmK8bFKXbLp11JaZdVEJmXRffJCtPPZgY6uliQHaIHKxAKJmBUIbcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Ur3mZakWlxqyOvEYubzhMr7RMG5JsS3EX9n47PQSSLjIT8kR
	DlqnsjoI2wI6lFAwaWcKMyWV39em3uc3rcjzFx9fjLXaC36FqUbYLoPpRHQo89UHGGgCITup0wS
	F/GjWDg==
X-Google-Smtp-Source: AGHT+IHuzPFm66066+PM+qeXLjE3MUrZ+OKfquaNrkkMfQw82fR/11BL+BIef/h89u4WvUPnZWHI7Qy55Ias
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:b50c:66e8:6532:a371])
 (user=yuanchu job=sendgmr) by 2002:a0d:c607:0:b0:630:e8a:8a15 with SMTP id
 00721157ae682-6ac8feff7e5mr7727b3.0.1723568385881; Tue, 13 Aug 2024 09:59:45
 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:56:16 -0700
In-Reply-To: <20240813165619.748102-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813165619.748102-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813165619.748102-6-yuanchu@google.com>
Subject: [PATCH v3 5/7] mm: add kernel aging thread for workingset reporting
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

For reliable and timely aging on memcgs, one has to read the page age
histograms on time. A kernel thread makes it easier by aging memcgs with
valid refresh_interval when they can be refreshed, and also reduces the
latency of any userspace consumers of the page age histogram.

The kerne aging thread is gated behind CONFIG_WORKINGSET_REPORT_AGING.
Debugging stats may be added in the future for when aging cannot
keep up with the configured refresh_interval.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
Change-Id: Ia34a5d6b7eb91e39fab5f2d4ca2f18a9c370890b
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
index 951b4e7300d2..c1dfece5b71c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1272,6 +1272,12 @@ config WORKINGSET_REPORT
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
index 62cef72ce7f8..4a64b2454b6a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 obj-$(CONFIG_WORKINGSET_REPORT) += workingset_report.o
+obj-$(CONFIG_WORKINGSET_REPORT_AGING) += workingset_report_aging.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 56848dc94d48..52123b6cc9ce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4373,12 +4373,12 @@ static ssize_t memory_ws_refresh_interval_write(struct kernfs_open_file *of,
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
@@ -4397,9 +4397,13 @@ static ssize_t memory_ws_refresh_interval_write(struct kernfs_open_file *of,
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
 
@@ -4450,7 +4454,7 @@ static int memory_ws_page_age_show(struct seq_file *m, void *v)
 		if (!READ_ONCE(wsr->page_age))
 			continue;
 
-		wsr_refresh_report(wsr, memcg, NODE_DATA(nid));
+		wsr_refresh_report(wsr, memcg, NODE_DATA(nid), NULL);
 		mutex_lock(&wsr->page_age_lock);
 		if (!wsr->page_age)
 			goto unlock;
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 333e51e3ee12..6f64d89fe70d 100644
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
2.46.0.76.ge559c4bf1a-goog


