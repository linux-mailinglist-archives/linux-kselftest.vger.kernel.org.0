Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694226E270C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjDNPbG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 11:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDNPbE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 11:31:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC286AD
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681486240; x=1713022240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cZ93iHPQwILXaR5w6wvi8uMBss1dq/5A5wY4aSGJSdU=;
  b=iymu/fUbq7VbwhwgbQyQxTKHxMZ4HyJXeXvCCQh1o+t32AWvRw3d9sJQ
   nGNt9/HG+6yQenD37lMk4llszy0zUQdqeavIK0vBJyu0+fxBMC+HEVSZU
   etsfSHX0BM3vbFNefRsGadlkjSjEvmYadeno9qVcN0YyRuxELGdj8Aprx
   t9WYmuxgEvzS1z8ZS/ww5iMlj+WipeykztYZ3r/Meg78RehEEc0++qt2f
   6PL6Jid9DELvF2uY61iPIJKMyCA+52Z+ekfmZvi2PZjZ1h++yOHnlRvyF
   8tsE7w+l4+3yNkSN8n576L8H1b4ZAS+vmEqny/b6zLM/mnaHEa1jk8gSD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="341985956"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="341985956"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 08:28:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="759138736"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="759138736"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.157.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 08:28:13 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v2 3/3] kunit: Update kunit_print_ok_not_ok function
Date:   Fri, 14 Apr 2023 17:27:37 +0200
Message-Id: <20230414152737.1630-4-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230414152737.1630-1-michal.wajdeczko@intel.com>
References: <20230414152737.1630-1-michal.wajdeczko@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no need use opaque test_or_suite pointer and is_test flag
as we don't use anything from the suite struct. Always expect test
pointer and use NULL as indication that provided results are from
the suite so we can treat them differently.

Since results could be from nested tests, like parameterized tests,
add explicit level parameter to properly indent output messages and
thus allow to reuse this function from other places.

While around, remove small code duplication near skip directive.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 include/kunit/test.h |  1 +
 lib/kunit/test.c     | 45 +++++++++++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 08d3559dd703..5e5af167e7f8 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -47,6 +47,7 @@ struct kunit;
  * sub-subtest.  See the "Subtests" section in
  * https://node-tap.org/tap-protocol/
  */
+#define KUNIT_INDENT_LEN		4
 #define KUNIT_SUBTEST_INDENT		"    "
 #define KUNIT_SUBSUBTEST_INDENT		"        "
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 5679197b5f8a..ca636c9f793c 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -154,16 +154,28 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
 		  kunit_suite_num_test_cases(suite));
 }
 
-static void kunit_print_ok_not_ok(void *test_or_suite,
-				  bool is_test,
+/* Currently supported test levels */
+enum {
+	KUNIT_LEVEL_SUITE = 0,
+	KUNIT_LEVEL_CASE,
+	KUNIT_LEVEL_CASE_PARAM,
+};
+
+static void kunit_print_ok_not_ok(struct kunit *test,
+				  unsigned int test_level,
 				  enum kunit_status status,
 				  size_t test_number,
 				  const char *description,
 				  const char *directive)
 {
-	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
-	struct kunit *test = is_test ? test_or_suite : NULL;
 	const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP " : "";
+	const char *directive_body = (status == KUNIT_SKIPPED) ? directive : "";
+
+	/*
+	 * When test is NULL assume that results are from the suite
+	 * and today suite results are expected at level 0 only.
+	 */
+	WARN(!test && test_level, "suite test level can't be %u!\n", test_level);
 
 	/*
 	 * We do not log the test suite results as doing so would
@@ -173,17 +185,18 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 	 * separately seq_printf() the suite status for the debugfs
 	 * representation.
 	 */
-	if (suite)
+	if (!test)
 		pr_info("%s %zd %s%s%s\n",
 			kunit_status_to_ok_not_ok(status),
 			test_number, description, directive_header,
-			(status == KUNIT_SKIPPED) ? directive : "");
+			directive_body);
 	else
 		kunit_log(KERN_INFO, test,
-			  KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
+			  "%*s%s %zd %s%s%s",
+			  KUNIT_INDENT_LEN * test_level, "",
 			  kunit_status_to_ok_not_ok(status),
 			  test_number, description, directive_header,
-			  (status == KUNIT_SKIPPED) ? directive : "");
+			  directive_body);
 }
 
 enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
@@ -209,7 +222,7 @@ static size_t kunit_suite_counter = 1;
 
 static void kunit_print_suite_end(struct kunit_suite *suite)
 {
-	kunit_print_ok_not_ok((void *)suite, false,
+	kunit_print_ok_not_ok(NULL, KUNIT_LEVEL_SUITE,
 			      kunit_suite_has_succeeded(suite),
 			      kunit_suite_counter++,
 			      suite->name,
@@ -554,13 +567,11 @@ int kunit_run_tests(struct kunit_suite *suite)
 						 "param-%d", test.param_index);
 				}
 
-				kunit_log(KERN_INFO, &test,
-					  KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
-					  "%s %d %s%s%s",
-					  kunit_status_to_ok_not_ok(test.status),
-					  test.param_index + 1, param_desc,
-					  test.status == KUNIT_SKIPPED ? " # SKIP " : "",
-					  test.status == KUNIT_SKIPPED ? test.status_comment : "");
+				kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE_PARAM,
+						      test.status,
+						      test.param_index + 1,
+						      param_desc,
+						      test.status_comment);
 
 				/* Get next param. */
 				param_desc[0] = '\0';
@@ -574,7 +585,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 		kunit_print_test_stats(&test, param_stats);
 
-		kunit_print_ok_not_ok(&test, true, test_case->status,
+		kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE, test_case->status,
 				      kunit_test_case_num(suite, test_case),
 				      test_case->name,
 				      test.status_comment);
-- 
2.25.1

