Return-Path: <linux-kselftest+bounces-9458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F96C8BB9C9
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 09:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A6EB213C1
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 07:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117A8BA42;
	Sat,  4 May 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVr/XQmT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1D517C9E
	for <linux-kselftest@vger.kernel.org>; Sat,  4 May 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807854; cv=none; b=A7lC1I9jYH5tEdqCuYRt3wNAQVS3hoq5YjrOEuQCqT6rmZHExz2oEmqpeyWLhu6koJVZxYMSby/dLW8W6xWPZU0jW/zf2wLtXoGNrxDfEANXSQ472G0tD+v2JjNv5L2hQMoLvL17q3smrlcIbdGQtuopJkTJHX/zYPivC1y+yJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807854; c=relaxed/simple;
	bh=8BYM/0bwfvRiN/1tSxdyuXR2N0rM8FmGTxJpEOr2hEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XHm3EaRllJwlnvRrQvdzm2E5XjXbbrDChvJriXJGdc2vulvYICN1opbg3cHKVNPA8plzE++O/o8qyfL9AFy7OzOl4HADriU+QoEDA08Kc1hRFIRKRVgRF/SLQso7MPcibrFelJSrmrA0XKkwyPolAH+UtMkaWrOm+IfKsaqoZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVr/XQmT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso791441276.1
        for <linux-kselftest@vger.kernel.org>; Sat, 04 May 2024 00:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714807852; x=1715412652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xaEmyCMslYMwuxpJOVLJZ4UUBBVY/3Xfmzid12imJ38=;
        b=tVr/XQmTSO43vov5hcBa+jICF9/V5HkyIoGvjGJ86xu0ixLHgupRkWVxJOoSoP18i9
         94TcOD06goxs9eV40sZ3HQVefv+aD0SlbrpZ0FoJ7P7LkiG3nWUuHYPINQcfWHUfaIgh
         PUQDInFzLW2CLZ7EO0ASoiLOk9WGPOzwR7ggGmJKgJnNhr3KesmikmMpEu3PiAYkkoCc
         myQOXwiUqCGeQyV/r/YIODoIsajgtsvjfDi9J5ewmyquxXlQPkkc5Vtm3O72qNJD+Mh1
         Rmo7kHMxQLjQB8VPPT6RiPwnj/mc8Tl8gzrGnCiABinQkKnOtJco8h5gsDi8fEDL1jra
         GU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714807852; x=1715412652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaEmyCMslYMwuxpJOVLJZ4UUBBVY/3Xfmzid12imJ38=;
        b=wRvNBPGXTf5QXIprocDQmYFYllrvk2w484KxUEeHjKrdf8J2eY/a4xKRkdp13Lny7S
         24C9mu2Iz4VkMKenKveB4qGDtZMyCH1x2IYs9//O5wuB3HBvEYn9BEZB7UK/3TtOWYGw
         tQW1zqcQz16cBpxsVOmgSLyYsehqJ7dIG7XfZeQ2qthN98UToUXauG6ijJj/PCv2xG0S
         4OE9Mp/J3NHE0ao80KzBsczVKYvmWvnz8dilkBs+hhMdjpPgXuGkqW6l508ygMvZrkvE
         KD1UCM6lMr375iklMwM/nFB15cPMVS3IFHgaFGhJMKnvcqHUpVAU/IlxkHqwAcSiKhW8
         325w==
X-Forwarded-Encrypted: i=1; AJvYcCWkgtmfG4pm7nGMg3oxh/ym8lbXOgyj3SFP3F4FZRSR56Jncjki9wjskh3HWQf8aZACVfdCdrFAc+SoAIyOW4RlNC2VY5idfJX1LveQEm+T
X-Gm-Message-State: AOJu0YydaYCzTDUzjSU4uRmAWyg6OstXp4tOaQA2D3g8VinF+gL0m61F
	9DlRyLSzxMz1+tR3mOWBPL77Q0rQroMhLHGpxL1eOJN2BcfgUMU+cnWkAt0zNAfLtXShrCSCJJp
	bN01djw==
X-Google-Smtp-Source: AGHT+IEgDXzTdXOaK7MXB2FveB9irK572Lq296aA+UDNA71AYoSKYZI3L/RyqxlpQ13Ivr5db64iti7/LGM0
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:da8f:bd07:9977:eb21])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:c0b:b0:de5:3003:4b83 with SMTP id
 fs11-20020a0569020c0b00b00de530034b83mr681924ybb.8.1714807852560; Sat, 04 May
 2024 00:30:52 -0700 (PDT)
Date: Sat,  4 May 2024 00:30:08 -0700
In-Reply-To: <20240504073011.4000534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504073011.4000534-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240504073011.4000534-5-yuanchu@google.com>
Subject: [PATCH v1 4/7] mm: report workingset during memory pressure driven scanning
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
---
 include/linux/workingset_report.h |  4 +++
 mm/internal.h                     |  6 +++++
 mm/vmscan.c                       | 44 +++++++++++++++++++++++++++++++
 mm/workingset_report.c            | 43 +++++++++++++++++++++++++++++-
 4 files changed, 96 insertions(+), 1 deletion(-)

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
index 151f09c6983e..36480c7ac0dd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -209,8 +209,14 @@ extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason
 /*
  * in mm/wsr.c
  */
+void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat);
 /* Requires wsr->page_age_lock held */
 void wsr_refresh_scan(struct lruvec *lruvec, unsigned long refresh_interval);
+#else
+static inline void notify_workingset(struct mem_cgroup *memcg,
+				     struct pglist_data *pgdat)
+{
+}
 #endif
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b7293baac1dd..1f11b252c15e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2535,6 +2535,15 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
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
@@ -3936,6 +3945,8 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	if (!min_ttl || sc->order || sc->priority == DEF_PRIORITY)
 		return;
 
+	try_to_report_workingset(pgdat, sc);
+
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
@@ -5650,6 +5661,36 @@ void wsr_refresh_scan(struct lruvec *lruvec, unsigned long refresh_interval)
 		}
 	}
 }
+
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
 #endif /* CONFIG_WORKINGSET_REPORT */
 
 #else /* !CONFIG_LRU_GEN */
@@ -6177,6 +6218,9 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
+
+		if (!sc->proactive)
+			try_to_report_workingset(zone->zone_pgdat, sc);
 		shrink_node(zone->zone_pgdat, sc);
 	}
 
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 56155acbe7e9..7dcf38525016 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -295,6 +295,33 @@ static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
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
@@ -449,6 +476,7 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 static struct kobj_attribute page_age_attr = __ATTR_RO(page_age);
 
 static struct attribute *workingset_report_attrs[] = {
+	&report_threshold_attr.attr,
 	&refresh_interval_attr.attr,
 	&page_age_intervals_attr.attr,
 	&page_age_attr.attr,
@@ -470,8 +498,13 @@ void wsr_init_sysfs(struct node *node)
 
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
 
@@ -484,6 +517,14 @@ void wsr_remove_sysfs(struct node *node)
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
2.45.0.rc1.225.g2a3ae87e7f-goog


