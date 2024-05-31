Return-Path: <linux-kselftest+bounces-11002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F18D6288
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736C41C24FF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65A158DBE;
	Fri, 31 May 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+xoC+II"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C5158A02;
	Fri, 31 May 2024 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161136; cv=none; b=RznejMrbpCl+WqcJwgVJUSyzPuVwzs9n6wTUEyKwoVshf64Zv7Yndi2dkOL5eSyY3SFIEQbKtYHtRRvqWhGJX7nGsR1QgHMBCkR0Y4oXRy4E3rS5r0DxeSmnNfFsBbsXFK0ALywKygddgkeqznNjaU64aZN/ClUNYS/CdObSpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161136; c=relaxed/simple;
	bh=tDMh6O8uH2YekPBaczBE+uRT5cFr46yLEjSSvjkzaXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kbp/4Eh/qvGeiCdl1KWF2l4XfKgxPCFNOwGIDfqVQeyRnokk5ApJ/B81Cb6TOoaJR/UIh01rWVRWiUysjBrlbhEdhWIUNIgHbOF8wR1mgftywkOZyUniyW+7f7sZ9X+IR7ZqIs/eNFlvhCuDW+858SBJybbz/UfL6aqUjzdq5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+xoC+II; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161135; x=1748697135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDMh6O8uH2YekPBaczBE+uRT5cFr46yLEjSSvjkzaXw=;
  b=F+xoC+IIw1z3v5j3HE5ROfBnzBJxwu7roTnyODclxYRztq6kcphl9yHD
   taXZ2GJVgRFZdc1dr4xHMq6ucuPaEJNJZyGkOwbIcnMSnzif+06feKtO8
   4WqaeMH9NHMge8OSUNpp4kbOoB43h6J1+9JYkcbe6ZdnYy0U2YnEm9ng2
   vbE/Zv71sZtNgMAXAUuee4gKkLmMDRmakILjx4GzWeEVnQy/BVl98T/oH
   C1U5FwwpRS3HlznZLlr5yCX4Lt9V6al8YlY47EooK7cKA9TVH87VJX6Zz
   4eYPe/QkUV3LJeRGXzXKe5D7bhCHLEEN4cXm6Nazh4r7C+kS3BUZL6R2C
   A==;
X-CSE-ConnectionGUID: YjKDKs96SfGbhULHF/7KEg==
X-CSE-MsgGUID: JZmnGZfkSr+vu/+9Y3pf8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17532501"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17532501"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:14 -0700
X-CSE-ConnectionGUID: b92S/GB7QcirXnNm9HUvTg==
X-CSE-MsgGUID: wA62JiRUQ2OLJjS7iZ5wig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36106847"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:10 -0700
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
Subject: [PATCH v5 02/16] selftests/resctrl: Calculate resctrl FS derived mem bw over sleep(1) only
Date: Fri, 31 May 2024 16:11:28 +0300
Message-Id: <20240531131142.1716-3-ilpo.jarvinen@linux.intel.com>
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

For the second read after rewind() to return a fresh value, also
newline has to be consumed by the fscanf().

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v5:
- Open mem bw file once and use rewind()
- Read \n from the mem bw file to allow rewind to return a new value.
v4:
- Open resctrl mem bw file (twice) beforehand to avoid opening it during
  the test
v3:
- Don't drop Return: entry from perf_open_imc_mem_bw() func comment
---
 tools/testing/selftests/resctrl/resctrl_val.c | 115 ++++++++++++------
 1 file changed, 80 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index f55f5989de72..6231275a6e6c 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -306,18 +306,13 @@ static void perf_close_imc_mem_bw(void)
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
 
 	for (imc = 0; imc < imcs; imc++) {
@@ -325,8 +320,6 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 		imc_counters_config[imc][WRITE].fd = -1;
 	}
 
-	/* Start all iMC counters to log values (both read and write) */
-	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
 	for (imc = 0; imc < imcs; imc++) {
 		ret = open_perf_event(imc, cpu_no, READ);
 		if (ret)
@@ -334,7 +327,26 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 		ret = open_perf_event(imc, cpu_no, WRITE);
 		if (ret)
 			goto close_fds;
+	}
+
+	return 0;
+
+close_fds:
+	perf_close_imc_mem_bw();
+	return -1;
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
@@ -346,6 +358,24 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
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
@@ -462,24 +492,23 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
  * 1. If con_mon grp is given, then read from it
  * 2. If con_mon grp is not given, then read from root con_mon grp
  */
-static int get_mem_bw_resctrl(unsigned long *mbm_total)
+static FILE *open_mem_bw_resctrl(const char *mbm_bw_file)
 {
 	FILE *fp;
 
-	fp = fopen(mbm_total_path, "r");
-	if (!fp) {
+	fp = fopen(mbm_bw_file, "r");
+	if (!fp)
 		ksft_perror("Failed to open total bw file");
 
-		return -1;
-	}
-	if (fscanf(fp, "%lu", mbm_total) <= 0) {
-		ksft_perror("Could not get mbm local bytes");
-		fclose(fp);
+	return fp;
+}
 
+static int get_mem_bw_resctrl(FILE *fp, unsigned long *mbm_total)
+{
+	if (fscanf(fp, "%lu\n", mbm_total) <= 0) {
+		ksft_perror("Could not get mbm local bytes");
 		return -1;
 	}
-	fclose(fp);
-
 	return 0;
 }
 
@@ -616,13 +645,17 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 }
 
 static int measure_vals(const struct user_params *uparams,
-			struct resctrl_val_param *param,
-			unsigned long *bw_resc_start)
+			struct resctrl_val_param *param)
 {
-	unsigned long bw_resc, bw_resc_end;
+	unsigned long bw_resc, bw_resc_start, bw_resc_end;
+	FILE *mem_bw_fp;
 	float bw_imc;
 	int ret;
 
+	mem_bw_fp = open_mem_bw_resctrl(mbm_total_path);
+	if (!mem_bw_fp)
+		return -1;
+
 	/*
 	 * Measure memory bandwidth from resctrl and from
 	 * another source which is perf imc value or could
@@ -630,22 +663,35 @@ static int measure_vals(const struct user_params *uparams,
 	 * Compare the two values to validate resctrl value.
 	 * It takes 1sec to measure the data.
 	 */
-	ret = get_mem_bw_imc(uparams->cpu, param->bw_report, &bw_imc);
+	ret = perf_open_imc_mem_bw(uparams->cpu);
 	if (ret < 0)
-		return ret;
+		goto close_fp;
 
-	ret = get_mem_bw_resctrl(&bw_resc_end);
+	ret = get_mem_bw_resctrl(mem_bw_fp, &bw_resc_start);
 	if (ret < 0)
-		return ret;
+		goto close_fp;
 
-	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
-	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
-	if (ret)
-		return ret;
+	rewind(mem_bw_fp);
 
-	*bw_resc_start = bw_resc_end;
+	do_imc_mem_bw_test();
 
-	return 0;
+	ret = get_mem_bw_resctrl(mem_bw_fp, &bw_resc_end);
+	if (ret < 0)
+		goto close_fp;
+
+	ret = get_mem_bw_imc(param->bw_report, &bw_imc);
+	if (ret < 0)
+		goto close_fp;
+
+	fclose(mem_bw_fp);
+
+	bw_resc = (bw_resc_end - bw_resc_start) / MB;
+
+	return print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
+
+close_fp:
+	fclose(mem_bw_fp);
+	return ret;
 }
 
 /*
@@ -719,7 +765,6 @@ int resctrl_val(const struct resctrl_test *test,
 		struct resctrl_val_param *param)
 {
 	char *resctrl_val = param->resctrl_val;
-	unsigned long bw_resc_start = 0;
 	struct sigaction sigact;
 	int ret = 0, pipefd[2];
 	char pipe_message = 0;
@@ -861,7 +906,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param, &bw_resc_start);
+			ret = measure_vals(uparams, param);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.39.2


