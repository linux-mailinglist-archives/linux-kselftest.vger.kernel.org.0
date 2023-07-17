Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE53875644E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGQNTM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjGQNSl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:18:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6830DF;
        Mon, 17 Jul 2023 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599855; x=1721135855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1TVPhglmPyef33VOHsKcPA5LwHiM2UJevhSWt6TPmY=;
  b=Fia5R+l4VVNuMUq1PM2EogweFj0VBgPTy7WNgduXg5vBuFqATHoO2h0x
   ObhPWDQ57uU1yQIuutu8O0mSbQmlf3BmvxUtrH+0sNztEmpZsscN8tJPy
   7mvGKGaLmXePGno6PtQLD2W9uKzHKexM0uWm4uh6uUNyuq80X1qE3Zx7y
   bPP0jmXq/g+ANGM3W2lvksWYpPJcGGHtHFMVIpgSI98bopiq3D0Sxv87E
   6TaeEwkDavZ9z8EJNohBduODXyQc4iYwJXVara5aVTufEEqXJTOSP20jc
   j5ULX9oc97dvDgSz6BK4u49n40RjTGVz1EZuCdSSwfJe/GqM2UcqCSr2p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368569293"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368569293"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793247336"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793247336"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:58 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 19/19] selftests/resctrl: Remove test type checks from cat_val()
Date:   Mon, 17 Jul 2023 16:15:07 +0300
Message-Id: <20230717131507.32420-20-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

cat_val() is only used during CAT test but it checks for test type.

Remove test type checks and the unused else branch from cat_val().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 47 +++++++++++--------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 18ebd1324cb3..d3cbb829ff6a 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -230,38 +230,31 @@ int cat_val(struct resctrl_val_param *param)
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
-				goto pe_close;
-			}
-
-			sleep(1);
-			ret = measure_cache_vals(param, bm_pid);
-			if (ret)
-				goto pe_close;
-
-			close(fd_lm);
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
+			goto pe_close;
+		}
+
+		sleep(1);
+		ret = measure_cache_vals(param, bm_pid);
+		if (ret)
+			goto pe_close;
 	}
 
 	return ret;
-- 
2.30.2

