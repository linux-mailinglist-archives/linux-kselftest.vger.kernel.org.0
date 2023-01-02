Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04D565B4E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 17:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjABQMD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 11:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbjABQLs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 11:11:48 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB2E126;
        Mon,  2 Jan 2023 08:11:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so18714175wms.0;
        Mon, 02 Jan 2023 08:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2umSBEKU1jrOTCQbYbaE77i1/wcdwV3wcFFtsOdAgA=;
        b=K0Mz7MtmcBe5SPITyUynOpL8Bwxtsuj7PNqEvf5Y5tqSRKqS19g67euiPtH5s4WE24
         yplTdRexanBDCgI1726wIhgGV4ZrkJCJTFWkAP/jiaL1FHUhhkesuGqQh1x48xbUyg8S
         wjQCePkwCI0AlpLmRtp4B0JoevW/LF4PiR0QvjXuxkuDjmbgnygz2/Xr+Tc00B782ty7
         oedDIIormmO17UkdyzZbTjgr/8dyq58yp9c+J9b85izqbT3d/JAVPxsA0C+p+hAV0t7T
         13fGuhuJMC7DOORSAp+loZTovRrgsetomoBwclWWRzWdfmhbZeJdKMNMa1urC7V+75YY
         ryvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2umSBEKU1jrOTCQbYbaE77i1/wcdwV3wcFFtsOdAgA=;
        b=L9d2UgOIYf4erHzmQT7J+0kfFNNz8Te9pq0t68CL6jw21t8szOhxAWWU9jqu1ml3i9
         x5t+qmKVwLlmL3UhwW12o1g9mZHgFrVJ837p5J4Zz25WlytYmzhFudTcC15gCuOl5zg6
         JQt2mzvIG9oxT8L8sNR61PXh8vUwFkGbU5/fwCZnWa8NodibZ3b+MhAMjaXAfOGZziuR
         k+k3f3X3XZTvhf2jPWhpLCv3ALai2fO/ihSm0EFnnUFo0ljU1ZNXVheQs8Hg96SQ2n39
         uBbEJbR8cIET+nNVKBzaX7pcDbE5Q+ScFv9CfR4Uod38oWCSPjjcqjIUK/M6O3l5+zy8
         GM3w==
X-Gm-Message-State: AFqh2krgU3SZpYnAN3NalnGDqquhujXPk2awa1tutLC2EiMhaa6Zgkba
        ZE/sllCZyk3CK8GwDOnDQbE=
X-Google-Smtp-Source: AMrXdXst+qvS//a+dHeFG+MatIC9d6NTDrjz2ezqJVlLLtk3tnuWXtftAgnGOc63+/RYWfg+zpLlpQ==
X-Received: by 2002:a1c:4b04:0:b0:3c6:f0b8:74e6 with SMTP id y4-20020a1c4b04000000b003c6f0b874e6mr29900964wma.4.1672675899980;
        Mon, 02 Jan 2023 08:11:39 -0800 (PST)
Received: from localhost.localdomain ([2a01:4c8:469:341:d1e1:a149:58ed:f096])
        by smtp.googlemail.com with ESMTPSA id w23-20020a1cf617000000b003d9b89a39b2sm2923816wmc.10.2023.01.02.08.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:11:39 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4] selftest/vm: add mremap expand merge offset test
Date:   Mon,  2 Jan 2023 16:11:26 +0000
Message-Id: <02b117a8ffd52acc01dc66c2fb39754f08d92c0e.1672675824.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test to assert that we can mremap() and expand a mapping starting
from an offset within an existing mapping. We unmap the last page in a 3
page mapping to ensure that the remap should always succeed, before
remapping from the 2nd page.

This is additionally a regression test for the issue solved in "mm, mremap:
fix mremap() expanding vma with addr inside vma" and confirmed to fail
prior to the change and pass after it.

Finally, this patch updates the existing mremap expand merge test to check
error conditions and reduce code duplication between the two tests.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 tools/testing/selftests/vm/mremap_test.c | 117 ++++++++++++++++++-----
 1 file changed, 95 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 9496346973d4..a705dfe7b259 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -119,47 +119,109 @@ static unsigned long long get_mmap_min_addr(void)
 }
 
 /*
- * This test validates that merge is called when expanding a mapping.
- * Mapping containing three pages is created, middle page is unmapped
- * and then the mapping containing the first page is expanded so that
- * it fills the created hole. The two parts should merge creating
- * single mapping with three pages.
+ * Using /proc/self/maps, assert that the specified address range is contained
+ * within a single mapping.
  */
-static void mremap_expand_merge(unsigned long page_size)
+static bool is_range_mapped(FILE *maps_fp, void *start, void *end)
 {
-	char *test_name = "mremap expand merge";
-	FILE *fp;
 	char *line = NULL;
 	size_t len = 0;
 	bool success = false;
-	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
-			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-
-	munmap(start + page_size, page_size);
-	mremap(start, page_size, 2 * page_size, 0);
 
-	fp = fopen("/proc/self/maps", "r");
-	if (fp == NULL) {
-		ksft_test_result_fail("%s\n", test_name);
-		return;
-	}
+	rewind(maps_fp);
 
-	while (getline(&line, &len, fp) != -1) {
+	while (getline(&line, &len, maps_fp) != -1) {
 		char *first = strtok(line, "- ");
 		void *first_val = (void *)strtol(first, NULL, 16);
 		char *second = strtok(NULL, "- ");
 		void *second_val = (void *) strtol(second, NULL, 16);
 
-		if (first_val == start && second_val == start + 3 * page_size) {
+		if (first_val <= start && second_val >= end) {
 			success = true;
 			break;
 		}
 	}
+
+	return success;
+}
+
+/*
+ * This test validates that merge is called when expanding a mapping.
+ * Mapping containing three pages is created, middle page is unmapped
+ * and then the mapping containing the first page is expanded so that
+ * it fills the created hole. The two parts should merge creating
+ * single mapping with three pages.
+ */
+static void mremap_expand_merge(FILE *maps_fp, unsigned long page_size)
+{
+	char *test_name = "mremap expand merge";
+	bool success = false;
+	char *remap, *start;
+
+	start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (start == MAP_FAILED) {
+		ksft_print_msg("mmap failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	munmap(start + page_size, page_size);
+	remap = mremap(start, page_size, 2 * page_size, 0);
+	if (remap == MAP_FAILED) {
+		ksft_print_msg("mremap failed: %s\n", strerror(errno));
+		munmap(start, page_size);
+		munmap(start + 2 * page_size, page_size);
+		goto out;
+	}
+
+	success = is_range_mapped(maps_fp, start, start + 3 * page_size);
+	munmap(start, 3 * page_size);
+
+out:
+	if (success)
+		ksft_test_result_pass("%s\n", test_name);
+	else
+		ksft_test_result_fail("%s\n", test_name);
+}
+
+/*
+ * Similar to mremap_expand_merge() except instead of removing the middle page,
+ * we remove the last then attempt to remap offset from the second page. This
+ * should result in the mapping being restored to its former state.
+ */
+static void mremap_expand_merge_offset(FILE *maps_fp, unsigned long page_size)
+{
+
+	char *test_name = "mremap expand merge offset";
+	bool success = false;
+	char *remap, *start;
+
+	start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (start == MAP_FAILED) {
+		ksft_print_msg("mmap failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	/* Unmap final page to ensure we have space to expand. */
+	munmap(start + 2 * page_size, page_size);
+	remap = mremap(start + page_size, page_size, 2 * page_size, 0);
+	if (remap == MAP_FAILED) {
+		ksft_print_msg("mremap failed: %s\n", strerror(errno));
+		munmap(start, 2 * page_size);
+		goto out;
+	}
+
+	success = is_range_mapped(maps_fp, start, start + 3 * page_size);
+	munmap(start, 3 * page_size);
+
+out:
 	if (success)
 		ksft_test_result_pass("%s\n", test_name);
 	else
 		ksft_test_result_fail("%s\n", test_name);
-	fclose(fp);
 }
 
 /*
@@ -385,6 +447,7 @@ int main(int argc, char **argv)
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
 	time_t t;
+	FILE *maps_fp;
 
 	pattern_seed = (unsigned int) time(&t);
 
@@ -458,7 +521,17 @@ int main(int argc, char **argv)
 		run_mremap_test_case(test_cases[i], &failures, threshold_mb,
 				     pattern_seed);
 
-	mremap_expand_merge(page_size);
+	maps_fp = fopen("/proc/self/maps", "r");
+
+	if (maps_fp == NULL) {
+		ksft_print_msg("Failed to read /proc/self/maps: %s\n", strerror(errno));
+		exit(KSFT_FAIL);
+	}
+
+	mremap_expand_merge(maps_fp, page_size);
+	mremap_expand_merge_offset(maps_fp, page_size);
+
+	fclose(maps_fp);
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
-- 
2.39.0

