Return-Path: <linux-kselftest+bounces-11369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F15900424
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336461F269C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89528194A6F;
	Fri,  7 Jun 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxNbR82q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B45194158;
	Fri,  7 Jun 2024 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764898; cv=none; b=CTMSKTHxB8DmghIIf4drm9gT5BTeCyGM8EqPcTpqAjf3yfYgLmYh3hYqhQc4bV8WuXeu0xUHPUWvkPQofuQZB4Zna05g8RqOntokF/n2qgL0kVEE2o9utX8z7AGbEzJYwhS/OoDU8bs0CWLs8+7AeGNP+KdyNz6EA7CC+ZuNv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764898; c=relaxed/simple;
	bh=wD+tdQtrHuJ2XQhtxDiKVlZdCR4XYw6SYfFA/LI7uXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K99aqhq3wfy/NhdtC7YSlVq+wgRmCIL9k2wmrtwiyyAGHKXsqMBqVXvQag0Whn2CjLy+nieE1CNueZRDAb2Nrosw5gqUfq2qyr4WOyfY/UAJlxH1anZzKEU55VTaWkaHX8apcl4MNfDfewMegq9xvPLi4zFet4oVzCFiifFHx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxNbR82q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764897; x=1749300897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wD+tdQtrHuJ2XQhtxDiKVlZdCR4XYw6SYfFA/LI7uXY=;
  b=LxNbR82qq9SnpVSoVeNItbUtG5WW7doiOWBmVzvTWOSvRoU6/Vceh3HJ
   /yBBs84QHM6xh33/u32k6zxlTh6htihl6X5EM/ZAEMb/d7LGIVVDWLhRy
   htNt6wq1nTqvQXQMdJ2wV2K0mWXLxEf7E6pOVKzVZ0KPsfl1v6xhWoGeq
   MkDPWSf+0GxfiYiOJDTFJJ3queoQzsSWT0I/FeJDUOBWLNimqrvc0jGHa
   M96PYe8i+BzFs98tHZoSMVDQ1F743PrIoN3C87odccPikw/+1HFkUpxtQ
   G++JArt/UrHrdZ5A0m7SlSAjbTwVQW1L+MbFU7yTXbhWCnTs0Zw24dA+D
   A==;
X-CSE-ConnectionGUID: j7WUEAGITaCzdMJtxPcXPg==
X-CSE-MsgGUID: xSE+00ZdSaSTwqGXIojBmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14664827"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14664827"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:54:56 -0700
X-CSE-ConnectionGUID: CsO402PhQ6+DyS36MqpaEg==
X-CSE-MsgGUID: 73qfoyclR0OCzj1NJvMXnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="75797358"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:54:53 -0700
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
Subject: [PATCH v6 10/16] selftests/resctrl: Add ->init() callback into resctrl_val_param
Date: Fri,  7 Jun 2024 15:53:10 +0300
Message-Id: <20240607125316.7089-11-ilpo.jarvinen@linux.intel.com>
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

The struct resctrl_val_param is there to customize behavior inside
resctrl_val() which is currently not used to full extent and there are
number of strcmp()s for test name in resctrl_val done by resctrl_val().

Create ->init() hook into the struct resctrl_val_param to cleanly
do per test initialization.

Remove also unused branches to setup paths and the related #defines
for CMT test.

While touching kerneldoc, make the adjacent line consistent with the
newly added form (callback vs call back).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v5:
- Use consistent formatting in kerneldoc
v3:
- Rename init functions to <testname>_init()
- Removed tabs intermixed with code
- Leave now common mbm bw filename setup into resctrl_val.c
---
 tools/testing/selftests/resctrl/cmt_test.c    | 12 +++
 tools/testing/selftests/resctrl/mba_test.c    | 14 ++++
 tools/testing/selftests/resctrl/mbm_test.c    | 14 ++++
 tools/testing/selftests/resctrl/resctrl.h     |  8 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 75 ++++---------------
 5 files changed, 60 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index d8521386cd18..238f514ba7e6 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -16,6 +16,17 @@
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
+#define CON_MON_LCC_OCCUP_PATH		\
+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
+
+static int cmt_init(const struct resctrl_val_param *param, int domain_id)
+{
+	sprintf(llc_occup_path, CON_MON_LCC_OCCUP_PATH, RESCTRL_PATH,
+		param->ctrlgrp, param->mongrp, domain_id);
+
+	return 0;
+}
+
 static int cmt_setup(const struct resctrl_test *test,
 		     const struct user_params *uparams,
 		     struct resctrl_val_param *p)
@@ -139,6 +150,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 		.filename	= RESULT_FILE_NAME,
 		.mask		= ~(long_mask << n) & long_mask,
 		.num_of_runs	= 0,
+		.init		= cmt_init,
 		.setup		= cmt_setup,
 		.measure	= cmt_measure,
 	};
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index de6e29faf214..0a95c42f1616 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -17,6 +17,19 @@
 #define ALLOCATION_MIN		10
 #define ALLOCATION_STEP		10
 
+static int mba_init(const struct resctrl_val_param *param, int domain_id)
+{
+	int ret;
+
+	ret = initialize_mem_bw_imc();
+	if (ret)
+		return ret;
+
+	initialize_mem_bw_resctrl(param, domain_id);
+
+	return 0;
+}
+
 /*
  * Change schemata percentage from 100 to 10%. Write schemata to specified
  * con_mon grp, mon_grp in resctrl FS.
@@ -156,6 +169,7 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
+		.init		= mba_init,
 		.setup		= mba_setup,
 		.measure	= mba_measure,
 	};
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 59e26adf60bb..00e60b01188a 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -86,6 +86,19 @@ static int check_results(size_t span)
 	return ret;
 }
 
+static int mbm_init(const struct resctrl_val_param *param, int domain_id)
+{
+	int ret;
+
+	ret = initialize_mem_bw_imc();
+	if (ret)
+		return ret;
+
+	initialize_mem_bw_resctrl(param, domain_id);
+
+	return 0;
+}
+
 static int mbm_setup(const struct resctrl_test *test,
 		     const struct user_params *uparams,
 		     struct resctrl_val_param *p)
@@ -123,6 +136,7 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.ctrlgrp	= "c1",
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
+		.init		= mbm_init,
 		.setup		= mbm_setup,
 		.measure	= mbm_measure,
 	};
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 5dc3def70669..d3fbb957309d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -86,7 +86,8 @@ struct resctrl_test {
  * @mongrp:		Name of the monitor group (mon grp)
  * @filename:		Name of file to which the o/p should be written
  * @bw_report:		Bandwidth report type (reads vs writes)
- * @setup:		Call back function to setup test environment
+ * @init:		Callback function to initialize test environment
+ * @setup:		Callback function to setup per test run environment
  * @measure:		Callback that performs the measurement (a single test)
  */
 struct resctrl_val_param {
@@ -97,6 +98,8 @@ struct resctrl_val_param {
 	char		*bw_report;
 	unsigned long	mask;
 	int		num_of_runs;
+	int		(*init)(const struct resctrl_val_param *param,
+				int domain_id);
 	int		(*setup)(const struct resctrl_test *test,
 				 const struct user_params *uparams,
 				 struct resctrl_val_param *param);
@@ -149,8 +152,11 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
+int initialize_mem_bw_imc(void);
 int measure_mem_bw(const struct user_params *uparams,
 		   struct resctrl_val_param *param, pid_t bm_pid);
+void initialize_mem_bw_resctrl(const struct resctrl_val_param *param,
+			       int domain_id);
 int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
 		const char * const *benchmark_cmd,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 22446930a856..e38bcdd8b46f 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -23,18 +23,6 @@
 #define CON_MBM_LOCAL_BYTES_PATH		\
 	"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
 
-#define CON_MON_LCC_OCCUP_PATH		\
-	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
-
-#define CON_LCC_OCCUP_PATH		\
-	"%s/%s/mon_data/mon_L3_%02d/llc_occupancy"
-
-#define MON_LCC_OCCUP_PATH		\
-	"%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
-
-#define LCC_OCCUP_PATH			\
-	"%s/mon_data/mon_L3_%02d/llc_occupancy"
-
 struct membw_read_format {
 	__u64 value;         /* The value of the event */
 	__u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
@@ -268,7 +256,7 @@ static int num_of_imcs(void)
 	return count;
 }
 
-static int initialize_mem_bw_imc(void)
+int initialize_mem_bw_imc(void)
 {
 	int imc, j;
 
@@ -424,24 +412,18 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
 
 /*
  * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
- * @ctrlgrp:			Name of the control monitor group (con_mon grp)
- * @domain_id:			Domain ID (cache ID; for MB, L3 cache ID)
+ * @param:	Parameters passed to resctrl_val()
+ * @domain_id:	Domain ID (cache ID; for MB, L3 cache ID)
  */
-static void initialize_mem_bw_resctrl(const char *ctrlgrp, int domain_id)
+void initialize_mem_bw_resctrl(const struct resctrl_val_param *param,
+			       int domain_id)
 {
 	sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-		ctrlgrp, domain_id);
+		param->ctrlgrp, domain_id);
 }
 
 /*
- * Get MBM Local bytes as reported by resctrl FS
- * For MBM,
- * 1. If con_mon grp and mon grp are given, then read from con_mon grp's mon grp
- * 2. If only con_mon grp is given, then read from con_mon grp
- * 3. If both are not given, then read from root con_mon grp
- * For MBA,
- * 1. If con_mon grp is given, then read from it
- * 2. If con_mon grp is not given, then read from root con_mon grp
+ * Open file to read MBM local bytes from resctrl FS
  */
 static FILE *open_mem_bw_resctrl(const char *mbm_bw_file)
 {
@@ -454,6 +436,9 @@ static FILE *open_mem_bw_resctrl(const char *mbm_bw_file)
 	return fp;
 }
 
+/*
+ * Get MBM Local bytes as reported by resctrl FS
+ */
 static int get_mem_bw_resctrl(FILE *fp, unsigned long *mbm_total)
 {
 	if (fscanf(fp, "%lu\n", mbm_total) <= 0) {
@@ -566,35 +551,6 @@ static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
 	return 0;
 }
 
-static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
-{
-	if (strlen(ctrlgrp) && strlen(mongrp))
-		sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
-			ctrlgrp, mongrp, sock_num);
-	else if (!strlen(ctrlgrp) && strlen(mongrp))
-		sprintf(llc_occup_path,	MON_LCC_OCCUP_PATH, RESCTRL_PATH,
-			mongrp, sock_num);
-	else if (strlen(ctrlgrp) && !strlen(mongrp))
-		sprintf(llc_occup_path,	CON_LCC_OCCUP_PATH, RESCTRL_PATH,
-			ctrlgrp, sock_num);
-	else if (!strlen(ctrlgrp) && !strlen(mongrp))
-		sprintf(llc_occup_path, LCC_OCCUP_PATH,	RESCTRL_PATH, sock_num);
-}
-
-/*
- * initialize_llc_occu_resctrl:	Appropriately populate "llc_occup_path"
- * @ctrlgrp:			Name of the control monitor group (con_mon grp)
- * @mongrp:			Name of the monitor group (mon grp)
- * @domain_id:			Domain ID (cache ID; for MB, L3 cache ID)
- * @resctrl_val:		Resctrl feature (Eg: cat, cmt.. etc)
- */
-static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
-					int domain_id, char *resctrl_val)
-{
-	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		set_cmt_path(ctrlgrp, mongrp, domain_id);
-}
-
 /*
  * measure_mem_bw - Measures memory bandwidth numbers while benchmark runs
  * @uparams:		User supplied parameters
@@ -825,16 +781,11 @@ int resctrl_val(const struct resctrl_test *test,
 	if (ret)
 		goto out;
 
-	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
-	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-		ret = initialize_mem_bw_imc();
+	if (param->init) {
+		ret = param->init(param, domain_id);
 		if (ret)
 			goto out;
-
-		initialize_mem_bw_resctrl(param->ctrlgrp, domain_id);
-	} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
-					    domain_id, resctrl_val);
+	}
 
 	/* Parent waits for child to be ready. */
 	close(pipefd[1]);
-- 
2.39.2


