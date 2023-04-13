Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D966E07A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 09:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDMHYS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 03:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjDMHYR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 03:24:17 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 00:24:08 PDT
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A478681;
        Thu, 13 Apr 2023 00:24:08 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="92663591"
X-IronPort-AV: E=Sophos;i="5.98,339,1673881200"; 
   d="scan'208";a="92663591"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 16:23:03 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 81625DF1BD;
        Thu, 13 Apr 2023 16:23:00 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C2C22D9497;
        Thu, 13 Apr 2023 16:22:59 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 6E65C400C0319;
        Thu, 13 Apr 2023 16:22:59 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v9 2/6] selftests/resctrl: Return MBA check result and make it to output message
Date:   Thu, 13 Apr 2023 16:22:55 +0900
Message-Id: <20230413072259.2089348-3-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com>
References: <20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com>
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
index 7defb32ad0de..2a5d43f3c142 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -56,10 +56,10 @@ static int mba_setup(int num, ...)
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
@@ -95,13 +95,15 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
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
@@ -137,9 +139,7 @@ static int check_results(void)
 
 	fclose(fp);
 
-	show_mba_info(bw_imc, bw_resc);
-
-	return 0;
+	return show_mba_info(bw_imc, bw_resc);
 }
 
 void mba_test_cleanup(void)
-- 
2.27.0

