Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38D968242A
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 06:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjAaFuy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 00:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjAaFuv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 00:50:51 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1867D3BDA6;
        Mon, 30 Jan 2023 21:50:40 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="84409738"
X-IronPort-AV: E=Sophos;i="5.97,259,1669042800"; 
   d="scan'208";a="84409738"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:50:37 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id F360FD4324;
        Tue, 31 Jan 2023 14:50:35 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 33BB4D8C81;
        Tue, 31 Jan 2023 14:50:35 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id E9C4640003AFE;
        Tue, 31 Jan 2023 14:50:34 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error occurs in CAT test
Date:   Tue, 31 Jan 2023 14:46:54 +0900
Message-Id: <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com>
References: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After creating a child process with fork() in CAT test, if an error
occurs or a signal such as SIGINT is received, the parent process will
be terminated immediately, and therefor the child process will not
be killed and also resctrlfs is not unmounted.

There is a signal handler registered in CMT/MBM/MBA tests, which kills
child process, unmount resctrlfs, cleanups result files, etc., if a
signal such as SIGINT is received.

Commonize the signal handler registered for CMT/MBM/MBA tests and reuse
it in CAT too.

To reuse the signal handler, make the child process in CAT wait to be
killed by parent process in any case (an error occurred or a signal was
received), and when killing child process use global bm_pid instead of
local bm_pid.

Also, since the MBA/MBA/CMT/CAT are run in order, unregister the signal
handler at the end of each test so that the signal handler cannot be
inherited by other tests.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c    | 28 ++++----
 tools/testing/selftests/resctrl/fill_buf.c    | 14 ----
 tools/testing/selftests/resctrl/resctrl.h     |  2 +
 tools/testing/selftests/resctrl/resctrl_val.c | 70 +++++++++++++------
 4 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 6a8306b0a109..3524fa88e3a4 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -103,7 +103,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	unsigned long l_mask, l_mask_1;
 	int ret, pipefd[2], sibling_cpu_no;
 	char pipe_message;
-	pid_t bm_pid;
 
 	cache_size = 0;
 
@@ -181,28 +180,31 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
+	} else {
+		ret = signal_handler_register();
+		if (ret) {
+			kill(bm_pid, SIGKILL);
+			goto out;
+		}
 	}
 
 	remove(param.filename);
 
 	ret = cat_val(&param);
-	if (ret)
-		return ret;
-
-	ret = check_results(&param);
-	if (ret)
-		return ret;
+	if (ret == 0)
+		ret = check_results(&param);
 
 	if (bm_pid == 0) {
 		/* Tell parent that child is ready */
 		close(pipefd[0]);
 		pipe_message = 1;
 		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
-		    sizeof(pipe_message)) {
-			close(pipefd[1]);
+		    sizeof(pipe_message))
+			/*
+			 * Just print the error message.
+			 * Let while(1) run and wait for itself to be killed.
+			 */
 			perror("# failed signaling parent process");
-			return errno;
-		}
 
 		close(pipefd[1]);
 		while (1)
@@ -222,9 +224,11 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		kill(bm_pid, SIGKILL);
 	}
 
+	signal_handler_unregister();
+out:
 	cat_test_cleanup();
 	if (bm_pid)
 		umount_resctrlfs();
 
-	return 0;
+	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 56ccbeae0638..322c6812e15c 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -33,14 +33,6 @@ static void sb(void)
 #endif
 }
 
-static void ctrl_handler(int signo)
-{
-	free(startptr);
-	printf("\nEnding\n");
-	sb();
-	exit(EXIT_SUCCESS);
-}
-
 static void cl_flush(void *p)
 {
 #if defined(__i386) || defined(__x86_64)
@@ -198,12 +190,6 @@ int run_fill_buf(unsigned long span, int malloc_and_init_memory,
 	unsigned long long cache_size = span;
 	int ret;
 
-	/* set up ctrl-c handler */
-	if (signal(SIGINT, ctrl_handler) == SIG_ERR)
-		printf("Failed to catch SIGINT!\n");
-	if (signal(SIGHUP, ctrl_handler) == SIG_ERR)
-		printf("Failed to catch SIGHUP!\n");
-
 	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
 			 resctrl_val);
 	if (ret) {
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f0ded31fb3c7..92b59d2f603d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -107,6 +107,8 @@ void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type, char *cbm_mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
+int signal_handler_register(void);
+void signal_handler_unregister(void);
 int cat_val(struct resctrl_val_param *param);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 6948843bf995..c2be2f2505a8 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -476,6 +476,45 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 	exit(EXIT_SUCCESS);
 }
 
+/*
+ * Register CTRL-C handler for parent, as it has to kill
+ * child process before exiting
+ */
+int signal_handler_register(void)
+{
+	struct sigaction sigact;
+	int ret = 0;
+
+	sigact.sa_sigaction = ctrlc_handler;
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGTERM, &sigact, NULL) ||
+	    sigaction(SIGHUP, &sigact, NULL)) {
+		perror("# sigaction");
+		ret = -1;
+	}
+	return ret;
+}
+
+/*
+ * Reset signal handler to SIG_DFL.
+ * Non-Vaule return because the caller should keep
+ * the error code of other path even if sigaction fails.
+ */
+void signal_handler_unregister(void)
+{
+	struct sigaction sigact;
+
+	sigact.sa_handler = SIG_DFL;
+	sigemptyset(&sigact.sa_mask);
+	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGTERM, &sigact, NULL) ||
+	    sigaction(SIGHUP, &sigact, NULL)) {
+		perror("# sigaction");
+	}
+}
+
 /*
  * print_results_bw:	the memory bandwidth results are stored in a file
  * @filename:		file that stores the results
@@ -671,39 +710,28 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
 
-	/*
-	 * Register CTRL-C handler for parent, as it has to kill benchmark
-	 * before exiting
-	 */
-	sigact.sa_sigaction = ctrlc_handler;
-	sigemptyset(&sigact.sa_mask);
-	sigact.sa_flags = SA_SIGINFO;
-	if (sigaction(SIGINT, &sigact, NULL) ||
-	    sigaction(SIGTERM, &sigact, NULL) ||
-	    sigaction(SIGHUP, &sigact, NULL)) {
-		perror("# sigaction");
-		ret = errno;
-		goto out;
-	}
+	ret = signal_handler_register();
+	if (ret)
+		goto out1;
 
 	value.sival_ptr = benchmark_cmd;
 
 	/* Taskset benchmark to specified cpu */
 	ret = taskset_benchmark(bm_pid, param->cpu_no);
 	if (ret)
-		goto out;
+		goto out2;
 
 	/* Write benchmark to specified control&monitoring grp in resctrl FS */
 	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
 				      resctrl_val);
 	if (ret)
-		goto out;
+		goto out2;
 
 	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 		ret = initialize_mem_bw_imc();
 		if (ret)
-			goto out;
+			goto out2;
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
 					  param->cpu_no, resctrl_val);
@@ -718,7 +746,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 		    sizeof(pipe_message)) {
 			perror("# failed reading message from child process");
 			close(pipefd[0]);
-			goto out;
+			goto out2;
 		}
 	}
 	close(pipefd[0]);
@@ -727,7 +755,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
 		perror("# sigqueue SIGUSR1 to child");
 		ret = errno;
-		goto out;
+		goto out2;
 	}
 
 	/* Give benchmark enough time to fully run */
@@ -761,7 +789,9 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 		}
 	}
 
-out:
+out2:
+	signal_handler_unregister();
+out1:
 	kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
 
-- 
2.27.0

