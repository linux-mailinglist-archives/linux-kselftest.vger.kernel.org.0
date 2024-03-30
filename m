Return-Path: <linux-kselftest+bounces-6917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BD1892C26
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 18:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5911F22854
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FE73DB89;
	Sat, 30 Mar 2024 17:37:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC03D0C4;
	Sat, 30 Mar 2024 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711820267; cv=none; b=LnHaY27V7xUeBpGKJnkbHRLP9E74OerbmKLgtVHPFv+7LzK8oPJMkLmZj97adARA7wk/zo+/3afzBiAmdo7QBNd/GybljTunj5lFKqMf0XZ+Ctg2BDYcltjPj2wMDuZZJqNgJf22870Ahve/y9o+N+WFm0zJKOCUtchhDS7qV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711820267; c=relaxed/simple;
	bh=Af8eg09+2gdRgXFSi9yiCRsX/YUl+szxGem0bcZ8LeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEir7LEsB9tGf61irIAfGx/4FxAaTGGVNK75a637ncMI3AbCcriWUSPv3sdCDu8VmTfA6uqTeyOL/EWcX28Sf20Rj/UBirkypCWrA0WDRYZsp0iu4UiFJYh0kpPAx+lx4OrrI4TLsrgmv7643pftFFHvKcqKN49EGFbLHeRjUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B32B212FC;
	Sat, 30 Mar 2024 10:38:16 -0700 (PDT)
Received: from e116581.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E5853F7B4;
	Sat, 30 Mar 2024 10:37:40 -0700 (PDT)
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
Subject: [PATCH 2/3] selftests/mm: mremap_test: Optimize execution time from minutes to seconds using chunkwise memcmp
Date: Sat, 30 Mar 2024 23:05:56 +0530
Message-Id: <20240330173557.2697684-3-dev.jain@arm.com>
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

Mismatch index is currently being checked by a brute force iteration over the
buffer. Instead, break the comparison into O(sqrt(n)) number of chunks, with
the chunk size of this order only, where n is the size of the buffer. Do a
brute-force iteration to print to stdout only when the highly optimized
memcmp() library function returns a mismatch in the chunk.
The time complexity of this algorithm is O(sqrt(n)) * t, where t is the time
taken by memcmp(); for our test conditions, it is safe to assume t to be small.

NOTE: This patch depends on the previous one.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/mremap_test.c | 112 ++++++++++++++++++-----
 1 file changed, 91 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 7fed9cc3911e..678c79d5b8ef 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -70,6 +70,27 @@ enum {
 	.expect_failure = should_fail				\
 }
 
+/* compute square root using binary search */
+static unsigned long get_sqrt(unsigned long val)
+{
+	unsigned long low = 1;
+
+	/* assuming rand_size is less than 1TB */
+	unsigned long high = (1UL << 20);
+
+	while (low <= high) {
+		unsigned long mid = low + (high - low) / 2;
+		unsigned long temp = mid * mid;
+
+		if (temp == val)
+			return mid;
+		if (temp < val)
+			low = mid + 1;
+		high = mid - 1;
+	}
+	return low;
+}
+
 /*
  * Returns false if the requested remap region overlaps with an
  * existing mapping (e.g text, stack) else returns true.
@@ -355,14 +376,14 @@ static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 
 /* Returns the time taken for the remap on success else returns -1. */
 static long long remap_region(struct config c, unsigned int threshold_mb,
-			      unsigned int pattern_seed, char *rand_addr)
+			      char *rand_addr)
 {
 	void *addr, *src_addr, *dest_addr, *dest_preamble_addr;
-	int d;
-	unsigned long long t;
+	unsigned long long t, d;
 	struct timespec t_start = {0, 0}, t_end = {0, 0};
 	long long  start_ns, end_ns, align_mask, ret, offset;
 	unsigned long long threshold;
+	unsigned long num_chunks;
 
 	if (threshold_mb == VALIDATION_NO_THRESHOLD)
 		threshold = c.region_size;
@@ -430,15 +451,42 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		goto clean_up_dest_preamble;
 	}
 
-	/* Verify byte pattern after remapping */
-	srand(pattern_seed);
-	for (t = 0; t < threshold; t++) {
-		char c = (char) rand();
+	/*
+	 * Verify byte pattern after remapping. Employ an algorithm with a
+	 * square root time complexity in threshold: divide the range into
+	 * chunks, if memcmp() returns non-zero, only then perform an
+	 * iteration in that chunk to find the mismatch index.
+	 */
+	num_chunks = get_sqrt(threshold);
+	for (unsigned long i = 0; i < num_chunks; ++i) {
+		size_t chunk_size = threshold / num_chunks;
+		unsigned long shift = i * chunk_size;
+
+		if (!memcmp(dest_addr + shift, rand_addr + shift, chunk_size))
+			continue;
+
+		/* brute force iteration only over mismatch segment */
+		for (t = shift; t < shift + chunk_size; ++t) {
+			if (((char *) dest_addr)[t] != rand_addr[t]) {
+				ksft_print_msg("Data after remap doesn't match at offset %llu\n",
+						t);
+				ksft_print_msg("Expected: %#x\t Got: %#x\n", rand_addr[t] & 0xff,
+						((char *) dest_addr)[t] & 0xff);
+				ret = -1;
+				goto clean_up_dest;
+			}
+		}
+	}
 
-		if (((char *) dest_addr)[t] != c) {
+	/*
+	 * if threshold is not divisible by num_chunks, then check the
+	 * last chunk
+	 */
+	for (t = num_chunks * (threshold / num_chunks); t < threshold; ++t) {
+		if (((char *) dest_addr)[t] != rand_addr[t]) {
 			ksft_print_msg("Data after remap doesn't match at offset %llu\n",
-				       t);
-			ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
+					t);
+			ksft_print_msg("Expected: %#x\t Got: %#x\n", rand_addr[t] & 0xff,
 					((char *) dest_addr)[t] & 0xff);
 			ret = -1;
 			goto clean_up_dest;
@@ -446,22 +494,44 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	}
 
 	/* Verify the dest preamble byte pattern after remapping */
-	if (c.dest_preamble_size) {
-		srand(pattern_seed);
-		for (d = 0; d < c.dest_preamble_size; d++) {
-			char c = (char) rand();
-
-			if (((char *) dest_preamble_addr)[d] != c) {
-				ksft_print_msg("Preamble data after remap doesn't match at offset %d\n",
-					       d);
-				ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
-					       ((char *) dest_preamble_addr)[d] & 0xff);
+	if (!c.dest_preamble_size)
+		goto no_preamble;
+
+	num_chunks = get_sqrt(c.dest_preamble_size);
+
+	for (unsigned long i = 0; i < num_chunks; ++i) {
+		size_t chunk_size = c.dest_preamble_size / num_chunks;
+		unsigned long shift = i * chunk_size;
+
+		if (!memcmp(dest_preamble_addr + shift, rand_addr + shift,
+			    chunk_size))
+			continue;
+
+		/* brute force iteration only over mismatched segment */
+		for (d = shift; d < shift + chunk_size; ++d) {
+			if (((char *) dest_preamble_addr)[d] != rand_addr[d]) {
+				ksft_print_msg("Preamble data after remap doesn't match at offset %llu\n",
+						d);
+				ksft_print_msg("Expected: %#x\t Got: %#x\n", rand_addr[d] & 0xff,
+						((char *) dest_preamble_addr)[d] & 0xff);
 				ret = -1;
 				goto clean_up_dest;
 			}
 		}
 	}
 
+	for (d = num_chunks * (c.dest_preamble_size / num_chunks); d < c.dest_preamble_size; ++d) {
+		if (((char *) dest_preamble_addr)[d] != rand_addr[d]) {
+			ksft_print_msg("Preamble data after remap doesn't match at offset %llu\n",
+					d);
+			ksft_print_msg("Expected: %#x\t Got: %#x\n", rand_addr[d] & 0xff,
+					((char *) dest_preamble_addr)[d] & 0xff);
+			ret = -1;
+			goto clean_up_dest;
+		}
+	}
+
+no_preamble:
 	start_ns = t_start.tv_sec * NS_PER_SEC + t_start.tv_nsec;
 	end_ns = t_end.tv_sec * NS_PER_SEC + t_end.tv_nsec;
 	ret = end_ns - start_ns;
@@ -563,7 +633,7 @@ static void run_mremap_test_case(struct test test_case, int *failures,
 				 unsigned int pattern_seed, char *rand_addr)
 {
 	long long remap_time = remap_region(test_case.config, threshold_mb,
-					    pattern_seed, rand_addr);
+					    rand_addr);
 
 	if (remap_time < 0) {
 		if (test_case.expect_failure)
-- 
2.34.1


