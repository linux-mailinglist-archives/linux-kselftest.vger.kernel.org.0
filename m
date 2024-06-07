Return-Path: <linux-kselftest+bounces-11370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E3900428
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC0228B8C9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC3194ACB;
	Fri,  7 Jun 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdoEewTC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DE192B71;
	Fri,  7 Jun 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764907; cv=none; b=NOr5BhphgO7+eFz1CJlFc4XE2CKiMRLuIrw4kLxUSIfC4SrP4bMiY+CeN5Lt2UdxX8LYpUAbb6mhfv8iCr5XaZpMO8afD13X3UaG65Cc52mN7Y7ehlWyTOuylY33ACLtTeF/6bl6nHBBI//jG7ECirRaz7MwPeEj1fgEYVcW7Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764907; c=relaxed/simple;
	bh=WRe8NEY3kJuX6k0/E7Ze+UsA45owFsVDeVy2P1F3oFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEBBmZ2cpFMeOu/1zyjEf04bLn3igdB2ofmMgTYZHJ5sH8MVD0d2PLKPDREMJdk77S1p7hzBJ7p3FM5YxN/esIgg9L7fYZvUrWBcStn2SJnMLYRbQCRMrP4jD2yOd1vRcKVrLUxOdDL8BYGIygYUE2Z+3krt2IzYFjt2fExWGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdoEewTC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764906; x=1749300906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WRe8NEY3kJuX6k0/E7Ze+UsA45owFsVDeVy2P1F3oFI=;
  b=NdoEewTCeQre/URQoIOamRPH3Rmi36UgpIKBLfBOS/Q6qdDa0rYDXqO4
   fIzQVGsVVBoQURedPJcpsWLb4buxIHZtpdjyMIY8CZH8kfQ9zsDb8cKz5
   A2YT3Q0oyua6qg2OorzerXuzO/2EMQ/YX5kyLKhaFIwrtH7aGuNoRDglR
   Sqo8o9nWYURnB7WtztwkAsMntN9s4zuoeoOwfjilOqMldOhSws2pp1SbU
   kw8mrzuO2uFUL0Y8Meuvm6fNP+3eH3QkACvK8D66A0Rfx3Vb/5h9mpZi0
   mgWQ0sofsurZ20JytH+T+1TDg+mXOkw45wS8Lym9xRPreAhxmgyB15bw8
   g==;
X-CSE-ConnectionGUID: Y8GEQi7VRymUT869bjWi5w==
X-CSE-MsgGUID: wkHtgK05QvGpLIP7/VkOgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14664858"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14664858"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:55:05 -0700
X-CSE-ConnectionGUID: cOOrEMPTSpuhcaVHuKapzQ==
X-CSE-MsgGUID: aOe5nbJGS3ixvWvkz2y33w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="75797383"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:55:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Babu Moger <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 11/16] selftests/resctrl: Simplify bandwidth report type handling
Date: Fri,  7 Jun 2024 15:53:11 +0300
Message-Id: <20240607125316.7089-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
References: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
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

- Pass bw_report to measure_mem_bw() from ->measure() hook because
  resctrl_val() no longer needs bw_report for anything.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v5:
- Use imperative tone in commit message
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
index e38bcdd8b46f..2e85badd6d6b 100644
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
@@ -556,6 +556,7 @@ static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
  * @uparams:		User supplied parameters
  * @param:		Parameters passed to resctrl_val()
  * @bm_pid:		PID that runs the benchmark
+ * @bw_report:		Bandwidth report type (reads, writes)
  *
  * Measure memory bandwidth from resctrl and from another source which is
  * perf imc value or could be something else if perf imc event is not
@@ -563,13 +564,18 @@ static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
  * 1 sec to measure the data.
  */
 int measure_mem_bw(const struct user_params *uparams,
-		   struct resctrl_val_param *param, pid_t bm_pid)
+		   struct resctrl_val_param *param, pid_t bm_pid,
+		   const char *bw_report)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	FILE *mem_bw_fp;
 	float bw_imc;
 	int ret;
 
+	bw_report = get_bw_report_type(bw_report);
+	if (!bw_report)
+		return -1;
+
 	mem_bw_fp = open_mem_bw_resctrl(mbm_total_path);
 	if (!mem_bw_fp)
 		return -1;
@@ -590,7 +596,7 @@ int measure_mem_bw(const struct user_params *uparams,
 	if (ret < 0)
 		goto close_imc;
 
-	ret = get_mem_bw_imc(param->bw_report, &bw_imc);
+	ret = get_mem_bw_imc(bw_report, &bw_imc);
 	if (ret < 0)
 		goto close_imc;
 
@@ -694,13 +700,6 @@ int resctrl_val(const struct resctrl_test *test,
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
index 917d677adbba..9e4cda154d66 100644
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


