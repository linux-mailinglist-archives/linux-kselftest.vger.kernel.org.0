Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16037ADE32
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjIYR6K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjIYR6G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 13:58:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157B1A7
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695664678; x=1727200678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZYYgPqw7ohm87675/5XKWP5wf2DjbWIEkF5V01oH7M=;
  b=EZo3ekO5VuaUIbr+pkkdafBPYJx0mX4nlqgGRPpycyFltI98qOBkZTV6
   Yy3pCOhp9KTTYF06y6y9dLxCSM+wfOtRjFOjqG6yY1aPrHaeaDKhTB46p
   VWt/gVde1n9fjcaD4+PHx//chmKvET2jneEy1GMWDSBcw6nT0KRkTGs0M
   RudbFv5kpGHJMytMEscZMOrNDMr416aFU00jipgVB50HvmaUBQcwShrWW
   hPULOktK3E0gvlKRHE5kY5kJ0j0H3H1OiposCJ4vk0KGH1Fp8iL/geLZl
   HLtnwfgWVX5SeRN9k/RrhzYAlJcin5QEgn0eQJHoOEFoTt1nkfVbw89tx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371643653"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="371643653"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:57:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995489273"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995489273"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.131.28])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:57:56 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH 2/4] kunit: Fix indentation level of suite messages
Date:   Mon, 25 Sep 2023 19:57:31 +0200
Message-Id: <20230925175733.1379-3-michal.wajdeczko@intel.com>
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

A kunit suite is a top level test from the KTAP point of view but
all suite diagnostic messages are printed at the subtest level:

    $ ./tools/testing/kunit/kunit.py run --raw_output \
        --kunitconfig ./lib/kunit/.kunitconfig "example.*simple*"

    KTAP version 1
    1..1
        # example: initializing suite
        # example: failed to initialize (-ENODEV)
    not ok 1 example

    KTAP version 1
    1..1
        # example: initializing suite
        KTAP version 1
        # Subtest: example
        # module: kunit_example_test
        1..1
        # example_simple_test: initializing
        # example_simple_test: cleaning up
        ok 1 example_simple_test
        # example: exiting suite
    ok 1 example

Replace hardcoded indent in kunit_printk() with flexible
indentation based on the argument type (test or suite):

    KTAP version 1
    1..1
    # example: initializing suite
    # example: failed to initialize (-ENODEV)
    not ok 1 example

    KTAP version 1
    1..1
    # example: initializing suite
        KTAP version 1
        # Subtest: example
        # module: kunit_example_test
        1..1
        # example_simple_test: initializing
        # example_simple_test: cleaning up
        ok 1 example_simple_test
    # example: exiting suite
    ok 1 example

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 include/kunit/test.h | 24 ++++++++++++++++++++++--
 lib/kunit/test.c     |  7 -------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 20ed9f9275c9..158876c4cb43 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -509,6 +509,21 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
 		kunit_try_catch_throw(&((test_or_suite)->try_catch));	\
 	} while (0)
 
+/* Currently supported test levels */
+enum {
+	KUNIT_LEVEL_SUITE = 0,
+	KUNIT_LEVEL_CASE,
+	KUNIT_LEVEL_CASE_PARAM,
+};
+
+#define kunit_level(test_or_suite)					\
+	_Generic((test_or_suite),					\
+		 struct kunit_suite * : KUNIT_LEVEL_SUITE,		\
+		 struct kunit * : KUNIT_LEVEL_CASE)
+
+#define kunit_indent_level(test_or_suite)				\
+	(KUNIT_INDENT_LEN * kunit_level(test_or_suite))
+
 /*
  * printk and log to per-test or per-suite log buffer.  Logging only done
  * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
@@ -520,9 +535,14 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
 				 ##__VA_ARGS__);			\
 	} while (0)
 
+#define kunit_log_indent(lvl, test_or_suite, fmt, ...)			\
+	kunit_log(lvl, test_or_suite, "%*s" fmt,			\
+		  kunit_indent_level(test_or_suite), "",		\
+		  ##__VA_ARGS__)
+
 #define kunit_printk(lvl, test, fmt, ...)				\
-	kunit_log(lvl, test, KUNIT_SUBTEST_INDENT "# %s: " fmt,		\
-		  (test)->name,	##__VA_ARGS__)
+	kunit_log_indent(lvl, test, "# %s: " fmt,			\
+			 (test)->name, ##__VA_ARGS__)
 
 /**
  * kunit_info() - Prints an INFO level message associated with @test.
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index fb5981ce578d..d10e6d610e20 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -135,13 +135,6 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
 }
 EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
-/* Currently supported test levels */
-enum {
-	KUNIT_LEVEL_SUITE = 0,
-	KUNIT_LEVEL_CASE,
-	KUNIT_LEVEL_CASE_PARAM,
-};
-
 static void kunit_print_suite_start(struct kunit_suite *suite)
 {
 	/*
-- 
2.25.1

