Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A0BD5373
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2019 02:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfJMAaa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Oct 2019 20:30:30 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38421 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfJMAaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Oct 2019 20:30:30 -0400
Received: by mail-pf1-f202.google.com with SMTP id d126so10665038pfd.5
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2019 17:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EopVkWKYWV3u5jB7sSoC9RjSodCCxqS+Mci7sV9VxPY=;
        b=hB2RBKC4tmA2pETKfBInZNzPFP/IbYhsVcQIrjFIiOakJ+v+2kExP0/S5mBY3wmz+c
         IeQTPgfaT+/7KvPexhO6RXR/IaTPDsq9PqHl8bMR9fqKNb7+XteOsPERKl447uKDoDoF
         AxssDGQIuGZFe9gczY9xP0Y9q1yPUDkPUAvoShoVjF0IlsqDulUnxV7vg3iEIKUZgHGl
         1fZr33mvjsDQxkrixKFWCHOdKu7dZrnveqqoe7lOnjg3MMcGr0z3OHjbZ+wim9FU/25U
         MiPngACOPZOA5f0DE61gTrF5GomMD2NbveTne+j6EWaq+bcI1Us3muiCABNLLaCSZP8h
         9uWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EopVkWKYWV3u5jB7sSoC9RjSodCCxqS+Mci7sV9VxPY=;
        b=kgGd5PdZaM1f4r/GEwNhfR536NpDiK4RHgrfKOr/LndfLJlsJwNqFJZUzf6CNvPNp4
         hloUAUDyVeXUm//baAW7FXDIRDFNFYcyHKJh3JExJO0MAX4uG51mJbEKUSRfu5u3Qjxi
         TACzCBiEwH5P/iaZ7VMK3zmQQ+SAE3tOtNed90H6XS2tlnEMt5fDyAaZh83deJ/ezIA2
         mAXh0O2BAZ3dT3GlObeBckNZ6Ql5CUJ4RTAPfLIP35acSmMeyo5pSgDzd+n9CAFiUtG0
         AtkwLlqACQqQ2OpLp+yeqM1TBt4fBBTlXWa5nA3CaUEN1bnE9eDUlak1dQUTY9N8u2q0
         0cCg==
X-Gm-Message-State: APjAAAVY+G3OD0Hq6qq1GZ5v4CYXZHE1E9zq1S6wfKHVQfEzXN4FYHvr
        u+ESGwGD2gQM4yhD4qmecgKluH4/57UXjZxYUg==
X-Google-Smtp-Source: APXvYqxZ884rRhx2+SOp4Nn0XYcIPLL5V05SWv3kr04QLfHmTNd+KEvJk3uGH632D73P9rHnKVruD0tulCqNF0+7Bw==
X-Received: by 2002:a63:3104:: with SMTP id x4mr22466310pgx.88.1570926629548;
 Sat, 12 Oct 2019 17:30:29 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:30:16 -0700
Message-Id: <20191013003024.215429-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v6 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These counters will track hugetlb reservations rather than hugetlb
memory faulted in. This patch only adds the counter, following patches
add the charging and uncharging of the counter.

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
- libhugetlbfs tests mostly passing, but some tests have trouble with and
  without this patch series. Seems environment issue rather than code:
  - Overall results:
    ********** TEST SUMMARY
    *                      2M
    *                      32-bit 64-bit
    *     Total testcases:    84      0
    *             Skipped:     0      0
    *                PASS:    66      0
    *                FAIL:    14      0
    *    Killed by signal:     0      0
    *   Bad configuration:     4      0
    *       Expected FAIL:     0      0
    *     Unexpected PASS:     0      0
    *    Test not present:     0      0
    * Strange test result:     0      0
    **********
  - Failing tests:
    - elflink_rw_and_share_test("linkhuge_rw") segfaults with and without this
      patch series.
    - LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes malloc (2M: 32):
      FAIL    Address is not hugepage
    - LD_PRELOAD=libhugetlbfs.so HUGETLB_RESTRICT_EXE=unknown:malloc
      HUGETLB_MORECORE=yes malloc (2M: 32):
      FAIL    Address is not hugepage
    - LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes malloc_manysmall (2M: 32):
      FAIL    Address is not hugepage
    - GLIBC_TUNABLES=glibc.malloc.tcache_count=0 LD_PRELOAD=libhugetlbfs.so
      HUGETLB_MORECORE=yes heapshrink (2M: 32):
      FAIL    Heap not on hugepages
    - GLIBC_TUNABLES=glibc.malloc.tcache_count=0 LD_PRELOAD=libhugetlbfs.so
      libheapshrink.so HUGETLB_MORECORE=yes heapshrink (2M: 32):
      FAIL    Heap not on hugepages
    - HUGETLB_ELFMAP=RW linkhuge_rw (2M: 32): FAIL    small_data is not hugepage
    - HUGETLB_ELFMAP=RW HUGETLB_MINIMAL_COPY=no linkhuge_rw (2M: 32):
      FAIL    small_data is not hugepage
    - alloc-instantiate-race shared (2M: 32):
      Bad configuration: sched_setaffinity(cpu1): Invalid argument -
      FAIL    Child 1 killed by signal Killed
    - shmoverride_linked (2M: 32):
      FAIL    shmget failed size 2097152 from line 176: Invalid argument
    - HUGETLB_SHM=yes shmoverride_linked (2M: 32):
      FAIL    shmget failed size 2097152 from line 176: Invalid argument
    - shmoverride_linked_static (2M: 32):
      FAIL shmget failed size 2097152 from line 176: Invalid argument
    - HUGETLB_SHM=yes shmoverride_linked_static (2M: 32):
      FAIL shmget failed size 2097152 from line 176: Invalid argument
    - LD_PRELOAD=libhugetlbfs.so shmoverride_unlinked (2M: 32):
      FAIL shmget failed size 2097152 from line 176: Invalid argument
    - LD_PRELOAD=libhugetlbfs.so HUGETLB_SHM=yes shmoverride_unlinked (2M: 32):
      FAIL    shmget failed size 2097152 from line 176: Invalid argument

[1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Hillf Danton <hdanton@sina.com>

---
 include/linux/hugetlb.h |  23 ++++++++-
 mm/hugetlb_cgroup.c     | 111 ++++++++++++++++++++++++++++++----------
 2 files changed, 107 insertions(+), 27 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 53fc34f930d08..9c49a0ba894d3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -320,6 +320,27 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,

 #ifdef CONFIG_HUGETLB_PAGE

+enum {
+	/* Tracks hugetlb memory faulted in. */
+	HUGETLB_RES_USAGE,
+	/* Tracks hugetlb memory reserved. */
+	HUGETLB_RES_RESERVATION_USAGE,
+	/* Limit for hugetlb memory faulted in. */
+	HUGETLB_RES_LIMIT,
+	/* Limit for hugetlb memory reserved. */
+	HUGETLB_RES_RESERVATION_LIMIT,
+	/* Max usage for hugetlb memory faulted in. */
+	HUGETLB_RES_MAX_USAGE,
+	/* Max usage for hugetlb memory reserved. */
+	HUGETLB_RES_RESERVATION_MAX_USAGE,
+	/* Faulted memory accounting fail count. */
+	HUGETLB_RES_FAILCNT,
+	/* Reserved memory accounting fail count. */
+	HUGETLB_RES_RESERVATION_FAILCNT,
+	HUGETLB_RES_NULL,
+	HUGETLB_RES_MAX,
+};
+
 #define HSTATE_NAME_LEN 32
 /* Defines one hugetlb page size */
 struct hstate {
@@ -340,7 +361,7 @@ struct hstate {
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
-	struct cftype cgroup_files[5];
+	struct cftype cgroup_files[HUGETLB_RES_MAX];
 #endif
 	char name[HSTATE_NAME_LEN];
 };
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index f1930fa0b445d..1ed4448ca41d3 100644
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
@@ -33,6 +37,14 @@ struct hugetlb_cgroup {

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
@@ -254,30 +266,33 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
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
@@ -291,6 +306,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	int ret, idx;
 	unsigned long nr_pages;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
+	bool reserved = false;

 	if (hugetlb_cgroup_is_root(h_cg)) /* Can't set limit on root */
 		return -EINVAL;
@@ -304,9 +320,14 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	nr_pages = round_down(nr_pages, 1 << huge_page_order(&hstates[idx]));

 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
-	case RES_LIMIT:
+	case HUGETLB_RES_RESERVATION_LIMIT:
+		reserved = true;
+		/* Fall through. */
+	case HUGETLB_RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
-		ret = page_counter_set_max(&h_cg->hugepage[idx], nr_pages);
+		ret = page_counter_set_max(hugetlb_cgroup_get_counter(h_cg, idx,
+								      reserved),
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
+	reserved_counter =
+		&h_cg->reserved_hugepage[MEMFILE_IDX(of_cft(of)->private)];

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
+		 buf);
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
+		 "%s.reservation_max_usage_in_bytes", buf);
+	cft->private = MEMFILE_PRIVATE(idx, HUGETLB_RES_RESERVATION_MAX_USAGE);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

 	/* Add the failcntfile */
-	cft = &h->cgroup_files[3];
+	cft = &h->cgroup_files[HUGETLB_RES_FAILCNT];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
-	cft->private  = MEMFILE_PRIVATE(idx, RES_FAILCNT);
+	cft->private = MEMFILE_PRIVATE(idx, HUGETLB_RES_FAILCNT);
+	cft->write = hugetlb_cgroup_reset;
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
+	/* Add the reservation failcntfile */
+	cft = &h->cgroup_files[HUGETLB_RES_RESERVATION_FAILCNT];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_failcnt", buf);
+	cft->private = MEMFILE_PRIVATE(idx, HUGETLB_RES_RESERVATION_FAILCNT);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

 	/* NULL terminate the last cft */
-	cft = &h->cgroup_files[4];
+	cft = &h->cgroup_files[HUGETLB_RES_NULL];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
--
2.23.0.700.g56cf767bdb-goog
