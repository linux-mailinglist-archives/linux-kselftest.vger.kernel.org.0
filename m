Return-Path: <linux-kselftest+bounces-11563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE50902541
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C811C231C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F271422CE;
	Mon, 10 Jun 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6H85iAC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DC140E30;
	Mon, 10 Jun 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032564; cv=none; b=CL0nmYjpmpyqwF6OJlYbJwVyQ/b0Mu/zjrQQoh90tIPIGRD59WfuNlddMy3EptfixEGBvwq4zxMFk0APAdHAiAJWmPoe/bbDHLohLeTXqvlukgUbB4/hKONfeUS9FVos5sy60hcok8UiyBNQLlDFjQm6fbNenedzxryE2IBjKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032564; c=relaxed/simple;
	bh=cfxO8qFC0DNK4cOE0EMUug/EGzpL5kwVpjyX2BnUbGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qc2D4hUHoktXFcGEiI3Vy1h5VteQgcpV4pUEehs0+EghvSAq5uFM5YJYDG7GWsKjsdHyYqIBfIsqfHQSvrCk5NNnazqCe7JI8EF5Bg56Tu2kJvNemFCmWbFifcZGEOwPyIDk2q5J54DB2wXFuaqex7abPFlN6eTpmhFlvA4uV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6H85iAC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718032563; x=1749568563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cfxO8qFC0DNK4cOE0EMUug/EGzpL5kwVpjyX2BnUbGM=;
  b=U6H85iACDNr6gHTswGcE4Inz1DgeolEqMSMQln6f0sFbZvK3ZpwR/5K0
   miOzVZxTH2NIc0Zkvq0bqqKBRM8d0kIsPiagmKhueIgCjJP1e87XFuvMV
   22VbNOR0V2d01aiNdfoYpt0DOE53Za8CQPnuC+bn+Q7EwrPYRJZ5L89do
   NN4R10ZttT90wSJe8huXht7lySdchgav79Rk8sMh1L1jKuw+xYRs3GoLY
   OJDp4fRT2eyBoz0goWAwENC57zk0b0FmsGFzNoi6wVtQj7VCTNLiCcjjP
   VN00VOh2NGAMrc1Imqe6x5qvifAJSk/DmM5UUGDKwVxILfZXa2Hg6uNIp
   w==;
X-CSE-ConnectionGUID: joQB8FEIRnW1SFvaWuhung==
X-CSE-MsgGUID: BLeb8gXRSFO3/cYrztrXtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18530851"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18530851"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:16:02 -0700
X-CSE-ConnectionGUID: SFXXgnS9SNy9ku9UUbEDeg==
X-CSE-MsgGUID: adaT/t0dQq+Ycb0yfPWtCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39650748"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:15:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 06/16] selftests/resctrl: Cleanup bm_pid and ppid usage & limit scope
Date: Mon, 10 Jun 2024 18:14:47 +0300
Message-Id: <20240610151457.7305-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'bm_pid' and 'ppid' are global variables. As they are used by different
processes and in signal handler, they cannot be entirely converted into
local variables.

The scope of those variables can still be reduced into resctrl_val.c
only. As PARENT_EXIT() macro is using 'ppid', make it a function in
resctrl_val.c and pass ppid to it as an argument because it is easier
to understand than using the global variable directly.

Pass 'bm_pid' into measure_vals() instead of relying on the global
variable which helps to make the call signatures of measure_vals() and
measure_llc_resctrl() more similar to each other.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  9 --------
 tools/testing/selftests/resctrl/resctrl_val.c | 23 ++++++++++++-------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index e6f221236c79..e4b6dc672ecc 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -43,13 +43,6 @@
 
 #define DEFAULT_SPAN		(250 * MB)
 
-#define PARENT_EXIT()				\
-	do {					\
-		kill(ppid, SIGKILL);		\
-		umount_resctrlfs();		\
-		exit(EXIT_FAILURE);		\
-	} while (0)
-
 /*
  * user_params:		User supplied parameters
  * @cpu:		CPU number to which the benchmark will be bound to
@@ -127,8 +120,6 @@ struct perf_event_read {
  */
 extern volatile int *value_sink;
 
-extern pid_t bm_pid, ppid;
-
 extern char llc_occup_path[1024];
 
 int get_vendor(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 5704fa3ba202..3cf671cbb7a2 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -499,7 +499,7 @@ static int get_mem_bw_resctrl(FILE *fp, unsigned long *mbm_total)
 	return 0;
 }
 
-pid_t bm_pid, ppid;
+static pid_t bm_pid, ppid;
 
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
@@ -557,6 +557,13 @@ void signal_handler_unregister(void)
 	}
 }
 
+static void parent_exit(pid_t ppid)
+{
+	kill(ppid, SIGKILL);
+	umount_resctrlfs();
+	exit(EXIT_FAILURE);
+}
+
 /*
  * print_results_bw:	the memory bandwidth results are stored in a file
  * @filename:		file that stores the results
@@ -631,7 +638,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
  * 1 sec to measure the data.
  */
 static int measure_vals(const struct user_params *uparams,
-			struct resctrl_val_param *param)
+			struct resctrl_val_param *param, pid_t bm_pid)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	FILE *mem_bw_fp;
@@ -700,7 +707,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	fp = freopen("/dev/null", "w", stdout);
 	if (!fp) {
 		ksft_perror("Unable to direct benchmark status to /dev/null");
-		PARENT_EXIT();
+		parent_exit(ppid);
 	}
 
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
@@ -714,7 +721,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 			once = false;
 		} else {
 			ksft_print_msg("Invalid once parameter\n");
-			PARENT_EXIT();
+			parent_exit(ppid);
 		}
 
 		if (run_fill_buf(span, memflush, operation, once))
@@ -728,7 +735,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 
 	fclose(stdout);
 	ksft_print_msg("Unable to run specified benchmark\n");
-	PARENT_EXIT();
+	parent_exit(ppid);
 }
 
 /*
@@ -807,7 +814,7 @@ int resctrl_val(const struct resctrl_test *test,
 		/* Register for "SIGUSR1" signal from parent */
 		if (sigaction(SIGUSR1, &sigact, NULL)) {
 			ksft_perror("Can't register child for signal");
-			PARENT_EXIT();
+			parent_exit(ppid);
 		}
 
 		/* Tell parent that child is ready */
@@ -825,7 +832,7 @@ int resctrl_val(const struct resctrl_test *test,
 		sigsuspend(&sigact.sa_mask);
 
 		ksft_perror("Child is done");
-		PARENT_EXIT();
+		parent_exit(ppid);
 	}
 
 	ksft_print_msg("Benchmark PID: %d\n", (int)bm_pid);
@@ -895,7 +902,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param);
+			ret = measure_vals(uparams, param, bm_pid);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


