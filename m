Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5CD1D8A84
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgERWOG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:14:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:46561 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgERWOF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:14:05 -0400
IronPort-SDR: TuQ8jM+7vX6DM96eeZDnsYG4wkDgz1sphHWkAlO5DMR2ngQur/Mn/7D+W/Fg4TrZa2TifPBzyO
 P7EZZ6sOdbEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:14:04 -0700
IronPort-SDR: 4F1jBJOvWspkwsl6o0wHoHsf4buKogWvuR3qEHR+A5jDdP/umr2EedjLmzfO/v7d7P7EsPPyni
 JaXbIFHaf3kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420476"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:14:04 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 19/19] selftests/resctrl: Fix checking for < 0 for unsigned values
Date:   Mon, 18 May 2020 15:08:39 -0700
Message-Id: <75653a26f64e19c5b87827b1cdfd7b8c95a3de31.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dan reported that he noticed following static checker warnings

	tools/testing/selftests/resctrl/resctrl_val.c:545 measure_vals()
	warn: 'bw_imc' unsigned <= 0

	tools/testing/selftests/resctrl/resctrl_val.c:549 measure_vals()
	warn: 'bw_resc_end' unsigned <= 0

These warnings are reported because
1. measure_vals() declares 'bw_imc' and 'bw_resc_end' as unsigned long
   variables
2. Return value of get_mem_bw_imc() and get_mem_bw_resctrl() are assigned
   to 'bw_imc' and 'bw_resc_end' respectively
3. The return values are checked for <=0 to see if the calls were
   successful or not

Checking for < 0 for an unsigned value doesn't make any sense. So, to
fix this issue, change the implementation of get_mem_bw_imc() and
get_mem_bw_resctrl() such that they now accept reference to a variable
and set the variable appropriately upon success and return 0, else return
<0 on error.

Fixes: 7f4d257e3a2a: "selftests/resctrl: Add callback to start a benchmark"
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 33 ++++++++++---------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 94f3a34e21bb..003457b16ce7 100644
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
@@ -374,12 +374,13 @@ static float get_mem_bw_imc(int cpu_no, char *bw_report)
 	}
 
 	if (strcmp(bw_report, "reads") == 0)
-		return reads;
+		*bw_imc = reads;
 
 	if (strcmp(bw_report, "writes") == 0)
-		return writes;
+		*bw_imc = writes;
 
-	return (reads + writes);
+	*bw_imc = reads + writes;
+	return 0;
 }
 
 void set_mbm_path(const char *ctrlgrp, const char *mongrp, int resource_id)
@@ -438,9 +439,8 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
  * 1. If con_mon grp is given, then read from it
  * 2. If con_mon grp is not given, then read from root con_mon grp
  */
-static unsigned long get_mem_bw_resctrl(void)
+static int get_mem_bw_resctrl(unsigned long *mbm_total)
 {
-	unsigned long mbm_total = 0;
 	FILE *fp;
 
 	fp = fopen(mbm_total_path, "r");
@@ -449,7 +449,7 @@ static unsigned long get_mem_bw_resctrl(void)
 
 		return -1;
 	}
-	if (fscanf(fp, "%lu", &mbm_total) <= 0) {
+	if (fscanf(fp, "%lu", mbm_total) <= 0) {
 		perror("Could not get mbm local bytes");
 		fclose(fp);
 
@@ -457,7 +457,7 @@ static unsigned long get_mem_bw_resctrl(void)
 	}
 	fclose(fp);
 
-	return mbm_total;
+	return 0;
 }
 
 pid_t bm_pid, ppid;
@@ -549,7 +549,8 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 static int
 measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
 {
-	unsigned long bw_imc, bw_resc, bw_resc_end;
+	unsigned long bw_resc, bw_resc_end;
+	float bw_imc;
 	int ret;
 
 	/*
@@ -559,13 +560,13 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
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
2.19.1

