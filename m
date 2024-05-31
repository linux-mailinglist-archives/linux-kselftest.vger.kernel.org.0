Return-Path: <linux-kselftest+bounces-11006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB688D6292
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E378728951C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E95158D95;
	Fri, 31 May 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3t+yAAD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132A158A36;
	Fri, 31 May 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161171; cv=none; b=CZZ8F2JrL5gGEJVsvoaLomL791ZBrIR8jv8OWivJ2bIxD//W0jPWRe75/oM7QsACdrfYxEJVOvKCPyty+rwT82D2zM2Zg2H7wZE0eiwLWlY1qkexmk2dOtJSZ5lt5Gn8Fsix9+Xktz5NbZd9IzMnlCMTO3auD2NAeJAEuPk1QhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161171; c=relaxed/simple;
	bh=DMdffhGTiQwSZyerm8rW8MvsdOVRuDu43DL1ELq+CAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFZsrrkpqqvPMFhw7ZvcjBeTgxubnwCiC4O3FrYbO/Xo/ZradTKFLDP/N88udUE/NKInobbyAxUx6ouBk8t8LVALojlCcH4kST9qxT8oqoZMhgLlU2wIZ4NzqesN2lfODIEJJc3u36AVWIXncR4ZQ/QsHQ9JnlSrX0OcM6/wpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3t+yAAD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161170; x=1748697170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DMdffhGTiQwSZyerm8rW8MvsdOVRuDu43DL1ELq+CAY=;
  b=b3t+yAAD4dQ3bvetGCveoL+fbvRaMuNe6ziF5WBizl6C51Oem15C9UDa
   RERZbAdomw/KyjPQMCOiLSslZTw3AYbSzui8l6pPlPvFJCIhIQWyHWEPE
   kM9WHWSdqWvQYA7TGuXWC7mNQu1e8h9VA6tnQoyHlY9mFzUqwHmFGoFuT
   VJIbj+Rv2Q//z20UvJ0YP9HQCTeYl/2t0uUxKzFraVfcfaoTYHZQb+Z5f
   OM+Fc+hgkGKM1H4dkzM3AUHoMac4cl67qk3diXZfb9WMSCVmOoNVRj7o5
   bLiZKiGQNFcsuX1kpv/tOBvKc2T7P7OXhyZPfCg32lWa6f1pXz5AniwpT
   A==;
X-CSE-ConnectionGUID: PZXnwNx3R8upOJfGlAsKrw==
X-CSE-MsgGUID: Lvq42SC2RxO9iVNuvZ7/tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17501463"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17501463"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:50 -0700
X-CSE-ConnectionGUID: 1RINMxlxTlSxUwCtjz96ng==
X-CSE-MsgGUID: niXMPy49ROuOyxWfmz+gGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36240502"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 06/16] selftests/resctrl: Cleanup bm_pid and ppid usage & limit scope
Date: Fri, 31 May 2024 16:11:32 +0300
Message-Id: <20240531131142.1716-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
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
index d6f6db77d480..3939a657de4a 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -505,7 +505,7 @@ static int get_mem_bw_resctrl(FILE *fp, unsigned long *mbm_total)
 	return 0;
 }
 
-pid_t bm_pid, ppid;
+static pid_t bm_pid, ppid;
 
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
@@ -563,6 +563,13 @@ void signal_handler_unregister(void)
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
 }
 
 static int measure_vals(const struct user_params *uparams,
-			struct resctrl_val_param *param)
+			struct resctrl_val_param *param, pid_t bm_pid)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	FILE *mem_bw_fp;
@@ -704,7 +711,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	fp = freopen("/dev/null", "w", stdout);
 	if (!fp) {
 		ksft_perror("Unable to direct benchmark status to /dev/null");
-		PARENT_EXIT();
+		parent_exit(ppid);
 	}
 
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
@@ -718,7 +725,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 			once = false;
 		} else {
 			ksft_print_msg("Invalid once parameter\n");
-			PARENT_EXIT();
+			parent_exit(ppid);
 		}
 
 		if (run_fill_buf(span, memflush, operation, once))
@@ -732,7 +739,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 
 	fclose(stdout);
 	ksft_print_msg("Unable to run specified benchmark\n");
-	PARENT_EXIT();
+	parent_exit(ppid);
 }
 
 /*
@@ -811,7 +818,7 @@ int resctrl_val(const struct resctrl_test *test,
 		/* Register for "SIGUSR1" signal from parent */
 		if (sigaction(SIGUSR1, &sigact, NULL)) {
 			ksft_perror("Can't register child for signal");
-			PARENT_EXIT();
+			parent_exit(ppid);
 		}
 
 		/* Tell parent that child is ready */
@@ -829,7 +836,7 @@ int resctrl_val(const struct resctrl_test *test,
 		sigsuspend(&sigact.sa_mask);
 
 		ksft_perror("Child is done");
-		PARENT_EXIT();
+		parent_exit(ppid);
 	}
 
 	ksft_print_msg("Benchmark PID: %d\n", (int)bm_pid);
@@ -899,7 +906,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param);
+			ret = measure_vals(uparams, param, bm_pid);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


