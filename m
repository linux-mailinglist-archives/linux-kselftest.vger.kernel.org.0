Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6914614723
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 10:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKAJsv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiKAJsu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 05:48:50 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BA6C29;
        Tue,  1 Nov 2022 02:48:49 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="94441000"
X-IronPort-AV: E=Sophos;i="5.95,230,1661785200"; 
   d="scan'208";a="94441000"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Nov 2022 18:48:47 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id CBBC4C1388;
        Tue,  1 Nov 2022 18:48:46 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E858D9490;
        Tue,  1 Nov 2022 18:48:46 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 02B3F40164011;
        Tue,  1 Nov 2022 18:48:46 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v3 2/5] selftests/resctrl: Return MBA check result and make it to output message
Date:   Tue,  1 Nov 2022 18:43:38 +0900
Message-Id: <20221101094341.3383073-3-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
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

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 1a1bdb6180cf..5d14802add4d 100644
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

