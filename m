Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6875313FB4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 22:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbgAPVWL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 16:22:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:38731 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388890AbgAPVWK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 16:22:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 13:22:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="226870946"
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
Subject: [RESEND PATCH v9 06/13] selftests/resctrl: Add MBM test
Date:   Thu, 16 Jan 2020 13:32:39 -0800
Message-Id: <1579210366-55429-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
References: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MBM (Memory Bandwidth Monitoring) test is the first implemented selftest.
It starts a stressful memory bandwidth benchmark and assigns the
bandwidth pid in a resctrl monitoring group. Read and compare perf IMC
counter and MBM total bytes for the benchmark. The numbers should be
close enough to pass the test.

Default benchmark is built-in fill_buf. But users can specify their
own benchmark by option "-b".

We can add memory bandwidth monitoring for multiple processes in the
future.

Co-developed-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Co-developed-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/Makefile      |   7 +-
 tools/testing/selftests/resctrl/mbm_test.c    | 145 ++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h     |   6 +
 .../testing/selftests/resctrl/resctrl_tests.c | 132 ++++++++++++++++
 tools/testing/selftests/resctrl/resctrl_val.c |   2 +
 tools/testing/selftests/resctrl/resctrlfs.c   |  77 ++++++++++
 6 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 76bbd6d3e4a8..d585cc1948cc 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -3,10 +3,15 @@ CFLAGS = -g -Wall
 SRCS=$(wildcard *.c)
 OBJS=$(SRCS:.c=.o)
 
+all: resctrl_tests
+
 $(OBJS): $(SRCS)
 	$(CC) $(CFLAGS) -c $(SRCS)
 
+resctrl_tests: $(OBJS)
+	$(CC) $(CFLAGS) -o $@ $^
+
 .PHONY: clean
 
 clean:
-	$(RM) $(OBJS)
+	$(RM) $(OBJS) resctrl_tests
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
new file mode 100644
index 000000000000..4700f7453f81
--- /dev/null
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory Bandwidth Monitoring (MBM) test
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+#define RESULT_FILE_NAME	"result_mbm"
+#define MAX_DIFF		300
+#define NUM_OF_RUNS		5
+
+static void
+show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
+{
+	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
+	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+	long avg_diff = 0;
+	int runs;
+
+	/*
+	 * Discard the first value which is inaccurate due to monitoring setup
+	 * transition phase.
+	 */
+	for (runs = 1; runs < NUM_OF_RUNS ; runs++) {
+		sum_bw_imc += bw_imc[runs];
+		sum_bw_resc += bw_resc[runs];
+	}
+
+	avg_bw_imc = sum_bw_imc / 4;
+	avg_bw_resc = sum_bw_resc / 4;
+	avg_diff = avg_bw_resc - avg_bw_imc;
+
+	printf("%sok MBM: diff within %d%%\n",
+	       labs(avg_diff) > MAX_DIFF ? "not " : "", MAX_DIFF);
+	tests_run++;
+	printf("# avg_diff: %lu\n", labs(avg_diff));
+	printf("# Span (MB): %d\n", span);
+	printf("# avg_bw_imc: %lu\n", avg_bw_imc);
+	printf("# avg_bw_resc: %lu\n", avg_bw_resc);
+}
+
+static int check_results(int span)
+{
+	unsigned long bw_imc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
+	char temp[1024], *token_array[8];
+	char output[] = RESULT_FILE_NAME;
+	int runs;
+	FILE *fp;
+
+	printf("# Checking for pass/fail\n");
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
+		int i = 0;
+
+		while (token) {
+			token_array[i++] = token;
+			token = strtok(NULL, ":\t");
+		}
+
+		bw_resc[runs] = strtoul(token_array[5], NULL, 0);
+		bw_imc[runs] = strtoul(token_array[3], NULL, 0);
+		runs++;
+	}
+
+	show_bw_info(bw_imc, bw_resc, span);
+
+	fclose(fp);
+
+	return 0;
+}
+
+static int mbm_setup(int num, ...)
+{
+	struct resctrl_val_param *p;
+	static int num_of_runs;
+	va_list param;
+	int ret = 0;
+
+	/* Run NUM_OF_RUNS times */
+	if (num_of_runs++ >= NUM_OF_RUNS)
+		return -1;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	/* Set up shemata with 100% allocation on the first run. */
+	if (num_of_runs == 0)
+		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
+				     p->resctrl_val);
+
+	return ret;
+}
+
+void mbm_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME);
+}
+
+int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
+{
+	struct resctrl_val_param param = {
+		.resctrl_val	= "mbm",
+		.ctrlgrp	= "c1",
+		.mongrp		= "m1",
+		.span		= span,
+		.cpu_no		= cpu_no,
+		.mum_resctrlfs	= 1,
+		.filename	= RESULT_FILE_NAME,
+		.bw_report	=  bw_report,
+		.setup		= mbm_setup
+	};
+	int ret;
+
+	remove(RESULT_FILE_NAME);
+
+	if (!validate_resctrl_feature_request("mbm"))
+		return -1;
+
+	ret = resctrl_val(benchmark_cmd, &param);
+	if (ret)
+		return ret;
+
+	ret = check_results(span);
+	if (ret)
+		return ret;
+
+	mbm_test_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index fb42087c904d..c92bc50c6751 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -57,7 +57,10 @@ struct resctrl_val_param {
 };
 
 pid_t bm_pid, ppid;
+int tests_run;
 
+bool check_resctrlfs_support(void);
+int filter_dmesg(void);
 int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
 int umount_resctrlfs(void);
@@ -75,5 +78,8 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
 		 int op, char *resctrl_va);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
+int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd);
+void tests_cleanup(void);
+void mbm_test_cleanup(void);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
new file mode 100644
index 000000000000..496c8030fe43
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Resctrl tests
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+#define BENCHMARK_ARGS		64
+#define BENCHMARK_ARG_SIZE	64
+
+static void cmd_help(void)
+{
+	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list]\n");
+	printf("\t-b benchmark_cmd [options]: run specified benchmark\n");
+	printf("\t default benchmark is builtin fill_buf\n");
+	printf("\t-t test list: run tests specified in the test list, ");
+	printf("e.g. -t mbm,mba\n");
+	printf("\t-h: help\n");
+}
+
+void tests_cleanup(void)
+{
+	mbm_test_cleanup();
+}
+
+int main(int argc, char **argv)
+{
+	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, ben_ind;
+	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
+	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
+	bool has_ben = false, mbm_test = true;
+	int ben_count;
+
+	for (i = 0; i < argc; i++) {
+		if (strcmp(argv[i], "-b") == 0) {
+			ben_ind = i + 1;
+			ben_count = argc - ben_ind;
+			argc_new = ben_ind - 1;
+			has_ben = true;
+			break;
+		}
+	}
+
+	while ((c = getopt(argc_new, argv, "ht:b:")) != -1) {
+		char *token;
+
+		switch (c) {
+		case 't':
+			token = strtok(optarg, ",");
+
+			mbm_test = false;
+			while (token) {
+				if (!strcmp(token, "mbm")) {
+					mbm_test = true;
+				} else {
+					printf("invalid argument\n");
+
+					return -1;
+				}
+				token = strtok(NULL, ":\t");
+			}
+			break;
+		case 'p':
+			cpu_no = atoi(optarg);
+			break;
+		case 'h':
+			cmd_help();
+
+			return 0;
+		default:
+			printf("invalid argument\n");
+
+			return -1;
+		}
+	}
+
+	printf("TAP version 13\n");
+
+	/*
+	 * Typically we need root privileges, because:
+	 * 1. We write to resctrl FS
+	 * 2. We execute perf commands
+	 */
+	if (geteuid() != 0)
+		printf("# WARNING: not running as root, tests may fail.\n");
+
+	if (has_ben) {
+		/* Extract benchmark command from command line. */
+		for (i = ben_ind; i < argc; i++) {
+			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
+			sprintf(benchmark_cmd[i - ben_ind], "%s", argv[i]);
+		}
+		benchmark_cmd[ben_count] = NULL;
+	} else {
+		/* If no benchmark is given by "-b" argument, use fill_buf. */
+		for (i = 0; i < 6; i++)
+			benchmark_cmd[i] = benchmark_cmd_area[i];
+
+		strcpy(benchmark_cmd[0], "fill_buf");
+		sprintf(benchmark_cmd[1], "%d", span);
+		strcpy(benchmark_cmd[2], "1");
+		strcpy(benchmark_cmd[3], "1");
+		strcpy(benchmark_cmd[4], "0");
+		strcpy(benchmark_cmd[5], "");
+		benchmark_cmd[6] = NULL;
+	}
+
+	sprintf(bw_report, "reads");
+	sprintf(bm_type, "fill_buf");
+
+	check_resctrlfs_support();
+	filter_dmesg();
+
+	if (mbm_test) {
+		printf("# Starting MBM BW change ...\n");
+		if (!has_ben)
+			sprintf(benchmark_cmd[5], "%s", "mba");
+		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
+		printf("%sok MBM: bw change\n", res ? "not " : "");
+		mbm_test_cleanup();
+		tests_run++;
+	}
+
+	printf("1..%d\n", tests_run);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 0d1bd03ec4be..4f7bd5a4d86e 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -435,6 +435,8 @@ pid_t bm_pid, ppid;
 static void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
 	kill(bm_pid, SIGKILL);
+	umount_resctrlfs();
+	tests_cleanup();
 	printf("Ending\n\n");
 
 	exit(EXIT_SUCCESS);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 1b125f9d8e5d..07c8394b427f 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -388,6 +388,41 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	return ret;
 }
 
+bool check_resctrlfs_support(void)
+{
+	FILE *inf = fopen("/proc/filesystems", "r");
+	DIR *dp;
+	char *res;
+	bool ret = false;
+
+	if (!inf)
+		return false;
+
+	res = fgrep(inf, "nodev\tresctrl\n");
+
+	if (res) {
+		ret = true;
+		free(res);
+	}
+
+	fclose(inf);
+
+	printf("%sok kernel supports resctrl filesystem\n", ret ? "" : "not ");
+	tests_run++;
+
+	dp = opendir(RESCTRL_PATH);
+	printf("%sok resctrl mountpoint \"%s\" exists\n",
+	       dp ? "" : "not ", RESCTRL_PATH);
+	if (dp)
+		closedir(dp);
+	tests_run++;
+
+	printf("# resctrl filesystem %s mounted\n",
+	       find_resctrl_mount(NULL) ? "not" : "is");
+
+	return ret;
+}
+
 char *fgrep(FILE *inf, const char *str)
 {
 	char line[256];
@@ -433,6 +468,48 @@ bool validate_resctrl_feature_request(char *resctrl_val)
 	return found;
 }
 
+int filter_dmesg(void)
+{
+	char line[1024];
+	FILE *fp;
+	int pipefds[2];
+	pid_t pid;
+	int ret;
+
+	ret = pipe(pipefds);
+	if (ret) {
+		perror("pipe");
+		return ret;
+	}
+	pid = fork();
+	if (pid == 0) {
+		close(pipefds[0]);
+		dup2(pipefds[1], STDOUT_FILENO);
+		execlp("dmesg", "dmesg", NULL);
+		perror("executing dmesg");
+		exit(1);
+	}
+	close(pipefds[1]);
+	fp = fdopen(pipefds[0], "r");
+	if (!fp) {
+		perror("fdopen(pipe)");
+		kill(pid, SIGTERM);
+
+		return -1;
+	}
+
+	while (fgets(line, 1024, fp)) {
+		if (strstr(line, "intel_rdt:"))
+			printf("# dmesg: %s", line);
+		if (strstr(line, "resctrl:"))
+			printf("# dmesg: %s", line);
+	}
+	fclose(fp);
+	waitpid(pid, NULL, 0);
+
+	return 0;
+}
+
 int validate_bw_report_request(char *bw_report)
 {
 	if (strcmp(bw_report, "reads") == 0)
-- 
2.19.1

