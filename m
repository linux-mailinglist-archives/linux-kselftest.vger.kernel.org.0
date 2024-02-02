Return-Path: <linux-kselftest+bounces-4012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C82F846EFD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 12:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB731F240A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942014199F;
	Fri,  2 Feb 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ipHgTHIb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9A140768;
	Fri,  2 Feb 2024 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873509; cv=none; b=u3TDoT3Kday1V0XwDSwNrZQ6qXGFZmHomLKen8lBGKvOzFoSU7y9YyzCnTPlLwZnpj91csUZHBuJ2umHVwo2AriYvfhaFEzfBciT+FLkf7oDyAqPyuV5ujLQJN+bRD4QH08CKExoZn+wR6ICjj05BPY/EiHm8IazvdLFHmI+Ifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873509; c=relaxed/simple;
	bh=phqEauq7xpk8vLg2PWuGHTlhwPPAnujnoDVOr8o/G5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVAyMk2bK2jkVd02Ino7O0lFIJ7uW9BmxyvhH1gA8Kr0bH3ZrWXqhY4wU+VAZarHGtPI0yME9b0e3QM168X3B6fUd22SrDsg9GyHihZgXMz9804DgTIYdxeKKjksQFPBQTg23MdmMqYGtBw42rjL/mWT6EUbQ/IOsNIOon+e9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ipHgTHIb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706873505;
	bh=phqEauq7xpk8vLg2PWuGHTlhwPPAnujnoDVOr8o/G5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipHgTHIbiZtL9GHnLkuHFSqUSjrI8mA7oZH118h7U07iSgQcWvmLRz2JL5vFbzeoa
	 CxvrBadDugg7yifOh6jgaW7EJ7PLl6Pb++JGSvDaEKNwT1Z2jOt2WWHPooMXhUaXsR
	 uKLORI0Cb7tfrSU37m8l0Fi4QVkC8H/Ym/rwqI8WZZPsY9V45hoWj/Lf81awLqvx3h
	 iI+l2xlw7BRq9Rs0o1axoKjTgsU8ItkQ4LpyLY4pheyL7HIuBd3p5SGc+rRaFk6UPi
	 j+a8XUYvPIhvp3odA1NCsfV6CtUjAL6R9dOJVweVBPLxJF/9gCxXBthA58qsqcYYkN
	 40uffs/rX6xLA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D80D53782099;
	Fri,  2 Feb 2024 11:31:43 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/12] selftests/mm: split_huge_page_test: conform test to TAP format output
Date: Fri,  2 Feb 2024 16:31:15 +0500
Message-ID: <20240202113119.2047740-9-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240202113119.2047740-1-usama.anjum@collabora.com>
References: <20240202113119.2047740-1-usama.anjum@collabora.com>
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
 .../selftests/mm/split_huge_page_test.c       | 161 ++++++++----------
 1 file changed, 69 insertions(+), 92 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 0e74635c8c3d9..7b698a848babf 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -17,6 +17,7 @@
 #include <malloc.h>
 #include <stdbool.h>
 #include "vm_util.h"
+#include "../kselftest.h"
 
 uint64_t pagesize;
 unsigned int pageshift;
@@ -50,21 +51,19 @@ int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
 	return 0;
 }
 
-static int write_file(const char *path, const char *buf, size_t buflen)
+static void write_file(const char *path, const char *buf, size_t buflen)
 {
 	int fd;
 	ssize_t numwritten;
 
 	fd = open(path, O_WRONLY);
 	if (fd == -1)
-		return 0;
+		ksft_exit_fail_msg("%s open failed: %s\n", path, strerror(errno));
 
 	numwritten = write(fd, buf, buflen - 1);
 	close(fd);
 	if (numwritten < 1)
-		return 0;
-
-	return (unsigned int) numwritten;
+		ksft_exit_fail_msg("Write failed\n");
 }
 
 static void write_debugfs(const char *fmt, ...)
@@ -77,15 +76,10 @@ static void write_debugfs(const char *fmt, ...)
 	ret = vsnprintf(input, INPUT_MAX, fmt, argp);
 	va_end(argp);
 
-	if (ret >= INPUT_MAX) {
-		printf("%s: Debugfs input is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
+	if (ret >= INPUT_MAX)
+		ksft_exit_fail_msg("%s: Debugfs input is too long\n", __func__);
 
-	if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
-		perror(SPLIT_DEBUGFS);
-		exit(EXIT_FAILURE);
-	}
+	write_file(SPLIT_DEBUGFS, input, ret + 1);
 }
 
 void split_pmd_thp(void)
@@ -95,39 +89,30 @@ void split_pmd_thp(void)
 	size_t i;
 
 	one_page = memalign(pmd_pagesize, len);
-
-	if (!one_page) {
-		printf("Fail to allocate memory\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!one_page)
+		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
 
 	madvise(one_page, len, MADV_HUGEPAGE);
 
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
-		printf("No THP is allocated\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!check_huge_anon(one_page, 4, pmd_pagesize))
+		ksft_exit_fail_msg("No THP is allocated\n");
 
 	/* split all THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
 		(uint64_t)one_page + len);
 
 	for (i = 0; i < len; i++)
-		if (one_page[i] != (char)i) {
-			printf("%ld byte corrupted\n", i);
-			exit(EXIT_FAILURE);
-		}
+		if (one_page[i] != (char)i)
+			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
 
-	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
-		printf("Still AnonHugePages not split\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!check_huge_anon(one_page, 0, pmd_pagesize))
+		ksft_exit_fail_msg("Still AnonHugePages not split\n");
 
-	printf("Split huge pages successful\n");
+	ksft_test_result_pass("Split huge pages successful\n");
 	free(one_page);
 }
 
@@ -143,36 +128,29 @@ void split_pte_mapped_thp(void)
 	int pagemap_fd;
 	int kpageflags_fd;
 
-	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0) {
-		perror("get pagemap proc error");
-		exit(EXIT_FAILURE);
-	}
-	pagemap_fd = open(pagemap_proc, O_RDONLY);
+	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0)
+		ksft_exit_fail_msg("get pagemap proc error: %s\n", strerror(errno));
 
-	if (pagemap_fd == -1) {
-		perror("read pagemap:");
-		exit(EXIT_FAILURE);
-	}
+	pagemap_fd = open(pagemap_proc, O_RDONLY);
+	if (pagemap_fd == -1)
+		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
 
 	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
-
-	if (kpageflags_fd == -1) {
-		perror("read kpageflags:");
-		exit(EXIT_FAILURE);
-	}
+	if (kpageflags_fd == -1)
+		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
 
 	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (one_page == MAP_FAILED)
+		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
 
 	madvise(one_page, len, MADV_HUGEPAGE);
 
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
-		printf("No THP is allocated\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!check_huge_anon(one_page, 4, pmd_pagesize))
+		ksft_exit_fail_msg("No THP is allocated\n");
 
 	/* remap the first pagesize of first THP */
 	pte_mapped = mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
@@ -183,10 +161,8 @@ void split_pte_mapped_thp(void)
 				     pagesize, pagesize,
 				     MREMAP_MAYMOVE|MREMAP_FIXED,
 				     pte_mapped + pagesize * i);
-		if (pte_mapped2 == (char *)-1) {
-			perror("mremap failed");
-			exit(EXIT_FAILURE);
-		}
+		if (pte_mapped2 == MAP_FAILED)
+			ksft_exit_fail_msg("mremap failed: %s\n", strerror(errno));
 	}
 
 	/* smap does not show THPs after mremap, use kpageflags instead */
@@ -196,10 +172,8 @@ void split_pte_mapped_thp(void)
 		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
 			thp_size++;
 
-	if (thp_size != 4) {
-		printf("Some THPs are missing during mremap\n");
-		exit(EXIT_FAILURE);
-	}
+	if (thp_size != 4)
+		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
 
 	/* split all remapped THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
@@ -208,21 +182,18 @@ void split_pte_mapped_thp(void)
 	/* smap does not show THPs after mremap, use kpageflags instead */
 	thp_size = 0;
 	for (i = 0; i < pagesize * 4; i++) {
-		if (pte_mapped[i] != (char)i) {
-			printf("%ld byte corrupted\n", i);
-			exit(EXIT_FAILURE);
-		}
+		if (pte_mapped[i] != (char)i)
+			ksft_exit_fail_msg("%ld byte corrupted\n", i);
+
 		if (i % pagesize == 0 &&
 		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
 			thp_size++;
 	}
 
-	if (thp_size) {
-		printf("Still %ld THPs not split\n", thp_size);
-		exit(EXIT_FAILURE);
-	}
+	if (thp_size)
+		ksft_exit_fail_msg("Still %ld THPs not split\n", thp_size);
 
-	printf("Split PTE-mapped huge pages successful\n");
+	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
 	munmap(one_page, len);
 	close(pagemap_fd);
 	close(kpageflags_fd);
@@ -238,24 +209,21 @@ void split_file_backed_thp(void)
 	char testfile[INPUT_MAX];
 	uint64_t pgoff_start = 0, pgoff_end = 1024;
 
-	printf("Please enable pr_debug in split_huge_pages_in_file() if you need more info.\n");
+	ksft_print_msg("Please enable pr_debug in split_huge_pages_in_file() for more info.\n");
 
 	status = mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=always,size=4m");
 
-	if (status) {
-		printf("Unable to create a tmpfs for testing\n");
-		exit(EXIT_FAILURE);
-	}
+	if (status)
+		ksft_exit_fail_msg("Unable to create a tmpfs for testing\n");
 
 	status = snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
 	if (status >= INPUT_MAX) {
-		printf("Fail to create file-backed THP split testing file\n");
-		goto cleanup;
+		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
 	}
 
 	fd = open(testfile, O_CREAT|O_WRONLY);
 	if (fd == -1) {
-		perror("Cannot open testing file\n");
+		ksft_perror("Cannot open testing file");
 		goto cleanup;
 	}
 
@@ -264,7 +232,7 @@ void split_file_backed_thp(void)
 	close(fd);
 
 	if (num_written < 1) {
-		printf("Fail to write data to testing file\n");
+		ksft_perror("Fail to write data to testing file");
 		goto cleanup;
 	}
 
@@ -272,42 +240,51 @@ void split_file_backed_thp(void)
 	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end);
 
 	status = unlink(testfile);
-	if (status)
-		perror("Cannot remove testing file\n");
+	if (status) {
+		ksft_perror("Cannot remove testing file");
+		goto cleanup;
+	}
 
-cleanup:
 	status = umount(tmpfs_loc);
 	if (status) {
-		printf("Unable to umount %s\n", tmpfs_loc);
-		exit(EXIT_FAILURE);
+		rmdir(tmpfs_loc);
+		ksft_exit_fail_msg("Unable to umount %s\n", tmpfs_loc);
 	}
+
 	status = rmdir(tmpfs_loc);
-	if (status) {
-		perror("cannot remove tmp dir");
-		exit(EXIT_FAILURE);
-	}
+	if (status)
+		ksft_exit_fail_msg("cannot remove tmp dir: %s\n", strerror(errno));
 
-	printf("file-backed THP split test done, please check dmesg for more information\n");
+	ksft_print_msg("Please check dmesg for more information\n");
+	ksft_test_result_pass("File-backed THP split test done\n");
+	return;
+
+cleanup:
+	umount(tmpfs_loc);
+	rmdir(tmpfs_loc);
+	ksft_exit_fail_msg("Error occurred\n");
 }
 
 int main(int argc, char **argv)
 {
+	ksft_print_header();
+
 	if (geteuid() != 0) {
-		printf("Please run the benchmark as root\n");
-		exit(EXIT_FAILURE);
+		ksft_print_msg("Please run the benchmark as root\n");
+		ksft_finished();
 	}
 
+	ksft_set_plan(3);
+
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
 	pmd_pagesize = read_pmd_pagesize();
-	if (!pmd_pagesize) {
-		printf("Reading PMD pagesize failed\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!pmd_pagesize)
+		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
 	split_pmd_thp();
 	split_pte_mapped_thp();
 	split_file_backed_thp();
 
-	return 0;
+	ksft_finished();
 }
-- 
2.42.0


