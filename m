Return-Path: <linux-kselftest+bounces-20587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4AB9AF467
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C50E283848
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5984521BB02;
	Thu, 24 Oct 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHS0cDiN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6400821A6E2;
	Thu, 24 Oct 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804097; cv=none; b=JbCetTCgZRYOocp8zfi/iLfAQMpM2qIU/yLFpyuoKT8udJd/BK3px3sY0cTR5GqFJ07Ws43C3RCGPGibXM7HrKreMa8jV/IVb267fXujmGACnt0F4SctXtvRSpuO+jJOB0nc3Fw5u7UJXeDaSo/R8A6btj0uqCB/RBAZmXHIHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804097; c=relaxed/simple;
	bh=P2HOYzUXw07lhwl1z3PmjsSo47s3FUXbboxIje+LtVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQvFX7/phYz84bYPVEqJLHwg2VSt1joWHALyn8xyFl3gP1WTm3Aq+wTRucFQqg1JTsHti/rEHGbWNNBwtiZ7q5T/I5r3t9CgO8uQ0PVHJDSoANzOzml3JZ88VrTk+OSjlW8c0XOQss2VUGrqvmkiyIP9Kxr/Gv5cLOWjAMV0K14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHS0cDiN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804093; x=1761340093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2HOYzUXw07lhwl1z3PmjsSo47s3FUXbboxIje+LtVo=;
  b=dHS0cDiN2GcsFj7PpGGXQYzXNhZ+gpIgJsRE0EjfCuIi+hqrBG36WUmO
   3XwqkxYlxl+LnjWVm976VUouM86r3vaFFFBAzGUM+5iARYJ2M+dT81XVT
   oEVzNjCGXGDY/GB6ft1zbVjYjMDEVJC7QcFpcxJgSXRc0iaUs/5aAUAaG
   6fDyktn/UXWbMwk2RsGaChaLK8cQFzSEuYXjJgvtymQlpQH6YPvHr5AZh
   ENFOEefLGf9vyBS3CF9sKneZ2QS23jYBJZwBn200fnBNXO6rc3I9hjlYa
   MkQe6XQN7ZK5HfhFVJpgbSh7zZpNeE5vzehLIrGW3KO3l7p13uo7lQG4g
   w==;
X-CSE-ConnectionGUID: S7TIZmf9TaWn9Oev7YhXEw==
X-CSE-MsgGUID: 2Vzm/G3cSgmiaR997KeJWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090921"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090921"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
X-CSE-ConnectionGUID: dS78AZz0T+2zXnAmXsGimA==
X-CSE-MsgGUID: StL4bv2GTu+vE0UsrKDcDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488054"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 11/15] selftests/resctrl: Ensure measurements skip initialization of default benchmark
Date: Thu, 24 Oct 2024 14:18:48 -0700
Message-ID: <aa2fab257734332455eb98fa67389a03981dd844.1729804024.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729804024.git.reinette.chatre@intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CMT, MBA, and MBM tests rely on the resctrl_val() wrapper to
start and run a benchmark while providing test specific flows
via callbacks to do test specific configuration and measurements.

At a high level, the resctrl_val() flow is:
	a) Start by fork()ing a child process that installs a signal
	   handler for SIGUSR1 that, on receipt of SIGUSR1, will
	   start running a benchmark.
	b) Assign the child process created in (a) to the resctrl
	   control and monitoring group that dictates the memory and
	   cache allocations with which the process can run and will
	   contain all resctrl monitoring data of that process.
	c) Once parent and child are considered "ready" (determined via
	   a message over a pipe) the parent signals the child (via
	   SIGUSR1) to start the benchmark, waits one second for the
	   benchmark to run, and then starts collecting monitoring data
	   for the tests, potentially also changing allocation
	   configuration depending on the various test callbacks.

A problem with the above flow is the "black box" view of the
benchmark that is combined with an arbitrarily chosen
"wait one second" before measurements start. No matter what
the benchmark does, it is given one second to initialize before
measurements start.

The default benchmark "fill_buf" consists of two parts,
first it prepares a buffer (allocate, initialize, then flush), then it
reads from the buffer (in unpredictable ways) until terminated.
Depending on the system and the size of the buffer, the first "prepare"
part may not be complete by the time the one second delay expires. Test
measurements may thus start before the work needing to be measured runs.

Split the default benchmark into its "prepare" and "runtime" parts and
simplify the resctrl_val() wrapper while doing so. This same split
cannot be done for the user provided benchmark (without a user
interface change), so the current behavior is maintained for user
provided benchmark.

Assign the test itself to the control and monitoring group and run the
"prepare" part of the benchmark in this context, ensuring it runs with
required cache and memory bandwidth allocations. With the benchmark
preparation complete it is only needed to fork() the "runtime" part
of the benchmark (or entire user provided benchmark).

Keep the "wait one second" delay before measurements start. For the
default "fill_buf" benchmark this time now covers only the "runtime"
portion that needs to be measured. For the user provided benchmark this
delay maintains current behavior.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V2:
- Add Ilpo's Reviewed-by tag.

Changes since V1:
- Keep the fflush(stdout) before fork() to avoid duplicate messages. (Ilpo)
- Re-order in series to that the new behavior is introduced after issues
  with existing behavior is addressed.
---
 tools/testing/selftests/resctrl/fill_buf.c    |  15 --
 tools/testing/selftests/resctrl/resctrl.h     |   1 -
 tools/testing/selftests/resctrl/resctrl_val.c | 195 +++++-------------
 3 files changed, 50 insertions(+), 161 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 39545f9369e8..380cc35f10c6 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -129,18 +129,3 @@ unsigned char *alloc_buffer(size_t buf_size, bool memflush)
 
 	return buf;
 }
-
-int run_fill_buf(size_t buf_size, bool memflush)
-{
-	unsigned char *buf;
-
-	buf = alloc_buffer(buf_size, memflush);
-	if (!buf)
-		return -1;
-
-	fill_cache_read(buf, buf_size, false);
-
-	free(buf);
-
-	return 0;
-}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index c9336f9c2cae..032cd9ebd761 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -169,7 +169,6 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 unsigned char *alloc_buffer(size_t buf_size, bool memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
-int run_fill_buf(size_t buf_size, bool memflush);
 int initialize_read_mem_bw_imc(void);
 int measure_read_mem_bw(const struct user_params *uparams,
 			struct resctrl_val_param *param, pid_t bm_pid);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 00b3808d3bca..7c08e936572d 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -373,7 +373,7 @@ static int get_mem_bw_resctrl(FILE *fp, unsigned long *mbm_total)
 	return 0;
 }
 
-static pid_t bm_pid, ppid;
+static pid_t bm_pid;
 
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
@@ -431,13 +431,6 @@ void signal_handler_unregister(void)
 	}
 }
 
-static void parent_exit(pid_t ppid)
-{
-	kill(ppid, SIGKILL);
-	umount_resctrlfs();
-	exit(EXIT_FAILURE);
-}
-
 /*
  * print_results_bw:	the memory bandwidth results are stored in a file
  * @filename:		file that stores the results
@@ -535,52 +528,6 @@ int measure_read_mem_bw(const struct user_params *uparams,
 	return ret;
 }
 
-struct benchmark_info {
-	const struct user_params *uparams;
-	struct resctrl_val_param *param;
-};
-
-/*
- * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
- *		   in specified signal. Direct benchmark stdio to /dev/null.
- * @signum:	signal number
- * @info:	signal info
- * @ucontext:	user context in signal handling
- */
-static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
-{
-	struct benchmark_info *benchmark_info = info->si_ptr;
-	const struct user_params *uparams = benchmark_info->uparams;
-	struct resctrl_val_param *param = benchmark_info->param;
-	FILE *fp;
-	int ret;
-
-	/*
-	 * Direct stdio of child to /dev/null, so that only parent writes to
-	 * stdio (console)
-	 */
-	fp = freopen("/dev/null", "w", stdout);
-	if (!fp) {
-		ksft_perror("Unable to direct benchmark status to /dev/null");
-		parent_exit(ppid);
-	}
-
-	if (param->fill_buf) {
-		if (run_fill_buf(param->fill_buf->buf_size,
-				 param->fill_buf->memflush))
-			fprintf(stderr, "Error in running fill buffer\n");
-	} else if (uparams->benchmark_cmd[0]) {
-		/* Execute specified benchmark */
-		ret = execvp(uparams->benchmark_cmd[0], (char **)uparams->benchmark_cmd);
-		if (ret)
-			ksft_perror("execvp");
-	}
-
-	fclose(stdout);
-	ksft_print_msg("Unable to run specified benchmark\n");
-	parent_exit(ppid);
-}
-
 /*
  * resctrl_val:	execute benchmark and measure memory bandwidth on
  *			the benchmark
@@ -594,12 +541,11 @@ int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
 		struct resctrl_val_param *param)
 {
-	struct benchmark_info benchmark_info;
-	struct sigaction sigact;
-	int ret = 0, pipefd[2];
-	char pipe_message = 0;
-	union sigval value;
+	unsigned char *buf = NULL;
+	cpu_set_t old_affinity;
 	int domain_id;
+	int ret = 0;
+	pid_t ppid;
 
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
@@ -610,108 +556,65 @@ int resctrl_val(const struct resctrl_test *test,
 		return ret;
 	}
 
-	benchmark_info.uparams = uparams;
-	benchmark_info.param = param;
-
-	/*
-	 * If benchmark wasn't successfully started by child, then child should
-	 * kill parent, so save parent's pid
-	 */
 	ppid = getpid();
 
-	if (pipe(pipefd)) {
-		ksft_perror("Unable to create pipe");
+	/* Taskset test to specified CPU. */
+	ret = taskset_benchmark(ppid, uparams->cpu, &old_affinity);
+	if (ret)
+		return ret;
+
+	/* Write test to specified control & monitoring group in resctrl FS. */
+	ret = write_bm_pid_to_resctrl(ppid, param->ctrlgrp, param->mongrp);
+	if (ret)
+		goto reset_affinity;
 
-		return -1;
+	if (param->init) {
+		ret = param->init(param, domain_id);
+		if (ret)
+			goto reset_affinity;
 	}
 
 	/*
-	 * Fork to start benchmark, save child's pid so that it can be killed
-	 * when needed
+	 * If not running user provided benchmark, run the default
+	 * "fill_buf". First phase of "fill_buf" is to prepare the
+	 * buffer that the benchmark will operate on. No measurements
+	 * are needed during this phase and prepared memory will be
+	 * passed to next part of benchmark via copy-on-write thus
+	 * no impact on the benchmark that relies on reading from
+	 * memory only.
 	 */
+	if (param->fill_buf) {
+		buf = alloc_buffer(param->fill_buf->buf_size,
+				   param->fill_buf->memflush);
+		if (!buf) {
+			ret = -ENOMEM;
+			goto reset_affinity;
+		}
+	}
+
 	fflush(stdout);
 	bm_pid = fork();
 	if (bm_pid == -1) {
+		ret = -errno;
 		ksft_perror("Unable to fork");
-
-		return -1;
+		goto free_buf;
 	}
 
+	/*
+	 * What needs to be measured runs in separate process until
+	 * terminated.
+	 */
 	if (bm_pid == 0) {
-		/*
-		 * Mask all signals except SIGUSR1, parent uses SIGUSR1 to
-		 * start benchmark
-		 */
-		sigfillset(&sigact.sa_mask);
-		sigdelset(&sigact.sa_mask, SIGUSR1);
-
-		sigact.sa_sigaction = run_benchmark;
-		sigact.sa_flags = SA_SIGINFO;
-
-		/* Register for "SIGUSR1" signal from parent */
-		if (sigaction(SIGUSR1, &sigact, NULL)) {
-			ksft_perror("Can't register child for signal");
-			parent_exit(ppid);
-		}
-
-		/* Tell parent that child is ready */
-		close(pipefd[0]);
-		pipe_message = 1;
-		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
-		    sizeof(pipe_message)) {
-			ksft_perror("Failed signaling parent process");
-			close(pipefd[1]);
-			return -1;
-		}
-		close(pipefd[1]);
-
-		/* Suspend child until delivery of "SIGUSR1" from parent */
-		sigsuspend(&sigact.sa_mask);
-
-		ksft_perror("Child is done");
-		parent_exit(ppid);
+		if (param->fill_buf)
+			fill_cache_read(buf, param->fill_buf->buf_size, false);
+		else if (uparams->benchmark_cmd[0])
+			execvp(uparams->benchmark_cmd[0], (char **)uparams->benchmark_cmd);
+		exit(EXIT_SUCCESS);
 	}
 
 	ksft_print_msg("Benchmark PID: %d\n", (int)bm_pid);
 
-	value.sival_ptr = (void *)&benchmark_info;
-
-	/* Taskset benchmark to specified cpu */
-	ret = taskset_benchmark(bm_pid, uparams->cpu, NULL);
-	if (ret)
-		goto out;
-
-	/* Write benchmark to specified control&monitoring grp in resctrl FS */
-	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp);
-	if (ret)
-		goto out;
-
-	if (param->init) {
-		ret = param->init(param, domain_id);
-		if (ret)
-			goto out;
-	}
-
-	/* Parent waits for child to be ready. */
-	close(pipefd[1]);
-	while (pipe_message != 1) {
-		if (read(pipefd[0], &pipe_message, sizeof(pipe_message)) <
-		    sizeof(pipe_message)) {
-			ksft_perror("Failed reading message from child process");
-			close(pipefd[0]);
-			goto out;
-		}
-	}
-	close(pipefd[0]);
-
-	/* Signal child to start benchmark */
-	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
-		ksft_perror("sigqueue SIGUSR1 to child");
-		ret = -1;
-		goto out;
-	}
-
-	/* Give benchmark enough time to fully run */
+	/* Give benchmark enough time to fully run. */
 	sleep(1);
 
 	/* Test runs until the callback setup() tells the test to stop. */
@@ -729,8 +632,10 @@ int resctrl_val(const struct resctrl_test *test,
 			break;
 	}
 
-out:
 	kill(bm_pid, SIGKILL);
-
+free_buf:
+	free(buf);
+reset_affinity:
+	taskset_restore(ppid, &old_affinity);
 	return ret;
 }
-- 
2.47.0


