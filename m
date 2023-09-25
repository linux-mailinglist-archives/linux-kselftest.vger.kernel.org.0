Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318487ADE33
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjIYR6L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 13:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjIYR6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 13:58:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866BE1B0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695664680; x=1727200680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xGMeTT1k3Boz0PoAgFBIhfApJ6Bl/sQXlmU26NPL9aE=;
  b=RWMVVv9zX9Hd5GDJajtnFWkUJ0TwS+cchN0pdPRGYjmZKE4zHkcsuma8
   AVCmHJHRmXvwkA6YZ2q+HRfnE2eL/qugZMwp2lWXqJvPXQJy18ktF7yWL
   G+5PSWKBDFEpH5Xuvgg7wG1Y0A6YoRbWZ20gyfoFiwDwjg0dj1E5q3H9v
   zDLKbxyAbIiWkHj4TNfM4hxLKtU0goONCGuFc87mIstFOJ+1ZleaENJCW
   huI2NonPQQVJCLKGrLSlpU2ProKgjHGGggePB1gk5lVZQkGtcpSh9w4Z8
   ZUcRDUQZhoe6YCQNTSnUvLpvZfNIaySZsPnoCBFAs4kTmESdMdvFiV7O2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371643657"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="371643657"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995489286"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995489286"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.131.28])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:57:58 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH 3/4] kunit: Fix indentation of parameterized tests messages
Date:   Mon, 25 Sep 2023 19:57:32 +0200
Message-Id: <20230925175733.1379-4-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230925175733.1379-1-michal.wajdeczko@intel.com>
References: <20230925175733.1379-1-michal.wajdeczko@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running parametrized test cases, diagnostic messages
are not properly aligned with the test result lines:

    $ ./tools/testing/kunit/kunit.py run --raw_output \
        --kunitconfig ./lib/kunit/.kunitconfig *.example_params*

    KTAP version 1
    1..1
    # example: initializing suite
        KTAP version 1
        # Subtest: example
        # module: kunit_example_test
        1..1
            KTAP version 1
            # Subtest: example_params_test
        # example_params_test: initializing
        # example_params_test: cleaning up
            ok 1 example value 3 # SKIP unsupported param value 3
        # example_params_test: initializing
        # example_params_test: cleaning up
            ok 2 example value 2
        # example_params_test: initializing
        # example_params_test: cleaning up
            ok 3 example value 1
        # example_params_test: initializing
        # example_params_test: cleaning up
            ok 4 example value 0 # SKIP unsupported param value 0
        # example_params_test: pass:2 fail:0 skip:2 total:4
        ok 1 example_params_test
    # example: exiting suite
    # Totals: pass:2 fail:0 skip:2 total:4
    ok 1 example

Add test level attribute and use it to generate proper indent
at the runtime:

    KTAP version 1
    1..1
    # example: initializing suite
        KTAP version 1
        # Subtest: example
        # module: kunit_example_test
        1..1
            KTAP version 1
            # Subtest: example_params_test
            # example_params_test: initializing
            # example_params_test: cleaning up
            ok 1 example value 3 # SKIP unsupported param value 3
            # example_params_test: initializing
            # example_params_test: cleaning up
            ok 2 example value 2
            # example_params_test: initializing
            # example_params_test: cleaning up
            ok 3 example value 1
            # example_params_test: initializing
            # example_params_test: cleaning up
            ok 4 example value 0 # SKIP unsupported param value 0
        # example_params_test: pass:2 fail:0 skip:2 total:4
        ok 1 example_params_test
    # example: exiting suite
    # Totals: pass:2 fail:0 skip:2 total:4
    ok 1 example

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 include/kunit/test.h |  3 ++-
 lib/kunit/test.c     | 52 ++++++++++++++++++++------------------------
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 158876c4cb43..4804d539e10f 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -276,6 +276,7 @@ struct kunit {
 	void *priv;
 
 	/* private: internal use only. */
+	unsigned int level; /* Helps in proper log indent */
 	const char *name; /* Read only after initialization! */
 	struct string_stream *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
@@ -519,7 +520,7 @@ enum {
 #define kunit_level(test_or_suite)					\
 	_Generic((test_or_suite),					\
 		 struct kunit_suite * : KUNIT_LEVEL_SUITE,		\
-		 struct kunit * : KUNIT_LEVEL_CASE)
+		 struct kunit * : ((struct kunit *)(test_or_suite))->level)
 
 #define kunit_indent_level(test_or_suite)				\
 	(KUNIT_INDENT_LEN * kunit_level(test_or_suite))
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d10e6d610e20..43c3efc286e4 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -99,14 +99,13 @@ static void kunit_print_test_stats(struct kunit *test,
 	if (!kunit_should_print_stats(stats))
 		return;
 
-	kunit_log(KERN_INFO, test,
-		  KUNIT_SUBTEST_INDENT
-		  "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
-		  test->name,
-		  stats.passed,
-		  stats.failed,
-		  stats.skipped,
-		  stats.total);
+	kunit_log_indent(KERN_INFO, test,
+			 "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
+			 test->name,
+			 stats.passed,
+			 stats.failed,
+			 stats.skipped,
+			 stats.total);
 }
 
 /* Append formatted message to log. */
@@ -154,7 +153,6 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
 }
 
 static void kunit_print_ok_not_ok(struct kunit *test,
-				  unsigned int test_level,
 				  enum kunit_status status,
 				  size_t test_number,
 				  const char *description,
@@ -163,12 +161,6 @@ static void kunit_print_ok_not_ok(struct kunit *test,
 	const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP " : "";
 	const char *directive_body = (status == KUNIT_SKIPPED) ? directive : "";
 
-	/*
-	 * When test is NULL assume that results are from the suite
-	 * and today suite results are expected at level 0 only.
-	 */
-	WARN(!test && test_level, "suite test level can't be %u!\n", test_level);
-
 	/*
 	 * We do not log the test suite results as doing so would
 	 * mean debugfs display would consist of an incorrect test
@@ -182,12 +174,11 @@ static void kunit_print_ok_not_ok(struct kunit *test,
 			test_number, description, directive_header,
 			directive_body);
 	else
-		kunit_log(KERN_INFO, test,
-			  "%*s%s %zd %s%s%s",
-			  KUNIT_INDENT_LEN * test_level, "",
-			  kunit_status_to_ok_not_ok(status),
-			  test_number, description, directive_header,
-			  directive_body);
+		kunit_log_indent(KERN_INFO, test,
+				 "%s %zd %s%s%s",
+				 kunit_status_to_ok_not_ok(status),
+				 test_number, description, directive_header,
+				 directive_body);
 }
 
 enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
@@ -213,7 +204,7 @@ static size_t kunit_suite_counter = 1;
 
 static void kunit_print_suite_end(struct kunit_suite *suite)
 {
-	kunit_print_ok_not_ok(NULL, KUNIT_LEVEL_SUITE,
+	kunit_print_ok_not_ok(NULL,
 			      kunit_suite_has_succeeded(suite),
 			      kunit_suite_counter++,
 			      suite->name,
@@ -322,6 +313,7 @@ void kunit_init_test(struct kunit *test, const char *name, struct string_stream
 {
 	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
+	test->level = KUNIT_LEVEL_CASE;
 	test->name = name;
 	test->log = log;
 	if (test->log)
@@ -584,14 +576,15 @@ int kunit_run_tests(struct kunit_suite *suite)
 			kunit_run_case_catch_errors(suite, test_case, &test);
 			kunit_update_stats(&param_stats, test.status);
 		} else {
+			/* Parameterized test is one level up from simple test-case. */
+			test.level++;
+
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			test.param_value = test_case->generate_params(NULL, param_desc);
 			test_case->status = KUNIT_SKIPPED;
-			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
-				  "KTAP version 1\n");
-			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
-				  "# Subtest: %s", test_case->name);
+			kunit_log_indent(KERN_INFO, &test, "KTAP version 1\n");
+			kunit_log_indent(KERN_INFO, &test, "# Subtest: %s", test_case->name);
 
 			while (test.param_value) {
 				kunit_run_case_catch_errors(suite, test_case, &test);
@@ -601,7 +594,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 						 "param-%d", test.param_index);
 				}
 
-				kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE_PARAM,
+				kunit_print_ok_not_ok(&test,
 						      test.status,
 						      test.param_index + 1,
 						      param_desc,
@@ -616,13 +609,16 @@ int kunit_run_tests(struct kunit_suite *suite)
 				test.status = KUNIT_SUCCESS;
 				test.status_comment[0] = '\0';
 			}
+
+			/* Return to parent (test-case) level. */
+			test.level--;
 		}
 
 		kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
 
 		kunit_print_test_stats(&test, param_stats);
 
-		kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE, test_case->status,
+		kunit_print_ok_not_ok(&test, test_case->status,
 				      kunit_test_case_num(suite, test_case),
 				      test_case->name,
 				      test.status_comment);
-- 
2.25.1

