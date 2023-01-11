Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB466558F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjAKH7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 02:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjAKH7g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 02:59:36 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C6BE4;
        Tue, 10 Jan 2023 23:59:34 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="103632564"
X-IronPort-AV: E=Sophos;i="5.96,315,1665414000"; 
   d="scan'208";a="103632564"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Jan 2023 16:59:32 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 63E34DE50E;
        Wed, 11 Jan 2023 16:59:31 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B2335D507A;
        Wed, 11 Jan 2023 16:59:30 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 8F1824007B0E9;
        Wed, 11 Jan 2023 16:59:30 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v5 4/5] selftests/resctrl: Cleanup properly when an error occurs in CAT test
Date:   Wed, 11 Jan 2023 16:58:01 +0900
Message-Id: <20230111075802.3556803-5-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com>
References: <20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com>
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

After creating a child process with fork() in CAT test, if there is an
error occurs or a signal such as SIGINT is received, the parent process
will be terminated immediately, and therefor the child process will not
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
 tools/testing/selftests/resctrl/cat_test.c    | 26 +++++----
 tools/testing/selftests/resctrl/fill_buf.c    | 14 -----
 tools/testing/selftests/resctrl/resctrl.h     |  2 +
 tools/testing/selftests/resctrl/resctrl_val.c | 56 ++++++++++++++-----
 4 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 6a8306b0a109..87302b882929 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -103,7 +103,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	unsigned long l_mask, l_mask_1;
 	int ret, pipefd[2], sibling_cpu_no;
 	char pipe_message;
-	pid_t bm_pid;
 
 	cache_size = 0;
 
@@ -181,28 +180,29 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
+	} else {
+		ret = signal_handler_register();
+		if (ret)
+			goto out;
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
@@ -226,5 +226,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	if (bm_pid)
 		umount_resctrlfs();
 
-	return 0;
+out:
+	ret = signal_handler_unregister();
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
index f0ded31fb3c7..14a5e21497e1 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -107,6 +107,8 @@ void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type, char *cbm_mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
+int signal_handler_register(void);
+int signal_handler_unregister(void);
 int cat_val(struct resctrl_val_param *param);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 6948843bf995..91a3cf8b308b 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -476,6 +476,46 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 	exit(EXIT_SUCCESS);
 }
 
+struct sigaction sigact;
+
+/*
+ * Register CTRL-C handler for parent, as it has to kill
+ * child process before exiting
+ */
+int signal_handler_register(void)
+{
+	int ret = 0;
+	struct sigaction sigact;
+
+	sigact.sa_sigaction = ctrlc_handler;
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGTERM, &sigact, NULL) ||
+	    sigaction(SIGHUP, &sigact, NULL)) {
+		perror("# sigaction");
+		ret = errno;
+	}
+	return ret;
+}
+
+/* reset signal handler to SIG_DFL. */
+int signal_handler_unregister(void)
+{
+	int ret = 0;
+	struct sigaction sigact;
+
+	sigact.sa_handler = SIG_DFL;
+	sigemptyset(&sigact.sa_mask);
+	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGTERM, &sigact, NULL) ||
+	    sigaction(SIGHUP, &sigact, NULL)) {
+		perror("# sigaction");
+		ret = errno;
+	}
+	return ret;
+}
+
 /*
  * print_results_bw:	the memory bandwidth results are stored in a file
  * @filename:		file that stores the results
@@ -671,20 +711,9 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
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
 
@@ -764,6 +793,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 out:
 	kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
+	ret = signal_handler_unregister();
 
 	return ret;
 }
-- 
2.27.0

