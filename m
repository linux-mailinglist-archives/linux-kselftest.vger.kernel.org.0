Return-Path: <linux-kselftest+bounces-3623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8474A83D93D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 12:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D89D1C288D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 11:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271211426E;
	Fri, 26 Jan 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ctzgBNKK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079217C6D;
	Fri, 26 Jan 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268103; cv=none; b=g8pxPvckOGJJdh+kZ7nxOXEZ2BvYzL5mwkwTloN1vhrq4GRwPhXRtYfnRBDlKs6G0awshznz5+DwUApehXx2GAJ7TCs9jR8Dxqld5ek/C0jRb1UhHvdszpaydG3ryoqFEnlQYU0qoEoFiIcD67Bdi6I+WMbAMcuXDe2retfJFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268103; c=relaxed/simple;
	bh=oDxKY6D9IYcq3xKVIIbcarJ6RozlBwyEKP7D9+dutbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjhWx9U879+Vv1mO9AbtBXhmrRhEzBoLt1PwxQAH8wIQ4HhvsYI0FhqTsJO5WnYHP0H98PI1C1KBGqHSS/Jt0LM++Vwfh/XBilvBO47KJ5XaXU0dZOMtPZ/51Qj3v2MNzs3QmE+LEGQErSuU3VvtzGCf4nYYEPA8FlJmaBXoCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ctzgBNKK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706268099;
	bh=oDxKY6D9IYcq3xKVIIbcarJ6RozlBwyEKP7D9+dutbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctzgBNKKw3Zm63flRPmQV7k3ZxCtCt6ZXwYL/2QwVbNWoS4TV85VHw+K2hNOftLyT
	 AhBiBwk+/ghMUsJE2JKJksYOzE0Q7Kv1vM0w4Q5Z11m7YqK/AT7j5O6H9FOEoY80Yv
	 9EiEJwYLgEAzGdyQT6sxP6pnbVoNDFv2t/elNVEzW+l3xNBNDPlyAuwBx1z9RY3QT1
	 x3nGidv+PC/NldxAzP1tPfWJAfvUa6zns1zTWiaHy3vdiPhxCpAUPjB7UHLnEx6VVN
	 2+E4Ahfq2U0OJ4qrka0N9px8HHJIwgriaA+TTTXyYbeG4+PIWofvp/jy8dpcvHVNNE
	 8galWk+HiZEqA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D34CF3782072;
	Fri, 26 Jan 2024 11:21:36 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] selftests/mm: hugetlb-madvise: conform test to TAP format output
Date: Fri, 26 Jan 2024 16:21:22 +0500
Message-ID: <20240126112129.1480265-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240126112129.1480265-1-usama.anjum@collabora.com>
References: <20240126112129.1480265-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v3:
- Rebased on top of next-20240125
---
 tools/testing/selftests/mm/hugetlb-madvise.c | 207 +++++++------------
 1 file changed, 80 insertions(+), 127 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index f32d99565c5ea..2d9b27bc0d01d 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -19,19 +19,14 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include "vm_util.h"
+#include "../kselftest.h"
 
 #define MIN_FREE_PAGES	20
 #define NR_HUGE_PAGES	10	/* common number of pages to map/allocate */
 
 #define validate_free_pages(exp_free)					\
-	do {								\
-		int fhp = get_free_hugepages();				\
-		if (fhp != (exp_free)) {				\
-			printf("Unexpected number of free huge "	\
-				"pages line %d\n", __LINE__);		\
-			exit(1);					\
-		}							\
-	} while (0)
+	ksft_test_result(get_free_hugepages() == (exp_free),		\
+			 "Validation of free pages (%d)\n", __LINE__)
 
 unsigned long huge_page_size;
 unsigned long base_page_size;
@@ -64,28 +59,27 @@ int main(int argc, char **argv)
 	int fd;
 	int ret;
 
+	ksft_print_header();
+
 	huge_page_size = default_huge_page_size();
-	if (!huge_page_size) {
-		printf("Unable to determine huge page size, exiting!\n");
-		exit(1);
-	}
+	if (!huge_page_size)
+		ksft_exit_fail_msg("Unable to determine huge page size, exiting!\n");
+
 	base_page_size = sysconf(_SC_PAGE_SIZE);
-	if (!huge_page_size) {
-		printf("Unable to determine base page size, exiting!\n");
-		exit(1);
-	}
+	if (!huge_page_size)
+		ksft_exit_fail_msg("Unable to determine base page size, exiting!\n");
 
 	free_hugepages = get_free_hugepages();
 	if (free_hugepages < MIN_FREE_PAGES) {
-		printf("Not enough free huge pages to test, exiting!\n");
-		exit(1);
+		ksft_print_msg("Not enough free huge pages to test, exiting!\n");
+		ksft_finished();
 	}
 
 	fd = memfd_create(argv[0], MFD_HUGETLB);
-	if (fd < 0) {
-		perror("memfd_create() failed");
-		exit(1);
-	}
+	if (fd < 0)
+		ksft_exit_fail_msg("memfd_create() failed\n");
+
+	ksft_set_plan(37);
 
 	/*
 	 * Test validity of MADV_DONTNEED addr and length arguments.  mmap
@@ -97,16 +91,13 @@ int main(int argc, char **argv)
 			PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
 			-1, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
+
 	if (munmap(addr, huge_page_size) ||
-			munmap(addr + (NR_HUGE_PAGES + 1) * huge_page_size,
-				huge_page_size)) {
-		perror("munmap");
-		exit(1);
-	}
+	    munmap(addr + (NR_HUGE_PAGES + 1) * huge_page_size, huge_page_size))
+		ksft_exit_fail_msg("munmap: %s\n", strerror(errno));
+
 	addr = addr + huge_page_size;
 
 	write_fault_pages(addr, NR_HUGE_PAGES);
@@ -114,21 +105,13 @@ int main(int argc, char **argv)
 
 	/* addr before mapping should fail */
 	ret = madvise(addr - base_page_size, NR_HUGE_PAGES * huge_page_size,
-		MADV_DONTNEED);
-	if (!ret) {
-		printf("Unexpected success of madvise call with invalid addr line %d\n",
-				__LINE__);
-			exit(1);
-	}
+		      MADV_DONTNEED);
+	ksft_test_result(ret, "The madvise call with invalid address\n");
 
 	/* addr + length after mapping should fail */
 	ret = madvise(addr, (NR_HUGE_PAGES * huge_page_size) + base_page_size,
-		MADV_DONTNEED);
-	if (!ret) {
-		printf("Unexpected success of madvise call with invalid length line %d\n",
-				__LINE__);
-			exit(1);
-	}
+		      MADV_DONTNEED);
+	ksft_test_result(ret, "The madvise call with invalid address\n");
 
 	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
 
@@ -139,10 +122,9 @@ int main(int argc, char **argv)
 			PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
 			-1, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
+
 	write_fault_pages(addr, NR_HUGE_PAGES);
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
@@ -150,19 +132,12 @@ int main(int argc, char **argv)
 	ret = madvise(addr + base_page_size,
 			NR_HUGE_PAGES * huge_page_size - base_page_size,
 			MADV_DONTNEED);
-	if (!ret) {
-		printf("Unexpected success of madvise call with unaligned start address %d\n",
-				__LINE__);
-			exit(1);
-	}
+	ksft_test_result(ret, "The madvise call with unaligned start address\n");
 
 	/* addr + length should be aligned down to huge page size */
-	if (madvise(addr,
-			((NR_HUGE_PAGES - 1) * huge_page_size) + base_page_size,
-			MADV_DONTNEED)) {
-		perror("madvise");
-		exit(1);
-	}
+	ret = madvise(addr, ((NR_HUGE_PAGES - 1) * huge_page_size) + base_page_size,
+		      MADV_DONTNEED);
+	ksft_test_result(!ret, "The madvise call with aligned start address\n");
 
 	/* should free all but last page in mapping */
 	validate_free_pages(free_hugepages - 1);
@@ -177,17 +152,14 @@ int main(int argc, char **argv)
 			PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
 			-1, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
+
 	write_fault_pages(addr, NR_HUGE_PAGES);
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
-	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
-		perror("madvise");
-		exit(1);
-	}
+	ret = madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED);
+	ksft_test_result(!ret, "The madvise MADV_DONTNEED on anonymous private mapping\n");
 
 	/* should free all pages in mapping */
 	validate_free_pages(free_hugepages);
@@ -197,29 +169,25 @@ int main(int argc, char **argv)
 	/*
 	 * Test MADV_DONTNEED on private mapping of hugetlb file
 	 */
-	if (fallocate(fd, 0, 0, NR_HUGE_PAGES * huge_page_size)) {
-		perror("fallocate");
-		exit(1);
-	}
+	if (fallocate(fd, 0, 0, NR_HUGE_PAGES * huge_page_size))
+		ksft_exit_fail_msg("fallocate: %s\n", strerror(errno));
+
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
 	addr = mmap(NULL, NR_HUGE_PAGES * huge_page_size,
 			PROT_READ | PROT_WRITE,
 			MAP_PRIVATE, fd, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 
 	/* read should not consume any pages */
 	read_fault_pages(addr, NR_HUGE_PAGES);
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
 	/* madvise should not free any pages */
-	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
-		perror("madvise");
-		exit(1);
-	}
+	ret = madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED);
+	ksft_test_result(!ret, "The madvise MADV_DONTNEED on private mapping of file\n");
+
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
 	/* writes should allocate private pages */
@@ -227,10 +195,9 @@ int main(int argc, char **argv)
 	validate_free_pages(free_hugepages - (2 * NR_HUGE_PAGES));
 
 	/* madvise should free private pages */
-	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
-		perror("madvise");
-		exit(1);
-	}
+	ret = madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED);
+	ksft_test_result(!ret, "The madvise MADV_DONTNEED on private mapping of file\n");
+
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
 	/* writes should allocate private pages */
@@ -245,10 +212,9 @@ int main(int argc, char **argv)
 	 * implementation.
 	 */
 	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-					0, NR_HUGE_PAGES * huge_page_size)) {
-		perror("fallocate");
-		exit(1);
-	}
+					0, NR_HUGE_PAGES * huge_page_size))
+		ksft_exit_fail_msg("fallocate: %s\n", strerror(errno));
+
 	validate_free_pages(free_hugepages);
 
 	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
@@ -256,29 +222,25 @@ int main(int argc, char **argv)
 	/*
 	 * Test MADV_DONTNEED on shared mapping of hugetlb file
 	 */
-	if (fallocate(fd, 0, 0, NR_HUGE_PAGES * huge_page_size)) {
-		perror("fallocate");
-		exit(1);
-	}
+	if (fallocate(fd, 0, 0, NR_HUGE_PAGES * huge_page_size))
+		ksft_exit_fail_msg("fallocate: %s\n", strerror(errno));
+
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
 	addr = mmap(NULL, NR_HUGE_PAGES * huge_page_size,
 			PROT_READ | PROT_WRITE,
 			MAP_SHARED, fd, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 
 	/* write should not consume any pages */
 	write_fault_pages(addr, NR_HUGE_PAGES);
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
 	/* madvise should not free any pages */
-	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
-		perror("madvise");
-		exit(1);
-	}
+	ret = madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED);
+	ksft_test_result(!ret, "The madvise MADV_DONTNEED on shared mapping of file\n");
+
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
 	/*
@@ -286,29 +248,25 @@ int main(int argc, char **argv)
 	 *
 	 * madvise is same as hole punch and should free all pages.
 	 */
-	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_REMOVE)) {
-		perror("madvise");
-		exit(1);
-	}
+	ret = madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_REMOVE);
+	ksft_test_result(!ret, "The madvise MADV_REMOVE on shared mapping of file\n");
+
 	validate_free_pages(free_hugepages);
 	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
 
 	/*
 	 * Test MADV_REMOVE on shared and private mapping of hugetlb file
 	 */
-	if (fallocate(fd, 0, 0, NR_HUGE_PAGES * huge_page_size)) {
-		perror("fallocate");
-		exit(1);
-	}
+	if (fallocate(fd, 0, 0, NR_HUGE_PAGES * huge_page_size))
+		ksft_exit_fail_msg("fallocate: %s\n", strerror(errno));
+
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
 	addr = mmap(NULL, NR_HUGE_PAGES * huge_page_size,
 			PROT_READ | PROT_WRITE,
 			MAP_SHARED, fd, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 
 	/* shared write should not consume any additional pages */
 	write_fault_pages(addr, NR_HUGE_PAGES);
@@ -317,10 +275,8 @@ int main(int argc, char **argv)
 	addr2 = mmap(NULL, NR_HUGE_PAGES * huge_page_size,
 			PROT_READ | PROT_WRITE,
 			MAP_PRIVATE, fd, 0);
-	if (addr2 == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr2 == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 
 	/* private read should not consume any pages */
 	read_fault_pages(addr2, NR_HUGE_PAGES);
@@ -331,17 +287,15 @@ int main(int argc, char **argv)
 	validate_free_pages(free_hugepages - (2 * NR_HUGE_PAGES));
 
 	/* madvise of shared mapping should not free any pages */
-	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
-		perror("madvise");
-		exit(1);
-	}
+	ret = madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED);
+	ksft_test_result(!ret, "The madvise MADV_REMOVE on shared mapping of file\n");
+
 	validate_free_pages(free_hugepages - (2 * NR_HUGE_PAGES));
 
 	/* madvise of private mapping should free private pages */
-	if (madvise(addr2, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED)) {
-		perror("madvise");
-		exit(1);
-	}
+	ret = madvise(addr2, NR_HUGE_PAGES * huge_page_size, MADV_DONTNEED);
+	ksft_test_result(!ret, "The madvise MADV_REMOVE on shared mapping of file\n");
+
 	validate_free_pages(free_hugepages - NR_HUGE_PAGES);
 
 	/* private write should consume additional pages again */
@@ -353,15 +307,14 @@ int main(int argc, char **argv)
 	 * not correct.  private pages should not be freed, but this is
 	 * expected.  See comment associated with FALLOC_FL_PUNCH_HOLE call.
 	 */
-	if (madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_REMOVE)) {
-		perror("madvise");
-		exit(1);
-	}
+	ret = madvise(addr, NR_HUGE_PAGES * huge_page_size, MADV_REMOVE);
+	ksft_test_result(!ret, "The madvise MADV_REMOVE on shared mapping of file\n");
+
 	validate_free_pages(free_hugepages);
 
 	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
 	(void)munmap(addr2, NR_HUGE_PAGES * huge_page_size);
 
 	close(fd);
-	return 0;
+	ksft_finished();
 }
-- 
2.42.0


