Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747806DE050
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDKQBz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjDKQBY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:01:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021FC3594
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681228882; x=1712764882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8h9zsN6Q/5dlNLUFk19BumoHl+8mwQn+6CuUCd7CzaI=;
  b=CdaowFB8id1DSm3+Hssvd+r9H4H3GnQLiE8jt9gDr6r8J+gNKMF22PNy
   dCRVAQ1Z9WVpvJ+d3gZOs+Z3i0MW2yKz5j0L5yYUi7Nj6ejAEjYtfQLRf
   e16DUWYKN4ZUgH9Z+85wF//5rAzlOGPw67FVxZeLhjgaiCe+m/ANPc1d4
   2EpEpnYogdJxoLAeGkYiZd1aSk9H70G2hi+EOwhgxsHBwq1EdJCUukVGl
   3qhYcEYqhMlJUZXVSiv9megwqLtDs863X86PHHIDKS2zGTusq3JFdaPC1
   YPJYFNqHm8AaCoRYMCJcOQYtX5gTPcY45cnz17mnzavvcgrn7NTdk0N+/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="341149085"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341149085"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="777972316"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="777972316"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.133.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:01:18 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH 3/3] kunit: Update reporting function to support results from subtests
Date:   Tue, 11 Apr 2023 18:00:56 +0200
Message-Id: <20230411160056.1586-4-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230411160056.1586-1-michal.wajdeczko@intel.com>
References: <20230411160056.1586-1-michal.wajdeczko@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is function to report status of either suite or test, but it
doesn't support parameterized subtests that have to log report on
its own. Extend it to also accept subtest level results to avoid
code duplication.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
---
 lib/kunit/test.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 5679197b5f8a..692fce258c5b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -154,8 +154,14 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
 		  kunit_suite_num_test_cases(suite));
 }
 
+enum kunit_test_or_suite {
+	KUNIT_SUITE = 0,
+	KUNIT_TEST,
+	KUNIT_SUBTEST,
+};
+
 static void kunit_print_ok_not_ok(void *test_or_suite,
-				  bool is_test,
+				  enum kunit_test_or_suite is_test,
 				  enum kunit_status status,
 				  size_t test_number,
 				  const char *description,
@@ -180,7 +186,9 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 			(status == KUNIT_SKIPPED) ? directive : "");
 	else
 		kunit_log(KERN_INFO, test,
-			  KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
+			  "%.*s%s %zd %s%s%s",
+			  (int) strlen(KUNIT_SUBTEST_INDENT) * is_test,
+			  KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT,
 			  kunit_status_to_ok_not_ok(status),
 			  test_number, description, directive_header,
 			  (status == KUNIT_SKIPPED) ? directive : "");
@@ -209,7 +217,7 @@ static size_t kunit_suite_counter = 1;
 
 static void kunit_print_suite_end(struct kunit_suite *suite)
 {
-	kunit_print_ok_not_ok((void *)suite, false,
+	kunit_print_ok_not_ok((void *)suite, KUNIT_SUITE,
 			      kunit_suite_has_succeeded(suite),
 			      kunit_suite_counter++,
 			      suite->name,
@@ -554,13 +562,11 @@ int kunit_run_tests(struct kunit_suite *suite)
 						 "param-%d", test.param_index);
 				}
 
-				kunit_log(KERN_INFO, &test,
-					  KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
-					  "%s %d %s%s%s",
-					  kunit_status_to_ok_not_ok(test.status),
-					  test.param_index + 1, param_desc,
-					  test.status == KUNIT_SKIPPED ? " # SKIP " : "",
-					  test.status == KUNIT_SKIPPED ? test.status_comment : "");
+				kunit_print_ok_not_ok(&test, KUNIT_SUBTEST,
+						      test.status,
+						      test.param_index + 1,
+						      param_desc,
+						      test.status_comment);
 
 				/* Get next param. */
 				param_desc[0] = '\0';
@@ -574,7 +580,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 		kunit_print_test_stats(&test, param_stats);
 
-		kunit_print_ok_not_ok(&test, true, test_case->status,
+		kunit_print_ok_not_ok(&test, KUNIT_TEST, test_case->status,
 				      kunit_test_case_num(suite, test_case),
 				      test_case->name,
 				      test.status_comment);
-- 
2.25.1

