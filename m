Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E1A70668E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjEQLUh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 07:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjEQLUg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 07:20:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E130B212B
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684322434; x=1715858434;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GQucUMzI6Nkp4iPVZaB2quqORjlxJoX3GnCD93qSWnU=;
  b=hRAb3/+wasmXdExEuEvz2ENDtfqeOsu528vU83Z4PSJmgLZlkxOKrQKu
   N1PjMnoGqv6TB+gVFNLhmZHEVMOQlzTdmN+Bfv4LXhkw+8uvENh9glni+
   5TycKl95BgYoizq+4vVrylNh7efZijvqJulZOO2qEk4QH/a8RHQRsndeI
   M5aMspItoEnwNYVUPnQd8J4dZ+waXdFHM901rnFcqxgORoLGvQrwX1+lu
   uO6ig/L3t33niKWrgWepQBnqeBmCfqc+szjJmlbS6Ofsd/7kmJD/hfV05
   OCDisgSO0LIV/TdmUuwM+bsRo/3iJ3QikWO6V43f8E1PEsLhpg2PN6aGR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="341115918"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="341115918"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 04:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="766738752"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="766738752"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.142.110])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 04:20:32 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v3 3/3] kunit: Update kunit_print_ok_not_ok function
Date:   Wed, 17 May 2023 13:18:16 +0200
Message-Id: <20230517111816.984-4-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230517111816.984-1-michal.wajdeczko@intel.com>
References: <20230517111816.984-1-michal.wajdeczko@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 3028a1a3fcad..d717fc055e06 100644
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
index af48d0761d26..6bc92ced82ee 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -185,16 +185,28 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
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
@@ -203,17 +215,18 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 	 * separately seq_printf() the suite results for the debugfs
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
@@ -239,7 +252,7 @@ static size_t kunit_suite_counter = 1;
 
 static void kunit_print_suite_end(struct kunit_suite *suite)
 {
-	kunit_print_ok_not_ok((void *)suite, false,
+	kunit_print_ok_not_ok(NULL, KUNIT_LEVEL_SUITE,
 			      kunit_suite_has_succeeded(suite),
 			      kunit_suite_counter++,
 			      suite->name,
@@ -625,13 +638,11 @@ int kunit_run_tests(struct kunit_suite *suite)
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
@@ -645,7 +656,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 		kunit_print_test_stats(&test, param_stats);
 
-		kunit_print_ok_not_ok(&test, true, test_case->status,
+		kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE, test_case->status,
 				      kunit_test_case_num(suite, test_case),
 				      test_case->name,
 				      test.status_comment);
-- 
2.25.1

