Return-Path: <linux-kselftest+bounces-6197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61EF878106
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E221C22625
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39823FB81;
	Mon, 11 Mar 2024 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxx1kI0Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591041C87;
	Mon, 11 Mar 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165252; cv=none; b=om9R5ZGmv49M+1tLpnGXhMcPvwIOuoTk2hKl1p3F5wclNq+b5FkK2s0dYeObvfHiRU6IJxDjrlWKPZSsLxRn1CwW39YbZ5sTIUuX9rCm9B+t0Xkcs+/9agDFhZi+ita/OD4iZoDg0D1p2Tsq168nzF68V/HXUac5iwbQ3CjEmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165252; c=relaxed/simple;
	bh=6TdbMNuNIygJmkdm0Aj4jKqBVcr35/Oplbv/oqfHVIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZCgDVYU93FjDubuxoCpz5dW2lORqnbFkcUmtAfTzhkyJiHFzFaxlKPw8K+6fAWlvdGJ1TLy7zXPZjgPGQOspCN2htC1LvdbxfXCoViWvESGucVahsEWN/170kSS5vo5VFcFP0/zEdPVzrqQkJsguYWrL/40z78iEPFjeEQWOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxx1kI0Q; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165251; x=1741701251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6TdbMNuNIygJmkdm0Aj4jKqBVcr35/Oplbv/oqfHVIg=;
  b=gxx1kI0QYTAuHFz7LtdbhA6yDf0r6elDld5ymoFbJyl5nK+hG87iE6gd
   VSkZfAG4ZQuOkDgwrNHrO9sKI+ialFL/iKbi02pV9fdRjH6shpIKxDKAG
   51uIfFIt5B3ZkWfk/5gU8y05dnVIekr/YbgbKoYHsLQUiIyOGHU1ueBsl
   VshuFGibiFwcKgJVDWHQeCg5+reL68LYMjkg6MtO9E9dyQcczFePOZB4A
   fXbCoBo7yR1ipqDFeqGw03ZTl90SLpxZ7wXNjnX53C2CdvhhLvzWT+TnA
   KHVlEIlL4lbXjLiOvNKWh2V63c3bQSsV5g1e6MAOnItKAOZckguOjXIxP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15388876"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15388876"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11166926"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:54:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 09/13] selftests/resctrl: Simplify bandwidth report type handling
Date: Mon, 11 Mar 2024 15:52:26 +0200
Message-Id: <20240311135230.7007-10-ilpo.jarvinen@linux.intel.com>
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

bw_report is only needed for selecting the correct value from the
values IMC measured. It is a member in the resctrl_val_param struct and
is always set to "reads". The value is then checked in resctrl_val()
using validate_bw_report_request() that besides validating the input,
assumes it can mutate the string which is questionable programming
practice.

Simplify handling bw_report:

- Convert validate_bw_report_request() into get_bw_report_type() that
  inputs and returns const char *. Use NULL to indicate error.

- Validate the report types inside measure_mem_bw(), not in
  resctrl_val().

- As resctrl_val() no longer needs bw_report for anything, it can just
  be passed to measure_mem_bw() by the ->measure() hooks.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- Rebased on top of next to resolve conflict in resctrl.h
---
 tools/testing/selftests/resctrl/mba_test.c    |  3 +--
 tools/testing/selftests/resctrl/mbm_test.c    |  3 +--
 tools/testing/selftests/resctrl/resctrl.h     |  7 +++----
 tools/testing/selftests/resctrl/resctrl_val.c | 19 +++++++++----------
 tools/testing/selftests/resctrl/resctrlfs.c   | 13 ++++++-------
 5 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 22c1f5e43352..89ad7f2cdd65 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -75,7 +75,7 @@ static int mba_setup(const struct resctrl_test *test,
 static int mba_measure(const struct user_params *uparams,
 		       struct resctrl_val_param *param, pid_t bm_pid)
 {
-	return measure_mem_bw(uparams, param, bm_pid, mbm_total_path);
+	return measure_mem_bw(uparams, param, bm_pid, mbm_total_path, "reads");
 }
 
 static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
@@ -176,7 +176,6 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
-		.bw_report	= "reads",
 		.init		= set_mba_path,
 		.setup		= mba_setup,
 		.measure	= mba_measure,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index ffbfcecf9bd6..c8c9aba81db8 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -129,7 +129,7 @@ static int mbm_setup(const struct resctrl_test *test,
 static int mbm_measure(const struct user_params *uparams,
 		       struct resctrl_val_param *param, pid_t bm_pid)
 {
-	return measure_mem_bw(uparams, param, bm_pid, mbm_total_path);
+	return measure_mem_bw(uparams, param, bm_pid, mbm_total_path, "reads");
 }
 
 void mbm_test_cleanup(void)
@@ -144,7 +144,6 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
-		.bw_report	= "reads",
 		.init		= set_mbm_path,
 		.setup		= mbm_setup,
 		.measure	= mbm_measure,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index d9c6443a8524..0931c5c09c4f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -83,7 +83,6 @@ struct resctrl_test {
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
  * @filename:		Name of file to which the o/p should be written
- * @bw_report:		Bandwidth report type (reads vs writes)
  * @init:		Callback function to initialize test environment
  * @setup:		Callback function to setup per test run environment
  * @measure:		Callback that performs the measurement (a single test)
@@ -93,7 +92,6 @@ struct resctrl_val_param {
 	char		ctrlgrp[64];
 	char		mongrp[64];
 	char		filename[64];
-	char		*bw_report;
 	unsigned long	mask;
 	int		num_of_runs;
 	int		(*init)(const struct resctrl_val_param *param,
@@ -133,7 +131,7 @@ int filter_dmesg(void);
 int get_domain_id(const char *resource, int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
-int validate_bw_report_request(char *bw_report);
+const char *get_bw_report_type(const char *bw_report);
 bool resctrl_resource_exists(const char *resource);
 bool resctrl_mon_feature_exists(const char *resource, const char *feature);
 bool resource_info_file_exists(const char *resource, const char *file);
@@ -153,7 +151,8 @@ int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
 int initialize_mem_bw_imc(void);
 int measure_mem_bw(const struct user_params *uparams,
 		   struct resctrl_val_param *param,
-		   pid_t bm_pid, const char *mbm_total_path);
+		   pid_t bm_pid, const char *mbm_total_path,
+		   const char *bw_report);
 int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
 		const char * const *benchmark_cmd,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 1a96298592ed..2f166a5c0c9b 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -320,7 +320,7 @@ static void do_imc_mem_bw_test(void)
  *
  * Return: = 0 on success. < 0 on failure.
  */
-static int get_mem_bw_imc(char *bw_report, float *bw_imc)
+static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
 {
 	float reads, writes, of_mul_read, of_mul_write;
 	int imc, j;
@@ -517,15 +517,21 @@ static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
  * @param:		parameters passed to resctrl_val()
  * @bm_pid:		PID that runs the benchmark
  * @mbm_total_path:	Resctrl FS monitoring file to read mem BW from
+ * @bw_report:		Bandwidth report type (reads, writes)
  */
 int measure_mem_bw(const struct user_params *uparams,
 		   struct resctrl_val_param *param,
-		   pid_t bm_pid, const char *mbm_total_path)
+		   pid_t bm_pid, const char *mbm_total_path,
+		   const char *bw_report)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	float bw_imc;
 	int ret;
 
+	bw_report = get_bw_report_type(bw_report);
+	if (!bw_report)
+		return -1;
+
 	/*
 	 * Measure memory bandwidth from resctrl and from
 	 * another source which is perf imc value or could
@@ -547,7 +553,7 @@ int measure_mem_bw(const struct user_params *uparams,
 	if (ret < 0)
 		return ret;
 
-	ret = get_mem_bw_imc(param->bw_report, &bw_imc);
+	ret = get_mem_bw_imc(bw_report, &bw_imc);
 	if (ret < 0)
 		return ret;
 
@@ -642,13 +648,6 @@ int resctrl_val(const struct resctrl_test *test,
 		return ret;
 	}
 
-	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
-	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
-		ret = validate_bw_report_request(param->bw_report);
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * If benchmark wasn't successfully started by child, then child should
 	 * kill parent, so save parent's pid
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 1cade75176eb..5f113b813253 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -837,22 +837,21 @@ int filter_dmesg(void)
 	return 0;
 }
 
-int validate_bw_report_request(char *bw_report)
+const char *get_bw_report_type(const char *bw_report)
 {
 	if (strcmp(bw_report, "reads") == 0)
-		return 0;
+		return bw_report;
 	if (strcmp(bw_report, "writes") == 0)
-		return 0;
+		return bw_report;
 	if (strcmp(bw_report, "nt-writes") == 0) {
-		strcpy(bw_report, "writes");
-		return 0;
+		return "writes";
 	}
 	if (strcmp(bw_report, "total") == 0)
-		return 0;
+		return bw_report;
 
 	fprintf(stderr, "Requested iMC B/W report type unavailable\n");
 
-	return -1;
+	return NULL;
 }
 
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
-- 
2.39.2


