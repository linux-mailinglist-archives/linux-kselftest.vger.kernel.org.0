Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3713A7B1EAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjI1Nil (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 09:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjI1Nik (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 09:38:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F5D92
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695908319; x=1727444319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M9URAU2x21TCgOTE1bIiuAdOMJMus4RaRV3wQMI/7F0=;
  b=HF+krojC16vLbaKF4skp/EvpM0ILM27Kb0FUz2NgsRdivBqYCwWBktbK
   LLgDAPfvq7rRX8B+MleXkaCf2kKK55cRJ2alSBMtUBR8GVDw/BLTqfnqf
   6KgkWhIDJNZ0N2BDlNE92NB5ZfWq1/7Z5eGtb7VGvQw7N1rswk5BUQpoW
   r9kGDMU7X0IY3jJUmftal9bQ6J4HvYJiu9igUT1ouGCW+dAJ2bVtmPq8A
   16wg+RPWaFKN6hPo7YMP+lCKo7SsMw3HUpWWONd1VgGFgxpEwuVEzf1ax
   N82ZmwFw9okG++Tu4YENEq3uwuznQ0oLNeL3gDXkI0I3FJVuHxNpqhGM3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361438865"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="361438865"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:38:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="778905398"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="778905398"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.152.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:38:36 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH 1/2] kunit: Improve format of the NOT_ERR_OR_NULL assertion
Date:   Thu, 28 Sep 2023 15:38:20 +0200
Message-Id: <20230928133821.1467-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
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

Diagnostic message for failed KUNIT_ASSERT|EXPECT_NOT_ERR_OR_NULL
shows only raw error code, like in this example:

[ ] # example_all_expect_macros_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:126
[ ] Expected myptr is not error, but is: -12

but we can improve it by using more friendly error pointer format:

[ ] # example_all_expect_macros_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:126
[ ] Expected myptr is not error, but is -ENOMEM

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/assert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index dd1d633d0fe2..96ef236d3ca3 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -80,9 +80,9 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				  ptr_assert->text);
 	} else if (IS_ERR(ptr_assert->value)) {
 		string_stream_add(stream,
-				  KUNIT_SUBTEST_INDENT "Expected %s is not error, but is: %ld\n",
+				  KUNIT_SUBTEST_INDENT "Expected %s is not error, but is %pe\n",
 				  ptr_assert->text,
-				  PTR_ERR(ptr_assert->value));
+				  ptr_assert->value);
 	}
 	kunit_assert_print_msg(message, stream);
 }
-- 
2.25.1

