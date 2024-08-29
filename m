Return-Path: <linux-kselftest+bounces-16744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 197B696532D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 00:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCAD1F220B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 22:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90711BE241;
	Thu, 29 Aug 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="el9KEMn0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EC18B47B;
	Thu, 29 Aug 2024 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971962; cv=none; b=Fo5akK2pS4p/lS/i8ETiDHlACsePauJO4EAxJg0JJVFEpUpnodA4USapwbXTSj0f8rqDxcDexl6/UuqRtkwXYk7ghkR5W524oEFDYRgGX5QbvL0PfXjcS5QhP6ZVL3608cZkTMVMeUTzv+ZIKWxiGKqmbFeFIHnucZGFgTjrGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971962; c=relaxed/simple;
	bh=0OjFF+To1zRUAdydXuWXh/Hwmgo2V5m4CUUVuEHN6gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vmpia2oWhJPrSZJWqX1wqGKsLXY5A1BoWuYgwjooFIuxHKWA6f5eQYT9B+Iyk1y8p4tSJRVEQK4m8ruf7u5B2dUz0VaJ1NQjUz1C7Bmk2TLJjgu+IQgcr0L3B7NgfJXYukt+rkbD0iHVC5rYmW+qi8KF2AP5I3eVG4Das1s9Nw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=el9KEMn0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724971961; x=1756507961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0OjFF+To1zRUAdydXuWXh/Hwmgo2V5m4CUUVuEHN6gk=;
  b=el9KEMn0a9ld6nmNCHCdCmVfKrqSqnVtWDle6bSeq7X46VUztFGNIPgW
   SKRZ2Jnw3iOK154aHXwvMYq5DqekG6Ry43rpVXp3RoEFTnSgq3f/DEuHI
   WGXPfo02woVgr3BsMtOgrvdhWBN1G3NBGw9GbsUR+ZTXAf5kM9hOh438g
   +pP1OTed0WFedDPgEMR3+FCW6nKLk5zRajpUcCRCU3FV/3wTR1BP7RanT
   GuLBymCbIZb8ARtf0hn/X1UrGX494DPzj0DMUgJkNzeL3nR44PhfWpheM
   y5CkTyE4auy2IaZb+00vX7MC/jbh0pNGfTzDwSqz7leseHmPWUejornFb
   w==;
X-CSE-ConnectionGUID: 0kLUHk83S7uvt8iypF0z2g==
X-CSE-MsgGUID: 70qk6Zr8SwaMsTPkAnOyrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27479159"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27479159"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:39 -0700
X-CSE-ConnectionGUID: KpkrqGBLS5Gf5tEg7/evUQ==
X-CSE-MsgGUID: 6axeBCsNTT2OYRYLcluLjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63415128"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO rchatre-mobl4.intel.com) ([10.125.111.220])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:39 -0700
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
Subject: [PATCH 2/6] selftests/resctrl: Ensure measurements skip initialization of default benchmark
Date: Thu, 29 Aug 2024 15:52:28 -0700
Message-ID: <a0fe2be86f3e868a5f908ac4f2c76e71b4d08d4f.1724970211.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724970211.git.reinette.chatre@intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
---
 tools/testing/selftests/resctrl/fill_buf.c    |  19 +-
 tools/testing/selftests/resctrl/resctrl.h     |   2 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 225 ++++++------------
 3 files changed, 70 insertions(+), 176 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index ae120f1735c0..12c71bb44cb6 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -114,7 +114,7 @@ void fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
 	*value_sink = ret;
 }
 
-static void fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
+void fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
 {
 	while (1) {
 		fill_one_span_write(buf, buf_size);
@@ -150,20 +150,3 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush)
 
 	return buf;
 }
-
-int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
-{
-	unsigned char *buf;
-
-	buf = alloc_buffer(buf_size, memflush);
-	if (!buf)
-		return -1;
-
-	if (op == 0)
-		fill_cache_read(buf, buf_size, once);
-	else
-		fill_cache_write(buf, buf_size, once);
-	free(buf);
-
-	return 0;
-}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 2dda56084588..0afbc4dd18e4 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -142,7 +142,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
-int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
+void fill_cache_write(unsigned char *buf, size_t buf_size, bool once);
 int initialize_mem_bw_imc(void);
 int measure_mem_bw(const struct user_params *uparams,
 		   struct resctrl_val_param *param, pid_t bm_pid,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 70e8e31f5d1a..574b72604f95 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -448,7 +448,7 @@ static int get_mem_bw_resctrl(FILE *fp, unsigned long *mbm_total)
 	return 0;
 }
 
-static pid_t bm_pid, ppid;
+static pid_t bm_pid;
 
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
@@ -506,13 +506,6 @@ void signal_handler_unregister(void)
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
@@ -614,61 +607,6 @@ int measure_mem_bw(const struct user_params *uparams,
 	return ret;
 }
 
-/*
- * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
- *		   in specified signal. Direct benchmark stdio to /dev/null.
- * @signum:	signal number
- * @info:	signal info
- * @ucontext:	user context in signal handling
- */
-static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
-{
-	int operation, ret, memflush;
-	char **benchmark_cmd;
-	size_t span;
-	bool once;
-	FILE *fp;
-
-	benchmark_cmd = info->si_ptr;
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
-	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
-		/* Execute default fill_buf benchmark */
-		span = strtoul(benchmark_cmd[1], NULL, 10);
-		memflush =  atoi(benchmark_cmd[2]);
-		operation = atoi(benchmark_cmd[3]);
-		if (!strcmp(benchmark_cmd[4], "true")) {
-			once = true;
-		} else if (!strcmp(benchmark_cmd[4], "false")) {
-			once = false;
-		} else {
-			ksft_print_msg("Invalid once parameter\n");
-			parent_exit(ppid);
-		}
-
-		if (run_fill_buf(span, memflush, operation, once))
-			fprintf(stderr, "Error in running fill buffer\n");
-	} else {
-		/* Execute specified benchmark */
-		ret = execvp(benchmark_cmd[0], benchmark_cmd);
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
@@ -684,11 +622,13 @@ int resctrl_val(const struct resctrl_test *test,
 		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param)
 {
-	struct sigaction sigact;
-	int ret = 0, pipefd[2];
-	char pipe_message = 0;
-	union sigval value;
-	int domain_id;
+	int domain_id, operation = 0, memflush = 1;
+	size_t span = DEFAULT_SPAN;
+	unsigned char *buf = NULL;
+	cpu_set_t old_affinity;
+	bool once = false;
+	int ret = 0;
+	pid_t ppid;
 
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
@@ -699,111 +639,80 @@ int resctrl_val(const struct resctrl_test *test,
 		return ret;
 	}
 
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
 
-		return -1;
+	/* Write test to specified control & monitoring group in resctrl FS. */
+	ret = write_bm_pid_to_resctrl(ppid, param->ctrlgrp, param->mongrp);
+	if (ret)
+		goto reset_affinity;
+
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
+	 * passed to next part of benchmark via copy-on-write. TBD
+	 * how this impacts "write" benchmark, but no test currently
+	 * uses this.
 	 */
-	fflush(stdout);
+	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
+		span = strtoul(benchmark_cmd[1], NULL, 10);
+		memflush =  atoi(benchmark_cmd[2]);
+		operation = atoi(benchmark_cmd[3]);
+		if (!strcmp(benchmark_cmd[4], "true")) {
+			once = true;
+		} else if (!strcmp(benchmark_cmd[4], "false")) {
+			once = false;
+		} else {
+			ksft_print_msg("Invalid once parameter\n");
+			ret = -EINVAL;
+			goto reset_affinity;
+		}
+
+		buf = alloc_buffer(span, memflush);
+		if (!buf) {
+			ret = -ENOMEM;
+			goto reset_affinity;
+		}
+	}
+
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
+		if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
+			if (operation == 0)
+				fill_cache_read(buf, span, once);
+			else
+				fill_cache_write(buf, span, once);
+		} else {
+			execvp(benchmark_cmd[0], (char **)benchmark_cmd);
 		}
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
+		exit(EXIT_SUCCESS);
 	}
 
 	ksft_print_msg("Benchmark PID: %d\n", (int)bm_pid);
 
-	/*
-	 * The cast removes constness but nothing mutates benchmark_cmd within
-	 * the context of this process. At the receiving process, it becomes
-	 * argv, which is mutable, on exec() but that's after fork() so it
-	 * doesn't matter for the process running the tests.
-	 */
-	value.sival_ptr = (void *)benchmark_cmd;
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
@@ -821,8 +730,10 @@ int resctrl_val(const struct resctrl_test *test,
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
2.46.0


