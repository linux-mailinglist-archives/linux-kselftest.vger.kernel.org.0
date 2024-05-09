Return-Path: <linux-kselftest+bounces-9785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C8D8C0DDF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 11:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DED428486C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70614AD1B;
	Thu,  9 May 2024 09:56:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A86BE68;
	Thu,  9 May 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248595; cv=none; b=NWgZl+LptOdGgm0kQHazBOibozwWlb0Bi2KX6IaloACF8U+Y1CPUKUsF2Dle00O4K1QadJ7GySf4N2jJHAjfS9FtRLJ2XKDNznEq/lZeRD6v1EqM8Ho7iDcc1R/gnu+u8wZMYFoo+dpwE2oY8jqO88dgqSCmyfRTtCLoKAo9/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248595; c=relaxed/simple;
	bh=bkdnPTqguEmErPjetrOrTQt4B1ja9Q8ssDLo3J3S05o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tc3nJ1Zz6cyGFfqsco5msY7IwSkaeLASOCWPPtjylHIsXXNaoYk2gceB1yidVebA1LpV9RVc8A1NKuXpiufM8C+KC9FSvy2lfp2k4whdYbUv+DWviKClnKdY8sr2SQVH7WsWq2fHfSgm/rt8wOtFDWsp2I5trrSnMelcuZv0o+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF7C0106F;
	Thu,  9 May 2024 02:56:51 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9FD63F6A8;
	Thu,  9 May 2024 02:56:23 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests/mm: hugetlb_madv_vs_map: Avoid test skipping by querying hugepage size at runtime
Date: Thu,  9 May 2024 15:24:47 +0530
Message-Id: <20240509095447.3791573-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the size used in mmap() is statically defined, leading to
skipping of the test on a hugepage size other than 2 MB, since munmap()
won't free the hugepage for a size greater than 2 MB. Hence, query the
size at runtime.

Also, there is no reason why a hugepage allocation should fail, since we
are using a simple mmap() using MAP_HUGETLB; hence, instead of skipping
the test, make it fail.
 
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/hugetlb_madv_vs_map.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
index d01e8d4901d0..8f122a0f0828 100644
--- a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
+++ b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
@@ -27,9 +27,9 @@
 #include "vm_util.h"
 #include "../kselftest.h"
 
-#define MMAP_SIZE (1 << 21)
 #define INLOOP_ITER 100
 
+size_t mmap_size;
 char *huge_ptr;
 
 /* Touch the memory while it is being madvised() */
@@ -44,7 +44,7 @@ void *touch(void *unused)
 void *madv(void *unused)
 {
 	for (int i = 0; i < INLOOP_ITER; i++)
-		madvise(huge_ptr, MMAP_SIZE, MADV_DONTNEED);
+		madvise(huge_ptr, mmap_size, MADV_DONTNEED);
 
 	return NULL;
 }
@@ -59,7 +59,7 @@ void *map_extra(void *unused)
 	void *ptr;
 
 	for (int i = 0; i < INLOOP_ITER; i++) {
-		ptr = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
+		ptr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
 			   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
 			   -1, 0);
 
@@ -93,14 +93,16 @@ int main(void)
 			       free_hugepages);
 	}
 
+	mmap_size = default_huge_page_size();
+
 	while (max--) {
-		huge_ptr = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
+		huge_ptr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
 				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
 				-1, 0);
 
 		if ((unsigned long)huge_ptr == -1) {
-			ksft_exit_skip("Failed to allocated huge page\n");
-			return KSFT_SKIP;
+			ksft_test_result_fail("Failed to allocate huge page\n");
+			return KSFT_FAIL;
 		}
 
 		pthread_create(&thread1, NULL, madv, NULL);
@@ -117,7 +119,7 @@ int main(void)
 		}
 
 		/* Unmap and restart */
-		munmap(huge_ptr, MMAP_SIZE);
+		munmap(huge_ptr, mmap_size);
 	}
 
 	return KSFT_PASS;
-- 
2.39.2


