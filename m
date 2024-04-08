Return-Path: <linux-kselftest+bounces-7423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A02489C9B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8A91C247CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C11428EA;
	Mon,  8 Apr 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvnLlk9j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C014534F;
	Mon,  8 Apr 2024 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594085; cv=none; b=E//zf+M/wKVl4O4GvS8aYmG7FYBwvahgsvhTHYIe8Q//KQaxs6tyreay1W5PZ7NdW7w5Kqz40ew7K1tWkthnTEsMdAG3h9U+W8NUxNiTSqAxOyqvvGOuIDoXIKiYyBBdQzUdRVRLYnLMKP+nJNm7BiuIZl3v1PZ1VGvdVDS8DrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594085; c=relaxed/simple;
	bh=ou95bQenO6eaVT0zNYeAL1pHVoXX2ezb5k+zzB03VxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/GDQCqAc+xwS9RrjxBRRb/S8+mt+vs8wToWkc851kigCXNbugB2jqT0idvsfDGvtuFEnwcfyXtQTMdfE3DoWUaYn1ttQ0dnxyxRtW1H1DF9NshmdEVPnkfgTzKiDa18zknVezfpH4x1ZEC+QctAQIajfe7NWGVq1GbObWkkylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvnLlk9j; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594083; x=1744130083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ou95bQenO6eaVT0zNYeAL1pHVoXX2ezb5k+zzB03VxQ=;
  b=WvnLlk9jEaI5EDRzPb1x84Jkbwg8rMh8gWHU1siMBRn9YgJjI3Oxopub
   Ftb1bzXK2BYyH2+Vr159rNZ9+/dpUi9sfqYh6GTAzLQrP6B6pZFll0W2c
   YSn2mK1YVa8LBN6ihjKck4beDTdv6YY1Ln5VOA/mRfzG9lWnh4Pyi/sGU
   Ksr9KdHSS4WuPJyXHG9Iof5YIWcabLxFdE/hfKcsuDQAlYE1HGgF2+Ard
   EWqA2TbM0aPDc1WuHY8sSUMJIvN4LhuvTD7qPB+AkccoS80t0/3aa7eDQ
   3eDg5P1IhH/nUfnK2mvPOqUzsTbjxJAmPDaVMSzdlaXGS5Y4IaxSxS0sX
   A==;
X-CSE-ConnectionGUID: xp+jwV+6SjK017f+divwhQ==
X-CSE-MsgGUID: DgIimFZcQPStKZFGLHtIog==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7750077"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7750077"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:34:43 -0700
X-CSE-ConnectionGUID: hf3wv+xnQg+vQoMtHJVsaQ==
X-CSE-MsgGUID: 9/kPExKzQ3CHElAQJAR6nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="57396660"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:34:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 12/16] selftests/resctrl: Simplify bandwidth report type handling
Date: Mon,  8 Apr 2024 19:32:43 +0300
Message-Id: <20240408163247.3224-13-ilpo.jarvinen@linux.intel.com>
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
index 0a95c42f1616..9c9a4f22e529 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -67,7 +67,7 @@ static int mba_setup(const struct resctrl_test *test,
 static int mba_measure(const struct user_params *uparams,
 		       struct resctrl_val_param *param, pid_t bm_pid)
 {
-	return measure_mem_bw(uparams, param, bm_pid);
+	return measure_mem_bw(uparams, param, bm_pid, "reads");
 }
 
 static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
@@ -168,7 +168,6 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
-		.bw_report	= "reads",
 		.init		= mba_init,
 		.setup		= mba_setup,
 		.measure	= mba_measure,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 90716917e6ef..0a3ab99b31ab 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -121,7 +121,7 @@ static int mbm_setup(const struct resctrl_test *test,
 static int mbm_measure(const struct user_params *uparams,
 		       struct resctrl_val_param *param, pid_t bm_pid)
 {
-	return measure_mem_bw(uparams, param, bm_pid);
+	return measure_mem_bw(uparams, param, bm_pid, "reads");
 }
 
 static void mbm_test_cleanup(void)
@@ -136,7 +136,6 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
-		.bw_report	= "reads",
 		.init		= mbm_init,
 		.setup		= mbm_setup,
 		.measure	= mbm_measure,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index d3fbb957309d..4446a0e493ef 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -85,7 +85,6 @@ struct resctrl_test {
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
  * @filename:		Name of file to which the o/p should be written
- * @bw_report:		Bandwidth report type (reads vs writes)
  * @init:		Callback function to initialize test environment
  * @setup:		Callback function to setup per test run environment
  * @measure:		Callback that performs the measurement (a single test)
@@ -95,7 +94,6 @@ struct resctrl_val_param {
 	char		ctrlgrp[64];
 	char		mongrp[64];
 	char		filename[64];
-	char		*bw_report;
 	unsigned long	mask;
 	int		num_of_runs;
 	int		(*init)(const struct resctrl_val_param *param,
@@ -135,7 +133,7 @@ int filter_dmesg(void);
 int get_domain_id(const char *resource, int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
-int validate_bw_report_request(char *bw_report);
+const char *get_bw_report_type(const char *bw_report);
 bool resctrl_resource_exists(const char *resource);
 bool resctrl_mon_feature_exists(const char *resource, const char *feature);
 bool resource_info_file_exists(const char *resource, const char *file);
@@ -154,7 +152,8 @@ void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
 int initialize_mem_bw_imc(void);
 int measure_mem_bw(const struct user_params *uparams,
-		   struct resctrl_val_param *param, pid_t bm_pid);
+		   struct resctrl_val_param *param, pid_t bm_pid,
+		   const char *bw_report);
 void initialize_mem_bw_resctrl(const struct resctrl_val_param *param,
 			       int domain_id);
 int resctrl_val(const struct resctrl_test *test,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index d289c17f1f03..a9e0bb35a4ab 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -338,7 +338,7 @@ static void do_imc_mem_bw_test(void)
  *
  * Return: = 0 on success. < 0 on failure.
  */
-static int get_mem_bw_imc(char *bw_report, float *bw_imc)
+static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
 {
 	float reads, writes, of_mul_read, of_mul_write;
 	int imc;
@@ -550,14 +550,20 @@ static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
  * @uparams:		User supplied parameters
  * @param:		parameters passed to resctrl_val()
  * @bm_pid:		PID that runs the benchmark
+ * @bw_report:		Bandwidth report type (reads, writes)
  */
 int measure_mem_bw(const struct user_params *uparams,
-		   struct resctrl_val_param *param, pid_t bm_pid)
+		   struct resctrl_val_param *param, pid_t bm_pid,
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
@@ -579,7 +585,7 @@ int measure_mem_bw(const struct user_params *uparams,
 	if (ret < 0)
 		return ret;
 
-	ret = get_mem_bw_imc(param->bw_report, &bw_imc);
+	ret = get_mem_bw_imc(bw_report, &bw_imc);
 	if (ret < 0)
 		return ret;
 
@@ -674,13 +680,6 @@ int resctrl_val(const struct resctrl_test *test,
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
index 9b86f826a40c..aac382eaa032 100644
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
 
 	fprintf(stderr, "Requested iMC bandwidth report type unavailable\n");
 
-	return -1;
+	return NULL;
 }
 
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
-- 
2.39.2


