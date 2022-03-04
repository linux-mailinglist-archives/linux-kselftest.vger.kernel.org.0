Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB64CD29D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiCDKmX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 05:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiCDKmX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 05:42:23 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AD41AAFDE;
        Fri,  4 Mar 2022 02:41:35 -0800 (PST)
IronPort-SDR: sNKOLv2BAlkibgeIIZSso01JBiPWq9hMk8+Zc8u/1hGej2VX84Y9wPdMXj4DlBuTxw9FddHGj4
 7wZVCHpuhHyU8I/7hZ7ftE7uCBDq+zTCLfPbHhOVDv3CpBpGa6lRnNcufWF/hR69Hw34uUI3me
 HlhvSg/+UpwJ/nmdsSvtiPuC8ypOOBZo05b7WZc0t55wbG7Ge6TexFys1gQMwSIpG8lTI22dlh
 xDAwy1EHCmzG1RT36+LqyuVNaJSq0MQrWROZUjayCd7Barlbo66iwbbFZ58jlQoTVJpAXvRs2v
 ZBQ3MpLGlQpl8J9IL0USEkNv
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="53044773"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; 
   d="scan'208";a="53044773"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2022 19:40:29 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 92D2CC68A8;
        Fri,  4 Mar 2022 19:40:28 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 38230E679E;
        Fri,  4 Mar 2022 19:40:27 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id 0C38C403884E6;
        Fri,  4 Mar 2022 19:40:27 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v3] selftests/resctrl: Print a message if the result of MBM&CMT tests is failed on Intel cpu
Date:   Fri,  4 Mar 2022 19:39:57 +0900
Message-Id: <20220304103957.487660-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
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

According to "Intel Resource Director Technology (Intel RDT) on 
2nd Generation Intel Xeon Scalable Processors Reference Manual",
When the Intel Sub-NUMA Clustering(SNC) feature is enabled,
Intel CMT and MBM counters may not be accurate.

However, there does not seem to be an architectural way to detect
if SNC is enabled.

If the result of MBM&CMT test fails on Intel CPU,
print a message to let users know a possible cause of failure.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Hello,

In PATCH V2, I tried to detect whether SNC is enabled by NUMA info and
cpuinfo(socket_num), but it is not reliable and no future-proof.

I just print a message to let users know a possible cause of "not ok",
When CMT or MBM test runs on Intel CPU, and the result is "not ok".

This patch is based on v5.16.

 tools/testing/selftests/resctrl/resctrl_tests.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 973f09a66e1e..ec2bdce7b85f 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -14,8 +14,9 @@
 #define BENCHMARK_ARG_SIZE	64
 
 bool is_amd;
+bool is_intel;
 
-void detect_amd(void)
+void detect_vendor(void)
 {
 	FILE *inf = fopen("/proc/cpuinfo", "r");
 	char *res;
@@ -29,6 +30,7 @@ void detect_amd(void)
 		char *s = strchr(res, ':');
 
 		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
+		is_intel = s && !strcmp(s, ": GenuineIntel\n");
 		free(res);
 	}
 	fclose(inf);
@@ -70,6 +72,8 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 		sprintf(benchmark_cmd[5], "%s", MBA_STR);
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
+	if (is_intel && res)
+		ksft_print_msg("Intel CMT and MBM counters may be inaccurate when Sub-NUMA Clustering (SNC) is enabled. Ensure SNC is disabled in the BIOS if this system supports SNC.\n");
 	mbm_test_cleanup();
 }
 
@@ -106,6 +110,8 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 		sprintf(benchmark_cmd[5], "%s", CMT_STR);
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 	ksft_test_result(!res, "CMT: test\n");
+	if (is_intel && res)
+		ksft_print_msg("Intel CMT and MBM counters may be inaccurate when Sub-NUMA Clustering (SNC) is enabled. Ensure SNC is disabled in the BIOS if this system supports SNC.\n");
 	cmt_test_cleanup();
 }
 
@@ -207,8 +213,8 @@ int main(int argc, char **argv)
 	if (geteuid() != 0)
 		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
 
-	/* Detect AMD vendor */
-	detect_amd();
+	/* Detect AMD/INTEL vendor */
+	detect_vendor();
 
 	if (has_ben) {
 		/* Extract benchmark command from command line. */
-- 
2.27.0

