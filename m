Return-Path: <linux-kselftest+bounces-6190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22428780F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113C21C222BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFD93EA76;
	Mon, 11 Mar 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwrkinLT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE43EA62;
	Mon, 11 Mar 2024 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165199; cv=none; b=kwvqyepaLYtN6+riPHayxM6lolTkT4TQhR0oaySBm7jA3MOKD5XQk5DKUB/j5vXqA0NmtKbgLDKKOlu/A/tzk+fhoozGB3WAWQQbqdHyuYAC5Ft9mVQOdBC84EXtRYoJGhBMQuQTADJur4cYa0B4hxYhV7yKzyyhHl6KN5bwajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165199; c=relaxed/simple;
	bh=sEYLNbkyuSH14euw2egzBjKSQE2lGokAtrCPLRS27NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCnGS4HcIboO51xC75TEbpIFn1nlBXN2E76EY2aEcd53r73QMVab95cQHkH0FRi0p5Y92Db4KiNk7BSOBNr4RGfZ/DfyV4TnK/VP3jzSRosG5fWGmW5CgsXpIOK7GwBInfep6+Rv9jzC1SBT0s6E8CvI0IrmNiKT1HQq0bQM5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwrkinLT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165198; x=1741701198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sEYLNbkyuSH14euw2egzBjKSQE2lGokAtrCPLRS27NE=;
  b=QwrkinLTqfaBXsTVSFuwoCdakv0qqwadm9gmwSHZqcv4bP0lr3lxLABx
   5ogzVgB2TiW/7mm5D+dziMZs1wjFGRrgUWXSBaPCoHsYUb5uM5Dslt9N3
   jVD4OlucBlDj3pY+4tzjUQfQgy3Ph1q4JfzGae8WP5+GjL53/o4Dwn6Tx
   k6jCgJp+lfcWddxlRv+LgTxJV3HZLO4xT2ZprYxy6OYsanTKbGxpDfvBx
   lW214aMkJPTpX3C8WtAGeVygTPIP+HX7l53lrFSgxGBIcSwUGxDgmhY/6
   a+rhgvL0fStMdhyqOiNKq/8nSH10u3hVOWpOBLIefR3UCKz1AHnN9Jz5n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15966201"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15966201"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11614484"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:53:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 02/13] selftests/resctrl: Calculate resctrl FS derived mem bw over sleep(1) only
Date: Mon, 11 Mar 2024 15:52:19 +0200
Message-Id: <20240311135230.7007-3-ilpo.jarvinen@linux.intel.com>
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

For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
the measurement over a duration of sleep(1) call. The memory bandwidth
numbers from IMC are derived over this duration. The resctrl FS derived
memory bandwidth, however, is calculated inside measure_vals() and only
takes delta between the previous value and the current one which
besides the actual test, also samples inter-test noise.

Rework the logic in measure_vals() and get_mem_bw_imc() such that the
resctrl FS memory bandwidth section covers much shorter duration
closely matching that of the IMC perf counters to improve measurement
accuracy.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 72 +++++++++++++------
 1 file changed, 50 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 36139cba7be8..4df2cd738f88 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -293,28 +293,35 @@ static int initialize_mem_bw_imc(void)
 }
 
 /*
- * get_mem_bw_imc:	Memory band width as reported by iMC counters
+ * perf_open_imc_mem_bw - Open perf fds for IMCs
  * @cpu_no:		CPU number that the benchmark PID is binded to
- * @bw_report:		Bandwidth report type (reads, writes)
- *
- * Memory B/W utilized by a process on a socket can be calculated using
- * iMC counters. Perf events are used to read these counters.
- *
- * Return: = 0 on success. < 0 on failure.
  */
-static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
+static int perf_open_imc_mem_bw(int cpu_no)
 {
-	float reads, writes, of_mul_read, of_mul_write;
 	int imc, j, ret;
 
-	/* Start all iMC counters to log values (both read and write) */
-	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
 	for (imc = 0; imc < imcs; imc++) {
 		for (j = 0; j < 2; j++) {
 			ret = open_perf_event(imc, cpu_no, j);
 			if (ret)
 				return -1;
 		}
+	}
+
+	return 0;
+}
+
+/*
+ * do_mem_bw_test - Perform memory bandwidth test
+ *
+ * Runs memory bandwidth test over one second period. Also, handles starting
+ * and stopping of the IMC perf counters around the test.
+ */
+static void do_imc_mem_bw_test(void)
+{
+	int imc, j;
+
+	for (imc = 0; imc < imcs; imc++) {
 		for (j = 0; j < 2; j++)
 			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
 	}
@@ -326,6 +333,24 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 		for (j = 0; j < 2; j++)
 			membw_ioctl_perf_event_ioc_disable(imc, j);
 	}
+}
+
+/*
+ * get_mem_bw_imc - Memory band width as reported by iMC counters
+ * @bw_report:		Bandwidth report type (reads, writes)
+ *
+ * Memory B/W utilized by a process on a socket can be calculated using
+ * iMC counters. Perf events are used to read these counters.
+ *
+ * Return: = 0 on success. < 0 on failure.
+ */
+static int get_mem_bw_imc(char *bw_report, float *bw_imc)
+{
+	float reads, writes, of_mul_read, of_mul_write;
+	int imc, j;
+
+	/* Start all iMC counters to log values (both read and write) */
+	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
 
 	/*
 	 * Get results which are stored in struct type imc_counter_config
@@ -593,10 +618,9 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 }
 
 static int measure_vals(const struct user_params *uparams,
-			struct resctrl_val_param *param,
-			unsigned long *bw_resc_start)
+			struct resctrl_val_param *param)
 {
-	unsigned long bw_resc, bw_resc_end;
+	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	float bw_imc;
 	int ret;
 
@@ -607,22 +631,27 @@ static int measure_vals(const struct user_params *uparams,
 	 * Compare the two values to validate resctrl value.
 	 * It takes 1sec to measure the data.
 	 */
-	ret = get_mem_bw_imc(uparams->cpu, param->bw_report, &bw_imc);
+	ret = perf_open_imc_mem_bw(uparams->cpu);
 	if (ret < 0)
 		return ret;
 
+	ret = get_mem_bw_resctrl(&bw_resc_start);
+	if (ret < 0)
+		return ret;
+
+	do_imc_mem_bw_test();
+
 	ret = get_mem_bw_resctrl(&bw_resc_end);
 	if (ret < 0)
 		return ret;
 
-	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
-	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
-	if (ret)
+	ret = get_mem_bw_imc(param->bw_report, &bw_imc);
+	if (ret < 0)
 		return ret;
 
-	*bw_resc_start = bw_resc_end;
+	bw_resc = (bw_resc_end - bw_resc_start) / MB;
 
-	return 0;
+	return print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
 }
 
 /*
@@ -696,7 +725,6 @@ int resctrl_val(const struct resctrl_test *test,
 		struct resctrl_val_param *param)
 {
 	char *resctrl_val = param->resctrl_val;
-	unsigned long bw_resc_start = 0;
 	struct sigaction sigact;
 	int ret = 0, pipefd[2];
 	char pipe_message = 0;
@@ -838,7 +866,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param, &bw_resc_start);
+			ret = measure_vals(uparams, param);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


