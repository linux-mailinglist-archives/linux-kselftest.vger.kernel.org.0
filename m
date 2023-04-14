Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB66E270B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDNPbE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjDNPbC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 11:31:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23EFF2C
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681486236; x=1713022236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HQgmAkzJlMZj69bz14as7wZfyrhYGhdQQsw+FTyrJVo=;
  b=nQ6XoRPvRHOiDW4slPmeZn7H6pCWyLf7SwA+0ApIJxxroBYH+Ze7FE+q
   okeV0Q0lR9xDqzSq3M8cuO8Iepz8z2+/e78tfIiYfSwRbzbDHTz9MF6bW
   TAIHUcTzE4oHQ/i465CHTKLTACe/xdvePOFXY403M5mBIpgJjPW1rfo9g
   xBMQRY6ijFm0Bzil1WHGoc3bHrffslQ2t3mF6S1UdCKoNwW0sqGtxJ8dL
   jsfCB8liPfxJWTLIY6gvCn9rz8KfkkbHV1Nw+NCHXxJeHNiNJn3KGGGqu
   xUXTA96FSeOVssAnohzHojf5AKBMCkcLQ+qUfBTOGe2dI/H3dHGf6P9XN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="341985947"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="341985947"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 08:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="759138720"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="759138720"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.157.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 08:28:11 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v2 2/3] kunit: Fix reporting of the skipped parameterized tests
Date:   Fri, 14 Apr 2023 17:27:36 +0200
Message-Id: <20230414152737.1630-3-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230414152737.1630-1-michal.wajdeczko@intel.com>
References: <20230414152737.1630-1-michal.wajdeczko@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Logs from the parameterized tests that were skipped don't include
SKIP directive thus they are displayed as PASSED. Fix that.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
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

