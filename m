Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5352F29459C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439370AbgJTXwI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:52:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:11170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439400AbgJTXvj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:39 -0400
IronPort-SDR: WUzWOB5lYL0N4mZedbaeENaYbZFf6vmZFUiV2XnoyxBNwcud32foVJQ0Kq+UUYXnnxROhQIZ19
 YM5CTYsCc5UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486370"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486370"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:33 -0700
IronPort-SDR: Us20K3CBo3ru3wmGQnMap/rI7C+t6tTb/cIr0y0zRg9vc3vI5q/QY2wgHirvdf6Dip+yZK01k4
 Y3GO8dOMpTmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833897"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:33 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 19/21] selftests/resctrl: Fix checking for < 0 for unsigned values
Date:   Tue, 20 Oct 2020 23:51:24 +0000
Message-Id: <20201020235126.1871815-20-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dan reported following static checker warnings

tools/testing/selftests/resctrl/resctrl_val.c:545 measure_vals()
warn: 'bw_imc' unsigned <= 0

tools/testing/selftests/resctrl/resctrl_val.c:549 measure_vals()
warn: 'bw_resc_end' unsigned <= 0

These warnings are reported because
1. measure_vals() declares 'bw_imc' and 'bw_resc_end' as unsigned long
   variables
2. Return value of get_mem_bw_imc() and get_mem_bw_resctrl() are assigned
   to 'bw_imc' and 'bw_resc_end' respectively
3. The returned values are checked for <= 0 to see if the calls failed

Checking for < 0 for an unsigned value doesn't make any sense.

Fix this issue by changing the implementation of get_mem_bw_imc() and
get_mem_bw_resctrl() such that they now accept reference to a variable
and set the variable appropriately upon success and return 0, else return
< 0 on error.

Fixes: 7f4d257e3a2a ("selftests/resctrl: Add callback to start a benchmark")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 41 +++++++++++--------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 88f9b641d753..f723d8534cf2 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -300,9 +300,9 @@ static int initialize_mem_bw_imc(void)
  * Memory B/W utilized by a process on a socket can be calculated using
  * iMC counters. Perf events are used to read these counters.
  *
- * Return: >= 0 on success. < 0 on failure.
+ * Return: = 0 on success. < 0 on failure.
  */
-static float get_mem_bw_imc(int cpu_no, char *bw_report)
+static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 {
 	float reads, writes, of_mul_read, of_mul_write;
 	int imc, j, ret;
@@ -373,13 +373,18 @@ static float get_mem_bw_imc(int cpu_no, char *bw_report)
 		close(imc_counters_config[imc][WRITE].fd);
 	}
 
-	if (strcmp(bw_report, "reads") == 0)
-		return reads;
+	if (strcmp(bw_report, "reads") == 0) {
+		*bw_imc = reads;
+		return 0;
+	}
 
-	if (strcmp(bw_report, "writes") == 0)
-		return writes;
+	if (strcmp(bw_report, "writes") == 0) {
+		*bw_imc = writes;
+		return 0;
+	}
 
-	return (reads + writes);
+	*bw_imc = reads + writes;
+	return 0;
 }
 
 void set_mbm_path(const char *ctrlgrp, const char *mongrp, int resource_id)
@@ -438,9 +443,8 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
  * 1. If con_mon grp is given, then read from it
  * 2. If con_mon grp is not given, then read from root con_mon grp
  */
-static unsigned long get_mem_bw_resctrl(void)
+static int get_mem_bw_resctrl(unsigned long *mbm_total)
 {
-	unsigned long mbm_total = 0;
 	FILE *fp;
 
 	fp = fopen(mbm_total_path, "r");
@@ -449,7 +453,7 @@ static unsigned long get_mem_bw_resctrl(void)
 
 		return -1;
 	}
-	if (fscanf(fp, "%lu", &mbm_total) <= 0) {
+	if (fscanf(fp, "%lu", mbm_total) <= 0) {
 		perror("Could not get mbm local bytes");
 		fclose(fp);
 
@@ -457,7 +461,7 @@ static unsigned long get_mem_bw_resctrl(void)
 	}
 	fclose(fp);
 
-	return mbm_total;
+	return 0;
 }
 
 pid_t bm_pid, ppid;
@@ -549,7 +553,8 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 static int
 measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
 {
-	unsigned long bw_imc, bw_resc, bw_resc_end;
+	unsigned long bw_resc, bw_resc_end;
+	float bw_imc;
 	int ret;
 
 	/*
@@ -559,13 +564,13 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
 	 * Compare the two values to validate resctrl value.
 	 * It takes 1sec to measure the data.
 	 */
-	bw_imc = get_mem_bw_imc(param->cpu_no, param->bw_report);
-	if (bw_imc <= 0)
-		return bw_imc;
+	ret = get_mem_bw_imc(param->cpu_no, param->bw_report, &bw_imc);
+	if (ret < 0)
+		return ret;
 
-	bw_resc_end = get_mem_bw_resctrl();
-	if (bw_resc_end <= 0)
-		return bw_resc_end;
+	ret = get_mem_bw_resctrl(&bw_resc_end);
+	if (ret < 0)
+		return ret;
 
 	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
 	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
-- 
2.29.0

