Return-Path: <linux-kselftest+bounces-6918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991E892C28
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 18:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FAC1F221F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 17:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5F40867;
	Sat, 30 Mar 2024 17:37:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BFE3D0C6;
	Sat, 30 Mar 2024 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711820268; cv=none; b=ikL6KX/bCwvc9rOobvIGDVLGZ/TgdfaTlls9Z2lPPYXOyiOew0TNok9Us9ihzLbfYHp2Nf0Q+RMC+lQIe0aKVY/IqDVNyqb521edGKy8zdxqrboJ3QJP4NJTB4SDYI9SLej4pg/6Hm8zJ2hNDDx5z/qTNIqIyr158VdfkocUFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711820268; c=relaxed/simple;
	bh=86LynxX/Wa5mVbZP8ibHc/96NXH3pPQppzNPOikiI/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWbtpzHBETvvBhxhBWQnrE2gEheYkvLCum9F6oLtZIYolr4S4nngi//ZANlMNY6zP9nmTVPWksUCtDj8EnNPrT0B3kfTV/ePrrXgP3shgrVk8Dz6G+q0bCPUjRxXHnsuFlhRNmhCITjX+VEYeIjqVSXl4WdX2fcgo79I4pG2OiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 824DE11FB;
	Sat, 30 Mar 2024 10:38:12 -0700 (PDT)
Received: from e116581.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C7803F7B4;
	Sat, 30 Mar 2024 10:37:35 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kaleshsingh@google.com,
	jhubbard@nvidia.com,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 1/3] selftests/mm: mremap_test: Optimize using pre-filled random array and memcpy
Date: Sat, 30 Mar 2024 23:05:55 +0530
Message-Id: <20240330173557.2697684-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330173557.2697684-1-dev.jain@arm.com>
References: <20240330173557.2697684-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate a pre-filled random buffer using the seed. Replace iterative copying
of the random sequence to buffers using the highly optimized library
function memcpy().

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/mremap_test.c | 78 ++++++++++++++++--------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 2f8b991f78cb..7fed9cc3911e 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -23,6 +23,7 @@
 #define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
 
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
 #define SIZE_MB(m) ((size_t)m * (1024 * 1024))
 #define SIZE_KB(k) ((size_t)k * 1024)
 
@@ -296,7 +297,7 @@ static void mremap_expand_merge_offset(FILE *maps_fp, unsigned long page_size)
  *
  * |DDDDddddSSSSssss|
  */
-static void mremap_move_within_range(char pattern_seed)
+static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 {
 	char *test_name = "mremap mremap move within range";
 	void *src, *dest;
@@ -316,10 +317,7 @@ static void mremap_move_within_range(char pattern_seed)
 	src = (void *)((unsigned long)src & ~(SIZE_MB(2) - 1));
 
 	/* Set byte pattern for source block. */
-	srand(pattern_seed);
-	for (i = 0; i < SIZE_MB(2); i++) {
-		((char *)src)[i] = (char) rand();
-	}
+	memcpy(src, rand_addr, SIZE_MB(2));
 
 	dest = src - SIZE_MB(2);
 
@@ -357,7 +355,7 @@ static void mremap_move_within_range(char pattern_seed)
 
 /* Returns the time taken for the remap on success else returns -1. */
 static long long remap_region(struct config c, unsigned int threshold_mb,
-			      char pattern_seed)
+			      unsigned int pattern_seed, char *rand_addr)
 {
 	void *addr, *src_addr, *dest_addr, *dest_preamble_addr;
 	int d;
@@ -378,9 +376,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	}
 
 	/* Set byte pattern for source block. */
-	srand(pattern_seed);
-	for (t = 0; t < threshold; t++)
-		memset((char *) src_addr + t, (char) rand(), 1);
+	memcpy(src_addr, rand_addr, threshold);
 
 	/* Mask to zero out lower bits of address for alignment */
 	align_mask = ~(c.dest_alignment - 1);
@@ -420,9 +416,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		}
 
 		/* Set byte pattern for the dest preamble block. */
-		srand(pattern_seed);
-		for (d = 0; d < c.dest_preamble_size; d++)
-			memset((char *) dest_preamble_addr + d, (char) rand(), 1);
+		memcpy(dest_preamble_addr, rand_addr, c.dest_preamble_size);
 	}
 
 	clock_gettime(CLOCK_MONOTONIC, &t_start);
@@ -494,7 +488,8 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
  * the beginning of the mapping just because the aligned
  * down address landed on a mapping that maybe does not exist.
  */
-static void mremap_move_1mb_from_start(char pattern_seed)
+static void mremap_move_1mb_from_start(unsigned int pattern_seed,
+				       char *rand_addr)
 {
 	char *test_name = "mremap move 1mb from start at 1MB+256KB aligned src";
 	void *src = NULL, *dest = NULL;
@@ -520,10 +515,7 @@ static void mremap_move_1mb_from_start(char pattern_seed)
 	}
 
 	/* Set byte pattern for source block. */
-	srand(pattern_seed);
-	for (i = 0; i < SIZE_MB(2); i++) {
-		((char *)src)[i] = (char) rand();
-	}
+	memcpy(src, rand_addr, SIZE_MB(2));
 
 	/*
 	 * Unmap the beginning of dest so that the aligned address
@@ -568,10 +560,10 @@ static void mremap_move_1mb_from_start(char pattern_seed)
 
 static void run_mremap_test_case(struct test test_case, int *failures,
 				 unsigned int threshold_mb,
-				 unsigned int pattern_seed)
+				 unsigned int pattern_seed, char *rand_addr)
 {
 	long long remap_time = remap_region(test_case.config, threshold_mb,
-					    pattern_seed);
+					    pattern_seed, rand_addr);
 
 	if (remap_time < 0) {
 		if (test_case.expect_failure)
@@ -642,7 +634,15 @@ int main(int argc, char **argv)
 	int failures = 0;
 	int i, run_perf_tests;
 	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
+
+	/* hard-coded test configs */
+	size_t max_test_variable_region_size = _2GB;
+	size_t max_test_constant_region_size = _2MB;
+	size_t dest_preamble_size = 10 * _4MB;
+
 	unsigned int pattern_seed;
+	char *rand_addr;
+	size_t rand_size;
 	int num_expand_tests = 2;
 	int num_misc_tests = 2;
 	struct test test_cases[MAX_TEST] = {};
@@ -659,6 +659,31 @@ int main(int argc, char **argv)
 	ksft_print_msg("Test configs:\n\tthreshold_mb=%u\n\tpattern_seed=%u\n\n",
 		       threshold_mb, pattern_seed);
 
+	/*
+	 * set preallocated random array according to test configs; see the
+	 * functions for the logic of setting the size
+	 */
+	if (!threshold_mb)
+		rand_size = MAX(max_test_variable_region_size,
+				max_test_constant_region_size);
+	else
+		rand_size = MAX(MIN(threshold_mb * _1MB,
+				    max_test_variable_region_size),
+				max_test_constant_region_size);
+	rand_size = MAX(dest_preamble_size, rand_size);
+
+	rand_addr = (char *)mmap(NULL, rand_size, PROT_READ | PROT_WRITE,
+				 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (rand_addr == MAP_FAILED) {
+		perror("mmap");
+		ksft_exit_fail_msg("cannot mmap rand_addr\n");
+	}
+
+	/* fill stream of random bytes */
+	srand(pattern_seed);
+	for (unsigned long i = 0; i < rand_size; ++i)
+		rand_addr[i] = (char) rand();
+
 	page_size = sysconf(_SC_PAGESIZE);
 
 	/* Expected mremap failures */
@@ -730,13 +755,13 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
 		run_mremap_test_case(test_cases[i], &failures, threshold_mb,
-				     pattern_seed);
+				     pattern_seed, rand_addr);
 
 	maps_fp = fopen("/proc/self/maps", "r");
 
 	if (maps_fp == NULL) {
-		ksft_print_msg("Failed to read /proc/self/maps: %s\n", strerror(errno));
-		exit(KSFT_FAIL);
+		munmap(rand_addr, rand_size);
+		ksft_exit_fail_msg("Failed to read /proc/self/maps: %s\n", strerror(errno));
 	}
 
 	mremap_expand_merge(maps_fp, page_size);
@@ -744,17 +769,20 @@ int main(int argc, char **argv)
 
 	fclose(maps_fp);
 
-	mremap_move_within_range(pattern_seed);
-	mremap_move_1mb_from_start(pattern_seed);
+	mremap_move_within_range(pattern_seed, rand_addr);
+	mremap_move_1mb_from_start(pattern_seed, rand_addr);
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
 		 "mremap HAVE_MOVE_PMD/PUD optimization time comparison for 1GB region:");
 		for (i = 0; i < ARRAY_SIZE(perf_test_cases); i++)
 			run_mremap_test_case(perf_test_cases[i], &failures,
-					     threshold_mb, pattern_seed);
+					     threshold_mb, pattern_seed,
+					     rand_addr);
 	}
 
+	munmap(rand_addr, rand_size);
+
 	if (failures > 0)
 		ksft_exit_fail();
 	else
-- 
2.34.1


