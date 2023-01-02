Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7159065B376
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 15:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjABOos (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 09:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjABOoq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 09:44:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39D830F;
        Mon,  2 Jan 2023 06:44:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bn26so7001366wrb.0;
        Mon, 02 Jan 2023 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgFmNRdHygLva/1e819I9RIBayyDHYYRyCiC5tgLkZE=;
        b=POcgRsv3ouy8PBGVrpluD+aI9uTpA/FDDkJRtLTj5IUTTQXqq1GYRgDnhJyd6bBtEE
         BZmFDiAanM3PuSd5W5ukfZ88R6b3EuvkQY9HQnKQlQL6cWep47m9mBFuwD7FutlydoJp
         WABWX9b3rBs12BUU6Ifxx2SIgLl/BAs8BmBMPE3Elu7WcJ4oS4WeVrzArAHu4x4mNFsi
         4hyjNVj99QtmWtGeiAqgTiKPk2Pzg2PmsVSSASJb6oD0QEpfonq3maBMJr4MvE4gpfxg
         fgbpvxMpgtAMCECACEK9951osnI2RLMha6NB0eGXFEPdlW+Ji/O+TtKwyWtFFUWPGQqf
         DB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgFmNRdHygLva/1e819I9RIBayyDHYYRyCiC5tgLkZE=;
        b=LTpHaetTRiNkb1YllPHp9TwV7rrgiblWAgmEjsjwNYilVN0RTy4Zq58H483KcQpqDQ
         kD15zxphdfeh3CUf2hBllfAIaCgUygAR5WRGb3+GFaQWsGAIAXz4/+pQO8SVxMCbBDM3
         nzwKyElIFcEfnN/eYjAAoURn+LY+11Lh9bk5A8YjJLfLlUHE99rlr8NeF+5b48oVhJuG
         cWq5GMOnYnZj3OkWs/0ZDmn9fSusjMfzLb9Wd3j23Dq0u6vXxTzlB5N3WviiT5mtXS8F
         OpaHb8SOx+ErCDCS7ypq7RmUfHGOtiNzPqUf12Xe61K/2IYWjLQACYOl9kEUyd2fOtKP
         IODg==
X-Gm-Message-State: AFqh2kofM0Lkypv3O4rlyRMsAts65g8QdLmzLb468XCWiEVtSwVgDAJd
        +kyLr1Qot56QIslxpvjewAU=
X-Google-Smtp-Source: AMrXdXsLvnP1C5KuZUTiX0RgYNyRX6OcA/vZ359lOBSMfS+hmVc1iGRioX/NzqBGjjbO3GviXU0ULw==
X-Received: by 2002:adf:fcc6:0:b0:277:7243:5cef with SMTP id f6-20020adffcc6000000b0027772435cefmr25540430wrs.67.1672670683159;
        Mon, 02 Jan 2023 06:44:43 -0800 (PST)
Received: from localhost.localdomain ([2a01:4c8:469:341:d1e1:a149:58ed:f096])
        by smtp.googlemail.com with ESMTPSA id v3-20020a5d4a43000000b0026fc5694a60sm28364338wrs.26.2023.01.02.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 06:44:42 -0800 (PST)
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
Subject: [PATCH v2] selftest/vm: add mremap expand merge offset test
Date:   Mon,  2 Jan 2023 14:44:33 +0000
Message-Id: <f132891530423f8bb72fde8169279b1c5967ec40.1672670177.git.lstoakes@gmail.com>
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
 tools/testing/selftests/vm/mremap_test.c | 115 ++++++++++++++++++-----
 1 file changed, 93 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 9496346973d4..8946283b0ba5 100644
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
 
@@ -458,7 +521,15 @@ int main(int argc, char **argv)
 		run_mremap_test_case(test_cases[i], &failures, threshold_mb,
 				     pattern_seed);
 
-	mremap_expand_merge(page_size);
+	maps_fp = fopen("/proc/self/maps", "r");
+	if (maps_fp == NULL) {
+		ksft_print_msg("Failed to read /proc/self/maps: %s\n", strerror(errno));
+	} else {
+		mremap_expand_merge(maps_fp, page_size);
+		mremap_expand_merge_offset(maps_fp, page_size);
+
+		fclose(maps_fp);
+	}
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
-- 
2.39.0

