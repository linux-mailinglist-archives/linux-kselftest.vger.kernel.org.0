Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD186DBF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 01:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390509AbfHHXN7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 19:13:59 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:53303 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390506AbfHHXN7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 19:13:59 -0400
Received: by mail-qk1-f202.google.com with SMTP id d11so84049779qkb.20
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2019 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1e5Y+e42KorvbcxGXpQwcEigXZeGV0ULHZdDaD0hvA4=;
        b=b+zT0f9fu3ULZ0gkfmCIj5ZnufLu5TrTyMwWV6AJcHZSMmCx7vDSJ678HGyeAZNvNR
         HRmHfd11DfakQ4WibruAurLDZaAKlglidQFRwRel4tJ021LGCoozToPmLIDFt7zHH1OO
         lsli6SbS7zTH9Mz7jEgwSq3wYd0RJVOM0WEkDUb6HeLaw3d1WT5JQ1gPstZbdXAIjhkT
         Zk31JWtZT3EoPeJJmuV6/efvk9XKcRoc9S2YhR65FM7YW6fHe5K9v2lNn3b3c6YPzlv6
         B2F7+oVMu6Kf7+vPrHz/b7G9vi4mbpKh2MPYppFHPiPJAjkAl/4VKB1CUO2o15wdpHSt
         CuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1e5Y+e42KorvbcxGXpQwcEigXZeGV0ULHZdDaD0hvA4=;
        b=EBoBZ4pYxFmi7Zsijpkwwerz8OSNQ5qTtEbuOOElalRjJDqOGiudCGakv/AAc5vxUb
         absePBPhU6ccp99KfRZM270q3ACL06DKWdWEStVBsVnou2WkgxcalW0RbufzpprjEakc
         VBZqyepwHw0F/TVjRlGNVklrIoaUBIDAlFON9vwa9bl39s7GlwQE2VBUHIAcI0uWVCmf
         WZ2SddTBPNFWtBQR6miH2mmraXzF9izNXm6Q3wUVExTQ/y4IPclMegPyQdWbobiwj5IQ
         QP6NJHq/qxI5Nv8GTfyPsL80dO7DvjYKgd/iaDcZ7ehu7Ea68Pidb/Me2VPMrxTpOz1h
         pFNQ==
X-Gm-Message-State: APjAAAU0zlQs5XcLzJNZaQAJyRP7+0Y/qzJsgDL6H5FBO/mJa6TXA3BE
        yEzqhMV08sDAAQQOU73MQwHTJ0KL1RCMdQxg+Q==
X-Google-Smtp-Source: APXvYqxZsZORtAFxvo/GCCxeazLSDeTloGwWD2nvNdmwV7J3BRRl3Vegc7pnzWtMZdZFgg0hWgmiIgFkIB0uV5GRKw==
X-Received: by 2002:aed:3461:: with SMTP id w88mr15451018qtd.13.1565306038224;
 Thu, 08 Aug 2019 16:13:58 -0700 (PDT)
Date:   Thu,  8 Aug 2019 16:13:36 -0700
In-Reply-To: <20190808231340.53601-1-almasrymina@google.com>
Message-Id: <20190808231340.53601-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20190808231340.53601-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [RFC PATCH v2 1/5] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These counters will track hugetlb reservations rather than hugetlb
memory faulted in. This patch only adds the counter, following patches
add the charging and uncharging of the counter.
---
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb_cgroup.c     | 86 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index edfca42783192..6777b3013345d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -340,7 +340,7 @@ struct hstate {
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
-	struct cftype cgroup_files[5];
+	struct cftype cgroup_files[9];
 #endif
 	char name[HSTATE_NAME_LEN];
 };
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 68c2f2f3c05b7..708103663988a 100644
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
+struct page_counter *get_counter(struct hugetlb_cgroup *h_cg, int idx,
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
@@ -256,28 +269,42 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,

 enum {
 	RES_USAGE,
+	RES_RESERVATION_USAGE,
 	RES_LIMIT,
+	RES_RESERVATION_LIMIT,
 	RES_MAX_USAGE,
+	RES_RESERVATION_MAX_USAGE,
 	RES_FAILCNT,
+	RES_RESERVATION_FAILCNT,
 };

 static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 				   struct cftype *cft)
 {
 	struct page_counter *counter;
+	struct page_counter *reserved_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(css);

 	counter = &h_cg->hugepage[MEMFILE_IDX(cft->private)];
+	reserved_counter = &h_cg->reserved_hugepage[MEMFILE_IDX(cft->private)];

 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_USAGE:
 		return (u64)page_counter_read(counter) * PAGE_SIZE;
+	case RES_RESERVATION_USAGE:
+		return (u64)page_counter_read(reserved_counter) * PAGE_SIZE;
 	case RES_LIMIT:
 		return (u64)counter->max * PAGE_SIZE;
+	case RES_RESERVATION_LIMIT:
+		return (u64)reserved_counter->max * PAGE_SIZE;
 	case RES_MAX_USAGE:
 		return (u64)counter->watermark * PAGE_SIZE;
+	case RES_RESERVATION_MAX_USAGE:
+		return (u64)reserved_counter->watermark * PAGE_SIZE;
 	case RES_FAILCNT:
 		return counter->failcnt;
+	case RES_RESERVATION_FAILCNT:
+		return reserved_counter->failcnt;
 	default:
 		BUG();
 	}
@@ -291,6 +318,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	int ret, idx;
 	unsigned long nr_pages;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
+	bool reserved = false;

 	if (hugetlb_cgroup_is_root(h_cg)) /* Can't set limit on root */
 		return -EINVAL;
@@ -303,10 +331,16 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	idx = MEMFILE_IDX(of_cft(of)->private);
 	nr_pages = round_down(nr_pages, 1 << huge_page_order(&hstates[idx]));

+	if (MEMFILE_ATTR(of_cft(of)->private) == RES_RESERVATION_LIMIT) {
+		reserved = true;
+	}
+
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
+	case RES_RESERVATION_LIMIT:
 	case RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
-		ret = page_counter_set_max(&h_cg->hugepage[idx], nr_pages);
+		ret = page_counter_set_max(get_counter(h_cg, idx, reserved),
+					   nr_pages);
 		mutex_unlock(&hugetlb_limit_mutex);
 		break;
 	default:
@@ -320,18 +354,26 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
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
 	case RES_MAX_USAGE:
 		page_counter_reset_watermark(counter);
 		break;
+	case RES_RESERVATION_MAX_USAGE:
+		page_counter_reset_watermark(reserved_counter);
+		break;
 	case RES_FAILCNT:
 		counter->failcnt = 0;
 		break;
+	case RES_RESERVATION_FAILCNT:
+		reserved_counter->failcnt = 0;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -357,7 +399,7 @@ static void __init __hugetlb_cgroup_file_init(int idx)
 	struct hstate *h = &hstates[idx];

 	/* format the size */
-	mem_fmt(buf, 32, huge_page_size(h));
+	mem_fmt(buf, sizeof(buf), huge_page_size(h));

 	/* Add the limit file */
 	cft = &h->cgroup_files[0];
@@ -366,28 +408,58 @@ static void __init __hugetlb_cgroup_file_init(int idx)
 	cft->read_u64 = hugetlb_cgroup_read_u64;
 	cft->write = hugetlb_cgroup_write;

-	/* Add the usage file */
+	/* Add the reservation limit file */
 	cft = &h->cgroup_files[1];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_limit_in_bytes",
+		 buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_LIMIT);
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+	cft->write = hugetlb_cgroup_write;
+
+	/* Add the usage file */
+	cft = &h->cgroup_files[2];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.usage_in_bytes", buf);
 	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
 	cft->read_u64 = hugetlb_cgroup_read_u64;

+	/* Add the reservation usage file */
+	cft = &h->cgroup_files[3];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_usage_in_bytes",
+			buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_USAGE);
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
 	/* Add the MAX usage file */
-	cft = &h->cgroup_files[2];
+	cft = &h->cgroup_files[4];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max_usage_in_bytes", buf);
 	cft->private = MEMFILE_PRIVATE(idx, RES_MAX_USAGE);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

+	/* Add the MAX reservation usage file */
+	cft = &h->cgroup_files[5];
+	snprintf(cft->name, MAX_CFTYPE_NAME,
+			"%s.reservation_max_usage_in_bytes", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_MAX_USAGE);
+	cft->write = hugetlb_cgroup_reset;
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
 	/* Add the failcntfile */
-	cft = &h->cgroup_files[3];
+	cft = &h->cgroup_files[6];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
 	cft->private  = MEMFILE_PRIVATE(idx, RES_FAILCNT);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

+	/* Add the reservation failcntfile */
+	cft = &h->cgroup_files[7];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_failcnt", buf);
+	cft->private  = MEMFILE_PRIVATE(idx, RES_FAILCNT);
+	cft->write = hugetlb_cgroup_reset;
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
 	/* NULL terminate the last cft */
-	cft = &h->cgroup_files[4];
+	cft = &h->cgroup_files[8];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
--
2.23.0.rc1.153.gdeed80330f-goog
