Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D17ADE34
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjIYR6M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 13:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjIYR6I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 13:58:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9DD11D
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695664682; x=1727200682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=03C41OMffArkupQnMzMOXyeB8LKSiHhumuP6kOtlVCU=;
  b=LJfZ338Hm/tGUc6esvgMEHhLY11KRNpCEY7G4OtGKUVttmxwZy53jbak
   nhrzw3cJV70mAWdfUcAwN1zqmA5JEpBx/DYIn9i5gkI/Je5TEagIRNGfl
   gSjndp0mehIteLTBt2pmPU6j5fnfbI/PHkwf65tc85gtToP8qsG8rlYLr
   sRFfDngxXgde8J6cmjnqmyFzYlNX3iUT5BMV8NF2LStufVDYXetI2F+Aq
   +EMdsWbuQyUXzyLAAqbAC9F4Uj1TEycbpgjQ7M6j2mXN3bbdt5mlfDtlV
   am+VcjVYNeRfBy/DK8vBpLIDSkzzJHM+6z/MerIJaa6/aQPddlw6QSK0r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371643663"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="371643663"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995489289"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995489289"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.131.28])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:58:00 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH 4/4] kunit: Prepare test plan for parameterized subtests
Date:   Mon, 25 Sep 2023 19:57:33 +0200
Message-Id: <20230925175733.1379-5-michal.wajdeczko@intel.com>
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

In case of parameterized tests we are not providing a test plan
so we can't detect if any result is missing.

Count available params using the same generator as during a test
execution

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 43c3efc286e4..55eabb324f39 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -540,6 +540,20 @@ static void kunit_accumulate_stats(struct kunit_result_stats *total,
 	total->total += add.total;
 }
 
+static size_t count_test_case_params(struct kunit_case *test_case)
+{
+	char param_desc[KUNIT_PARAM_DESC_SIZE];
+	const void *param_value = NULL;
+	size_t num = 0;
+
+	if (test_case->generate_params)
+		while ((param_value = test_case->generate_params(param_value,
+								 param_desc)))
+			num++;
+
+	return num;
+}
+
 int kunit_run_tests(struct kunit_suite *suite)
 {
 	char param_desc[KUNIT_PARAM_DESC_SIZE];
@@ -585,6 +599,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 			test_case->status = KUNIT_SKIPPED;
 			kunit_log_indent(KERN_INFO, &test, "KTAP version 1\n");
 			kunit_log_indent(KERN_INFO, &test, "# Subtest: %s", test_case->name);
+			kunit_log_indent(KERN_INFO, &test, "1..%zd\n",
+					 count_test_case_params(test_case));
 
 			while (test.param_value) {
 				kunit_run_case_catch_errors(suite, test_case, &test);
-- 
2.25.1

