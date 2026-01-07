Return-Path: <linux-kselftest+bounces-48426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C3CFF00A
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 18:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A17653008542
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A015135772B;
	Wed,  7 Jan 2026 16:49:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3134B425;
	Wed,  7 Jan 2026 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804555; cv=none; b=dqMMoQEa6f5z8BpegjVZvQRR9MpoMBblhN+D4U7sxjNxsRdMaqtSUD914Gol6py6Y1ZvU3BqOYe0dEP5THLhxOwgy3Ys9JSZhJaNwE2kQdKI0X90XbvmJO8xMADIa3ezGDZqiQc7vXzrQNo0siTrZeJHCvABBzAfxNvGM0IVsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804555; c=relaxed/simple;
	bh=hVcrYx1PlEIf89awYzQhAdw/HoIMx6RpxVSkN+eaEgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ2YIm7UXUuCXM7CeS/2sP1AZPjzHoKPSrxTszKM8NHziCNQWExkKv+6RUr4TBS2WdwzDWqhmd3eQM6ARfo4vJ5inDZmBb4dHDW5QC2zdAx6JQ55j17ioPq2OaEVWKEC7lK4GeV0esTe1w/W9JON3bSsPfDYMnL/2KpQ/+V7a3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 094C11684;
	Wed,  7 Jan 2026 08:48:52 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986943F5A1;
	Wed,  7 Jan 2026 08:48:57 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 5/8] selftests/mm: introduce helper to read every page in range
Date: Wed,  7 Jan 2026 16:48:39 +0000
Message-ID: <20260107164842.3289559-6-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107164842.3289559-1-kevin.brodsky@arm.com>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FORCE_READ(*addr) ensures that the compiler will emit a load from
addr. Several tests need to trigger such a load for every page in
the range [addr, addr + len), ensuring that every page is faulted
in, if it wasn't already.

Introduce a new helper force_read_pages_in_range() that does exactly
that and replace existing loops with a call to it. Some of those
loops have a different step size, but reading from every page is
appropriate in all cases.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/hugetlb-madvise.c     |  9 +--------
 tools/testing/selftests/mm/pfnmap.c              | 16 ++++++----------
 .../testing/selftests/mm/split_huge_page_test.c  |  6 +-----
 tools/testing/selftests/mm/vm_util.h             |  6 ++++++
 4 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index 05d9d2805ae4..1f82568ae262 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -47,14 +47,7 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
 
 void read_fault_pages(void *addr, unsigned long nr_pages)
 {
-	unsigned long i;
-
-	for (i = 0; i < nr_pages; i++) {
-		unsigned long *addr2 =
-			((unsigned long *)(addr + (i * huge_page_size)));
-		/* Prevent the compiler from optimizing out the entire loop: */
-		FORCE_READ(*addr2);
-	}
+	force_read_pages_in_range(addr, nr_pages * huge_page_size);
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index f546dfb10cae..35b0e3ed54cd 100644
--- a/tools/testing/selftests/mm/pfnmap.c
+++ b/tools/testing/selftests/mm/pfnmap.c
@@ -33,20 +33,17 @@ static void signal_handler(int sig)
 	siglongjmp(sigjmp_buf_env, -EFAULT);
 }
 
-static int test_read_access(char *addr, size_t size, size_t pagesize)
+static int test_read_access(char *addr, size_t size)
 {
-	size_t offs;
 	int ret;
 
 	if (signal(SIGSEGV, signal_handler) == SIG_ERR)
 		return -EINVAL;
 
 	ret = sigsetjmp(sigjmp_buf_env, 1);
-	if (!ret) {
-		for (offs = 0; offs < size; offs += pagesize)
-			/* Force a read that the compiler cannot optimize out. */
-			*((volatile char *)(addr + offs));
-	}
+	if (!ret)
+		force_read_pages_in_range(addr, size);
+
 	if (signal(SIGSEGV, SIG_DFL) == SIG_ERR)
 		return -EINVAL;
 
@@ -138,7 +135,7 @@ FIXTURE_SETUP(pfnmap)
 		SKIP(return, "Invalid file: '%s'. Not pfnmap'ed\n", file);
 
 	/* ... and want to be able to read from them. */
-	if (test_read_access(self->addr1, self->size1, self->pagesize))
+	if (test_read_access(self->addr1, self->size1))
 		SKIP(return, "Cannot read-access mmap'ed '%s'\n", file);
 
 	self->size2 = 0;
@@ -243,8 +240,7 @@ TEST_F(pfnmap, fork)
 	ASSERT_GE(pid, 0);
 
 	if (!pid) {
-		EXPECT_EQ(test_read_access(self->addr1, self->size1,
-					   self->pagesize), 0);
+		EXPECT_EQ(test_read_access(self->addr1, self->size1), 0);
 		exit(0);
 	}
 
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 40799f3f0213..65a89ceca4a5 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -652,11 +652,7 @@ static int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size,
 	}
 	madvise(*addr, fd_size, MADV_HUGEPAGE);
 
-	for (size_t i = 0; i < fd_size; i++) {
-		char *addr2 = *addr + i;
-
-		FORCE_READ(*addr2);
-	}
+	force_read_pages_in_range(*addr, fd_size);
 
 	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
 		ksft_print_msg("No large pagecache folio generated, please provide a filesystem supporting large folio\n");
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 6ad32b1830f1..74bdf96161d7 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -54,6 +54,12 @@ static inline unsigned int pshift(void)
 	return __page_shift;
 }
 
+static inline void force_read_pages_in_range(char *addr, size_t len)
+{
+	for (size_t i = 0; i < len; i += psize())
+		FORCE_READ(addr[i]);
+}
+
 bool detect_huge_zeropage(void);
 
 /*
-- 
2.51.2


