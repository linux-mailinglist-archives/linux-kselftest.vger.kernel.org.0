Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE66DE04C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDKQBy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjDKQBY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:01:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332434697
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681228882; x=1712764882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u95HEAaJtyZJkxab6ihnM1J03ypCR93pnjr/N0y+sWo=;
  b=Cb6amM9a8DT4DUi0SGvITqX8PyC2Gv7SEi+enjR/FElwwvpD7rK8ywaF
   RQOUUM4w5Kj3O4AK40WmziebDCyX6q309dqE6SFt1AwCoQLSUMOAkX0Rk
   o2en0DrmqVc6vQeK3Br9yIX3rXy5XhDMxrdbuYTyUUM1y6M75jIkk3sN+
   aOJSla4oAcJ2AiJBB8U/HLT0mPiDDiDW/WZiL5VAMm/aBWnjCBIgGMx66
   1a7j6T2LSmvprl55eOPKFtKeVDjWgDBs1vvR4okAXEWcUHgfBVHGMd2UR
   X/1+lSSk5kRVVX0tFBYHmhfyKlt5WzzJXi5FTsOvqFcnzyHQASs4PomC9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="341149075"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341149075"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="777972302"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="777972302"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.133.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:01:17 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH 2/3] kunit: Fix reporting of the skipped parameterized tests
Date:   Tue, 11 Apr 2023 18:00:55 +0200
Message-Id: <20230411160056.1586-3-michal.wajdeczko@intel.com>
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

Logs from the parameterized tests that were skipped don't include
SKIP directive thus they are displayed as PASSED. Fix that.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
---
 lib/kunit/test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c9e15bb60058..5679197b5f8a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -556,9 +556,11 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 				kunit_log(KERN_INFO, &test,
 					  KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
-					  "%s %d %s",
+					  "%s %d %s%s%s",
 					  kunit_status_to_ok_not_ok(test.status),
-					  test.param_index + 1, param_desc);
+					  test.param_index + 1, param_desc,
+					  test.status == KUNIT_SKIPPED ? " # SKIP " : "",
+					  test.status == KUNIT_SKIPPED ? test.status_comment : "");
 
 				/* Get next param. */
 				param_desc[0] = '\0';
-- 
2.25.1

