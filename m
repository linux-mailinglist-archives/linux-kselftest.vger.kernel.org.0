Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D02064F350
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 22:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiLPVpK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 16:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPVpI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 16:45:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E89D32B9C;
        Fri, 16 Dec 2022 13:45:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so2700240wms.2;
        Fri, 16 Dec 2022 13:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRK3ufbYho0z9LiSN86FnA5BN6pv7SkyPTFsiET5xIc=;
        b=FqV5ZpDNvorXYyLpowDzrdKInEILpDvNy30qKoV0gMOzQMUp5S8UxLXlhmghPi9Hkg
         Em+Oib6+DVksyWYEIGRYuMAS520rW7LCPEvDvcMkdgjPhzWlNas86EaayO0lrmy8goAp
         zmrgLWBmZnD3wuFLt24FMF+qqE/GNufngpY7dLDdqpIiFJED7tsLdFHZUMkOYZzNPRYs
         MjepnAYaSUsxxARCMosTLXJfDjEjEvIwupu6S278/exYqeXhmP15EpdYRpf0kmJuZ450
         tjn7uvnzevFuIf6z8pKic6CcVSKcgaHOVVZe1XkjrtbxBbi2oYQsCf2GPThziw0XxqVD
         w7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRK3ufbYho0z9LiSN86FnA5BN6pv7SkyPTFsiET5xIc=;
        b=5xQhrrmPk6ne94Qff6jLjtvKvRBPZbCYHrRyG+iLHoIJOqp++pSgDYm7J9v8O4Snxw
         etEkwOlAG1psgXfiAy8++wXxlPVzvzXJ8AbWesN/mw3kQiNKQloEuXa+tuqphdKjYeX8
         adis7jvL/KXUCucQ6LHuIx67w7bVmZeR9nqeycPuYkPkFmxXDGj6zhZJWmlRdaP+Q4o3
         B3tVLb/iWurH4U0xs/+wW0Mu6zyy22dYdfxOXagdG9Bxm7c6eibMMR7zD+b8bvMYLwO6
         zg1s3dxSxsLKeJMmIpi6igybL3m4R6eNFxNlyOg2sTM2Dv4EEItjGMNS2yGL+9ZjltTY
         kDDQ==
X-Gm-Message-State: ANoB5pkGNLmxTWk7IC9ySKqQGfsU2xyeHl/P6Kq8qYku0AMRVjCqu00D
        tzQERjftOU296/qxtDtFHq4=
X-Google-Smtp-Source: AA0mqf6VMLjHVjuSEBVqErF+mL/E0FJGDdBthNbYiNUdxFDFCpUa//9B+fdATpcwXQjf3zXLFPzupg==
X-Received: by 2002:a05:600c:4fd1:b0:3cf:a08f:10a5 with SMTP id o17-20020a05600c4fd100b003cfa08f10a5mr27514173wmq.31.1671227105543;
        Fri, 16 Dec 2022 13:45:05 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id z19-20020a05600c221300b003a3170a7af9sm3728762wml.4.2022.12.16.13.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:45:04 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] selftest/vm: add mremap expand merge offset test
Date:   Fri, 16 Dec 2022 21:44:36 +0000
Message-Id: <20221216214436.405071-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.38.1
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
 tools/testing/selftests/vm/mremap_test.c | 111 +++++++++++++++++++----
 1 file changed, 93 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 9496346973d4..28a17d4e8afd 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -119,30 +119,19 @@ static unsigned long long get_mmap_min_addr(void)
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
+static bool is_range_mapped(void *start, void *end)
 {
-	char *test_name = "mremap expand merge";
 	FILE *fp;
 	char *line = NULL;
 	size_t len = 0;
 	bool success = false;
-	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
-			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-
-	munmap(start + page_size, page_size);
-	mremap(start, page_size, 2 * page_size, 0);

 	fp = fopen("/proc/self/maps", "r");
-	if (fp == NULL) {
-		ksft_test_result_fail("%s\n", test_name);
-		return;
-	}
+	if (fp == NULL)
+		return false;

 	while (getline(&line, &len, fp) != -1) {
 		char *first = strtok(line, "- ");
@@ -150,16 +139,101 @@ static void mremap_expand_merge(unsigned long page_size)
 		char *second = strtok(NULL, "- ");
 		void *second_val = (void *) strtol(second, NULL, 16);

-		if (first_val == start && second_val == start + 3 * page_size) {
+		if (first_val <= start && second_val >= end) {
 			success = true;
 			break;
 		}
 	}
+
+	fclose(fp);
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
+static void mremap_expand_merge(unsigned long page_size)
+{
+	char *test_name = "mremap expand merge";
+	bool success = false;
+	int errsv = 0;
+	char *remap;
+	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (start == MAP_FAILED) {
+		errsv = errno;
+		goto error;
+	}
+
+	munmap(start + page_size, page_size);
+	remap = mremap(start, page_size, 2 * page_size, 0);
+	if (remap == MAP_FAILED) {
+		errsv = errno;
+		munmap(start, page_size);
+		munmap(start + 2 * page_size, page_size);
+		goto error;
+	}
+
+	success = is_range_mapped(start, start + 3 * page_size);
+
+	munmap(start, 3 * page_size);
+	goto out;
+
+error:
+	ksft_print_msg("Unexpected mapping/remapping error: %s\n",
+		       strerror(errsv));
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
+static void mremap_expand_merge_offset(unsigned long page_size)
+{
+
+	char *test_name = "mremap expand merge offset";
+	bool success = false;
+	int errsv = 0;
+	char *remap;
+	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (start == MAP_FAILED) {
+		errsv = errno;
+		goto error;
+	}
+
+	/* Unmap final page to ensure we have space to expand. */
+	munmap(start + 2 * page_size, page_size);
+	remap = mremap(start + page_size, page_size, 2 * page_size, 0);
+	if (remap == MAP_FAILED) {
+		errsv = errno;
+		munmap(start, 2 * page_size);
+		goto error;
+	}
+
+	success = is_range_mapped(start, start + 3 * page_size);
+	goto out;
+
+error:
+	ksft_print_msg("Unexpected mapping/remapping error: %s\n",
+		       strerror(errsv));
+out:
 	if (success)
 		ksft_test_result_pass("%s\n", test_name);
 	else
 		ksft_test_result_fail("%s\n", test_name);
-	fclose(fp);
 }

 /*
@@ -459,6 +533,7 @@ int main(int argc, char **argv)
 				     pattern_seed);

 	mremap_expand_merge(page_size);
+	mremap_expand_merge_offset(page_size);

 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
--
2.38.1
