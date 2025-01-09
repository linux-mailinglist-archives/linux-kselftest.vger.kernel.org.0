Return-Path: <linux-kselftest+bounces-24139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AD9A07EE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DA13A69F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24CA192D97;
	Thu,  9 Jan 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="fUDKglXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB818DF73;
	Thu,  9 Jan 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444358; cv=pass; b=l2IhkcQcpddsSxildYJ5EdXKTjm7UdlFrjv5g7z75VNOH0RwS4avlIb73h5WsTHU5yqCAxqkLZdctzSZ4WOj7/J71nF/16L1Hb4sUJp6RscM75JdnM1gkRWP0oFs3OuR7P/ZLcGd8c1jq0Om5PNENj5vbytGmOlJoelTP/xpj60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444358; c=relaxed/simple;
	bh=ihdVx2XOZxyAVVni6D1kfTA6g83DLUjzoGmIGSIoW/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r6Rfx+C/shaiDfvnM5KQY3vInmshaSdagkdjYmaUcNjfZRSrFSjTVtzv7EuWgOAqBExtlohxgdVH//aOOsdm6D780F1G+BkFGd1K6b+Sc9XSUKq9pj5L0b3kkwQ0Ci0tbsYIfmlHceWS4ob0Zqjiy8lxCHPR2tr6cvRwuF/6Kpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=fUDKglXD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444339; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ONu17u81hOmHOabYuB7sMpw1Vkpsu1s65oTy1JfJV+QRkxuPt50f0dbR5rDyNYUVb+qf/cRjspjdzI0zDY//e7yTCw3UaJzi7y6ODpU4KBlvitpN40Q2VjFhQIuLKGxDLOLQuLhuumz77PHcoTdG0n4Y3vBK4A4N3QWMB4yZq7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444339; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DzeP1877WvjEGBYELRWDa1Fo4chfHCz216EXXV975qM=; 
	b=ehDzb7K7x7wR+E8C8fcj/0RDoPZSq67n/5OXDJZZIl9NCMdc8+FiRgBGhfmer06UvAPC/WT7sSh5djPdNbFxE4Mwwnx2jo7toLyrTd7sO/iqDno+wVND/2dDB94GdkZnIl+1cw0H0qkJnyLjx5eUeoEch6/4o/bNNzq/Lcew0PA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444339;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=DzeP1877WvjEGBYELRWDa1Fo4chfHCz216EXXV975qM=;
	b=fUDKglXDNAM9KS8TprA2p9ApBzZJTjzC6r9wIKwdKWwIbuOwSfuNFiSZ0BB7oLiU
	PBZmE1SXg13PK3WHAH+NWsmHhMq1KZRuSmLoJea1jGOnQYD2eePoJ6KZcWs5hJRhuG6
	nifnuw97bvY8qRqRl4jdsNYKE0MhPzQIHrZWLnYY=
Received: by mx.zohomail.com with SMTPS id 1736444336977345.11679082868227;
	Thu, 9 Jan 2025 09:38:56 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 02/16] selftests/mm: Fix unused parameter warnings
Date: Thu,  9 Jan 2025 22:38:28 +0500
Message-Id: <20250109173842.1142376-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix warnings generated  by unused parameters.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../selftests/mm/hugetlb_fault_after_madv.c   |  4 +-
 .../selftests/mm/hugetlb_madv_vs_map.c        |  6 +--
 tools/testing/selftests/mm/ksm_tests.c        | 17 +++---
 tools/testing/selftests/mm/memfd_secret.c     |  4 +-
 tools/testing/selftests/mm/soft-dirty.c       |  4 +-
 .../selftests/mm/split_huge_page_test.c       |  4 +-
 tools/testing/selftests/mm/uffd-common.c      | 18 ++++---
 tools/testing/selftests/mm/uffd-common.h      |  2 +-
 tools/testing/selftests/mm/uffd-stress.c      |  2 +-
 tools/testing/selftests/mm/uffd-unit-tests.c  | 52 +++++++++----------
 10 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
index e2640529dbb29..e62f4e1388f26 100644
--- a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
+++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
@@ -28,7 +28,7 @@ static void signal_handler(int signal)
 }
 
 /* Touch the memory while it is being madvised() */
-void *touch(void *unused)
+void *touch(void __attribute__((unused)) *unused)
 {
 	char *ptr = (char *)huge_ptr;
 
@@ -41,7 +41,7 @@ void *touch(void *unused)
 	return NULL;
 }
 
-void *madv(void *unused)
+void *madv(void __attribute__((unused)) *unused)
 {
 	usleep(rand() % 10);
 
diff --git a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
index 8f122a0f08281..6c326cf3dcf6b 100644
--- a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
+++ b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
@@ -33,7 +33,7 @@ size_t mmap_size;
 char *huge_ptr;
 
 /* Touch the memory while it is being madvised() */
-void *touch(void *unused)
+void *touch(void __attribute__((unused)) *unused)
 {
 	for (int i = 0; i < INLOOP_ITER; i++)
 		huge_ptr[0] = '.';
@@ -41,7 +41,7 @@ void *touch(void *unused)
 	return NULL;
 }
 
-void *madv(void *unused)
+void *madv(void __attribute__((unused)) *unused)
 {
 	for (int i = 0; i < INLOOP_ITER; i++)
 		madvise(huge_ptr, mmap_size, MADV_DONTNEED);
@@ -54,7 +54,7 @@ void *madv(void *unused)
  * The other hugepage should be flipping from used <-> reserved, because
  * of madvise(DONTNEED).
  */
-void *map_extra(void *unused)
+void *map_extra(void __attribute__((unused)) *unused)
 {
 	void *ptr;
 
diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index dcdd5bb20f3d8..323cfcb14e4d4 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -265,8 +265,7 @@ static int ksm_merge_pages(int merge_type, void *addr, size_t size,
 	return 0;
 }
 
-static int ksm_unmerge_pages(void *addr, size_t size,
-			     struct timespec start_time, int timeout)
+static int ksm_unmerge_pages(void *addr, size_t size)
 {
 	if (madvise(addr, size, MADV_UNMERGEABLE)) {
 		perror("madvise");
@@ -483,7 +482,7 @@ static int get_first_mem_node(void)
 	return get_next_mem_node(numa_max_node());
 }
 
-static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeout,
+static int check_ksm_numa_merge(int merge_type, int timeout,
 				bool merge_across_nodes, size_t page_size)
 {
 	void *numa1_map_ptr, *numa2_map_ptr;
@@ -547,8 +546,7 @@ static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeo
 	return KSFT_FAIL;
 }
 
-static int ksm_merge_hugepages_time(int merge_type, int mapping, int prot,
-				int timeout, size_t map_size)
+static int ksm_merge_hugepages_time(int merge_type, int timeout, size_t map_size)
 {
 	void *map_ptr, *map_ptr_orig;
 	struct timespec start_time, end_time;
@@ -678,7 +676,7 @@ static int ksm_unmerge_time(int merge_type, int mapping, int prot, int timeout,
 		perror("clock_gettime");
 		goto err_out;
 	}
-	if (ksm_unmerge_pages(map_ptr, map_size, start_time, timeout))
+	if (ksm_unmerge_pages(map_ptr, map_size))
 		goto err_out;
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
 		perror("clock_gettime");
@@ -906,8 +904,8 @@ int main(int argc, char *argv[])
 						page_size);
 		break;
 	case CHECK_KSM_NUMA_MERGE:
-		ret = check_ksm_numa_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-					ksm_scan_limit_sec, merge_across_nodes, page_size);
+		ret = check_ksm_numa_merge(merge_type, ksm_scan_limit_sec, merge_across_nodes,
+					   page_size);
 		break;
 	case KSM_MERGE_TIME:
 		if (size_MB == 0) {
@@ -922,8 +920,7 @@ int main(int argc, char *argv[])
 			printf("Option '-s' is required.\n");
 			return KSFT_FAIL;
 		}
-		ret = ksm_merge_hugepages_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-				ksm_scan_limit_sec, size_MB);
+		ret = ksm_merge_hugepages_time(merge_type, ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_UNMERGE_TIME:
 		if (size_MB == 0) {
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index b9659fa357371..f9d728e18678c 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -121,7 +121,7 @@ static void test_vmsplice(int fd, const char *desc)
 	close(pipefd[1]);
 }
 
-static void try_process_vm_read(int fd, int pipefd[2])
+static void try_process_vm_read(int __attribute__((unused)) fd, int pipefd[2])
 {
 	struct iovec liov, riov;
 	char buf[64];
@@ -145,7 +145,7 @@ static void try_process_vm_read(int fd, int pipefd[2])
 	exit(KSFT_FAIL);
 }
 
-static void try_ptrace(int fd, int pipefd[2])
+static void try_ptrace(int __attribute__((unused)) fd, int pipefd[2])
 {
 	pid_t ppid = getppid();
 	int status;
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 7286c90fff1a3..b6eb5c4642ce5 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -74,7 +74,7 @@ static void test_vma_reuse(int pagemap_fd, int pagesize)
 	munmap(map2, pagesize);
 }
 
-static void test_hugepage(int pagemap_fd, int pagesize)
+static void test_hugepage(int pagemap_fd)
 {
 	char *map;
 	int i, ret;
@@ -203,7 +203,7 @@ int main(void)
 
 	test_simple(pagemap_fd, pagesize);
 	test_vma_reuse(pagemap_fd, pagesize);
-	test_hugepage(pagemap_fd, pagesize);
+	test_hugepage(pagemap_fd);
 	test_mprotect_anon(pagemap_fd, pagesize);
 	test_mprotect_file(pagemap_fd, pagesize);
 
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index eb6d1b9fc3625..84b1251666aa1 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -103,7 +103,7 @@ static char *allocate_zero_filled_hugepage(size_t len)
 	return result;
 }
 
-static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hpages, size_t len)
+static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, size_t len)
 {
 	unsigned long rss_anon_before, rss_anon_after;
 	size_t i;
@@ -149,7 +149,7 @@ void split_pmd_zero_pages(void)
 	size_t len = nr_hpages * pmd_pagesize;
 
 	one_page = allocate_zero_filled_hugepage(len);
-	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
+	verify_rss_anon_split_huge_page_all_zeroes(one_page, len);
 	printf("Split zero filled huge pages successful\n");
 	free(one_page);
 }
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 717539eddf987..c15674a60f299 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -46,7 +46,7 @@ static void anon_release_pages(char *rel_area)
 		err("madvise(MADV_DONTNEED) failed");
 }
 
-static int anon_allocate_area(void **alloc_area, bool is_src)
+static int anon_allocate_area(void **alloc_area, bool __attribute__((unused)) is_src)
 {
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
@@ -57,7 +57,9 @@ static int anon_allocate_area(void **alloc_area, bool is_src)
 	return 0;
 }
 
-static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void noop_alias_mapping(__u64 __attribute__((unused)) *start,
+			       size_t __attribute__((unused)) len,
+			       unsigned long __attribute__((unused)) offset)
 {
 }
 
@@ -108,7 +110,8 @@ static int hugetlb_allocate_area(void **alloc_area, bool is_src)
 	return 0;
 }
 
-static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void hugetlb_alias_mapping(__u64 *start, size_t __attribute__((unused)) len,
+				  unsigned long offset)
 {
 	if (!map_shared)
 		return;
@@ -167,12 +170,13 @@ static int shmem_allocate_area(void **alloc_area, bool is_src)
 	return 0;
 }
 
-static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void shmem_alias_mapping(__u64 *start, size_t __attribute__((unused)) len,
+				unsigned long offset)
 {
 	*start = (unsigned long)area_dst_alias + offset;
 }
 
-static void shmem_check_pmd_mapping(void *p, int expect_nr_hpages)
+static void shmem_check_pmd_mapping(void __attribute__((unused)) *p, int expect_nr_hpages)
 {
 	if (!check_huge_shmem(area_dst_alias, expect_nr_hpages,
 			      read_pmd_pagesize()))
@@ -416,7 +420,7 @@ static void continue_range(int ufd, __u64 start, __u64 len, bool wp)
 		    ret, (int64_t) req.mapped);
 }
 
-int uffd_read_msg(int ufd, struct uffd_msg *msg)
+int uffd_read_msg(struct uffd_msg *msg)
 {
 	int ret = read(uffd, msg, sizeof(*msg));
 
@@ -537,7 +541,7 @@ void *uffd_poll_thread(void *arg)
 		}
 		if (!(pollfd[0].revents & POLLIN))
 			err("pollfd[0].revents %d", pollfd[0].revents);
-		if (uffd_read_msg(uffd, &msg))
+		if (uffd_read_msg(&msg))
 			continue;
 		switch (msg.event) {
 		default:
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index a70ae10b5f620..4a5d5b37107c7 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -117,7 +117,7 @@ void uffd_stats_report(struct uffd_args *args, int n_cpus);
 int uffd_test_ctx_init(uint64_t features, const char **errmsg);
 void uffd_test_ctx_clear(void);
 int userfaultfd_open(uint64_t *features);
-int uffd_read_msg(int ufd, struct uffd_msg *msg);
+int uffd_read_msg(struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
 int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index a4b83280998ab..1270ff3104cc6 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -136,7 +136,7 @@ static void *uffd_read_thread(void *arg)
 	/* from here cancellation is ok */
 
 	for (;;) {
-		if (uffd_read_msg(uffd, &msg))
+		if (uffd_read_msg(&msg))
 			continue;
 		uffd_handle_page_fault(&msg, args);
 	}
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 9ff71fa1f9bf0..81b315bedb744 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -244,7 +244,7 @@ static void *fork_event_consumer(void *data)
 	ready_for_fork = true;
 
 	/* Read until a full msg received */
-	while (uffd_read_msg(args->parent_uffd, &msg));
+	while (uffd_read_msg(&msg));
 
 	if (msg.event != UFFD_EVENT_FORK)
 		err("wrong message: %u\n", msg.event);
@@ -357,7 +357,7 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 	return result;
 }
 
-static void uffd_wp_unpopulated_test(uffd_test_args_t *args)
+static void uffd_wp_unpopulated_test(uffd_test_args_t __attribute__((unused)) *args)
 {
 	uint64_t value;
 	int pagemap_fd;
@@ -483,8 +483,7 @@ static void uffd_wp_fork_with_event_test(uffd_test_args_t *args)
 	uffd_wp_fork_test_common(args, true);
 }
 
-static void uffd_wp_fork_pin_test_common(uffd_test_args_t *args,
-					 bool with_event)
+static void uffd_wp_fork_pin_test_common(bool with_event)
 {
 	int pagemap_fd;
 	pin_args pin_args = {};
@@ -535,14 +534,14 @@ static void uffd_wp_fork_pin_test_common(uffd_test_args_t *args,
 	close(pagemap_fd);
 }
 
-static void uffd_wp_fork_pin_test(uffd_test_args_t *args)
+static void uffd_wp_fork_pin_test(uffd_test_args_t __attribute__((unused)) *args)
 {
-	uffd_wp_fork_pin_test_common(args, false);
+	uffd_wp_fork_pin_test_common(false);
 }
 
-static void uffd_wp_fork_pin_with_event_test(uffd_test_args_t *args)
+static void uffd_wp_fork_pin_with_event_test(uffd_test_args_t __attribute__((unused)) *args)
 {
-	uffd_wp_fork_pin_test_common(args, true);
+	uffd_wp_fork_pin_test_common(true);
 }
 
 static void check_memory_contents(char *p)
@@ -627,24 +626,25 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
 		uffd_test_pass();
 }
 
-void uffd_minor_test(uffd_test_args_t *args)
+void uffd_minor_test(uffd_test_args_t __attribute__((unused)) *args)
 {
 	uffd_minor_test_common(false, false);
 }
 
-void uffd_minor_wp_test(uffd_test_args_t *args)
+void uffd_minor_wp_test(uffd_test_args_t __attribute__((unused)) *args)
 {
 	uffd_minor_test_common(false, true);
 }
 
-void uffd_minor_collapse_test(uffd_test_args_t *args)
+void uffd_minor_collapse_test(uffd_test_args_t __attribute__((unused)) *args)
 {
 	uffd_minor_test_common(true, false);
 }
 
 static sigjmp_buf jbuf, *sigbuf;
 
-static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
+static void sighndl(int sig, siginfo_t __attribute__((unused)) *siginfo,
+		    void __attribute__((unused)) *ptr)
 {
 	if (sig == SIGBUS) {
 		if (sigbuf)
@@ -820,12 +820,12 @@ static void uffd_sigbus_test_common(bool wp)
 		uffd_test_pass();
 }
 
-static void uffd_sigbus_test(uffd_test_args_t *args)
+static void uffd_sigbus_test(uffd_test_args_t __attribute__((unused)) *args)
 {
 	uffd_sigbus_test_common(false);
 }
 
-static void uffd_sigbus_wp_test(uffd_test_args_t *args)
+static void uffd_sigbus_wp_test(uffd_test_args_t __attribute__((unused)) *args)
 {
 	uffd_sigbus_test_common(true);
 }
@@ -873,12 +873,12 @@ static void uffd_events_test_common(bool wp)
 		uffd_test_pass();
 }
 
-static void uffd_events_test(uffd_test_args_t *args)
+static void uffd_events_test(uffd_test_args_t __attribute__((unused)) *args)
 {
 	uffd_events_test_common(false);
 }
 
-static void uffd_events_wp_test(uffd_test_args_t *args)
+static void uffd_events_wp_test(uffd_test_args_t __attribute__((unused)) *args)
 {
 	uffd_events_test_common(true);
 }
@@ -946,7 +946,7 @@ uffd_register_detect_zeropage(int uffd, void *addr, uint64_t len)
 }
 
 /* exercise UFFDIO_ZEROPAGE */
-static void uffd_zeropage_test(uffd_test_args_t *args)
+static void uffd_zeropage_test(uffd_test_args_t __attribute__((unused)) *args)
 {
 	bool has_zeropage;
 	int i;
@@ -1002,7 +1002,7 @@ static void do_uffdio_poison(int uffd, unsigned long offset)
 }
 
 static void uffd_poison_handle_fault(
-	struct uffd_msg *msg, struct uffd_args *args)
+	struct uffd_msg *msg, struct uffd_args __attribute__((unused)) *args)
 {
 	unsigned long offset;
 
@@ -1023,7 +1023,7 @@ static void uffd_poison_handle_fault(
 		do_uffdio_poison(uffd, offset);
 }
 
-static void uffd_poison_test(uffd_test_args_t *targs)
+static void uffd_poison_test(uffd_test_args_t __attribute__((unused)) *targs)
 {
 	pthread_t uffd_mon;
 	char c;
@@ -1114,7 +1114,7 @@ static void uffd_move_pmd_handle_fault(struct uffd_msg *msg,
 }
 
 static void
-uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
+uffd_move_test_common(unsigned long chunk_size,
 		      void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args))
 {
 	unsigned long nr;
@@ -1206,24 +1206,24 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 		uffd_test_pass();
 }
 
-static void uffd_move_test(uffd_test_args_t *targs)
+static void uffd_move_test(uffd_test_args_t __attribute__((unused)) *targs)
 {
-	uffd_move_test_common(targs, page_size, uffd_move_handle_fault);
+	uffd_move_test_common(page_size, uffd_move_handle_fault);
 }
 
-static void uffd_move_pmd_test(uffd_test_args_t *targs)
+static void uffd_move_pmd_test(uffd_test_args_t __attribute__((unused)) *targs)
 {
 	if (madvise(area_dst, nr_pages * page_size, MADV_HUGEPAGE))
 		err("madvise(MADV_HUGEPAGE) failure");
-	uffd_move_test_common(targs, read_pmd_pagesize(),
+	uffd_move_test_common(read_pmd_pagesize(),
 			      uffd_move_pmd_handle_fault);
 }
 
-static void uffd_move_pmd_split_test(uffd_test_args_t *targs)
+static void uffd_move_pmd_split_test(uffd_test_args_t __attribute__((unused)) *targs)
 {
 	if (madvise(area_dst, nr_pages * page_size, MADV_NOHUGEPAGE))
 		err("madvise(MADV_NOHUGEPAGE) failure");
-	uffd_move_test_common(targs, read_pmd_pagesize(),
+	uffd_move_test_common(read_pmd_pagesize(),
 			      uffd_move_pmd_handle_fault);
 }
 
-- 
2.39.5


