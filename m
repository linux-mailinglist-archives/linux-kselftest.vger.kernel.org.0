Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E467B8E5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjJDU5q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 16:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJDU5q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 16:57:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D74E9B
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Oct 2023 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696453063; x=1727989063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ng1qV7oqP4vlKUJHjcOrxkQ8pV4/v/y3L4YpnUu4SL4=;
  b=hTCIpqdddkAMTlxExkv/KlgZoBOkrg6gUm71LDGodDPbIXwd7EaqR7uy
   c9m8jm1yEOqa0nsDRieV4QQbbRnXmhtFkfWVti5GsKdLMFfpwD61VlrQi
   5bS1tPXISK5XZmUCp/ulXYIHQtcG6HGA22GiNt+VecYaVEd/TFYjKvLYs
   GKysQT7VFcB06zR+gODau/6d5zZMOhWrj8ovXMkSRjGPjTwrl/8tNjG8a
   7C2xtW/fzIhTlKP/norxmxGEn6Fn5FbtT1vrnVybaotXyWoqwutMf+1RC
   DVIjl3ZJIpl4wXDPtVKNLK+SXb2GplsMLQCtqUs4m/MqSMUUy7qLcykvu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="414248311"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="414248311"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 13:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="925309898"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="925309898"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.133.82])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 13:57:39 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH] kunit: Reset suite counter right before running tests
Date:   Wed,  4 Oct 2023 22:57:00 +0200
Message-Id: <20231004205700.1511-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Today we reset the suite counter as part of the suite cleanup,
called from the module exit callback, but it might not work that
well as one can try to collect results without unloading a previous
test (either unintentionally or due to dependencies).

For easy reproduction try to load the kunit-test.ko and then
collect and parse results from the kunit-example-test.ko load.
Parser will complain about mismatch of expected test number:

[ ] KTAP version 1
[ ] 1..1
[ ]     # example: initializing suite
[ ]     KTAP version 1
[ ]     # Subtest: example
..
[ ] # example: pass:5 fail:0 skip:4 total:9
[ ] # Totals: pass:6 fail:0 skip:6 total:12
[ ] ok 7 example

[ ] [ERROR] Test: example: Expected test number 1 but found 7
[ ] ===================== [PASSED] example =====================
[ ] ============================================================
[ ] Testing complete. Ran 12 tests: passed: 6, skipped: 6, errors: 1

Since we are now printing suite test plan on every module load,
right before running suite tests, we should make sure that suite
counter will also start from 1. Easiest solution seems to be move
counter reset to the __kunit_test_suites_init() function.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f2eb71f1a66c..9325d309ed82 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -670,6 +670,8 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 		return 0;
 	}
 
+	kunit_suite_counter = 1;
+
 	static_branch_inc(&kunit_running);
 
 	for (i = 0; i < num_suites; i++) {
@@ -696,8 +698,6 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
 
 	for (i = 0; i < num_suites; i++)
 		kunit_exit_suite(suites[i]);
-
-	kunit_suite_counter = 1;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
-- 
2.25.1

