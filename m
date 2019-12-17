Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17525123A97
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2019 00:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfLQXQU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Dec 2019 18:16:20 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54764 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLQXQU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Dec 2019 18:16:20 -0500
Received: by mail-pf1-f201.google.com with SMTP id v14so5319pfm.21
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2019 15:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fmLWS4dpNb8jVS/5rqZ+CA53CnOvDXqWOpoeGQV32Ag=;
        b=p5KnOfjN2Kg63lvMZFKcPGppbKabQqibMQRoKLLiUoAAN1evAjms2mnlhpjdXb9Dxc
         MstH/ZY7Azx+odQEaPkxQZjcTs9s/rYK6UEIN1TYXatKGZy8AOoWVJDzMTInk5gAUPo+
         WPoIphgmUCopcaI1kF22ByxXHlNqUvygiPaEjShY18ATbgICW/zw4eYXrafHsEYrrjjb
         4aFUHm2jPzAbhn3Kp91g39LezIXwFWDM6LYP0b1S1Zm81pi9Z9iKtbkwQVfQHhq/Hxhk
         X41fe0U3UYcaBCZfOHsGVJpYbl9eWfWeZLfkPK4xDW4wNL5raypfGuSTqJBjT6M8kMyR
         UjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fmLWS4dpNb8jVS/5rqZ+CA53CnOvDXqWOpoeGQV32Ag=;
        b=aP2eLzrU7bmJpmA7OD3QpIYscWnHniOQZ0z+Y0AwdxvVal+to99ue9/XxtOsC1Amnb
         RyZdKVtfwOVPivEUtLEQcS3Uxg5y+U1tuH1TftkO9a/En/bBmEAZd+Cs0gwgnBVpd58W
         icGP1Gp/DrpY7B4iz8jX7FBDI8Ysg2YiG3X67r9WiYmfltHIHdxOwWUx0lchOhJFakGn
         U6PR8a0P06D9iucS8Ul8AtND9T5gk4+ML325PElh8EYrGaRCbywFKSIPVAGNbTOAoTeS
         LTighpc1jFE8/SUuE6bBbdtuePmmuxK2i1dMXyTUGvbhKLKBPgj4w3VnbaOH8AskWiMw
         uKZQ==
X-Gm-Message-State: APjAAAXIUAEc4+zb1oC5PpAY13MlrSjtWJs8AnqlOIUQLEJBv07w8wGo
        Emd2sCbGlii7UpeSMsrtteMwxaElDvqX06ZN+A==
X-Google-Smtp-Source: APXvYqy6LGLg4J345RdtxC9kXceokOdVJlSCDkT1URc+HdngUscxhaAs3i4vQ4BAaSQqdbyj5g7f5AwCbAXWRkkDrw==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr28553183pgx.286.1576624579364;
 Tue, 17 Dec 2019 15:16:19 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:16:08 -0800
Message-Id: <20191217231615.164161-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v9 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These counters will track hugetlb reservations rather than hugetlb
memory faulted in. This patch only adds the counter, following patches
add the charging and uncharging of the counter.

This is patch 1 of an 8 patch series.

Problem:
Currently tasks attempting to allocate more hugetlb memory than is available get
a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
However, if a task attempts to allocate hugetlb memory only more than its
hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
but will SIGBUS the task when it attempts to fault the memory in.

We have developers interested in using hugetlb_cgroups, and they have expressed
dissatisfaction regarding this behavior. We'd like to improve this
behavior such that tasks violating the hugetlb_cgroup limits get an error on
mmap/shmget time, rather than getting SIGBUS'd when they try to fault
the excess memory in.

The underlying problem is that today's hugetlb_cgroup accounting happens
at hugetlb memory *fault* time, rather than at *reservation* time.
Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
the offending task gets SIGBUS'd.

Proposed Solution:
A new page counter named hugetlb.xMB.reservation_[limit|usage]_in_bytes. This
counter has slightly different semantics than
hugetlb.xMB.[limit|usage]_in_bytes:

- While usage_in_bytes tracks all *faulted* hugetlb memory,
reservation_usage_in_bytes tracks all *reserved* hugetlb memory and
hugetlb memory faulted in without a prior reservation.

- If a task attempts to reserve more memory than limit_in_bytes allows,
the kernel will allow it to do so. But if a task attempts to reserve
more memory than reservation_limit_in_bytes, the kernel will fail this
reservation.

This proposal is implemented in this patch series, with tests to verify
functionality and show the usage. We also added cgroup-v2 support to
hugetlb_cgroup so that the new use cases can be extended to v2.

Alternatives considered:
1. A new cgroup, instead of only a new page_counter attached to
   the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
   duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
   hugetlb_cgroup seemed cleaner as well.

2. Instead of adding a new counter, we considered adding a sysctl that modifies
   the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
   reservation time rather than fault time. Adding a new page_counter seems
   better as userspace could, if it wants, choose to enforce different cgroups
   differently: one via limit_in_bytes, and another via
   reservation_limit_in_bytes. This could be very useful if you're
   transitioning how hugetlb memory is partitioned on your system one
   cgroup at a time, for example. Also, someone may find usage for both
   limit_in_bytes and reservation_limit_in_bytes concurrently, and this
   approach gives them the option to do so.

Testing:
- Added tests passing.
- Used libhugetlbfs for regression testing.

[1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Hillf Danton <hdanton@sina.com>

---
 include/linux/hugetlb.h |   4 +-
 mm/hugetlb_cgroup.c     | 116 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 106 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1e897e4168ac1..dea6143aa0685 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -432,8 +432,8 @@ struct hstate {
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
-	struct cftype cgroup_files_dfl[5];
-	struct cftype cgroup_files_legacy[5];
+	struct cftype cgroup_files_dfl[7];
+	struct cftype cgroup_files_legacy[9];
 #endif
 	char name[HSTATE_NAME_LEN];
 };
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index e434b05416c68..35415af9ed26f 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -36,6 +36,11 @@ struct hugetlb_cgroup {
 	 */
 	struct page_counter hugepage[HUGE_MAX_HSTATE];

+	/*
+	 * the counter to account for hugepage reservations from hugetlb.
+	 */
+	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
+
 	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
 	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];

@@ -55,6 +60,14 @@ struct hugetlb_cgroup {

 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;

+static inline struct page_counter *
+hugetlb_cgroup_get_counter(struct hugetlb_cgroup *h_cg, int idx, bool reserved)
+{
+	if (reserved)
+		return &h_cg->reserved_hugepage[idx];
+	return &h_cg->hugepage[idx];
+}
+
 static inline
 struct hugetlb_cgroup *hugetlb_cgroup_from_css(struct cgroup_subsys_state *s)
 {
@@ -295,28 +308,42 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,

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
@@ -338,10 +365,16 @@ static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
 			   1 << huge_page_order(&hstates[idx]));

 	switch (MEMFILE_ATTR(cft->private)) {
+	case RES_RESERVATION_USAGE:
+		counter = &h_cg->reserved_hugepage[idx];
+		/* Fall through. */
 	case RES_USAGE:
 		val = (u64)page_counter_read(counter);
 		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
 		break;
+	case RES_RESERVATION_LIMIT:
+		counter = &h_cg->reserved_hugepage[idx];
+		/* Fall through. */
 	case RES_LIMIT:
 		val = (u64)counter->max;
 		if (val == limit)
@@ -365,6 +398,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	int ret, idx;
 	unsigned long nr_pages;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
+	bool reserved = false;

 	if (hugetlb_cgroup_is_root(h_cg)) /* Can't set limit on root */
 		return -EINVAL;
@@ -378,9 +412,14 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	nr_pages = round_down(nr_pages, 1 << huge_page_order(&hstates[idx]));

 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
+	case RES_RESERVATION_LIMIT:
+		reserved = true;
+		/* Fall through. */
 	case RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
-		ret = page_counter_set_max(&h_cg->hugepage[idx], nr_pages);
+		ret = page_counter_set_max(hugetlb_cgroup_get_counter(h_cg, idx,
+								      reserved),
+					   nr_pages);
 		mutex_unlock(&hugetlb_limit_mutex);
 		break;
 	default:
@@ -406,18 +445,26 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
 	int ret = 0;
-	struct page_counter *counter;
+	struct page_counter *counter, *reserved_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));

 	counter = &h_cg->hugepage[MEMFILE_IDX(of_cft(of)->private)];
+	reserved_counter =
+		&h_cg->reserved_hugepage[MEMFILE_IDX(of_cft(of)->private)];

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
@@ -472,7 +519,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
 	struct hstate *h = &hstates[idx];

 	/* format the size */
-	mem_fmt(buf, 32, huge_page_size(h));
+	mem_fmt(buf, sizeof(buf), huge_page_size(h));

 	/* Add the limit file */
 	cft = &h->cgroup_files_dfl[0];
@@ -482,15 +529,30 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
 	cft->write = hugetlb_cgroup_write_dfl;
 	cft->flags = CFTYPE_NOT_ON_ROOT;

-	/* Add the current usage file */
+	/* Add the reservation limit file */
 	cft = &h->cgroup_files_dfl[1];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_max", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_LIMIT);
+	cft->seq_show = hugetlb_cgroup_read_u64_max;
+	cft->write = hugetlb_cgroup_write_dfl;
+	cft->flags = CFTYPE_NOT_ON_ROOT;
+
+	/* Add the current usage file */
+	cft = &h->cgroup_files_dfl[2];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.current", buf);
 	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
 	cft->seq_show = hugetlb_cgroup_read_u64_max;
 	cft->flags = CFTYPE_NOT_ON_ROOT;

+	/* Add the current reservation usage file */
+	cft = &h->cgroup_files_dfl[3];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_current", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_USAGE);
+	cft->seq_show = hugetlb_cgroup_read_u64_max;
+	cft->flags = CFTYPE_NOT_ON_ROOT;
+
 	/* Add the events file */
-	cft = &h->cgroup_files_dfl[2];
+	cft = &h->cgroup_files_dfl[4];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
 	cft->private = MEMFILE_PRIVATE(idx, 0);
 	cft->seq_show = hugetlb_events_show;
@@ -498,7 +560,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
 	cft->flags = CFTYPE_NOT_ON_ROOT;

 	/* Add the events.local file */
-	cft = &h->cgroup_files_dfl[3];
+	cft = &h->cgroup_files_dfl[5];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events.local", buf);
 	cft->private = MEMFILE_PRIVATE(idx, 0);
 	cft->seq_show = hugetlb_events_local_show;
@@ -507,7 +569,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
 	cft->flags = CFTYPE_NOT_ON_ROOT;

 	/* NULL terminate the last cft */
-	cft = &h->cgroup_files_dfl[4];
+	cft = &h->cgroup_files_dfl[6];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
@@ -530,28 +592,58 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
 	cft->read_u64 = hugetlb_cgroup_read_u64;
 	cft->write = hugetlb_cgroup_write_legacy;

-	/* Add the usage file */
+	/* Add the reservation limit file */
 	cft = &h->cgroup_files_legacy[1];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_limit_in_bytes",
+		 buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_LIMIT);
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+	cft->write = hugetlb_cgroup_write_legacy;
+
+	/* Add the usage file */
+	cft = &h->cgroup_files_legacy[2];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.usage_in_bytes", buf);
 	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
 	cft->read_u64 = hugetlb_cgroup_read_u64;

+	/* Add the reservation usage file */
+	cft = &h->cgroup_files_legacy[3];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_usage_in_bytes",
+		 buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_USAGE);
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
 	/* Add the MAX usage file */
-	cft = &h->cgroup_files_legacy[2];
+	cft = &h->cgroup_files_legacy[4];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max_usage_in_bytes", buf);
 	cft->private = MEMFILE_PRIVATE(idx, RES_MAX_USAGE);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

+	/* Add the MAX reservation usage file */
+	cft = &h->cgroup_files_legacy[5];
+	snprintf(cft->name, MAX_CFTYPE_NAME,
+		 "%s.reservation_max_usage_in_bytes", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_MAX_USAGE);
+	cft->write = hugetlb_cgroup_reset;
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
 	/* Add the failcntfile */
-	cft = &h->cgroup_files_legacy[3];
+	cft = &h->cgroup_files_legacy[6];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
-	cft->private  = MEMFILE_PRIVATE(idx, RES_FAILCNT);
+	cft->private = MEMFILE_PRIVATE(idx, RES_FAILCNT);
+	cft->write = hugetlb_cgroup_reset;
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
+	/* Add the reservation failcntfile */
+	cft = &h->cgroup_files_legacy[7];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_failcnt", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_FAILCNT);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

 	/* NULL terminate the last cft */
-	cft = &h->cgroup_files_legacy[4];
+	cft = &h->cgroup_files_legacy[8];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
--
2.24.1.735.g03f4e72817-goog
