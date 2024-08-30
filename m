Return-Path: <linux-kselftest+bounces-16776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E49A3965FB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 12:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642D71F21315
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2818FDB3;
	Fri, 30 Aug 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Up4oLiJK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073C15C147;
	Fri, 30 Aug 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015421; cv=none; b=PgYsbb+sXbsZFhPeXd52/KsK6bSaTby8HBR/wWrDZ8rBwQFCaecp6XJQaKYV4Yr/2WvkAICrQtXQC9I71JO7DYzFw8YyV9sBNdj7bmeboMmsXxZTEwSFbzxvY9vD5saif8Yf2JOnPTznMOExVjXIgDhuITgzqGxjDp3Ufxx8A+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015421; c=relaxed/simple;
	bh=sttpGSmbHRtdhTxv9II3Mt4znWWYtJCXB0zM63hC3FE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q1wjIoFcdiBop5xhgYiXhPrkCV9I/D84tTj7JXpUmkRpwhF8EJCLTBlFtWiRVWvcelFb858Ab2/b+OW1hYmIyJyvno+lgBei+xhWiCbRqxahrVs0rl8OaW/41EEQfPfeBtWq4hwWbPBo24sPwjceGRNGmqWn5HoozOchlni4uBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Up4oLiJK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725015420; x=1756551420;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sttpGSmbHRtdhTxv9II3Mt4znWWYtJCXB0zM63hC3FE=;
  b=Up4oLiJKa+FrZTXOv7RSOMYSzAY8nnk+1kIhELuzEju4SXVewg4V/jk8
   H2fmMun+hllMmUXQL8i1x32IvXF+dWl+sC1TASkNTqavxe/6ijk3lvtSc
   PmWTD+W3f8m0n75634huEwcFyyYu0DkMdVZOZJlGyNujgJ1HtW0trKRrx
   qRtn9Uc1g78JWs6neWKAZWE1xQQoaibFWJWTpxSQOiqOs7nMjfVYNS5VP
   GJLOjAjgtCYp/FT6USaJtHtZ6tzNB106Lq02SDpJeC23sIrszYqUjQqk0
   PKdYd7bpNxXSqsxrzFMRuaw4IN3NHRmnQgl6tbPmfgJRMJBhnfJN7GL9e
   Q==;
X-CSE-ConnectionGUID: iA9SLiFYQ+uv+DVtfNeSIA==
X-CSE-MsgGUID: iCV9EN1kQMCQcBG4b7O1vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="35058646"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="35058646"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 03:56:59 -0700
X-CSE-ConnectionGUID: wXPJonKLTpat6FsYZhaXMA==
X-CSE-MsgGUID: Anw0jtnIQVmdw+t3xl6Plg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="94692446"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 03:56:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Aug 2024 13:56:52 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] selftests/resctrl: Ensure measurements skip
 initialization of default benchmark
In-Reply-To: <a0fe2be86f3e868a5f908ac4f2c76e71b4d08d4f.1724970211.git.reinette.chatre@intel.com>
Message-ID: <3add783b-74cf-23c0-a301-aa203efdd0f6@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <a0fe2be86f3e868a5f908ac4f2c76e71b4d08d4f.1724970211.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Aug 2024, Reinette Chatre wrote:

> The CMT, MBA, and MBM tests rely on the resctrl_val() wrapper to
> start and run a benchmark while providing test specific flows
> via callbacks to do test specific configuration and measurements.
> 
> At a high level, the resctrl_val() flow is:
> 	a) Start by fork()ing a child process that installs a signal
> 	   handler for SIGUSR1 that, on receipt of SIGUSR1, will
> 	   start running a benchmark.
> 	b) Assign the child process created in (a) to the resctrl
> 	   control and monitoring group that dictates the memory and
> 	   cache allocations with which the process can run and will
> 	   contain all resctrl monitoring data of that process.
> 	c) Once parent and child are considered "ready" (determined via
> 	   a message over a pipe) the parent signals the child (via
> 	   SIGUSR1) to start the benchmark, waits one second for the
> 	   benchmark to run, and then starts collecting monitoring data
> 	   for the tests, potentially also changing allocation
> 	   configuration depending on the various test callbacks.
> 
> A problem with the above flow is the "black box" view of the
> benchmark that is combined with an arbitrarily chosen
> "wait one second" before measurements start. No matter what
> the benchmark does, it is given one second to initialize before
> measurements start.
> 
> The default benchmark "fill_buf" consists of two parts,
> first it prepares a buffer (allocate, initialize, then flush), then it
> reads from the buffer (in unpredictable ways) until terminated.
> Depending on the system and the size of the buffer, the first "prepare"
> part may not be complete by the time the one second delay expires. Test
> measurements may thus start before the work needing to be measured runs.
> 
> Split the default benchmark into its "prepare" and "runtime" parts and
> simplify the resctrl_val() wrapper while doing so. This same split
> cannot be done for the user provided benchmark (without a user
> interface change), so the current behavior is maintained for user
> provided benchmark.
> 
> Assign the test itself to the control and monitoring group and run the
> "prepare" part of the benchmark in this context, ensuring it runs with
> required cache and memory bandwidth allocations. With the benchmark
> preparation complete it is only needed to fork() the "runtime" part
> of the benchmark (or entire user provided benchmark).
> 
> Keep the "wait one second" delay before measurements start. For the
> default "fill_buf" benchmark this time now covers only the "runtime"
> portion that needs to be measured. For the user provided benchmark this
> delay maintains current behavior.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  tools/testing/selftests/resctrl/fill_buf.c    |  19 +-
>  tools/testing/selftests/resctrl/resctrl.h     |   2 +-
>  tools/testing/selftests/resctrl/resctrl_val.c | 225 ++++++------------
>  3 files changed, 70 insertions(+), 176 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index ae120f1735c0..12c71bb44cb6 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -114,7 +114,7 @@ void fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
>  	*value_sink = ret;
>  }
>  
> -static void fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
> +void fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
>  {
>  	while (1) {
>  		fill_one_span_write(buf, buf_size);
> @@ -150,20 +150,3 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush)
>  
>  	return buf;
>  }
> -
> -int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
> -{
> -	unsigned char *buf;
> -
> -	buf = alloc_buffer(buf_size, memflush);
> -	if (!buf)
> -		return -1;
> -
> -	if (op == 0)
> -		fill_cache_read(buf, buf_size, once);
> -	else
> -		fill_cache_write(buf, buf_size, once);
> -	free(buf);
> -
> -	return 0;
> -}
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 2dda56084588..0afbc4dd18e4 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -142,7 +142,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
>  unsigned char *alloc_buffer(size_t buf_size, int memflush);
>  void mem_flush(unsigned char *buf, size_t buf_size);
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
> -int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
> +void fill_cache_write(unsigned char *buf, size_t buf_size, bool once);
>  int initialize_mem_bw_imc(void);
>  int measure_mem_bw(const struct user_params *uparams,
>  		   struct resctrl_val_param *param, pid_t bm_pid,
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 70e8e31f5d1a..574b72604f95 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -448,7 +448,7 @@ static int get_mem_bw_resctrl(FILE *fp, unsigned long *mbm_total)
>  	return 0;
>  }
>  
> -static pid_t bm_pid, ppid;
> +static pid_t bm_pid;
>  
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>  {
> @@ -506,13 +506,6 @@ void signal_handler_unregister(void)
>  	}
>  }
>  
> -static void parent_exit(pid_t ppid)
> -{
> -	kill(ppid, SIGKILL);
> -	umount_resctrlfs();
> -	exit(EXIT_FAILURE);
> -}
> -
>  /*
>   * print_results_bw:	the memory bandwidth results are stored in a file
>   * @filename:		file that stores the results
> @@ -614,61 +607,6 @@ int measure_mem_bw(const struct user_params *uparams,
>  	return ret;
>  }
>  
> -/*
> - * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
> - *		   in specified signal. Direct benchmark stdio to /dev/null.
> - * @signum:	signal number
> - * @info:	signal info
> - * @ucontext:	user context in signal handling
> - */
> -static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
> -{
> -	int operation, ret, memflush;
> -	char **benchmark_cmd;
> -	size_t span;
> -	bool once;
> -	FILE *fp;
> -
> -	benchmark_cmd = info->si_ptr;
> -
> -	/*
> -	 * Direct stdio of child to /dev/null, so that only parent writes to
> -	 * stdio (console)
> -	 */
> -	fp = freopen("/dev/null", "w", stdout);
> -	if (!fp) {
> -		ksft_perror("Unable to direct benchmark status to /dev/null");
> -		parent_exit(ppid);
> -	}
> -
> -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
> -		/* Execute default fill_buf benchmark */
> -		span = strtoul(benchmark_cmd[1], NULL, 10);
> -		memflush =  atoi(benchmark_cmd[2]);
> -		operation = atoi(benchmark_cmd[3]);
> -		if (!strcmp(benchmark_cmd[4], "true")) {
> -			once = true;
> -		} else if (!strcmp(benchmark_cmd[4], "false")) {
> -			once = false;
> -		} else {
> -			ksft_print_msg("Invalid once parameter\n");
> -			parent_exit(ppid);
> -		}
> -
> -		if (run_fill_buf(span, memflush, operation, once))
> -			fprintf(stderr, "Error in running fill buffer\n");
> -	} else {
> -		/* Execute specified benchmark */
> -		ret = execvp(benchmark_cmd[0], benchmark_cmd);
> -		if (ret)
> -			ksft_perror("execvp");
> -	}
> -
> -	fclose(stdout);
> -	ksft_print_msg("Unable to run specified benchmark\n");
> -	parent_exit(ppid);
> -}
> -
>  /*
>   * resctrl_val:	execute benchmark and measure memory bandwidth on
>   *			the benchmark
> @@ -684,11 +622,13 @@ int resctrl_val(const struct resctrl_test *test,
>  		const char * const *benchmark_cmd,
>  		struct resctrl_val_param *param)
>  {
> -	struct sigaction sigact;
> -	int ret = 0, pipefd[2];
> -	char pipe_message = 0;
> -	union sigval value;
> -	int domain_id;
> +	int domain_id, operation = 0, memflush = 1;
> +	size_t span = DEFAULT_SPAN;
> +	unsigned char *buf = NULL;
> +	cpu_set_t old_affinity;
> +	bool once = false;
> +	int ret = 0;
> +	pid_t ppid;
>  
>  	if (strcmp(param->filename, "") == 0)
>  		sprintf(param->filename, "stdio");
> @@ -699,111 +639,80 @@ int resctrl_val(const struct resctrl_test *test,
>  		return ret;
>  	}
>  
> -	/*
> -	 * If benchmark wasn't successfully started by child, then child should
> -	 * kill parent, so save parent's pid
> -	 */
>  	ppid = getpid();
>  
> -	if (pipe(pipefd)) {
> -		ksft_perror("Unable to create pipe");
> +	/* Taskset test to specified CPU. */
> +	ret = taskset_benchmark(ppid, uparams->cpu, &old_affinity);

Previously only CPU affinity for bm_pid was set but now it's set before 
fork(). Quickly checking the Internet, it seems that CPU affinity gets
inherited on fork() so now both processes will have the same affinity
which might make the other process to interfere with the measurement.

> +	if (ret)
> +		return ret;
>  
> -		return -1;
> +	/* Write test to specified control & monitoring group in resctrl FS. */
> +	ret = write_bm_pid_to_resctrl(ppid, param->ctrlgrp, param->mongrp);

Previously, this was done for bm_pid but now it's done for the parent. I'm 
not sure how inheritance goes with resctrl on fork(), will the forked PID 
get added to the list of PIDs or not? You probably know the answer :-).
Neither behavior, however, seems to result in the intended behavior as we 
either get interfering processes (if inherited) or no desired resctrl 
setup for the benchmark process.

> +	if (ret)
> +		goto reset_affinity;
> +
> +	if (param->init) {
> +		ret = param->init(param, domain_id);
> +		if (ret)
> +			goto reset_affinity;
>  	}
>  
>  	/*
> -	 * Fork to start benchmark, save child's pid so that it can be killed
> -	 * when needed
> +	 * If not running user provided benchmark, run the default
> +	 * "fill_buf". First phase of "fill_buf" is to prepare the
> +	 * buffer that the benchmark will operate on. No measurements
> +	 * are needed during this phase and prepared memory will be
> +	 * passed to next part of benchmark via copy-on-write. TBD
> +	 * how this impacts "write" benchmark, but no test currently
> +	 * uses this.
>  	 */
> -	fflush(stdout);

Please don't remove fflush() in front of fork() as it leads to duplicating 
messages.

-- 
 i.

> +	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
> +		span = strtoul(benchmark_cmd[1], NULL, 10);
> +		memflush =  atoi(benchmark_cmd[2]);
> +		operation = atoi(benchmark_cmd[3]);
> +		if (!strcmp(benchmark_cmd[4], "true")) {
> +			once = true;
> +		} else if (!strcmp(benchmark_cmd[4], "false")) {
> +			once = false;
> +		} else {
> +			ksft_print_msg("Invalid once parameter\n");
> +			ret = -EINVAL;
> +			goto reset_affinity;
> +		}
> +
> +		buf = alloc_buffer(span, memflush);
> +		if (!buf) {
> +			ret = -ENOMEM;
> +			goto reset_affinity;
> +		}
> +	}
> +
>  	bm_pid = fork();
>  	if (bm_pid == -1) {
> +		ret = -errno;
>  		ksft_perror("Unable to fork");
> -
> -		return -1;
> +		goto free_buf;
>  	}
>  
> +	/*
> +	 * What needs to be measured runs in separate process until
> +	 * terminated.
> +	 */
>  	if (bm_pid == 0) {
> -		/*
> -		 * Mask all signals except SIGUSR1, parent uses SIGUSR1 to
> -		 * start benchmark
> -		 */
> -		sigfillset(&sigact.sa_mask);
> -		sigdelset(&sigact.sa_mask, SIGUSR1);
> -
> -		sigact.sa_sigaction = run_benchmark;
> -		sigact.sa_flags = SA_SIGINFO;
> -
> -		/* Register for "SIGUSR1" signal from parent */
> -		if (sigaction(SIGUSR1, &sigact, NULL)) {
> -			ksft_perror("Can't register child for signal");
> -			parent_exit(ppid);
> +		if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
> +			if (operation == 0)
> +				fill_cache_read(buf, span, once);
> +			else
> +				fill_cache_write(buf, span, once);
> +		} else {
> +			execvp(benchmark_cmd[0], (char **)benchmark_cmd);
>  		}
> -
> -		/* Tell parent that child is ready */
> -		close(pipefd[0]);
> -		pipe_message = 1;
> -		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
> -		    sizeof(pipe_message)) {
> -			ksft_perror("Failed signaling parent process");
> -			close(pipefd[1]);
> -			return -1;
> -		}
> -		close(pipefd[1]);
> -
> -		/* Suspend child until delivery of "SIGUSR1" from parent */
> -		sigsuspend(&sigact.sa_mask);
> -
> -		ksft_perror("Child is done");
> -		parent_exit(ppid);
> +		exit(EXIT_SUCCESS);
>  	}
>  
>  	ksft_print_msg("Benchmark PID: %d\n", (int)bm_pid);
>  
> -	/*
> -	 * The cast removes constness but nothing mutates benchmark_cmd within
> -	 * the context of this process. At the receiving process, it becomes
> -	 * argv, which is mutable, on exec() but that's after fork() so it
> -	 * doesn't matter for the process running the tests.
> -	 */
> -	value.sival_ptr = (void *)benchmark_cmd;
> -
> -	/* Taskset benchmark to specified cpu */
> -	ret = taskset_benchmark(bm_pid, uparams->cpu, NULL);
> -	if (ret)
> -		goto out;
> -
> -	/* Write benchmark to specified control&monitoring grp in resctrl FS */
> -	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp);
> -	if (ret)
> -		goto out;
> -
> -	if (param->init) {
> -		ret = param->init(param, domain_id);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	/* Parent waits for child to be ready. */
> -	close(pipefd[1]);
> -	while (pipe_message != 1) {
> -		if (read(pipefd[0], &pipe_message, sizeof(pipe_message)) <
> -		    sizeof(pipe_message)) {
> -			ksft_perror("Failed reading message from child process");
> -			close(pipefd[0]);
> -			goto out;
> -		}
> -	}
> -	close(pipefd[0]);
> -
> -	/* Signal child to start benchmark */
> -	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
> -		ksft_perror("sigqueue SIGUSR1 to child");
> -		ret = -1;
> -		goto out;
> -	}
> -
> -	/* Give benchmark enough time to fully run */
> +	/* Give benchmark enough time to fully run. */
>  	sleep(1);
>  
>  	/* Test runs until the callback setup() tells the test to stop. */
> @@ -821,8 +730,10 @@ int resctrl_val(const struct resctrl_test *test,
>  			break;
>  	}
>  
> -out:
>  	kill(bm_pid, SIGKILL);
> -
> +free_buf:
> +	free(buf);
> +reset_affinity:
> +	taskset_restore(ppid, &old_affinity);
>  	return ret;
>  }
> 


