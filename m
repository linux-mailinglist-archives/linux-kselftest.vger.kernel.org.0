Return-Path: <linux-kselftest+bounces-9457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451408BB9C3
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 09:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E9A1C2126F
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C3817C7C;
	Sat,  4 May 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPv9KoG9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E202171C2
	for <linux-kselftest@vger.kernel.org>; Sat,  4 May 2024 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807853; cv=none; b=kQvPx71ucYXsLhou83P+Kbc+VCDRKz3vCZTiBFxA8z9OKMSXIOiMxUJb36T/yGh2IbmL5ZJ6SyHnz9F9KGHgKCdORaqIxrJvk8XCs74L3CoPmbyscK7nGjSD7ULASeRAn2JRtMByCuYBWapErI6UYQDYhX8NO8e3HWwExp9c9M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807853; c=relaxed/simple;
	bh=QoEQP71r0sLhLVdUCy47tqFkf/xeFd57hSMDzOdqrGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f1AeM2pnWb/9EbCo9R0IAK2eCMYPXvRBOXmzIKHJsprvyKyOhaUVdvb6cYjC6S4pxuVxiTIzq/ugo0BaNL7hdH3wifTChX+Q8AEr03nG3v6Ungw2HfJBVqXG4+FF+bjopbAkBHp7SblSySiAqpxfOMoxqI6YfEmRfptVxdu3WDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPv9KoG9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so1162627276.0
        for <linux-kselftest@vger.kernel.org>; Sat, 04 May 2024 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714807850; x=1715412650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+esKTT8j37wn7GqAICF1gBoKkjcIdKDssnbLJgB8I3o=;
        b=HPv9KoG9buPkZHNDFkJhQC7Ws3qQBnw6osOrxOE6I2LXXdfWpKRSa06MfgVn2eLheJ
         vEYahYHa8cWjmNRNnK63pooiS9yQ+vtzmUTD6IUnE5l5/5RbILB5A5cOwMpXKDqE5CzK
         ZMKbP/BjCFu2CV1Fr9scxW+NOm1fIBivn5vmhW7tNLcC9zMmXbd9GvNHoFSf/r5DcTK2
         rCRkZ1fJvL7exM21oLfhOMETD7+KQIK9MNVTC07jXwcO0grl1ak74nh0HO6LXBVm1SX7
         tBY7cLxN+aMw7Nk9JOQmbnqHW8rht6tGxdTdk5y8eJFNfIb7v7s3lxjsFIK+QQ3xTmj7
         +DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714807850; x=1715412650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+esKTT8j37wn7GqAICF1gBoKkjcIdKDssnbLJgB8I3o=;
        b=dE2fK/dEN4Sxmb4HmA4SACizCIGAeRhqnndUYZ1cRIyxkbGWyQvESg8Rn99rXAwBW5
         ZW2N05RNImKx2sg7tcOkg0j7U/oC29bxhILcl9i4yU9pzIcEf/6dA0HcVAa6EAG+JbZ8
         hRhNHGtrJTaQbijYyaex5BKUtXcuxgEsKgw7ueToPtFsThnl0ru/L8GPUjHvoG2fp/fV
         C9Ib5xEhifqC/S5yL+k433ffvpmYbZxPY4VCjv3N0CDErN+89PCOgkGKFQw7uyKrSEY4
         Rdwf++PP1S9niywI5Ge9n6iUr9IlF7tXhXE/TGCka+T0Ck7ll/sfcglx4/lehXNZUaYg
         AAiA==
X-Forwarded-Encrypted: i=1; AJvYcCWj64mBGo3B9BUxXSUPh2xM8kapwXBMi27aabnnaL6tp7bJcHEzb2ZTVBeCnL1TyE+Y92N+r6fBIpdGvATiZ6a/F6g1v0judPscpPBaDC7e
X-Gm-Message-State: AOJu0Ywph8zO5YVeKMicSXpZ+H19m1KVFjOQMeuKZ3JzXR0D4yGfjySg
	HjO01fLdxp4zYR4fTDJt2He8vAyEzxFVaoRoOU2Ra7IqqNFDPUWhJP+AE9GLX3GsW8TkhqReFKm
	4+8Qq9A==
X-Google-Smtp-Source: AGHT+IGpqecW4RBq1KKdblvfWTC4PDXr5GnnaakPH7N839yUP3w23VFJCVQbib80PviIg8Tn4iBf4ov4rT3U
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:da8f:bd07:9977:eb21])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:c11:b0:de5:2b18:3b74 with SMTP id
 fs17-20020a0569020c1100b00de52b183b74mr1531852ybb.2.1714807850514; Sat, 04
 May 2024 00:30:50 -0700 (PDT)
Date: Sat,  4 May 2024 00:30:07 -0700
In-Reply-To: <20240504073011.4000534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504073011.4000534-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240504073011.4000534-4-yuanchu@google.com>
Subject: [PATCH v1 3/7] mm: use refresh interval to rate-limit workingset
 report aggregation
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

The refresh interval is a rate limiting factor to workingset page age
histogram reads. When a workingset report is generated, a timestamp
is noted, and the same report will be read until it expires beyond
the refresh interval, at which point a new report is generated.

Sysfs interface
/sys/devices/system/node/nodeX/workingset_report/refresh_interval
	time in milliseconds specifying how long the report is valid for

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/workingset_report.h |  1 +
 mm/internal.h                     |  2 +-
 mm/vmscan.c                       | 27 +++++++----
 mm/workingset_report.c            | 81 +++++++++++++++++++++++++------
 4 files changed, 85 insertions(+), 26 deletions(-)

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index d7c2ee14ec87..8bae6a600410 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -37,6 +37,7 @@ struct wsr_page_age_histo {
 };
 
 struct wsr_state {
+	unsigned long refresh_interval;
 	/* breakdown of workingset by page age */
 	struct mutex page_age_lock;
 	struct wsr_page_age_histo *page_age;
diff --git a/mm/internal.h b/mm/internal.h
index 5e0caba64ee4..151f09c6983e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -210,7 +210,7 @@ extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason
  * in mm/wsr.c
  */
 /* Requires wsr->page_age_lock held */
-void wsr_refresh_scan(struct lruvec *lruvec);
+void wsr_refresh_scan(struct lruvec *lruvec, unsigned long refresh_interval);
 #endif
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9af6793a6534..b7293baac1dd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5620,7 +5620,7 @@ late_initcall(init_lru_gen);
  *                          workingset reporting
  ******************************************************************************/
 #ifdef CONFIG_WORKINGSET_REPORT
-void wsr_refresh_scan(struct lruvec *lruvec)
+void wsr_refresh_scan(struct lruvec *lruvec, unsigned long refresh_interval)
 {
 	DEFINE_MAX_SEQ(lruvec);
 	struct scan_control sc = {
@@ -5633,15 +5633,22 @@ void wsr_refresh_scan(struct lruvec *lruvec)
 	};
 	unsigned int flags;
 
-	set_task_reclaim_state(current, &sc.reclaim_state);
-	flags = memalloc_noreclaim_save();
-	/*
-	 * setting can_swap=true and force_scan=true ensures
-	 * proper workingset stats when the system cannot swap.
-	 */
-	try_to_inc_max_seq(lruvec, max_seq, &sc, true, true);
-	memalloc_noreclaim_restore(flags);
-	set_task_reclaim_state(current, NULL);
+	if (refresh_interval) {
+		int gen = lru_gen_from_seq(max_seq);
+		unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
+
+		if (time_is_before_jiffies(birth + refresh_interval)) {
+			set_task_reclaim_state(current, &sc.reclaim_state);
+			flags = memalloc_noreclaim_save();
+			/*
+			 * setting can_swap=true and force_scan=true ensures
+			 * proper workingset stats when the system cannot swap.
+			 */
+			try_to_inc_max_seq(lruvec, max_seq, &sc, true, true);
+			memalloc_noreclaim_restore(flags);
+			set_task_reclaim_state(current, NULL);
+		}
+	}
 }
 #endif /* CONFIG_WORKINGSET_REPORT */
 
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index 7b872b9fa7da..56155acbe7e9 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -195,7 +195,8 @@ static void collect_page_age(struct wsr_page_age_histo *page_age,
 
 /* First step: hierarchically scan child memcgs. */
 static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
-			 struct pglist_data *pgdat)
+			 struct pglist_data *pgdat,
+			 unsigned long refresh_interval)
 {
 	struct mem_cgroup *memcg;
 
@@ -203,7 +204,7 @@ static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-		wsr_refresh_scan(lruvec);
+		wsr_refresh_scan(lruvec, refresh_interval);
 		cond_resched();
 	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
 }
@@ -257,17 +258,25 @@ bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
 			struct pglist_data *pgdat)
 {
 	struct wsr_page_age_histo *page_age;
+	unsigned long refresh_interval = READ_ONCE(wsr->refresh_interval);
 
 	if (!READ_ONCE(wsr->page_age))
 		return false;
 
-	refresh_scan(wsr, root, pgdat);
+	if (!refresh_interval)
+		return false;
+
 	mutex_lock(&wsr->page_age_lock);
 	page_age = READ_ONCE(wsr->page_age);
-	if (page_age) {
-		copy_node_bins(pgdat, page_age);
-		refresh_aggregate(page_age, root, pgdat);
-	}
+	if (!page_age)
+		goto unlock;
+	if (page_age->timestamp &&
+	    time_is_after_jiffies(page_age->timestamp + refresh_interval))
+		goto unlock;
+	refresh_scan(wsr, root, pgdat, refresh_interval);
+	copy_node_bins(pgdat, page_age);
+	refresh_aggregate(page_age, root, pgdat);
+unlock:
 	mutex_unlock(&wsr->page_age_lock);
 	return !!page_age;
 }
@@ -286,6 +295,52 @@ static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
 	return &mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj))->wsr;
 }
 
+static ssize_t refresh_interval_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+	unsigned int interval = READ_ONCE(wsr->refresh_interval);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(interval));
+}
+
+static ssize_t refresh_interval_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t len)
+{
+	unsigned int interval;
+	int err;
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+
+	err = kstrtouint(buf, 0, &interval);
+	if (err)
+		return err;
+
+	mutex_lock(&wsr->page_age_lock);
+	if (interval && !wsr->page_age) {
+		struct wsr_page_age_histo *page_age =
+			kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL);
+
+		if (!page_age) {
+			err = -ENOMEM;
+			goto unlock;
+		}
+		wsr->page_age = page_age;
+	}
+	if (!interval && wsr->page_age) {
+		kfree(wsr->page_age);
+		wsr->page_age = NULL;
+	}
+
+	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(interval));
+unlock:
+	mutex_unlock(&wsr->page_age_lock);
+	return err ?: len;
+}
+
+static struct kobj_attribute refresh_interval_attr =
+	__ATTR_RW(refresh_interval);
+
 static ssize_t page_age_intervals_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
@@ -369,13 +424,6 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 	int ret = 0;
 	struct wsr_state *wsr = kobj_to_wsr(kobj);
 
-
-	mutex_lock(&wsr->page_age_lock);
-	if (!wsr->page_age)
-		wsr->page_age =
-			kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL);
-	mutex_unlock(&wsr->page_age_lock);
-
 	wsr_refresh_report(wsr, NULL, kobj_to_pgdat(kobj));
 
 	mutex_lock(&wsr->page_age_lock);
@@ -401,7 +449,10 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 static struct kobj_attribute page_age_attr = __ATTR_RO(page_age);
 
 static struct attribute *workingset_report_attrs[] = {
-	&page_age_intervals_attr.attr, &page_age_attr.attr, NULL
+	&refresh_interval_attr.attr,
+	&page_age_intervals_attr.attr,
+	&page_age_attr.attr,
+	NULL
 };
 
 static const struct attribute_group workingset_report_attr_group = {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


