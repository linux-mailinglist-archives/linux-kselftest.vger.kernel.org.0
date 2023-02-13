Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17C66942D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 11:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjBMK3s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 05:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBMK3s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 05:29:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3121CC37;
        Mon, 13 Feb 2023 02:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676284186; x=1707820186;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nf320NwdQ3AvlMHzKHnvarphv0YLb22mbr/M6SepNEc=;
  b=FUtY7NQBjw7ObfbaCuwUnZZzjGdTMusfF45YZ1lHfY6Op/vCMeL+0PXm
   HPKqUWGIqf23P/5oqXVUjgDegA6OGWoWnXBpulurj1NKZB2ghW4weoqv0
   pPautJzk+vVkGE/az2mBj6CLibb5LUYJHLMZAICJ0RU0Xnp+Zkk6XM0FV
   qAnZxRr2kP74JPdoMckx+DlK/aB4Tksspp+94Yzjsm0jasJYloc+lvMJd
   4JC+tTRquDn5jzgmccdCSbAjYeAciWvw92rZgiD14L3C8J6tIj0rbYKpF
   d9P5qDXkkxhF2GJqP7WsGJ6EcYO7yAvrz8VMWSuMVjXOHL0ptUmDui74B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="314502140"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="314502140"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 02:29:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="811540812"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="811540812"
Received: from hdevries-mobl.ger.corp.intel.com ([10.249.36.140])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 02:29:44 -0800
Date:   Mon, 13 Feb 2023 12:29:41 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 5/6] selftests/resctrl: Commonize the signal handler
 register/unregister for all tests
In-Reply-To: <20230213062428.1721572-6-tan.shaopeng@jp.fujitsu.com>
Message-ID: <b0c6fd3a-c983-1082-da46-6bcb754f3ff4@linux.intel.com>
References: <20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com> <20230213062428.1721572-6-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1666962008-1676284185=:1712"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1666962008-1676284185=:1712
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 13 Feb 2023, Shaopeng Tan wrote:

> After creating a child process with fork() in CAT test, if a signal such
> as SIGINT is received, the parent process will be terminated immediately,
> and therefor the child process will not be killed and also resctrlfs is

therefore

> not unmounted.
> 
> There is a signal handler registered in CMT/MBM/MBA tests, which kills
> child process, unmount resctrlfs, cleanups result files, etc., if a
> signal such as SIGINT is received.
> 
> Commonize the signal handler registered for CMT/MBM/MBA tests and
> reuse it in CAT.
> 
> To reuse the signal handler to kill child process use global bm_pid
> instead of local bm_pid.
> 
> Also, since the MBA/MBA/CMT/CAT are run in order, unregister the signal
> handler at the end of each test so that the signal handler cannot be
> inherited by other tests.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

This looks okay.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

As a general comment, it would be probably nicer structure to put all
IPC related code into ipc.c rather than have it in the test related files
(mainly signal handling, pipe write/wait).

> ---
>  tools/testing/selftests/resctrl/cat_test.c    |  9 ++-
>  tools/testing/selftests/resctrl/fill_buf.c    | 14 ----
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>  tools/testing/selftests/resctrl/resctrl_val.c | 66 ++++++++++++++-----
>  4 files changed, 58 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 477b62dac546..0bdf0305a506 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -103,7 +103,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	unsigned long l_mask, l_mask_1;
>  	int ret, pipefd[2], sibling_cpu_no;
>  	char pipe_message;
> -	pid_t bm_pid;
>  
>  	cache_size = 0;
>  
> @@ -181,6 +180,12 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		strcpy(param.filename, RESULT_FILE_NAME1);
>  		param.num_of_runs = 0;
>  		param.cpu_no = sibling_cpu_no;
> +	} else {
> +		ret = signal_handler_register();
> +		if (ret) {
> +			kill(bm_pid, SIGKILL);
> +			goto out;
> +		}
>  	}
>  
>  	remove(param.filename);
> @@ -217,8 +222,10 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		}
>  		close(pipefd[0]);
>  		kill(bm_pid, SIGKILL);
> +		signal_handler_unregister();
>  	}
>  
> +out:
>  	cat_test_cleanup();
>  	if (bm_pid)
>  		umount_resctrlfs();
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 56ccbeae0638..322c6812e15c 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -33,14 +33,6 @@ static void sb(void)
>  #endif
>  }
>  
> -static void ctrl_handler(int signo)
> -{
> -	free(startptr);
> -	printf("\nEnding\n");
> -	sb();
> -	exit(EXIT_SUCCESS);
> -}
> -
>  static void cl_flush(void *p)
>  {
>  #if defined(__i386) || defined(__x86_64)
> @@ -198,12 +190,6 @@ int run_fill_buf(unsigned long span, int malloc_and_init_memory,
>  	unsigned long long cache_size = span;
>  	int ret;
>  
> -	/* set up ctrl-c handler */
> -	if (signal(SIGINT, ctrl_handler) == SIG_ERR)
> -		printf("Failed to catch SIGINT!\n");
> -	if (signal(SIGHUP, ctrl_handler) == SIG_ERR)
> -		printf("Failed to catch SIGHUP!\n");
> -
>  	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
>  			 resctrl_val);
>  	if (ret) {
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index f0ded31fb3c7..92b59d2f603d 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -107,6 +107,8 @@ void mba_test_cleanup(void);
>  int get_cbm_mask(char *cache_type, char *cbm_mask);
>  int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
> +int signal_handler_register(void);
> +void signal_handler_unregister(void);
>  int cat_val(struct resctrl_val_param *param);
>  void cat_test_cleanup(void);
>  int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 6948843bf995..7c8d5c25e6da 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -476,6 +476,45 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>  	exit(EXIT_SUCCESS);
>  }
>  
> +/*
> + * Register CTRL-C handler for parent, as it has to kill
> + * child process before exiting.
> + */
> +int signal_handler_register(void)
> +{
> +	struct sigaction sigact;
> +	int ret = 0;
> +
> +	sigact.sa_sigaction = ctrlc_handler;
> +	sigemptyset(&sigact.sa_mask);
> +	sigact.sa_flags = SA_SIGINFO;
> +	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGTERM, &sigact, NULL) ||
> +	    sigaction(SIGHUP, &sigact, NULL)) {
> +		perror("# sigaction");
> +		ret = -1;
> +	}
> +	return ret;
> +}
> +
> +/*
> + * Reset signal handler to SIG_DFL.
> + * Non-Value return because the caller should keep
> + * the error code of other path even if sigaction fails.
> + */
> +void signal_handler_unregister(void)
> +{
> +	struct sigaction sigact;
> +
> +	sigact.sa_handler = SIG_DFL;
> +	sigemptyset(&sigact.sa_mask);
> +	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGTERM, &sigact, NULL) ||
> +	    sigaction(SIGHUP, &sigact, NULL)) {
> +		perror("# sigaction");
> +	}
> +}
> +
>  /*
>   * print_results_bw:	the memory bandwidth results are stored in a file
>   * @filename:		file that stores the results
> @@ -671,39 +710,28 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  
>  	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
>  
> -	/*
> -	 * Register CTRL-C handler for parent, as it has to kill benchmark
> -	 * before exiting
> -	 */
> -	sigact.sa_sigaction = ctrlc_handler;
> -	sigemptyset(&sigact.sa_mask);
> -	sigact.sa_flags = SA_SIGINFO;
> -	if (sigaction(SIGINT, &sigact, NULL) ||
> -	    sigaction(SIGTERM, &sigact, NULL) ||
> -	    sigaction(SIGHUP, &sigact, NULL)) {
> -		perror("# sigaction");
> -		ret = errno;
> +	ret = signal_handler_register();
> +	if (ret)
>  		goto out;
> -	}
>  
>  	value.sival_ptr = benchmark_cmd;
>  
>  	/* Taskset benchmark to specified cpu */
>  	ret = taskset_benchmark(bm_pid, param->cpu_no);
>  	if (ret)
> -		goto out;
> +		goto unregister;
>  
>  	/* Write benchmark to specified control&monitoring grp in resctrl FS */
>  	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
>  				      resctrl_val);
>  	if (ret)
> -		goto out;
> +		goto unregister;
>  
>  	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
>  	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
>  		ret = initialize_mem_bw_imc();
>  		if (ret)
> -			goto out;
> +			goto unregister;
>  
>  		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
>  					  param->cpu_no, resctrl_val);
> @@ -718,7 +746,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  		    sizeof(pipe_message)) {
>  			perror("# failed reading message from child process");
>  			close(pipefd[0]);
> -			goto out;
> +			goto unregister;
>  		}
>  	}
>  	close(pipefd[0]);
> @@ -727,7 +755,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
>  		perror("# sigqueue SIGUSR1 to child");
>  		ret = errno;
> -		goto out;
> +		goto unregister;
>  	}
>  
>  	/* Give benchmark enough time to fully run */
> @@ -761,6 +789,8 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  		}
>  	}
>  
> +unregister:
> +	signal_handler_unregister();
>  out:
>  	kill(bm_pid, SIGKILL);
>  	umount_resctrlfs();
> 
--8323329-1666962008-1676284185=:1712--
