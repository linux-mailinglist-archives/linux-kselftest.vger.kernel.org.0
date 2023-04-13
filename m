Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7576E07A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 09:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDMHXT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 03:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjDMHXN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 03:23:13 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0772386B5;
        Thu, 13 Apr 2023 00:23:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="100985214"
X-IronPort-AV: E=Sophos;i="5.98,339,1673881200"; 
   d="scan'208";a="100985214"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 16:23:07 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1BFCDE8523;
        Thu, 13 Apr 2023 16:23:05 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 53019D3F33;
        Thu, 13 Apr 2023 16:23:04 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 1AB20400C07D1;
        Thu, 13 Apr 2023 16:23:04 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v9 6/6] selftests/resctrl: Remove duplicate codes that clear each test result file
Date:   Thu, 13 Apr 2023 16:22:59 +0900
Message-Id: <20230413072259.2089348-7-tan.shaopeng@jp.fujitsu.com>
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

Remove duplicate codes that clear each test result file,
while ensuring cleanup properly even when errors occur in each test.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cmt_test.c      | 7 +++----
 tools/testing/selftests/resctrl/mba_test.c      | 7 +++----
 tools/testing/selftests/resctrl/mbm_test.c      | 7 +++----
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ----
 4 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 47cde5c02b7f..af71b2141271 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -132,13 +132,12 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = check_results(&param, n);
-	if (ret)
-		return ret;
 
+out:
 	cmt_test_cleanup();
 
-	return 0;
+	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 2a5d43f3c142..cde3781a9ab0 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -165,13 +165,12 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = check_results();
-	if (ret)
-		return ret;
 
+out:
 	mba_test_cleanup();
 
-	return 0;
+	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 9b591c35310f..146132fa986d 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -134,13 +134,12 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = check_results(span);
-	if (ret)
-		return ret;
 
+out:
 	mbm_test_cleanup();
 
-	return 0;
+	return ret;
 }
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

