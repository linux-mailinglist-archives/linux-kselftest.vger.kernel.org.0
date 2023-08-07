Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E39771E01
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 12:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjHGK2c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 06:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjHGK2b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 06:28:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B764210F4;
        Mon,  7 Aug 2023 03:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691404110; x=1722940110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dkHorrBffv4xQS+bxgJDmsQVKSSR++utvuao/xqLQqw=;
  b=KB1HzHMVJ2OXbCG6iF/Grlc4tFUzzG1raPQhzd1EFQCKWveyHmYbJyI2
   ghTrYZvpN+BfHiXh3eBf3S6QSKjagXccSIadCMOmH9K3hFd/+CKTzhWI+
   46aqABLXPXHLNnCv2VFo/C53gOqHbOX0vR150jhbR9hKJqoxAXtdeTYgI
   1FznqpPmQp3WXsWMy9poUIcro3u5fKRUWjP/wmFVAxZjvHCry07/NqZcN
   LqFFnXkDHPLVWwu4pFh6Y3ca6oba1GsAsygkzXqqKTKy4OSHQCQqsHrgU
   HI5YTSNMayzwhXOiCz6ta6KdvwP/u+zHKq2vSSb/Vg15HJjhA7xUjdxJE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="350818181"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="350818181"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 03:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="730909195"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="730909195"
Received: from kornelo-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.ger.corp.intel.com) ([10.213.30.73])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 03:28:22 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH v5 0/3] kunit: Expose some built-in features to modules
Date:   Mon,  7 Aug 2023 12:23:53 +0200
Message-ID: <20230807102352.4607-5-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Submit the top-level headers also from the kunit test module notifier
initialization callback, so external tools that are parsing dmesg for
kunit test output are able to tell how many test suites should be expected
and whether to continue parsing after complete output from the first test
suite is collected.

Extend kunit module notifier initialization callback with a processing
path for only listing the tests provided by a module if the kunit action
parameter is set to "list", so external tools can obtain a list of test
cases to be executed in advance and can make a better job on assigning
kernel messages interleaved with kunit output to specific tests. 

Use test filtering functions in kunit module notifier callback functions,
so external tools are able to execute individual test cases from kunit
test modules in order to still better isolate their potential impact on
kernel messages that appear interleaved with output from other tests.
    
v5: Fix new name of a structure moved to kunit namespace not updated in
    executor_test functions (lkp@intel.com),
  - refresh on tpp of attributes filtering fix.
v4: Use kunit_exec_run_tests() (Mauro, Rae), but prevent it from
    emitting the headers when called on load of non-test modules, 
  - don't use a different list format, use kunit_exec_list_tests() (Rae),
  - refresh on top of newly introduced attributes patches, handle newly
    introduced kunit.action=list_attr case (Rae).
v3: Fix CONFIG_GLOB, required by filtering functions, not selected when
    building as a module (lkp@intel.com).
v2: Fix new name of a structure moved to kunit namespace not updated
    across all uses (lkp@intel.com).

Janusz Krzysztofik (3):
  kunit: Report the count of test suites in a module
  kunit: Make 'list' action available to kunit test modules
  kunit: Allow kunit test modules to use test filtering

 include/kunit/test.h      |  21 +++++++
 lib/kunit/Kconfig         |   2 +-
 lib/kunit/executor.c      | 115 ++++++++++++++++++++++----------------
 lib/kunit/executor_test.c |  36 ++++++++----
 lib/kunit/test.c          |  37 +++++++++++-
 5 files changed, 149 insertions(+), 62 deletions(-)


base-commit: 1c9fd080dffe5e5ad763527fbc2aa3f6f8c653e9
-- 
2.41.0

