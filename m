Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EABD7670D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbjG1Ppc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 11:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjG1Ppb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 11:45:31 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125D4E0;
        Fri, 28 Jul 2023 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690559129; x=1722095129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WiBMoGQQC4NhBoCp+ki275V6Cbp6pdJOqJCv6Im1MbM=;
  b=NGZ+3KlzIh3mjxy4GMcD+Dk/AlChoILmA1SRcd5RqEmbEg6d2r1FbuPG
   rwDwEa43Os+onCfQoODW5Y0F1ya8x0upK0hEuzlqNZPFw2lsqvXxKEh62
   elB4lQwdm2yicXTojwYzhuBQ3bJx2nchQ28XT2Wvxo9DZk82BB6x2qtE+
   473WbF89FYsTLSLfkNExbqlQzRMDcTUHYcuhc9sqI3kTaIDj9wd1swSsV
   yAtXhd+p0oBlfFfQbiLUVLJXe0jWDCHEaiercdb6ncihjvdpCZRjlZmkn
   +iR4goWVxLzElBaofF8s/H766ezBQsBRefPrrZ8Jd8ECi3O2c0vS15Ay6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371323327"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="371323327"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817557438"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="817557438"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.lan) ([10.213.24.93])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:45:26 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] kunit: Expose some built-in features to modules
Date:   Fri, 28 Jul 2023 17:44:20 +0200
Message-ID: <20230728154419.1810177-5-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Janusz Krzysztofik (3):
  kunit: Report the count of test suites in a module
  kunit: Make 'list' action available to kunit test modules
  kunit: Allow kunit test modules to use test filtering

 include/kunit/test.h | 14 +++++++++++
 lib/kunit/executor.c | 51 ++++++++++++++++++++++-----------------
 lib/kunit/test.c     | 57 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 99 insertions(+), 23 deletions(-)

-- 
2.41.0

