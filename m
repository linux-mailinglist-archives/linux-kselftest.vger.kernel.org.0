Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B423E472833
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 11:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbhLMKI5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 05:08:57 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139]:12481 "EHLO
        esa6.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241664AbhLMKFE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 05:05:04 -0500
IronPort-SDR: kFGPvSJf08lZZatBWifo1falkp1d1zeWLZhEtBJIsrLSw46QDlhu0asERdqhO4rjOXkNuL5dn0
 maG0m6l7Gd7xNC0wZmHuXMxc0hUPygf02aGiWgtZNVaytc6dGE6JCHFp0t4/uGf8K8Krcna9Eb
 daRKWBJskxzEyVV1WkoWp25ufONUOOc1YDUgUSt55TgVI67RlzjXJLHYxeit4v6HRZma20Z9AC
 rlioNtLwYWs9Rx/fCZ+LJsqrEbDd9Ka16bm5t/Jb4xpbZAJH2C6Wtit9XnEpTv1FwscbqGOUjk
 x313ZmDeIsPWBw0WKUTGdq0J
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="56381295"
X-IronPort-AV: E=Sophos;i="5.88,202,1635174000"; 
   d="scan'208";a="56381295"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Dec 2021 19:04:59 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B3B6226D7BB;
        Mon, 13 Dec 2021 19:04:58 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id ED588D95F3;
        Mon, 13 Dec 2021 19:04:57 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id D4E8F40467B5C;
        Mon, 13 Dec 2021 19:04:57 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v2] selftests/resctrl: Print a message if the result of MBM&CMT tests is failed when Intel Sub-NUMA is enabled
Date:   Mon, 13 Dec 2021 19:03:21 +0900
Message-Id: <20211213100321.181408-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If the result of MBM&CMT tests is failed when Intel
Sub-NUMA is enabled, print a possible causes of failure.
Since when the Intel Sub-NUMA Clustering(SNC) feature is enabled,
the CMT and MBM counters may not be accurate.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Hello,

According to the Intel RDT reference Manual,
when the sub-numa clustering feature is enabled,
the CMT and MBM counters may not be accurate.
When running CMT tests and MBM tests on 2nd Generation
Intel Xeon Scalable Processor, the result may be "not ok".
If result of MBM&CMT tests is failed when Intel Sub-NUMA is enabled,
fix it to print a possible cause of failure,
instead of SKIP these tests in v1.

Thanks,

 tools/testing/selftests/resctrl/Makefile      |  1 +
 tools/testing/selftests/resctrl/cmt_test.c    |  5 ++-
 tools/testing/selftests/resctrl/mbm_test.c    |  5 ++-
 tools/testing/selftests/resctrl/resctrl.h     |  2 ++
 .../testing/selftests/resctrl/resctrl_tests.c | 36 +++++++++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 26 ++++++++++++++
 6 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index adfd92145e12..6d257f40e6ac 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,7 @@
 #SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
+LDLIBS += -lnuma
 
 TEST_GEN_PROGS := resctrl_tests
 EXTRA_SOURCES := $(wildcard *.c)
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 8968e36db99d..c5a49444c5a0 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -136,8 +136,11 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 		return ret;
 
 	ret = check_results(&param, n);
-	if (ret)
+	if (ret) {
+		if (sub_numa_cluster_enable)
+			ksft_print_msg("Sub-NUMA Clustering(SNC) feature is enabled, the CMT counters may not be accurate.\n");
 		return ret;
+	}
 
 	cmt_test_cleanup();
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 8392e5c55ed0..7dc1bdf2d0b8 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -136,8 +136,11 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 		return ret;
 
 	ret = check_results(span);
-	if (ret)
+	if (ret) {
+		if (sub_numa_cluster_enable)
+			ksft_print_msg("Sub-NUMA Clustering(SNC) feature is enabled, the MBM counters may not be accurate.\n");
 		return ret;
+	}
 
 	mbm_test_cleanup();
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 1ad10c47e31d..4b8ad4fbd016 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -76,6 +76,7 @@ extern pid_t bm_pid, ppid;
 
 extern char llc_occup_path[1024];
 extern bool is_amd;
+extern bool sub_numa_cluster_enable;
 
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
@@ -85,6 +86,7 @@ int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 bool validate_resctrl_feature_request(const char *resctrl_val);
 char *fgrep(FILE *inf, const char *str);
+char *fgrep_last_match_line(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
 void run_benchmark(int signum, siginfo_t *info, void *ucontext);
 int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3be0895c492b..bbab4a7f37ed 100644
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
@@ -210,6 +242,10 @@ int main(int argc, char **argv)
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
index 5f5a166ade60..1908ecb14b70 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -605,6 +605,32 @@ char *fgrep(FILE *inf, const char *str)
 	return NULL;
 }
 
+/*
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
 /*
  * validate_resctrl_feature_request - Check if requested feature is valid.
  * @resctrl_val:	Requested feature
-- 
2.27.0

