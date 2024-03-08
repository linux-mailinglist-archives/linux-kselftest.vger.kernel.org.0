Return-Path: <linux-kselftest+bounces-6095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D3B876519
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE737283BEF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC736138;
	Fri,  8 Mar 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRnCwe3D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B434381D4;
	Fri,  8 Mar 2024 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904217; cv=none; b=uc9VaBH0kfHVJsXl0Q6uTGKX5uAUa7eVYDF5/bjV/jwlQ4Z2M0A/0XVp5agimSpnY6CpEhIxFEveXNg1EbAe0KGoLPxlBRMlQu+OGMgnMRUQ9HOFIosdk0D4wbA+/JkDqrtyg0lIa/3ndLyHJqQzrdJd375yPEj5PotDK+PbK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904217; c=relaxed/simple;
	bh=sEYLNbkyuSH14euw2egzBjKSQE2lGokAtrCPLRS27NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPTkI1q8Avw7qgthPDHGuT2Ft8xX49XKcXR2Efl7ee1R02S7jxsqbf3aANFaT2xcBZDEnL6vTMdJxQZ1REL3L52tiQDeV0UtAzhnRRgT/AQqcd+jBuIE5lTCvQkPccTt+D2R1gewj3TXppegmSdYwFhabznJogeCye3P0MjX4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRnCwe3D; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904215; x=1741440215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sEYLNbkyuSH14euw2egzBjKSQE2lGokAtrCPLRS27NE=;
  b=JRnCwe3DAOCmvwqussb4Q95bDkPa3Ae+t++1BuDoqmASV2darlNkcMC0
   L8F2If8Vzm3BnXokwo9MdQ3/y2ZqxYnIIuoRtPfmCGNTrGPhd9qgfwxn+
   YoWikDv5Znl9RHvOQmnzT6eB+pjhWCxG7OPrR/ZwQ+flaJjeSd6jjMzDT
   jImONn84gY2WuWNY6t3SOOulcvlQN0TXQ5X4OvfWYETVX3ROgUcS/914Z
   rTScKM9n2HzpAl0VT3c82g/tPM5Le1oeQujAvd0j5DjIZ+4D5bzA5i6wW
   QsV4+pkG+HVCGTs7n8o8Z7V0mlkmzK+1akFAz82XJRkJu6NuJ/oBmgd86
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="7568428"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="7568428"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="47927962"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/13] selftests/resctrl: Calculate resctrl FS derived mem bw over sleep(1) only
Date: Fri,  8 Mar 2024 15:22:44 +0200
Message-Id: <20240308132255.14442-3-ilpo.jarvinen@linux.intel.com>
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


