Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FF3614728
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 10:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiKAJtZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 05:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAJsy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 05:48:54 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E72E1902A;
        Tue,  1 Nov 2022 02:48:53 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="94348500"
X-IronPort-AV: E=Sophos;i="5.95,230,1661785200"; 
   d="scan'208";a="94348500"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Nov 2022 18:48:51 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id F2A59D63B6;
        Tue,  1 Nov 2022 18:48:49 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 587B1D35F3;
        Tue,  1 Nov 2022 18:48:49 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 376CF40164011;
        Tue,  1 Nov 2022 18:48:49 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v3 5/5] selftests/resctrl: Remove duplicate codes that clear each test result file
Date:   Tue,  1 Nov 2022 18:43:41 +0900
Message-Id: <20221101094341.3383073-6-tan.shaopeng@jp.fujitsu.com>
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

Before exiting each test function(run_cmt/cat/mbm/mba_test()),
test results("ok","not ok") are printed by ksft_test_result() and then
temporary result files are cleaned by function
cmt/cat/mbm/mba_test_cleanup().
However, before running ksft_test_result(),
function cmt/cat/mbm/mba_test_cleanup()
has been run in each test function as follows:
  cmt_resctrl_val()
  cat_perf_miss_val()
  mba_schemata_change()
  mbm_bw_change()

Remove duplicate codes that clear each test result file.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index df0d8d8526fc..8732cf736528 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -88,7 +88,6 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
-	mbm_test_cleanup();
 }
 
 static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
@@ -107,7 +106,6 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 		sprintf(benchmark_cmd[1], "%d", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
-	mba_test_cleanup();
 }
 
 static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
@@ -126,7 +124,6 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 	ksft_test_result(!res, "CMT: test\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
-	cmt_test_cleanup();
 }
 
 static void run_cat_test(int cpu_no, int no_of_bits)
@@ -142,7 +139,6 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
 	ksft_test_result(!res, "CAT: test\n");
-	cat_test_cleanup();
 }
 
 int main(int argc, char **argv)
-- 
2.27.0

