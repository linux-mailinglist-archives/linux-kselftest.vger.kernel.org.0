Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5B270668C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 13:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEQLUg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 07:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjEQLUf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 07:20:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016831BF
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 04:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684322434; x=1715858434;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9dzr8tvDYI2+0eZZWUhDHHpN/Iz2mOx345NMl71pfHE=;
  b=Dc8p5tqAxS/aNaER2dlbXO2vSlVTol9k66V4RQVr5QCt6TSYYBkKrrLY
   iGiB30vVp9n72MoJyFpRGmM08VQZhJPBzLlyVrGKnectTsDHt/nMc8XST
   1EK32wzC6PP3yNX9aZOKohzo4zX7YrH7g51FMWHudY9NTKolIukoEFsWn
   ngr91KvRThoDxTOSsPvfw2OoZ/8k2TLnI7CuUPLRwWQLmWQRSRhNNPahC
   +y9zL4jwche8iU5N7jmIWMHzqq3Ox8BQURApkruj29zE3OIxY9IeS8oDW
   kKz98fca6PJTaecJA0Nqhz19Hfd2mbpVgebEV+VCaVBDcVNU3s2qu055e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="341115899"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="341115899"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 04:20:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="766738727"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="766738727"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.142.110])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 04:20:28 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v3 0/3] kunit: Fix reporting of the skipped parameterized tests
Date:   Wed, 17 May 2023 13:18:13 +0200
Message-Id: <20230517111816.984-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
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
v3: rebased on kunit tree [1]

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit

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

