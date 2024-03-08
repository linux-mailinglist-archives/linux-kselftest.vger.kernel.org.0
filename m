Return-Path: <linux-kselftest+bounces-6098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E1D87651F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CC81C21FD0
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615B225CE;
	Fri,  8 Mar 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WATEAsvW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE43FBA3;
	Fri,  8 Mar 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904245; cv=none; b=t+3PY6+fPlxxXviZLj5aV8rMmPU3krf48bcq9iYmrOEKCUym9TK66EOKAbkKnLRijR+8kmIbb6K/16blZ3PSOy6Svtmh3M2H91kX13RZDUZrdky7DP7/4qo8eHDITrSUmpg7XoowW8ogat3YZkZIaEyVRmC89DcMT975TsPBuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904245; c=relaxed/simple;
	bh=tj/MiMOB4nEuPTTvSBtSR+rayPJOewTgzoDjPET3oR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlvmnZmSwBpRpP4fppFTYizrk+Cgnn9Vbam3nVGKfni88MVtYGLBZ4X4MavrgA9uYNTo8YcfHYGyFrkL/dQ4y1ofu3BsPh3mT18eoSb574mJyp0MRl7lH9ec/wPGTVqiiBoiqPX/KrOBmw3puIZHCi/C3dnk+HuHUl6WH8oSz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WATEAsvW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904243; x=1741440243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tj/MiMOB4nEuPTTvSBtSR+rayPJOewTgzoDjPET3oR0=;
  b=WATEAsvWTmVauoYknhOksgSgkWe5lN80jOVj3KaC8bD7wG5O8lK3E9HU
   /4Zt/DrmXcOGZnhRBOryvyfDGF4lq4tCf8HeZsJ8DbAhysY7J/de+bTW9
   NasPDPYkroSiTSCtKLcEKobioM1tcGvKjWxb85X1NFOne7qPzw7648jGo
   ouMzMsAvqnSAYkuyZZxRB/7uLYhIZ4+1YvnwjxdBcbWyG8CajHtNBMTjU
   wE+KHqpKrgX/f+h9cGYH/xjDUfqwH5/5BLTDnkPWmrGx3OKY4eKapjkkX
   S63qPzLPLTqHKDsLYkOaJetoyzuDnuTz8VA2ZRetjC3yxU+Mf+QlAr1XY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4801443"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4801443"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:24:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10505955"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/13] selftests/resctrl: Cleanup bm_pid and ppid usage & limit scope
Date: Fri,  8 Mar 2024 15:22:47 +0200
Message-Id: <20240308132255.14442-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
References: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
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

Pass 'bm_pid' into measure_val() instead of relying on the global
variable which helps to make the call signatures of measure_val() and
measure_llc_resctrl() more similar to each other.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  9 --------
 tools/testing/selftests/resctrl/resctrl_val.c | 23 ++++++++++++-------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 84d18d66dab2..cf98c03887c9 100644
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
@@ -122,8 +115,6 @@ struct perf_event_read {
  */
 extern volatile int *value_sink;
 
-extern pid_t bm_pid, ppid;
-
 extern char llc_occup_path[1024];
 
 int get_vendor(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 07fd57d8d125..04a8577b5e0a 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -481,7 +481,7 @@ static int get_mem_bw_resctrl(unsigned long *mbm_total)
 	return 0;
 }
 
-pid_t bm_pid, ppid;
+static pid_t bm_pid, ppid;
 
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
@@ -536,6 +536,13 @@ void signal_handler_unregister(void)
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
@@ -604,7 +611,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 }
 
 static int measure_vals(const struct user_params *uparams,
-			struct resctrl_val_param *param)
+			struct resctrl_val_param *param, pid_t bm_pid)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	float bw_imc;
@@ -664,7 +671,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	fp = freopen("/dev/null", "w", stdout);
 	if (!fp) {
 		ksft_perror("Unable to direct benchmark status to /dev/null");
-		PARENT_EXIT();
+		parent_exit(ppid);
 	}
 
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
@@ -678,7 +685,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 			once = false;
 		} else {
 			ksft_print_msg("Invalid once parameter\n");
-			PARENT_EXIT();
+			parent_exit(ppid);
 		}
 
 		if (run_fill_buf(span, memflush, operation, once))
@@ -692,7 +699,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 
 	fclose(stdout);
 	ksft_print_msg("Unable to run specified benchmark\n");
-	PARENT_EXIT();
+	parent_exit(ppid);
 }
 
 /*
@@ -771,7 +778,7 @@ int resctrl_val(const struct resctrl_test *test,
 		/* Register for "SIGUSR1" signal from parent */
 		if (sigaction(SIGUSR1, &sigact, NULL)) {
 			ksft_perror("Can't register child for signal");
-			PARENT_EXIT();
+			parent_exit(ppid);
 		}
 
 		/* Tell parent that child is ready */
@@ -789,7 +796,7 @@ int resctrl_val(const struct resctrl_test *test,
 		sigsuspend(&sigact.sa_mask);
 
 		ksft_perror("Child is done");
-		PARENT_EXIT();
+		parent_exit(ppid);
 	}
 
 	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
@@ -859,7 +866,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param);
+			ret = measure_vals(uparams, param, bm_pid);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


