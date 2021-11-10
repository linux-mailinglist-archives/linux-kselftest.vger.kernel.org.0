Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2144BCF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 09:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhKJIio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 03:38:44 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:2972 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhKJIio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 03:38:44 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 03:38:43 EST
IronPort-SDR: bRvmrCCjfmNJ3KhaQEZRWVpVap0DobbxEc57XaKm52SmvUtN4yhWWq0pEvgblv1iAuBoxt/Wkz
 tKphh5icNRZCeB4Hvti2bK63F+qJ+lIfDgqonvD6HNpbzTPxpKsvApGKEA+ZBWaF6NbWQkJ5Bs
 3UjVPVMcZyGVBRtZAe8Wj1l+2tlYWjxTA6ItuPgwy081FQMWsy31WsxvggGbeKIf0BP3erFhUO
 KqQGajx6VALqiuZtORALUCSw7o4TCQA35Jhh6bZoFDSE6Vb8he038saJdQGMpv0PXG289tX0tH
 y9HJLm4z9iqxlrLrdoX7Giys
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="31702384"
X-IronPort-AV: E=Sophos;i="5.87,223,1631545200"; 
   d="scan'208";a="31702384"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 10 Nov 2021 17:28:27 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 18A96122D1B;
        Wed, 10 Nov 2021 17:28:27 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4B89FDA65B;
        Wed, 10 Nov 2021 17:28:26 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 6EFFC4019A4C3;
        Wed, 10 Nov 2021 17:28:25 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH] selftests/resctrl: Skip MBM&CMT tests when Intel Sub-NUMA
Date:   Wed, 10 Nov 2021 17:27:34 +0900
Message-Id: <20211110082734.3184985-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>

When the Intel Sub-NUMA Clustering(SNC) feature is enabled,
the CMT and MBM counters may not be accurate.
In this case, skip MBM&CMT tests.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Hello,

According to the Intel RDT reference Manual, 
when the sub-numa clustering feature is enabled, the CMT and MBM counters may not be accurate.
When running CMT tests and MBM tests on Intel processor, the result is "not ok".
So, fix it to skip the CMT & MBM test When the Intel Sub-NUMA Clustering(SNC) feature is enabled.

Thanks,

 tools/testing/selftests/resctrl/resctrl.h       |  1 +
 tools/testing/selftests/resctrl/resctrl_tests.c | 51 +++++++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c     | 26 +++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 1ad10c4..8e82ce3 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -85,6 +85,7 @@ struct resctrl_val_param {
 int validate_bw_report_request(char *bw_report);
 bool validate_resctrl_feature_request(const char *resctrl_val);
 char *fgrep(FILE *inf, const char *str);
+char *fgrep_last_match_line(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
 void run_benchmark(int signum, siginfo_t *info, void *ucontext);
 int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 973f09a..122aab6 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -8,12 +8,15 @@
  *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
  *    Fenghua Yu <fenghua.yu@intel.com>
  */
+#include <numa.h>
+#include <string.h>
 #include "resctrl.h"
 
 #define BENCHMARK_ARGS		64
 #define BENCHMARK_ARG_SIZE	64
 
 bool is_amd;
+bool sub_numa_cluster_enable;
 
 void detect_amd(void)
 {
@@ -34,6 +37,35 @@ void detect_amd(void)
 	fclose(inf);
 }
 
+void check_sub_numa_cluster(void)
+{
+	FILE *inf = fopen("/proc/cpuinfo", "r");
+	char *res, *s;
+	int socket_num = 0;
+	int numa_nodes = 0;
+
+	if (!inf)
+		return;
+
+	res = fgrep_last_match_line(inf, "physical id");
+
+	if (res) {
+		s = strpbrk(res, "1234567890");
+		socket_num = atoi(s) + 1;
+		free(res);
+	}
+	fclose(inf);
+
+	numa_nodes = numa_max_node() + 1;
+
+	/*
+	 * when the Sub-NUMA Clustering(SNC) feature is enabled,
+	 * the number of numa nodes is twice the number of sockets.
+	 */
+	if (numa_nodes == (2 * socket_num))
+		sub_numa_cluster_enable = true;
+}
+
 static void cmd_help(void)
 {
 	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
@@ -61,6 +93,13 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 
 	ksft_print_msg("Starting MBM BW change ...\n");
 
+	/* when the Sub-NUMA Clustering(SNC) feature is enabled,
+	 * the CMT and MBM counters may not be accurate
+	 */
+	if (sub_numa_cluster_enable) {
+		ksft_test_result_skip("Sub-NUMA Clustering(SNC) feature is enabled, the MBM counters may not be accurate.\n");
+		return;
+	}
 	if (!validate_resctrl_feature_request(MBM_STR)) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
 		return;
@@ -97,6 +136,14 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 	int res;
 
 	ksft_print_msg("Starting CMT test ...\n");
+
+	/* when the Sub-NUMA Clustering(SNC) feature is enabled,
+	 * the CMT and MBM counters may not be accurate
+	 */
+	if (sub_numa_cluster_enable) {
+		ksft_test_result_skip("Sub-NUMA Clustering(SNC) feature is enabled, the CMT counters may not be accurate.\n");
+		return;
+	}
 	if (!validate_resctrl_feature_request(CMT_STR)) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
 		return;
@@ -210,6 +257,10 @@ int main(int argc, char **argv)
 	/* Detect AMD vendor */
 	detect_amd();
 
+	/* check whether sub numa clustering is enable or not */
+	if (!is_amd)
+		check_sub_numa_cluster();
+
 	if (has_ben) {
 		/* Extract benchmark command from command line. */
 		for (i = ben_ind; i < argc; i++) {
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 5f5a166..1908ecb 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -606,6 +606,32 @@ char *fgrep(FILE *inf, const char *str)
 }
 
 /*
+ * Find the last matched line.
+ * Return a pointer to the string of the matched line,
+ * else retuen NULL if no matched line
+ */
+char *fgrep_last_match_line(FILE *inf, const char *str)
+{
+	char line[256];
+	char result_line[256];
+	int slen = strlen(str);
+
+	while (!feof(inf)) {
+		if (!fgets(line, 256, inf))
+			break;
+		if (strncmp(line, str, slen))
+			continue;
+
+		strcpy(result_line, line);
+	}
+
+	if (strlen(result_line) >= slen)
+		return strdup(result_line);
+
+	return NULL;
+}
+
+/*
  * validate_resctrl_feature_request - Check if requested feature is valid.
  * @resctrl_val:	Requested feature
  *
-- 
1.8.3.1

