Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F067ADE30
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjIYR6I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 13:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjIYR6G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 13:58:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3FD1A5
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695664678; x=1727200678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kO+KrNTR8kWxuX/LyKXcB+Gb7mODQeojOqMSeENlHM=;
  b=MEKKYlgIloyLK/Hwmho6D2XOiIMTPXRt2KKhx3Gez4KbHwjLuE0Pth2q
   9Xm24if/rt+PAx6+ZSq6SXFN96Wuyhi96OwAGfXoJB76BV7gYI5bf3l+x
   tHZELoA9iRwb/NbbtoF2be8lI7B4ZT+YO3lTwgDvlkLxs/uLZwB10eU8A
   NNlQox2XGIBr2iM/6Pw6gYPsYnzT2b26uyouBiTVf10lk9ojawMpnY87h
   6+IsWtrK0hZhkd1uZpcWzvznxuZTDVYUzeNfquWE2h5HSJJwA+eJsWbZS
   Auf4FAGGA+Pkz0wXBG8RrSllxe+xwcXrWzQbr5hA4qENQZJ+ilV+ueNk4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371643649"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="371643649"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995489266"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995489266"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.131.28])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:57:54 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH 1/4] kunit: Drop redundant text from suite init failure message
Date:   Mon, 25 Sep 2023 19:57:30 +0200
Message-Id: <20230925175733.1379-2-michal.wajdeczko@intel.com>
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

If a suite initialization fails, then our diagnostic message
will include redundant indent and hash sign as all this was
already added by the kunit_printk() used by kunit_err() macro.

This could be easily seen if we force some error in our example
test by modyfing example_test_init_suite() and running:

$ ./tools/testing/kunit/kunit.py run --raw_output \
	--kunitconfig ./lib/kunit/.kunitconfig "example.*"

    KTAP version 1
    1..1
        # example: initializing suite
        # example:     # failed to initialize (-19)
    not ok 1 example

Fix that and while around improve error code reporting by using
error pointer format %pe that gives more user friendly output:

    KTAP version 1
    1..1
        # example: initializing suite
        # example: failed to initialize (-ENODEV)
    not ok 1 example

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f2eb71f1a66c..fb5981ce578d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -568,8 +568,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 	if (suite->suite_init) {
 		suite->suite_init_err = suite->suite_init(suite);
 		if (suite->suite_init_err) {
-			kunit_err(suite, KUNIT_SUBTEST_INDENT
-				  "# failed to initialize (%d)", suite->suite_init_err);
+			kunit_err(suite, "failed to initialize (%pe)",
+				  ERR_PTR(suite->suite_init_err));
 			goto suite_end;
 		}
 	}
-- 
2.25.1

