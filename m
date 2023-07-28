Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B578C7670DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbjG1Ppd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbjG1Ppc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 11:45:32 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74613212B;
        Fri, 28 Jul 2023 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690559131; x=1722095131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xfWKTT2Wn3/IWe//m/LpBpFN0F6nm+3nkhbl/ibfElU=;
  b=Tsoj3rOw/uHMzjrKviGMAIs7AmcdV2ajQOvw3iAtuwzR7Yv2uVHWC62f
   XoYV++sPYQhx2kpO/KKfoILs2VlEl7oczdWUxVA6vKsKMHCFXd0Rnd5Bl
   fQUQ5tEL2WcOryBhaQZJjwvWQu9kEtmWY+l5RbCLS71krNpegvAUU5Twc
   eJztowFBfwfUyncwrcXqCpXw2U3piQXzgS8TJAdXM8J/jNHyv3EIO8ojY
   0AqyumMwsDAGHH6Wsi2Mbi0V1MJEi5FlEkCGor21MpZBhsUWTUuW2VSRh
   aAwbLdjWYFahuUsTAY/HiM9rP2F170GvdGouMzGkF4cOhBm+V9pO6r1xV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371323344"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="371323344"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817557440"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="817557440"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.lan) ([10.213.24.93])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:45:28 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kunit: Report the count of test suites in a module
Date:   Fri, 28 Jul 2023 17:44:21 +0200
Message-ID: <20230728154419.1810177-6-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728154419.1810177-5-janusz.krzysztofik@linux.intel.com>
References: <20230728154419.1810177-5-janusz.krzysztofik@linux.intel.com>
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

According to KTAP specification[1], results should always start from a
header that provides a TAP protocol version, followed by a test plan with
a count of items to be executed.  That pattern should be followed at each
nesting level.  In the current implementation of the top-most, i.e., test
suite level, those rules apply only for test suites built into the kernel,
executed and reported on boot.  Results submitted to dmesg from kunit test
modules loaded later are missing those top-level headers.

As a consequence, if a kunit test module provides more than one test suite
then, without the top level test plan, external tools that are parsing
dmesg for kunit test output are not able to tell how many test suites
should be expected and whether to continue parsing after complete output
from the first test suite is collected.

Submit the top-level headers also from the kunit test module notifier
initialization callback.

[1] https://docs.kernel.org/dev-tools/ktap.html#

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 lib/kunit/test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 84e4666555c94..a29ca1acc4d81 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -729,6 +729,11 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 #ifdef CONFIG_MODULES
 static void kunit_module_init(struct module *mod)
 {
+	if (mod->num_kunit_suites > 0) {
+		pr_info("KTAP version 1\n");
+		pr_info("1..%d\n", mod->num_kunit_suites);
+	}
+
 	__kunit_test_suites_init(mod->kunit_suites, mod->num_kunit_suites);
 }
 
-- 
2.41.0

