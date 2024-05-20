Return-Path: <linux-kselftest+bounces-10429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022DF8C9D5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D6F7B22DC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C61C57881;
	Mon, 20 May 2024 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiIMo3j4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A06CDC5;
	Mon, 20 May 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208288; cv=none; b=GDsJOzReDlLdWz+tnCKCk8iwmsZdvAaCXRYuSb8Y2iuM/aRYs2Ap5oEuP//Q7ElPwfqtsrRbXxJljv+/hD0sb2qcT9+emC28mP3g+w9/d/QXqGZJkX2kO+608YW+B1pjijLZMZ8Oco+O9fCsqJy1TaJrXOIBJ9Yfvogb9wiBSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208288; c=relaxed/simple;
	bh=K+i/q8levs1aLzjEe7nsPGEh1RHzB4gA9b8PvFdYk0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBDHul17Ao9NYC0p/3l5rK+Fy1hwMfhpFO3amuPD0i/a0NwWUUnMt04Rs1sa/ZPjE4E1a+FjiWXS5zomz24nr8ZxPOLk999B2ImNY0H0OMakXf9IlIR+1IZv462vg0AlVsqkP//gJOgZuA7cye4fgXrg8vFHhxTVB5CqDR7OzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiIMo3j4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208287; x=1747744287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K+i/q8levs1aLzjEe7nsPGEh1RHzB4gA9b8PvFdYk0s=;
  b=OiIMo3j4k28xsswzqjT44M9Tc04IP+1+q4CiN1UyGceqE7+vuU4OwlYC
   5QFp3apU9r4L+dtQwL4eQ5qpR4VTTRNLMNKD+2vLc2P6dUQ0A2LlZvntT
   o2cvjvG+hEcppfxCMaHjvpbMnCNo3HBdTCTvFMyxz71GZvm2DX8fGWfrV
   gx7xrm6VeL/xrhmUieHZ/I7AykGpcRXAS3yAvpfuRg4YDhmgV6UHra+GE
   GcDXTn4Eb/31zsk/q9FUNl+wRa/VjXo0NvbBNZCNNp8ecC7HOni4KF4qU
   GYB0wzRUD4TERL9yNE+MSQq/kmef2lEE3hOBeL2WlQ7aOFNPxj0v5GapI
   A==;
X-CSE-ConnectionGUID: wSRoIUXuTbW/UhhnmXP1HA==
X-CSE-MsgGUID: fVWtIUjTRxGiVrlUUj/BZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12180387"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12180387"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:31:26 -0700
X-CSE-ConnectionGUID: ZD2gpGpaSPexQkA8/jRn3w==
X-CSE-MsgGUID: ei8Lnr3dRXaMhEhAsya2vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="37474354"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:31:24 -0700
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
Subject: [PATCH v4 06/16] selftests/resctrl: Cleanup bm_pid and ppid usage & limit scope
Date: Mon, 20 May 2024 15:30:10 +0300
Message-Id: <20240520123020.18938-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
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
index 18bfdff78089..198b5133432a 100644
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
 	FILE *mem_bw_fp, *mem_bw_fp2;
@@ -710,7 +717,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	fp = freopen("/dev/null", "w", stdout);
 	if (!fp) {
 		ksft_perror("Unable to direct benchmark status to /dev/null");
-		PARENT_EXIT();
+		parent_exit(ppid);
 	}
 
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
@@ -724,7 +731,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 			once = false;
 		} else {
 			ksft_print_msg("Invalid once parameter\n");
-			PARENT_EXIT();
+			parent_exit(ppid);
 		}
 
 		if (run_fill_buf(span, memflush, operation, once))
@@ -738,7 +745,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 
 	fclose(stdout);
 	ksft_print_msg("Unable to run specified benchmark\n");
-	PARENT_EXIT();
+	parent_exit(ppid);
 }
 
 /*
@@ -817,7 +824,7 @@ int resctrl_val(const struct resctrl_test *test,
 		/* Register for "SIGUSR1" signal from parent */
 		if (sigaction(SIGUSR1, &sigact, NULL)) {
 			ksft_perror("Can't register child for signal");
-			PARENT_EXIT();
+			parent_exit(ppid);
 		}
 
 		/* Tell parent that child is ready */
@@ -835,7 +842,7 @@ int resctrl_val(const struct resctrl_test *test,
 		sigsuspend(&sigact.sa_mask);
 
 		ksft_perror("Child is done");
-		PARENT_EXIT();
+		parent_exit(ppid);
 	}
 
 	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
@@ -905,7 +912,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param);
+			ret = measure_vals(uparams, param, bm_pid);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


