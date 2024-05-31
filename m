Return-Path: <linux-kselftest+bounces-11010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333378D629B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D701F27B0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B59159564;
	Fri, 31 May 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGpDQALo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63F158A02;
	Fri, 31 May 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161214; cv=none; b=BkaKIjSdagH5hL9x6UZFr5XI34zAXvF7bJOX+AsCc4fDqmgl/9g/zXaQuHIq9D9dxRdFVCD+XGhDnLCXOSze2KgzLEnYDJYVtj9Dr7z3d5KXIjDSOktm6Wp9s9mtCFp9Ek8FygT+T7HXPO1/MfVnxp2zNokWOPVZLFYNPd9DQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161214; c=relaxed/simple;
	bh=cHWV8Uiq61pkFoHnE66/c199y6NcZbmjb30YfLy+umA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMnpBW4xEr442DO/TISUi1FtuBc2q3CQYs3anKWZPRS7csbKFUIyJMQt/HUB1zy4WLVYZSsDxK0rELoppxPvzrZI4VBXuDPsagxyHbWhx/2eXJhnRzq4toH5PZwzMBV1DCltDMbVEXmIttr591ZTegSACuJf3SUB6PMyWJF0dIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGpDQALo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161213; x=1748697213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cHWV8Uiq61pkFoHnE66/c199y6NcZbmjb30YfLy+umA=;
  b=CGpDQALoklci4bxyQw68drTCHcQMIBb3HOLmykXAtW7wabBV11U4FD67
   OSU4rR4hmkaIT5JwAlQraT7+jt1qCLlSqqIh208qURQa3iUnTM5yYl+WP
   cUmMkukIs5efaW4cMAZEGcoEyIsSV7wfPMhRs/aZEtR5gtNgxRjV0C59o
   Jc7rSzeYquS5k9ZH6Zj8OLdVPb4jAJYwxwc9+2SGadZuR/ROmJht/tMJ7
   UlszpSD7Jt0qzFxc9B5nHIGFJdA5mrbgQsSKD+mo4BuIko3OuLdKHP7sA
   Xr3SjWNyQPXhFw9B2ucVnocYtvANDgMuOc3R2rp6337jkw1lqlKS4uyaH
   w==;
X-CSE-ConnectionGUID: eo44LSNpQ9uUM1aqT4OBRQ==
X-CSE-MsgGUID: T2mkkbmvRlmqRqK0IQhM0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24263302"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24263302"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:13:31 -0700
X-CSE-ConnectionGUID: e65rre7LTaqbr5kWd36P8Q==
X-CSE-MsgGUID: gmkqCxvxTAagb8AnPNsoaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36098314"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:13:28 -0700
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
Subject: [PATCH v5 10/16] selftests/resctrl: Add ->init() callback into resctrl_val_param
Date: Fri, 31 May 2024 16:11:36 +0300
Message-Id: <20240531131142.1716-11-ilpo.jarvinen@linux.intel.com>
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
index 47d58c9aed28..164f57454cb0 100644
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
 
@@ -430,24 +418,18 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
 
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
@@ -460,6 +442,9 @@ static FILE *open_mem_bw_resctrl(const char *mbm_bw_file)
 	return fp;
 }
 
+/*
+ * Get MBM Local bytes as reported by resctrl FS
+ */
 static int get_mem_bw_resctrl(FILE *fp, unsigned long *mbm_total)
 {
 	if (fscanf(fp, "%lu\n", mbm_total) <= 0) {
@@ -572,35 +557,6 @@ static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
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
@@ -830,16 +786,11 @@ int resctrl_val(const struct resctrl_test *test,
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


