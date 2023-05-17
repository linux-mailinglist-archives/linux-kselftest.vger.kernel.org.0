Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7C070668D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjEQLUg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 07:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjEQLUe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 07:20:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8C103
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684322434; x=1715858434;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=8SpyRf+yeQrxbHtQ75fj/0ADY3ykc7S3MEaXhzRIDVw=;
  b=JvxVhVktXJbclCFUolhyymiK55D2E7BR2+QEMkEGrZINThwl1LcOO34d
   39Sy72Wl7koFkhHJIXpGArCiK6l4mGdhENDOWnDeFnhAXLSvyT3SGIq1H
   UfIlQ+OP8fWfqFgGmQrooXZpFkO1Rk58nm+kMPHPu5hEazAAdkUKjeRXk
   XFQXZJftM7zF5TmESCKjEAQt4vhzpTQu7a8v02BO3XW7wA5IyW+GAvP5X
   64Dlb6x4lKSsdoOOza2vDHOuJgTcAjqzgYFQXuDWobeqFBLGnKYsDaFrG
   6g2F6sya2qd95nuBazRydLLpCzMRjrbFrNcZ72gdrV9tsKd8vyicSYd6P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="341115909"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="341115909"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 04:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="766738744"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="766738744"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.142.110])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 04:20:31 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v3 2/3] kunit: Fix reporting of the skipped parameterized tests
Date:   Wed, 17 May 2023 13:18:15 +0200
Message-Id: <20230517111816.984-3-michal.wajdeczko@intel.com>
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
index f5e4ceffd282..af48d0761d26 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -627,9 +627,11 @@ int kunit_run_tests(struct kunit_suite *suite)
 
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

