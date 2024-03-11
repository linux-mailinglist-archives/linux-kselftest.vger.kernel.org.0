Return-Path: <linux-kselftest+bounces-6193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21198780FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B89286559
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493FA3E491;
	Mon, 11 Mar 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqJ6IbQA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F43FE20;
	Mon, 11 Mar 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165220; cv=none; b=l832mPrVtubJHHdj2Ii3X799JaEisfj6z6HwaFt0/HCoMA9X8iVla9aUIZXb4657FMpHWwViJpxXA76xHbvJ6WfBPIZ3YWZyczUUhDU5kG6wUm/X0CGwqJQI39WFATCIIFocdF757Q5UwA/dXIFMaGC7QMi+xR1M7tpkjZjc/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165220; c=relaxed/simple;
	bh=GDC8Tjn6yltKW0gL0SkQ6vqVXaf83nlicg0ZTvVVWG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzwef1S9yPgncuGmMQvUm695OpxIxutTT/kgRHRDVAtx1KeytGCvPLa9VCBfdT9OuGD03WXAVbJDn8s5gypcbnXX04a8Mo9/AE1ikrB3+ikFPNNyy4aYnZpAl3Q21XowX6lrW0vvjWLQCF0KWH9zbT1rlFlsKiVnx/mkjoYNb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqJ6IbQA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165217; x=1741701217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GDC8Tjn6yltKW0gL0SkQ6vqVXaf83nlicg0ZTvVVWG4=;
  b=bqJ6IbQAgYUnbCvjLkMd58MPp6Vk29Sfa8mWLVjlP0lAemCyNa1vSdb/
   4Eh/ERWvNsdOeVnYVG67x5yxGrjr3HkwXRpo9JCXpGilv5PCvQlCszZEd
   vyZtNpEm3ojGouI5l/C/WTPD++38RzVK6nfZvy1RQvMN5db1Mpm3XT5Hn
   N3x99K3GdbPzmvDDh6d5dklDcSfL2VyJlMn6/ZBz+ijaC/nWQXNKXEcd7
   +i3uBuzicngJsHxYW15xS64FVAYpJtR3Q5d339wzjR3MdIq9zw5qCbf8K
   J6pbSj4563covU0EbRMG3hN2CN3r+x2IQwIcwcI4DYvSssep3x4SVup7f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4705211"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4705211"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:53:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11247730"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:53:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 05/13] selftests/resctrl: Cleanup bm_pid and ppid usage & limit scope
Date: Mon, 11 Mar 2024 15:52:22 +0200
Message-Id: <20240311135230.7007-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
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
index f810a3c5692c..90fc00a61d72 100644
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
@@ -125,8 +118,6 @@ struct perf_event_read {
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


