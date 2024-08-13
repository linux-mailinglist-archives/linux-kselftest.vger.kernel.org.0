Return-Path: <linux-kselftest+bounces-15252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D58950AE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 19:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EE61C22BA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810F1A38DB;
	Tue, 13 Aug 2024 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlJ+ydgf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723D1A2C22
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568385; cv=none; b=l7yu/0YWxYEVA8ZJ2pzOpC4xGUv528qkt/d1bjrWum7+eKYWQf0rS5oue5SOgeTZ8bXVLiQuNQ5TUlPkU0Gs8vHnQhiLjz9HQocKjoBMzeH2jwV/JwVOqaEnX45JRfrN7fUq2qhbjyQQej61RUombItZlA5XqmNwZcqAdARf3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568385; c=relaxed/simple;
	bh=uUt4ZAicTtOcUFBajc2Rcm/DS6stfUhYzd+Acgyt79g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cvWyVTDZ4zt7mWO93BLZUDxvcxHX7lj5aSoa2wRJ+CHZVinWPfuSb8ZyzHkk6NNeItBogzuLyM4ZzK7kYzoRP1yU0ABAwK8wB6FhiUksd6e0V98+9CvveS1OvwVwdF/c1OLHheMSIdSZnemM58e0HhjsU7aYtfILmpZHja75YnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlJ+ydgf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664bc570740so1072097b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723568382; x=1724173182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1JUyOR+BauD0beWrpDUPXKr0GpTowWtPDSwnxHbi4c=;
        b=IlJ+ydgfsQVGD8V5EZalojt0t8crnWOVXavzywaQ7Jf5nNZbWQktI6u+EEWwF3OcBi
         PzZFmPY9kXHnCTqhgo9g6R1R88vbfDsMpaDEDHz1v9AVFAmJRjeWSUFQgl2xu/zXWwri
         qYGYYLfuHxweY+fWH6CNZf97W3w6dPIbIYoBPXHGSoTZfwK62XrATImy+GfwasCNV7Rt
         fhNGrdRUk8NnSyjNhO1x0MTz9Cys0+MNPZ/hbRCiQoePfPYGo2OGEaMhtK7oZiLQJyjT
         uhkSfMIR0ivCHBGotLCpQUVa1/AUBje7cxFnexmDIT2V/n6CLqVTc9s+RWzcI+orO26B
         HG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568382; x=1724173182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1JUyOR+BauD0beWrpDUPXKr0GpTowWtPDSwnxHbi4c=;
        b=WQSzTcepESxo1Ihej3GVbmUxIcVu6LM1yu/AeCAoOiarC2Smwk9bNEAUvjssRlWGSM
         /W7O/O3STSlXBMGdhPBZGQDHpF898N5ojeIDZZwu8j7bmeSTdAdVQrzA7Z/GjRWDUfOY
         OOh8+eGdKwUk2z5ShXGWT4Zm1UtFWg3UuznwatvstBa+Lc84BGnQODa5LYh+2y3QB/FQ
         lr3NhAGPydmmN6exhJqL2GJtXRnltpyD74s1h2YGBg8RzIlOJiYlkb+qXPSMY+nrPpBe
         U2NzlMxvNmDAM3D6pKw+y58DWZaCm0D1hdNVoe1wLDg9j7sgMJObhRCbrBOk7uKYjwLe
         9NsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKFEYVPIg2HBFCgQMU4XjoCf+pPJdAkq7k0llsElUWi1JntEsiiaH8j06MbPXPJDQwhOKf0MDd42MNRQjgUKnz/t/l0y26gtPpChGMaYK4
X-Gm-Message-State: AOJu0YzALMl1pgaYqB+GOpBKdEKI/IORx1C6HcPr7Mh7wjjxj2RDIZ85
	y0owMm8AQLE3VnTBisJwpBkgVpRnw3d56I7x1v1PtM28KfkyTzs6a6VocAGGkNJsZLsBV7/Z0AW
	1F2QNhg==
X-Google-Smtp-Source: AGHT+IGF6gcvOUuK0qRwt2F4MDLyEzr3H7dooXhW2VhDhQ7vMG1kJd5bUtwNOeRY1xrvYnGAuUjldLTxpbDJ
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:b50c:66e8:6532:a371])
 (user=yuanchu job=sendgmr) by 2002:a0d:ce01:0:b0:6a1:741b:b723 with SMTP id
 00721157ae682-6a9ea8e5238mr545567b3.5.1723568381863; Tue, 13 Aug 2024
 09:59:41 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:56:14 -0700
In-Reply-To: <20240813165619.748102-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813165619.748102-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813165619.748102-4-yuanchu@google.com>
Subject: [PATCH v3 3/7] mm: report workingset during memory pressure driven scanning
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

When a node reaches its low watermarks and wakes up kswapd, notify all
userspace programs waiting on the workingset page age histogram of the
memory pressure, so a userspace agent can read the workingset report in
time and make policy decisions, such as logging, oom-killing, or
migration.

Sysfs interface:
/sys/devices/system/node/nodeX/workingset_report/report_threshold
	time in milliseconds that specifies how often the userspace
	agent can be notified for node memory pressure.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
Change-Id: Ib1fdb726da921e8d467822a99da8f384c6181951
---
 include/linux/workingset_report.h |  4 +++
 mm/internal.h                     | 12 ++++++++
 mm/vmscan.c                       | 46 +++++++++++++++++++++++++++++++
 mm/workingset_report.c            | 43 ++++++++++++++++++++++++++++-
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index 8bae6a600410..2ec8b927b200 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -37,7 +37,11 @@ struct wsr_page_age_histo {
 };
 
 struct wsr_state {
+	unsigned long report_threshold;
 	unsigned long refresh_interval;
+
+	struct kernfs_node *page_age_sys_file;
+
 	/* breakdown of workingset by page age */
 	struct mutex page_age_lock;
 	struct wsr_page_age_histo *page_age;
diff --git a/mm/internal.h b/mm/internal.h
index f7d790f5d41c..19af882c506e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -416,6 +416,18 @@ bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq, bool can_swap,
 			bool force_scan);
 void set_task_reclaim_state(struct task_struct *task, struct reclaim_state *rs);
 
+#ifdef CONFIG_WORKINGSET_REPORT
+/*
+ * in mm/wsr.c
+ */
+void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat);
+#else
+static inline void notify_workingset(struct mem_cgroup *memcg,
+				     struct pglist_data *pgdat)
+{
+}
+#endif
+
 /*
  * in mm/rmap.c:
  */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8ab1b456d2cf..b07fd2016c75 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2574,6 +2574,15 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
 	return can_demote(pgdat->node_id, sc);
 }
 
+#ifdef CONFIG_WORKINGSET_REPORT
+static void try_to_report_workingset(struct pglist_data *pgdat, struct scan_control *sc);
+#else
+static inline void try_to_report_workingset(struct pglist_data *pgdat,
+					    struct scan_control *sc)
+{
+}
+#endif
+
 #ifdef CONFIG_LRU_GEN
 
 #ifdef CONFIG_LRU_GEN_ENABLED
@@ -4000,6 +4009,8 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 
 	set_initial_priority(pgdat, sc);
 
+	try_to_report_workingset(pgdat, sc);
+
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
@@ -5640,6 +5651,38 @@ static int __init init_lru_gen(void)
 };
 late_initcall(init_lru_gen);
 
+#ifdef CONFIG_WORKINGSET_REPORT
+static void try_to_report_workingset(struct pglist_data *pgdat,
+				     struct scan_control *sc)
+{
+	struct mem_cgroup *memcg = sc->target_mem_cgroup;
+	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
+	unsigned long threshold = READ_ONCE(wsr->report_threshold);
+
+	if (sc->priority == DEF_PRIORITY)
+		return;
+
+	if (!threshold)
+		return;
+
+	if (!mutex_trylock(&wsr->page_age_lock))
+		return;
+
+	if (!wsr->page_age) {
+		mutex_unlock(&wsr->page_age_lock);
+		return;
+	}
+
+	if (time_is_after_jiffies(wsr->page_age->timestamp + threshold)) {
+		mutex_unlock(&wsr->page_age_lock);
+		return;
+	}
+
+	mutex_unlock(&wsr->page_age_lock);
+	notify_workingset(memcg, pgdat);
+}
+#endif /* CONFIG_WORKINGSET_REPORT */
+
 #else /* !CONFIG_LRU_GEN */
 
 static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
@@ -6191,6 +6234,9 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
+
+		if (!sc->proactive)
+			try_to_report_workingset(zone->zone_pgdat, sc);
 		shrink_node(zone->zone_pgdat, sc);
 	}
 
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index fe553c0a653e..801ac8e5c1da 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -311,6 +311,33 @@ static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
 	return &mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj))->wsr;
 }
 
+static ssize_t report_threshold_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+	unsigned int threshold = READ_ONCE(wsr->report_threshold);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(threshold));
+}
+
+static ssize_t report_threshold_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t len)
+{
+	unsigned int threshold;
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+
+	if (kstrtouint(buf, 0, &threshold))
+		return -EINVAL;
+
+	WRITE_ONCE(wsr->report_threshold, msecs_to_jiffies(threshold));
+
+	return len;
+}
+
+static struct kobj_attribute report_threshold_attr =
+	__ATTR_RW(report_threshold);
+
 static ssize_t refresh_interval_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
@@ -465,6 +492,7 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 static struct kobj_attribute page_age_attr = __ATTR_RO(page_age);
 
 static struct attribute *workingset_report_attrs[] = {
+	&report_threshold_attr.attr,
 	&refresh_interval_attr.attr,
 	&page_age_intervals_attr.attr,
 	&page_age_attr.attr,
@@ -486,8 +514,13 @@ void wsr_init_sysfs(struct node *node)
 
 	wsr = kobj_to_wsr(kobj);
 
-	if (sysfs_create_group(kobj, &workingset_report_attr_group))
+	if (sysfs_create_group(kobj, &workingset_report_attr_group)) {
 		pr_warn("Workingset report failed to create sysfs files\n");
+		return;
+	}
+
+	wsr->page_age_sys_file =
+		kernfs_walk_and_get(kobj->sd, "workingset_report/page_age");
 }
 EXPORT_SYMBOL_GPL(wsr_init_sysfs);
 
@@ -500,6 +533,14 @@ void wsr_remove_sysfs(struct node *node)
 		return;
 
 	wsr = kobj_to_wsr(kobj);
+	kernfs_put(wsr->page_age_sys_file);
 	sysfs_remove_group(kobj, &workingset_report_attr_group);
 }
 EXPORT_SYMBOL_GPL(wsr_remove_sysfs);
+
+void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat)
+{
+	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
+
+	kernfs_notify(wsr->page_age_sys_file);
+}
-- 
2.46.0.76.ge559c4bf1a-goog


