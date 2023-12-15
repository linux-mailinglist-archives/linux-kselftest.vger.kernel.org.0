Return-Path: <linux-kselftest+bounces-2040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08C1814B2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C591C23B6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA193358BD;
	Fri, 15 Dec 2023 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NckDVSqS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6639FC3;
	Fri, 15 Dec 2023 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652760; x=1734188760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iJ9O6xIEXYcnxDKeClcIk8aRdLw1wQZFJnOxBvDhHTU=;
  b=NckDVSqSrr4X0ZM4ZLTtVBxZDC9km51TGmB4Ukj8iR89faasL+gj04Fn
   X9+kWFDEGlTVXEpn/KHnoLeF8PNvmXcDXoe8bP3VNWolMflEt/1mLKtPF
   iqKTdY2n9zmXIdHSkHDNo9DCUaXKgLvFPYaKDbtoZIlL2nejgvtghHXDd
   XSOQaH/XSX28MugkSCo2vcs95dedwC02xgk2ClJSwZzC1/QGS0PVJWmTh
   dF8g6lorTLlgAYaRhk0SB8AZfNlZXHSocWs3+CcCwKN1JtjnAoCwB5aBp
   xu9mn8zrBjFMZlLUO6nc7KIAKetAAXA+z2MPDZuiPMs/HFga6nkaRVWeo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392461444"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="392461444"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:05:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1106150911"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1106150911"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:05:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 01/29] selftests/resctrl: Convert perror() to ksft_perror() or ksft_print_msg()
Date: Fri, 15 Dec 2023 17:04:47 +0200
Message-Id: <20231215150515.36983-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The resctrl selftest code contains a number of perror() calls. Some of
them come with hash character and some don't. The kselftest framework
provides ksft_perror() that is compatible with test output formatting
so it should be used instead of adding custom hash signs.

Some perror() calls are too far away from anything that sets error.
For those call sites, ksft_print_msg() must be used instead.

Convert perror() to ksft_perror() or ksft_print_msg().

Other related changes:
- Remove hash signs
- Remove trailing stops & newlines from ksft_perror()
- Add terminating newlines for converted ksft_print_msg()
- Use consistent capitalization
- Small fixes/tweaks to typos & grammar of the messages
- Extract error printing out of PARENT_EXIT() to be able to
  differentiate

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v4:
- fprintf() error handling changed ksft_perror() -> ksft_print_msg()
- Fixed one typo in message
- Add a few more details into related changes list in the changelog

v3:
- New patch
---
 tools/testing/selftests/resctrl/cache.c       | 10 +--
 tools/testing/selftests/resctrl/cat_test.c    |  8 +-
 tools/testing/selftests/resctrl/cmt_test.c    |  2 +-
 tools/testing/selftests/resctrl/fill_buf.c    |  2 +-
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     |  3 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 76 ++++++++++---------
 tools/testing/selftests/resctrl/resctrlfs.c   | 42 +++++-----
 9 files changed, 77 insertions(+), 70 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index bcbca356d56a..992bac8c352b 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -40,7 +40,7 @@ static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
 	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
 				PERF_FLAG_FD_CLOEXEC);
 	if (fd_lm == -1) {
-		perror("Error opening leader");
+		ksft_perror("Error opening leader");
 		ctrlc_handler(0, NULL, NULL);
 		return -1;
 	}
@@ -95,7 +95,7 @@ static int get_llc_perf(unsigned long *llc_perf_miss)
 
 	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
 	if (ret == -1) {
-		perror("Could not get llc misses through perf");
+		ksft_perror("Could not get llc misses through perf");
 		return -1;
 	}
 
@@ -124,12 +124,12 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
 
 	fp = fopen(llc_occup_path, "r");
 	if (!fp) {
-		perror("Failed to open results file");
+		ksft_perror("Failed to open results file");
 
 		return errno;
 	}
 	if (fscanf(fp, "%lu", llc_occupancy) <= 0) {
-		perror("Could not get llc occupancy");
+		ksft_perror("Could not get llc occupancy");
 		fclose(fp);
 
 		return -1;
@@ -159,7 +159,7 @@ static int print_results_cache(char *filename, int bm_pid,
 	} else {
 		fp = fopen(filename, "a");
 		if (!fp) {
-			perror("Cannot open results file");
+			ksft_perror("Cannot open results file");
 
 			return errno;
 		}
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 224ba8544d8a..9bb8ba93f433 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -51,7 +51,7 @@ static int check_results(struct resctrl_val_param *param, size_t span)
 	ksft_print_msg("Checking for pass/fail\n");
 	fp = fopen(param->filename, "r");
 	if (!fp) {
-		perror("# Cannot open file");
+		ksft_perror("Cannot open file");
 
 		return errno;
 	}
@@ -149,7 +149,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	param.num_of_runs = 0;
 
 	if (pipe(pipefd)) {
-		perror("# Unable to create pipe");
+		ksft_perror("Unable to create pipe");
 		return errno;
 	}
 
@@ -185,7 +185,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 			 * Just print the error message.
 			 * Let while(1) run and wait for itself to be killed.
 			 */
-			perror("# failed signaling parent process");
+			ksft_perror("Failed signaling parent process");
 
 		close(pipefd[1]);
 		while (1)
@@ -197,7 +197,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		while (pipe_message != 1) {
 			if (read(pipefd[0], &pipe_message,
 				 sizeof(pipe_message)) < sizeof(pipe_message)) {
-				perror("# failed reading from child process");
+				ksft_perror("Failed reading from child process");
 				break;
 			}
 		}
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 50bdbce9fba9..16fc0488e0a5 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -37,7 +37,7 @@ static int check_results(struct resctrl_val_param *param, size_t span, int no_of
 	ksft_print_msg("Checking for pass/fail\n");
 	fp = fopen(param->filename, "r");
 	if (!fp) {
-		perror("# Error in opening file\n");
+		ksft_perror("Error in opening file");
 
 		return errno;
 	}
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 0d425f26583a..0f6cca61ec94 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -115,7 +115,7 @@ static int fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
 	/* Consume read result so that reading memory is not optimized out. */
 	fp = fopen("/dev/null", "w");
 	if (!fp) {
-		perror("Unable to write to /dev/null");
+		ksft_perror("Unable to write to /dev/null");
 		return -1;
 	}
 	fprintf(fp, "Sum: %d ", ret);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index d3bf4368341e..4988b93add6a 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -109,7 +109,7 @@ static int check_results(void)
 
 	fp = fopen(output, "r");
 	if (!fp) {
-		perror(output);
+		ksft_perror(output);
 
 		return errno;
 	}
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 741533f2b075..045cd7818c79 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -59,7 +59,7 @@ static int check_results(size_t span)
 
 	fp = fopen(output, "r");
 	if (!fp) {
-		perror(output);
+		ksft_perror(output);
 
 		return errno;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index a33f414f6019..dd3546655657 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -37,9 +37,8 @@
 
 #define DEFAULT_SPAN		(250 * MB)
 
-#define PARENT_EXIT(err_msg)			\
+#define PARENT_EXIT()				\
 	do {					\
-		perror(err_msg);		\
 		kill(ppid, SIGKILL);		\
 		umount_resctrlfs();		\
 		exit(EXIT_FAILURE);		\
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 88789678917b..231d2012de2b 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -156,12 +156,12 @@ static int read_from_imc_dir(char *imc_dir, int count)
 	sprintf(imc_counter_type, "%s%s", imc_dir, "type");
 	fp = fopen(imc_counter_type, "r");
 	if (!fp) {
-		perror("Failed to open imc counter type file");
+		ksft_perror("Failed to open iMC counter type file");
 
 		return -1;
 	}
 	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
-		perror("Could not get imc type");
+		ksft_perror("Could not get iMC type");
 		fclose(fp);
 
 		return -1;
@@ -175,12 +175,12 @@ static int read_from_imc_dir(char *imc_dir, int count)
 	sprintf(imc_counter_cfg, "%s%s", imc_dir, READ_FILE_NAME);
 	fp = fopen(imc_counter_cfg, "r");
 	if (!fp) {
-		perror("Failed to open imc config file");
+		ksft_perror("Failed to open iMC config file");
 
 		return -1;
 	}
 	if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
-		perror("Could not get imc cas count read");
+		ksft_perror("Could not get iMC cas count read");
 		fclose(fp);
 
 		return -1;
@@ -193,12 +193,12 @@ static int read_from_imc_dir(char *imc_dir, int count)
 	sprintf(imc_counter_cfg, "%s%s", imc_dir, WRITE_FILE_NAME);
 	fp = fopen(imc_counter_cfg, "r");
 	if (!fp) {
-		perror("Failed to open imc config file");
+		ksft_perror("Failed to open iMC config file");
 
 		return -1;
 	}
 	if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
-		perror("Could not get imc cas count write");
+		ksft_perror("Could not get iMC cas count write");
 		fclose(fp);
 
 		return -1;
@@ -262,12 +262,12 @@ static int num_of_imcs(void)
 		}
 		closedir(dp);
 		if (count == 0) {
-			perror("Unable find iMC counters!\n");
+			ksft_print_msg("Unable to find iMC counters\n");
 
 			return -1;
 		}
 	} else {
-		perror("Unable to open PMU directory!\n");
+		ksft_perror("Unable to open PMU directory");
 
 		return -1;
 	}
@@ -339,14 +339,14 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 
 		if (read(r->fd, &r->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
-			perror("Couldn't get read b/w through iMC");
+			ksft_perror("Couldn't get read b/w through iMC");
 
 			return -1;
 		}
 
 		if (read(w->fd, &w->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
-			perror("Couldn't get write bw through iMC");
+			ksft_perror("Couldn't get write bw through iMC");
 
 			return -1;
 		}
@@ -416,7 +416,7 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
 	int resource_id;
 
 	if (get_resource_id(cpu_no, &resource_id) < 0) {
-		perror("Could not get resource_id");
+		ksft_print_msg("Could not get resource_id\n");
 		return;
 	}
 
@@ -449,12 +449,12 @@ static int get_mem_bw_resctrl(unsigned long *mbm_total)
 
 	fp = fopen(mbm_total_path, "r");
 	if (!fp) {
-		perror("Failed to open total bw file");
+		ksft_perror("Failed to open total bw file");
 
 		return -1;
 	}
 	if (fscanf(fp, "%lu", mbm_total) <= 0) {
-		perror("Could not get mbm local bytes");
+		ksft_perror("Could not get mbm local bytes");
 		fclose(fp);
 
 		return -1;
@@ -495,7 +495,7 @@ int signal_handler_register(void)
 	if (sigaction(SIGINT, &sigact, NULL) ||
 	    sigaction(SIGTERM, &sigact, NULL) ||
 	    sigaction(SIGHUP, &sigact, NULL)) {
-		perror("# sigaction");
+		ksft_perror("sigaction");
 		ret = -1;
 	}
 	return ret;
@@ -515,7 +515,7 @@ void signal_handler_unregister(void)
 	if (sigaction(SIGINT, &sigact, NULL) ||
 	    sigaction(SIGTERM, &sigact, NULL) ||
 	    sigaction(SIGHUP, &sigact, NULL)) {
-		perror("# sigaction");
+		ksft_perror("sigaction");
 	}
 }
 
@@ -540,14 +540,14 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
 	} else {
 		fp = fopen(filename, "a");
 		if (!fp) {
-			perror("Cannot open results file");
+			ksft_perror("Cannot open results file");
 
 			return errno;
 		}
 		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
 			    bm_pid, bw_imc, bw_resc, diff) <= 0) {
+			ksft_print_msg("Could not log results\n");
 			fclose(fp);
-			perror("Could not log results.");
 
 			return errno;
 		}
@@ -585,7 +585,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 	int resource_id;
 
 	if (get_resource_id(cpu_no, &resource_id) < 0) {
-		perror("# Unable to resource_id");
+		ksft_print_msg("Could not get resource_id\n");
 		return;
 	}
 
@@ -647,20 +647,24 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	 * stdio (console)
 	 */
 	fp = freopen("/dev/null", "w", stdout);
-	if (!fp)
-		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
+	if (!fp) {
+		ksft_perror("Unable to direct benchmark status to /dev/null");
+		PARENT_EXIT();
+	}
 
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
 		/* Execute default fill_buf benchmark */
 		span = strtoul(benchmark_cmd[1], NULL, 10);
 		memflush =  atoi(benchmark_cmd[2]);
 		operation = atoi(benchmark_cmd[3]);
-		if (!strcmp(benchmark_cmd[4], "true"))
+		if (!strcmp(benchmark_cmd[4], "true")) {
 			once = true;
-		else if (!strcmp(benchmark_cmd[4], "false"))
+		} else if (!strcmp(benchmark_cmd[4], "false")) {
 			once = false;
-		else
-			PARENT_EXIT("Invalid once parameter");
+		} else {
+			ksft_print_msg("Invalid once parameter\n");
+			PARENT_EXIT();
+		}
 
 		if (run_fill_buf(span, memflush, operation, once))
 			fprintf(stderr, "Error in running fill buffer\n");
@@ -668,11 +672,12 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		/* Execute specified benchmark */
 		ret = execvp(benchmark_cmd[0], benchmark_cmd);
 		if (ret)
-			perror("wrong\n");
+			ksft_perror("execvp");
 	}
 
 	fclose(stdout);
-	PARENT_EXIT("Unable to run specified benchmark");
+	ksft_print_msg("Unable to run specified benchmark\n");
+	PARENT_EXIT();
 }
 
 /*
@@ -709,7 +714,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	ppid = getpid();
 
 	if (pipe(pipefd)) {
-		perror("# Unable to create pipe");
+		ksft_perror("Unable to create pipe");
 
 		return -1;
 	}
@@ -721,7 +726,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	fflush(stdout);
 	bm_pid = fork();
 	if (bm_pid == -1) {
-		perror("# Unable to fork");
+		ksft_perror("Unable to fork");
 
 		return -1;
 	}
@@ -738,15 +743,17 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 		sigact.sa_flags = SA_SIGINFO;
 
 		/* Register for "SIGUSR1" signal from parent */
-		if (sigaction(SIGUSR1, &sigact, NULL))
-			PARENT_EXIT("Can't register child for signal");
+		if (sigaction(SIGUSR1, &sigact, NULL)) {
+			ksft_perror("Can't register child for signal");
+			PARENT_EXIT();
+		}
 
 		/* Tell parent that child is ready */
 		close(pipefd[0]);
 		pipe_message = 1;
 		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
 		    sizeof(pipe_message)) {
-			perror("# failed signaling parent process");
+			ksft_perror("Failed signaling parent process");
 			close(pipefd[1]);
 			return -1;
 		}
@@ -755,7 +762,8 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 		/* Suspend child until delivery of "SIGUSR1" from parent */
 		sigsuspend(&sigact.sa_mask);
 
-		PARENT_EXIT("Child is done");
+		ksft_perror("Child is done");
+		PARENT_EXIT();
 	}
 
 	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
@@ -796,7 +804,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	while (pipe_message != 1) {
 		if (read(pipefd[0], &pipe_message, sizeof(pipe_message)) <
 		    sizeof(pipe_message)) {
-			perror("# failed reading message from child process");
+			ksft_perror("Failed reading message from child process");
 			close(pipefd[0]);
 			goto out;
 		}
@@ -805,7 +813,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 
 	/* Signal child to start benchmark */
 	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
-		perror("# sigqueue SIGUSR1 to child");
+		ksft_perror("sigqueue SIGUSR1 to child");
 		ret = errno;
 		goto out;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 5ebd43683876..77023d342a12 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -20,7 +20,7 @@ static int find_resctrl_mount(char *buffer)
 
 	mounts = fopen("/proc/mounts", "r");
 	if (!mounts) {
-		perror("/proc/mounts");
+		ksft_perror("/proc/mounts");
 		return -ENXIO;
 	}
 	while (!feof(mounts)) {
@@ -69,7 +69,7 @@ int mount_resctrlfs(void)
 	ksft_print_msg("Mounting resctrl to \"%s\"\n", RESCTRL_PATH);
 	ret = mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL);
 	if (ret)
-		perror("# mount");
+		ksft_perror("mount");
 
 	return ret;
 }
@@ -86,7 +86,7 @@ int umount_resctrlfs(void)
 		return ret;
 
 	if (umount(mountpoint)) {
-		perror("# Unable to umount resctrl");
+		ksft_perror("Unable to umount resctrl");
 
 		return errno;
 	}
@@ -115,12 +115,12 @@ int get_resource_id(int cpu_no, int *resource_id)
 
 	fp = fopen(phys_pkg_path, "r");
 	if (!fp) {
-		perror("Failed to open physical_package_id");
+		ksft_perror("Failed to open physical_package_id");
 
 		return -1;
 	}
 	if (fscanf(fp, "%d", resource_id) <= 0) {
-		perror("Could not get socket number or l3 id");
+		ksft_perror("Could not get socket number or l3 id");
 		fclose(fp);
 
 		return -1;
@@ -149,7 +149,7 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
 	} else if (!strcmp(cache_type, "L2")) {
 		cache_num = 2;
 	} else {
-		perror("Invalid cache level");
+		ksft_print_msg("Invalid cache level\n");
 		return -1;
 	}
 
@@ -157,12 +157,12 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
 		cpu_no, cache_num);
 	fp = fopen(cache_path, "r");
 	if (!fp) {
-		perror("Failed to open cache size");
+		ksft_perror("Failed to open cache size");
 
 		return -1;
 	}
 	if (fscanf(fp, "%s", cache_str) <= 0) {
-		perror("Could not get cache_size");
+		ksft_perror("Could not get cache_size");
 		fclose(fp);
 
 		return -1;
@@ -214,12 +214,12 @@ int get_cbm_mask(char *cache_type, char *cbm_mask)
 
 	fp = fopen(cbm_mask_path, "r");
 	if (!fp) {
-		perror("Failed to open cache level");
+		ksft_perror("Failed to open cache level");
 
 		return -1;
 	}
 	if (fscanf(fp, "%s", cbm_mask) <= 0) {
-		perror("Could not get max cbm_mask");
+		ksft_perror("Could not get max cbm_mask");
 		fclose(fp);
 
 		return -1;
@@ -246,12 +246,12 @@ int get_core_sibling(int cpu_no)
 
 	fp = fopen(core_siblings_path, "r");
 	if (!fp) {
-		perror("Failed to open core siblings path");
+		ksft_perror("Failed to open core siblings path");
 
 		return -1;
 	}
 	if (fscanf(fp, "%s", cpu_list_str) <= 0) {
-		perror("Could not get core_siblings list");
+		ksft_perror("Could not get core_siblings list");
 		fclose(fp);
 
 		return -1;
@@ -286,7 +286,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
 	CPU_SET(cpu_no, &my_set);
 
 	if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set)) {
-		perror("Unable to taskset benchmark");
+		ksft_perror("Unable to taskset benchmark");
 
 		return -1;
 	}
@@ -325,7 +325,7 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 		}
 		closedir(dp);
 	} else {
-		perror("Unable to open resctrl for group");
+		ksft_perror("Unable to open resctrl for group");
 
 		return -1;
 	}
@@ -333,7 +333,7 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 	/* Requested grp doesn't exist, hence create it */
 	if (found_grp == 0) {
 		if (mkdir(grp, 0) == -1) {
-			perror("Unable to create group");
+			ksft_perror("Unable to create group");
 
 			return -1;
 		}
@@ -348,12 +348,12 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
 
 	fp = fopen(tasks, "w");
 	if (!fp) {
-		perror("Failed to open tasks file");
+		ksft_perror("Failed to open tasks file");
 
 		return -1;
 	}
 	if (fprintf(fp, "%d\n", pid) < 0) {
-		perror("Failed to wr pid to tasks file");
+		ksft_print_msg("Failed to write pid to tasks file\n");
 		fclose(fp);
 
 		return -1;
@@ -420,7 +420,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 out:
 	ksft_print_msg("Writing benchmark parameters to resctrl FS\n");
 	if (ret)
-		perror("# writing to resctrlfs");
+		ksft_print_msg("Failed writing to resctrlfs\n");
 
 	return ret;
 }
@@ -617,7 +617,7 @@ int filter_dmesg(void)
 
 	ret = pipe(pipefds);
 	if (ret) {
-		perror("pipe");
+		ksft_perror("pipe");
 		return ret;
 	}
 	fflush(stdout);
@@ -626,13 +626,13 @@ int filter_dmesg(void)
 		close(pipefds[0]);
 		dup2(pipefds[1], STDOUT_FILENO);
 		execlp("dmesg", "dmesg", NULL);
-		perror("executing dmesg");
+		ksft_perror("Executing dmesg");
 		exit(1);
 	}
 	close(pipefds[1]);
 	fp = fdopen(pipefds[0], "r");
 	if (!fp) {
-		perror("fdopen(pipe)");
+		ksft_perror("fdopen(pipe)");
 		kill(pid, SIGTERM);
 
 		return -1;
-- 
2.30.2


