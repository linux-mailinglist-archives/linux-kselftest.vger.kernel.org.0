Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29F697CBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 14:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjBONG3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 08:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjBONG1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 08:06:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AD538B4D;
        Wed, 15 Feb 2023 05:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676466386; x=1708002386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qn//9IBm5Kac9zEBQzEQS4jENOC77V8ts13HcmG10h0=;
  b=FJYLqX7L1ASRhBvDcgzvrIHms/65ar9D4R5WvRizu2+wAhNTR8Sv1f3V
   5mgYHb+4X+3koKI3cib9DKmTZpqKRqjrU3Z64SmXdgF4QTbrpUcqfsre9
   Lk0pjQf20NWHRqFMMmJVD7iCy8UrGHqiK/VEAKnFEx2keN/ofuKG/KGdz
   51yM1QCSS1tBvONq+dTlh7Lyr+2V2scI31KSnZs2cGm3PlGFE9Llmr7++
   wWCiA/Z0KvKfnAAfIE3FlBb8riEUR1iqk0P/HhsOE/DHXc20VAGTQJVcI
   PJTEepshmIxKmfnQbzI9bw3Ws941KMPAnVVY0xd90Q8G+1opGT29YF/5j
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319456252"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319456252"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812436033"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="812436033"
Received: from hshannan-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:24 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/9] selftests/resctrl: Move ->setup() call outside of test specific branches
Date:   Wed, 15 Feb 2023 15:05:58 +0200
Message-Id: <20230215130605.31583-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

resctrl_val() function is called only by MBM, MBA, and CMT tests which
means the else branch is never used.

Both test branches call param->setup().

Remove the unused else branch and place the ->setup() call outside of
the test specific branches reducing code duplication.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index b32b96356ec7..787546a52849 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -734,29 +734,22 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
+		ret = param->setup(1, param);
+		if (ret) {
+			ret = 0;
+			break;
+		}
+
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = param->setup(1, param);
-			if (ret) {
-				ret = 0;
-				break;
-			}
-
 			ret = measure_vals(param, &bw_resc_start);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-			ret = param->setup(1, param);
-			if (ret) {
-				ret = 0;
-				break;
-			}
 			sleep(1);
 			ret = measure_cache_vals(param, bm_pid);
 			if (ret)
 				break;
-		} else {
-			break;
 		}
 	}
 
-- 
2.30.2

