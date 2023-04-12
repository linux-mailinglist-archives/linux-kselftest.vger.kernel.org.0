Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A046DF705
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjDLNXy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDLNXa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:23:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FECBA261;
        Wed, 12 Apr 2023 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305786; x=1712841786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fToQ+8SOAxiSfN3ZiH5XH4bjEW4BAV3bTtI/uobe8NE=;
  b=mJQ0iIq/ukbZkES4f019lswtyf1x+F3ph9scburq+Va8sLHcSJFMlln6
   0fhcnANNEFiD2H96lpSnfRAX9VUjU/kygMnlJzjeTI0ntFXox9iwDDyXx
   LN6u5X6jYP95DpuSXqnPDviWP6yfFxoIybxhsvwhBG96kGDpYNDpOAxdI
   D8Go/Cfw1u077BnplzIoLXsd0UedH0euckWI7dmEcEPPV8HV16TmpQPYE
   /t4PKs8T6f/Yu+g+zSjzNW7iyHYpApd9V0V+0KuYKnlMInCNvUF5f6FKZ
   7N1Qxpv2IbLo17PBKGDBwAuH4Dj0eTG7PvWon3b8RL2Iy9llVqwOt47Qu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590185"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590185"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230082"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230082"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:27 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 12/22] selftests/resctrl: Remove test type checks from cat_val()
Date:   Wed, 12 Apr 2023 16:21:12 +0300
Message-Id: <20230412132122.29452-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

cat_val() is only used during CAT test but it checks for test type.

Remove test type checks and the unused else branch from cat_val().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 45 +++++++++++--------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index a15f1f2715cd..6bc912de38be 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -232,36 +232,31 @@ int cat_val(struct resctrl_val_param *param)
 	if (ret)
 		return ret;
 
-	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
-		initialize_llc_perf();
+	initialize_llc_perf();
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-			ret = param->setup(param);
-			if (ret == END_OF_TESTS) {
-				ret = 0;
-				break;
-			}
-			if (ret < 0)
-				break;
-			ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
-			if (ret)
-				break;
-
-			if (run_fill_buf(param->span, memflush, operation, true)) {
-				fprintf(stderr, "Error-running fill buffer\n");
-				ret = -1;
-				break;
-			}
-
-			sleep(1);
-			ret = measure_cache_vals(param, bm_pid);
-			if (ret)
-				break;
-		} else {
+		ret = param->setup(param);
+		if (ret == END_OF_TESTS) {
+			ret = 0;
 			break;
 		}
+		if (ret < 0)
+			break;
+		ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
+		if (ret)
+			break;
+
+		if (run_fill_buf(param->span, memflush, operation, true)) {
+			fprintf(stderr, "Error-running fill buffer\n");
+			ret = -1;
+			break;
+		}
+
+		sleep(1);
+		ret = measure_cache_vals(param, bm_pid);
+		if (ret)
+			break;
 	}
 
 	return ret;
-- 
2.30.2

