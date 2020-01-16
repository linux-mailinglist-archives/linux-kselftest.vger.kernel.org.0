Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0913FB50
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 22:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbgAPVWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 16:22:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:38728 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388901AbgAPVWL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 16:22:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 13:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="226870954"
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
Subject: [RESEND PATCH v9 08/13] selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest
Date:   Thu, 16 Jan 2020 13:32:41 -0800
Message-Id: <1579210366-55429-9-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
References: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cache QoS Monitoring (CQM) selftest starts stressful cache benchmark
with specified size of memory to access the cache. Last Level cache
occupancy reported by CQM should be close to the size of the memory.

Co-developed-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Co-developed-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cache.c       |  99 +++++++++
 tools/testing/selftests/resctrl/cqm_test.c    | 176 ++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h     |  16 ++
 .../testing/selftests/resctrl/resctrl_tests.c |  31 ++-
 tools/testing/selftests/resctrl/resctrl_val.c |  63 +++++-
 tools/testing/selftests/resctrl/resctrlfs.c   | 193 +++++++++++++++++-
 6 files changed, 558 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/cache.c
 create mode 100644 tools/testing/selftests/resctrl/cqm_test.c

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
new file mode 100644
index 000000000000..d7719219ab51
--- /dev/null
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdint.h>
+#include "resctrl.h"
+
+struct read_format {
+	__u64 nr;			/* The number of events */
+	struct {
+		__u64 value;		/* The value of the event */
+	} values[2];
+};
+
+char llc_occup_path[1024];
+
+/*
+ * Get LLC Occupancy as reported by RESCTRL FS
+ * For CQM,
+ * 1. If con_mon grp and mon grp given, then read from mon grp in
+ * con_mon grp
+ * 2. If only con_mon grp given, then read from con_mon grp
+ * 3. If both not given, then read from root con_mon grp
+ * For CAT,
+ * 1. If con_mon grp given, then read from it
+ * 2. If con_mon grp not given, then read from root con_mon grp
+ *
+ * Return: =0 on success.  <0 on failure.
+ */
+static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
+{
+	FILE *fp;
+
+	fp = fopen(llc_occup_path, "r");
+	if (!fp) {
+		perror("Failed to open results file");
+
+		return errno;
+	}
+	if (fscanf(fp, "%lu", llc_occupancy) <= 0) {
+		perror("Could not get llc occupancy");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * print_results_cache:	the cache results are stored in a file
+ * @filename:		file that stores the results
+ * @bm_pid:		child pid that runs benchmark
+ * @llc_value:		perf miss value /
+ *			llc occupancy value reported by resctrl FS
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+static int print_results_cache(char *filename, int bm_pid,
+			       unsigned long llc_value)
+{
+	FILE *fp;
+
+	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
+		printf("Pid: %d \t LLC_value: %lu\n", bm_pid,
+		       llc_value);
+	} else {
+		fp = fopen(filename, "a");
+		if (!fp) {
+			perror("Cannot open results file");
+
+			return errno;
+		}
+		fprintf(fp, "Pid: %d \t llc_value: %lu\n", bm_pid, llc_value);
+		fclose(fp);
+	}
+
+	return 0;
+}
+
+int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
+{
+	unsigned long llc_occu_resc = 0, llc_value = 0;
+	int ret;
+
+	/*
+	 * Measure llc occupancy from resctrl.
+	 */
+	if (!strcmp(param->resctrl_val, "cqm")) {
+		ret = get_llc_occu_resctrl(&llc_occu_resc);
+		if (ret < 0)
+			return ret;
+		llc_value = llc_occu_resc;
+	}
+	ret = print_results_cache(param->filename, bm_pid, llc_value);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cqm_test.c
new file mode 100644
index 000000000000..c8756152bd61
--- /dev/null
+++ b/tools/testing/selftests/resctrl/cqm_test.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cache Monitoring Technology (CQM) test
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+#include <unistd.h>
+
+#define RESULT_FILE_NAME	"result_cqm"
+#define NUM_OF_RUNS		5
+#define MAX_DIFF		2000000
+#define MAX_DIFF_PERCENT	15
+
+int count_of_bits;
+char cbm_mask[256];
+unsigned long long_mask;
+unsigned long cache_size;
+
+static int cqm_setup(int num, ...)
+{
+	struct resctrl_val_param *p;
+	va_list param;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	/* Run NUM_OF_RUNS times */
+	if (p->num_of_runs >= NUM_OF_RUNS)
+		return -1;
+
+	p->num_of_runs++;
+
+	return 0;
+}
+
+static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
+			    unsigned long span)
+{
+	unsigned long avg_llc_occu_resc = 0;
+	float diff_percent;
+	long avg_diff = 0;
+	bool res;
+
+	avg_llc_occu_resc = sum_llc_occu_resc / (NUM_OF_RUNS - 1);
+	avg_diff = (long)abs(span - avg_llc_occu_resc);
+
+	diff_percent = (((float)span - avg_llc_occu_resc) / span) * 100;
+
+	if ((abs((int)diff_percent) <= MAX_DIFF_PERCENT) ||
+	    (abs(avg_diff) <= MAX_DIFF))
+		res = true;
+	else
+		res = false;
+
+	printf("%sok CQM: diff within %d, %d\%%\n", res ? "" : "not",
+	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
+
+	printf("# diff: %ld\n", avg_diff);
+	printf("# percent diff=%d\n", abs((int)diff_percent));
+	printf("# Results are displayed in (Bytes)\n");
+	printf("# Number of bits: %d\n", no_of_bits);
+	printf("# Avg_llc_occu_resc: %lu\n", avg_llc_occu_resc);
+	printf("# llc_occu_exp (span): %lu\n", span);
+
+	tests_run++;
+}
+
+static int check_results(struct resctrl_val_param *param, int no_of_bits)
+{
+	char *token_array[8], temp[512];
+	unsigned long sum_llc_occu_resc = 0;
+	int runs = 0;
+	FILE *fp;
+
+	printf("# checking for pass/fail\n");
+	fp = fopen(param->filename, "r");
+	if (!fp) {
+		perror("# Error in opening file\n");
+
+		return errno;
+	}
+
+	while (fgets(temp, 1024, fp)) {
+		char *token = strtok(temp, ":\t");
+		int fields = 0;
+
+		while (token) {
+			token_array[fields++] = token;
+			token = strtok(NULL, ":\t");
+		}
+
+		/* Field 3 is llc occ resc value */
+		if (runs > 0)
+			sum_llc_occu_resc += strtoul(token_array[3], NULL, 0);
+		runs++;
+	}
+	fclose(fp);
+	show_cache_info(sum_llc_occu_resc, no_of_bits, param->span);
+
+	return 0;
+}
+
+void cqm_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME);
+}
+
+int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
+{
+	int ret, mum_resctrlfs;
+
+	cache_size = 0;
+	mum_resctrlfs = 1;
+
+	ret = remount_resctrlfs(mum_resctrlfs);
+	if (ret)
+		return ret;
+
+	if (!validate_resctrl_feature_request("cqm"))
+		return -1;
+
+	ret = get_cbm_mask("L3");
+	if (ret)
+		return ret;
+
+	long_mask = strtoul(cbm_mask, NULL, 16);
+
+	ret = get_cache_size(cpu_no, "L3", &cache_size);
+	if (ret)
+		return ret;
+	printf("cache size :%lu\n", cache_size);
+
+	count_of_bits = count_bits(long_mask);
+
+	if (n < 1 || n > count_of_bits) {
+		printf("Invalid input value for numbr_of_bits n!\n");
+		printf("Please Enter value in range 1 to %d\n", count_of_bits);
+		return -1;
+	}
+
+	struct resctrl_val_param param = {
+		.resctrl_val	= "cqm",
+		.ctrlgrp	= "c1",
+		.mongrp		= "m1",
+		.cpu_no		= cpu_no,
+		.mum_resctrlfs	= 0,
+		.filename	= RESULT_FILE_NAME,
+		.mask		= ~(long_mask << n) & long_mask,
+		.span		= cache_size * n / count_of_bits,
+		.num_of_runs	= 0,
+		.setup		= cqm_setup,
+	};
+
+	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
+		sprintf(benchmark_cmd[1], "%lu", param.span);
+
+	remove(RESULT_FILE_NAME);
+
+	ret = resctrl_val(benchmark_cmd, &param);
+	if (ret)
+		return ret;
+
+	ret = check_results(&param, n);
+	if (ret)
+		return ret;
+
+	cqm_test_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index a6196ab6b59f..ae0a3b5aa83d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -18,12 +18,16 @@
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/select.h>
+#include <sys/time.h>
+#include <sys/eventfd.h>
 #include <asm/unistd.h>
 #include <linux/perf_event.h>
 
 #define MB			(1024 * 1024)
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
+#define CBM_MASK_PATH		"/sys/fs/resctrl/info"
 
 #define PARENT_EXIT(err_msg)			\
 	do {					\
@@ -53,12 +57,16 @@ struct resctrl_val_param {
 	int		mum_resctrlfs;
 	char		filename[64];
 	char		*bw_report;
+	unsigned long	mask;
+	int		num_of_runs;
 	int		(*setup)(int num, ...);
 };
 
 pid_t bm_pid, ppid;
 int tests_run;
 
+char llc_occup_path[1024];
+
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
 int remount_resctrlfs(bool mum_resctrlfs);
@@ -83,5 +91,13 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
 void mba_test_cleanup(void);
+int get_cbm_mask(char *cache_type);
+int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
+void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
+int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
+unsigned int count_bits(unsigned long n);
+void cqm_test_cleanup(void);
+int get_core_sibling(int cpu_no);
+int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 0ed953a97db2..70179a61df3b 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -15,11 +15,13 @@
 
 static void cmd_help(void)
 {
-	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list]\n");
-	printf("\t-b benchmark_cmd [options]: run specified benchmark\n");
+	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
+	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM");
 	printf("\t default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
-	printf("e.g. -t mbm,mba\n");
+	printf("e.g. -t mbm, mba, cqm\n");
+	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
+	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
 	printf("\t-h: help\n");
 }
 
@@ -27,15 +29,16 @@ void tests_cleanup(void)
 {
 	mbm_test_cleanup();
 	mba_test_cleanup();
+	cqm_test_cleanup();
 }
 
 int main(int argc, char **argv)
 {
-	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, ben_ind;
+	bool has_ben = false, mbm_test = true, mba_test = true, cqm_test = true;
+	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
-	bool has_ben = false, mbm_test = true, mba_test = true;
-	int ben_count;
+	int ben_ind, ben_count;
 
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "-b") == 0) {
@@ -56,11 +59,14 @@ int main(int argc, char **argv)
 
 			mbm_test = false;
 			mba_test = false;
+			cqm_test = false;
 			while (token) {
 				if (!strcmp(token, "mbm")) {
 					mbm_test = true;
 				} else if (!strcmp(token, "mba")) {
 					mba_test = true;
+				} else if (!strcmp(token, "cqm")) {
+					cqm_test = true;
 				} else {
 					printf("invalid argument\n");
 
@@ -72,6 +78,9 @@ int main(int argc, char **argv)
 		case 'p':
 			cpu_no = atoi(optarg);
 			break;
+		case 'n':
+			no_of_bits = atoi(optarg);
+			break;
 		case 'h':
 			cmd_help();
 
@@ -140,6 +149,16 @@ int main(int argc, char **argv)
 		tests_run++;
 	}
 
+	if (cqm_test) {
+		printf("# Starting CQM test ...\n");
+		if (!has_ben)
+			sprintf(benchmark_cmd[5], "%s", "cqm");
+		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
+		printf("%sok CQM: test\n", res ? "not " : "");
+		cqm_test_cleanup();
+		tests_run++;
+	}
+
 	printf("1..%d\n", tests_run);
 
 	return 0;
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 4f7bd5a4d86e..520fea3606d1 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -31,6 +31,18 @@
 #define MBM_LOCAL_BYTES_PATH			\
 	"%s/mon_data/mon_L3_%02d/mbm_local_bytes"
 
+#define CON_MON_LCC_OCCUP_PATH		\
+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
+
+#define CON_LCC_OCCUP_PATH		\
+	"%s/%s/mon_data/mon_L3_%02d/llc_occupancy"
+
+#define MON_LCC_OCCUP_PATH		\
+	"%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
+
+#define LCC_OCCUP_PATH			\
+	"%s/mon_data/mon_L3_%02d/llc_occupancy"
+
 struct membw_read_format {
 	__u64 value;         /* The value of the event */
 	__u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
@@ -432,7 +444,7 @@ static unsigned long get_mem_bw_resctrl(void)
 
 pid_t bm_pid, ppid;
 
-static void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
+void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
 	kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
@@ -480,6 +492,42 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
 	return 0;
 }
 
+static void set_cqm_path(const char *ctrlgrp, const char *mongrp, char sock_num)
+{
+	if (strlen(ctrlgrp) && strlen(mongrp))
+		sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
+			ctrlgrp, mongrp, sock_num);
+	else if (!strlen(ctrlgrp) && strlen(mongrp))
+		sprintf(llc_occup_path,	MON_LCC_OCCUP_PATH, RESCTRL_PATH,
+			mongrp, sock_num);
+	else if (strlen(ctrlgrp) && !strlen(mongrp))
+		sprintf(llc_occup_path,	CON_LCC_OCCUP_PATH, RESCTRL_PATH,
+			ctrlgrp, sock_num);
+	else if (!strlen(ctrlgrp) && !strlen(mongrp))
+		sprintf(llc_occup_path, LCC_OCCUP_PATH,	RESCTRL_PATH, sock_num);
+}
+
+/*
+ * initialize_llc_occu_resctrl:	Appropriately populate "llc_occup_path"
+ * @ctrlgrp:			Name of the control monitor group (con_mon grp)
+ * @mongrp:			Name of the monitor group (mon grp)
+ * @cpu_no:			CPU number that the benchmark PID is binded to
+ * @resctrl_val:		Resctrl feature (Eg: cat, cqm.. etc)
+ */
+static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
+					int cpu_no, char *resctrl_val)
+{
+	int resource_id;
+
+	if (get_resource_id(cpu_no, &resource_id) < 0) {
+		perror("# Unable to resource_id");
+		return;
+	}
+
+	if (strcmp(resctrl_val, "cqm") == 0)
+		set_cqm_path(ctrlgrp, mongrp, resource_id);
+}
+
 static int
 measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
 {
@@ -634,7 +682,9 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
 					  param->cpu_no, resctrl_val);
-	}
+	} else if (strcmp(resctrl_val, "cqm") == 0)
+		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
+					    param->cpu_no, resctrl_val);
 
 	/* Parent waits for child to be ready. */
 	close(pipefd[1]);
@@ -660,7 +710,8 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		if (strcmp(resctrl_val, "mbm") == 0) {
+		if ((strcmp(resctrl_val, "mbm") == 0) ||
+		    (strcmp(resctrl_val, "mba") == 0)) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
@@ -670,14 +721,14 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 			ret = measure_vals(param, &bw_resc_start);
 			if (ret)
 				break;
-		} else if ((strcmp(resctrl_val, "mba") == 0)) {
+		} else if (strcmp(resctrl_val, "cqm") == 0) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
 				break;
 			}
-
-			ret = measure_vals(param, &bw_resc_start);
+			sleep(1);
+			ret = measure_cache_vals(param, bm_pid);
 			if (ret)
 				break;
 		} else {
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 07c8394b427f..9c050a6c1723 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -49,6 +49,8 @@ static int find_resctrl_mount(char *buffer)
 	return -ENOENT;
 }
 
+char cbm_mask[256];
+
 /*
  * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
  * @mum_resctrlfs:	Should the resctrl FS be remounted?
@@ -130,6 +132,145 @@ int get_resource_id(int cpu_no, int *resource_id)
 	return 0;
 }
 
+/*
+ * get_cache_size - Get cache size for a specified CPU
+ * @cpu_no:	CPU number
+ * @cache_type:	Cache level L2/L3
+ * @cache_size:	pointer to cache_size
+ *
+ * Return: = 0 on success, < 0 on failure.
+ */
+int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
+{
+	char cache_path[1024], cache_str[64];
+	int length, i, cache_num;
+	FILE *fp;
+
+	if (!strcmp(cache_type, "L3")) {
+		cache_num = 3;
+	} else if (!strcmp(cache_type, "L2")) {
+		cache_num = 2;
+	} else {
+		perror("Invalid cache level");
+		return -1;
+	}
+
+	sprintf(cache_path, "/sys/bus/cpu/devices/cpu%d/cache/index%d/size",
+		cpu_no, cache_num);
+	fp = fopen(cache_path, "r");
+	if (!fp) {
+		perror("Failed to open cache size");
+
+		return -1;
+	}
+	if (fscanf(fp, "%s", cache_str) <= 0) {
+		perror("Could not get cache_size");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	length = (int)strlen(cache_str);
+
+	*cache_size = 0;
+
+	for (i = 0; i < length; i++) {
+		if ((cache_str[i] >= '0') && (cache_str[i] <= '9'))
+
+			*cache_size = *cache_size * 10 + (cache_str[i] - '0');
+
+		else if (cache_str[i] == 'K')
+
+			*cache_size = *cache_size * 1024;
+
+		else if (cache_str[i] == 'M')
+
+			*cache_size = *cache_size * 1024 * 1024;
+
+		else
+			break;
+	}
+
+	return 0;
+}
+
+#define CORE_SIBLINGS_PATH	"/sys/bus/cpu/devices/cpu"
+
+/*
+ * get_cbm_mask - Get cbm mask for given cache
+ * @cache_type:	Cache level L2/L3
+ *
+ * Mask is stored in cbm_mask which is global variable.
+ *
+ * Return: = 0 on success, < 0 on failure.
+ */
+int get_cbm_mask(char *cache_type)
+{
+	char cbm_mask_path[1024];
+	FILE *fp;
+
+	sprintf(cbm_mask_path, "%s/%s/cbm_mask", CBM_MASK_PATH, cache_type);
+
+	fp = fopen(cbm_mask_path, "r");
+	if (!fp) {
+		perror("Failed to open cache level");
+
+		return -1;
+	}
+	if (fscanf(fp, "%s", cbm_mask) <= 0) {
+		perror("Could not get max cbm_mask");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * get_core_sibling - Get sibling core id from the same socket for given CPU
+ * @cpu_no:	CPU number
+ *
+ * Return:	> 0 on success, < 0 on failure.
+ */
+int get_core_sibling(int cpu_no)
+{
+	char core_siblings_path[1024], cpu_list_str[64];
+	int sibling_cpu_no = -1;
+	FILE *fp;
+
+	sprintf(core_siblings_path, "%s%d/topology/core_siblings_list",
+		CORE_SIBLINGS_PATH, cpu_no);
+
+	fp = fopen(core_siblings_path, "r");
+	if (!fp) {
+		perror("Failed to open core siblings path");
+
+		return -1;
+	}
+	if (fscanf(fp, "%s", cpu_list_str) <= 0) {
+		perror("Could not get core_siblings list");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	char *token = strtok(cpu_list_str, "-,");
+
+	while (token) {
+		sibling_cpu_no = atoi(token);
+		/* Skipping core 0 as we don't want to run test on core 0 */
+		if (sibling_cpu_no != 0)
+			break;
+		token = strtok(NULL, "-,");
+	}
+
+	return sibling_cpu_no;
+}
+
 /*
  * taskset_benchmark - Taskset PID (i.e. benchmark) to a specified cpu
  * @bm_pid:	PID that should be binded
@@ -164,9 +305,10 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
  */
 void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
-	unsigned long span;
-	int operation, ret;
+	int operation, ret, malloc_and_init_memory, memflush;
+	unsigned long span, buffer_span;
 	char **benchmark_cmd;
+	char resctrl_val[64];
 	FILE *fp;
 
 	benchmark_cmd = info->si_ptr;
@@ -182,8 +324,18 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
 		/* Execute default fill_buf benchmark */
 		span = strtoul(benchmark_cmd[1], NULL, 10);
+		malloc_and_init_memory = atoi(benchmark_cmd[2]);
+		memflush =  atoi(benchmark_cmd[3]);
 		operation = atoi(benchmark_cmd[4]);
-		if (run_fill_buf(span, 1, 1, operation, NULL))
+		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
+
+		if (strcmp(resctrl_val, "cqm") != 0)
+			buffer_span = span * MB;
+		else
+			buffer_span = span;
+
+		if (run_fill_buf(buffer_span, malloc_and_init_memory, memflush,
+				 operation, resctrl_val))
 			fprintf(stderr, "Error in running fill buffer\n");
 	} else {
 		/* Execute specified benchmark */
@@ -210,6 +362,14 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 	struct dirent *ep;
 	DIR *dp;
 
+	/*
+	 * At this point, we are guaranteed to have resctrl FS mounted and if
+	 * length of grp_name == 0, it means, user wants to use root con_mon
+	 * grp, so do nothing
+	 */
+	if (strlen(grp_name) == 0)
+		return 0;
+
 	/* Check if requested grp exists or not */
 	dp = opendir(parent_grp);
 	if (dp) {
@@ -293,9 +453,10 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 	if (ret)
 		goto out;
 
-	/* Create mon grp and write pid into it for "mbm" test */
-	if ((strcmp(resctrl_val, "mbm") == 0)) {
-		if (mongrp) {
+	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
+	if ((strcmp(resctrl_val, "cqm") == 0) ||
+	    (strcmp(resctrl_val, "mbm") == 0)) {
+		if (strlen(mongrp)) {
 			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
 			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
 			ret = create_grp(mongrp, monitorgroup, monitorgroup_p);
@@ -339,7 +500,8 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	int resource_id, ret = 0;
 	FILE *fp;
 
-	if (strcmp(resctrl_val, "mba") != 0)
+	if ((strcmp(resctrl_val, "mba") != 0) &&
+	    (strcmp(resctrl_val, "cqm") != 0))
 		return -ENOENT;
 
 	if (!schemata) {
@@ -360,7 +522,10 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
-	sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
+	if (!strcmp(resctrl_val, "cqm"))
+		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
+	if (strcmp(resctrl_val, "mba") == 0)
+		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
 
 	fp = fopen(controlgroup, "w");
 	if (!fp) {
@@ -537,3 +702,15 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		      group_fd, flags);
 	return ret;
 }
+
+unsigned int count_bits(unsigned long n)
+{
+	unsigned int count = 0;
+
+	while (n) {
+		count += n & 1;
+		n >>= 1;
+	}
+
+	return count;
+}
-- 
2.19.1

