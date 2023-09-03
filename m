Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E8790CB3
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 17:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbjICPNx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243793AbjICPNt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 11:13:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9936612A
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 08:13:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79564282cb1so21313239f.2
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Sep 2023 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693754023; x=1694358823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+nqtAseasZFOdOpIwYvU1wfrPMXCZ3Zt4BE+IzJOeI=;
        b=icCM7tAzofuObhoJQPpsMpaO+grSsCguGAmim704GqP8i0u1ttjtGUGUoHa3E5vRjs
         zKxkWRouRndPglhy6x+rPOwjcFPdDCi93iOcjGd+LXmjzx2cItmRTPTG83TYiYP7RiAU
         fnxCDKydFoOsyu+ocnnMmvLl1vFOjDaUJGR6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754023; x=1694358823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+nqtAseasZFOdOpIwYvU1wfrPMXCZ3Zt4BE+IzJOeI=;
        b=Xm80vcrB1EF1cqy912Pt2TTkmiGaGo3jcg9hIcx1SrDSZ1pO149n6AwbgsAgND5yAf
         jbtDiRquYgPwamlh3jTL2+VUsvggTTK4UVsbTJFe4iS3cUAmyG2KuuEaSPxHfY4wdGLS
         1kEdohc2IEPEJFJY0rpbv5X0ZtFDX3DQXFd138RwQx5LVesxaTpJuz2gU4LJxiy96/WC
         qnec6k5XWUjIasPCBvE3AzqJG4QeUf5JoGv/e1/kjFuWh1zh4N+nfdcGIUdMoF55ckyQ
         TVFPdRMTwfkrk+cnoZm0FkwQuYkt/7+2ej8cFv2tae+f35o+6BxnCkkKA1wjJtJIr5XC
         TwCw==
X-Gm-Message-State: AOJu0Yze8Dom+z0NBTW3jNg0q7XTYaOnqoBhEL6jKpBzYO3mO2h/cEJU
        T9c7bvUPxlOx3/xMOWm/Kb6tlg==
X-Google-Smtp-Source: AGHT+IG0ubtl3WQP2iLAfgo/8U3Gp+Qcadj9ljmVKqqAyOzu0TCZj645xHn8dTLLCtLKiiIphITokw==
X-Received: by 2002:a6b:ec16:0:b0:792:82f8:6f90 with SMTP id c22-20020a6bec16000000b0079282f86f90mr8856879ioh.16.1693754022914;
        Sun, 03 Sep 2023 08:13:42 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f5-20020a6b5105000000b007835a305f61sm2605897iob.36.2023.09.03.08.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:13:42 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v6 7/7] selftests: mm: Add a test for moving from an offset from start of mapping
Date:   Sun,  3 Sep 2023 15:13:28 +0000
Message-ID: <20230903151328.2981432-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230903151328.2981432-1-joel@joelfernandes.org>
References: <20230903151328.2981432-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 189 ++++++++++++++++-------
 1 file changed, 134 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 12a095457f4c..1f836e670a37 100644
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
+	char *test_name = "mremap move 1mb from start at 1MB+256KB aligned src";
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
2.42.0.283.g2d96d420d3-goog

