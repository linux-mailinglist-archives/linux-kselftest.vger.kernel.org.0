Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6D6770C26
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 00:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjHDWzZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 18:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHDWzY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 18:55:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F6A1BE;
        Fri,  4 Aug 2023 15:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691189723; x=1722725723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=74eJtOZ8h+3nyHZJZk3ePstWB6ItvCo3PtaMJEcyxlA=;
  b=HKSJ17WzrSVsz0rc3IB8P3Hc+arD0iBNW9keGDlcjnQJzg8yPddg1mpo
   DArsuqnE+XAvFNFJfbr0tZkeWy0pfuPXzbIWvH9qBNf71d7KUrQl9GSiB
   31SLIWENEiOOFHkXD+IHXuepkHNYIa1Vqldg5SC18EBdt+4mzU288xT8Z
   8EG+WQSnrSENsiwDNEjUxC5Jx8BILMdI3GVPXScFN4udwLXBkJdF6r6Xt
   P3xDmvtCkD02xW+mu9WeK9sHztIpn1xPkL4kaF98Lr9JEXOjxsT3PYGeJ
   wIL5Pp8aJfxJLxU3EKj6M60ka+MTqia/S8T/dB26fOzmoZ4PQX0nePHQ2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="360325192"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="360325192"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 15:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="733445155"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="733445155"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.intranet) ([10.213.4.149])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 15:55:15 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH v4 0/3] kunit: Expose some built-in features to modules
Date:   Sat,  5 Aug 2023 00:52:21 +0200
Message-ID: <20230804225220.8005-5-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
    
v4: Use kunit_exec_run_tests() (Mauro, Rae), but prevent it from
    emitting the headers when called on load of non-test modules, 
  - don't use a different list format, use kunit_exec_list_tests() (Rae),
  - refresh on top of newly introduced attributes patches, handle newly
    introduced kunit.action=list_attr case (Rae).
v3: Fix CONFIG_GLOB, required by filtering functions, not selected when
    building as a module.
v2: Fix new name of a structure moved to kunit namespace not updated
    across all uses.

Janusz Krzysztofik (3):
  kunit: Report the count of test suites in a module
  kunit: Make 'list' action available to kunit test modules
  kunit: Allow kunit test modules to use test filtering

 include/kunit/test.h |  21 ++++++++
 lib/kunit/Kconfig    |   2 +-
 lib/kunit/executor.c | 115 +++++++++++++++++++++++++------------------
 lib/kunit/test.c     |  40 ++++++++++++++-
 4 files changed, 128 insertions(+), 50 deletions(-)


base-commit: 5a175d369c702ce08c9feb630125c9fc7a9e1370
-- 
2.41.0

