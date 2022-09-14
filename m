Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4D55B7EBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 03:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiINBzJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 21:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiINBzH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 21:55:07 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869C42CE1E;
        Tue, 13 Sep 2022 18:55:06 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="67233269"
X-IronPort-AV: E=Sophos;i="5.93,313,1654527600"; 
   d="scan'208";a="67233269"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 14 Sep 2022 10:55:03 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id ECED1DAFD0;
        Wed, 14 Sep 2022 10:55:02 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3E55BE676E;
        Wed, 14 Sep 2022 10:55:02 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 073F8403E0587;
        Wed, 14 Sep 2022 10:55:02 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH] selftests/resctrl: Return MBA check result and make it to output message
Date:   Wed, 14 Sep 2022 10:51:43 +0900
Message-Id: <20220914015147.3071025-3-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since MBA check result is not returned, the MBA test result message
is always output as OK regardless of whether the MBA check result is
true or fail.

Make output message to be "not ok" if MBA check result is failed.

This patch is based on Linux v6.0-rc5

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 93ffacb416df..e7dfeb697e5e 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -51,7 +51,7 @@ static int mba_setup(int num, ...)
 	return 0;
 }
 
-static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
+static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 {
 	int allocation, runs;
 	bool failed = false;
@@ -97,6 +97,8 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 		       failed ? "Fail:" : "Pass:");
 	if (failed)
 		ksft_print_msg("At least one test failed\n");
+
+	return failed;
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

