Return-Path: <linux-kselftest+bounces-6196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E73A878104
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD441F239D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893BB3FB85;
	Mon, 11 Mar 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXloENAi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6D41C7A;
	Mon, 11 Mar 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165244; cv=none; b=PrMoCQwN0jqsCmZpfPgeEHx+JtFJZYcUUXjSIDS5kflymyep2FNQGfCO/nQvw9HrDxHZzK3P+2s6WQH8ECrt6uODsbnZ+L+UHx9MhgGOA8gq/qbuS7McDHJ7JRSLPz9XO3XLVzaVQaMem11B2keYoduHYQYjaKEdLhXE7kef5rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165244; c=relaxed/simple;
	bh=nrg3pCi22NX1fMATMvIFbWDFyL8xEeuOhcUfrUuu900=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gba+kOU5n5y/JADjGeyUL4OlmRjF4AH9e1pSZC94PvSj+fCwAwn7qkpbpzcsOvZNp6MHJWZwzIFtE69pybB9Oy83PK0PkpVQZgScdxNFckbsx3np4PBDoqM1rPqZqs7ixMHbqm4KNEqleWlAazkT5h0dWiCo4sviDDBeNLlJmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXloENAi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165243; x=1741701243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrg3pCi22NX1fMATMvIFbWDFyL8xEeuOhcUfrUuu900=;
  b=GXloENAiSqHxEwed0MVKCFyd0fp9GMq+R+LEoPfnKvpbGf0zgOl0MPUT
   MD4s5IfBz0bzTi/uEC3WO1Va/gdc5ci7eAtUNIZEAb5jJx/o7CAmuaN9K
   LinfpFE2Vu2i9xDXTubtqBzWt8xKV5yVZnu1pxjVQksVAmaq+pXLjKrHv
   qTqlYY4rLP04OY6wDJD0Xv6XA5s0B8ULB3gpjADcMUlyMzRZZ3rCsDOxK
   AhFCfCojOtHU3AqFU/3+yuQahv57EnW0CydBjZq0lzcJks5mAnYqKKtEX
   3AJZ13sgRgW5VQEaZ2Awi1FE+vMSz1ENrkpJ1Loe/b5g40qHm8Dc8z/Dt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15388863"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15388863"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:54:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11166897"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:53:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/13] selftests/resctrl: Add ->init() callback into resctrl_val_param
Date: Mon, 11 Mar 2024 15:52:25 +0200
Message-Id: <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com>
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
index 241c0b129b58..e79eca9346f3 100644
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
index 0939f86514f7..22c1f5e43352 100644
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
index 17398cd3aace..ffbfcecf9bd6 100644
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
index 2da642e11b61..d9c6443a8524 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -84,7 +84,8 @@ struct resctrl_test {
  * @mongrp:		Name of the monitor group (mon grp)
  * @filename:		Name of file to which the o/p should be written
  * @bw_report:		Bandwidth report type (reads vs writes)
- * @setup:		Call back function to setup test environment
+ * @init:		Callback function to initialize test environment
+ * @setup:		Callback function to setup per test run environment
  * @measure:		Callback that performs the measurement (a single test)
  */
 struct resctrl_val_param {
@@ -95,6 +96,8 @@ struct resctrl_val_param {
 	char		*bw_report;
 	unsigned long	mask;
 	int		num_of_runs;
+	int		(*init)(const struct resctrl_val_param *param,
+				int domain_id);
 	int		(*setup)(const struct resctrl_test *test,
 				 const struct user_params *uparams,
 				 struct resctrl_val_param *param);
@@ -147,8 +150,10 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush);
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


