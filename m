Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE2752392
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjGMNXh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjGMNW4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:22:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E583591;
        Thu, 13 Jul 2023 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254510; x=1720790510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B1zmj95tGIdII2SZaOFKFZ8yIm0cMc8pTOJH7ndgiGQ=;
  b=QBCmt7QLb72LpgCVMagKNsIVbWdfGAifz2X6QYBGO+B2CtiUP2/cTuy3
   Ehm2bZx+k+1Y76R3YUghKlINaTX1F731XtCemeYDlYIjesEq8ZScfAwUd
   IgwS4ZPaS8xKX78ODrDDuf+dVBVRi9/FD9mJbJoMPj2sR61qV5cKJTBKz
   XxecS74cSzO1a7ATgJnL7a34M7cn/8a2UgT5v88jV9QMd+kOkEGDZVZKj
   w3fgQd2GcocFCROq8GjUVMnLox+yV9r9ndsCBFfDi3UnEFp5tCW8mEpox
   W9RTy6TONWki/kNiNZwQW3DHC97oW5oX7syb97EkiLnNC+RvygG0gosfh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345497143"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345497143"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:21:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968616062"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968616062"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:21:18 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 19/19] selftests/resctrl: Remove test type checks from cat_val()
Date:   Thu, 13 Jul 2023 16:19:32 +0300
Message-Id: <20230713131932.133258-20-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
 tools/testing/selftests/resctrl/cache.c | 47 +++++++++++--------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 5aa112e5fdd3..2758e1a3b255 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -231,37 +231,32 @@ int cat_val(struct resctrl_val_param *param)
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
-				close(fd_lm);
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
+			close(fd_lm);
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

