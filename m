Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9674C6E270A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDNPbC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 11:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDNPbA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 11:31:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF148D32A
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681486232; x=1713022232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zaP6d8QyUzaYF3BL3H3Igo1ej7QNfF5OedPuQRNW43M=;
  b=YsodCQY+d3cUAfyjEVLICzuadcCKqmHXU9pwiAC0x4bAECFWYawc0YJE
   P20PV1uORpMQUwZ6ozMQnWK7Po2GBu1KC5B4lS05RUtojJjWedR4O9ZDz
   8Y50/N9KLXCFGYiGnaKF1Sw3b2OW4cpWzhVWgmKskn2+xJ/r9/Tm2X3kt
   7MT515ZrsMcOEnANEnciwFRNqjUGsu5hbkN0yfzhqUt70NhPtP1sv2b/t
   N1MFEVbHVgoGU1soJnD+lqTALGtfyBcRU5oox+cRARVqxiOwLf0Lz+9M1
   ZOi/LklzZ3qELcl5WUJYU8mC84cdhhtOyHudZclQBfDuEPZRKWTsjHzyr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="341985924"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="341985924"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 08:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="759138688"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="759138688"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.157.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 08:28:05 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v2 0/3] kunit: Fix reporting of the skipped parameterized tests
Date:   Fri, 14 Apr 2023 17:27:34 +0200
Message-Id: <20230414152737.1630-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
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

Due to the lack of the SKIP directive in the output, if any of the
parameterized test was skipped, the parser could not recognize that
correctly and was marking the test as PASSED.

This can easily be seen by running the new subtest from patch 1:

$ ./tools/testing/kunit/kunit.py run \
	--kunitconfig ./lib/kunit/.kunitconfig *.example_params*

  [ ] Starting KUnit Kernel (1/1)...
  [ ] ============================================================
  [ ] =================== example (1 subtest) ====================
  [ ] =================== example_params_test  ===================
  [ ] [PASSED] example value 2
  [ ] [PASSED] example value 1
  [ ] [PASSED] example value 0
  [ ] =============== [PASSED] example_params_test ===============
  [ ] ===================== [PASSED] example =====================
  [ ] ============================================================
  [ ] Testing complete. Ran 3 tests: passed: 3

$ ./tools/testing/kunit/kunit.py run \
	--kunitconfig ./lib/kunit/.kunitconfig *.example_params* \
	--raw_output

  [ ] Starting KUnit Kernel (1/1)...
  KTAP version 1
  1..1
      # example: initializing suite
      KTAP version 1
      # Subtest: example
      1..1
          KTAP version 1
          # Subtest: example_params_test
      # example_params_test: initializing
          ok 1 example value 2
      # example_params_test: initializing
          ok 2 example value 1
      # example_params_test: initializing
          ok 3 example value 0
      # example_params_test: pass:2 fail:0 skip:1 total:3
      ok 1 example_params_test
  # Totals: pass:2 fail:0 skip:1 total:3
  ok 1 example

After adding the SKIP directive, the report looks as expected:

  [ ] Starting KUnit Kernel (1/1)...
  [ ] ============================================================
  [ ] =================== example (1 subtest) ====================
  [ ] =================== example_params_test  ===================
  [ ] [PASSED] example value 2
  [ ] [PASSED] example value 1
  [ ] [SKIPPED] example value 0
  [ ] =============== [PASSED] example_params_test ===============
  [ ] ===================== [PASSED] example =====================
  [ ] ============================================================
  [ ] Testing complete. Ran 3 tests: passed: 2, skipped: 1

  [ ] Starting KUnit Kernel (1/1)...
  KTAP version 1
  1..1
      # example: initializing suite
      KTAP version 1
      # Subtest: example
      1..1
          KTAP version 1
          # Subtest: example_params_test
      # example_params_test: initializing
          ok 1 example value 2
      # example_params_test: initializing
          ok 2 example value 1
      # example_params_test: initializing
          ok 3 example value 0 # SKIP unsupported param value
      # example_params_test: pass:2 fail:0 skip:1 total:3
      ok 1 example_params_test
  # Totals: pass:2 fail:0 skip:1 total:3
  ok 1 example

v2: better align with future support for arbitrary levels of testing

Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>

Michal Wajdeczko (3):
  kunit/test: Add example test showing parameterized testing
  kunit: Fix reporting of the skipped parameterized tests
  kunit: Update kunit_print_ok_not_ok function

 include/kunit/test.h           |  1 +
 lib/kunit/kunit-example-test.c | 34 +++++++++++++++++++++++++++
 lib/kunit/test.c               | 43 ++++++++++++++++++++++------------
 3 files changed, 63 insertions(+), 15 deletions(-)

-- 
2.25.1

