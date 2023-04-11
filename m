Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183946DE04B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjDKQBx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDKQBX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:01:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1281F49F5
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681228882; x=1712764882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VSHjNOJ/FlrIT86OAvkBHS2Spcnc8prxVT13bL+pJVI=;
  b=ZKq6p0KF4Wt0G/xJlEVrUgjhmKWhyq5kf/6u7imeGXhWNZBWOFxRtUud
   tH5ZO2ZPmLNJzWSIIhTYrE62tab8D919GqpS8mdCsc97L/d+Nv0AxJOFM
   d9qxoAnCYNPLmFJmcbYMMeCKKyvGNqJJqpp47v8MhLh8fbZSgHFUrzzsm
   +mozg3r2NTaUE2pbFVQOQbevHtMO+zikg94PpffaZfuxGYB+ITWSfUDbI
   R2k+hOEqkyX9ER8wZw01axQ1w3UkgGyrYrIs76/wOkLOoS+cX3g8oN/Tt
   dx7dxcc/gqs0VB14mu+K1SZWDZz3/i3Cxs0/eoGddioclkiZZU1u676nS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="341149047"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341149047"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="777972271"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="777972271"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.133.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:01:14 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH 0/3] kunit: Fix reporting of the skipped parameterized tests
Date:   Tue, 11 Apr 2023 18:00:53 +0200
Message-Id: <20230411160056.1586-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
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

Cc: David Gow <davidgow@google.com>

Michal Wajdeczko (3):
  kunit/test: Add example test showing parameterized testing
  kunit: Fix reporting of the skipped parameterized tests
  kunit: Update reporting function to support results from subtests

 lib/kunit/kunit-example-test.c | 34 ++++++++++++++++++++++++++++++++++
 lib/kunit/test.c               | 26 +++++++++++++++++---------
 2 files changed, 51 insertions(+), 9 deletions(-)

-- 
2.25.1

