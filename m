Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3F6E6046
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjDRLrR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDRLrP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:47:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B18E7ED1;
        Tue, 18 Apr 2023 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818406; x=1713354406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fToQ+8SOAxiSfN3ZiH5XH4bjEW4BAV3bTtI/uobe8NE=;
  b=j6LDF3/lxwCsDZDJMVM5xBj3gKcschUKrdQ+/p78Wr8uSYwyEqbbQn3M
   4o8ex6VCEI7LYbGiST5hvsiiJcdZsccCiFCB/wzkmks/Z3/G5l4psXDUy
   2WUZsfC18ZIha4s/8Ut9oXaRtOAfOry4WuPFr8KtHO4wMjgx3DLW8neMs
   uA1TfhDq9HZ2/KGr8zwDr8QnNKRh0BLJ2Uh76XiTEF4ThnZ+py2WXtkZQ
   kcW4BzOjc9KEVcIWH1S1+XM6HecYYBjmu7scORdnaHLVbEnxghKAEcKlm
   Fsr0KN02WVkCE92I9clHv1ZrM6dOyeDggXd6xKRsHKjS1u3MXL3Q6kLNa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994396"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994396"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601712"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601712"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:07 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 14/24] selftests/resctrl: Remove test type checks from cat_val()
Date:   Tue, 18 Apr 2023 14:44:56 +0300
Message-Id: <20230418114506.46788-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

