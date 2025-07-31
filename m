Return-Path: <linux-kselftest+bounces-38105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D676B1749E
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 18:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6790AA8333C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3B26FD9B;
	Thu, 31 Jul 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="V1k0vjni"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79923E32D;
	Thu, 31 Jul 2025 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977839; cv=pass; b=EE0DgAsH5clCdd5+o4Mkuj/wGwpaT4G8uWF2v/H+8LvgyaQCyRro07QOVoFenWCOSMYZID45mK/5RNFnnKGjBPZZjGVoOGuNVgOUhT1z3U9iki5RHEXY30rWrj3835/tdQBdf1As9JWFqUS0F7ugXQKSNm08uzzpNnJzH1AL0+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977839; c=relaxed/simple;
	bh=NSmhUbRXEzv8wHvUHxDjDs2GaeGlKxdpWVaIwtS0TaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gbdqmGpdezyPQW6j6wdGK5PNgAP87O2plKPhergqnNQmCOjE8kmzPLCehL0mk/ZmmADVinyy3dx61vMReh5EdSK7wggTZUETGCULSvtG0BDATw1+yncZIU84+vjYMdiw3XCjT1bWKrGKI9yrQkPk91V3SuStHqpYKsasWI+ajsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=V1k0vjni; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753977794; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ujx1sK3b6FE3Nv5iXi/XMjJN0rJKpEI2qZhFgCzaPXeZaOEBjr0scNP5O7REcClbw7JIWr6jxxS14GCWnRpdWhBExi2yeNBxOyPDyOpeuuHtBhBtgEqMRrMm40xXXiO4t4k91hTnyq8RaCJRgA8+6nRHlt33XTFtXXTPcSb0NaA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753977794; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KX4em/GE5ltQsdxfmeYM80ZyMjqjVqVuT5GM9bbxR8w=; 
	b=ASUPeMhliOTGc6KBnq2r+VopbrALlz2QbDdk/36fE/s8XXtnuXktb6zUsiKqvPTr+zbPC0qszS7zd3Qdn0dEVBbzo0DOtmtNPO1RiVg1z/GyfjgJNyZy9CprC42KDbroRzN2EMJIcLqc2n2+S6Mhss7DkezJfckTX9v4nmoh3vQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753977794;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=KX4em/GE5ltQsdxfmeYM80ZyMjqjVqVuT5GM9bbxR8w=;
	b=V1k0vjnih4FE/4EHG7hKwlzRHwUZHhD0ya3pC+Fb1V1vSXc37HlH2zp4x4jq5ypf
	j6dnv8jctjcMjyUk6rVwkfaP3+KY6+fz1TZtRUEmX4Va2o7RqiB3MVOQDesN5RaI9GM
	n/Vzk90/ibwDMYmnr3XyqEGzqtg8UZOVaJMZVb4Q=
Received: by mx.zohomail.com with SMTPS id 1753977792702357.38842988413626;
	Thu, 31 Jul 2025 09:03:12 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v2 6/8] selftests/mm: Mark unused arguments with __unused
Date: Thu, 31 Jul 2025 21:01:30 +0500
Message-Id: <20250731160132.1795351-7-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731160132.1795351-1-usama.anjum@collabora.com>
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Mark the arguments which cannot be removed with __unused attribute.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/cow.c             | 20 ++++++-------
 tools/testing/selftests/mm/memfd_secret.c    |  4 +--
 tools/testing/selftests/mm/pfnmap.c          |  2 +-
 tools/testing/selftests/mm/uffd-common.c     | 11 +++----
 tools/testing/selftests/mm/uffd-unit-tests.c | 30 ++++++++++----------
 5 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index eb1ccf067b633..6f6c4e85240c7 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -253,12 +253,12 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
 	close_comm_pipes(&comm_pipes);
 }
 
-static void test_cow_in_parent(char *mem, size_t size, bool is_hugetlb)
+static void test_cow_in_parent(char *mem, size_t size, bool __unused is_hugetlb)
 {
 	do_test_cow_in_parent(mem, size, false, child_memcmp_fn, false);
 }
 
-static void test_cow_in_parent_mprotect(char *mem, size_t size, bool is_hugetlb)
+static void test_cow_in_parent_mprotect(char *mem, size_t size, bool __unused is_hugetlb)
 {
 	do_test_cow_in_parent(mem, size, true, child_memcmp_fn, false);
 }
@@ -734,36 +734,36 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 	free(tmp);
 }
 
-static void test_ro_pin_on_shared(char *mem, size_t size, bool is_hugetlb)
+static void test_ro_pin_on_shared(char *mem, size_t size, bool __unused is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_SHARED, false);
 }
 
-static void test_ro_fast_pin_on_shared(char *mem, size_t size, bool is_hugetlb)
+static void test_ro_fast_pin_on_shared(char *mem, size_t size, bool __unused is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_SHARED, true);
 }
 
 static void test_ro_pin_on_ro_previously_shared(char *mem, size_t size,
-		bool is_hugetlb)
+		bool __unused is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_PREVIOUSLY_SHARED, false);
 }
 
 static void test_ro_fast_pin_on_ro_previously_shared(char *mem, size_t size,
-		bool is_hugetlb)
+		bool __unused is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_PREVIOUSLY_SHARED, true);
 }
 
 static void test_ro_pin_on_ro_exclusive(char *mem, size_t size,
-		bool is_hugetlb)
+		bool __unused is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_RO_EXCLUSIVE, false);
 }
 
 static void test_ro_fast_pin_on_ro_exclusive(char *mem, size_t size,
-		bool is_hugetlb)
+		bool __unused is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_RO_EXCLUSIVE, true);
 }
@@ -1522,12 +1522,12 @@ static void test_cow(char *mem, const char *smem, size_t size)
 	free(old);
 }
 
-static void test_ro_pin(char *mem, const char *smem, size_t size)
+static void test_ro_pin(char *mem, const char __unused *smem, size_t size)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST, false);
 }
 
-static void test_ro_fast_pin(char *mem, const char *smem, size_t size)
+static void test_ro_fast_pin(char *mem, const char __unused *smem, size_t size)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST, true);
 }
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 836383f63b630..7117cc0f56dbb 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -123,7 +123,7 @@ static void test_vmsplice(int fd, const char *desc)
 	close(pipefd[1]);
 }
 
-static void try_process_vm_read(int fd, int pipefd[2])
+static void try_process_vm_read(int __unused fd, int pipefd[2])
 {
 	struct iovec liov, riov;
 	char buf[64];
@@ -147,7 +147,7 @@ static void try_process_vm_read(int fd, int pipefd[2])
 	exit(KSFT_FAIL);
 }
 
-static void try_ptrace(int fd, int pipefd[2])
+static void try_ptrace(int __unused fd, int pipefd[2])
 {
 	pid_t ppid = getppid();
 	int status;
diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index 866ac023baf5c..54c9af20d312e 100644
--- a/tools/testing/selftests/mm/pfnmap.c
+++ b/tools/testing/selftests/mm/pfnmap.c
@@ -26,7 +26,7 @@
 
 static sigjmp_buf sigjmp_buf_env;
 
-static void signal_handler(int sig)
+static void signal_handler(int __unused sig)
 {
 	siglongjmp(sigjmp_buf_env, -EFAULT);
 }
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 815c22114b57e..e309ec886fa72 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -46,7 +46,7 @@ static void anon_release_pages(char *rel_area)
 		err("madvise(MADV_DONTNEED) failed");
 }
 
-static int anon_allocate_area(void **alloc_area, bool is_src)
+static int anon_allocate_area(void **alloc_area, bool __unused is_src)
 {
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
@@ -57,7 +57,8 @@ static int anon_allocate_area(void **alloc_area, bool is_src)
 	return 0;
 }
 
-static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void noop_alias_mapping(__u64 __unused *start, size_t __unused len,
+			       unsigned long __unused offset)
 {
 }
 
@@ -108,7 +109,7 @@ static int hugetlb_allocate_area(void **alloc_area, bool is_src)
 	return 0;
 }
 
-static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void hugetlb_alias_mapping(__u64 *start, size_t __unused len, unsigned long offset)
 {
 	if (!map_shared)
 		return;
@@ -167,12 +168,12 @@ static int shmem_allocate_area(void **alloc_area, bool is_src)
 	return 0;
 }
 
-static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void shmem_alias_mapping(__u64 *start, size_t __unused len, unsigned long offset)
 {
 	*start = (unsigned long)area_dst_alias + offset;
 }
 
-static void shmem_check_pmd_mapping(void *p, int expect_nr_hpages)
+static void shmem_check_pmd_mapping(void __unused *p, int expect_nr_hpages)
 {
 	if (!check_huge_shmem(area_dst_alias, expect_nr_hpages,
 			      read_pmd_pagesize()))
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index df7b82bbebaad..ee9b407e893e1 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -361,7 +361,7 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 	return result;
 }
 
-static void uffd_wp_unpopulated_test(uffd_test_args_t *args)
+static void uffd_wp_unpopulated_test(uffd_test_args_t __unused *args)
 {
 	uint64_t value;
 	int pagemap_fd;
@@ -487,7 +487,7 @@ static void uffd_wp_fork_with_event_test(uffd_test_args_t *args)
 	uffd_wp_fork_test_common(args, true);
 }
 
-static void uffd_wp_fork_pin_test_common(uffd_test_args_t *args,
+static void uffd_wp_fork_pin_test_common(uffd_test_args_t __unused *args,
 					 bool with_event)
 {
 	int pagemap_fd;
@@ -631,24 +631,24 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
 		uffd_test_pass();
 }
 
-void uffd_minor_test(uffd_test_args_t *args)
+void uffd_minor_test(uffd_test_args_t __unused *args)
 {
 	uffd_minor_test_common(false, false);
 }
 
-void uffd_minor_wp_test(uffd_test_args_t *args)
+void uffd_minor_wp_test(uffd_test_args_t __unused *args)
 {
 	uffd_minor_test_common(false, true);
 }
 
-void uffd_minor_collapse_test(uffd_test_args_t *args)
+void uffd_minor_collapse_test(uffd_test_args_t __unused *args)
 {
 	uffd_minor_test_common(true, false);
 }
 
 static sigjmp_buf jbuf, *sigbuf;
 
-static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
+static void sighndl(int sig, siginfo_t __unused *siginfo, void __unused *ptr)
 {
 	if (sig == SIGBUS) {
 		if (sigbuf)
@@ -824,12 +824,12 @@ static void uffd_sigbus_test_common(bool wp)
 		uffd_test_pass();
 }
 
-static void uffd_sigbus_test(uffd_test_args_t *args)
+static void uffd_sigbus_test(uffd_test_args_t __unused *args)
 {
 	uffd_sigbus_test_common(false);
 }
 
-static void uffd_sigbus_wp_test(uffd_test_args_t *args)
+static void uffd_sigbus_wp_test(uffd_test_args_t __unused *args)
 {
 	uffd_sigbus_test_common(true);
 }
@@ -877,12 +877,12 @@ static void uffd_events_test_common(bool wp)
 		uffd_test_pass();
 }
 
-static void uffd_events_test(uffd_test_args_t *args)
+static void uffd_events_test(uffd_test_args_t __unused *args)
 {
 	uffd_events_test_common(false);
 }
 
-static void uffd_events_wp_test(uffd_test_args_t *args)
+static void uffd_events_wp_test(uffd_test_args_t __unused *args)
 {
 	uffd_events_test_common(true);
 }
@@ -950,7 +950,7 @@ uffd_register_detect_zeropage(int uffd, void *addr, uint64_t len)
 }
 
 /* exercise UFFDIO_ZEROPAGE */
-static void uffd_zeropage_test(uffd_test_args_t *args)
+static void uffd_zeropage_test(uffd_test_args_t __unused *args)
 {
 	bool has_zeropage;
 	int i;
@@ -1006,7 +1006,7 @@ static void do_uffdio_poison(int uffd, unsigned long offset)
 }
 
 static void uffd_poison_handle_fault(
-	struct uffd_msg *msg, struct uffd_args *args)
+	struct uffd_msg *msg, struct uffd_args __unused *args)
 {
 	unsigned long offset;
 
@@ -1030,7 +1030,7 @@ static void uffd_poison_handle_fault(
 /* Make sure to cover odd/even, and minimum duplications */
 #define  UFFD_POISON_TEST_NPAGES  4
 
-static void uffd_poison_test(uffd_test_args_t *targs)
+static void uffd_poison_test(uffd_test_args_t __unused *targs)
 {
 	pthread_t uffd_mon;
 	char c;
@@ -1126,7 +1126,7 @@ static void uffd_move_pmd_handle_fault(struct uffd_msg *msg,
 }
 
 static void
-uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
+uffd_move_test_common(uffd_test_args_t __unused *targs, unsigned long chunk_size,
 		      void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args))
 {
 	unsigned long nr;
@@ -1359,7 +1359,7 @@ static void uffd_consume_message(void)
 	while (uffd_read_msg(&msg));
 }
 
-static void uffd_mmap_changing_test(uffd_test_args_t *targs)
+static void uffd_mmap_changing_test(uffd_test_args_t __unused *targs)
 {
 	/*
 	 * This stores the real PID (which can be different from how tid is
-- 
2.39.5


