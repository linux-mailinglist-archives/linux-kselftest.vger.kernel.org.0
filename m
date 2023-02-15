Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A067D69784D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 09:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjBOIgn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 03:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjBOIgm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 03:36:42 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421725B9C;
        Wed, 15 Feb 2023 00:36:40 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="106671294"
X-IronPort-AV: E=Sophos;i="5.97,299,1669042800"; 
   d="scan'208";a="106671294"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 17:36:39 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5462BC3F94;
        Wed, 15 Feb 2023 17:36:36 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id AC7D7CFF98;
        Wed, 15 Feb 2023 17:36:35 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 851C2400C029A;
        Wed, 15 Feb 2023 17:36:35 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v8 2/6] selftests/resctrl: Return MBA check result and make it to output message
Date:   Wed, 15 Feb 2023 17:32:26 +0900
Message-Id: <20230215083230.3155897-3-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com>
References: <20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since MBA check result is not returned, the MBA test result message
is always output as "ok" regardless of whether the MBA check result is
true or false.

Make output message to be "not ok" if MBA check result is failed.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 1a1bdb6180cf..e3a473976d74 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -51,10 +51,10 @@ static int mba_setup(int num, ...)
 	return 0;
 }
 
-static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
+static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 {
 	int allocation, runs;
-	bool failed = false;
+	bool ret = false;
 
 	ksft_print_msg("Results are displayed in (MB)\n");
 	/* Memory bandwidth from 100% down to 10% */
@@ -90,13 +90,15 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 		ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 		ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
 		if (avg_diff_per > MAX_DIFF_PERCENT)
-			failed = true;
+			ret = true;
 	}
 
 	ksft_print_msg("%s Check schemata change using MBA\n",
-		       failed ? "Fail:" : "Pass:");
-	if (failed)
+		       ret ? "Fail:" : "Pass:");
+	if (ret)
 		ksft_print_msg("At least one test failed\n");
+
+	return ret;
 }
 
 static int check_results(void)
@@ -132,9 +134,7 @@ static int check_results(void)
 
 	fclose(fp);
 
-	show_mba_info(bw_imc, bw_resc);
-
-	return 0;
+	return show_mba_info(bw_imc, bw_resc);
 }
 
 void mba_test_cleanup(void)
-- 
2.27.0

