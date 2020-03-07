Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653C817CBA8
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 04:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCGDqZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 22:46:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:57585 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbgCGDqY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 22:46:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 19:46:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,524,1574150400"; 
   d="scan'208";a="235036052"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2020 19:46:22 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V1 13/13] selftests/resctrl: Cleanup fill_buff after changing CAT test
Date:   Fri,  6 Mar 2020 19:40:54 -0800
Message-Id: <c2a5da486b2e97f284026ffb36f1b49b5702bae8.1583657204.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The previous CAT test reads buffer only once and hence to accomodate this
use case, name of the test case (i.e. cat) was passed as an argument to
"fill_buff". Ideally, "fill_buff" doesn't need to know which test invoked
it, hence, cleanup "fill_buff" and code that was carrying around this extra
argument.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c      |  6 +----
 tools/testing/selftests/resctrl/fill_buf.c      | 29 ++++++++++---------------
 tools/testing/selftests/resctrl/resctrl.h       |  4 ++--
 tools/testing/selftests/resctrl/resctrl_tests.c | 11 +++-------
 tools/testing/selftests/resctrl/resctrlfs.c     |  4 +---
 5 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index d1c50430ab20..b25c8f43d29c 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -169,11 +169,7 @@ static int start_noisy_process(pid_t pid, int sibling_cpu_no)
 	if (ret)
 		return ret;
 
-	/*
-	 * Passing 'cat' will not loop around buffer forever, hence don't pass
-	 * test name
-	 */
-	ret = run_fill_buf(buf_size, 1, 1, 0, "");
+	ret = run_fill_buf(buf_size, 1, 1, 0);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 0500dab90b2e..486e6b4c9924 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -107,16 +107,13 @@ static void fill_one_span_write(void)
 	}
 }
 
-static int fill_cache_read(char *resctrl_val)
+static int fill_cache_read(void)
 {
 	int ret = 0;
 	FILE *fp;
 
-	while (1) {
+	while (1)
 		ret = fill_one_span_read();
-		if (!strcmp(resctrl_val, "cat"))
-			break;
-	}
 
 	/* Consume read result so that reading memory is not optimized out. */
 	fp = fopen("/dev/null", "w");
@@ -128,13 +125,10 @@ static int fill_cache_read(char *resctrl_val)
 	return 0;
 }
 
-static int fill_cache_write(char *resctrl_val)
+static int fill_cache_write(void)
 {
-	while (1) {
+	while (1)
 		fill_one_span_write();
-		if (!strcmp(resctrl_val, "cat"))
-			break;
-	}
 
 	return 0;
 }
@@ -202,14 +196,14 @@ int use_buffer_once(int op)
 	return 0;
 }
 
-int use_buffer_forever(int op, char *resctrl_val)
+int use_buffer_forever(int op)
 {
 	int ret;
 
 	if (op == 0)
-		ret = fill_cache_read(resctrl_val);
+		ret = fill_cache_read();
 	else
-		ret = fill_cache_write(resctrl_val);
+		ret = fill_cache_write();
 
 	if (ret) {
 		printf("\n Error in fill cache read/write...\n");
@@ -221,7 +215,7 @@ int use_buffer_forever(int op, char *resctrl_val)
 
 static int
 fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
-	   int op, char *resctrl_val)
+	   int op)
 {
 	int ret;
 
@@ -229,7 +223,7 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
 	if (ret)
 		return ret;
 
-	ret = use_buffer_forever(op, resctrl_val);
+	ret = use_buffer_forever(op);
 	if (ret)
 		return ret;
 
@@ -239,7 +233,7 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
 }
 
 int run_fill_buf(unsigned long span, int malloc_and_init_memory,
-		 int memflush, int op, char *resctrl_val)
+		 int memflush, int op)
 {
 	unsigned long long cache_size = span;
 	int ret;
@@ -250,8 +244,7 @@ int run_fill_buf(unsigned long span, int malloc_and_init_memory,
 	if (signal(SIGHUP, ctrl_handler) == SIG_ERR)
 		printf("Failed to catch SIGHUP!\n");
 
-	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
-			 resctrl_val);
+	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op);
 	if (ret) {
 		printf("\n Error in fill cache\n");
 		return -1;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 393f2f34ccac..18e27e3f71ae 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -86,9 +86,9 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int init_buffer(unsigned long long buf_size, int malloc_and_init, int memflush);
 int use_buffer_once(int op);
-int use_buffer_forever(int op, char *resctrl_val);
+int use_buffer_forever(int op);
 int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
-		 int op, char *resctrl_va);
+		 int op);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd);
 void tests_cleanup(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 4461c3dc8cce..503c68f2570f 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -141,7 +141,7 @@ int main(int argc, char **argv)
 		benchmark_cmd[ben_count] = NULL;
 	} else {
 		/* If no benchmark is given by "-b" argument, use fill_buf. */
-		for (i = 0; i < 6; i++)
+		for (i = 0; i < 5; i++)
 			benchmark_cmd[i] = benchmark_cmd_area[i];
 
 		strcpy(benchmark_cmd[0], "fill_buf");
@@ -149,8 +149,7 @@ int main(int argc, char **argv)
 		strcpy(benchmark_cmd[2], "1");
 		strcpy(benchmark_cmd[3], "1");
 		strcpy(benchmark_cmd[4], "0");
-		strcpy(benchmark_cmd[5], "");
-		benchmark_cmd[6] = NULL;
+		benchmark_cmd[5] = NULL;
 	}
 
 	sprintf(bw_report, "reads");
@@ -161,8 +160,6 @@ int main(int argc, char **argv)
 
 	if (!is_amd && mbm_test) {
 		printf("# Starting MBM BW change ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", "mba");
 		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 		printf("%sok MBM: bw change\n", res ? "not " : "");
 		mbm_test_cleanup();
@@ -181,10 +178,8 @@ int main(int argc, char **argv)
 
 	if (cqm_test) {
 		printf("# Starting CQM test ...\n");
-		if (!has_ben) {
+		if (!has_ben)
 			sprintf(benchmark_cmd[1], "%d", span);
-			sprintf(benchmark_cmd[5], "%s", "cqm");
-		}
 		res = cqm_schemata_change(cpu_no, span, "L3", benchmark_cmd);
 		printf("%sok CQM: test\n", res ? "not " : "");
 		cqm_test_cleanup();
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index bd81a13ff9df..dcc9e70cbf30 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -345,7 +345,6 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	int operation, ret, malloc_and_init_memory, memflush;
 	unsigned long span, buffer_span;
 	char **benchmark_cmd;
-	char resctrl_val[64];
 	FILE *fp;
 
 	benchmark_cmd = info->si_ptr;
@@ -364,11 +363,10 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		malloc_and_init_memory = atoi(benchmark_cmd[2]);
 		memflush =  atoi(benchmark_cmd[3]);
 		operation = atoi(benchmark_cmd[4]);
-		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
 		buffer_span = span * MB;
 
 		if (run_fill_buf(buffer_span, malloc_and_init_memory, memflush,
-				 operation, resctrl_val))
+				 operation))
 			fprintf(stderr, "Error in running fill buffer\n");
 	} else {
 		/* Execute specified benchmark */
-- 
2.7.4

