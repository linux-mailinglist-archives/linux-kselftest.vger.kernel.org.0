Return-Path: <linux-kselftest+bounces-22551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534939DA0DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 03:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCF9168DEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 02:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A27146017;
	Wed, 27 Nov 2024 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7VrsVia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17C13D613
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676275; cv=none; b=iI4sCtzJomfS/J5Gj5AFthU8IyOZutuQxa8aVj68r7iBQU5O4fwZJKyNogCXg8GpMxNubwUxr4EzgZxLg2fEPXmvmk9RDZgQpEasYzdcAyPZJVdU8FlUV483SbpAHxgnl9tETCa0d6RbXZv8uBt/hYIuWeOgsNzdHXimaaC/l7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676275; c=relaxed/simple;
	bh=QBepoMOHoV4DwOBPejg0o5SckReMvASw8L0MVT06MTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EIHqaLwJol6J+G9hNDvddqi1u1FipUNoENPVDqO0UXgKqaANbBnhepxzz1vcvWm6UzLu1yIxYY5FcAVkisVo8mStx367glbULBADzVv98bRuYJpGKev1fiezeI9sZ+PVrSJgz6+RjgM8HpiYRBcXKnpBqXie1jKtZeSo8BNBsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7VrsVia; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2967f717d96so3925642fac.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 18:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732676272; x=1733281072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/WPTXcvcabaljBBrVkxMdtvNE4T0NFrHkMqJHgXQGk=;
        b=K7VrsViasR8HP4IXX4yG/dIsp615KetwHDwyLI6h187uVaXalPl5nDfJTIexXugV0+
         CzpIdOhxvNz0lC2b6ssOlyGL+mY4mjBjlqaItaEac57yd2APhv+9RHIf97zOIPQ4GwEN
         6FLNJkTWSaS+2d8F2EV66nrG7K3y/W+J0PIRHGVuoVDZJj39imUtzQ+t6qtU2XvLz+WY
         WPr74nPceXyYoxTty5BJj9QA4m6qSZDDpuJmRf2rm0SyA+zRKcqihH9S/PXEc6u2Nzho
         SJH0svdveiFH1lRSZrVxGObYjaO5pFF0Dx+ZWdJfiMc5gjb4Y7R5XW6OntgPRGMHuD5y
         Sz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676272; x=1733281072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/WPTXcvcabaljBBrVkxMdtvNE4T0NFrHkMqJHgXQGk=;
        b=sBvZXAT/PnR4MCzQHyv+yWhnMbvxgJyGzfOFdDHzGf7DJ159UMBFffvkn11GbiiEiZ
         xdGWGvJJUctKflARCDwNcjQVMjHuw5CRfvKeJrvdZ4j6uagzHbo/mEiDlsjhkdILjOuV
         VHAfZg3I9Qus5Q633dCJdMLSCerwhUzxnHCielLNWeErzDBMYR5TFxha/1/rvRzdueEK
         AfkH1dChWEr/99xr6i9L2WrxUKK9umod4Y2zg0O4Z0hW8Q/kc8to2Ny6zUdmIo1uU+jb
         w9zvP3rlVTo9DdI0IYhu+3oULbD2yIO9aZM0zTVOYLJ4O+HIpmCfJaNnXf3Pac3dYk6n
         Uf7g==
X-Forwarded-Encrypted: i=1; AJvYcCVynP/oQLAc/bKbtpgFfx9GemEP4Py+m2tT35AGJvwqFsaxoPHAEAXhETQHaQky2KmXrpjQbzcR/gCpnUh0IA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvFcfBBeEWUlrTnt31Yzslwo5oLSb/teHwIj/VwxLT1b3uYwl
	uD+M9yGTK2ORqYoOkfH/6EyyU5dr9bC22k97WeR/hLJ4LiLo+EptcEfjiaDjU/s8BHQ8/qU18tX
	abmmkWg==
X-Google-Smtp-Source: AGHT+IFRcRWDlCpSpvonVfz6gqukD5+iS1Nh+k6upjKjqm+Gv9S2zOic8Epnn/W/99f5T4mKjm5ZX+88GSwn
X-Received: from oacnq1.prod.google.com ([2002:a05:6871:3781:b0:296:523f:4d02])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:4996:b0:297:2376:9b07
 with SMTP id 586e51a60fabf-29dc400538dmr1178830fac.10.1732676272567; Tue, 26
 Nov 2024 18:57:52 -0800 (PST)
Date: Tue, 26 Nov 2024 18:57:24 -0800
In-Reply-To: <20241127025728.3689245-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127025728.3689245-6-yuanchu@google.com>
Subject: [PATCH v4 5/9] mm: add kernel aging thread for workingset reporting
From: Yuanchu Xie <yuanchu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, Yuanchu Xie <yuanchu@google.com>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
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
 include/linux/workingset_report.h |  10 ++-
 mm/Kconfig                        |   6 ++
 mm/Makefile                       |   1 +
 mm/memcontrol.c                   |   2 +-
 mm/workingset_report.c            |  13 ++-
 mm/workingset_report_aging.c      | 127 ++++++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 5 deletions(-)
 create mode 100644 mm/workingset_report_aging.c

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index 616be6469768..f6bbde2a04c3 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -64,7 +64,15 @@ void wsr_remove_sysfs(struct node *node);
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
 
 int wsr_set_refresh_interval(struct wsr_state *wsr,
 			     unsigned long refresh_interval);
diff --git a/mm/Kconfig b/mm/Kconfig
index be949786796d..a8def8c65610 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1310,6 +1310,12 @@ config WORKINGSET_REPORT
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
index f5ef0768253a..3a282510f960 100644
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
index d1032c6efc66..ea83f10b22a1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4462,7 +4462,7 @@ static int memory_ws_page_age_show(struct seq_file *m, void *v)
 		if (!READ_ONCE(wsr->page_age))
 			continue;
 
-		wsr_refresh_report(wsr, memcg, NODE_DATA(nid));
+		wsr_refresh_report(wsr, memcg, NODE_DATA(nid), NULL);
 		mutex_lock(&wsr->page_age_lock);
 		if (!wsr->page_age)
 			goto unlock;
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 1e1bdb8bf75b..dad539e602bb 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -283,7 +283,7 @@ static void copy_node_bins(struct pglist_data *pgdat,
 }
 
 bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
-			struct pglist_data *pgdat)
+			struct pglist_data *pgdat, unsigned long *refresh_time)
 {
 	struct wsr_page_age_histo *page_age;
 	unsigned long refresh_interval = READ_ONCE(wsr->refresh_interval);
@@ -300,10 +300,14 @@ bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
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
@@ -386,6 +390,9 @@ int wsr_set_refresh_interval(struct wsr_state *wsr,
 	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(refresh_interval));
 unlock:
 	mutex_unlock(&wsr->page_age_lock);
+	if (!err && refresh_interval &&
+	    (!old_interval || jiffies_to_msecs(old_interval) > refresh_interval))
+		wsr_wakeup_aging_thread();
 	return err;
 }
 
@@ -491,7 +498,7 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
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
2.47.0.338.g60cca15819-goog


