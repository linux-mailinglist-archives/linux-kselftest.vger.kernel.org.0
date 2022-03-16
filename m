Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835274DAA2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 07:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353763AbiCPGDF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 02:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353746AbiCPGDA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 02:03:00 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884D960064;
        Tue, 15 Mar 2022 23:01:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="45955051"
X-IronPort-AV: E=Sophos;i="5.90,185,1643641200"; 
   d="scan'208";a="45955051"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Mar 2022 15:01:42 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id AC5F1E9029;
        Wed, 16 Mar 2022 15:01:41 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 85B3211097C;
        Wed, 16 Mar 2022 15:01:40 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 6F221403FA055;
        Wed, 16 Mar 2022 15:01:40 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v4 1/2] selftest/resctrl: Extend cpu vendor detection
Date:   Wed, 16 Mar 2022 14:59:39 +0900
Message-Id: <20220316055940.292550-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com>
References: <20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com>
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

Currently, the resctrl_tests only has a function to detect amd vendor.
Since when the Intel Sub-NUMA Clustering feature is enabled,
Intel CMT and MBM counters may not be accurate,
the resctrl_tests also need a function to detect intel vendor.
And in the future, resctrl_tests will need a function to detect different
vendors, such as arm.

Extend the function to detect intel vendor as well. Also,
this function can be easily extended to detect other venders.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     |  5 ++-
 .../testing/selftests/resctrl/resctrl_tests.c | 41 ++++++++++++-------
 tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
 4 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index cd4f68388e0f..2daa63991628 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -89,7 +89,7 @@ static int check_results(struct resctrl_val_param *param)
 
 	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
 			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
-			       !is_amd, false);
+			       (get_vendor() != ARCH_AMD), false);
 }
 
 void cat_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 1ad10c47e31d..f0ded31fb3c7 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -34,6 +34,9 @@
 #define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
 #define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
 
+#define ARCH_INTEL     1
+#define ARCH_AMD       2
+
 #define PARENT_EXIT(err_msg)			\
 	do {					\
 		perror(err_msg);		\
@@ -75,8 +78,8 @@ struct resctrl_val_param {
 extern pid_t bm_pid, ppid;
 
 extern char llc_occup_path[1024];
-extern bool is_amd;
 
+int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
 int remount_resctrlfs(bool mum_resctrlfs);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 973f09a66e1e..dc548d3e2454 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -13,25 +13,41 @@
 #define BENCHMARK_ARGS		64
 #define BENCHMARK_ARG_SIZE	64
 
-bool is_amd;
-
-void detect_amd(void)
+static int detect_vendor(void)
 {
 	FILE *inf = fopen("/proc/cpuinfo", "r");
 	char *res;
+	char *s = NULL;
+	int vendor_id = 0;
 
 	if (!inf)
-		return;
+		return vendor_id;
 
 	res = fgrep(inf, "vendor_id");
 
-	if (res) {
-		char *s = strchr(res, ':');
+	if (res)
+		s = strchr(res, ':');
+
+	if (s && !strcmp(s, ": GenuineIntel\n"))
+		vendor_id = ARCH_INTEL;
+	else if (s && !strcmp(s, ": AuthenticAMD\n"))
+		vendor_id =  ARCH_AMD;
 
-		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
-		free(res);
-	}
 	fclose(inf);
+	free(res);
+	return vendor_id;
+}
+
+int get_vendor(void)
+{
+	static int vendor = -1;
+
+	if (vendor == -1)
+		vendor = detect_vendor();
+	if (vendor == 0)
+		ksft_print_msg("Can not get vendor info...\n");
+
+	return vendor;
 }
 
 static void cmd_help(void)
@@ -207,9 +223,6 @@ int main(int argc, char **argv)
 	if (geteuid() != 0)
 		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
 
-	/* Detect AMD vendor */
-	detect_amd();
-
 	if (has_ben) {
 		/* Extract benchmark command from command line. */
 		for (i = ben_ind; i < argc; i++) {
@@ -241,10 +254,10 @@ int main(int argc, char **argv)
 
 	ksft_set_plan(tests ? : 4);
 
-	if (!is_amd && mbm_test)
+	if ((get_vendor() != ARCH_AMD) && mbm_test)
 		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (!is_amd && mba_test)
+	if ((get_vendor() != ARCH_AMD) && mba_test)
 		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
 	if (cmt_test)
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 5f5a166ade60..6f543e470ad4 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -106,7 +106,7 @@ int get_resource_id(int cpu_no, int *resource_id)
 	char phys_pkg_path[1024];
 	FILE *fp;
 
-	if (is_amd)
+	if (get_vendor() == ARCH_AMD)
 		sprintf(phys_pkg_path, "%s%d/cache/index3/id",
 			PHYS_ID_PATH, cpu_no);
 	else
-- 
2.27.0

