Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9AD7A22CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 17:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjIOPpT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbjIOPo7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 11:44:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A410D9;
        Fri, 15 Sep 2023 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694792692; x=1726328692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p3WKUD0Jn0eiW+5uYqB0b3LYfda6aL3MfFO/89kyeUc=;
  b=ZKlL4qlbhJvAn6o0nBrnBIeA8tlZOXpAKgtg0YkAf24gnvaBsMz+Up67
   KSFjMx5OP4K50jD0c5mbasozz0Hj7A83wdh1sSQ2/eZTeXf5GbyR40IAP
   A+hhbVieG1iuYjKDUI5giM6iBjEDghgDpGmdU5FefTsM4EA8i028ULLav
   OMEsmwGL7AJifJGoJS14Zm9LeSkga4z4Ffkcb7myi1FIJ3eHlH4AUGm1b
   c9pwt97SV3HTLNlvce2SJFDYFHu57IjMc7irCx4VsZJ20b5lFRJDeBpjL
   Yd86IpTA3+A1BPatTIXFFVh0yA9ALCpjZy3VmrkZt4tWLO0HcoQ5fnr2x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410217238"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="410217238"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="991878544"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="991878544"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:44:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/6] selftests/resctrl: Extend signal handler coverage to unmount on receiving signal
Date:   Fri, 15 Sep 2023 18:44:33 +0300
Message-Id: <20230915154438.82931-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unmounting resctrl FS has been moved into the per test functions in
resctrl_tests.c by commit caddc0fbe495 ("selftests/resctrl: Move
resctrl FS mount/umount to higher level"). In case a signal (SIGINT,
SIGTERM, or SIGHUP) is received, the running selftest is aborted by
ctrlc_handler() which then unmounts resctrl fs before exiting. The
current section between signal_handler_register() and
signal_handler_unregister(), however, does not cover the entire
duration when resctrl FS is mounted.

Move signal_handler_register() and signal_handler_unregister() calls
from per test files into resctrl_tests.c to properly unmount resctrl
fs. In order to not add signal_handler_register()/unregister() n times,
create helpers test_prepare() and test_cleanup().

Adjust child process kill() call in ctrlc_handler() to only be invoked
if the child was already forked.

Fixes: caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 tools/testing/selftests/resctrl/cat_test.c    |  8 ---
 .../testing/selftests/resctrl/resctrl_tests.c | 65 +++++++++++--------
 tools/testing/selftests/resctrl/resctrl_val.c | 22 +++----
 3 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 97b87285ab2a..224ba8544d8a 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -167,12 +167,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
-	} else {
-		ret = signal_handler_register();
-		if (ret) {
-			kill(bm_pid, SIGKILL);
-			goto out;
-		}
 	}
 
 	remove(param.filename);
@@ -209,10 +203,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		}
 		close(pipefd[0]);
 		kill(bm_pid, SIGKILL);
-		signal_handler_unregister();
 	}
 
-out:
 	cat_test_cleanup();
 
 	return ret;
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 823672a20a43..524ba83d7568 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -67,21 +67,41 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
+static int test_prepare()
 {
 	int res;
 
-	ksft_print_msg("Starting MBM BW change ...\n");
+	res = signal_handler_register();
+	if (res)
+		return res;
 
 	res = mount_resctrlfs();
 	if (res) {
+		signal_handler_unregister();
 		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
-		return;
+		return res;
 	}
+	return 0;
+}
+
+static void test_cleanup()
+{
+	umount_resctrlfs();
+	signal_handler_unregister();
+}
+
+static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
+{
+	int res;
+
+	ksft_print_msg("Starting MBM BW change ...\n");
+
+	if (test_prepare())
+		return;
 
 	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
-		goto umount;
+		goto cleanup;
 	}
 
 	res = mbm_bw_change(cpu_no, benchmark_cmd);
@@ -89,8 +109,8 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
-umount:
-	umount_resctrlfs();
+cleanup:
+	test_cleanup();
 }
 
 static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
@@ -99,22 +119,19 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 
 	ksft_print_msg("Starting MBA Schemata change ...\n");
 
-	res = mount_resctrlfs();
-	if (res) {
-		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+	if (test_prepare())
 		return;
-	}
 
 	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
-		goto umount;
+		goto cleanup;
 	}
 
 	res = mba_schemata_change(cpu_no, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
-umount:
-	umount_resctrlfs();
+cleanup:
+	test_cleanup();
 }
 
 static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
@@ -123,15 +140,12 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 
 	ksft_print_msg("Starting CMT test ...\n");
 
-	res = mount_resctrlfs();
-	if (res) {
-		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+	if (test_prepare())
 		return;
-	}
 
 	if (!validate_resctrl_feature_request(CMT_STR)) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
-		goto umount;
+		goto cleanup;
 	}
 
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
@@ -139,8 +153,8 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
-umount:
-	umount_resctrlfs();
+cleanup:
+	test_cleanup();
 }
 
 static void run_cat_test(int cpu_no, int no_of_bits)
@@ -149,22 +163,19 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 	ksft_print_msg("Starting CAT test ...\n");
 
-	res = mount_resctrlfs();
-	if (res) {
-		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+	if (test_prepare())
 		return;
-	}
 
 	if (!validate_resctrl_feature_request(CAT_STR)) {
 		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
-		goto umount;
+		goto cleanup;
 	}
 
 	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
 	ksft_test_result(!res, "CAT: test\n");
 
-umount:
-	umount_resctrlfs();
+cleanup:
+	test_cleanup();
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 51963a6f2186..a9fe61133119 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -468,7 +468,9 @@ pid_t bm_pid, ppid;
 
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
-	kill(bm_pid, SIGKILL);
+	/* Only kill child after bm_pid is set after fork() */
+	if (bm_pid)
+		kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
 	tests_cleanup();
 	ksft_print_msg("Ending\n\n");
@@ -485,6 +487,8 @@ int signal_handler_register(void)
 	struct sigaction sigact;
 	int ret = 0;
 
+	bm_pid = 0;
+
 	sigact.sa_sigaction = ctrlc_handler;
 	sigemptyset(&sigact.sa_mask);
 	sigact.sa_flags = SA_SIGINFO;
@@ -706,10 +710,6 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 
 	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
 
-	ret = signal_handler_register();
-	if (ret)
-		goto out;
-
 	/*
 	 * The cast removes constness but nothing mutates benchmark_cmd within
 	 * the context of this process. At the receiving process, it becomes
@@ -721,19 +721,19 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	/* Taskset benchmark to specified cpu */
 	ret = taskset_benchmark(bm_pid, param->cpu_no);
 	if (ret)
-		goto unregister;
+		goto out;
 
 	/* Write benchmark to specified control&monitoring grp in resctrl FS */
 	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
 				      resctrl_val);
 	if (ret)
-		goto unregister;
+		goto out;
 
 	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 		ret = initialize_mem_bw_imc();
 		if (ret)
-			goto unregister;
+			goto out;
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
 					  param->cpu_no, resctrl_val);
@@ -748,7 +748,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 		    sizeof(pipe_message)) {
 			perror("# failed reading message from child process");
 			close(pipefd[0]);
-			goto unregister;
+			goto out;
 		}
 	}
 	close(pipefd[0]);
@@ -757,7 +757,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
 		perror("# sigqueue SIGUSR1 to child");
 		ret = errno;
-		goto unregister;
+		goto out;
 	}
 
 	/* Give benchmark enough time to fully run */
@@ -786,8 +786,6 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 		}
 	}
 
-unregister:
-	signal_handler_unregister();
 out:
 	kill(bm_pid, SIGKILL);
 
-- 
2.30.2

