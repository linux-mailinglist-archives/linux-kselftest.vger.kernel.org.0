Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ED27837B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 03:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjHVB4n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 21:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjHVBzs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 21:55:48 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2356F1A1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:28 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34bbc5eb310so11406125ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692669327; x=1693274127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSp2RkE7WNDbZkDSniptEmg1knVa7eiFGdAlEcTCYXk=;
        b=hB3OrYAbWCivFEMRY0ZLiMpZipo0ohQ9va0ALoFrxF3N6j0sGBBJlAMhPCHbROrmOG
         MMW9Vz6sZFa1UpuJWvtJjqpcBgMy1oMCAqHWjDG602AT6TI0cyy2YQgsTV3s8EI+m5+o
         Y3Mr4kc1PezfoD+BPHuwn4CF5Y65DFcuRKn00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692669327; x=1693274127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSp2RkE7WNDbZkDSniptEmg1knVa7eiFGdAlEcTCYXk=;
        b=G6iOejmREpBXlsCvJs11jGla8dtNp+CFyoNMM0EsKhhMZE0RKZZwlxaB/GebA2XkxF
         gqXU9KxcLayFA1yW/5zAxUdkrSw0vRX7QIS8xPCR3rM5QPBATyjUQCVAWNY1CwsAaDKJ
         xiHg/X57vHQG8UNCFl2qx4Eix/9hCx1SaAZVeGfZcyKo+FXjjw/b1FCOEg3FmvmCTHZ5
         BZ5Cd7M364m9sUGlJGkfkAHcDScsbvU8QQzeZJywqC1rxS7sUqy0EQ6cpqLWS69o9QRg
         28bYKpD8+MZyymb3o/bhPijniB4QbWqKrikf02bO9lQIvMg4jfxfU4/aLpun4c7V77O7
         Ryow==
X-Gm-Message-State: AOJu0Yy+X1lLVyveQQeE20vfNaT3Q9oyBYZR9DFT5LXw0wuky+hGk7Nq
        k76YMDLqhRjXgBprY16yEbZdqQ==
X-Google-Smtp-Source: AGHT+IHh2CBbyhDqgwo/dvz/3E91EJeozSUIuQC8LNJTxnm78FkGwumtTjDlvLHNyDKvyt16yZrJFg==
X-Received: by 2002:a05:6e02:e02:b0:346:5e80:bf67 with SMTP id a2-20020a056e020e0200b003465e80bf67mr8883734ilk.21.1692669327493;
        Mon, 21 Aug 2023 18:55:27 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id q11-20020a92d40b000000b0034886587bdcsm2907390ilm.18.2023.08.21.18.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:55:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v5 7/7] selftests: mm: Add a test for moving from an offset from start of mapping
Date:   Tue, 22 Aug 2023 01:55:00 +0000
Message-ID: <20230822015501.791637-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822015501.791637-1-joel@joelfernandes.org>
References: <20230822015501.791637-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

It is possible that the aligned address falls on no existing mapping,
however that does not mean that we can just align it down to that.
This test verifies that the "vma->vm_start != addr_to_align" check in
can_align_down() prevents disastrous results if aligning down when
source and dest are mutually aligned within a PMD but the source/dest
addresses requested are not at the beginning of the respective mapping
containing these addresses.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 189 ++++++++++++++++-------
 1 file changed, 134 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index f45d1abedc9c..c71ac8306c89 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -24,6 +24,7 @@
 
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 #define SIZE_MB(m) ((size_t)m * (1024 * 1024))
+#define SIZE_KB(k) ((size_t)k * 1024)
 
 struct config {
 	unsigned long long src_alignment;
@@ -148,6 +149,60 @@ static bool is_range_mapped(FILE *maps_fp, void *start, void *end)
 	return success;
 }
 
+/*
+ * Returns the start address of the mapping on success, else returns
+ * NULL on failure.
+ */
+static void *get_source_mapping(struct config c)
+{
+	unsigned long long addr = 0ULL;
+	void *src_addr = NULL;
+	unsigned long long mmap_min_addr;
+
+	mmap_min_addr = get_mmap_min_addr();
+	/*
+	 * For some tests, we need to not have any mappings below the
+	 * source mapping. Add some headroom to mmap_min_addr for this.
+	 */
+	mmap_min_addr += 10 * _4MB;
+
+retry:
+	addr += c.src_alignment;
+	if (addr < mmap_min_addr)
+		goto retry;
+
+	src_addr = mmap((void *) addr, c.region_size, PROT_READ | PROT_WRITE,
+					MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
+					-1, 0);
+	if (src_addr == MAP_FAILED) {
+		if (errno == EPERM || errno == EEXIST)
+			goto retry;
+		goto error;
+	}
+	/*
+	 * Check that the address is aligned to the specified alignment.
+	 * Addresses which have alignments that are multiples of that
+	 * specified are not considered valid. For instance, 1GB address is
+	 * 2MB-aligned, however it will not be considered valid for a
+	 * requested alignment of 2MB. This is done to reduce coincidental
+	 * alignment in the tests.
+	 */
+	if (((unsigned long long) src_addr & (c.src_alignment - 1)) ||
+			!((unsigned long long) src_addr & c.src_alignment)) {
+		munmap(src_addr, c.region_size);
+		goto retry;
+	}
+
+	if (!src_addr)
+		goto error;
+
+	return src_addr;
+error:
+	ksft_print_msg("Failed to map source region: %s\n",
+			strerror(errno));
+	return NULL;
+}
+
 /*
  * This test validates that merge is called when expanding a mapping.
  * Mapping containing three pages is created, middle page is unmapped
@@ -300,60 +355,6 @@ static void mremap_move_within_range(char pattern_seed)
 		ksft_test_result_fail("%s\n", test_name);
 }
 
-/*
- * Returns the start address of the mapping on success, else returns
- * NULL on failure.
- */
-static void *get_source_mapping(struct config c)
-{
-	unsigned long long addr = 0ULL;
-	void *src_addr = NULL;
-	unsigned long long mmap_min_addr;
-
-	mmap_min_addr = get_mmap_min_addr();
-	/*
-	 * For some tests, we need to not have any mappings below the
-	 * source mapping. Add some headroom to mmap_min_addr for this.
-	 */
-	mmap_min_addr += 10 * _4MB;
-
-retry:
-	addr += c.src_alignment;
-	if (addr < mmap_min_addr)
-		goto retry;
-
-	src_addr = mmap((void *) addr, c.region_size, PROT_READ | PROT_WRITE,
-					MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
-					-1, 0);
-	if (src_addr == MAP_FAILED) {
-		if (errno == EPERM || errno == EEXIST)
-			goto retry;
-		goto error;
-	}
-	/*
-	 * Check that the address is aligned to the specified alignment.
-	 * Addresses which have alignments that are multiples of that
-	 * specified are not considered valid. For instance, 1GB address is
-	 * 2MB-aligned, however it will not be considered valid for a
-	 * requested alignment of 2MB. This is done to reduce coincidental
-	 * alignment in the tests.
-	 */
-	if (((unsigned long long) src_addr & (c.src_alignment - 1)) ||
-			!((unsigned long long) src_addr & c.src_alignment)) {
-		munmap(src_addr, c.region_size);
-		goto retry;
-	}
-
-	if (!src_addr)
-		goto error;
-
-	return src_addr;
-error:
-	ksft_print_msg("Failed to map source region: %s\n",
-			strerror(errno));
-	return NULL;
-}
-
 /* Returns the time taken for the remap on success else returns -1. */
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char pattern_seed)
@@ -487,6 +488,83 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	return ret;
 }
 
+/*
+ * Verify that an mremap aligning down does not destroy
+ * the beginning of the mapping just because the aligned
+ * down address landed on a mapping that maybe does not exist.
+ */
+static void mremap_move_1mb_from_start(char pattern_seed)
+{
+	char *test_name = "mremap move 1mb from start at 2MB+256KB aligned src";
+	void *src = NULL, *dest = NULL;
+	int i, success = 1;
+
+	/* Config to reuse get_source_mapping() to do an aligned mmap. */
+	struct config c = {
+		.src_alignment = SIZE_MB(1) + SIZE_KB(256),
+		.region_size = SIZE_MB(6)
+	};
+
+	src = get_source_mapping(c);
+	if (!src) {
+		success = 0;
+		goto out;
+	}
+
+	c.src_alignment = SIZE_MB(1) + SIZE_KB(256);
+	dest = get_source_mapping(c);
+	if (!dest) {
+		success = 0;
+		goto out;
+	}
+
+	/* Set byte pattern for source block. */
+	srand(pattern_seed);
+	for (i = 0; i < SIZE_MB(2); i++) {
+		((char *)src)[i] = (char) rand();
+	}
+
+	/*
+	 * Unmap the beginning of dest so that the aligned address
+	 * falls on no mapping.
+	 */
+	munmap(dest, SIZE_MB(1));
+
+	void *new_ptr = mremap(src + SIZE_MB(1), SIZE_MB(1), SIZE_MB(1),
+						   MREMAP_MAYMOVE | MREMAP_FIXED, dest + SIZE_MB(1));
+	if (new_ptr == MAP_FAILED) {
+		perror("mremap");
+		success = 0;
+		goto out;
+	}
+
+	/* Verify byte pattern after remapping */
+	srand(pattern_seed);
+	for (i = 0; i < SIZE_MB(1); i++) {
+		char c = (char) rand();
+
+		if (((char *)src)[i] != c) {
+			ksft_print_msg("Data at src at %d got corrupted due to unrelated mremap\n",
+				       i);
+			ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
+					((char *) src)[i] & 0xff);
+			success = 0;
+		}
+	}
+
+out:
+	if (src && munmap(src, c.region_size) == -1)
+		perror("munmap src");
+
+	if (dest && munmap(dest, c.region_size) == -1)
+		perror("munmap dest");
+
+	if (success)
+		ksft_test_result_pass("%s\n", test_name);
+	else
+		ksft_test_result_fail("%s\n", test_name);
+}
+
 static void run_mremap_test_case(struct test test_case, int *failures,
 				 unsigned int threshold_mb,
 				 unsigned int pattern_seed)
@@ -565,7 +643,7 @@ int main(int argc, char **argv)
 	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
 	unsigned int pattern_seed;
 	int num_expand_tests = 2;
-	int num_misc_tests = 1;
+	int num_misc_tests = 2;
 	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
@@ -666,6 +744,7 @@ int main(int argc, char **argv)
 	fclose(maps_fp);
 
 	mremap_move_within_range(pattern_seed);
+	mremap_move_1mb_from_start(pattern_seed);
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
-- 
2.42.0.rc1.204.g551eb34607-goog

