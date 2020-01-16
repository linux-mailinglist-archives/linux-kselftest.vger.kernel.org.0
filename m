Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64DD13FB4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 22:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388895AbgAPVWK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 16:22:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:38730 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388850AbgAPVWJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 16:22:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 13:22:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="226870937"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2020 13:22:08 -0800
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
Subject: [RESEND PATCH v9 04/13] selftests/resctrl: Add callback to start a benchmark
Date:   Thu, 16 Jan 2020 13:32:37 -0800
Message-Id: <1579210366-55429-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
References: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

The callback starts a child process and puts the child pid in created
resctrl group with specified memory bandwidth in schemata. The child
starts running benchmark.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Co-developed-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  29 +
 tools/testing/selftests/resctrl/resctrl_val.c | 574 ++++++++++++++++++
 2 files changed, 603 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index ba98cd6efc64..fb42087c904d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -3,6 +3,8 @@
 #ifndef RESCTRL_H
 #define RESCTRL_H
 #include <stdio.h>
+#include <stdarg.h>
+#include <math.h>
 #include <errno.h>
 #include <sched.h>
 #include <stdlib.h>
@@ -19,6 +21,7 @@
 #include <asm/unistd.h>
 #include <linux/perf_event.h>
 
+#define MB			(1024 * 1024)
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 
@@ -29,10 +32,35 @@
 		exit(EXIT_FAILURE);		\
 	} while (0)
 
+/*
+ * resctrl_val_param:	resctrl test parameters
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ * @ctrlgrp:		Name of the control monitor group (con_mon grp)
+ * @mongrp:		Name of the monitor group (mon grp)
+ * @cpu_no:		CPU number to which the benchmark would be binded
+ * @span:		Memory bytes accessed in each benchmark iteration
+ * @mum_resctrlfs:	Should the resctrl FS be remounted?
+ * @filename:		Name of file to which the o/p should be written
+ * @bw_report:		Bandwidth report type (reads vs writes)
+ * @setup:		Call back function to setup test environment
+ */
+struct resctrl_val_param {
+	char		*resctrl_val;
+	char		ctrlgrp[64];
+	char		mongrp[64];
+	int		cpu_no;
+	unsigned long	span;
+	int		mum_resctrlfs;
+	char		filename[64];
+	char		*bw_report;
+	int		(*setup)(int num, ...);
+};
+
 pid_t bm_pid, ppid;
 
 int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
+int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 bool validate_resctrl_feature_request(char *resctrl_val);
 char *fgrep(FILE *inf, const char *str);
@@ -46,5 +74,6 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
 		 int op, char *resctrl_va);
+int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 0ca4c9252516..0d1bd03ec4be 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -47,6 +47,8 @@ struct imc_counter_config {
 	int fd;
 };
 
+static char mbm_total_path[1024];
+static int imcs;
 static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
 
 void membw_initialize_perf_event_attr(int i, int j)
@@ -115,3 +117,575 @@ void get_event_and_umask(char *cas_count_cfg, int count, bool op)
 		}
 	}
 }
+
+static int open_perf_event(int i, int cpu_no, int j)
+{
+	imc_counters_config[i][j].fd =
+		perf_event_open(&imc_counters_config[i][j].pe, -1, cpu_no, -1,
+				PERF_FLAG_FD_CLOEXEC);
+
+	if (imc_counters_config[i][j].fd == -1) {
+		fprintf(stderr, "Error opening leader %llx\n",
+			imc_counters_config[i][j].pe.config);
+
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Get type and config (read and write) of an iMC counter */
+static int read_from_imc_dir(char *imc_dir, int count)
+{
+	char cas_count_cfg[1024], imc_counter_cfg[1024], imc_counter_type[1024];
+	FILE *fp;
+
+	/* Get type of iMC counter */
+	sprintf(imc_counter_type, "%s%s", imc_dir, "type");
+	fp = fopen(imc_counter_type, "r");
+	if (!fp) {
+		perror("Failed to open imc counter type file");
+
+		return -1;
+	}
+	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
+		perror("Could not get imc type");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	imc_counters_config[count][WRITE].type =
+				imc_counters_config[count][READ].type;
+
+	/* Get read config */
+	sprintf(imc_counter_cfg, "%s%s", imc_dir, READ_FILE_NAME);
+	fp = fopen(imc_counter_cfg, "r");
+	if (!fp) {
+		perror("Failed to open imc config file");
+
+		return -1;
+	}
+	if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
+		perror("Could not get imc cas count read");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	get_event_and_umask(cas_count_cfg, count, READ);
+
+	/* Get write config */
+	sprintf(imc_counter_cfg, "%s%s", imc_dir, WRITE_FILE_NAME);
+	fp = fopen(imc_counter_cfg, "r");
+	if (!fp) {
+		perror("Failed to open imc config file");
+
+		return -1;
+	}
+	if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
+		perror("Could not get imc cas count write");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	get_event_and_umask(cas_count_cfg, count, WRITE);
+
+	return 0;
+}
+
+/*
+ * A system can have 'n' number of iMC (Integrated Memory Controller)
+ * counters, get that 'n'. For each iMC counter get it's type and config.
+ * Also, each counter has two configs, one for read and the other for write.
+ * A config again has two parts, event and umask.
+ * Enumerate all these details into an array of structures.
+ *
+ * Return: >= 0 on success. < 0 on failure.
+ */
+static int num_of_imcs(void)
+{
+	unsigned int count = 0;
+	char imc_dir[512];
+	struct dirent *ep;
+	int ret;
+	DIR *dp;
+
+	dp = opendir(DYN_PMU_PATH);
+	if (dp) {
+		while ((ep = readdir(dp))) {
+			if (strstr(ep->d_name, UNCORE_IMC)) {
+				sprintf(imc_dir, "%s/%s/", DYN_PMU_PATH,
+					ep->d_name);
+				ret = read_from_imc_dir(imc_dir, count);
+				if (ret) {
+					closedir(dp);
+
+					return ret;
+				}
+				count++;
+			}
+		}
+		closedir(dp);
+		if (count == 0) {
+			perror("Unable find iMC counters!\n");
+
+			return -1;
+		}
+	} else {
+		perror("Unable to open PMU directory!\n");
+
+		return -1;
+	}
+
+	return count;
+}
+
+static int initialize_mem_bw_imc(void)
+{
+	int imc, j;
+
+	imcs = num_of_imcs();
+	if (imcs <= 0)
+		return imcs;
+
+	/* Initialize perf_event_attr structures for all iMC's */
+	for (imc = 0; imc < imcs; imc++) {
+		for (j = 0; j < 2; j++)
+			membw_initialize_perf_event_attr(imc, j);
+	}
+
+	return 0;
+}
+
+/*
+ * get_mem_bw_imc:	Memory band width as reported by iMC counters
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @bw_report:		Bandwidth report type (reads, writes)
+ *
+ * Memory B/W utilized by a process on a socket can be calculated using
+ * iMC counters. Perf events are used to read these counters.
+ *
+ * Return: >= 0 on success. < 0 on failure.
+ */
+static float get_mem_bw_imc(int cpu_no, char *bw_report)
+{
+	float reads, writes, of_mul_read, of_mul_write;
+	int imc, j, ret;
+
+	/* Start all iMC counters to log values (both read and write) */
+	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
+	for (imc = 0; imc < imcs; imc++) {
+		for (j = 0; j < 2; j++) {
+			ret = open_perf_event(imc, cpu_no, j);
+			if (ret)
+				return -1;
+		}
+		for (j = 0; j < 2; j++)
+			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
+	}
+
+	sleep(1);
+
+	/* Stop counters after a second to get results (both read and write) */
+	for (imc = 0; imc < imcs; imc++) {
+		for (j = 0; j < 2; j++)
+			membw_ioctl_perf_event_ioc_disable(imc, j);
+	}
+
+	/*
+	 * Get results which are stored in struct type imc_counter_config
+	 * Take over flow into consideration before calculating total b/w
+	 */
+	for (imc = 0; imc < imcs; imc++) {
+		struct imc_counter_config *r =
+			&imc_counters_config[imc][READ];
+		struct imc_counter_config *w =
+			&imc_counters_config[imc][WRITE];
+
+		if (read(r->fd, &r->return_value,
+			 sizeof(struct membw_read_format)) == -1) {
+			perror("Couldn't get read b/w through iMC");
+
+			return -1;
+		}
+
+		if (read(w->fd, &w->return_value,
+			 sizeof(struct membw_read_format)) == -1) {
+			perror("Couldn't get write bw through iMC");
+
+			return -1;
+		}
+
+		__u64 r_time_enabled = r->return_value.time_enabled;
+		__u64 r_time_running = r->return_value.time_running;
+
+		if (r_time_enabled != r_time_running)
+			of_mul_read = (float)r_time_enabled /
+					(float)r_time_running;
+
+		__u64 w_time_enabled = w->return_value.time_enabled;
+		__u64 w_time_running = w->return_value.time_running;
+
+		if (w_time_enabled != w_time_running)
+			of_mul_write = (float)w_time_enabled /
+					(float)w_time_running;
+		reads += r->return_value.value * of_mul_read * SCALE;
+		writes += w->return_value.value * of_mul_write * SCALE;
+	}
+
+	for (imc = 0; imc < imcs; imc++) {
+		close(imc_counters_config[imc][READ].fd);
+		close(imc_counters_config[imc][WRITE].fd);
+	}
+
+	if (strcmp(bw_report, "reads") == 0)
+		return reads;
+
+	if (strcmp(bw_report, "writes") == 0)
+		return writes;
+
+	return (reads + writes);
+}
+
+void set_mbm_path(const char *ctrlgrp, const char *mongrp, int resource_id)
+{
+	if (ctrlgrp && mongrp)
+		sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
+			RESCTRL_PATH, ctrlgrp, mongrp, resource_id);
+	else if (!ctrlgrp && mongrp)
+		sprintf(mbm_total_path, MON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			mongrp, resource_id);
+	else if (ctrlgrp && !mongrp)
+		sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			ctrlgrp, resource_id);
+	else if (!ctrlgrp && !mongrp)
+		sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			resource_id);
+}
+
+/*
+ * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
+ * @ctrlgrp:			Name of the control monitor group (con_mon grp)
+ * @mongrp:			Name of the monitor group (mon grp)
+ * @cpu_no:			CPU number that the benchmark PID is binded to
+ * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
+ */
+static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
+				      int cpu_no, char *resctrl_val)
+{
+	int resource_id;
+
+	if (get_resource_id(cpu_no, &resource_id) < 0) {
+		perror("Could not get resource_id");
+		return;
+	}
+
+	if (strcmp(resctrl_val, "mbm") == 0)
+		set_mbm_path(ctrlgrp, mongrp, resource_id);
+
+	if ((strcmp(resctrl_val, "mba") == 0)) {
+		if (ctrlgrp)
+			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
+				RESCTRL_PATH, ctrlgrp, resource_id);
+		else
+			sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
+				RESCTRL_PATH, resource_id);
+	}
+}
+
+/*
+ * Get MBM Local bytes as reported by resctrl FS
+ * For MBM,
+ * 1. If con_mon grp and mon grp are given, then read from con_mon grp's mon grp
+ * 2. If only con_mon grp is given, then read from con_mon grp
+ * 3. If both are not given, then read from root con_mon grp
+ * For MBA,
+ * 1. If con_mon grp is given, then read from it
+ * 2. If con_mon grp is not given, then read from root con_mon grp
+ */
+static unsigned long get_mem_bw_resctrl(void)
+{
+	unsigned long mbm_total = 0;
+	FILE *fp;
+
+	fp = fopen(mbm_total_path, "r");
+	if (!fp) {
+		perror("Failed to open total bw file");
+
+		return -1;
+	}
+	if (fscanf(fp, "%lu", &mbm_total) <= 0) {
+		perror("Could not get mbm local bytes");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return mbm_total;
+}
+
+pid_t bm_pid, ppid;
+
+static void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
+{
+	kill(bm_pid, SIGKILL);
+	printf("Ending\n\n");
+
+	exit(EXIT_SUCCESS);
+}
+
+/*
+ * print_results_bw:	the memory bandwidth results are stored in a file
+ * @filename:		file that stores the results
+ * @bm_pid:		child pid that runs benchmark
+ * @bw_imc:		perf imc counter value
+ * @bw_resc:		memory bandwidth value
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
+			    unsigned long bw_resc)
+{
+	unsigned long diff = fabs(bw_imc - bw_resc);
+	FILE *fp;
+
+	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
+		printf("Pid: %d \t Mem_BW_iMC: %f \t ", bm_pid, bw_imc);
+		printf("Mem_BW_resc: %lu \t Difference: %lu\n", bw_resc, diff);
+	} else {
+		fp = fopen(filename, "a");
+		if (!fp) {
+			perror("Cannot open results file");
+
+			return errno;
+		}
+		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
+			    bm_pid, bw_imc, bw_resc, diff) <= 0) {
+			fclose(fp);
+			perror("Could not log results.");
+
+			return errno;
+		}
+		fclose(fp);
+	}
+
+	return 0;
+}
+
+static int
+measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
+{
+	unsigned long bw_imc, bw_resc, bw_resc_end;
+	int ret;
+
+	/*
+	 * Measure memory bandwidth from resctrl and from
+	 * another source which is perf imc value or could
+	 * be something else if perf imc event is not available.
+	 * Compare the two values to validate resctrl value.
+	 * It takes 1sec to measure the data.
+	 */
+	bw_imc = get_mem_bw_imc(param->cpu_no, param->bw_report);
+	if (bw_imc <= 0)
+		return bw_imc;
+
+	bw_resc_end = get_mem_bw_resctrl();
+	if (bw_resc_end <= 0)
+		return bw_resc_end;
+
+	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
+	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
+	if (ret)
+		return ret;
+
+	*bw_resc_start = bw_resc_end;
+
+	return 0;
+}
+
+/*
+ * resctrl_val:	execute benchmark and measure memory bandwidth on
+ *			the benchmark
+ * @benchmark_cmd:	benchmark command and its arguments
+ * @param:		parameters passed to resctrl_val()
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
+{
+	char *resctrl_val = param->resctrl_val;
+	unsigned long bw_resc_start = 0;
+	struct sigaction sigact;
+	int ret = 0, pipefd[2];
+	char pipe_message = 0;
+	union sigval value;
+
+	if (strcmp(param->filename, "") == 0)
+		sprintf(param->filename, "stdio");
+
+	if ((strcmp(resctrl_val, "mba")) == 0 ||
+	    (strcmp(resctrl_val, "mbm")) == 0) {
+		ret = validate_bw_report_request(param->bw_report);
+		if (ret)
+			return ret;
+	}
+
+	ret = remount_resctrlfs(param->mum_resctrlfs);
+	if (ret)
+		return ret;
+
+	/*
+	 * If benchmark wasn't successfully started by child, then child should
+	 * kill parent, so save parent's pid
+	 */
+	ppid = getpid();
+
+	if (pipe(pipefd)) {
+		perror("# Unable to create pipe");
+
+		return -1;
+	}
+
+	/*
+	 * Fork to start benchmark, save child's pid so that it can be killed
+	 * when needed
+	 */
+	bm_pid = fork();
+	if (bm_pid == -1) {
+		perror("# Unable to fork");
+
+		return -1;
+	}
+
+	if (bm_pid == 0) {
+		/*
+		 * Mask all signals except SIGUSR1, parent uses SIGUSR1 to
+		 * start benchmark
+		 */
+		sigfillset(&sigact.sa_mask);
+		sigdelset(&sigact.sa_mask, SIGUSR1);
+
+		sigact.sa_sigaction = run_benchmark;
+		sigact.sa_flags = SA_SIGINFO;
+
+		/* Register for "SIGUSR1" signal from parent */
+		if (sigaction(SIGUSR1, &sigact, NULL))
+			PARENT_EXIT("Can't register child for signal");
+
+		/* Tell parent that child is ready */
+		close(pipefd[0]);
+		pipe_message = 1;
+		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
+		    sizeof(pipe_message)) {
+			perror("# failed signaling parent process");
+			close(pipefd[1]);
+			return -1;
+		}
+		close(pipefd[1]);
+
+		/* Suspend child until delivery of "SIGUSR1" from parent */
+		sigsuspend(&sigact.sa_mask);
+
+		PARENT_EXIT("Child is done");
+	}
+
+	printf("# benchmark PID: %d\n", bm_pid);
+
+	/*
+	 * Register CTRL-C handler for parent, as it has to kill benchmark
+	 * before exiting
+	 */
+	sigact.sa_sigaction = ctrlc_handler;
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGHUP, &sigact, NULL)) {
+		perror("# sigaction");
+		ret = errno;
+		goto out;
+	}
+
+	value.sival_ptr = benchmark_cmd;
+
+	/* Taskset benchmark to specified cpu */
+	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	if (ret)
+		goto out;
+
+	/* Write benchmark to specified control&monitoring grp in resctrl FS */
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				      resctrl_val);
+	if (ret)
+		goto out;
+
+	if ((strcmp(resctrl_val, "mbm") == 0) ||
+	    (strcmp(resctrl_val, "mba") == 0)) {
+		ret = initialize_mem_bw_imc();
+		if (ret)
+			goto out;
+
+		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
+					  param->cpu_no, resctrl_val);
+	}
+
+	/* Parent waits for child to be ready. */
+	close(pipefd[1]);
+	while (pipe_message != 1) {
+		if (read(pipefd[0], &pipe_message, sizeof(pipe_message)) <
+		    sizeof(pipe_message)) {
+			perror("# failed reading message from child process");
+			close(pipefd[0]);
+			goto out;
+		}
+	}
+	close(pipefd[0]);
+
+	/* Signal child to start benchmark */
+	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
+		perror("# sigqueue SIGUSR1 to child");
+		ret = errno;
+		goto out;
+	}
+
+	/* Give benchmark enough time to fully run */
+	sleep(1);
+
+	/* Test runs until the callback setup() tells the test to stop. */
+	while (1) {
+		if (strcmp(resctrl_val, "mbm") == 0) {
+			ret = param->setup(1, param);
+			if (ret) {
+				ret = 0;
+				break;
+			}
+
+			ret = measure_vals(param, &bw_resc_start);
+			if (ret)
+				break;
+		} else if ((strcmp(resctrl_val, "mba") == 0)) {
+			ret = param->setup(1, param);
+			if (ret) {
+				ret = 0;
+				break;
+			}
+
+			ret = measure_vals(param, &bw_resc_start);
+			if (ret)
+				break;
+		} else {
+			break;
+		}
+	}
+
+out:
+	kill(bm_pid, SIGKILL);
+	umount_resctrlfs();
+
+	return ret;
+}
-- 
2.19.1

