Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA613FB52
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 22:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388850AbgAPVWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 16:22:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:38730 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388905AbgAPVWL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 16:22:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 13:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="226870960"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2020 13:22:10 -0800
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
Subject: [RESEND PATCH v9 09/13] selftests/resctrl: Add Cache Allocation Technology (CAT) selftest
Date:   Thu, 16 Jan 2020 13:32:42 -0800
Message-Id: <1579210366-55429-10-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
References: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cache Allocation Technology (CAT) selftest allocates a portion of
last level cache and starts a benchmark to read each cache
line in this portion of cache. Measure the cache misses in perf and
the misses should be equal to the number of cache lines in this
portion of cache.

We don't use CQM to calculate cache usage because some CAT enabled
platforms don't have CQM.

Co-developed-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Co-developed-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cache.c       | 175 +++++++++++-
 tools/testing/selftests/resctrl/cat_test.c    | 250 ++++++++++++++++++
 tools/testing/selftests/resctrl/fill_buf.c    |  10 +-
 tools/testing/selftests/resctrl/resctrl.h     |   3 +
 .../testing/selftests/resctrl/resctrl_tests.c |  15 +-
 tools/testing/selftests/resctrl/resctrlfs.c   |   3 +-
 6 files changed, 451 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/cat_test.c

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index d7719219ab51..38dbf4962e33 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -10,8 +10,105 @@ struct read_format {
 	} values[2];
 };
 
+static struct perf_event_attr pea_llc_miss;
+static struct read_format rf_cqm;
+static int fd_lm;
 char llc_occup_path[1024];
 
+static void initialize_perf_event_attr(void)
+{
+	pea_llc_miss.type = PERF_TYPE_HARDWARE;
+	pea_llc_miss.size = sizeof(struct perf_event_attr);
+	pea_llc_miss.read_format = PERF_FORMAT_GROUP;
+	pea_llc_miss.exclude_kernel = 1;
+	pea_llc_miss.exclude_hv = 1;
+	pea_llc_miss.exclude_idle = 1;
+	pea_llc_miss.exclude_callchain_kernel = 1;
+	pea_llc_miss.inherit = 1;
+	pea_llc_miss.exclude_guest = 1;
+	pea_llc_miss.disabled = 1;
+}
+
+static void ioctl_perf_event_ioc_reset_enable(void)
+{
+	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
+	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
+}
+
+static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
+{
+	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
+				PERF_FLAG_FD_CLOEXEC);
+	if (fd_lm == -1) {
+		perror("Error opening leader");
+		ctrlc_handler(0, NULL, NULL);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int initialize_llc_perf(void)
+{
+	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
+	memset(&rf_cqm, 0, sizeof(struct read_format));
+
+	/* Initialize perf_event_attr structures for HW_CACHE_MISSES */
+	initialize_perf_event_attr();
+
+	pea_llc_miss.config = PERF_COUNT_HW_CACHE_MISSES;
+
+	rf_cqm.nr = 1;
+
+	return 0;
+}
+
+static int reset_enable_llc_perf(pid_t pid, int cpu_no)
+{
+	int ret = 0;
+
+	ret = perf_event_open_llc_miss(pid, cpu_no);
+	if (ret < 0)
+		return ret;
+
+	/* Start counters to log values */
+	ioctl_perf_event_ioc_reset_enable();
+
+	return 0;
+}
+
+/*
+ * get_llc_perf:	llc cache miss through perf events
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ *
+ * Perf events like HW_CACHE_MISSES could be used to validate number of
+ * cache lines allocated.
+ *
+ * Return: =0 on success.  <0 on failure.
+ */
+static int get_llc_perf(unsigned long *llc_perf_miss)
+{
+	__u64 total_misses;
+
+	/* Stop counters after one span to get miss rate */
+
+	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
+
+	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
+		perror("Could not get llc misses through perf");
+
+		return -1;
+	}
+
+	total_misses = rf_cqm.values[0].value;
+
+	close(fd_lm);
+
+	*llc_perf_miss = total_misses;
+
+	return 0;
+}
+
 /*
  * Get LLC Occupancy as reported by RESCTRL FS
  * For CQM,
@@ -79,9 +176,19 @@ static int print_results_cache(char *filename, int bm_pid,
 
 int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 {
-	unsigned long llc_occu_resc = 0, llc_value = 0;
+	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
 	int ret;
 
+	/*
+	 * Measure cache miss from perf.
+	 */
+	if (!strcmp(param->resctrl_val, "cat")) {
+		ret = get_llc_perf(&llc_perf_miss);
+		if (ret < 0)
+			return ret;
+		llc_value = llc_perf_miss;
+	}
+
 	/*
 	 * Measure llc occupancy from resctrl.
 	 */
@@ -97,3 +204,69 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 
 	return 0;
 }
+
+/*
+ * cache_val:		execute benchmark and measure LLC occupancy resctrl
+ * and perf cache miss for the benchmark
+ * @param:		parameters passed to cache_val()
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+int cat_val(struct resctrl_val_param *param)
+{
+	int malloc_and_init_memory = 1, memflush = 1, operation = 0, ret = 0;
+	char *resctrl_val = param->resctrl_val;
+	pid_t bm_pid;
+
+	if (strcmp(param->filename, "") == 0)
+		sprintf(param->filename, "stdio");
+
+	bm_pid = getpid();
+
+	/* Taskset benchmark to specified cpu */
+	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	if (ret)
+		return ret;
+
+	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				      resctrl_val);
+	if (ret)
+		return ret;
+
+	if ((strcmp(resctrl_val, "cat") == 0)) {
+		ret = initialize_llc_perf();
+		if (ret)
+			return ret;
+	}
+
+	/* Test runs until the callback setup() tells the test to stop. */
+	while (1) {
+		if (strcmp(resctrl_val, "cat") == 0) {
+			ret = param->setup(1, param);
+			if (ret) {
+				ret = 0;
+				break;
+			}
+			ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
+			if (ret)
+				break;
+
+			if (run_fill_buf(param->span, malloc_and_init_memory,
+					 memflush, operation, resctrl_val)) {
+				fprintf(stderr, "Error-running fill buffer\n");
+				ret = -1;
+				break;
+			}
+
+			sleep(1);
+			ret = measure_cache_vals(param, bm_pid);
+			if (ret)
+				break;
+		} else {
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
new file mode 100644
index 000000000000..c194fcc42407
--- /dev/null
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cache Allocation Technology (CAT) test
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
+#define RESULT_FILE_NAME1	"result_cat1"
+#define RESULT_FILE_NAME2	"result_cat2"
+#define NUM_OF_RUNS		5
+#define MAX_DIFF_PERCENT	4
+#define MAX_DIFF		1000000
+
+int count_of_bits;
+char cbm_mask[256];
+unsigned long long_mask;
+unsigned long cache_size;
+
+/*
+ * Change schemata. Write schemata to specified
+ * con_mon grp, mon_grp in resctrl FS.
+ * Run 5 times in order to get average values.
+ */
+static int cat_setup(int num, ...)
+{
+	struct resctrl_val_param *p;
+	char schemata[64];
+	va_list param;
+	int ret = 0;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	/* Run NUM_OF_RUNS times */
+	if (p->num_of_runs >= NUM_OF_RUNS)
+		return -1;
+
+	if (p->num_of_runs == 0) {
+		sprintf(schemata, "%lx", p->mask);
+		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
+				     p->resctrl_val);
+	}
+	p->num_of_runs++;
+
+	return ret;
+}
+
+static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
+			    unsigned long span)
+{
+	unsigned long allocated_cache_lines = span / 64;
+	unsigned long avg_llc_perf_miss = 0;
+	float diff_percent;
+
+	avg_llc_perf_miss = sum_llc_perf_miss / (NUM_OF_RUNS - 1);
+	diff_percent = ((float)allocated_cache_lines - avg_llc_perf_miss) /
+				allocated_cache_lines * 100;
+
+	printf("%sok CAT: cache miss rate within %d%%\n",
+	       abs((int)diff_percent) > MAX_DIFF_PERCENT ? "not " : "",
+	       MAX_DIFF_PERCENT);
+	tests_run++;
+	printf("# Percent diff=%d\n", abs((int)diff_percent));
+	printf("# Number of bits: %d\n", no_of_bits);
+	printf("# Avg_llc_perf_miss: %lu\n", avg_llc_perf_miss);
+	printf("# Allocated cache lines: %lu\n", allocated_cache_lines);
+}
+
+static int check_results(struct resctrl_val_param *param)
+{
+	char *token_array[8], temp[512];
+	unsigned long sum_llc_perf_miss = 0;
+	int runs = 0, no_of_bits = 0;
+	FILE *fp;
+
+	printf("# Checking for pass/fail\n");
+	fp = fopen(param->filename, "r");
+	if (!fp) {
+		perror("# Cannot open file");
+
+		return errno;
+	}
+
+	while (fgets(temp, sizeof(temp), fp)) {
+		char *token = strtok(temp, ":\t");
+		int fields = 0;
+
+		while (token) {
+			token_array[fields++] = token;
+			token = strtok(NULL, ":\t");
+		}
+		/*
+		 * Discard the first value which is inaccurate due to monitoring
+		 * setup transition phase.
+		 */
+		if (runs > 0)
+			sum_llc_perf_miss += strtoul(token_array[3], NULL, 0);
+		runs++;
+	}
+
+	fclose(fp);
+	no_of_bits = count_bits(param->mask);
+
+	show_cache_info(sum_llc_perf_miss, no_of_bits, param->span);
+
+	return 0;
+}
+
+void cat_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME1);
+	remove(RESULT_FILE_NAME2);
+}
+
+int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
+{
+	unsigned long l_mask, l_mask_1;
+	int ret, pipefd[2], sibling_cpu_no;
+	char pipe_message;
+	pid_t bm_pid;
+
+	cache_size = 0;
+
+	ret = remount_resctrlfs(true);
+	if (ret)
+		return ret;
+
+	if (!validate_resctrl_feature_request("cat"))
+		return -1;
+
+	/* Get default cbm mask for L3/L2 cache */
+	ret = get_cbm_mask(cache_type);
+	if (ret)
+		return ret;
+
+	long_mask = strtoul(cbm_mask, NULL, 16);
+
+	/* Get L3/L2 cache size */
+	ret = get_cache_size(cpu_no, cache_type, &cache_size);
+	if (ret)
+		return ret;
+	printf("cache size :%lu\n", cache_size);
+
+	/* Get max number of bits from default-cabm mask */
+	count_of_bits = count_bits(long_mask);
+
+	if (n < 1 || n > count_of_bits - 1) {
+		printf("Invalid input value for no_of_bits n!\n");
+		printf("Please Enter value in range 1 to %d\n",
+		       count_of_bits - 1);
+		return -1;
+	}
+
+	/* Get core id from same socket for running another thread */
+	sibling_cpu_no = get_core_sibling(cpu_no);
+	if (sibling_cpu_no < 0)
+		return -1;
+
+	struct resctrl_val_param param = {
+		.resctrl_val	= "cat",
+		.cpu_no		= cpu_no,
+		.mum_resctrlfs	= 0,
+		.setup		= cat_setup,
+	};
+
+	l_mask = long_mask >> n;
+	l_mask_1 = ~l_mask & long_mask;
+
+	/* Set param values for parent thread which will be allocated bitmask
+	 * with (max_bits - n) bits
+	 */
+	param.span = cache_size * (count_of_bits - n) / count_of_bits;
+	strcpy(param.ctrlgrp, "c2");
+	strcpy(param.mongrp, "m2");
+	strcpy(param.filename, RESULT_FILE_NAME2);
+	param.mask = l_mask;
+	param.num_of_runs = 0;
+
+	if (pipe(pipefd)) {
+		perror("# Unable to create pipe");
+		return errno;
+	}
+
+	bm_pid = fork();
+
+	/* Set param values for child thread which will be allocated bitmask
+	 * with n bits
+	 */
+	if (bm_pid == 0) {
+		param.mask = l_mask_1;
+		strcpy(param.ctrlgrp, "c1");
+		strcpy(param.mongrp, "m1");
+		param.span = cache_size * n / count_of_bits;
+		strcpy(param.filename, RESULT_FILE_NAME1);
+		param.num_of_runs = 0;
+		param.cpu_no = sibling_cpu_no;
+	}
+
+	remove(param.filename);
+
+	ret = cat_val(&param);
+	if (ret)
+		return ret;
+
+	ret = check_results(&param);
+	if (ret)
+		return ret;
+
+	if (bm_pid == 0) {
+		/* Tell parent that child is ready */
+		close(pipefd[0]);
+		pipe_message = 1;
+		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
+		    sizeof(pipe_message)) {
+			close(pipefd[1]);
+			perror("# failed signaling parent process");
+			return errno;
+		}
+
+		close(pipefd[1]);
+		while (1)
+			;
+	} else {
+		/* Parent waits for child to be ready. */
+		close(pipefd[1]);
+		pipe_message = 0;
+		while (pipe_message != 1) {
+			if (read(pipefd[0], &pipe_message,
+				 sizeof(pipe_message)) < sizeof(pipe_message)) {
+				perror("# failed reading from child process");
+				break;
+			}
+		}
+		close(pipefd[0]);
+		kill(bm_pid, SIGKILL);
+	}
+
+	cat_test_cleanup();
+	if (bm_pid)
+		umount_resctrlfs();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index b76bf6a4a0a5..84d2a8b9657a 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -113,8 +113,11 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 	int ret = 0;
 	FILE *fp;
 
-	while (1)
+	while (1) {
 		ret = fill_one_span_read(start_ptr, end_ptr);
+		if (!strcmp(resctrl_val, "cat"))
+			break;
+	}
 
 	/* Consume read result so that reading memory is not optimized out. */
 	fp = fopen("/dev/null", "w");
@@ -129,8 +132,11 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 			    char *resctrl_val)
 {
-	while (1)
+	while (1) {
 		fill_one_span_write(start_ptr, end_ptr);
+		if (!strcmp(resctrl_val, "cat"))
+			break;
+	}
 
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index ae0a3b5aa83d..99659639e580 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -94,6 +94,9 @@ void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
+int cat_val(struct resctrl_val_param *param);
+void cat_test_cleanup(void);
+int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
 int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cqm_test_cleanup(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 70179a61df3b..7f75b0b01bb5 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -19,7 +19,7 @@ static void cmd_help(void)
 	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM");
 	printf("\t default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
-	printf("e.g. -t mbm, mba, cqm\n");
+	printf("e.g. -t mbm, mba, cqm, cat\n");
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
 	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
 	printf("\t-h: help\n");
@@ -30,6 +30,7 @@ void tests_cleanup(void)
 	mbm_test_cleanup();
 	mba_test_cleanup();
 	cqm_test_cleanup();
+	cat_test_cleanup();
 }
 
 int main(int argc, char **argv)
@@ -39,6 +40,7 @@ int main(int argc, char **argv)
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int ben_ind, ben_count;
+	bool cat_test = true;
 
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "-b") == 0) {
@@ -60,6 +62,7 @@ int main(int argc, char **argv)
 			mbm_test = false;
 			mba_test = false;
 			cqm_test = false;
+			cat_test = false;
 			while (token) {
 				if (!strcmp(token, "mbm")) {
 					mbm_test = true;
@@ -67,6 +70,8 @@ int main(int argc, char **argv)
 					mba_test = true;
 				} else if (!strcmp(token, "cqm")) {
 					cqm_test = true;
+				} else if (!strcmp(token, "cat")) {
+					cat_test = true;
 				} else {
 					printf("invalid argument\n");
 
@@ -159,6 +164,14 @@ int main(int argc, char **argv)
 		tests_run++;
 	}
 
+	if (cat_test) {
+		printf("# Starting CAT test ...\n");
+		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
+		printf("%sok CAT: test\n", res ? "not " : "");
+		tests_run++;
+		cat_test_cleanup();
+	}
+
 	printf("1..%d\n", tests_run);
 
 	return 0;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 9c050a6c1723..8772c8c4d5d0 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -501,6 +501,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	FILE *fp;
 
 	if ((strcmp(resctrl_val, "mba") != 0) &&
+	    (strcmp(resctrl_val, "cat") != 0) &&
 	    (strcmp(resctrl_val, "cqm") != 0))
 		return -ENOENT;
 
@@ -522,7 +523,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
-	if (!strcmp(resctrl_val, "cqm"))
+	if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cqm"))
 		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
 	if (strcmp(resctrl_val, "mba") == 0)
 		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
-- 
2.19.1

