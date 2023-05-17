Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7070668B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 13:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjEQLUe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 07:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjEQLUd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 07:20:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F41103
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 04:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684322433; x=1715858433;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=FzGWov9BBJvwViTRy8xFbr/fsg+jM+ytcaLpUaA0EIo=;
  b=UXQZqFLpqHTUO2FjCYyv+6j3dmyZZ1ht2Uh407xtUWPT+1PI/CYoloBX
   qi2RWwXK9lKcwM7xHgfoyiMqikVTUNu0wzz0e4fd0ZkKkOlsKCeXWDbFY
   +mWihr13yFrrfhwfp97z1GamcPgBmrIJooN9URP2GndfrTmVJhJOZh3YX
   OUBBDmjUF9PMIGuMJhTNI9dgYFCkFq8Lnt0Tv3g2xu3A/VX5s05Jv5NdI
   yAXEh7wAiSik5KwtVzp9MD1TWaglDILjbP/gFZs7K6hrSTC7D/PEGSTIl
   +ZY3lFWMxrcJLXwcilSkJqCL6zTJcE2GcZXVJ+N1F6yIAKe5PWroAgdYr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="341115904"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="341115904"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 04:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="766738735"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="766738735"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.142.110])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 04:20:30 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v3 1/3] kunit/test: Add example test showing parameterized testing
Date:   Wed, 17 May 2023 13:18:14 +0200
Message-Id: <20230517111816.984-2-michal.wajdeczko@intel.com>
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

Use of parameterized testing is documented [1] but such use case
is not present in demo kunit test. Add small subtest for that.

[1] https://kernel.org/doc/html/latest/dev-tools/kunit/usage.html#parameterized-testing

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/kunit/kunit-example-test.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 24315c882b31..b69b689ea850 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -187,6 +187,39 @@ static void example_static_stub_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, add_one(1), 2);
 }
 
+static const struct example_param {
+	int value;
+} example_params_array[] = {
+	{ .value = 2, },
+	{ .value = 1, },
+	{ .value = 0, },
+};
+
+static void example_param_get_desc(const struct example_param *p, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "example value %d", p->value);
+}
+
+KUNIT_ARRAY_PARAM(example, example_params_array, example_param_get_desc);
+
+/*
+ * This test shows the use of params.
+ */
+static void example_params_test(struct kunit *test)
+{
+	const struct example_param *param = test->param_value;
+
+	/* By design, param pointer will not be NULL */
+	KUNIT_ASSERT_NOT_NULL(test, param);
+
+	/* Test can be skipped on unsupported param values */
+	if (!param->value)
+		kunit_skip(test, "unsupported param value");
+
+	/* You can use param values for parameterized testing */
+	KUNIT_EXPECT_EQ(test, param->value % param->value, 0);
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -203,6 +236,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_mark_skipped_test),
 	KUNIT_CASE(example_all_expect_macros_test),
 	KUNIT_CASE(example_static_stub_test),
+	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	{}
 };
 
-- 
2.25.1

