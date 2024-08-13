Return-Path: <linux-kselftest+bounces-15251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05AB950AE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C640282A72
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E3F1A2C17;
	Tue, 13 Aug 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cf6TjRSD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15881A257B
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568382; cv=none; b=c6nLuDkJibap2ig8L8ZthTpQhy0V4Sh4GcAA+c3dALQ5myOH0UqFZ9rGEqwY2ja/QXrZTwd/aqKCc9x+D24BLUR2Rn9oQ1+Fv1k6NR8zAxVu1UtcFzkLDCKhfaX6V+ozPIvN2uewZdUKyliMGaeNgN2Q/+Teklv7T1HM7qaOz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568382; c=relaxed/simple;
	bh=FnqAQTPwgBVVzDcbida/hFCCtbq3A4I5BvukZxTAxKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jj9HNT3GZqI7WHPfFBk/g+/MxEvsdROc4MVCoYEnlaG9RF4mKx4hQLQF43LXOPsXiDbCJVIc3afYW6EG+vzN4bOOoWVT3Cz1ovG0IjvOXkwIbO49TYYU9WIF87U8R3ux3VdVukyuXpXF7jssqkUJaAUHzuU7zu12xIU/OieFKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cf6TjRSD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-688777c95c4so133226207b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723568380; x=1724173180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqd1jKx+q5wvRHFsKe7RtJaTNM99zPu8YKm8b61Swh4=;
        b=cf6TjRSD7hGi1Z7Qu23XIG7vOAiRc4PCOA0hLBhX5rg3pFiqeJto/+2dl2U1fEBCYI
         3Won33Z1AGzKo2aSR5vWaq23zzlSFoGFFa7elnDhiXcQ1/vRt7Hv7drl/fwyi+SZ3Aq7
         R63j0YsMj/uct3npuDxpuH0oSbbf7c9nu5otOOiaYrcnJwAeuzAOrJ4ieOwVD9oTSaWq
         wlQM36pGs6XohQSi17G8MNmqceVsglySsmvk4QW0TniIK4vrekUW5U+9jmTQcq0rYJ+S
         poJuF4sX8Q2nnyhdkD6joiLR6V1mWT6lKPgESp7azd0Fu9njgBPuABW/i+pGPXJcNoY/
         Y6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568380; x=1724173180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqd1jKx+q5wvRHFsKe7RtJaTNM99zPu8YKm8b61Swh4=;
        b=BswAwho2dM04yHBxVhkVHoabkZ6IzyL8xBe+DIcX+gkZ4z09lHGU/SNFv8DYWxWZS1
         BdbeZ26CJgbrnnquvNx2mxnzFuAf/ZT1V9PGiTRkcNiFSKP3/t5G++v1GY2kGHv16gW0
         6cFLxlxepb8L2lcKxygY0V8iIqU/3cFdps+64LkiyYzZXHmZ+8jkVu1cGMVJQUsY81y6
         ldfGJjVPbacTl4mukQcPfINZChTASM8n6najzZOkWltmZAZAb0fVbAZ3jSmY5f4RneYA
         ZNbjSLP3ndl8HDIT8feMUymrDENehat476qaQ8xaRlg3fXt1IoaWveXvXdtczqHS09tx
         SYQA==
X-Forwarded-Encrypted: i=1; AJvYcCUGFFsZmGIkRNVFolX7iZ14+nv019Qnnvlu8Ehas8r+9cigfafflocj6H0lXDgAmrBl/zfvog7dldFBjdt+I0EpqVQwgYJrCrC1Sy5M/KZ0
X-Gm-Message-State: AOJu0YxmmkLZdl3jwUDeHf/C2U15MQ7Igm6fanQbocQfLoehNQ2QIQSS
	WHCB+b20iYIOqb5Ol8TvLHM097s1tOK6kr//EEF3vbOR41rFafU+WdQq7WT+iLnw2QBvJGcAZCp
	hZmH53w==
X-Google-Smtp-Source: AGHT+IHcXqA8D3zvHAIQfVpeQAXseyth/6ohOvX1sAG9G57GDA3x2krpy7DDbUSjGWDUUw5XpHr8rLgkLnqj
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:b50c:66e8:6532:a371])
 (user=yuanchu job=sendgmr) by 2002:a0d:ce43:0:b0:62f:f535:f41 with SMTP id
 00721157ae682-6ac9bd76ef6mr1297b3.9.1723568379605; Tue, 13 Aug 2024 09:59:39
 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:56:13 -0700
In-Reply-To: <20240813165619.748102-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813165619.748102-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813165619.748102-3-yuanchu@google.com>
Subject: [PATCH v3 2/7] mm: use refresh interval to rate-limit workingset
 report aggregation
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

The refresh interval is a rate limiting factor to workingset page age
histogram reads. When a workingset report is generated, a timestamp
is noted, and the same report will be read until it expires beyond
the refresh interval, at which point a new report is generated.

Sysfs interface
/sys/devices/system/node/nodeX/workingset_report/refresh_interval
	time in milliseconds specifying how long the report is valid for

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
Change-Id: Iabacec2845a7fac7280ffc5f4faed55186cfa7a2
---
 include/linux/workingset_report.h |  1 +
 mm/workingset_report.c            | 84 +++++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 15 deletions(-)

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
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index a4dcf62fcd96..fe553c0a653e 100644
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
 	unsigned int flags;
@@ -208,12 +209,15 @@ static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
+		int gen = lru_gen_from_seq(max_seq);
+		unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
 
 		/*
 		 * setting can_swap=true and force_scan=true ensures
 		 * proper workingset stats when the system cannot swap.
 		 */
-		try_to_inc_max_seq(lruvec, max_seq, true, true);
+		if (time_is_before_jiffies(birth + refresh_interval))
+			try_to_inc_max_seq(lruvec, max_seq, true, true);
 		cond_resched();
 	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
 
@@ -270,17 +274,25 @@ bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
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
@@ -299,6 +311,52 @@ static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
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
@@ -382,13 +440,6 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
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
@@ -414,7 +465,10 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
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
2.46.0.76.ge559c4bf1a-goog


