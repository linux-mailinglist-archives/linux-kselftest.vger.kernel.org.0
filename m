Return-Path: <linux-kselftest+bounces-7412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A176A89C993
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D57E1F25AC6
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982021428E4;
	Mon,  8 Apr 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDBzlhYE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4661428E2;
	Mon,  8 Apr 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593997; cv=none; b=LFqmCHGaTvwaDNlkmI8NCzvPXIdyUBkSXuXUOwoueUIvAmoi2hAVt6l2D+0NvW00x1ZFkNbgDInDQGH6g25sEB4dryWSWwJMk4fJco9RDJkGIjj//Ml0eu5pjwHHxgCbdS7u006Zo2WrDKl+65kqMGBejf1osyZEQoPHdYXCRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593997; c=relaxed/simple;
	bh=MR/3kQosYswddmPsSqRKHNFA2bPIav4MO/96clktDoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZtqjogBGBtmY7KvIplNjDq5pUJUgsJ8ak3udwM9Arjny+Y8wno4GweNL3LrVPKqXxQCQiA6asCHLcLOxdhfULosh1nrdKsiGOF9yXO8W8lDnRhbNrHgbUm6Y8vif8lpbEFZTrV5WLZqH2zmQtnIqA2CYJ+DQFC/zojMwMRlvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDBzlhYE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712593995; x=1744129995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MR/3kQosYswddmPsSqRKHNFA2bPIav4MO/96clktDoI=;
  b=KDBzlhYEdzgRHIyDWj+WOeZeILThItbnezG0tjBE4tMAIxuBZKUCUc4H
   r3bghwTR8FcI0+xguc4+r2uk5l0giXzFGcMKWsYyjAeTsvK9fK/jSYj9s
   Bi8g/Ox5L7KWNrCJ0wWEmYFaWyskwe1c5JX+KXGHq9hfJo5gSERQdAQg/
   Nufxteljo9ZadSPHoiic66jfIR5EJ8jjosZPS5BIBteeiFnR0N0nTibl5
   R/TWEA6nKOq4IFFEV/6aC3h6QsyGK3UUs0hnen3nrbP3+WZNhBqYhLbQm
   U69Ih0eCI7/zLjYVi+U3MfcJmbbQEP21ebGKTHIE2qbfYN67JOJuiOub3
   w==;
X-CSE-ConnectionGUID: yROIcwhbQ4yIIkLXp0F6aA==
X-CSE-MsgGUID: mNQa3MasS9uBljCrpdvhpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8106732"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8106732"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:33:15 -0700
X-CSE-ConnectionGUID: j3YKSgO7RKGqHLT6pFiKog==
X-CSE-MsgGUID: 4gM1l4wTRp+VWiFQptweOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="50935071"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:33:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 02/16] selftests/resctrl: Calculate resctrl FS derived mem bw over sleep(1) only
Date: Mon,  8 Apr 2024 19:32:33 +0300
Message-Id: <20240408163247.3224-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
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

v3:
- Don't drop Return: entry from perf_open_imc_mem_bw() func comment
---
 tools/testing/selftests/resctrl/resctrl_val.c | 71 +++++++++++++------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 456cf0d0b8ca..ca4da7f4cf25 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -294,22 +294,15 @@ static int initialize_mem_bw_imc(void)
 }
 
 /*
- * get_mem_bw_imc:	Memory band width as reported by iMC counters
- * @cpu_no:		CPU number that the benchmark PID is binded to
- * @bw_report:		Bandwidth report type (reads, writes)
- *
- * Memory B/W utilized by a process on a socket can be calculated using
- * iMC counters. Perf events are used to read these counters.
+ * perf_open_imc_mem_bw - Open perf fds for IMCs
+ * @cpu_no: CPU number that the benchmark PID is binded to
  *
  * Return: = 0 on success. < 0 on failure.
  */
-static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
+static int perf_open_imc_mem_bw(int cpu_no)
 {
-	float reads, writes, of_mul_read, of_mul_write;
 	int imc, ret;
 
-	/* Start all iMC counters to log values (both read and write) */
-	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
 	for (imc = 0; imc < imcs; imc++) {
 		ret = open_perf_event(imc, cpu_no, READ);
 		if (ret)
@@ -317,7 +310,22 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 		ret = open_perf_event(imc, cpu_no, WRITE);
 		if (ret)
 			return -1;
+	}
+
+	return 0;
+}
 
+/*
+ * do_mem_bw_test - Perform memory bandwidth test
+ *
+ * Runs memory bandwidth test over one second period. Also, handles starting
+ * and stopping of the IMC perf counters around the test.
+ */
+static void do_imc_mem_bw_test(void)
+{
+	int imc;
+
+	for (imc = 0; imc < imcs; imc++) {
 		membw_ioctl_perf_event_ioc_reset_enable(imc, READ);
 		membw_ioctl_perf_event_ioc_reset_enable(imc, WRITE);
 	}
@@ -329,6 +337,24 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 		membw_ioctl_perf_event_ioc_disable(imc, READ);
 		membw_ioctl_perf_event_ioc_disable(imc, WRITE);
 	}
+}
+
+/*
+ * get_mem_bw_imc - Memory band width as reported by iMC counters
+ * @bw_report: Bandwidth report type (reads, writes)
+ *
+ * Memory B/W utilized by a process on a socket can be calculated using
+ * iMC counters. Perf events are used to read these counters.
+ *
+ * Return: = 0 on success. < 0 on failure.
+ */
+static int get_mem_bw_imc(char *bw_report, float *bw_imc)
+{
+	float reads, writes, of_mul_read, of_mul_write;
+	int imc;
+
+	/* Start all iMC counters to log values (both read and write) */
+	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
 
 	/*
 	 * Get results which are stored in struct type imc_counter_config
@@ -600,10 +626,9 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
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
 
@@ -614,22 +639,27 @@ static int measure_vals(const struct user_params *uparams,
 	 * Compare the two values to validate resctrl value.
 	 * It takes 1sec to measure the data.
 	 */
-	ret = get_mem_bw_imc(uparams->cpu, param->bw_report, &bw_imc);
+	ret = perf_open_imc_mem_bw(uparams->cpu);
+	if (ret < 0)
+		return ret;
+
+	ret = get_mem_bw_resctrl(&bw_resc_start);
 	if (ret < 0)
 		return ret;
 
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
@@ -703,7 +733,6 @@ int resctrl_val(const struct resctrl_test *test,
 		struct resctrl_val_param *param)
 {
 	char *resctrl_val = param->resctrl_val;
-	unsigned long bw_resc_start = 0;
 	struct sigaction sigact;
 	int ret = 0, pipefd[2];
 	char pipe_message = 0;
@@ -845,7 +874,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param, &bw_resc_start);
+			ret = measure_vals(uparams, param);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


