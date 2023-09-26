Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92867AF62B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 00:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjIZWLV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 18:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbjIZWH7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 18:07:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9964C23115
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 15:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695765989; x=1727301989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1ok+L+LOTtUHmGuHNZmLVlkROpzhHF/CcKWPXy2X6fM=;
  b=ltGPqi9M3c7pX4Pl3flakoG/rrK2gMZx8nbR0d6N+E5+yQPH4sVtQSSp
   ypeLlLD5uCU+jgUGLzxefBDTxN61MvIRscjKR8QT0zNGpYD3MerQviX5A
   fdClo+N1odPyOQH6OfPC49oYTDBHKe8sGWA4v7zqU60pvloX5JYmwtPoT
   OGN3q6Bwn8GJFynHnPPvzz+SN3Q+Ijz5SpQaml6yAi0lyFfAy/2t2cYm2
   SrlNh2IOhjIsp5KdiSjBjqJ5k7YA1J9OXrYU2ARKoWq2TyoccYYOJLzWb
   msuB4L1uhoOW1ZSu0g2Aj0ER8QM3cpE/iq+tHMOQGVqIunuiNK+nA2F7C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445807339"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="445807339"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 15:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="922577734"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="922577734"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.130.252])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 15:02:21 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH 1/2] kunit: Add param generator macro for zero terminated arrays
Date:   Wed, 27 Sep 2023 00:02:07 +0200
Message-Id: <20230926220208.1423-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The existing macro KUNIT_ARRAY_PARAM can produce parameter
generator function but only when we fully know the definition
of the array. However, there might be cases where we would like
to generate test params based on externaly defined array, which
is defined as zero-terminated array, like pci_driver.id_table.

Add helper macro KUNIT_ZERO_ARRAY_PARAM that can work with zero
terminated arrays and provide example how to use it.

$ ./tools/testing/kunit/kunit.py run \
	--kunitconfig ./lib/kunit/.kunitconfig *.example_params*

[ ] Starting KUnit Kernel (1/1)...
[ ] ============================================================
[ ] ========================= example  =========================
[ ] =================== example_params_test  ===================
[ ] [SKIPPED] example value 3
[ ] [PASSED] example value 2
[ ] [PASSED] example value 1
[ ] [SKIPPED] example value 0
[ ] =============== [PASSED] example_params_test ===============
[ ] =================== example_params_test  ===================
[ ] [SKIPPED] example value 3
[ ] [PASSED] example value 2
[ ] [PASSED] example value 1
[ ] =============== [PASSED] example_params_test ===============
[ ] ===================== [PASSED] example =====================
[ ] ============================================================
[ ] Testing complete. Ran 7 tests: passed: 4, skipped: 3

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 include/kunit/test.h           | 22 ++++++++++++++++++++++
 lib/kunit/kunit-example-test.c |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 20ed9f9275c9..280113ceb6a6 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1514,6 +1514,28 @@ do {									       \
 		return NULL;									\
 	}
 
+/**
+ * KUNIT_ZERO_ARRAY_PARAM() - Define test parameter generator from a zero terminated array.
+ * @name:  prefix for the test parameter generator function.
+ * @array: zero terminated array of test parameters.
+ * @get_desc: function to convert param to description; NULL to use default
+ *
+ * Define function @name_gen_params which uses zero terminated @array to generate parameters.
+ */
+#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc)						\
+	static const void *name##_gen_params(const void *prev, char *desc)			\
+	{											\
+		typeof((array)[0]) *__prev = prev;						\
+		typeof(__prev) __next = __prev ? __prev + 1 : (array);				\
+		void (*__get_desc)(typeof(__next), char *) = get_desc;				\
+		for (; memchr_inv(__next, 0, sizeof(*__next)); __prev = __next++) {		\
+			if (__get_desc)								\
+				__get_desc(__next, desc);					\
+			return __next;								\
+		}										\
+		return NULL;									\
+	}
+
 // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
 // include resource.h themselves if they need it.
 #include <kunit/resource.h>
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 6bb5c2ef6696..ad9ebcfd513e 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -202,6 +202,7 @@ static void example_param_get_desc(const struct example_param *p, char *desc)
 }
 
 KUNIT_ARRAY_PARAM(example, example_params_array, example_param_get_desc);
+KUNIT_ZERO_ARRAY_PARAM(example_zero, example_params_array, example_param_get_desc);
 
 /*
  * This test shows the use of params.
@@ -246,6 +247,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_all_expect_macros_test),
 	KUNIT_CASE(example_static_stub_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
+	KUNIT_CASE_PARAM(example_params_test, example_zero_gen_params),
 	KUNIT_CASE_SLOW(example_slow_test),
 	{}
 };
-- 
2.25.1

