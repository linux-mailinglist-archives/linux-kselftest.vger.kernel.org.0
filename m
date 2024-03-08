Return-Path: <linux-kselftest+bounces-6101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D89876528
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC64E285808
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2678723767;
	Fri,  8 Mar 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="da3Af5HP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CA4CE08;
	Fri,  8 Mar 2024 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904274; cv=none; b=CFch0SNYKwpXq1pefwmuB/lPdnc3Vady8VACa6kuZJe2m0clcFA92KXckH5Lb2sKMW4MZTNr5BfhLBhNM88yTqk6xL+evzRdSYs7wbl7MtyKANnB91ndjSpDpzUVJ19gdpuUqE2dXwFN92pNY28py8g5wWPaSYpI5P/4kniiX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904274; c=relaxed/simple;
	bh=o8lv5VE1IlgHSVebaQ+NoK1MFGS3ZjMGBmAnHnYJVaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtvebgaNNtPOQp702tvTAh7t6FsEG2tSu24AbMyw1V3YhRqVeOm74qiXgaUFnBJcofGCWJJ7+REDlHOWR8JyVBlWhfX2IPoCpiNDRNbIuZmOOnFcgRsqQ+0Z3pgM5vX2kMUgFlc1Ip/YmUEjHJqRbrX9yMwOW32eUl64Gp8VhTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=da3Af5HP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904272; x=1741440272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o8lv5VE1IlgHSVebaQ+NoK1MFGS3ZjMGBmAnHnYJVaE=;
  b=da3Af5HPxjLYX19YpOmKKw9ZOWhAD0wcWTieCW4euw6m7iZxdZrMZ5bj
   KqAOz99mJ7nKMVF3g9+GTi6OGAbaGzWew7MFmrdmu2RXtr7LXbtdB8rF7
   uAexfPnIA6gJcQVb/9oZD6C9qN5eTbjDNXGAU6ihi9tZZ5SHB2NF4JrQk
   PXZNPGCH1PETAb3V7cN0OOObiLtt2J3+tG4TKxGS5Q5VfXUbiRCJ0LZKV
   QzcYbC1JBROw6pJDzwsz5FczqiItiIuTsgnRg6fLpImotf6vBOueCznpm
   3cARp/a6Z7t4X9zzRgQ6bouaXF7g9OiPLTaSEcjaDtHuGeTg38uBvUUjM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8375118"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="8375118"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10472740"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:24:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 08/13] selftests/resctrl: Add ->init() callback into resctrl_val_param
Date: Fri,  8 Mar 2024 15:22:50 +0200
Message-Id: <20240308132255.14442-9-ilpo.jarvinen@linux.intel.com>
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

The struct resctrl_val_param is there to customize behavior inside
resctrl_val() which is currently not used to full extent and there are
number of strcmp()s for test name in resctrl_val done by resctrl_val().

Create ->init() hook into the struct resctrl_val_param to cleanly
do per test initialization.

Remove also unused branches to setup paths and the related #defines.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cmt_test.c    |  12 ++
 tools/testing/selftests/resctrl/mba_test.c    |  24 +++-
 tools/testing/selftests/resctrl/mbm_test.c    |  24 +++-
 tools/testing/selftests/resctrl/resctrl.h     |   9 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 123 ++----------------
 5 files changed, 75 insertions(+), 117 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index fec487b2cbf2..ae2775ace36e 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -16,6 +16,17 @@
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
+#define CON_MON_LCC_OCCUP_PATH		\
+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
+
+static int set_cmt_path(const struct resctrl_val_param *param, int domain_id)
+{
+	sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
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
+		.init		= set_cmt_path,
 		.setup		= cmt_setup,
 		.measure	= cmt_measure,
 	};
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index a88a22294f03..eb02d3322e0e 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -8,6 +8,8 @@
  *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
  *    Fenghua Yu <fenghua.yu@intel.com>
  */
+#include <limits.h>
+
 #include "resctrl.h"
 
 #define RESULT_FILE_NAME	"result_mba"
@@ -17,6 +19,25 @@
 #define ALLOCATION_MIN		10
 #define ALLOCATION_STEP		10
 
+#define CON_MBM_LOCAL_BYTES_PATH \
+	"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+static char mbm_total_path[PATH_MAX];
+
+static int set_mba_path(const struct resctrl_val_param *param, int domain_id)
+{
+	int ret;
+
+	ret = initialize_mem_bw_imc();
+	if (ret)
+		return ret;
+
+	sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
+		RESCTRL_PATH, param->ctrlgrp, domain_id);
+
+	return 0;
+}
+
 /*
  * Change schemata percentage from 100 to 10%. Write schemata to specified
  * con_mon grp, mon_grp in resctrl FS.
@@ -54,7 +75,7 @@ static int mba_setup(const struct resctrl_test *test,
 static int mba_measure(const struct user_params *uparams,
 		       struct resctrl_val_param *param, pid_t bm_pid)
 {
-	return measure_mem_bw(uparams, param, bm_pid);
+	return measure_mem_bw(uparams, param, bm_pid, mbm_total_path);
 }
 
 static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
@@ -156,6 +177,7 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
+		.init		= set_mba_path,
 		.setup		= mba_setup,
 		.measure	= mba_measure,
 	};
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 90c8dfa2c3fb..cb9f9d5101d9 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -8,12 +8,19 @@
  *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
  *    Fenghua Yu <fenghua.yu@intel.com>
  */
+#include <limits.h>
+
 #include "resctrl.h"
 
 #define RESULT_FILE_NAME	"result_mbm"
 #define MAX_DIFF_PERCENT	8
 #define NUM_OF_RUNS		5
 
+#define CON_MON_MBM_LOCAL_BYTES_PATH \
+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+static char mbm_total_path[PATH_MAX];
+
 static int
 show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 {
@@ -86,6 +93,20 @@ static int check_results(size_t span)
 	return ret;
 }
 
+static int set_mbm_path(const struct resctrl_val_param *param, int domain_id)
+{
+	int ret;
+
+	ret = initialize_mem_bw_imc();
+	if (ret)
+		return ret;
+
+	sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
+		RESCTRL_PATH, param->ctrlgrp, param->mongrp, domain_id);
+
+	return 0;
+}
+
 static int mbm_setup(const struct resctrl_test *test,
 		     const struct user_params *uparams,
 		     struct resctrl_val_param *p)
@@ -108,7 +129,7 @@ static int mbm_setup(const struct resctrl_test *test,
 static int mbm_measure(const struct user_params *uparams,
 		       struct resctrl_val_param *param, pid_t bm_pid)
 {
-	return measure_mem_bw(uparams, param, bm_pid);
+	return measure_mem_bw(uparams, param, bm_pid, mbm_total_path);
 }
 
 void mbm_test_cleanup(void)
@@ -124,6 +145,7 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
+		.init		= set_mbm_path,
 		.setup		= mbm_setup,
 		.measure	= mbm_measure,
 	};
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 4455fb3c6933..511c87634d4f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -81,7 +81,8 @@ struct resctrl_test {
  * @mongrp:		Name of the monitor group (mon grp)
  * @filename:		Name of file to which the o/p should be written
  * @bw_report:		Bandwidth report type (reads vs writes)
- * @setup:		Call back function to setup test environment
+ * @init:		Callback function to initialize test environment
+ * @setup:		Callback function to setup per test run environment
  * @measure:		Callback that performs the measurement (a single test)
  */
 struct resctrl_val_param {
@@ -92,6 +93,8 @@ struct resctrl_val_param {
 	char		*bw_report;
 	unsigned long	mask;
 	int		num_of_runs;
+	int		(*init)(const struct resctrl_val_param *param,
+				int domain_id);
 	int		(*setup)(const struct resctrl_test *test,
 				 const struct user_params *uparams,
 				 struct resctrl_val_param *param);
@@ -142,8 +145,10 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
+int initialize_mem_bw_imc(void);
 int measure_mem_bw(const struct user_params *uparams,
-		   struct resctrl_val_param *param, pid_t bm_pid);
+		   struct resctrl_val_param *param,
+		   pid_t bm_pid, const char *mbm_total_path);
 int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
 		const char * const *benchmark_cmd,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 13d89d24474e..1a96298592ed 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -19,29 +19,6 @@
 #define MAX_TOKENS		5
 #define READ			0
 #define WRITE			1
-#define CON_MON_MBM_LOCAL_BYTES_PATH				\
-	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
-
-#define CON_MBM_LOCAL_BYTES_PATH		\
-	"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
-
-#define MON_MBM_LOCAL_BYTES_PATH		\
-	"%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
-
-#define MBM_LOCAL_BYTES_PATH			\
-	"%s/mon_data/mon_L3_%02d/mbm_local_bytes"
-
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
 
 struct membw_read_format {
 	__u64 value;         /* The value of the event */
@@ -59,7 +36,6 @@ struct imc_counter_config {
 	int fd;
 };
 
-static char mbm_total_path[1024];
 static int imcs;
 static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
 
@@ -275,7 +251,7 @@ static int num_of_imcs(void)
 	return count;
 }
 
-static int initialize_mem_bw_imc(void)
+int initialize_mem_bw_imc(void)
 {
 	int imc, j;
 
@@ -411,56 +387,10 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
 	return 0;
 }
 
-void set_mbm_path(const char *ctrlgrp, const char *mongrp, int domain_id)
-{
-	if (ctrlgrp && mongrp)
-		sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
-			RESCTRL_PATH, ctrlgrp, mongrp, domain_id);
-	else if (!ctrlgrp && mongrp)
-		sprintf(mbm_total_path, MON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			mongrp, domain_id);
-	else if (ctrlgrp && !mongrp)
-		sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			ctrlgrp, domain_id);
-	else if (!ctrlgrp && !mongrp)
-		sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			domain_id);
-}
-
-/*
- * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
- * @ctrlgrp:			Name of the control monitor group (con_mon grp)
- * @mongrp:			Name of the monitor group (mon grp)
- * @domain_id:			Domain ID (cache ID; for MB, L3 cache ID)
- * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
- */
-static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
-				      int domain_id, char *resctrl_val)
-{
-	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
-		set_mbm_path(ctrlgrp, mongrp, domain_id);
-
-	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-		if (ctrlgrp)
-			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
-				RESCTRL_PATH, ctrlgrp, domain_id);
-		else
-			sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
-				RESCTRL_PATH, domain_id);
-	}
-}
-
 /*
  * Get MBM Local bytes as reported by resctrl FS
- * For MBM,
- * 1. If con_mon grp and mon grp are given, then read from con_mon grp's mon grp
- * 2. If only con_mon grp is given, then read from con_mon grp
- * 3. If both are not given, then read from root con_mon grp
- * For MBA,
- * 1. If con_mon grp is given, then read from it
- * 2. If con_mon grp is not given, then read from root con_mon grp
  */
-static int get_mem_bw_resctrl(unsigned long *mbm_total)
+static int get_mem_bw_resctrl(const char *mbm_total_path, unsigned long *mbm_total)
 {
 	FILE *fp;
 
@@ -581,43 +511,16 @@ static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
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
  * @param:		parameters passed to resctrl_val()
  * @bm_pid:		PID that runs the benchmark
+ * @mbm_total_path:	Resctrl FS monitoring file to read mem BW from
  */
 int measure_mem_bw(const struct user_params *uparams,
-		   struct resctrl_val_param *param, pid_t bm_pid)
+		   struct resctrl_val_param *param,
+		   pid_t bm_pid, const char *mbm_total_path)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	float bw_imc;
@@ -634,13 +537,13 @@ int measure_mem_bw(const struct user_params *uparams,
 	if (ret < 0)
 		return ret;
 
-	ret = get_mem_bw_resctrl(&bw_resc_start);
+	ret = get_mem_bw_resctrl(mbm_total_path, &bw_resc_start);
 	if (ret < 0)
 		return ret;
 
 	do_imc_mem_bw_test();
 
-	ret = get_mem_bw_resctrl(&bw_resc_end);
+	ret = get_mem_bw_resctrl(mbm_total_path, &bw_resc_end);
 	if (ret < 0)
 		return ret;
 
@@ -826,17 +729,11 @@ int resctrl_val(const struct resctrl_test *test,
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
-		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
-					  domain_id, resctrl_val);
-	} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
-					    domain_id, resctrl_val);
+	}
 
 	/* Parent waits for child to be ready. */
 	close(pipefd[1]);
-- 
2.39.2


