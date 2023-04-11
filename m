Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F226DE04E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDKQBy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDKQBY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:01:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8D049FA
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681228882; x=1712764882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2C6HVcldbHRC+EVsJimv+eCkqn6k5GMHuuTW5O2y7c=;
  b=XtkDT+bTivN1Et0W0A9obcHTL1JZ2rYCbwIyVOHyt9+HcbddydJgRdcN
   kcoZzZ1Oxsktu2oTxbaXLTQj5nWSkUlAd59JOGn3Z4D5yul3B5oc+tFGy
   MP5QDTm2cjScNUalyE9EVDsYt320al7hb6UQDHO8DhanVnDuGPblbR/1V
   tAFySuNXgQhL3VDUmMPqwsKxkYjpBmUqonQ0hlQn56UnWficFh1IQ2hQ6
   wA9I44wV3QE1i8BNn23/MbD9AeloxxpBKvLBW3BKqT6V6A3HcEIFqGuGx
   V4NlXZEFqF0XRLcSrEx3N12NxPwacLp/j5XWb9mFNfTwUWRO/wr2VJ7cC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="341149064"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341149064"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:01:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="777972291"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="777972291"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.133.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:01:15 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH 1/3] kunit/test: Add example test showing parameterized testing
Date:   Tue, 11 Apr 2023 18:00:54 +0200
Message-Id: <20230411160056.1586-2-michal.wajdeczko@intel.com>
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

Use of parameterized testing is documented [1] but such use case
is not present in demo kunit test. Add small subtest for that.

[1] https://kernel.org/doc/html/latest/dev-tools/kunit/usage.html#parameterized-testing

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
---
 lib/kunit/kunit-example-test.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index cd8b7e51d02b..775443f77763 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -167,6 +167,39 @@ static void example_static_stub_test(struct kunit *test)
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
@@ -183,6 +216,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_mark_skipped_test),
 	KUNIT_CASE(example_all_expect_macros_test),
 	KUNIT_CASE(example_static_stub_test),
+	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	{}
 };
 
-- 
2.25.1

