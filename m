Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8207378F4D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 23:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347608AbjHaVtc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 17:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347619AbjHaVtc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 17:49:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1C10C4
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 14:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693518541; x=1725054541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SqBcxAVTdFb3GKEowzMxVfccdctFtipDtJFbZjSzcQg=;
  b=VPa6q5QzQq0RLfKyNI7xMZZmHr5g0j8uMYjLi8pmJ8j0vwehLj+iWu0n
   VOlqdd3cA352vkSWsdmXzZfZfGXBdXLNgD5f9D9BXZsxxs+w910DCTHta
   lZeWsPQHDnpvHnfgyHJCZaexDsEJmSUYLJ8fdvU9Ibwq726bMlaTBsuDn
   BNxkvuAMAFxwKRcjOWOGf17t/HiGrS9lkqi8tJ13w8j/FcjpMh7Dv5jlx
   UAedys2QfNObhy0OLIwptMZMOe4IppaYBE7jff4dWOvWozyycoSlMRq/2
   cuYWBwxTKvJgM126ZCLNqaHWSMgLupQ35gHU13grwGfIYzJ8qTMhjyAI4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366300433"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="366300433"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 14:49:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986417242"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="986417242"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.135.36])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 14:48:59 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH] kunit: Reset test status on each param iteration
Date:   Thu, 31 Aug 2023 23:48:47 +0200
Message-Id: <20230831214847.209-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
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

If we skip one parametrized test case then test status remains
SKIP for all subsequent test params leading to wrong reports:

$ ./tools/testing/kunit/kunit.py run \
	--kunitconfig ./lib/kunit/.kunitconfig *.example_params*
	--raw_output \

[ ] Starting KUnit Kernel (1/1)...
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
        ok 2 example value 2 # SKIP unsupported param value 3
    # example_params_test: initializing
    # example_params_test: cleaning up
        ok 3 example value 1 # SKIP unsupported param value 3
    # example_params_test: initializing
    # example_params_test: cleaning up
        ok 4 example value 0 # SKIP unsupported param value 0
    # example_params_test: pass:0 fail:0 skip:4 total:4
    ok 1 example_params_test # SKIP unsupported param value 0
    # example: exiting suite
ok 1 example # SKIP

Reset test status and status comment after each param iteration
to avoid using stale results.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/kunit-example-test.c | 5 +++--
 lib/kunit/test.c               | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 01a769f35e1d..6bb5c2ef6696 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -190,6 +190,7 @@ static void example_static_stub_test(struct kunit *test)
 static const struct example_param {
 	int value;
 } example_params_array[] = {
+	{ .value = 3, },
 	{ .value = 2, },
 	{ .value = 1, },
 	{ .value = 0, },
@@ -213,8 +214,8 @@ static void example_params_test(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, param);
 
 	/* Test can be skipped on unsupported param values */
-	if (!param->value)
-		kunit_skip(test, "unsupported param value");
+	if (!is_power_of_2(param->value))
+		kunit_skip(test, "unsupported param value %d", param->value);
 
 	/* You can use param values for parameterized testing */
 	KUNIT_EXPECT_EQ(test, param->value % param->value, 0);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 49698a168437..a53fd7e6d5bf 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -648,12 +648,14 @@ int kunit_run_tests(struct kunit_suite *suite)
 						      param_desc,
 						      test.status_comment);
 
+				kunit_update_stats(&param_stats, test.status);
+
 				/* Get next param. */
 				param_desc[0] = '\0';
 				test.param_value = test_case->generate_params(test.param_value, param_desc);
 				test.param_index++;
-
-				kunit_update_stats(&param_stats, test.status);
+				test.status = KUNIT_SUCCESS;
+				test.status_comment[0] = '\0';
 			}
 		}
 
-- 
2.25.1

