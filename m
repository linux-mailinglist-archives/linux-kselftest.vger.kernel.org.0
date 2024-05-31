Return-Path: <linux-kselftest+bounces-11068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0609E8D6BA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 23:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF551C23458
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE379B87;
	Fri, 31 May 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEDRRnvn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414EF7407E
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191288; cv=none; b=P4t3YM9o3HSyrwW0pBSuVg5Nyc9apkBs9/0z5diE4ZQ2M2nMErm0ibuLH/crBDm9ElhNSyiBhQI0ugvT8VRt0GNxiOIYrd4eClL6MOaSV3Q1xrBv7Saq7OfoG1hIGGwxB4NF7pZfaqhieSZJwSC59cTEcY18ippKNdCbMAzRLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191288; c=relaxed/simple;
	bh=XUrRCro2c3vJASjYekSxK8B3yGUY52q1KIILfYM7BZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jV9mTrLwrXmdbbuhRUyZHjdjbG5lshzgBwl1+LC0JubJcbpHT5RMVLpXhCBQVx5myFhqsLJGQj9lm3w4vxiRsRyjXAZcVOpqznIiCogOltJ9Zv3RE9EGpaIIe+QX8tTOVkECV+5ojsYMljg4U4uJ05uRNsz0XpioTD1nxtRPd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEDRRnvn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a2aec8521so38954417b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717191286; x=1717796086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22c0UwDgNXgPsVV+qHmiQw5fv4pPjf+Lc0qLhHTqi88=;
        b=jEDRRnvnGYUZnQ39Mc5nbdkTKUyNZoOlbasuTHVOHb0knCE/VxZl9tp4vDDxwhTQ6E
         aavvNYUakc+bvxiNdYhU9NvmRgEOwfhoIzEUtxYOoTRrLwgV+pWzdgBpI6I2r8EfhbUY
         vqnr+84fuWxP4CB4PY7/M+3UAthA4YM5Y59nFazoXPtp6A3cUs52QiaNrkwCFaHc5vW/
         TgsU6ApM9FEArtfj1OQ9+u08xxnPLdn/fTv7uKL0IpoFoDmGMePKwTB4s9BaMRh5d9yO
         TuRQVDG5zDZPV5RMALlQMbn96+iCNO+QJnA4ZtBvd7SvQA1xlthtF7u5/a3iFS073x3r
         p1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191286; x=1717796086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22c0UwDgNXgPsVV+qHmiQw5fv4pPjf+Lc0qLhHTqi88=;
        b=ryuk+wuTxkrANH4+aEPRp/tSGgKq82NcPzDgBzMzYIS3TjchAHFM8NgCI9VVIeQx+F
         vDq/VAI8Ex8PMcnw1O6aeqbDWuwC/vqQJUq/ykL7CUULqWHlEmm4bXinp2ZIF9ydGwDa
         6cT5F3uR5h9CsNCjpLgI00RJLG/dWzuIOH57Zn36Ke+6fEer+O3g6yS7yRUABceIPq0p
         sr/+HTDrIVrI57t/FujrvSYWmAH8nmHYX99QdaagjpyUr6qjVA9obTEeyaUD2XZOvHWj
         1pDF01danzbhwpjhtxNomuhA9JknywvlKCR0NDEmTC/fXozRX78rwdFCMCgJlddKTw0b
         H0ng==
X-Forwarded-Encrypted: i=1; AJvYcCXQGbYvuWukzqFSo90w+RwVEgLhvCiW6mYkS9uaVR7ru56H0B3PvTGUARRHfILCrgOSdJV6Xy9pmSefvyy/juqZZFN/5oH4yITX+QUn60kp
X-Gm-Message-State: AOJu0YyKFY62f+y3iRJeZNBphniJp9bhUYns7CIIYci6KP14tV9F4ZxE
	uMxBjYRd/1LusUBz0hiKDS1I9xwORCRFTktnLIJex1Rpt9bOOjOEovifE9KRmY4wcQkZ2rRllql
	Cn6nyiZsWJw==
X-Google-Smtp-Source: AGHT+IEbPH0RxghVV8ANS15DCUTRp3o55R94/IFYmAtgmFEhINYqlUogTkNzjy7wCCu0jtBNvh0ajeeH7yA3Hw==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:1003:b0:df7:62ec:c517 with SMTP
 id 3f1490d57ef6-dfa73dba365mr150739276.11.1717191286235; Fri, 31 May 2024
 14:34:46 -0700 (PDT)
Date: Fri, 31 May 2024 21:34:37 +0000
In-Reply-To: <20240531213439.2958891-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240531213439.2958891-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531213439.2958891-2-jiaqiyan@google.com>
Subject: [PATCH v1 1/3] mm/memory-failure: userspace controls soft-offlining
 hugetlb pages
From: Jiaqi Yan <jiaqiyan@google.com>
To: naoya.horiguchi@nec.com, muchun.song@linux.dev, linmiaohe@huawei.com
Cc: akpm@linux-foundation.org, mike.kravetz@oracle.com, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Correctable memory errors are very common on servers with large
amount of memory, and are corrected by ECC. Soft offline is kernel's
additional recovery handling for memory pages having (excessive)
corrected memory errors. Impacted page is migrated to a healthy page
if mapped/inuse; the original page is discarded for any future use.

The actual policy on whether (and when) to soft offline should be
maintained by userspace, especially in case of HugeTLB hugepages.
Soft-offline dissolves a hugepage, either in-use or free, into
chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
If userspace has not acknowledged such behavior, it may be surprised
when later mmap hugepages MAP_FAILED due to lack of hugepages.
In addition, discarding the entire 1G memory page only because of
corrected memory errors sounds very costly and kernel better not
doing under the hood. But today there are at least 2 such cases:
1. GHES driver sees both GHES_SEV_CORRECTED and
   CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
2. RAS Correctable Errors Collector counts correctable errors per
   PFN and when the counter for a PFN reaches threshold
In both cases, userspace has no control of the soft offline performed
by kernel's memory failure recovery.

This commit gives userspace the control of soft-offlining HugeTLB
pages: kernel only soft offlines hugepage if userspace has opt-ed in
in for that specific hugepage size. The interface to userspace is a
new sysfs entry called softoffline_corrected_errors under the
/sys/kernel/mm/hugepages/hugepages-${size}kB directory:
* When softoffline_corrected_errors=0, skip soft offlining for all
  hugepages of size ${size}kB.
* When softoffline_corrected_errors=1, soft offline as before this
  patch series.

So the granularity of the control is per hugepage size, and is kept
in corresponding hstate. By default softoffline_corrected_errors is
1 to preserve existing behavior in kernel.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/hugetlb.h | 17 +++++++++++++++++
 mm/hugetlb.c            | 34 ++++++++++++++++++++++++++++++++++
 mm/memory-failure.c     |  7 +++++++
 3 files changed, 58 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2b3c3a404769..55f9e9593cce 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -685,6 +685,7 @@ struct hstate {
 	int next_nid_to_free;
 	unsigned int order;
 	unsigned int demote_order;
+	unsigned int softoffline_corrected_errors;
 	unsigned long mask;
 	unsigned long max_huge_pages;
 	unsigned long nr_huge_pages;
@@ -1029,6 +1030,16 @@ void hugetlb_unregister_node(struct node *node);
  */
 bool is_raw_hwpoison_page_in_hugepage(struct page *page);
 
+/*
+ * For certain hugepage size, when a hugepage has corrected memory error(s):
+ * - Return 0 if userspace wants to disable soft offlining the hugepage.
+ * - Return > 0 if userspace allows soft offlining the hugepage.
+ */
+static inline int hugetlb_softoffline_corrected_errors(struct folio *folio)
+{
+	return folio_hstate(folio)->softoffline_corrected_errors;
+}
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -1226,6 +1237,12 @@ static inline bool hugetlbfs_pagecache_present(
 {
 	return false;
 }
+
+static inline int hugetlb_softoffline_corrected_errors(struct folio *folio)
+{
+	return 1;
+}
+
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6be78e7d4f6e..a184e28ce592 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4325,6 +4325,38 @@ static ssize_t demote_size_store(struct kobject *kobj,
 }
 HSTATE_ATTR(demote_size);
 
+static ssize_t softoffline_corrected_errors_show(struct kobject *kobj,
+						 struct kobj_attribute *attr,
+						 char *buf)
+{
+	struct hstate *h = kobj_to_hstate(kobj, NULL);
+
+	return sysfs_emit(buf, "%d\n", h->softoffline_corrected_errors);
+}
+
+static ssize_t softoffline_corrected_errors_store(struct kobject *kobj,
+						  struct kobj_attribute *attr,
+						  const char *buf,
+						  size_t count)
+{
+	int err;
+	unsigned long input;
+	struct hstate *h = kobj_to_hstate(kobj, NULL);
+
+	err = kstrtoul(buf, 10, &input);
+	if (err)
+		return err;
+
+	/* softoffline_corrected_errors is either 0 or 1. */
+	if (input > 1)
+		return -EINVAL;
+
+	h->softoffline_corrected_errors = input;
+
+	return count;
+}
+HSTATE_ATTR(softoffline_corrected_errors);
+
 static struct attribute *hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&nr_overcommit_hugepages_attr.attr,
@@ -4334,6 +4366,7 @@ static struct attribute *hstate_attrs[] = {
 #ifdef CONFIG_NUMA
 	&nr_hugepages_mempolicy_attr.attr,
 #endif
+	&softoffline_corrected_errors_attr.attr,
 	NULL,
 };
 
@@ -4655,6 +4688,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h = &hstates[hugetlb_max_hstate++];
 	mutex_init(&h->resize_lock);
 	h->order = order;
+	h->softoffline_corrected_errors = 1;
 	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)
 		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 16ada4fb02b7..7094fc4c62e2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2776,6 +2776,13 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return -EIO;
 	}
 
+	if (PageHuge(page) &&
+	    !hugetlb_softoffline_corrected_errors(page_folio(page))) {
+		pr_info("soft offline: %#lx: hugetlb page is ignored\n", pfn);
+		put_ref_page(pfn, flags);
+		return -EINVAL;
+	}
+
 	mutex_lock(&mf_mutex);
 
 	if (PageHWPoison(page)) {
-- 
2.45.1.288.g0e0cd299f1-goog


