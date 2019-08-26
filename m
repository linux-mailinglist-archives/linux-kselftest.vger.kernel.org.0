Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295599D9ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 01:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfHZXdF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Aug 2019 19:33:05 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41550 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfHZXdF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Aug 2019 19:33:05 -0400
Received: by mail-qt1-f202.google.com with SMTP id c22so19093702qta.8
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2019 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pMSrPLzVDw1XICtNdfHCjhSkFMAozhktzn43CPlv63A=;
        b=otOw5OA1sX/jNb1jYDH6S9zrRuVcgN6R4YNdN/7HVF8iibqC6QR8TpEPe54ArOpR6J
         KvsJeEV5Gukpx27uQF9n+RiBL8SjTsZ6g2joWMxG7zuJXTA+CpeWxpvXSN95QW/rdQ/k
         zuLX0gtJY3E5H4TuhVrjkrNj7a525Ud0a93g7wqhcZ2EBKqvN09p1mBaRdCFAOnkeXAg
         bA7MOgCgrpt139u20WOfpGJQV6reDC7nqBEqXDcKuRE5/hzI9ocj4hM4cCtlRlMG2+HR
         349Ip/uiwHH5QjSBEq33BSUUgxUMtZTTOUC+24i5B60ru66Z22hX934+XyndMeR5JiPo
         IGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pMSrPLzVDw1XICtNdfHCjhSkFMAozhktzn43CPlv63A=;
        b=AMMiaKBgNcoAIFj+0O8qOA65FEhi4S+FE/loyjGgLktH9g5ME9X01jMPYn0MGsKFkG
         jfoDG1HuGSp4XDPxC6Mwe+ubR4tzu8jcK/ZXokBFC1SwQgjXkslyZkPbJb/vg9/xQsXH
         ly16x60nw5QCcR68owiu79U7izIY+FzL52egQY9xgXBvpNNBHZg0lSbxvnIhecFtUvqI
         nzJYtoDdMHhhJNkhUP76R9dqpKPUSYcJdrTZfoCQ44zhnwh5T8W7+f/6X0HcfiwrfaZR
         b3qTFs1TOT5Fj8aRxybEGedSybjmXFa479j1av4OqDHc2h5n4uyY3OXJGR5Y5gSgJIam
         ZOtA==
X-Gm-Message-State: APjAAAURealuPytV6hIFitpT/xeHeJbFpjANruhlsy4msWHrwYmANMOF
        STxm9T383ecX3BlufIn8JQGxnvXA4KJAmdfuIw==
X-Google-Smtp-Source: APXvYqzZthcJtvCShn4pCfZlvUZzveyAV/4uxV06OHB7vYkHwJw6IYyKKMLPes4tQXRBT0ofpPTGKZCMnsPOfNcBJw==
X-Received: by 2002:a0c:db12:: with SMTP id d18mr17990534qvk.199.1566862383641;
 Mon, 26 Aug 2019 16:33:03 -0700 (PDT)
Date:   Mon, 26 Aug 2019 16:32:35 -0700
In-Reply-To: <20190826233240.11524-1-almasrymina@google.com>
Message-Id: <20190826233240.11524-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20190826233240.11524-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 1/6] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These counters will track hugetlb reservations rather than hugetlb
memory faulted in. This patch only adds the counter, following patches
add the charging and uncharging of the counter.

---
 include/linux/hugetlb.h |  16 +++++-
 mm/hugetlb_cgroup.c     | 111 ++++++++++++++++++++++++++++++----------
 2 files changed, 100 insertions(+), 27 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index edfca42783192..128ff1aff1c93 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -320,6 +320,20 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,

 #ifdef CONFIG_HUGETLB_PAGE

+enum {
+	HUGETLB_RES_USAGE,
+	HUGETLB_RES_RESERVATION_USAGE,
+	HUGETLB_RES_LIMIT,
+	HUGETLB_RES_RESERVATION_LIMIT,
+	HUGETLB_RES_MAX_USAGE,
+	HUGETLB_RES_RESERVATION_MAX_USAGE,
+	HUGETLB_RES_FAILCNT,
+	HUGETLB_RES_RESERVATION_FAILCNT,
+	HUGETLB_RES_NULL,
+	HUGETLB_RES_MAX,
+};
+
+
 #define HSTATE_NAME_LEN 32
 /* Defines one hugetlb page size */
 struct hstate {
@@ -340,7 +354,7 @@ struct hstate {
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
-	struct cftype cgroup_files[5];
+	struct cftype cgroup_files[HUGETLB_RES_MAX];
 #endif
 	char name[HSTATE_NAME_LEN];
 };
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 68c2f2f3c05b7..51a72624bd1ff 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -25,6 +25,10 @@ struct hugetlb_cgroup {
 	 * the counter to account for hugepages from hugetlb.
 	 */
 	struct page_counter hugepage[HUGE_MAX_HSTATE];
+	/*
+	 * the counter to account for hugepage reservations from hugetlb.
+	 */
+	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
 };

 #define MEMFILE_PRIVATE(x, val)	(((x) << 16) | (val))
@@ -33,6 +37,15 @@ struct hugetlb_cgroup {

 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;

+static inline
+struct page_counter *hugetlb_cgroup_get_counter(struct hugetlb_cgroup *h_cg, int idx,
+				 bool reserved)
+{
+	if (reserved)
+		return  &h_cg->reserved_hugepage[idx];
+	return &h_cg->hugepage[idx];
+}
+
 static inline
 struct hugetlb_cgroup *hugetlb_cgroup_from_css(struct cgroup_subsys_state *s)
 {
@@ -254,30 +267,33 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	return;
 }

-enum {
-	RES_USAGE,
-	RES_LIMIT,
-	RES_MAX_USAGE,
-	RES_FAILCNT,
-};
-
 static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 				   struct cftype *cft)
 {
 	struct page_counter *counter;
+	struct page_counter *reserved_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(css);

 	counter = &h_cg->hugepage[MEMFILE_IDX(cft->private)];
+	reserved_counter = &h_cg->reserved_hugepage[MEMFILE_IDX(cft->private)];

 	switch (MEMFILE_ATTR(cft->private)) {
-	case RES_USAGE:
+	case HUGETLB_RES_USAGE:
 		return (u64)page_counter_read(counter) * PAGE_SIZE;
-	case RES_LIMIT:
+	case HUGETLB_RES_RESERVATION_USAGE:
+		return (u64)page_counter_read(reserved_counter) * PAGE_SIZE;
+	case HUGETLB_RES_LIMIT:
 		return (u64)counter->max * PAGE_SIZE;
-	case RES_MAX_USAGE:
+	case HUGETLB_RES_RESERVATION_LIMIT:
+		return (u64)reserved_counter->max * PAGE_SIZE;
+	case HUGETLB_RES_MAX_USAGE:
 		return (u64)counter->watermark * PAGE_SIZE;
-	case RES_FAILCNT:
+	case HUGETLB_RES_RESERVATION_MAX_USAGE:
+		return (u64)reserved_counter->watermark * PAGE_SIZE;
+	case HUGETLB_RES_FAILCNT:
 		return counter->failcnt;
+	case HUGETLB_RES_RESERVATION_FAILCNT:
+		return reserved_counter->failcnt;
 	default:
 		BUG();
 	}
@@ -291,6 +307,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	int ret, idx;
 	unsigned long nr_pages;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
+	bool reserved = false;

 	if (hugetlb_cgroup_is_root(h_cg)) /* Can't set limit on root */
 		return -EINVAL;
@@ -304,9 +321,13 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	nr_pages = round_down(nr_pages, 1 << huge_page_order(&hstates[idx]));

 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
-	case RES_LIMIT:
+	case HUGETLB_RES_RESERVATION_LIMIT:
+		reserved = true;
+		/* Fall through. */
+	case HUGETLB_RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
-		ret = page_counter_set_max(&h_cg->hugepage[idx], nr_pages);
+		ret = page_counter_set_max(hugetlb_cgroup_get_counter(h_cg, idx, reserved),
+					   nr_pages);
 		mutex_unlock(&hugetlb_limit_mutex);
 		break;
 	default:
@@ -320,18 +341,26 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
 	int ret = 0;
-	struct page_counter *counter;
+	struct page_counter *counter, *reserved_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));

 	counter = &h_cg->hugepage[MEMFILE_IDX(of_cft(of)->private)];
+	reserved_counter = &h_cg->reserved_hugepage[
+		MEMFILE_IDX(of_cft(of)->private)];

 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
-	case RES_MAX_USAGE:
+	case HUGETLB_RES_MAX_USAGE:
 		page_counter_reset_watermark(counter);
 		break;
-	case RES_FAILCNT:
+	case HUGETLB_RES_RESERVATION_MAX_USAGE:
+		page_counter_reset_watermark(reserved_counter);
+		break;
+	case HUGETLB_RES_FAILCNT:
 		counter->failcnt = 0;
 		break;
+	case HUGETLB_RES_RESERVATION_FAILCNT:
+		reserved_counter->failcnt = 0;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -357,37 +386,67 @@ static void __init __hugetlb_cgroup_file_init(int idx)
 	struct hstate *h = &hstates[idx];

 	/* format the size */
-	mem_fmt(buf, 32, huge_page_size(h));
+	mem_fmt(buf, sizeof(buf), huge_page_size(h));

 	/* Add the limit file */
-	cft = &h->cgroup_files[0];
+	cft = &h->cgroup_files[HUGETLB_RES_LIMIT];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.limit_in_bytes", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_LIMIT);
+	cft->private = MEMFILE_PRIVATE(idx, HUGETLB_RES_LIMIT);
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+	cft->write = hugetlb_cgroup_write;
+
+	/* Add the reservation limit file */
+	cft = &h->cgroup_files[HUGETLB_RES_RESERVATION_LIMIT];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_limit_in_bytes",
+		 buf);
+	cft->private = MEMFILE_PRIVATE(idx, HUGETLB_RES_RESERVATION_LIMIT);
 	cft->read_u64 = hugetlb_cgroup_read_u64;
 	cft->write = hugetlb_cgroup_write;

 	/* Add the usage file */
-	cft = &h->cgroup_files[1];
+	cft = &h->cgroup_files[HUGETLB_RES_USAGE];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.usage_in_bytes", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
+	cft->private = MEMFILE_PRIVATE(idx, HUGETLB_RES_USAGE);
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
+	/* Add the reservation usage file */
+	cft = &h->cgroup_files[HUGETLB_RES_RESERVATION_USAGE];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_usage_in_bytes",
+			buf);
+	cft->private = MEMFILE_PRIVATE(idx, HUGETLB_RES_RESERVATION_USAGE);
 	cft->read_u64 = hugetlb_cgroup_read_u64;

 	/* Add the MAX usage file */
-	cft = &h->cgroup_files[2];
+	cft = &h->cgroup_files[HUGETLB_RES_MAX_USAGE];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max_usage_in_bytes", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_MAX_USAGE);
+	cft->private = MEMFILE_PRIVATE(idx, HUGETLB_RES_MAX_USAGE);
+	cft->write = hugetlb_cgroup_reset;
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
+	/* Add the MAX reservation usage file */
+	cft = &h->cgroup_files[HUGETLB_RES_RESERVATION_MAX_USAGE];
+	snprintf(cft->name, MAX_CFTYPE_NAME,
+			"%s.reservation_max_usage_in_bytes", buf);
+	cft->private = MEMFILE_PRIVATE(idx, HUGETLB_RES_RESERVATION_MAX_USAGE);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

 	/* Add the failcntfile */
-	cft = &h->cgroup_files[3];
+	cft = &h->cgroup_files[HUGETLB_RES_FAILCNT];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
-	cft->private  = MEMFILE_PRIVATE(idx, RES_FAILCNT);
+	cft->private  = MEMFILE_PRIVATE(idx, HUGETLB_RES_FAILCNT);
+	cft->write = hugetlb_cgroup_reset;
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
+	/* Add the reservation failcntfile */
+	cft = &h->cgroup_files[HUGETLB_RES_RESERVATION_FAILCNT];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_failcnt", buf);
+	cft->private  = MEMFILE_PRIVATE(idx, HUGETLB_RES_RESERVATION_FAILCNT);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

 	/* NULL terminate the last cft */
-	cft = &h->cgroup_files[4];
+	cft = &h->cgroup_files[HUGETLB_RES_NULL];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
--
2.23.0.187.g17f5b7556c-goog
