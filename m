Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA6159B1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 22:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBKVbt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 16:31:49 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52966 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgBKVbt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 16:31:49 -0500
Received: by mail-pf1-f201.google.com with SMTP id w14so10920pfc.19
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 13:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c+fsn30b3pWjnYOr6E6zF4UMAJj0Yx+BEAwnB5sP5J8=;
        b=o72uVg9sJpd+UvYFuuzb65EzpdlHVgYlzpuacdYP9/+wTv2Z4axtnAWPKWaSxG6IpQ
         i9dcYqDm3EvPgsU/gGmlv2hTh3VcuRQMBXk2ozPhdauogUYRRANuln5bEnykkP+r283Z
         y23eVMMdbUea3L6hEh3nAVGVTJqqrXlksY/MBw3ew1KYrFawiAyBXrY1U2TJkaUQBdpC
         Nk+mZAJJfw5/PcOuC0WhR0edQwbSvlAULRVTswulrGNWxCSBfahLjUWCi7m5hR7p0llS
         GQweJbD6gKuLzUzXqd9B0/10J5D4hSIEkG/TTKksfnHRk0yRCplQk0U2I9jQLPOOf0Mf
         S5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c+fsn30b3pWjnYOr6E6zF4UMAJj0Yx+BEAwnB5sP5J8=;
        b=Zw7/hZsfwUbNgwBE+UI4fIe/COE5uUI+E4bwVzxfXh2Equp2E4k8PA4pPDsXt+DJN0
         1s244QOMANSRuZL0I6eVHPWax/lM/YnXGepcTTQTm5RwprwGwB9ti5CLsmQhAIePvSrU
         3Rh/xODCkp/XMoCMxGjIGtmj/HcRi4//spYPZGLN+BK7SB7cGsD2OeLogIuydyFjPpQ5
         G5kr9SmOGPWazKWQkCEvkh8mfMmcemqDW5JnBxafYkYdtKmIa6QNYlYjADUrpK80xlrY
         S3ZeAGa/fgjPLHYyVvJy6y8wgY9L5A3dumTwxQr/8Z9Zzo7Gq/rs5gf7UFVuRKlDR9Ex
         dFLQ==
X-Gm-Message-State: APjAAAX3+juENJECAG7ni1tqTjan13uUOyEGzomMOisroFCcT1142M4H
        HkycJpYNHISTdwAY0SAnNawH8ouyZzeymAOy0A==
X-Google-Smtp-Source: APXvYqwZcXavNgTvnHSepciYL/g+tzwV0kKfoKESWhUKYljcoZs5uTuH1N/KR7k5ejc8vOjtoShaglNvaJ6+zmDRLg==
X-Received: by 2002:a65:5283:: with SMTP id y3mr5113587pgp.370.1581456706831;
 Tue, 11 Feb 2020 13:31:46 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:31:20 -0800
Message-Id: <20200211213128.73302-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These counters will track hugetlb reservations rather than hugetlb
memory faulted in. This patch only adds the counter, following patches
add the charging and uncharging of the counter.

This is patch 1 of an 9 patch series.

Problem:
Currently tasks attempting to reserve more hugetlb memory than is
available get a failure at mmap/shmget time. This is thanks to
Hugetlbfs Reservations [1].  However, if a task attempts to reserve
more hugetlb memory than its hugetlb_cgroup limit allows, the kernel
will allow the mmap/shmget call, but will SIGBUS the task when it
attempts to fault in the excess memory.

We have users hitting their hugetlb_cgroup limits and thus we've been
looking at this failure mode. We'd like to improve this behavior such
that users violating the hugetlb_cgroup limits get an error on
mmap/shmget time, rather than getting SIGBUS'd when they try to fault
the excess memory in. This gives the user an opportunity to fallback
more gracefully to non-hugetlbfs memory for example.

The underlying problem is that today's hugetlb_cgroup accounting happens
at hugetlb memory *fault* time, rather than at *reservation* time.
Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
the offending task gets SIGBUS'd.

Proposed Solution:
A new page counter named
'hugetlb.xMB.rsvd.[limit|usage|max_usage]_in_bytes'. This counter has
slightly different semantics than
'hugetlb.xMB.[limit|usage|max_usage]_in_bytes':

- While usage_in_bytes tracks all *faulted* hugetlb memory,
rsvd.usage_in_bytes tracks all *reserved* hugetlb memory and
hugetlb memory faulted in without a prior reservation.

- If a task attempts to reserve more memory than limit_in_bytes allows,
the kernel will allow it to do so. But if a task attempts to reserve
more memory than rsvd.limit_in_bytes, the kernel will fail this
reservation.

This proposal is implemented in this patch series, with tests to verify
functionality and show the usage.

Alternatives considered:
1. A new cgroup, instead of only a new page_counter attached to
   the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot
   of code duplication with hugetlb_cgroup. Keeping hugetlb related
   page counters under hugetlb_cgroup seemed cleaner as well.

2. Instead of adding a new counter, we considered adding a sysctl that
   modifies the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do
   accounting at reservation time rather than fault time. Adding a new
   page_counter seems better as userspace could, if it wants, choose to
   enforce different cgroups differently: one via limit_in_bytes, and
   another via rsvd.limit_in_bytes.  This could be very useful if
   you're transitioning how hugetlb memory is partitioned on your system
   one cgroup at a time, for example. Also, someone may find usage for
   both limit_in_bytes and rsvd.limit_in_bytes concurrently, and this
   approach gives them the option to do so.

Testing:
- Added tests passing.
- Used libhugetlbfs for regression testing.

[1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

---
Changes in v12:
- Minor code formatting.

Changes in v11:
- Renamed resv.* or 'reservation' or 'reserved' to rsvd.*
- Renamed hugetlb_cgroup_get_counter() to
hugetlb_cgroup_counter_from_cgroup().

Changes in v10:
- Renamed reservation_* to resv.*

---
 include/linux/hugetlb.h |   4 +-
 mm/hugetlb_cgroup.c     | 115 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 104 insertions(+), 15 deletions(-)

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
index e434b05416c68..08b2adcdb5c1c 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -36,6 +36,11 @@ struct hugetlb_cgroup {
 	 */
 	struct page_counter hugepage[HUGE_MAX_HSTATE];

+	/*
+	 * the counter to account for hugepage reservations from hugetlb.
+	 */
+	struct page_counter rsvd_hugepage[HUGE_MAX_HSTATE];
+
 	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
 	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];

@@ -55,6 +60,15 @@ struct hugetlb_cgroup {

 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;

+static inline struct page_counter *
+hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx,
+				   bool rsvd)
+{
+	if (rsvd)
+		return &h_cg->rsvd_hugepage[idx];
+	return &h_cg->hugepage[idx];
+}
+
 static inline
 struct hugetlb_cgroup *hugetlb_cgroup_from_css(struct cgroup_subsys_state *s)
 {
@@ -295,28 +309,42 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,

 enum {
 	RES_USAGE,
+	RES_RSVD_USAGE,
 	RES_LIMIT,
+	RES_RSVD_LIMIT,
 	RES_MAX_USAGE,
+	RES_RSVD_MAX_USAGE,
 	RES_FAILCNT,
+	RES_RSVD_FAILCNT,
 };

 static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 				   struct cftype *cft)
 {
 	struct page_counter *counter;
+	struct page_counter *rsvd_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(css);

 	counter = &h_cg->hugepage[MEMFILE_IDX(cft->private)];
+	rsvd_counter = &h_cg->rsvd_hugepage[MEMFILE_IDX(cft->private)];

 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_USAGE:
 		return (u64)page_counter_read(counter) * PAGE_SIZE;
+	case RES_RSVD_USAGE:
+		return (u64)page_counter_read(rsvd_counter) * PAGE_SIZE;
 	case RES_LIMIT:
 		return (u64)counter->max * PAGE_SIZE;
+	case RES_RSVD_LIMIT:
+		return (u64)rsvd_counter->max * PAGE_SIZE;
 	case RES_MAX_USAGE:
 		return (u64)counter->watermark * PAGE_SIZE;
+	case RES_RSVD_MAX_USAGE:
+		return (u64)rsvd_counter->watermark * PAGE_SIZE;
 	case RES_FAILCNT:
 		return counter->failcnt;
+	case RES_RSVD_FAILCNT:
+		return rsvd_counter->failcnt;
 	default:
 		BUG();
 	}
@@ -338,10 +366,16 @@ static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
 			   1 << huge_page_order(&hstates[idx]));

 	switch (MEMFILE_ATTR(cft->private)) {
+	case RES_RSVD_USAGE:
+		counter = &h_cg->rsvd_hugepage[idx];
+		/* Fall through. */
 	case RES_USAGE:
 		val = (u64)page_counter_read(counter);
 		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
 		break;
+	case RES_RSVD_LIMIT:
+		counter = &h_cg->rsvd_hugepage[idx];
+		/* Fall through. */
 	case RES_LIMIT:
 		val = (u64)counter->max;
 		if (val == limit)
@@ -365,6 +399,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	int ret, idx;
 	unsigned long nr_pages;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
+	bool rsvd = false;

 	if (hugetlb_cgroup_is_root(h_cg)) /* Can't set limit on root */
 		return -EINVAL;
@@ -378,9 +413,14 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	nr_pages = round_down(nr_pages, 1 << huge_page_order(&hstates[idx]));

 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
+	case RES_RSVD_LIMIT:
+		rsvd = true;
+		/* Fall through. */
 	case RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
-		ret = page_counter_set_max(&h_cg->hugepage[idx], nr_pages);
+		ret = page_counter_set_max(
+			hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
+			nr_pages);
 		mutex_unlock(&hugetlb_limit_mutex);
 		break;
 	default:
@@ -406,18 +446,25 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
 	int ret = 0;
-	struct page_counter *counter;
+	struct page_counter *counter, *rsvd_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));

 	counter = &h_cg->hugepage[MEMFILE_IDX(of_cft(of)->private)];
+	rsvd_counter = &h_cg->rsvd_hugepage[MEMFILE_IDX(of_cft(of)->private)];

 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_MAX_USAGE:
 		page_counter_reset_watermark(counter);
 		break;
+	case RES_RSVD_MAX_USAGE:
+		page_counter_reset_watermark(rsvd_counter);
+		break;
 	case RES_FAILCNT:
 		counter->failcnt = 0;
 		break;
+	case RES_RSVD_FAILCNT:
+		rsvd_counter->failcnt = 0;
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
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.max", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_LIMIT);
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
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.current", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_USAGE);
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
@@ -521,7 +583,7 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
 	struct hstate *h = &hstates[idx];

 	/* format the size */
-	mem_fmt(buf, 32, huge_page_size(h));
+	mem_fmt(buf, sizeof(buf), huge_page_size(h));

 	/* Add the limit file */
 	cft = &h->cgroup_files_legacy[0];
@@ -530,28 +592,55 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
 	cft->read_u64 = hugetlb_cgroup_read_u64;
 	cft->write = hugetlb_cgroup_write_legacy;

-	/* Add the usage file */
+	/* Add the reservation limit file */
 	cft = &h->cgroup_files_legacy[1];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.limit_in_bytes", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_LIMIT);
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
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.usage_in_bytes", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_USAGE);
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
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.max_usage_in_bytes", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_MAX_USAGE);
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
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.failcnt", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_FAILCNT);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

 	/* NULL terminate the last cft */
-	cft = &h->cgroup_files_legacy[4];
+	cft = &h->cgroup_files_legacy[8];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
--
2.25.0.225.g125e21ebc7-goog
