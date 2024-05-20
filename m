Return-Path: <linux-kselftest+bounces-10434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068638C9D67
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3FD1C232DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4255F56B95;
	Mon, 20 May 2024 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWlD6hBP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04AA6BB44;
	Mon, 20 May 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208332; cv=none; b=NVzU1kGyO9+reYgGqajno6v6hqLKbTgLUhmYO0A1E9arm8lXcNMhYmo4DT1kvfjNmlYb3hmi6SLiyBFNbcEsocH3VgbUb7LfA60oymDKQXU/h1e+l179JsjR+GpGfwq+zyMSs+pBqRduUdLyTkTiEnxwUJ8pjnvVxILlZilXCIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208332; c=relaxed/simple;
	bh=aZZyt4NFPtXxU+nIadLJ1WaUrIuPpQqgZN/i+LIpzgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLyzBcE8gr5WLvHQBCRr20sdZQPCsoJ4Jc5IG5Q2FdYE8VV3dHaxjh7vaJV40CJlSSojVDdEwhM7/Vjn6ve1QyhXLy+7g+1IA0eLVmdjADxTk/vKr1lDMSoUXA7xzQa+2WWS+MUSnT+LN8RKU067baTck3Ffqtpf3T4uzR8/DWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWlD6hBP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208330; x=1747744330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZZyt4NFPtXxU+nIadLJ1WaUrIuPpQqgZN/i+LIpzgE=;
  b=aWlD6hBPPi7nwUElHhDGSNa7ekiJD5VErA5o5i7NNjMGPb6NVk3DNQIX
   biT6UPkSDcU2nz59YYt11NNpbiLIqc0L+gkhIrB/Sj6CMkQPn/Z997h4v
   dOBEfd7XO0C1YHxLNrSAte29FDYCUYFmcIw5Y+kOk3rdMcjXjUyiR8Ytj
   +v7cc4scojAXFNnmGb46K6SuGGeU5ysjFZnLJxZ/M3i1GbSh6k4J4+XUz
   //y5RVF9StgA0Fq5WwbmWWdED/4kwjR9ih6Y6PtjCufy1/WGsdUZIMtd8
   tEa8aEuKJAjsRyAHC4x7hO1aP1whUnvZlGKNrMBfOg6p0mPPCY2UnXioT
   A==;
X-CSE-ConnectionGUID: Ni+CSCaEQLG2u+QRylmXaw==
X-CSE-MsgGUID: 7a0dq5lOTee1+Fs55jDhlw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12180530"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12180530"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:32:10 -0700
X-CSE-ConnectionGUID: QlAKOWKRTuuUws68pREO7Q==
X-CSE-MsgGUID: CI9jpiZxR5yRNSVrmLGb+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="33091231"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:32:07 -0700
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
Subject: [PATCH v4 11/16] selftests/resctrl: Simplify bandwidth report type handling
Date: Mon, 20 May 2024 15:30:15 +0300
Message-Id: <20240520123020.18938-12-ilpo.jarvinen@linux.intel.com>
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
index 00e60b01188a..27b936fe60bc 100644
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
@@ -135,7 +135,6 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.resctrl_val	= MBM_STR,
 		.ctrlgrp	= "c1",
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
index 23a82bd547a3..b2b944a70fb9 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -349,7 +349,7 @@ static void do_imc_mem_bw_test(void)
  *
  * Return: = 0 on success. < 0 on failure.
  */
-static int get_mem_bw_imc(char *bw_report, float *bw_imc)
+static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
 {
 	float reads, writes, of_mul_read, of_mul_write;
 	int imc;
@@ -562,15 +562,21 @@ static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
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
 	FILE *mem_bw_fp, *mem_bw_fp2;
 	float bw_imc;
 	int ret;
 
+	bw_report = get_bw_report_type(bw_report);
+	if (!bw_report)
+		return -1;
+
 	mem_bw_fp = open_mem_bw_resctrl(mbm_total_path);
 	if (!mem_bw_fp)
 		return -1;
@@ -601,7 +607,7 @@ int measure_mem_bw(const struct user_params *uparams,
 	if (ret < 0)
 		goto close_fp2;
 
-	ret = get_mem_bw_imc(param->bw_report, &bw_imc);
+	ret = get_mem_bw_imc(bw_report, &bw_imc);
 	if (ret < 0)
 		goto close_fp2;
 
@@ -705,13 +711,6 @@ int resctrl_val(const struct resctrl_test *test,
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


