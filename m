Return-Path: <linux-kselftest+bounces-40317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0FEB3C007
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 17:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BE87A2F42
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED76322A18;
	Fri, 29 Aug 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZL+AwBT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18E322C87;
	Fri, 29 Aug 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483010; cv=none; b=JYCfYZ3TsIslcpdtD+R0/HJJ9bgNPS4UT5G0WwBq1bbLFT7hkSVWxw+fPfww9yZ/Mmi0xg/fRjBiyic3RdmjHbrChdm6wbJRj08thKv1Pzt2kmHrXVOer1kXfmF50OFXN/0ESp190sSbOfuEPTyGgGStwVOnAiEcbAl7PVSRS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483010; c=relaxed/simple;
	bh=7rLHhrl7KeBAmQR5Odap0TEKt6ln3fjGc75CWkSCUCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aR/YqznoQWW1b3gyDgIBQnRnKcxSCcFDmgrJqxVqSUQwVoPUcu4TkbLCtuwBgsP4nUXAD7vJSWRKMyoLsO7Q55MCaoI9D5A9SIGKkPymC7L1yBUHViFrd4RWI3JzhWOS15ElaUi/C6LotjU49uU0CgJIqv0dZjI82XZBl5ZwFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZL+AwBT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77201f3d389so2410977b3a.2;
        Fri, 29 Aug 2025 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756483005; x=1757087805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4MmccOD7MsL1t45a4Ftt4bM/IxUvvQBr3e6QSlr6rM=;
        b=aZL+AwBTd49mYh8a0qjuUe8OQg+Y7agatF21ezHcc4MXAqFpeE9fX4mxq4NP0g2lKp
         OmEpOx6f7Xr/wIh4evlbvUrwlWxWmumixiyZC7rLjqKFyuyiGHoFle3lYBCxcIjWpxSW
         QlxXiYO5mbSsCmMpFrXf1vrHGTdSyygKQgNdLUiGAw0bXF5/cJ4dTldM5yH6IMnm4wxR
         7ONfkRlsYMp1gtW4UZXbw7oElTuRC90qQEp+xrj3gEfOQ+STyPKC0B6F+/KPC5BzXGGD
         /5ToQzzNQDeZAPiy5FjYc3tpKQiMDjkjVEvB2Si3MvFGkr0z9V6DG2bmGUPcSYIG4bcg
         DRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756483005; x=1757087805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4MmccOD7MsL1t45a4Ftt4bM/IxUvvQBr3e6QSlr6rM=;
        b=M8Q1dk/ZeeAbsnJozfA54nCD6O1cVw4Q6fx5eVYK3K4+Dns2/mGekSE5GmxuunB1Qo
         A7hhdeGvL+4v1roEyauYla0tNpquWpP2KuOw7VCtNIAY6PV0x8smiZcB63n5QKxIvu6j
         WlaCbQM5DPcG8B9cLWN5llsqwzJdfh5VZaDjlDY6VeWwniH6M7r4ox0kJLbKelCasl16
         esY3fKT6ZgwjECo0JrfudgCZyoPng4KkFwWoJyxaY84cosusWDD3mYUQNwHHN3qjdNtH
         WlArhhkWGBkNLwh8BouzHEAh1XyNr0AVrTIaSXZ6ToHNyRcOChMUzB4U/ds/CZOvQvP0
         YE6A==
X-Forwarded-Encrypted: i=1; AJvYcCU/8J8sh5WjUSRKXyKg7gMKEtWJi8TJF4pW/UsAieKJAOEuy/2XXZ1rMcyCd+lzNlWFSQkvvxzxHO3rVFHvrQ2t@vger.kernel.org, AJvYcCWOR8VoIGmryO8WXNr6OdtzU/yR6HYYdVIkD/mnxaaxwj09q/WBJE25ocd2488OozC7sx0Au/HnGjLkVco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rh56+eULWkV/QB6YX8apXD48CljLa7qxAx2kg+EfX/2iHj6V
	0Tn19FR2eKeWGpsI4y4QoDqTv718EyUv64ubSKd7aUT2nohPir9bmUUCx8VegfA=
X-Gm-Gg: ASbGncuB2LNC/NtV4Y2dff0VV0hV056UVH9OjWOXtbdkwQKFBbYBvT42pxHPFKomY46
	3J0ykWwdEY/IelhowI8C5B9abEqNKvIiK+5vP+T8KFFaMxzKaRQWmhLJwjB/F+FIX/fzRuHi4K+
	6TMCZstRSFWwkXQ1wTzero8rbHxSajNUgKAHEC0bpBZFK5tsfD+PIQTw90QYuuMjZjwuWC9TfPB
	ZTCldboMMnjZdtHvHkx3eL06e5AW8IKSS39vAqfP8uPbloipoHG4N3mrn7aVOTOdKww1gzKibk8
	aNGZ7TIC2RD+1M7V1G1r7wz9KdzSZx9GXOhF44QcPCdkZUZtPhOHDtQkfBacPGfEgy5ckcaklHh
	W6ekCRDiF+m8IWiLzquHe0AIJwKGPOGNf1g==
X-Google-Smtp-Source: AGHT+IGqXGd5GllTWiZDFFXDjYeUJ9T7E3jB2Wg2PEtWoQ+bhDMdXdkRynnvYRTN+1r6PnTnUIHNZQ==
X-Received: by 2002:a05:6a00:7094:b0:771:f69a:c426 with SMTP id d2e1a72fcca58-771f69acc06mr18552698b3a.14.1756483004635;
        Fri, 29 Aug 2025 08:56:44 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.135.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b362dsm2795992b3a.32.2025.08.29.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 08:56:43 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: akpm@linux-foundation.org,
	peterx@redhat.com,
	david@redhat.com,
	jackmanb@google.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [PATCH v8 1/1] selftests/mm/uffd: Refactor non-composite global vars into struct
Date: Fri, 29 Aug 2025 21:26:00 +0530
Message-Id: <20250829155600.2000-1-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor macros and non-composite global variable definitions into a
struct that is defined at the start of a test and is passed around
instead of relying on global vars.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
---
v7:
https://lore.kernel.org/all/20250817065211.855-1-ujwal.kundur@gmail.com/

 Changes since v7:
 - rebase on mm-new again after cd79a1d9b08a was dropped
 - address minor formatting nits (David)
 Changes since v6:
 - rebased on 6.17-rc1 changes (cd79a1d9b08a)
   - removes unused args and adds the __unused attribute; since change
     is cosmetic-only, carry forward Acked-by tag
 - verified output remains unchanged using virtme-ng
 Changes since v5:
 - ensure uffd_global_test_opts_t instances are initialized
 - verified output remains unchanged using virtme-ng
 Changes since v4:
 - define gopts as global within uffd-stress.c to retain existing
   sigalrm handler logic
 Changes since v3:
 - more formatting fixes
 Changes since v2:
 - redo patch on mm-new branch
 Changes since v1:
 - indentation fixes
 - squash into single patch to assist bisections

 tools/testing/selftests/mm/uffd-common.c     | 271 ++++-----
 tools/testing/selftests/mm/uffd-common.h     |  78 +--
 tools/testing/selftests/mm/uffd-stress.c     | 228 ++++----
 tools/testing/selftests/mm/uffd-unit-tests.c | 559 ++++++++++---------
 tools/testing/selftests/mm/uffd-wp-mremap.c  |  20 +-
 5 files changed, 615 insertions(+), 541 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index a37088a23ffe..994fe8c03923 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -7,18 +7,29 @@
 
 #include "uffd-common.h"
 
-#define BASE_PMD_ADDR ((void *)(1UL << 30))
-
-volatile bool test_uffdio_copy_eexist = true;
-unsigned long nr_parallel, nr_pages, nr_pages_per_cpu, page_size;
-char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
-int uffd = -1, uffd_flags, finished, *pipefd, test_type;
-bool map_shared;
-bool test_uffdio_wp = true;
-unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
-atomic_bool ready_for_fork;
+
+#define BASE_PMD_ADDR ((void *)(1UL << 30))
+
+/* pthread_mutex_t starts at page offset 0 */
+pthread_mutex_t *area_mutex(char *area, unsigned long nr, uffd_global_test_opts_t *gopts)
+{
+	return (pthread_mutex_t *) (area + nr * gopts->page_size);
+}
+
+/*
+ * count is placed in the page after pthread_mutex_t naturally aligned
+ * to avoid non alignment faults on non-x86 archs.
+ */
+volatile unsigned long long *area_count(char *area, unsigned long nr,
+					uffd_global_test_opts_t *gopts)
+{
+	return (volatile unsigned long long *)
+	       ((unsigned long)(area + nr * gopts->page_size +
+	       sizeof(pthread_mutex_t) + sizeof(unsigned long long) - 1) &
+	       ~(unsigned long)(sizeof(unsigned long long) - 1));
+}
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -40,15 +51,15 @@ static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 	return mem_fd;
 }
 
-static void anon_release_pages(char *rel_area)
+static void anon_release_pages(uffd_global_test_opts_t *gopts, char *rel_area)
 {
-	if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
+	if (madvise(rel_area, gopts->nr_pages * gopts->page_size, MADV_DONTNEED))
 		err("madvise(MADV_DONTNEED) failed");
 }
 
-static int anon_allocate_area(void **alloc_area, bool is_src)
+static int anon_allocate_area(uffd_global_test_opts_t *gopts, void **alloc_area, bool is_src)
 {
-	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
+	*alloc_area = mmap(NULL, gopts->nr_pages * gopts->page_size, PROT_READ | PROT_WRITE,
 			   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	if (*alloc_area == MAP_FAILED) {
 		*alloc_area = NULL;
@@ -57,31 +68,32 @@ static int anon_allocate_area(void **alloc_area, bool is_src)
 	return 0;
 }
 
-static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void noop_alias_mapping(uffd_global_test_opts_t *gopts, __u64 *start,
+			       size_t len, unsigned long offset)
 {
 }
 
-static void hugetlb_release_pages(char *rel_area)
+static void hugetlb_release_pages(uffd_global_test_opts_t *gopts, char *rel_area)
 {
-	if (!map_shared) {
-		if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
+	if (!gopts->map_shared) {
+		if (madvise(rel_area, gopts->nr_pages * gopts->page_size, MADV_DONTNEED))
 			err("madvise(MADV_DONTNEED) failed");
 	} else {
-		if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
+		if (madvise(rel_area, gopts->nr_pages * gopts->page_size, MADV_REMOVE))
 			err("madvise(MADV_REMOVE) failed");
 	}
 }
 
-static int hugetlb_allocate_area(void **alloc_area, bool is_src)
+static int hugetlb_allocate_area(uffd_global_test_opts_t *gopts, void **alloc_area, bool is_src)
 {
-	off_t size = nr_pages * page_size;
+	off_t size = gopts->nr_pages * gopts->page_size;
 	off_t offset = is_src ? 0 : size;
 	void *area_alias = NULL;
 	char **alloc_area_alias;
 	int mem_fd = uffd_mem_fd_create(size * 2, true);
 
 	*alloc_area = mmap(NULL, size, PROT_READ | PROT_WRITE,
-			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
+			   (gopts->map_shared ? MAP_SHARED : MAP_PRIVATE) |
 			   (is_src ? 0 : MAP_NORESERVE),
 			   mem_fd, offset);
 	if (*alloc_area == MAP_FAILED) {
@@ -89,7 +101,7 @@ static int hugetlb_allocate_area(void **alloc_area, bool is_src)
 		return -errno;
 	}
 
-	if (map_shared) {
+	if (gopts->map_shared) {
 		area_alias = mmap(NULL, size, PROT_READ | PROT_WRITE,
 				  MAP_SHARED, mem_fd, offset);
 		if (area_alias == MAP_FAILED)
@@ -97,9 +109,9 @@ static int hugetlb_allocate_area(void **alloc_area, bool is_src)
 	}
 
 	if (is_src) {
-		alloc_area_alias = &area_src_alias;
+		alloc_area_alias = &gopts->area_src_alias;
 	} else {
-		alloc_area_alias = &area_dst_alias;
+		alloc_area_alias = &gopts->area_dst_alias;
 	}
 	if (area_alias)
 		*alloc_area_alias = area_alias;
@@ -108,24 +120,25 @@ static int hugetlb_allocate_area(void **alloc_area, bool is_src)
 	return 0;
 }
 
-static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void hugetlb_alias_mapping(uffd_global_test_opts_t *gopts, __u64 *start,
+				  size_t len, unsigned long offset)
 {
-	if (!map_shared)
+	if (!gopts->map_shared)
 		return;
 
-	*start = (unsigned long) area_dst_alias + offset;
+	*start = (unsigned long) gopts->area_dst_alias + offset;
 }
 
-static void shmem_release_pages(char *rel_area)
+static void shmem_release_pages(uffd_global_test_opts_t *gopts, char *rel_area)
 {
-	if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
+	if (madvise(rel_area, gopts->nr_pages * gopts->page_size, MADV_REMOVE))
 		err("madvise(MADV_REMOVE) failed");
 }
 
-static int shmem_allocate_area(void **alloc_area, bool is_src)
+static int shmem_allocate_area(uffd_global_test_opts_t *gopts, void **alloc_area, bool is_src)
 {
 	void *area_alias = NULL;
-	size_t bytes = nr_pages * page_size, hpage_size = read_pmd_pagesize();
+	size_t bytes = gopts->nr_pages * gopts->page_size, hpage_size = read_pmd_pagesize();
 	unsigned long offset = is_src ? 0 : bytes;
 	char *p = NULL, *p_alias = NULL;
 	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
@@ -159,22 +172,23 @@ static int shmem_allocate_area(void **alloc_area, bool is_src)
 		err("mmap of anonymous memory failed at %p", p_alias);
 
 	if (is_src)
-		area_src_alias = area_alias;
+		gopts->area_src_alias = area_alias;
 	else
-		area_dst_alias = area_alias;
+		gopts->area_dst_alias = area_alias;
 
 	close(mem_fd);
 	return 0;
 }
 
-static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void shmem_alias_mapping(uffd_global_test_opts_t *gopts, __u64 *start,
+				size_t len, unsigned long offset)
 {
-	*start = (unsigned long)area_dst_alias + offset;
+	*start = (unsigned long)gopts->area_dst_alias + offset;
 }
 
-static void shmem_check_pmd_mapping(void *p, int expect_nr_hpages)
+static void shmem_check_pmd_mapping(uffd_global_test_opts_t *gopts, void *p, int expect_nr_hpages)
 {
-	if (!check_huge_shmem(area_dst_alias, expect_nr_hpages,
+	if (!check_huge_shmem(gopts->area_dst_alias, expect_nr_hpages,
 			      read_pmd_pagesize()))
 		err("Did not find expected %d number of hugepages",
 		    expect_nr_hpages);
@@ -234,18 +248,18 @@ void uffd_stats_report(struct uffd_args *args, int n_cpus)
 	printf("\n");
 }
 
-int userfaultfd_open(uint64_t *features)
+int userfaultfd_open(uffd_global_test_opts_t *gopts, uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
 
-	uffd = uffd_open(UFFD_FLAGS);
-	if (uffd < 0)
+	gopts->uffd = uffd_open(UFFD_FLAGS);
+	if (gopts->uffd < 0)
 		return -1;
-	uffd_flags = fcntl(uffd, F_GETFD, NULL);
+	gopts->uffd_flags = fcntl(gopts->uffd, F_GETFD, NULL);
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = *features;
-	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
+	if (ioctl(gopts->uffd, UFFDIO_API, &uffdio_api))
 		/* Probably lack of CAP_PTRACE? */
 		return -1;
 	if (uffdio_api.api != UFFD_API)
@@ -255,59 +269,63 @@ int userfaultfd_open(uint64_t *features)
 	return 0;
 }
 
-static inline void munmap_area(void **area)
+static inline void munmap_area(uffd_global_test_opts_t *gopts, void **area)
 {
 	if (*area)
-		if (munmap(*area, nr_pages * page_size))
+		if (munmap(*area, gopts->nr_pages * gopts->page_size))
 			err("munmap");
 
 	*area = NULL;
 }
 
-void uffd_test_ctx_clear(void)
+void uffd_test_ctx_clear(uffd_global_test_opts_t *gopts)
 {
 	size_t i;
 
-	if (pipefd) {
-		for (i = 0; i < nr_parallel * 2; ++i) {
-			if (close(pipefd[i]))
+	if (gopts->pipefd) {
+		for (i = 0; i < gopts->nr_parallel * 2; ++i) {
+			if (close(gopts->pipefd[i]))
 				err("close pipefd");
 		}
-		free(pipefd);
-		pipefd = NULL;
+		free(gopts->pipefd);
+		gopts->pipefd = NULL;
 	}
 
-	if (count_verify) {
-		free(count_verify);
-		count_verify = NULL;
+	if (gopts->count_verify) {
+		free(gopts->count_verify);
+		gopts->count_verify = NULL;
 	}
 
-	if (uffd != -1) {
-		if (close(uffd))
+	if (gopts->uffd != -1) {
+		if (close(gopts->uffd))
 			err("close uffd");
-		uffd = -1;
+		gopts->uffd = -1;
 	}
 
-	munmap_area((void **)&area_src);
-	munmap_area((void **)&area_src_alias);
-	munmap_area((void **)&area_dst);
-	munmap_area((void **)&area_dst_alias);
-	munmap_area((void **)&area_remap);
+	munmap_area(gopts, (void **)&gopts->area_src);
+	munmap_area(gopts, (void **)&gopts->area_src_alias);
+	munmap_area(gopts, (void **)&gopts->area_dst);
+	munmap_area(gopts, (void **)&gopts->area_dst_alias);
+	munmap_area(gopts, (void **)&gopts->area_remap);
 }
 
-int uffd_test_ctx_init(uint64_t features, const char **errmsg)
+int uffd_test_ctx_init(uffd_global_test_opts_t *gopts, uint64_t features, const char **errmsg)
 {
 	unsigned long nr, cpu;
 	int ret;
 
+	gopts->area_src_alias = NULL;
+	gopts->area_dst_alias = NULL;
+	gopts->area_remap = NULL;
+
 	if (uffd_test_case_ops && uffd_test_case_ops->pre_alloc) {
-		ret = uffd_test_case_ops->pre_alloc(errmsg);
+		ret = uffd_test_case_ops->pre_alloc(gopts, errmsg);
 		if (ret)
 			return ret;
 	}
 
-	ret = uffd_test_ops->allocate_area((void **)&area_src, true);
-	ret |= uffd_test_ops->allocate_area((void **)&area_dst, false);
+	ret = uffd_test_ops->allocate_area(gopts, (void **) &gopts->area_src, true);
+	ret |= uffd_test_ops->allocate_area(gopts, (void **) &gopts->area_dst, false);
 	if (ret) {
 		if (errmsg)
 			*errmsg = "memory allocation failed";
@@ -315,26 +333,26 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	}
 
 	if (uffd_test_case_ops && uffd_test_case_ops->post_alloc) {
-		ret = uffd_test_case_ops->post_alloc(errmsg);
+		ret = uffd_test_case_ops->post_alloc(gopts, errmsg);
 		if (ret)
 			return ret;
 	}
 
-	ret = userfaultfd_open(&features);
+	ret = userfaultfd_open(gopts, &features);
 	if (ret) {
 		if (errmsg)
 			*errmsg = "possible lack of privilege";
 		return ret;
 	}
 
-	count_verify = malloc(nr_pages * sizeof(unsigned long long));
-	if (!count_verify)
+	gopts->count_verify = malloc(gopts->nr_pages * sizeof(unsigned long long));
+	if (!gopts->count_verify)
 		err("count_verify");
 
-	for (nr = 0; nr < nr_pages; nr++) {
-		*area_mutex(area_src, nr) =
+	for (nr = 0; nr < gopts->nr_pages; nr++) {
+		*area_mutex(gopts->area_src, nr, gopts) =
 			(pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
-		count_verify[nr] = *area_count(area_src, nr) = 1;
+		gopts->count_verify[nr] = *area_count(gopts->area_src, nr, gopts) = 1;
 		/*
 		 * In the transition between 255 to 256, powerpc will
 		 * read out of order in my_bcmp and see both bytes as
@@ -342,7 +360,7 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 		 * after the count, to avoid my_bcmp to trigger false
 		 * positives.
 		 */
-		*(area_count(area_src, nr) + 1) = 1;
+		*(area_count(gopts->area_src, nr, gopts) + 1) = 1;
 	}
 
 	/*
@@ -363,13 +381,13 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	 * proactively split the thp and drop any accidentally initialized
 	 * pages within area_dst.
 	 */
-	uffd_test_ops->release_pages(area_dst);
+	uffd_test_ops->release_pages(gopts, gopts->area_dst);
 
-	pipefd = malloc(sizeof(int) * nr_parallel * 2);
-	if (!pipefd)
+	gopts->pipefd = malloc(sizeof(int) * gopts->nr_parallel * 2);
+	if (!gopts->pipefd)
 		err("pipefd");
-	for (cpu = 0; cpu < nr_parallel; cpu++)
-		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
+	for (cpu = 0; cpu < gopts->nr_parallel; cpu++)
+		if (pipe2(&gopts->pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
 			err("pipe");
 
 	return 0;
@@ -416,9 +434,9 @@ static void continue_range(int ufd, __u64 start, __u64 len, bool wp)
 		    ret, (int64_t) req.mapped);
 }
 
-int uffd_read_msg(int ufd, struct uffd_msg *msg)
+int uffd_read_msg(uffd_global_test_opts_t *gopts, struct uffd_msg *msg)
 {
-	int ret = read(uffd, msg, sizeof(*msg));
+	int ret = read(gopts->uffd, msg, sizeof(*msg));
 
 	if (ret != sizeof(*msg)) {
 		if (ret < 0) {
@@ -433,7 +451,8 @@ int uffd_read_msg(int ufd, struct uffd_msg *msg)
 	return 0;
 }
 
-void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
+void uffd_handle_page_fault(uffd_global_test_opts_t *gopts, struct uffd_msg *msg,
+			    struct uffd_args *args)
 {
 	unsigned long offset;
 
@@ -442,7 +461,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 
 	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
 		/* Write protect page faults */
-		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
+		wp_range(gopts->uffd, msg->arg.pagefault.address, gopts->page_size, false);
 		args->wp_faults++;
 	} else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) {
 		uint8_t *area;
@@ -460,12 +479,12 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 		 * (UFFD-registered).
 		 */
 
-		area = (uint8_t *)(area_dst +
-				   ((char *)msg->arg.pagefault.address -
-				    area_dst_alias));
-		for (b = 0; b < page_size; ++b)
+		area = (uint8_t *)(gopts->area_dst +
+		       ((char *)msg->arg.pagefault.address -
+		       gopts->area_dst_alias));
+		for (b = 0; b < gopts->page_size; ++b)
 			area[b] = ~area[b];
-		continue_range(uffd, msg->arg.pagefault.address, page_size,
+		continue_range(gopts->uffd, msg->arg.pagefault.address, gopts->page_size,
 			       args->apply_wp);
 		args->minor_faults++;
 	} else {
@@ -493,10 +512,10 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
 			err("unexpected write fault");
 
-		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
-		offset &= ~(page_size-1);
+		offset = (char *)(unsigned long)msg->arg.pagefault.address - gopts->area_dst;
+		offset &= ~(gopts->page_size-1);
 
-		if (copy_page(uffd, offset, args->apply_wp))
+		if (copy_page(gopts, offset, args->apply_wp))
 			args->missing_faults++;
 	}
 }
@@ -504,6 +523,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 void *uffd_poll_thread(void *arg)
 {
 	struct uffd_args *args = (struct uffd_args *)arg;
+	uffd_global_test_opts_t *gopts = args->gopts;
 	unsigned long cpu = args->cpu;
 	struct pollfd pollfd[2];
 	struct uffd_msg msg;
@@ -514,12 +534,12 @@ void *uffd_poll_thread(void *arg)
 	if (!args->handle_fault)
 		args->handle_fault = uffd_handle_page_fault;
 
-	pollfd[0].fd = uffd;
+	pollfd[0].fd = gopts->uffd;
 	pollfd[0].events = POLLIN;
-	pollfd[1].fd = pipefd[cpu*2];
+	pollfd[1].fd = gopts->pipefd[cpu*2];
 	pollfd[1].events = POLLIN;
 
-	ready_for_fork = true;
+	gopts->ready_for_fork = true;
 
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
@@ -537,30 +557,30 @@ void *uffd_poll_thread(void *arg)
 		}
 		if (!(pollfd[0].revents & POLLIN))
 			err("pollfd[0].revents %d", pollfd[0].revents);
-		if (uffd_read_msg(uffd, &msg))
+		if (uffd_read_msg(gopts, &msg))
 			continue;
 		switch (msg.event) {
 		default:
 			err("unexpected msg event %u\n", msg.event);
 			break;
 		case UFFD_EVENT_PAGEFAULT:
-			args->handle_fault(&msg, args);
+			args->handle_fault(gopts, &msg, args);
 			break;
 		case UFFD_EVENT_FORK:
-			close(uffd);
-			uffd = msg.arg.fork.ufd;
-			pollfd[0].fd = uffd;
+			close(gopts->uffd);
+			gopts->uffd = msg.arg.fork.ufd;
+			pollfd[0].fd = gopts->uffd;
 			break;
 		case UFFD_EVENT_REMOVE:
 			uffd_reg.range.start = msg.arg.remove.start;
 			uffd_reg.range.len = msg.arg.remove.end -
 				msg.arg.remove.start;
-			if (ioctl(uffd, UFFDIO_UNREGISTER, &uffd_reg.range))
+			if (ioctl(gopts->uffd, UFFDIO_UNREGISTER, &uffd_reg.range))
 				err("remove failure");
 			break;
 		case UFFD_EVENT_REMAP:
-			area_remap = area_dst;  /* save for later unmap */
-			area_dst = (char *)(unsigned long)msg.arg.remap.to;
+			gopts->area_remap = gopts->area_dst;  /* save for later unmap */
+			gopts->area_dst = (char *)(unsigned long)msg.arg.remap.to;
 			break;
 		}
 	}
@@ -568,17 +588,18 @@ void *uffd_poll_thread(void *arg)
 	return NULL;
 }
 
-static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
+static void retry_copy_page(uffd_global_test_opts_t *gopts, struct uffdio_copy *uffdio_copy,
 			    unsigned long offset)
 {
-	uffd_test_ops->alias_mapping(&uffdio_copy->dst,
+	uffd_test_ops->alias_mapping(gopts,
+				     &uffdio_copy->dst,
 				     uffdio_copy->len,
 				     offset);
-	if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
+	if (ioctl(gopts->uffd, UFFDIO_COPY, uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
 		if (uffdio_copy->copy != -EEXIST)
 			err("UFFDIO_COPY retry error: %"PRId64,
-			    (int64_t)uffdio_copy->copy);
+			(int64_t)uffdio_copy->copy);
 	} else {
 		err("UFFDIO_COPY retry unexpected: %"PRId64,
 		    (int64_t)uffdio_copy->copy);
@@ -597,60 +618,60 @@ static void wake_range(int ufd, unsigned long addr, unsigned long len)
 			addr), exit(1);
 }
 
-int __copy_page(int ufd, unsigned long offset, bool retry, bool wp)
+int __copy_page(uffd_global_test_opts_t *gopts, unsigned long offset, bool retry, bool wp)
 {
 	struct uffdio_copy uffdio_copy;
 
-	if (offset >= nr_pages * page_size)
+	if (offset >= gopts->nr_pages * gopts->page_size)
 		err("unexpected offset %lu\n", offset);
-	uffdio_copy.dst = (unsigned long) area_dst + offset;
-	uffdio_copy.src = (unsigned long) area_src + offset;
-	uffdio_copy.len = page_size;
+	uffdio_copy.dst = (unsigned long) gopts->area_dst + offset;
+	uffdio_copy.src = (unsigned long) gopts->area_src + offset;
+	uffdio_copy.len = gopts->page_size;
 	if (wp)
 		uffdio_copy.mode = UFFDIO_COPY_MODE_WP;
 	else
 		uffdio_copy.mode = 0;
 	uffdio_copy.copy = 0;
-	if (ioctl(ufd, UFFDIO_COPY, &uffdio_copy)) {
+	if (ioctl(gopts->uffd, UFFDIO_COPY, &uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
 		if (uffdio_copy.copy != -EEXIST)
 			err("UFFDIO_COPY error: %"PRId64,
 			    (int64_t)uffdio_copy.copy);
-		wake_range(ufd, uffdio_copy.dst, page_size);
-	} else if (uffdio_copy.copy != page_size) {
+		wake_range(gopts->uffd, uffdio_copy.dst, gopts->page_size);
+	} else if (uffdio_copy.copy != gopts->page_size) {
 		err("UFFDIO_COPY error: %"PRId64, (int64_t)uffdio_copy.copy);
 	} else {
-		if (test_uffdio_copy_eexist && retry) {
-			test_uffdio_copy_eexist = false;
-			retry_copy_page(ufd, &uffdio_copy, offset);
+		if (gopts->test_uffdio_copy_eexist && retry) {
+			gopts->test_uffdio_copy_eexist = false;
+			retry_copy_page(gopts, &uffdio_copy, offset);
 		}
 		return 1;
 	}
 	return 0;
 }
 
-int copy_page(int ufd, unsigned long offset, bool wp)
+int copy_page(uffd_global_test_opts_t *gopts, unsigned long offset, bool wp)
 {
-	return __copy_page(ufd, offset, false, wp);
+	return __copy_page(gopts, offset, false, wp);
 }
 
-int move_page(int ufd, unsigned long offset, unsigned long len)
+int move_page(uffd_global_test_opts_t *gopts, unsigned long offset, unsigned long len)
 {
 	struct uffdio_move uffdio_move;
 
-	if (offset + len > nr_pages * page_size)
+	if (offset + len > gopts->nr_pages * gopts->page_size)
 		err("unexpected offset %lu and length %lu\n", offset, len);
-	uffdio_move.dst = (unsigned long) area_dst + offset;
-	uffdio_move.src = (unsigned long) area_src + offset;
+	uffdio_move.dst = (unsigned long) gopts->area_dst + offset;
+	uffdio_move.src = (unsigned long) gopts->area_src + offset;
 	uffdio_move.len = len;
 	uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
 	uffdio_move.move = 0;
-	if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
+	if (ioctl(gopts->uffd, UFFDIO_MOVE, &uffdio_move)) {
 		/* real retval in uffdio_move.move */
 		if (uffdio_move.move != -EEXIST)
 			err("UFFDIO_MOVE error: %"PRId64,
 			    (int64_t)uffdio_move.move);
-		wake_range(ufd, uffdio_move.dst, len);
+		wake_range(gopts->uffd, uffdio_move.dst, len);
 	} else if (uffdio_move.move != len) {
 		err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
 	} else
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 7700cbfa3975..37d3ca55905f 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -56,20 +56,17 @@
 
 #define err(fmt, ...) errexit(1, fmt, ##__VA_ARGS__)
 
-/* pthread_mutex_t starts at page offset 0 */
-#define area_mutex(___area, ___nr)					\
-	((pthread_mutex_t *) ((___area) + (___nr)*page_size))
-/*
- * count is placed in the page after pthread_mutex_t naturally aligned
- * to avoid non alignment faults on non-x86 archs.
- */
-#define area_count(___area, ___nr)					\
-	((volatile unsigned long long *) ((unsigned long)		\
-				 ((___area) + (___nr)*page_size +	\
-				  sizeof(pthread_mutex_t) +		\
-				  sizeof(unsigned long long) - 1) &	\
-				 ~(unsigned long)(sizeof(unsigned long long) \
-						  -  1)))
+struct uffd_global_test_opts {
+	unsigned long nr_parallel, nr_pages, nr_pages_per_cpu, page_size;
+	char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
+	int uffd, uffd_flags, finished, *pipefd, test_type;
+	bool map_shared;
+	bool test_uffdio_wp;
+	unsigned long long *count_verify;
+	volatile bool test_uffdio_copy_eexist;
+	atomic_bool ready_for_fork;
+};
+typedef struct uffd_global_test_opts uffd_global_test_opts_t;
 
 /* Userfaultfd test statistics */
 struct uffd_args {
@@ -79,50 +76,55 @@ struct uffd_args {
 	unsigned long missing_faults;
 	unsigned long wp_faults;
 	unsigned long minor_faults;
+	struct uffd_global_test_opts *gopts;
 
 	/* A custom fault handler; defaults to uffd_handle_page_fault. */
-	void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args);
+	void (*handle_fault)(struct uffd_global_test_opts *gopts,
+			     struct uffd_msg *msg,
+			     struct uffd_args *args);
 };
 
 struct uffd_test_ops {
-	int (*allocate_area)(void **alloc_area, bool is_src);
-	void (*release_pages)(char *rel_area);
-	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
-	void (*check_pmd_mapping)(void *p, int expect_nr_hpages);
+	int (*allocate_area)(uffd_global_test_opts_t *gopts, void **alloc_area, bool is_src);
+	void (*release_pages)(uffd_global_test_opts_t *gopts, char *rel_area);
+	void (*alias_mapping)(uffd_global_test_opts_t *gopts,
+			      __u64 *start,
+			      size_t len,
+			      unsigned long offset);
+	void (*check_pmd_mapping)(uffd_global_test_opts_t *gopts, void *p, int expect_nr_hpages);
 };
 typedef struct uffd_test_ops uffd_test_ops_t;
 
 struct uffd_test_case_ops {
-	int (*pre_alloc)(const char **errmsg);
-	int (*post_alloc)(const char **errmsg);
+	int (*pre_alloc)(uffd_global_test_opts_t *gopts, const char **errmsg);
+	int (*post_alloc)(uffd_global_test_opts_t *gopts, const char **errmsg);
 };
 typedef struct uffd_test_case_ops uffd_test_case_ops_t;
 
-extern unsigned long nr_parallel, nr_pages, nr_pages_per_cpu, page_size;
-extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
-extern int uffd, uffd_flags, finished, *pipefd, test_type;
-extern bool map_shared;
-extern bool test_uffdio_wp;
-extern unsigned long long *count_verify;
-extern volatile bool test_uffdio_copy_eexist;
-extern atomic_bool ready_for_fork;
-
+extern uffd_global_test_opts_t *uffd_gtest_opts;
 extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
 extern uffd_test_ops_t hugetlb_uffd_test_ops;
 extern uffd_test_ops_t *uffd_test_ops;
 extern uffd_test_case_ops_t *uffd_test_case_ops;
 
+pthread_mutex_t *area_mutex(char *area, unsigned long nr, uffd_global_test_opts_t *gopts);
+volatile unsigned long long *area_count(char *area,
+					unsigned long nr,
+					uffd_global_test_opts_t *gopts);
+
 void uffd_stats_report(struct uffd_args *args, int n_cpus);
-int uffd_test_ctx_init(uint64_t features, const char **errmsg);
-void uffd_test_ctx_clear(void);
-int userfaultfd_open(uint64_t *features);
-int uffd_read_msg(int ufd, struct uffd_msg *msg);
+int uffd_test_ctx_init(uffd_global_test_opts_t *gopts, uint64_t features, const char **errmsg);
+void uffd_test_ctx_clear(uffd_global_test_opts_t *gopts);
+int userfaultfd_open(uffd_global_test_opts_t *gopts, uint64_t *features);
+int uffd_read_msg(uffd_global_test_opts_t *gopts, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
-void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
-int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
-int copy_page(int ufd, unsigned long offset, bool wp);
-int move_page(int ufd, unsigned long offset, unsigned long len);
+void uffd_handle_page_fault(uffd_global_test_opts_t *gopts,
+			    struct uffd_msg *msg,
+			    struct uffd_args *args);
+int __copy_page(uffd_global_test_opts_t *gopts, unsigned long offset, bool retry, bool wp);
+int copy_page(uffd_global_test_opts_t *gopts, unsigned long offset, bool wp);
+int move_page(uffd_global_test_opts_t *gopts, unsigned long offset, unsigned long len);
 void *uffd_poll_thread(void *arg);
 
 int uffd_open_dev(unsigned int flags);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 991db8f90727..10154800a73f 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -44,6 +44,12 @@ uint64_t features;
 #define BOUNCE_VERIFY		(1<<2)
 #define BOUNCE_POLL		(1<<3)
 static int bounces;
+/* defined globally for this particular test as the sigalrm handler
+ * depends on test_uffdio_*_eexist.
+ * XXX: define gopts in main() when we figure out a way to deal with
+ * test_uffdio_*_eexist.
+ */
+static uffd_global_test_opts_t *gopts;
 
 /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
 #define ALARM_INTERVAL_SECS 10
@@ -76,54 +82,58 @@ static void usage(void)
 	exit(1);
 }
 
-static void uffd_stats_reset(struct uffd_args *args, unsigned long n_cpus)
+static void uffd_stats_reset(uffd_global_test_opts_t *gopts, struct uffd_args *args,
+			     unsigned long n_cpus)
 {
 	int i;
 
 	for (i = 0; i < n_cpus; i++) {
 		args[i].cpu = i;
-		args[i].apply_wp = test_uffdio_wp;
+		args[i].apply_wp = gopts->test_uffdio_wp;
 		args[i].missing_faults = 0;
 		args[i].wp_faults = 0;
 		args[i].minor_faults = 0;
+		args[i].gopts = gopts;
 	}
 }
 
 static void *locking_thread(void *arg)
 {
-	unsigned long cpu = (unsigned long) arg;
+	struct uffd_args *args = (struct uffd_args *) arg;
+	uffd_global_test_opts_t *gopts = args->gopts;
+	unsigned long cpu = (unsigned long) args->cpu;
 	unsigned long page_nr;
 	unsigned long long count;
 
 	if (!(bounces & BOUNCE_RANDOM)) {
 		page_nr = -bounces;
 		if (!(bounces & BOUNCE_RACINGFAULTS))
-			page_nr += cpu * nr_pages_per_cpu;
+			page_nr += cpu * gopts->nr_pages_per_cpu;
 	}
 
-	while (!finished) {
+	while (!gopts->finished) {
 		if (bounces & BOUNCE_RANDOM) {
 			if (getrandom(&page_nr, sizeof(page_nr), 0) != sizeof(page_nr))
 				err("getrandom failed");
 		} else
 			page_nr += 1;
-		page_nr %= nr_pages;
-		pthread_mutex_lock(area_mutex(area_dst, page_nr));
-		count = *area_count(area_dst, page_nr);
-		if (count != count_verify[page_nr])
+		page_nr %= gopts->nr_pages;
+		pthread_mutex_lock(area_mutex(gopts->area_dst, page_nr, gopts));
+		count = *area_count(gopts->area_dst, page_nr, gopts);
+		if (count != gopts->count_verify[page_nr])
 			err("page_nr %lu memory corruption %llu %llu",
-			    page_nr, count, count_verify[page_nr]);
+			    page_nr, count, gopts->count_verify[page_nr]);
 		count++;
-		*area_count(area_dst, page_nr) = count_verify[page_nr] = count;
-		pthread_mutex_unlock(area_mutex(area_dst, page_nr));
+		*area_count(gopts->area_dst, page_nr, gopts) = gopts->count_verify[page_nr] = count;
+		pthread_mutex_unlock(area_mutex(gopts->area_dst, page_nr, gopts));
 	}
 
 	return NULL;
 }
 
-static int copy_page_retry(int ufd, unsigned long offset)
+static int copy_page_retry(uffd_global_test_opts_t *gopts, unsigned long offset)
 {
-	return __copy_page(ufd, offset, true, test_uffdio_wp);
+	return __copy_page(gopts, offset, true, gopts->test_uffdio_wp);
 }
 
 pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
@@ -131,15 +141,16 @@ pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
 static void *uffd_read_thread(void *arg)
 {
 	struct uffd_args *args = (struct uffd_args *)arg;
+	uffd_global_test_opts_t *gopts = args->gopts;
 	struct uffd_msg msg;
 
 	pthread_mutex_unlock(&uffd_read_mutex);
 	/* from here cancellation is ok */
 
 	for (;;) {
-		if (uffd_read_msg(uffd, &msg))
+		if (uffd_read_msg(gopts, &msg))
 			continue;
-		uffd_handle_page_fault(&msg, args);
+		uffd_handle_page_fault(gopts, &msg, args);
 	}
 
 	return NULL;
@@ -147,32 +158,34 @@ static void *uffd_read_thread(void *arg)
 
 static void *background_thread(void *arg)
 {
-	unsigned long cpu = (unsigned long) arg;
+	struct uffd_args *args = (struct uffd_args *) arg;
+	uffd_global_test_opts_t *gopts = args->gopts;
+	unsigned long cpu = (unsigned long) args->cpu;
 	unsigned long page_nr, start_nr, mid_nr, end_nr;
 
-	start_nr = cpu * nr_pages_per_cpu;
-	end_nr = (cpu+1) * nr_pages_per_cpu;
+	start_nr = cpu * gopts->nr_pages_per_cpu;
+	end_nr = (cpu+1) * gopts->nr_pages_per_cpu;
 	mid_nr = (start_nr + end_nr) / 2;
 
 	/* Copy the first half of the pages */
 	for (page_nr = start_nr; page_nr < mid_nr; page_nr++)
-		copy_page_retry(uffd, page_nr * page_size);
+		copy_page_retry(gopts, page_nr * gopts->page_size);
 
 	/*
 	 * If we need to test uffd-wp, set it up now.  Then we'll have
 	 * at least the first half of the pages mapped already which
 	 * can be write-protected for testing
 	 */
-	if (test_uffdio_wp)
-		wp_range(uffd, (unsigned long)area_dst + start_nr * page_size,
-			nr_pages_per_cpu * page_size, true);
+	if (gopts->test_uffdio_wp)
+		wp_range(gopts->uffd, (unsigned long)gopts->area_dst + start_nr * gopts->page_size,
+			gopts->nr_pages_per_cpu * gopts->page_size, true);
 
 	/*
 	 * Continue the 2nd half of the page copying, handling write
 	 * protection faults if any
 	 */
 	for (page_nr = mid_nr; page_nr < end_nr; page_nr++)
-		copy_page_retry(uffd, page_nr * page_size);
+		copy_page_retry(gopts, page_nr * gopts->page_size);
 
 	return NULL;
 }
@@ -180,17 +193,21 @@ static void *background_thread(void *arg)
 static int stress(struct uffd_args *args)
 {
 	unsigned long cpu;
-	pthread_t locking_threads[nr_parallel];
-	pthread_t uffd_threads[nr_parallel];
-	pthread_t background_threads[nr_parallel];
+	uffd_global_test_opts_t *gopts = args->gopts;
+	pthread_t locking_threads[gopts->nr_parallel];
+	pthread_t uffd_threads[gopts->nr_parallel];
+	pthread_t background_threads[gopts->nr_parallel];
 
-	finished = 0;
-	for (cpu = 0; cpu < nr_parallel; cpu++) {
+	gopts->finished = 0;
+	for (cpu = 0; cpu < gopts->nr_parallel; cpu++) {
 		if (pthread_create(&locking_threads[cpu], &attr,
-				   locking_thread, (void *)cpu))
+				   locking_thread, (void *)&args[cpu]))
 			return 1;
 		if (bounces & BOUNCE_POLL) {
-			if (pthread_create(&uffd_threads[cpu], &attr, uffd_poll_thread, &args[cpu]))
+			if (pthread_create(&uffd_threads[cpu],
+					   &attr,
+					   uffd_poll_thread,
+					   (void *) &args[cpu]))
 				err("uffd_poll_thread create");
 		} else {
 			if (pthread_create(&uffd_threads[cpu], &attr,
@@ -200,10 +217,10 @@ static int stress(struct uffd_args *args)
 			pthread_mutex_lock(&uffd_read_mutex);
 		}
 		if (pthread_create(&background_threads[cpu], &attr,
-				   background_thread, (void *)cpu))
+				   background_thread, (void *)&args[cpu]))
 			return 1;
 	}
-	for (cpu = 0; cpu < nr_parallel; cpu++)
+	for (cpu = 0; cpu < gopts->nr_parallel; cpu++)
 		if (pthread_join(background_threads[cpu], NULL))
 			return 1;
 
@@ -216,17 +233,17 @@ static int stress(struct uffd_args *args)
 	 * UFFDIO_COPY without writing zero pages into area_dst
 	 * because the background threads already completed).
 	 */
-	uffd_test_ops->release_pages(area_src);
+	uffd_test_ops->release_pages(gopts, gopts->area_src);
 
-	finished = 1;
-	for (cpu = 0; cpu < nr_parallel; cpu++)
+	gopts->finished = 1;
+	for (cpu = 0; cpu < gopts->nr_parallel; cpu++)
 		if (pthread_join(locking_threads[cpu], NULL))
 			return 1;
 
-	for (cpu = 0; cpu < nr_parallel; cpu++) {
+	for (cpu = 0; cpu < gopts->nr_parallel; cpu++) {
 		char c;
 		if (bounces & BOUNCE_POLL) {
-			if (write(pipefd[cpu*2+1], &c, 1) != 1)
+			if (write(gopts->pipefd[cpu*2+1], &c, 1) != 1)
 				err("pipefd write error");
 			if (pthread_join(uffd_threads[cpu],
 					 (void *)&args[cpu]))
@@ -242,26 +259,26 @@ static int stress(struct uffd_args *args)
 	return 0;
 }
 
-static int userfaultfd_stress(void)
+static int userfaultfd_stress(uffd_global_test_opts_t *gopts)
 {
 	void *area;
 	unsigned long nr;
-	struct uffd_args args[nr_parallel];
-	uint64_t mem_size = nr_pages * page_size;
+	struct uffd_args args[gopts->nr_parallel];
+	uint64_t mem_size = gopts->nr_pages * gopts->page_size;
 	int flags = 0;
 
-	memset(args, 0, sizeof(struct uffd_args) * nr_parallel);
+	memset(args, 0, sizeof(struct uffd_args) * gopts->nr_parallel);
 
-	if (features & UFFD_FEATURE_WP_UNPOPULATED && test_type == TEST_ANON)
+	if (features & UFFD_FEATURE_WP_UNPOPULATED && gopts->test_type == TEST_ANON)
 		flags = UFFD_FEATURE_WP_UNPOPULATED;
 
-	if (uffd_test_ctx_init(flags, NULL))
+	if (uffd_test_ctx_init(gopts, flags, NULL))
 		err("context init failed");
 
-	if (posix_memalign(&area, page_size, page_size))
+	if (posix_memalign(&area, gopts->page_size, gopts->page_size))
 		err("out of memory");
 	zeropage = area;
-	bzero(zeropage, page_size);
+	bzero(zeropage, gopts->page_size);
 
 	pthread_mutex_lock(&uffd_read_mutex);
 
@@ -284,18 +301,18 @@ static int userfaultfd_stress(void)
 		fflush(stdout);
 
 		if (bounces & BOUNCE_POLL)
-			fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+			fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
 		else
-			fcntl(uffd, F_SETFL, uffd_flags & ~O_NONBLOCK);
+			fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags & ~O_NONBLOCK);
 
 		/* register */
-		if (uffd_register(uffd, area_dst, mem_size,
-				  true, test_uffdio_wp, false))
+		if (uffd_register(gopts->uffd, gopts->area_dst, mem_size,
+				  true, gopts->test_uffdio_wp, false))
 			err("register failure");
 
-		if (area_dst_alias) {
-			if (uffd_register(uffd, area_dst_alias, mem_size,
-					  true, test_uffdio_wp, false))
+		if (gopts->area_dst_alias) {
+			if (uffd_register(gopts->uffd, gopts->area_dst_alias, mem_size,
+					  true, gopts->test_uffdio_wp, false))
 				err("register failure alias");
 		}
 
@@ -323,87 +340,88 @@ static int userfaultfd_stress(void)
 		 * MADV_DONTNEED only after the UFFDIO_REGISTER, so it's
 		 * required to MADV_DONTNEED here.
 		 */
-		uffd_test_ops->release_pages(area_dst);
+		uffd_test_ops->release_pages(gopts, gopts->area_dst);
 
-		uffd_stats_reset(args, nr_parallel);
+		uffd_stats_reset(gopts, args, gopts->nr_parallel);
 
 		/* bounce pass */
 		if (stress(args)) {
-			uffd_test_ctx_clear();
+			uffd_test_ctx_clear(gopts);
 			return 1;
 		}
 
 		/* Clear all the write protections if there is any */
-		if (test_uffdio_wp)
-			wp_range(uffd, (unsigned long)area_dst,
-				 nr_pages * page_size, false);
+		if (gopts->test_uffdio_wp)
+			wp_range(gopts->uffd, (unsigned long)gopts->area_dst,
+				 gopts->nr_pages * gopts->page_size, false);
 
 		/* unregister */
-		if (uffd_unregister(uffd, area_dst, mem_size))
+		if (uffd_unregister(gopts->uffd, gopts->area_dst, mem_size))
 			err("unregister failure");
-		if (area_dst_alias) {
-			if (uffd_unregister(uffd, area_dst_alias, mem_size))
+		if (gopts->area_dst_alias) {
+			if (uffd_unregister(gopts->uffd, gopts->area_dst_alias, mem_size))
 				err("unregister failure alias");
 		}
 
 		/* verification */
 		if (bounces & BOUNCE_VERIFY)
-			for (nr = 0; nr < nr_pages; nr++)
-				if (*area_count(area_dst, nr) != count_verify[nr])
+			for (nr = 0; nr < gopts->nr_pages; nr++)
+				if (*area_count(gopts->area_dst, nr, gopts) !=
+						gopts->count_verify[nr])
 					err("error area_count %llu %llu %lu\n",
-					    *area_count(area_src, nr),
-					    count_verify[nr], nr);
+					    *area_count(gopts->area_src, nr, gopts),
+					    gopts->count_verify[nr], nr);
 
 		/* prepare next bounce */
-		swap(area_src, area_dst);
+		swap(gopts->area_src, gopts->area_dst);
 
-		swap(area_src_alias, area_dst_alias);
+		swap(gopts->area_src_alias, gopts->area_dst_alias);
 
-		uffd_stats_report(args, nr_parallel);
+		uffd_stats_report(args, gopts->nr_parallel);
 	}
-	uffd_test_ctx_clear();
+	uffd_test_ctx_clear(gopts);
 
 	return 0;
 }
 
-static void set_test_type(const char *type)
+static void set_test_type(uffd_global_test_opts_t *gopts, const char *type)
 {
 	if (!strcmp(type, "anon")) {
-		test_type = TEST_ANON;
+		gopts->test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
 	} else if (!strcmp(type, "hugetlb")) {
-		test_type = TEST_HUGETLB;
+		gopts->test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-		map_shared = true;
+		gopts->map_shared = true;
 	} else if (!strcmp(type, "hugetlb-private")) {
-		test_type = TEST_HUGETLB;
+		gopts->test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
 	} else if (!strcmp(type, "shmem")) {
-		map_shared = true;
-		test_type = TEST_SHMEM;
+		gopts->map_shared = true;
+		gopts->test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
 	} else if (!strcmp(type, "shmem-private")) {
-		test_type = TEST_SHMEM;
+		gopts->test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
 	}
 }
 
-static void parse_test_type_arg(const char *raw_type)
+static void parse_test_type_arg(uffd_global_test_opts_t *gopts, const char *raw_type)
 {
-	set_test_type(raw_type);
+	set_test_type(gopts, raw_type);
 
-	if (!test_type)
+	if (!gopts->test_type)
 		err("failed to parse test type argument: '%s'", raw_type);
 
-	if (test_type == TEST_HUGETLB)
-		page_size = default_huge_page_size();
+	if (gopts->test_type == TEST_HUGETLB)
+		gopts->page_size = default_huge_page_size();
 	else
-		page_size = sysconf(_SC_PAGE_SIZE);
+		gopts->page_size = sysconf(_SC_PAGE_SIZE);
 
-	if (!page_size)
+	if (!gopts->page_size)
 		err("Unable to determine page size");
-	if ((unsigned long) area_count(NULL, 0) + sizeof(unsigned long long) * 2
-	    > page_size)
+	if ((unsigned long) area_count(NULL, 0, gopts) + sizeof(unsigned long long) * 2
+	    > gopts->page_size)
 		err("Impossible to run this test");
 
 	/*
@@ -415,21 +433,21 @@ static void parse_test_type_arg(const char *raw_type)
 	if (uffd_get_features(&features) && errno == ENOENT)
 		ksft_exit_skip("failed to get available features (%d)\n", errno);
 
-	test_uffdio_wp = test_uffdio_wp &&
+	gopts->test_uffdio_wp = gopts->test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
 
-	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
-		test_uffdio_wp = false;
+	if (gopts->test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
+		gopts->test_uffdio_wp = false;
 
-	close(uffd);
-	uffd = -1;
+	close(gopts->uffd);
+	gopts->uffd = -1;
 }
 
 static void sigalrm(int sig)
 {
 	if (sig != SIGALRM)
 		abort();
-	test_uffdio_copy_eexist = true;
+	gopts->test_uffdio_copy_eexist = true;
 	alarm(ALARM_INTERVAL_SECS);
 }
 
@@ -438,6 +456,8 @@ int main(int argc, char **argv)
 	unsigned long nr_cpus;
 	size_t bytes;
 
+	gopts = (uffd_global_test_opts_t *) malloc(sizeof(uffd_global_test_opts_t));
+
 	if (argc < 4)
 		usage();
 
@@ -445,11 +465,11 @@ int main(int argc, char **argv)
 		err("failed to arm SIGALRM");
 	alarm(ALARM_INTERVAL_SECS);
 
-	parse_test_type_arg(argv[1]);
+	parse_test_type_arg(gopts, argv[1]);
 	bytes = atol(argv[2]) * 1024 * 1024;
 
-	if (test_type == TEST_HUGETLB &&
-	   get_free_hugepages() < 2 * (bytes / page_size) + 10) {
+	if (gopts->test_type == TEST_HUGETLB &&
+	   get_free_hugepages() < 2 * (bytes / gopts->page_size) + 10) {
 		printf("skip: Skipping userfaultfd... not enough hugepages\n");
 		return KSFT_SKIP;
 	}
@@ -459,15 +479,15 @@ int main(int argc, char **argv)
 		/* Don't let calculation below go to zero. */
 		ksft_print_msg("_SC_NPROCESSORS_ONLN (%lu) too large, capping nr_threads to 32\n",
 			       nr_cpus);
-		nr_parallel = 32;
+		gopts->nr_parallel = 32;
 	} else {
-		nr_parallel = nr_cpus;
+		gopts->nr_parallel = nr_cpus;
 	}
 
-	nr_pages_per_cpu = bytes / page_size / nr_parallel;
-	if (!nr_pages_per_cpu) {
+	gopts->nr_pages_per_cpu = bytes / gopts->page_size / gopts->nr_parallel;
+	if (!gopts->nr_pages_per_cpu) {
 		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
-			bytes, page_size, nr_parallel);
+			bytes, gopts->page_size, gopts->nr_parallel);
 		usage();
 	}
 
@@ -476,11 +496,11 @@ int main(int argc, char **argv)
 		_err("invalid bounces");
 		usage();
 	}
-	nr_pages = nr_pages_per_cpu * nr_parallel;
+	gopts->nr_pages = gopts->nr_pages_per_cpu * gopts->nr_parallel;
 
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
-	       nr_pages, nr_pages_per_cpu);
-	return userfaultfd_stress();
+	       gopts->nr_pages, gopts->nr_pages_per_cpu);
+	return userfaultfd_stress(gopts);
 }
 
 #else /* __NR_userfaultfd */
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 50501b38e34e..9e3be2ee7f1b 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -76,7 +76,7 @@ struct uffd_test_args {
 typedef struct uffd_test_args uffd_test_args_t;
 
 /* Returns: UFFD_TEST_* */
-typedef void (*uffd_test_fn)(uffd_test_args_t *);
+typedef void (*uffd_test_fn)(uffd_global_test_opts_t *, uffd_test_args_t *);
 
 typedef struct {
 	const char *name;
@@ -181,33 +181,6 @@ static int test_uffd_api(bool use_dev)
 	return 1;
 }
 
-/*
- * This function initializes the global variables.  TODO: remove global
- * vars and then remove this.
- */
-static int
-uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
-		       mem_type_t *mem_type, const char **errmsg)
-{
-	map_shared = mem_type->shared;
-	uffd_test_ops = mem_type->mem_ops;
-	uffd_test_case_ops = test->test_case_ops;
-
-	if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
-		page_size = default_huge_page_size();
-	else
-		page_size = psize();
-
-	/* Ensure we have at least 2 pages */
-	nr_pages = MAX(UFFD_TEST_MEM_SIZE, page_size * 2) / page_size;
-	/* TODO: remove this global var.. it's so ugly */
-	nr_parallel = 1;
-
-	/* Initialize test arguments */
-	args->mem_type = mem_type;
-
-	return uffd_test_ctx_init(test->uffd_feature_required, errmsg);
-}
 
 static bool uffd_feature_supported(uffd_test_case_t *test)
 {
@@ -237,7 +210,8 @@ static int pagemap_open(void)
 	} while (0)
 
 typedef struct {
-	int parent_uffd, child_uffd;
+	uffd_global_test_opts_t *gopts;
+	int child_uffd;
 } fork_event_args;
 
 static void *fork_event_consumer(void *data)
@@ -245,10 +219,10 @@ static void *fork_event_consumer(void *data)
 	fork_event_args *args = data;
 	struct uffd_msg msg = { 0 };
 
-	ready_for_fork = true;
+	args->gopts->ready_for_fork = true;
 
 	/* Read until a full msg received */
-	while (uffd_read_msg(args->parent_uffd, &msg));
+	while (uffd_read_msg(args->gopts, &msg));
 
 	if (msg.event != UFFD_EVENT_FORK)
 		err("wrong message: %u\n", msg.event);
@@ -304,9 +278,9 @@ static void unpin_pages(pin_args *args)
 	args->pinned = false;
 }
 
-static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
+static int pagemap_test_fork(uffd_global_test_opts_t *gopts, bool with_event, bool test_pin)
 {
-	fork_event_args args = { .parent_uffd = uffd, .child_uffd = -1 };
+	fork_event_args args = { .gopts = gopts, .child_uffd = -1 };
 	pthread_t thread;
 	pid_t child;
 	uint64_t value;
@@ -314,10 +288,10 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 	/* Prepare a thread to resolve EVENT_FORK */
 	if (with_event) {
-		ready_for_fork = false;
+		gopts->ready_for_fork = false;
 		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
 			err("pthread_create()");
-		while (!ready_for_fork)
+		while (!gopts->ready_for_fork)
 			; /* Wait for the poll_thread to start executing before forking */
 	}
 
@@ -328,14 +302,14 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 		fd = pagemap_open();
 
-		if (test_pin && pin_pages(&args, area_dst, page_size))
+		if (test_pin && pin_pages(&args, gopts->area_dst, gopts->page_size))
 			/*
 			 * Normally when reach here we have pinned in
 			 * previous tests, so shouldn't fail anymore
 			 */
 			err("pin page failed in child");
 
-		value = pagemap_get_entry(fd, area_dst);
+		value = pagemap_get_entry(fd, gopts->area_dst);
 		/*
 		 * After fork(), we should handle uffd-wp bit differently:
 		 *
@@ -361,70 +335,70 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 	return result;
 }
 
-static void uffd_wp_unpopulated_test(uffd_test_args_t *args)
+static void uffd_wp_unpopulated_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
 	uint64_t value;
 	int pagemap_fd;
 
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  false, true, false))
 		err("register failed");
 
 	pagemap_fd = pagemap_open();
 
 	/* Test applying pte marker to anon unpopulated */
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, true);
 
 	/* Test unprotect on anon pte marker */
-	wp_range(uffd, (uint64_t)area_dst, page_size, false);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, false);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Test zap on anon marker */
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	if (madvise(area_dst, page_size, MADV_DONTNEED))
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
+	if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
 		err("madvise(MADV_DONTNEED) failed");
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Test fault in after marker removed */
-	*area_dst = 1;
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	*gopts->area_dst = 1;
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, false);
 	/* Drop it to make pte none again */
-	if (madvise(area_dst, page_size, MADV_DONTNEED))
+	if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
 		err("madvise(MADV_DONTNEED) failed");
 
 	/* Test read-zero-page upon pte marker */
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	*(volatile char *)area_dst;
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
+	*(volatile char *)gopts->area_dst;
 	/* Drop it to make pte none again */
-	if (madvise(area_dst, page_size, MADV_DONTNEED))
+	if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
 		err("madvise(MADV_DONTNEED) failed");
 
 	uffd_test_pass();
 }
 
-static void uffd_wp_fork_test_common(uffd_test_args_t *args,
+static void uffd_wp_fork_test_common(uffd_global_test_opts_t *gopts, uffd_test_args_t *args,
 				     bool with_event)
 {
 	int pagemap_fd;
 	uint64_t value;
 
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  false, true, false))
 		err("register failed");
 
 	pagemap_fd = pagemap_open();
 
 	/* Touch the page */
-	*area_dst = 1;
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	*gopts->area_dst = 1;
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, true);
-	if (pagemap_test_fork(uffd, with_event, false)) {
+	if (pagemap_test_fork(gopts, with_event, false)) {
 		uffd_test_fail("Detected %s uffd-wp bit in child in present pte",
 			       with_event ? "missing" : "stall");
 		goto out;
@@ -442,79 +416,80 @@ static void uffd_wp_fork_test_common(uffd_test_args_t *args,
 	 * to expose pte markers.
 	 */
 	if (args->mem_type->shared) {
-		if (madvise(area_dst, page_size, MADV_DONTNEED))
+		if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
 			err("MADV_DONTNEED");
 	} else {
 		/*
 		 * NOTE: ignore retval because private-hugetlb doesn't yet
 		 * support swapping, so it could fail.
 		 */
-		madvise(area_dst, page_size, MADV_PAGEOUT);
+		madvise(gopts->area_dst, gopts->page_size, MADV_PAGEOUT);
 	}
 
 	/* Uffd-wp should persist even swapped out */
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, true);
-	if (pagemap_test_fork(uffd, with_event, false)) {
+	if (pagemap_test_fork(gopts, with_event, false)) {
 		uffd_test_fail("Detected %s uffd-wp bit in child in zapped pte",
 			       with_event ? "missing" : "stall");
 		goto out;
 	}
 
 	/* Unprotect; this tests swap pte modifications */
-	wp_range(uffd, (uint64_t)area_dst, page_size, false);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, false);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Fault in the page from disk */
-	*area_dst = 2;
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	*gopts->area_dst = 2;
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, false);
 	uffd_test_pass();
 out:
-	if (uffd_unregister(uffd, area_dst, nr_pages * page_size))
+	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size))
 		err("unregister failed");
 	close(pagemap_fd);
 }
 
-static void uffd_wp_fork_test(uffd_test_args_t *args)
+static void uffd_wp_fork_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_wp_fork_test_common(args, false);
+	uffd_wp_fork_test_common(gopts, args, false);
 }
 
-static void uffd_wp_fork_with_event_test(uffd_test_args_t *args)
+static void uffd_wp_fork_with_event_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_wp_fork_test_common(args, true);
+	uffd_wp_fork_test_common(gopts, args, true);
 }
 
-static void uffd_wp_fork_pin_test_common(uffd_test_args_t *args,
+static void uffd_wp_fork_pin_test_common(uffd_global_test_opts_t *gopts,
+					 uffd_test_args_t *args,
 					 bool with_event)
 {
 	int pagemap_fd;
 	pin_args pin_args = {};
 
-	if (uffd_register(uffd, area_dst, page_size, false, true, false))
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->page_size, false, true, false))
 		err("register failed");
 
 	pagemap_fd = pagemap_open();
 
 	/* Touch the page */
-	*area_dst = 1;
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
+	*gopts->area_dst = 1;
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
 
 	/*
 	 * 1. First pin, then fork().  This tests fork() special path when
 	 * doing early CoW if the page is private.
 	 */
-	if (pin_pages(&pin_args, area_dst, page_size)) {
+	if (pin_pages(&pin_args, gopts->area_dst, gopts->page_size)) {
 		uffd_test_skip("Possibly CONFIG_GUP_TEST missing "
 			       "or unprivileged");
 		close(pagemap_fd);
-		uffd_unregister(uffd, area_dst, page_size);
+		uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size);
 		return;
 	}
 
-	if (pagemap_test_fork(uffd, with_event, false)) {
+	if (pagemap_test_fork(gopts, with_event, false)) {
 		uffd_test_fail("Detected %s uffd-wp bit in early CoW of fork()",
 			       with_event ? "missing" : "stall");
 		unpin_pages(&pin_args);
@@ -527,49 +502,50 @@ static void uffd_wp_fork_pin_test_common(uffd_test_args_t *args,
 	 * 2. First fork(), then pin (in the child, where test_pin==true).
 	 * This tests COR, aka, page unsharing on private memories.
 	 */
-	if (pagemap_test_fork(uffd, with_event, true)) {
+	if (pagemap_test_fork(gopts, with_event, true)) {
 		uffd_test_fail("Detected %s uffd-wp bit when RO pin",
 			       with_event ? "missing" : "stall");
 		goto out;
 	}
 	uffd_test_pass();
 out:
-	if (uffd_unregister(uffd, area_dst, page_size))
+	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size))
 		err("register failed");
 	close(pagemap_fd);
 }
 
-static void uffd_wp_fork_pin_test(uffd_test_args_t *args)
+static void uffd_wp_fork_pin_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_wp_fork_pin_test_common(args, false);
+	uffd_wp_fork_pin_test_common(gopts, args, false);
 }
 
-static void uffd_wp_fork_pin_with_event_test(uffd_test_args_t *args)
+static void uffd_wp_fork_pin_with_event_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_wp_fork_pin_test_common(args, true);
+	uffd_wp_fork_pin_test_common(gopts, args, true);
 }
 
-static void check_memory_contents(char *p)
+static void check_memory_contents(uffd_global_test_opts_t *gopts, char *p)
 {
 	unsigned long i, j;
 	uint8_t expected_byte;
 
-	for (i = 0; i < nr_pages; ++i) {
+	for (i = 0; i < gopts->nr_pages; ++i) {
 		expected_byte = ~((uint8_t)(i % ((uint8_t)-1)));
-		for (j = 0; j < page_size; j++) {
-			uint8_t v = *(uint8_t *)(p + (i * page_size) + j);
+		for (j = 0; j < gopts->page_size; j++) {
+			uint8_t v = *(uint8_t *)(p + (i * gopts->page_size) + j);
 			if (v != expected_byte)
 				err("unexpected page contents");
 		}
 	}
 }
 
-static void uffd_minor_test_common(bool test_collapse, bool test_wp)
+static void uffd_minor_test_common(uffd_global_test_opts_t *gopts, bool test_collapse, bool test_wp)
 {
 	unsigned long p;
 	pthread_t uffd_mon;
 	char c;
 	struct uffd_args args = { 0 };
+	args.gopts = gopts;
 
 	/*
 	 * NOTE: MADV_COLLAPSE is not yet compatible with WP, so testing
@@ -577,7 +553,7 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
 	 */
 	assert(!(test_collapse && test_wp));
 
-	if (uffd_register(uffd, area_dst_alias, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst_alias, gopts->nr_pages * gopts->page_size,
 			  /* NOTE! MADV_COLLAPSE may not work with uffd-wp */
 			  false, test_wp, true))
 		err("register failure");
@@ -586,9 +562,9 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
 	 * After registering with UFFD, populate the non-UFFD-registered side of
 	 * the shared mapping. This should *not* trigger any UFFD minor faults.
 	 */
-	for (p = 0; p < nr_pages; ++p)
-		memset(area_dst + (p * page_size), p % ((uint8_t)-1),
-		       page_size);
+	for (p = 0; p < gopts->nr_pages; ++p)
+		memset(gopts->area_dst + (p * gopts->page_size), p % ((uint8_t)-1),
+		       gopts->page_size);
 
 	args.apply_wp = test_wp;
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
@@ -600,50 +576,51 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
 	 * fault. uffd_poll_thread will resolve the fault by bit-flipping the
 	 * page's contents, and then issuing a CONTINUE ioctl.
 	 */
-	check_memory_contents(area_dst_alias);
+	check_memory_contents(gopts, gopts->area_dst_alias);
 
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		err("join() failed");
 
 	if (test_collapse) {
-		if (madvise(area_dst_alias, nr_pages * page_size,
+		if (madvise(gopts->area_dst_alias, gopts->nr_pages * gopts->page_size,
 			    MADV_COLLAPSE)) {
 			/* It's fine to fail for this one... */
 			uffd_test_skip("MADV_COLLAPSE failed");
 			return;
 		}
 
-		uffd_test_ops->check_pmd_mapping(area_dst,
-						 nr_pages * page_size /
+		uffd_test_ops->check_pmd_mapping(gopts,
+						 gopts->area_dst,
+						 gopts->nr_pages * gopts->page_size /
 						 read_pmd_pagesize());
 		/*
 		 * This won't cause uffd-fault - it purely just makes sure there
 		 * was no corruption.
 		 */
-		check_memory_contents(area_dst_alias);
+		check_memory_contents(gopts, gopts->area_dst_alias);
 	}
 
-	if (args.missing_faults != 0 || args.minor_faults != nr_pages)
+	if (args.missing_faults != 0 || args.minor_faults != gopts->nr_pages)
 		uffd_test_fail("stats check error");
 	else
 		uffd_test_pass();
 }
 
-void uffd_minor_test(uffd_test_args_t *args)
+void uffd_minor_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_minor_test_common(false, false);
+	uffd_minor_test_common(gopts, false, false);
 }
 
-void uffd_minor_wp_test(uffd_test_args_t *args)
+void uffd_minor_wp_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_minor_test_common(false, true);
+	uffd_minor_test_common(gopts, false, true);
 }
 
-void uffd_minor_collapse_test(uffd_test_args_t *args)
+void uffd_minor_collapse_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_minor_test_common(true, false);
+	uffd_minor_test_common(gopts, true, false);
 }
 
 static sigjmp_buf jbuf, *sigbuf;
@@ -678,7 +655,7 @@ static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
  * This also tests UFFD_FEATURE_EVENT_FORK event along with the signal
  * feature. Using monitor thread, verify no userfault events are generated.
  */
-static int faulting_process(int signal_test, bool wp)
+static int faulting_process(uffd_global_test_opts_t *gopts, int signal_test, bool wp)
 {
 	unsigned long nr, i;
 	unsigned long long count;
@@ -687,7 +664,7 @@ static int faulting_process(int signal_test, bool wp)
 	struct sigaction act;
 	volatile unsigned long signalled = 0;
 
-	split_nr_pages = (nr_pages + 1) / 2;
+	split_nr_pages = (gopts->nr_pages + 1) / 2;
 
 	if (signal_test) {
 		sigbuf = &jbuf;
@@ -701,7 +678,7 @@ static int faulting_process(int signal_test, bool wp)
 
 	for (nr = 0; nr < split_nr_pages; nr++) {
 		volatile int steps = 1;
-		unsigned long offset = nr * page_size;
+		unsigned long offset = nr * gopts->page_size;
 
 		if (signal_test) {
 			if (sigsetjmp(*sigbuf, 1) != 0) {
@@ -713,15 +690,15 @@ static int faulting_process(int signal_test, bool wp)
 					if (steps == 1) {
 						/* This is a MISSING request */
 						steps++;
-						if (copy_page(uffd, offset, wp))
+						if (copy_page(gopts, offset, wp))
 							signalled++;
 					} else {
 						/* This is a WP request */
 						assert(steps == 2);
-						wp_range(uffd,
-							 (__u64)area_dst +
+						wp_range(gopts->uffd,
+							 (__u64)gopts->area_dst +
 							 offset,
-							 page_size, false);
+							 gopts->page_size, false);
 					}
 				} else {
 					signalled++;
@@ -730,51 +707,53 @@ static int faulting_process(int signal_test, bool wp)
 			}
 		}
 
-		count = *area_count(area_dst, nr);
-		if (count != count_verify[nr])
+		count = *area_count(gopts->area_dst, nr, gopts);
+		if (count != gopts->count_verify[nr])
 			err("nr %lu memory corruption %llu %llu\n",
-			    nr, count, count_verify[nr]);
+			    nr, count, gopts->count_verify[nr]);
 		/*
 		 * Trigger write protection if there is by writing
 		 * the same value back.
 		 */
-		*area_count(area_dst, nr) = count;
+		*area_count(gopts->area_dst, nr, gopts) = count;
 	}
 
 	if (signal_test)
 		return signalled != split_nr_pages;
 
-	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
-			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
-	if (area_dst == MAP_FAILED)
+	gopts->area_dst = mremap(gopts->area_dst, gopts->nr_pages * gopts->page_size,
+				 gopts->nr_pages * gopts->page_size,
+				 MREMAP_MAYMOVE | MREMAP_FIXED,
+				 gopts->area_src);
+	if (gopts->area_dst == MAP_FAILED)
 		err("mremap");
 	/* Reset area_src since we just clobbered it */
-	area_src = NULL;
+	gopts->area_src = NULL;
 
-	for (; nr < nr_pages; nr++) {
-		count = *area_count(area_dst, nr);
-		if (count != count_verify[nr]) {
+	for (; nr < gopts->nr_pages; nr++) {
+		count = *area_count(gopts->area_dst, nr, gopts);
+		if (count != gopts->count_verify[nr]) {
 			err("nr %lu memory corruption %llu %llu\n",
-			    nr, count, count_verify[nr]);
+			    nr, count, gopts->count_verify[nr]);
 		}
 		/*
 		 * Trigger write protection if there is by writing
 		 * the same value back.
 		 */
-		*area_count(area_dst, nr) = count;
+		*area_count(gopts->area_dst, nr, gopts) = count;
 	}
 
-	uffd_test_ops->release_pages(area_dst);
+	uffd_test_ops->release_pages(gopts, gopts->area_dst);
 
-	for (nr = 0; nr < nr_pages; nr++)
-		for (i = 0; i < page_size; i++)
-			if (*(area_dst + nr * page_size + i) != 0)
+	for (nr = 0; nr < gopts->nr_pages; nr++)
+		for (i = 0; i < gopts->page_size; i++)
+			if (*(gopts->area_dst + nr * gopts->page_size + i) != 0)
 				err("page %lu offset %lu is not zero", nr, i);
 
 	return 0;
 }
 
-static void uffd_sigbus_test_common(bool wp)
+static void uffd_sigbus_test_common(uffd_global_test_opts_t *gopts, bool wp)
 {
 	unsigned long userfaults;
 	pthread_t uffd_mon;
@@ -782,25 +761,26 @@ static void uffd_sigbus_test_common(bool wp)
 	int err;
 	char c;
 	struct uffd_args args = { 0 };
+	args.gopts = gopts;
 
-	ready_for_fork = false;
+	gopts->ready_for_fork = false;
 
-	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+	fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
 
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  true, wp, false))
 		err("register failure");
 
-	if (faulting_process(1, wp))
+	if (faulting_process(gopts, 1, wp))
 		err("faulting process failed");
 
-	uffd_test_ops->release_pages(area_dst);
+	uffd_test_ops->release_pages(gopts, gopts->area_dst);
 
 	args.apply_wp = wp;
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	while (!ready_for_fork)
+	while (!gopts->ready_for_fork)
 		; /* Wait for the poll_thread to start executing before forking */
 
 	pid = fork();
@@ -808,12 +788,12 @@ static void uffd_sigbus_test_common(bool wp)
 		err("fork");
 
 	if (!pid)
-		exit(faulting_process(2, wp));
+		exit(faulting_process(gopts, 2, wp));
 
 	waitpid(pid, &err, 0);
 	if (err)
 		err("faulting process failed");
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, (void **)&userfaults))
 		err("pthread_join()");
@@ -824,28 +804,29 @@ static void uffd_sigbus_test_common(bool wp)
 		uffd_test_pass();
 }
 
-static void uffd_sigbus_test(uffd_test_args_t *args)
+static void uffd_sigbus_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_sigbus_test_common(false);
+	uffd_sigbus_test_common(gopts, false);
 }
 
-static void uffd_sigbus_wp_test(uffd_test_args_t *args)
+static void uffd_sigbus_wp_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_sigbus_test_common(true);
+	uffd_sigbus_test_common(gopts, true);
 }
 
-static void uffd_events_test_common(bool wp)
+static void uffd_events_test_common(uffd_global_test_opts_t *gopts, bool wp)
 {
 	pthread_t uffd_mon;
 	pid_t pid;
 	int err;
 	char c;
 	struct uffd_args args = { 0 };
+	args.gopts = gopts;
 
-	ready_for_fork = false;
+	gopts->ready_for_fork = false;
 
-	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  true, wp, false))
 		err("register failure");
 
@@ -853,7 +834,7 @@ static void uffd_events_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	while (!ready_for_fork)
+	while (!gopts->ready_for_fork)
 		; /* Wait for the poll_thread to start executing before forking */
 
 	pid = fork();
@@ -861,39 +842,39 @@ static void uffd_events_test_common(bool wp)
 		err("fork");
 
 	if (!pid)
-		exit(faulting_process(0, wp));
+		exit(faulting_process(gopts, 0, wp));
 
 	waitpid(pid, &err, 0);
 	if (err)
 		err("faulting process failed");
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		err("pthread_join()");
 
-	if (args.missing_faults != nr_pages)
+	if (args.missing_faults != gopts->nr_pages)
 		uffd_test_fail("Fault counts wrong");
 	else
 		uffd_test_pass();
 }
 
-static void uffd_events_test(uffd_test_args_t *args)
+static void uffd_events_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_events_test_common(false);
+	uffd_events_test_common(gopts, false);
 }
 
-static void uffd_events_wp_test(uffd_test_args_t *args)
+static void uffd_events_wp_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_events_test_common(true);
+	uffd_events_test_common(gopts, true);
 }
 
-static void retry_uffdio_zeropage(int ufd,
+static void retry_uffdio_zeropage(uffd_global_test_opts_t *gopts,
 				  struct uffdio_zeropage *uffdio_zeropage)
 {
-	uffd_test_ops->alias_mapping(&uffdio_zeropage->range.start,
+	uffd_test_ops->alias_mapping(gopts, &uffdio_zeropage->range.start,
 				     uffdio_zeropage->range.len,
 				     0);
-	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
+	if (ioctl(gopts->uffd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
 		if (uffdio_zeropage->zeropage != -EEXIST)
 			err("UFFDIO_ZEROPAGE error: %"PRId64,
 			    (int64_t)uffdio_zeropage->zeropage);
@@ -903,16 +884,16 @@ static void retry_uffdio_zeropage(int ufd,
 	}
 }
 
-static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
+static bool do_uffdio_zeropage(uffd_global_test_opts_t *gopts, bool has_zeropage)
 {
 	struct uffdio_zeropage uffdio_zeropage = { 0 };
 	int ret;
 	__s64 res;
 
-	uffdio_zeropage.range.start = (unsigned long) area_dst;
-	uffdio_zeropage.range.len = page_size;
+	uffdio_zeropage.range.start = (unsigned long) gopts->area_dst;
+	uffdio_zeropage.range.len = gopts->page_size;
 	uffdio_zeropage.mode = 0;
-	ret = ioctl(ufd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
+	ret = ioctl(gopts->uffd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
 	res = uffdio_zeropage.zeropage;
 	if (ret) {
 		/* real retval in ufdio_zeropage.zeropage */
@@ -921,10 +902,10 @@ static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
 		else if (res != -EINVAL)
 			err("UFFDIO_ZEROPAGE not -EINVAL");
 	} else if (has_zeropage) {
-		if (res != page_size)
+		if (res != gopts->page_size)
 			err("UFFDIO_ZEROPAGE unexpected size");
 		else
-			retry_uffdio_zeropage(ufd, &uffdio_zeropage);
+			retry_uffdio_zeropage(gopts, &uffdio_zeropage);
 		return true;
 	} else
 		err("UFFDIO_ZEROPAGE succeeded");
@@ -950,25 +931,29 @@ uffd_register_detect_zeropage(int uffd, void *addr, uint64_t len)
 }
 
 /* exercise UFFDIO_ZEROPAGE */
-static void uffd_zeropage_test(uffd_test_args_t *args)
+static void uffd_zeropage_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
 	bool has_zeropage;
 	int i;
 
-	has_zeropage = uffd_register_detect_zeropage(uffd, area_dst, page_size);
-	if (area_dst_alias)
+	has_zeropage = uffd_register_detect_zeropage(gopts->uffd,
+						     gopts->area_dst,
+						     gopts->page_size);
+	if (gopts->area_dst_alias)
 		/* Ignore the retval; we already have it */
-		uffd_register_detect_zeropage(uffd, area_dst_alias, page_size);
+		uffd_register_detect_zeropage(gopts->uffd, gopts->area_dst_alias, gopts->page_size);
 
-	if (do_uffdio_zeropage(uffd, has_zeropage))
-		for (i = 0; i < page_size; i++)
-			if (area_dst[i] != 0)
+	if (do_uffdio_zeropage(gopts, has_zeropage))
+		for (i = 0; i < gopts->page_size; i++)
+			if (gopts->area_dst[i] != 0)
 				err("data non-zero at offset %d\n", i);
 
-	if (uffd_unregister(uffd, area_dst, page_size))
+	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size))
 		err("unregister");
 
-	if (area_dst_alias && uffd_unregister(uffd, area_dst_alias, page_size))
+	if (gopts->area_dst_alias && uffd_unregister(gopts->uffd,
+						     gopts->area_dst_alias,
+						     gopts->page_size))
 		err("unregister");
 
 	uffd_test_pass();
@@ -987,26 +972,27 @@ static void uffd_register_poison(int uffd, void *addr, uint64_t len)
 		err("registered area doesn't support COPY and POISON ioctls");
 }
 
-static void do_uffdio_poison(int uffd, unsigned long offset)
+static void do_uffdio_poison(uffd_global_test_opts_t *gopts, unsigned long offset)
 {
 	struct uffdio_poison uffdio_poison = { 0 };
 	int ret;
 	__s64 res;
 
-	uffdio_poison.range.start = (unsigned long) area_dst + offset;
-	uffdio_poison.range.len = page_size;
+	uffdio_poison.range.start = (unsigned long) gopts->area_dst + offset;
+	uffdio_poison.range.len = gopts->page_size;
 	uffdio_poison.mode = 0;
-	ret = ioctl(uffd, UFFDIO_POISON, &uffdio_poison);
+	ret = ioctl(gopts->uffd, UFFDIO_POISON, &uffdio_poison);
 	res = uffdio_poison.updated;
 
 	if (ret)
 		err("UFFDIO_POISON error: %"PRId64, (int64_t)res);
-	else if (res != page_size)
+	else if (res != gopts->page_size)
 		err("UFFDIO_POISON unexpected size: %"PRId64, (int64_t)res);
 }
 
-static void uffd_poison_handle_fault(
-	struct uffd_msg *msg, struct uffd_args *args)
+static void uffd_poison_handle_fault(uffd_global_test_opts_t *gopts,
+				     struct uffd_msg *msg,
+				     struct uffd_args *args)
 {
 	unsigned long offset;
 
@@ -1017,20 +1003,20 @@ static void uffd_poison_handle_fault(
 	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR))
 		err("unexpected fault type %llu", msg->arg.pagefault.flags);
 
-	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
-	offset &= ~(page_size-1);
+	offset = (char *)(unsigned long)msg->arg.pagefault.address - gopts->area_dst;
+	offset &= ~(gopts->page_size-1);
 
 	/* Odd pages -> copy zeroed page; even pages -> poison. */
-	if (offset & page_size)
-		copy_page(uffd, offset, false);
+	if (offset & gopts->page_size)
+		copy_page(gopts, offset, false);
 	else
-		do_uffdio_poison(uffd, offset);
+		do_uffdio_poison(gopts, offset);
 }
 
 /* Make sure to cover odd/even, and minimum duplications */
 #define  UFFD_POISON_TEST_NPAGES  4
 
-static void uffd_poison_test(uffd_test_args_t *targs)
+static void uffd_poison_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
 {
 	pthread_t uffd_mon;
 	char c;
@@ -1039,15 +1025,17 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 	unsigned long nr_sigbus = 0;
 	unsigned long nr, poison_pages = UFFD_POISON_TEST_NPAGES;
 
-	if (nr_pages < poison_pages) {
-		uffd_test_skip("Too few pages for POISON test");
+	if (gopts->nr_pages < poison_pages) {
+		uffd_test_skip("Too less pages for POISON test");
 		return;
 	}
 
-	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+	args.gopts = gopts;
+
+	fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
 
-	uffd_register_poison(uffd, area_dst, poison_pages * page_size);
-	memset(area_src, 0, poison_pages * page_size);
+	uffd_register_poison(gopts->uffd, gopts->area_dst, poison_pages * gopts->page_size);
+	memset(gopts->area_src, 0, poison_pages * gopts->page_size);
 
 	args.handle_fault = uffd_poison_handle_fault;
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
@@ -1060,8 +1048,8 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 		err("sigaction");
 
 	for (nr = 0; nr < poison_pages; ++nr) {
-		unsigned long offset = nr * page_size;
-		const char *bytes = (const char *) area_dst + offset;
+		unsigned long offset = nr * gopts->page_size;
+		const char *bytes = (const char *) gopts->area_dst + offset;
 		const char *i;
 
 		if (sigsetjmp(*sigbuf, 1)) {
@@ -1074,14 +1062,14 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 			continue;
 		}
 
-		for (i = bytes; i < bytes + page_size; ++i) {
+		for (i = bytes; i < bytes + gopts->page_size; ++i) {
 			if (*i)
 				err("nonzero byte in area_dst (%p) at %p: %u",
-				    area_dst, i, *i);
+				    gopts->area_dst, i, *i);
 		}
 	}
 
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		err("pthread_join()");
@@ -1094,7 +1082,9 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 }
 
 static void
-uffd_move_handle_fault_common(struct uffd_msg *msg, struct uffd_args *args,
+uffd_move_handle_fault_common(uffd_global_test_opts_t *gopts,
+			      struct uffd_msg *msg,
+			      struct uffd_args *args,
 			      unsigned long len)
 {
 	unsigned long offset;
@@ -1106,28 +1096,32 @@ uffd_move_handle_fault_common(struct uffd_msg *msg, struct uffd_args *args,
 	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR | UFFD_PAGEFAULT_FLAG_WRITE))
 		err("unexpected fault type %llu", msg->arg.pagefault.flags);
 
-	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+	offset = (char *)(unsigned long)msg->arg.pagefault.address - gopts->area_dst;
 	offset &= ~(len-1);
 
-	if (move_page(uffd, offset, len))
+	if (move_page(gopts, offset, len))
 		args->missing_faults++;
 }
 
-static void uffd_move_handle_fault(struct uffd_msg *msg,
+static void uffd_move_handle_fault(uffd_global_test_opts_t *gopts, struct uffd_msg *msg,
 				   struct uffd_args *args)
 {
-	uffd_move_handle_fault_common(msg, args, page_size);
+	uffd_move_handle_fault_common(gopts, msg, args, gopts->page_size);
 }
 
-static void uffd_move_pmd_handle_fault(struct uffd_msg *msg,
+static void uffd_move_pmd_handle_fault(uffd_global_test_opts_t *gopts, struct uffd_msg *msg,
 				       struct uffd_args *args)
 {
-	uffd_move_handle_fault_common(msg, args, read_pmd_pagesize());
+	uffd_move_handle_fault_common(gopts, msg, args, read_pmd_pagesize());
 }
 
 static void
-uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
-		      void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args))
+uffd_move_test_common(uffd_global_test_opts_t *gopts,
+		      uffd_test_args_t *targs,
+		      unsigned long chunk_size,
+		      void (*handle_fault)(struct uffd_global_test_opts *gopts,
+		      struct uffd_msg *msg, struct uffd_args *args)
+)
 {
 	unsigned long nr;
 	pthread_t uffd_mon;
@@ -1139,11 +1133,13 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 	unsigned long src_offs = 0;
 	unsigned long dst_offs = 0;
 
+	args.gopts = gopts;
+
 	/* Prevent source pages from being mapped more than once */
-	if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
+	if (madvise(gopts->area_src, gopts->nr_pages * gopts->page_size, MADV_DONTFORK))
 		err("madvise(MADV_DONTFORK) failure");
 
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  true, false, false))
 		err("register failure");
 
@@ -1151,22 +1147,22 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	step_size = chunk_size / page_size;
-	step_count = nr_pages / step_size;
+	step_size = chunk_size / gopts->page_size;
+	step_count = gopts->nr_pages / step_size;
 
-	if (chunk_size > page_size) {
-		char *aligned_src = ALIGN_UP(area_src, chunk_size);
-		char *aligned_dst = ALIGN_UP(area_dst, chunk_size);
+	if (chunk_size > gopts->page_size) {
+		char *aligned_src = ALIGN_UP(gopts->area_src, chunk_size);
+		char *aligned_dst = ALIGN_UP(gopts->area_dst, chunk_size);
 
-		if (aligned_src != area_src || aligned_dst != area_dst) {
-			src_offs = (aligned_src - area_src) / page_size;
-			dst_offs = (aligned_dst - area_dst) / page_size;
+		if (aligned_src != gopts->area_src || aligned_dst != gopts->area_dst) {
+			src_offs = (aligned_src - gopts->area_src) / gopts->page_size;
+			dst_offs = (aligned_dst - gopts->area_dst) / gopts->page_size;
 			step_count--;
 		}
-		orig_area_src = area_src;
-		orig_area_dst = area_dst;
-		area_src = aligned_src;
-		area_dst = aligned_dst;
+		orig_area_src = gopts->area_src;
+		orig_area_dst = gopts->area_dst;
+		gopts->area_src = aligned_src;
+		gopts->area_dst = aligned_dst;
 	}
 
 	/*
@@ -1180,34 +1176,34 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 
 		/* Check area_src content */
 		for (i = 0; i < step_size; i++) {
-			count = *area_count(area_src, nr + i);
-			if (count != count_verify[src_offs + nr + i])
+			count = *area_count(gopts->area_src, nr + i, gopts);
+			if (count != gopts->count_verify[src_offs + nr + i])
 				err("nr %lu source memory invalid %llu %llu\n",
-				    nr + i, count, count_verify[src_offs + nr + i]);
+				    nr + i, count, gopts->count_verify[src_offs + nr + i]);
 		}
 
 		/* Faulting into area_dst should move the page or the huge page */
 		for (i = 0; i < step_size; i++) {
-			count = *area_count(area_dst, nr + i);
-			if (count != count_verify[dst_offs + nr + i])
+			count = *area_count(gopts->area_dst, nr + i, gopts);
+			if (count != gopts->count_verify[dst_offs + nr + i])
 				err("nr %lu memory corruption %llu %llu\n",
-				    nr, count, count_verify[dst_offs + nr + i]);
+				    nr, count, gopts->count_verify[dst_offs + nr + i]);
 		}
 
 		/* Re-check area_src content which should be empty */
 		for (i = 0; i < step_size; i++) {
-			count = *area_count(area_src, nr + i);
+			count = *area_count(gopts->area_src, nr + i, gopts);
 			if (count != 0)
 				err("nr %lu move failed %llu %llu\n",
-				    nr, count, count_verify[src_offs + nr + i]);
+				    nr, count, gopts->count_verify[src_offs + nr + i]);
 		}
 	}
-	if (chunk_size > page_size) {
-		area_src = orig_area_src;
-		area_dst = orig_area_dst;
+	if (chunk_size > gopts->page_size) {
+		gopts->area_src = orig_area_src;
+		gopts->area_dst = orig_area_dst;
 	}
 
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		err("join() failed");
@@ -1218,24 +1214,24 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 		uffd_test_pass();
 }
 
-static void uffd_move_test(uffd_test_args_t *targs)
+static void uffd_move_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
 {
-	uffd_move_test_common(targs, page_size, uffd_move_handle_fault);
+	uffd_move_test_common(gopts, targs, gopts->page_size, uffd_move_handle_fault);
 }
 
-static void uffd_move_pmd_test(uffd_test_args_t *targs)
+static void uffd_move_pmd_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
 {
-	if (madvise(area_dst, nr_pages * page_size, MADV_HUGEPAGE))
+	if (madvise(gopts->area_dst, gopts->nr_pages * gopts->page_size, MADV_HUGEPAGE))
 		err("madvise(MADV_HUGEPAGE) failure");
-	uffd_move_test_common(targs, read_pmd_pagesize(),
+	uffd_move_test_common(gopts, targs, read_pmd_pagesize(),
 			      uffd_move_pmd_handle_fault);
 }
 
-static void uffd_move_pmd_split_test(uffd_test_args_t *targs)
+static void uffd_move_pmd_split_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
 {
-	if (madvise(area_dst, nr_pages * page_size, MADV_NOHUGEPAGE))
+	if (madvise(gopts->area_dst, gopts->nr_pages * gopts->page_size, MADV_NOHUGEPAGE))
 		err("madvise(MADV_NOHUGEPAGE) failure");
-	uffd_move_test_common(targs, read_pmd_pagesize(),
+	uffd_move_test_common(gopts, targs, read_pmd_pagesize(),
 			      uffd_move_pmd_handle_fault);
 }
 
@@ -1295,6 +1291,11 @@ typedef enum {
 	THR_STATE_UNINTERRUPTIBLE,
 } thread_state;
 
+typedef struct {
+	uffd_global_test_opts_t *gopts;
+	volatile pid_t *pid;
+} mmap_changing_thread_args;
+
 static void sleep_short(void)
 {
 	usleep(1000);
@@ -1337,7 +1338,9 @@ static void thread_state_until(pid_t tid, thread_state state)
 
 static void *uffd_mmap_changing_thread(void *opaque)
 {
-	volatile pid_t *pid = opaque;
+	mmap_changing_thread_args *args = opaque;
+	uffd_global_test_opts_t *gopts = args->gopts;
+	volatile pid_t *pid = args->pid;
 	int ret;
 
 	/* Unfortunately, it's only fetch-able from the thread itself.. */
@@ -1345,21 +1348,21 @@ static void *uffd_mmap_changing_thread(void *opaque)
 	*pid = syscall(SYS_gettid);
 
 	/* Inject an event, this will hang solid until the event read */
-	ret = madvise(area_dst, page_size, MADV_REMOVE);
+	ret = madvise(gopts->area_dst, gopts->page_size, MADV_REMOVE);
 	if (ret)
 		err("madvise(MADV_REMOVE) failed");
 
 	return NULL;
 }
 
-static void uffd_consume_message(int fd)
+static void uffd_consume_message(uffd_global_test_opts_t *gopts)
 {
 	struct uffd_msg msg = { 0 };
 
-	while (uffd_read_msg(fd, &msg));
+	while (uffd_read_msg(gopts, &msg));
 }
 
-static void uffd_mmap_changing_test(uffd_test_args_t *targs)
+static void uffd_mmap_changing_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
 {
 	/*
 	 * This stores the real PID (which can be different from how tid is
@@ -1368,13 +1371,14 @@ static void uffd_mmap_changing_test(uffd_test_args_t *targs)
 	pid_t pid = 0;
 	pthread_t tid;
 	int ret;
+	mmap_changing_thread_args args = { gopts, &pid };
 
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  true, false, false))
 		err("uffd_register() failed");
 
 	/* Create a thread to generate the racy event */
-	ret = pthread_create(&tid, NULL, uffd_mmap_changing_thread, &pid);
+	ret = pthread_create(&tid, NULL, uffd_mmap_changing_thread, &args);
 	if (ret)
 		err("pthread_create() failed");
 
@@ -1388,26 +1392,26 @@ static void uffd_mmap_changing_test(uffd_test_args_t *targs)
 	/* Wait until the thread hangs at REMOVE event */
 	thread_state_until(pid, THR_STATE_UNINTERRUPTIBLE);
 
-	if (!uffdio_mmap_changing_test_copy(uffd))
+	if (!uffdio_mmap_changing_test_copy(gopts->uffd))
 		return;
 
-	if (!uffdio_mmap_changing_test_zeropage(uffd))
+	if (!uffdio_mmap_changing_test_zeropage(gopts->uffd))
 		return;
 
-	if (!uffdio_mmap_changing_test_move(uffd))
+	if (!uffdio_mmap_changing_test_move(gopts->uffd))
 		return;
 
-	if (!uffdio_mmap_changing_test_poison(uffd))
+	if (!uffdio_mmap_changing_test_poison(gopts->uffd))
 		return;
 
-	if (!uffdio_mmap_changing_test_continue(uffd))
+	if (!uffdio_mmap_changing_test_continue(gopts->uffd))
 		return;
 
 	/*
 	 * All succeeded above!  Recycle everything.  Start by reading the
 	 * event so as to kick the thread roll again..
 	 */
-	uffd_consume_message(uffd);
+	uffd_consume_message(gopts);
 
 	ret = pthread_join(tid, NULL);
 	assert(ret == 0);
@@ -1415,10 +1419,10 @@ static void uffd_mmap_changing_test(uffd_test_args_t *targs)
 	uffd_test_pass();
 }
 
-static int prevent_hugepages(const char **errmsg)
+static int prevent_hugepages(uffd_global_test_opts_t *gopts, const char **errmsg)
 {
 	/* This should be done before source area is populated */
-	if (madvise(area_src, nr_pages * page_size, MADV_NOHUGEPAGE)) {
+	if (madvise(gopts->area_src, gopts->nr_pages * gopts->page_size, MADV_NOHUGEPAGE)) {
 		/* Ignore only if CONFIG_TRANSPARENT_HUGEPAGE=n */
 		if (errno != EINVAL) {
 			if (errmsg)
@@ -1429,10 +1433,10 @@ static int prevent_hugepages(const char **errmsg)
 	return 0;
 }
 
-static int request_hugepages(const char **errmsg)
+static int request_hugepages(uffd_global_test_opts_t *gopts, const char **errmsg)
 {
 	/* This should be done before source area is populated */
-	if (madvise(area_src, nr_pages * page_size, MADV_HUGEPAGE)) {
+	if (madvise(gopts->area_src, gopts->nr_pages * gopts->page_size, MADV_HUGEPAGE)) {
 		if (errmsg) {
 			*errmsg = (errno == EINVAL) ?
 				"CONFIG_TRANSPARENT_HUGEPAGE is not set" :
@@ -1456,13 +1460,17 @@ struct uffd_test_case_ops uffd_move_test_pmd_case_ops = {
  * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
  */
 static void
-do_register_ioctls_test(uffd_test_args_t *args, bool miss, bool wp, bool minor)
+do_register_ioctls_test(uffd_global_test_opts_t *gopts,
+			uffd_test_args_t *args,
+			bool miss,
+			bool wp,
+			bool minor)
 {
 	uint64_t ioctls = 0, expected = BIT_ULL(_UFFDIO_WAKE);
 	mem_type_t *mem_type = args->mem_type;
 	int ret;
 
-	ret = uffd_register_with_ioctls(uffd, area_dst, page_size,
+	ret = uffd_register_with_ioctls(gopts->uffd, gopts->area_dst, gopts->page_size,
 					miss, wp, minor, &ioctls);
 
 	/*
@@ -1493,18 +1501,18 @@ do_register_ioctls_test(uffd_test_args_t *args, bool miss, bool wp, bool minor)
 		    "(miss=%d, wp=%d, minor=%d): expected=0x%"PRIx64", "
 		    "returned=0x%"PRIx64, miss, wp, minor, expected, ioctls);
 
-	if (uffd_unregister(uffd, area_dst, page_size))
+	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size))
 		err("unregister");
 }
 
-static void uffd_register_ioctls_test(uffd_test_args_t *args)
+static void uffd_register_ioctls_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
 	int miss, wp, minor;
 
 	for (miss = 0; miss <= 1; miss++)
 		for (wp = 0; wp <= 1; wp++)
 			for (minor = 0; minor <= 1; minor++)
-				do_register_ioctls_test(args, miss, wp, minor);
+				do_register_ioctls_test(gopts, args, miss, wp, minor);
 
 	uffd_test_pass();
 }
@@ -1742,6 +1750,28 @@ int main(int argc, char *argv[])
 		}
 		for (j = 0; j < n_mems; j++) {
 			mem_type = &mem_types[j];
+
+			/* Initialize global test options */
+			uffd_global_test_opts_t gopts = { 0 };
+
+			gopts.map_shared = mem_type->shared;
+			uffd_test_ops = mem_type->mem_ops;
+			uffd_test_case_ops = test->test_case_ops;
+
+			if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
+				gopts.page_size = default_huge_page_size();
+			else
+				gopts.page_size = psize();
+
+			/* Ensure we have at least 2 pages */
+			gopts.nr_pages = MAX(UFFD_TEST_MEM_SIZE, gopts.page_size * 2)
+				/ gopts.page_size;
+
+			gopts.nr_parallel = 1;
+
+			/* Initialize test arguments */
+			args.mem_type = mem_type;
+
 			if (!(test->mem_targets & mem_type->mem_flag))
 				continue;
 
@@ -1756,13 +1786,12 @@ int main(int argc, char *argv[])
 				uffd_test_skip("feature missing");
 				continue;
 			}
-			if (uffd_setup_environment(&args, test, mem_type,
-						   &errmsg)) {
+			if (uffd_test_ctx_init(&gopts, test->uffd_feature_required, &errmsg)) {
 				uffd_test_skip(errmsg);
 				continue;
 			}
-			test->uffd_fn(&args);
-			uffd_test_ctx_clear();
+			test->uffd_fn(&gopts, &args);
+			uffd_test_ctx_clear(&gopts);
 		}
 	}
 
diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index 78038c40aaaf..4e4a591cf527 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -152,7 +152,8 @@ static bool range_is_swapped(void *addr, size_t size)
 	return true;
 }
 
-static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb)
+static void test_one_folio(uffd_global_test_opts_t *gopts, size_t size, bool private,
+			   bool swapout, bool hugetlb)
 {
 	struct uffdio_writeprotect wp_prms;
 	uint64_t features = 0;
@@ -176,21 +177,21 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
 	}
 
 	/* Register range for uffd-wp. */
-	if (userfaultfd_open(&features)) {
+	if (userfaultfd_open(gopts, &features)) {
 		if (errno == ENOENT)
 			ksft_test_result_skip("userfaultfd not available\n");
 		else
 			ksft_test_result_fail("userfaultfd_open() failed\n");
 		goto out;
 	}
-	if (uffd_register(uffd, mem, size, false, true, false)) {
+	if (uffd_register(gopts->uffd, mem, size, false, true, false)) {
 		ksft_test_result_fail("uffd_register() failed\n");
 		goto out;
 	}
 	wp_prms.mode = UFFDIO_WRITEPROTECT_MODE_WP;
 	wp_prms.range.start = (uintptr_t)mem;
 	wp_prms.range.len = size;
-	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &wp_prms)) {
+	if (ioctl(gopts->uffd, UFFDIO_WRITEPROTECT, &wp_prms)) {
 		ksft_test_result_fail("ioctl(UFFDIO_WRITEPROTECT) failed\n");
 		goto out;
 	}
@@ -237,9 +238,9 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
 out:
 	if (mem)
 		munmap(mem, size);
-	if (uffd >= 0) {
-		close(uffd);
-		uffd = -1;
+	if (gopts->uffd >= 0) {
+		close(gopts->uffd);
+		gopts->uffd = -1;
 	}
 }
 
@@ -331,6 +332,7 @@ static const struct testcase testcases[] = {
 
 int main(int argc, char **argv)
 {
+	uffd_global_test_opts_t gopts = { 0 };
 	struct thp_settings settings;
 	int i, j, plan = 0;
 
@@ -362,8 +364,8 @@ int main(int argc, char **argv)
 		const struct testcase *tc = &testcases[i];
 
 		for (j = 0; j < *tc->nr_sizes; j++)
-			test_one_folio(tc->sizes[j], tc->private, tc->swapout,
-				       tc->hugetlb);
+			test_one_folio(&gopts, tc->sizes[j], tc->private,
+				       tc->swapout, tc->hugetlb);
 	}
 
 	/* If THP is supported, restore original THP settings. */
-- 
2.30.2


