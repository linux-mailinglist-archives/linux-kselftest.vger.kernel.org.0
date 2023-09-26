Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E277AF62A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 00:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjIZWLU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 18:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjIZWIG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 18:08:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76C023116
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 15:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695765990; x=1727301990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m9qJycA1kn4jS+QWIXatNj97IDwr99dqBHE2Ay4WqrU=;
  b=bP0FtCC3hAGIXGBMVOZBz+ZQolrvE3G49cl4Tuz7KAWTeuM+035DNn7Z
   D51E/YsL0fL4q17Gp0boqZs11/oD5/DLqbMGmIKbA1zFbyEHysU3kMbnw
   5mYLrHk4+H0Ym8WEdTBMnkT4r4OUkHSaPhEuH+5GTdEouzF0tkGdZAAoa
   S0m15Lklm9ku4dUQRqwoAE4Ok12pO+2ih34fVUcFygXwQFkgCpkmjV43G
   vFDvu8sbTwy6bIqg3lsctPvcDjxD4xLJw1JYorI9TtBKnyrdB4ZAvJx9j
   boNKob7pmKSQ7cB15/M/32Tjey+h0T+mROZqSdLNTmJVFQ2PuHrclHLC9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445807352"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="445807352"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 15:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="922577739"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="922577739"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.130.252])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 15:02:22 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH 2/2] kunit: Allow to filter entries from zero terminated arrays
Date:   Wed, 27 Sep 2023 00:02:08 +0200
Message-Id: <20230926220208.1423-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230926220208.1423-1-michal.wajdeczko@intel.com>
References: <20230926220208.1423-1-michal.wajdeczko@intel.com>
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

In some cases we may want to generate params based on existing
zero terminated array, but with some entries filtered out.
Extend macro KUNIT_ZERO_ARRAY_PARAM to accept filter function
and provide example how to use it.

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
[ ] =================== example_params_test  ===================
[ ] [PASSED] example value 2
[ ] [PASSED] example value 1
[ ] =============== [PASSED] example_params_test ===============
[ ] ===================== [PASSED] example =====================
[ ] ============================================================
[ ] Testing complete. Ran 9 tests: passed: 6, skipped: 3

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 include/kunit/test.h           | 19 +++++++++++++++++--
 lib/kunit/kunit-example-test.c |  9 +++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 280113ceb6a6..8a87d1ce37e0 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1515,20 +1515,24 @@ do {									       \
 	}
 
 /**
- * KUNIT_ZERO_ARRAY_PARAM() - Define test parameter generator from a zero terminated array.
+ * KUNIT_FILTERED_ZERO_ARRAY_PARAM() - Define test parameter generator from a zero terminated array.
  * @name:  prefix for the test parameter generator function.
  * @array: zero terminated array of test parameters.
  * @get_desc: function to convert param to description; NULL to use default
+ * @filter: function to filter out unwanted params (like duplicates); can be NULL
  *
  * Define function @name_gen_params which uses zero terminated @array to generate parameters.
  */
-#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc)						\
+#define KUNIT_FILTERED_ZERO_ARRAY_PARAM(name, array, get_desc, filter)				\
 	static const void *name##_gen_params(const void *prev, char *desc)			\
 	{											\
 		typeof((array)[0]) *__prev = prev;						\
 		typeof(__prev) __next = __prev ? __prev + 1 : (array);				\
 		void (*__get_desc)(typeof(__next), char *) = get_desc;				\
+		bool (*__filter)(typeof(__prev), typeof(__next)) = filter;			\
 		for (; memchr_inv(__next, 0, sizeof(*__next)); __prev = __next++) {		\
+			if (__filter && !__filter(__prev, __next))				\
+				continue;							\
 			if (__get_desc)								\
 				__get_desc(__next, desc);					\
 			return __next;								\
@@ -1536,6 +1540,17 @@ do {									       \
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
+#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc)	\
+	KUNIT_FILTERED_ZERO_ARRAY_PARAM(name, array, get_desc, NULL)
+
 // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
 // include resource.h themselves if they need it.
 #include <kunit/resource.h>
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index ad9ebcfd513e..a3268754392c 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -201,8 +201,16 @@ static void example_param_get_desc(const struct example_param *p, char *desc)
 	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "example value %d", p->value);
 }
 
+static bool example_param_filter(const struct example_param *prev,
+				 const struct example_param *next)
+{
+	return next->value < 3;
+}
+
 KUNIT_ARRAY_PARAM(example, example_params_array, example_param_get_desc);
 KUNIT_ZERO_ARRAY_PARAM(example_zero, example_params_array, example_param_get_desc);
+KUNIT_FILTERED_ZERO_ARRAY_PARAM(example_filter, example_params_array, example_param_get_desc,
+				example_param_filter);
 
 /*
  * This test shows the use of params.
@@ -248,6 +256,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_static_stub_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_PARAM(example_params_test, example_zero_gen_params),
+	KUNIT_CASE_PARAM(example_params_test, example_filter_gen_params),
 	KUNIT_CASE_SLOW(example_slow_test),
 	{}
 };
-- 
2.25.1

