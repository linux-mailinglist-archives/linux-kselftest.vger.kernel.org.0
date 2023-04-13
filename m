Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1E6E07AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 09:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjDMHY0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjDMHYT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 03:24:19 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 00:24:12 PDT
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BB38A62;
        Thu, 13 Apr 2023 00:24:12 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="92736996"
X-IronPort-AV: E=Sophos;i="5.98,339,1673881200"; 
   d="scan'208";a="92736996"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 16:23:05 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0E944DD9AA;
        Thu, 13 Apr 2023 16:23:04 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4629C15FDD8;
        Thu, 13 Apr 2023 16:23:03 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id ED9C3400C07D0;
        Thu, 13 Apr 2023 16:23:02 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 5/6] selftests/resctrl: Commonize the signal handler register/unregister for all tests
Date:   Thu, 13 Apr 2023 16:22:58 +0900
Message-Id: <20230413072259.2089348-6-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com>
References: <20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com>
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

After creating a child process with fork() in CAT test, if a signal such
as SIGINT is received, the parent process will be terminated immediately,
and therefore the child process will not be killed and also resctrlfs is
not unmounted.

There is a signal handler registered in CMT/MBM/MBA tests, which kills
child process, unmount resctrlfs, cleanups result files, etc., if a
signal such as SIGINT is received.

Commonize the signal handler registered for CMT/MBM/MBA tests and
reuse it in CAT.

To reuse the signal handler to kill child process use global bm_pid
instead of local bm_pid.

Also, since the MBA/MBA/CMT/CAT are run in order, unregister the signal
handler at the end of each test so that the signal handler cannot be
inherited by other tests.

Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  9 ++-
 tools/testing/selftests/resctrl/fill_buf.c    | 14 ----
 tools/testing/selftests/resctrl/resctrl.h     |  2 +
 tools/testing/selftests/resctrl/resctrl_val.c | 66 ++++++++++++++-----
 4 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 0880575840f9..fb1443f888c4 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -103,7 +103,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	unsigned long l_mask, l_mask_1;
 	int ret, pipefd[2], sibling_cpu_no;
 	char pipe_message;
-	pid_t bm_pid;
 
 	cache_size = 0;
 
@@ -181,6 +180,12 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
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
@@ -217,8 +222,10 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		}
 		close(pipefd[0]);
 		kill(bm_pid, SIGKILL);
+		signal_handler_unregister();
 	}
 
+out:
 	cat_test_cleanup();
 	if (bm_pid)
 		umount_resctrlfs();
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 3cd0b337eae5..341cc93ca84c 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -32,14 +32,6 @@ static void sb(void)
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
@@ -201,12 +193,6 @@ int run_fill_buf(unsigned long span, int malloc_and_init_memory,
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
index 9555a6f683f7..87e39456dee0 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -109,6 +109,8 @@ void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type, char *cbm_mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
+int signal_handler_register(void);
+void signal_handler_unregister(void);
 int cat_val(struct resctrl_val_param *param);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index e632657995c7..ab1eab1e7ff6 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -476,6 +476,45 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 	exit(EXIT_SUCCESS);
 }
 
+/*
+ * Register CTRL-C handler for parent, as it has to kill
+ * child process before exiting.
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
+ * Non-Value return because the caller should keep
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
+	ret = signal_handler_register();
+	if (ret)
 		goto out;
-	}
 
 	value.sival_ptr = benchmark_cmd;
 
 	/* Taskset benchmark to specified cpu */
 	ret = taskset_benchmark(bm_pid, param->cpu_no);
 	if (ret)
-		goto out;
+		goto unregister;
 
 	/* Write benchmark to specified control&monitoring grp in resctrl FS */
 	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
 				      resctrl_val);
 	if (ret)
-		goto out;
+		goto unregister;
 
 	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 		ret = initialize_mem_bw_imc();
 		if (ret)
-			goto out;
+			goto unregister;
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
 					  param->cpu_no, resctrl_val);
@@ -718,7 +746,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 		    sizeof(pipe_message)) {
 			perror("# failed reading message from child process");
 			close(pipefd[0]);
-			goto out;
+			goto unregister;
 		}
 	}
 	close(pipefd[0]);
@@ -727,7 +755,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
 		perror("# sigqueue SIGUSR1 to child");
 		ret = errno;
-		goto out;
+		goto unregister;
 	}
 
 	/* Give benchmark enough time to fully run */
@@ -756,6 +784,8 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 		}
 	}
 
+unregister:
+	signal_handler_unregister();
 out:
 	kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
-- 
2.27.0

