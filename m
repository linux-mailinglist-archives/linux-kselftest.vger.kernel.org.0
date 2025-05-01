Return-Path: <linux-kselftest+bounces-32087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E6EAA617C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296C57B5374
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33820B807;
	Thu,  1 May 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCEab/fa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAC1C5F18;
	Thu,  1 May 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117626; cv=none; b=mjFaGXLTlukvLAthnGMO6litNSIgbNkWM+rj6eqEfRvdLjQeP0/mqztav5uqrTy6248YcTSjHv6gSf8+ed8rVBGt96a0pO1R1wzW1aQOAtwKWGhn0/KevFMX5lucGnnAcu//68CsgjUAo3TxTFZCR91+9M7pKmrVHmoyYeziHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117626; c=relaxed/simple;
	bh=upBb57xsILROHN0M91N/F4C8WOak3ply/B1BlbEfj+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p8QoIY6Qgcu1gbM14s+VNG7j9iOnz6zHH01VmkkYdgG5Xz/StTlHGnC8X3P3IG0vBMoXxn/z24E5BY9s4sBbj2p9kFSswBYQze22yDIGfbDdMXsKIjXKgG6oq3lg18gRjTAtIBfLNJQsOmZT9r2pldli0WNGlHEIL3eMzw57Xq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCEab/fa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2243803b776so20199385ad.0;
        Thu, 01 May 2025 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746117623; x=1746722423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B29N3ql8Km5YaO47sgwTzjZzJxM9wgtF00Tfw1QDRE=;
        b=LCEab/faHBNQARt4OWAM4uIMisCe+kGLOi0CXckQauVlgNv44m6pi6YkoikWcdBVYR
         jSHwhLlLXtPbCVcDMsAt2s7CCejSK5z2Z9r8xYtlKVGSiIIGcq0Se/l+nrIw3lK7SKt0
         0JIjxs22/5kguZexEaWNeK7O5sJhFN6e3ZatJOVq+Hcry8gpqKpDivNxhhLcAbd2bZgh
         0fryyzLEHG78e/V8TrL37c2T/B1yNPl9ur5X+0Boi32SquKx5tjiKnWBJr3Uhp4L4LqS
         P0e7K401xkwbdmxOmi7hacxhFDvDR/MC43VVC13BwQRE/iHe+5Yk9mBWktRRbMNH7U/3
         l6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117623; x=1746722423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B29N3ql8Km5YaO47sgwTzjZzJxM9wgtF00Tfw1QDRE=;
        b=dfcEheotwPsyLabnIwSr34JKJlnrLDmhNYMpIe4eHmsMmkS6GCsJ6b84CtBJkziY0V
         tMqv2JFdZRZ0l6fMDiC4CHNx5llI9lUKkZmlCHCaFALZQK0MXS4Y9ci5PuZsTalZVt76
         Qych69IcHDt9/7/y7xBiCYDCs7B0YWIWz5uYsTsF1/XyggOq0c/B/UrJ25HXnrwR/eay
         cYdPXVYDCzRBJrWqm57mJaebXH5fjdocSkNmZYUnJcbAx7ll+Nl0fIuCO5LiPsFq/f7Q
         5d0U8hIVRp4iDUNBtsS2BR5kiaI+2A2DD+BzLxZFQ0auqsVj/dVbN+VbMB5CgrZJTmEQ
         2UkA==
X-Forwarded-Encrypted: i=1; AJvYcCV0O5J+e0GtFJGxHiBc57VGGVqhWt2ZbLHGRLnSVZ5rl9Gs3//JXC67aGW0QLwsLnkn+1zcDhWjHGJvCO4Y8Vz/@vger.kernel.org, AJvYcCXpHOAMwwg60HsKtFmTLCol/Bn9fv0us/zP97yrmnL616XE5DLw1PEvYkehs0RaMpTu9kKBwZgzQejXdhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXUh8zG2h/GfVZC+7eaw8iv1ZJGtJ1XW/Bgcm2hY4p8NMJzme
	tAQilWfy1Kewjzut3lq2TddP1zsLxIb6Yb9dhsTx+ZhDNEm+mR8=
X-Gm-Gg: ASbGncvJb1v59ysoTxk3fZmPZ5x/1j6aO1f8V51Amr/ygJ68zPWM2rRQ7P7Oj8alFCx
	N8YZi+lz3mbMGioX2277rL0g1aBibzbc+CC8SV5nq5ueif5N+LAUMrQIIuVDkPcEgfvSnnO0fGP
	OfyIw1NHd1NNPRLrggOx0P6JzXqnrGmQN+iUKcEwwa/Z3CzAvh+YQiGviksCtSweU6V8fHYIvX7
	M4nUgYnTDq5+4jsYTwHO+CuaRjN29RdGpIsua/dQI1D7Pyvg74Kjq10Qz48dvvT/a7HcrmNRBfo
	EztjIy306rX4irS38Ylwua+OPpjwGZW4aKGz4cTMvDmrSszXyDhElAujY7ZZ
X-Google-Smtp-Source: AGHT+IHSslwowYhrXL1lkoPZdSSfH0o+GOL3w4k/egfH0gBxQRgNQeDx+vyOgVorJChvtRUMjaup5Q==
X-Received: by 2002:a17:903:1986:b0:21f:1549:a55a with SMTP id d9443c01a7336-22e040a34ccmr54632085ad.1.1746117622936;
        Thu, 01 May 2025 09:40:22 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.132.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e0bc6e678sm8797525ad.132.2025.05.01.09.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:40:22 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: akpm@linux-foundation.org,
	peterx@redhat.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [PATCH 1/4] selftests/mm/uffd: Refactor non-composite global vars into struct
Date: Thu,  1 May 2025 22:08:24 +0530
Message-Id: <20250501163827.2598-2-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250501163827.2598-1-ujwal.kundur@gmail.com>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch deals with the common uffd routines, refactoring macros and
non-composite global variable definitions into a struct that is defined
at the start of a test and is passed around instead of relying on global
vars.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 tools/testing/selftests/mm/uffd-common.c | 269 ++++++++++++-----------
 tools/testing/selftests/mm/uffd-common.h |  78 +++----
 2 files changed, 186 insertions(+), 161 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index a37088a23ffe..cc8e2079e207 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -7,18 +7,31 @@
 
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
+volatile unsigned long long *area_count(
+		char *area, unsigned long nr,
+		uffd_global_test_opts_t *gopts)
+{
+	return (volatile unsigned long long *)
+			((unsigned long) (area + nr * gopts->page_size +
+			  sizeof(pthread_mutex_t) +
+			  sizeof(unsigned long long) - 1) &
+			 ~(unsigned long)(sizeof(unsigned long long) -  1));
+}
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -40,15 +53,15 @@ static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
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
@@ -57,31 +70,33 @@ static int anon_allocate_area(void **alloc_area, bool is_src)
 	return 0;
 }
 
-static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void noop_alias_mapping(
+		uffd_global_test_opts_t *gopts, __u64 *start, size_t len,
+		unsigned long offset)
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
@@ -89,7 +104,7 @@ static int hugetlb_allocate_area(void **alloc_area, bool is_src)
 		return -errno;
 	}
 
-	if (map_shared) {
+	if (gopts->map_shared) {
 		area_alias = mmap(NULL, size, PROT_READ | PROT_WRITE,
 				  MAP_SHARED, mem_fd, offset);
 		if (area_alias == MAP_FAILED)
@@ -97,9 +112,9 @@ static int hugetlb_allocate_area(void **alloc_area, bool is_src)
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
@@ -108,24 +123,26 @@ static int hugetlb_allocate_area(void **alloc_area, bool is_src)
 	return 0;
 }
 
-static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+static void hugetlb_alias_mapping(
+		uffd_global_test_opts_t *gopts, __u64 *start, size_t len,
+		unsigned long offset)
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
@@ -159,22 +176,24 @@ static int shmem_allocate_area(void **alloc_area, bool is_src)
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
+static void shmem_alias_mapping(
+		uffd_global_test_opts_t *gopts, __u64 *start,
+		size_t len, unsigned long offset)
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
@@ -234,18 +253,18 @@ void uffd_stats_report(struct uffd_args *args, int n_cpus)
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
@@ -255,59 +274,59 @@ int userfaultfd_open(uint64_t *features)
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
@@ -315,26 +334,26 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
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
@@ -342,7 +361,7 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 		 * after the count, to avoid my_bcmp to trigger false
 		 * positives.
 		 */
-		*(area_count(area_src, nr) + 1) = 1;
+		*(area_count(gopts->area_src, nr, gopts) + 1) = 1;
 	}
 
 	/*
@@ -363,13 +382,13 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
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
@@ -416,9 +435,9 @@ static void continue_range(int ufd, __u64 start, __u64 len, bool wp)
 		    ret, (int64_t) req.mapped);
 }
 
-int uffd_read_msg(int ufd, struct uffd_msg *msg)
+int uffd_read_msg(uffd_global_test_opts_t *gopts, struct uffd_msg *msg)
 {
-	int ret = read(uffd, msg, sizeof(*msg));
+	int ret = read(gopts->uffd, msg, sizeof(*msg));
 
 	if (ret != sizeof(*msg)) {
 		if (ret < 0) {
@@ -433,7 +452,9 @@ int uffd_read_msg(int ufd, struct uffd_msg *msg)
 	return 0;
 }
 
-void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
+void uffd_handle_page_fault(
+		uffd_global_test_opts_t *gopts, struct uffd_msg *msg,
+		struct uffd_args *args)
 {
 	unsigned long offset;
 
@@ -442,7 +463,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 
 	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
 		/* Write protect page faults */
-		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
+		wp_range(gopts->uffd, msg->arg.pagefault.address, gopts->page_size, false);
 		args->wp_faults++;
 	} else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) {
 		uint8_t *area;
@@ -460,12 +481,12 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 		 * (UFFD-registered).
 		 */
 
-		area = (uint8_t *)(area_dst +
+		area = (uint8_t *)(gopts->area_dst +
 				   ((char *)msg->arg.pagefault.address -
-				    area_dst_alias));
-		for (b = 0; b < page_size; ++b)
+				    gopts->area_dst_alias));
+		for (b = 0; b < gopts->page_size; ++b)
 			area[b] = ~area[b];
-		continue_range(uffd, msg->arg.pagefault.address, page_size,
+		continue_range(gopts->uffd, msg->arg.pagefault.address, gopts->page_size,
 			       args->apply_wp);
 		args->minor_faults++;
 	} else {
@@ -493,10 +514,10 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
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
@@ -504,6 +525,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 void *uffd_poll_thread(void *arg)
 {
 	struct uffd_args *args = (struct uffd_args *)arg;
+	uffd_global_test_opts_t *gopts = args->gopts;
 	unsigned long cpu = args->cpu;
 	struct pollfd pollfd[2];
 	struct uffd_msg msg;
@@ -514,12 +536,12 @@ void *uffd_poll_thread(void *arg)
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
@@ -537,30 +559,30 @@ void *uffd_poll_thread(void *arg)
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
@@ -568,13 +590,14 @@ void *uffd_poll_thread(void *arg)
 	return NULL;
 }
 
-static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
+static void retry_copy_page(uffd_global_test_opts_t *gopts, struct uffdio_copy *uffdio_copy,
 			    unsigned long offset)
 {
-	uffd_test_ops->alias_mapping(&uffdio_copy->dst,
+	uffd_test_ops->alias_mapping(gopts,
+					&uffdio_copy->dst,
 				     uffdio_copy->len,
 				     offset);
-	if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
+	if (ioctl(gopts->uffd, UFFDIO_COPY, uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
 		if (uffdio_copy->copy != -EEXIST)
 			err("UFFDIO_COPY retry error: %"PRId64,
@@ -597,60 +620,60 @@ static void wake_range(int ufd, unsigned long addr, unsigned long len)
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
index 7700cbfa3975..a3debf116d58 100644
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
+						 struct uffd_msg *msg,
+						 struct uffd_args *args);
 };
 
 struct uffd_test_ops {
-	int (*allocate_area)(void **alloc_area, bool is_src);
-	void (*release_pages)(char *rel_area);
-	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
-	void (*check_pmd_mapping)(void *p, int expect_nr_hpages);
+	int (*allocate_area)(uffd_global_test_opts_t *gopts, void **alloc_area, bool is_src);
+	void (*release_pages)(uffd_global_test_opts_t *gopts, char *rel_area);
+	void (*alias_mapping)(uffd_global_test_opts_t *gopts,
+						  __u64 *start,
+						  size_t len,
+						  unsigned long offset);
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
+										unsigned long nr,
+										uffd_global_test_opts_t *gopts);
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
+							struct uffd_msg *msg,
+							struct uffd_args *args);
+int __copy_page(uffd_global_test_opts_t *gopts, unsigned long offset, bool retry, bool wp);
+int copy_page(uffd_global_test_opts_t *gopts, unsigned long offset, bool wp);
+int move_page(uffd_global_test_opts_t *gopts, unsigned long offset, unsigned long len);
 void *uffd_poll_thread(void *arg);
 
 int uffd_open_dev(unsigned int flags);
-- 
2.20.1


