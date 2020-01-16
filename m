Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809E413FB51
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 22:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbgAPVWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 16:22:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:38730 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388850AbgAPVWK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 16:22:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 13:22:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="226870950"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2020 13:22:09 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "linux-kselftest" <linux-kselftest@vger.kernel.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RESEND PATCH v9 07/13] selftests/resctrl: Add MBA test
Date:   Thu, 16 Jan 2020 13:32:40 -0800
Message-Id: <1579210366-55429-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
References: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MBA (Memory Bandwidth Allocation) test starts a stressful memory
bandwidth benchmark and allocates memory bandwidth from 100% down
to 10% for the benchmark process. For each allocation, compare
perf IMC counter and mbm total bytes from resctrl. The difference
between the two values should be within a threshold to pass the test.

Default benchmark is built-in fill_buf. But users can specify their
own benchmark by option "-b".

We can add memory bandwidth allocation for multiple processes in the
future.

Co-developed-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Co-developed-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c    | 171 ++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h     |   2 +
 .../testing/selftests/resctrl/resctrl_tests.c |  16 +-
 3 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/resctrl/mba_test.c

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
new file mode 100644
index 000000000000..7bf8eaa6204b
--- /dev/null
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory Bandwidth Allocation (MBA) test
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+#define RESULT_FILE_NAME	"result_mba"
+#define NUM_OF_RUNS		5
+#define MAX_DIFF		300
+#define ALLOCATION_MAX		100
+#define ALLOCATION_MIN		10
+#define ALLOCATION_STEP		10
+
+/*
+ * Change schemata percentage from 100 to 10%. Write schemata to specified
+ * con_mon grp, mon_grp in resctrl FS.
+ * For each allocation, run 5 times in order to get average values.
+ */
+static int mba_setup(int num, ...)
+{
+	static int runs_per_allocation, allocation = 100;
+	struct resctrl_val_param *p;
+	char allocation_str[64];
+	va_list param;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	if (runs_per_allocation >= NUM_OF_RUNS)
+		runs_per_allocation = 0;
+
+	/* Only set up schemata once every NUM_OF_RUNS of allocations */
+	if (runs_per_allocation++ != 0)
+		return 0;
+
+	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
+		return -1;
+
+	sprintf(allocation_str, "%d", allocation);
+
+	write_schemata(p->ctrlgrp, allocation_str, p->cpu_no, p->resctrl_val);
+	allocation -= ALLOCATION_STEP;
+
+	return 0;
+}
+
+static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
+{
+	int allocation, runs;
+	bool failed = false;
+
+	printf("# Results are displayed in (MB)\n");
+	/* Memory bandwidth from 100% down to 10% */
+	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
+	     allocation++) {
+		unsigned long avg_bw_imc, avg_bw_resc;
+		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+		unsigned long avg_diff;
+
+		/*
+		 * The first run is discarded due to inaccurate value from
+		 * phase transition.
+		 */
+		for (runs = NUM_OF_RUNS * allocation + 1;
+		     runs < NUM_OF_RUNS * allocation + NUM_OF_RUNS ; runs++) {
+			sum_bw_imc += bw_imc[runs];
+			sum_bw_resc += bw_resc[runs];
+		}
+
+		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
+		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
+		avg_diff = labs((long)(avg_bw_resc - avg_bw_imc));
+
+		printf("%sok MBA schemata percentage %u smaller than %d %%\n",
+		       avg_diff > MAX_DIFF ? "not " : "",
+		       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
+		       MAX_DIFF);
+		tests_run++;
+		printf("# avg_diff: %lu\n", avg_diff);
+		printf("# avg_bw_imc: %lu\n", avg_bw_imc);
+		printf("# avg_bw_resc: %lu\n", avg_bw_resc);
+		if (avg_diff > MAX_DIFF)
+			failed = true;
+	}
+
+	printf("%sok schemata change using MBA%s\n", failed ? "not " : "",
+	       failed ? " # at least one test failed" : "");
+	tests_run++;
+}
+
+static int check_results(void)
+{
+	char *token_array[8], output[] = RESULT_FILE_NAME, temp[512];
+	unsigned long bw_imc[1024], bw_resc[1024];
+	int runs;
+	FILE *fp;
+
+	fp = fopen(output, "r");
+	if (!fp) {
+		perror(output);
+
+		return errno;
+	}
+
+	runs = 0;
+	while (fgets(temp, sizeof(temp), fp)) {
+		char *token = strtok(temp, ":\t");
+		int fields = 0;
+
+		while (token) {
+			token_array[fields++] = token;
+			token = strtok(NULL, ":\t");
+		}
+
+		/* Field 3 is perf imc value */
+		bw_imc[runs] = strtoul(token_array[3], NULL, 0);
+		/* Field 5 is resctrl value */
+		bw_resc[runs] = strtoul(token_array[5], NULL, 0);
+		runs++;
+	}
+
+	fclose(fp);
+
+	show_mba_info(bw_imc, bw_resc);
+
+	return 0;
+}
+
+void mba_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME);
+}
+
+int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
+{
+	struct resctrl_val_param param = {
+		.resctrl_val	= "mba",
+		.ctrlgrp	= "c1",
+		.mongrp		= "m1",
+		.cpu_no		= cpu_no,
+		.mum_resctrlfs	= 1,
+		.filename	= RESULT_FILE_NAME,
+		.bw_report	= bw_report,
+		.setup		= mba_setup
+	};
+	int ret;
+
+	remove(RESULT_FILE_NAME);
+
+	if (!validate_resctrl_feature_request("mba"))
+		return -1;
+
+	ret = resctrl_val(benchmark_cmd, &param);
+	if (ret)
+		return ret;
+
+	ret = check_results();
+	if (ret)
+		return ret;
+
+	mba_test_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index c92bc50c6751..a6196ab6b59f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -81,5 +81,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
+int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
+void mba_test_cleanup(void);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 496c8030fe43..0ed953a97db2 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -26,6 +26,7 @@ static void cmd_help(void)
 void tests_cleanup(void)
 {
 	mbm_test_cleanup();
+	mba_test_cleanup();
 }
 
 int main(int argc, char **argv)
@@ -33,7 +34,7 @@ int main(int argc, char **argv)
 	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, ben_ind;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
-	bool has_ben = false, mbm_test = true;
+	bool has_ben = false, mbm_test = true, mba_test = true;
 	int ben_count;
 
 	for (i = 0; i < argc; i++) {
@@ -54,9 +55,12 @@ int main(int argc, char **argv)
 			token = strtok(optarg, ",");
 
 			mbm_test = false;
+			mba_test = false;
 			while (token) {
 				if (!strcmp(token, "mbm")) {
 					mbm_test = true;
+				} else if (!strcmp(token, "mba")) {
+					mba_test = true;
 				} else {
 					printf("invalid argument\n");
 
@@ -126,6 +130,16 @@ int main(int argc, char **argv)
 		tests_run++;
 	}
 
+	if (mba_test) {
+		printf("# Starting MBA Schemata change ...\n");
+		if (!has_ben)
+			sprintf(benchmark_cmd[1], "%d", span);
+		res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
+		printf("%sok MBA: schemata change\n", res ? "not " : "");
+		mba_test_cleanup();
+		tests_run++;
+	}
+
 	printf("1..%d\n", tests_run);
 
 	return 0;
-- 
2.19.1

