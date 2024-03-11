Return-Path: <linux-kselftest+bounces-6195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB0878101
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB391C224D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E6A3FB39;
	Mon, 11 Mar 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEpQ0zy6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB664174A;
	Mon, 11 Mar 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165236; cv=none; b=KKsQWQG1ssWyK9C8rC1m4aNgHpobXsQPdjHSWFVCxJaJrkbuBXxodhDjxwB0KbrlGvnEmGDOPQ5IhiIVF8fBLes5jyhWdxJ/gkfQP6swYjQ55TeBXrclfjP/ssZLvB5nyipcxAX+aP2BXjPt7+EKiIAaKhQIG/oVdtsF20pNV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165236; c=relaxed/simple;
	bh=6hINeLfkgFWE94mLII8XIbT1s+jkdRdKz9vHyDRpLCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUrGR68nFGALEf43XUv7py7FMchjJK0UejyHhXV7X5TLXB/2C4Tsx+cPOYez/LPwt+FLrPoDJzSxRPFsKYmSfD584ubiq80VVL/GDBnOVzr3RNNFXllbgKi1FHZmgMW0tO1u9+2uKv2qfxcxNniSbEl2PJ7TogC2zSBcUUdrZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEpQ0zy6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165235; x=1741701235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6hINeLfkgFWE94mLII8XIbT1s+jkdRdKz9vHyDRpLCM=;
  b=VEpQ0zy6MCYc5bJ/gvY9+Juwg7ecqgRQyaaEpc+l+DTIkM0YFjDge17A
   iRteWicm4vOrEl3Zq7kf/APVdY6eSZQ2KvOZUpQTHyBYjG/JeoefCmRFz
   +pvI99ljFOqHZ5HYQx1/NlWIuSDtJzY9pBuUOoU/dfn/LqB/jhz0eZr5Y
   9m8AUy/74UBj4fCAHjx6Tzft0KNid0Ofnj6DmmqsSu44fapMKe1xFEmNl
   ovNxuXXOtjKsPHLKIUAVNH+QbPmDwkAy7WWHrfmCX4MbUCSo7mW7KSBJj
   emO/BhWqgebm79p7RABO7Kkeb5khG15WfI5Idol8a1NXQHAa760Syiewt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15388847"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15388847"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15814495"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:53:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 07/13] selftests/resctrl: Add ->measure() callback to resctrl_val_param
Date: Mon, 11 Mar 2024 15:52:24 +0200
Message-Id: <20240311135230.7007-8-ilpo.jarvinen@linux.intel.com>
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

The measurement done in resctrl_val() varies depending on test type.
The decision for how to measure is decided based on the string compare
to test name which is quite inflexible.

Add ->measure() callback into the struct resctrl_val_param to allow
each test to provide necessary code as a function which simplifies what
resctrl_val() has to do.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- spaces -> tabs
---
 tools/testing/selftests/resctrl/cmt_test.c    |  8 ++++++++
 tools/testing/selftests/resctrl/mba_test.c    |  9 ++++++++-
 tools/testing/selftests/resctrl/mbm_test.c    |  9 ++++++++-
 tools/testing/selftests/resctrl/resctrl.h     |  6 ++++++
 tools/testing/selftests/resctrl/resctrl_val.c | 18 +++++-------------
 5 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a81f91222a89..241c0b129b58 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -29,6 +29,13 @@ static int cmt_setup(const struct resctrl_test *test,
 	return 0;
 }
 
+static int cmt_measure(const struct user_params *uparams,
+		       struct resctrl_val_param *param, pid_t bm_pid)
+{
+	sleep(1);
+	return measure_llc_resctrl(param->filename, bm_pid);
+}
+
 static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
 			     unsigned long cache_span, unsigned long max_diff,
 			     unsigned long max_diff_percent, unsigned long num_of_runs,
@@ -133,6 +140,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 		.mask		= ~(long_mask << n) & long_mask,
 		.num_of_runs	= 0,
 		.setup		= cmt_setup,
+		.measure	= cmt_measure,
 	};
 
 	span = cache_portion_size(cache_total_size, param.mask, long_mask);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7946e32e85c8..0939f86514f7 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -51,6 +51,12 @@ static int mba_setup(const struct resctrl_test *test,
 	return 0;
 }
 
+static int mba_measure(const struct user_params *uparams,
+		       struct resctrl_val_param *param, pid_t bm_pid)
+{
+	return measure_mem_bw(uparams, param, bm_pid);
+}
+
 static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 {
 	int allocation, runs;
@@ -150,7 +156,8 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
-		.setup		= mba_setup
+		.setup		= mba_setup,
+		.measure	= mba_measure,
 	};
 	int ret;
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d67ffa3ec63a..17398cd3aace 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -105,6 +105,12 @@ static int mbm_setup(const struct resctrl_test *test,
 	return ret;
 }
 
+static int mbm_measure(const struct user_params *uparams,
+		       struct resctrl_val_param *param, pid_t bm_pid)
+{
+	return measure_mem_bw(uparams, param, bm_pid);
+}
+
 void mbm_test_cleanup(void)
 {
 	remove(RESULT_FILE_NAME);
@@ -118,7 +124,8 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
-		.setup		= mbm_setup
+		.setup		= mbm_setup,
+		.measure	= mbm_measure,
 	};
 	int ret;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 90fc00a61d72..2da642e11b61 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -85,6 +85,7 @@ struct resctrl_test {
  * @filename:		Name of file to which the o/p should be written
  * @bw_report:		Bandwidth report type (reads vs writes)
  * @setup:		Call back function to setup test environment
+ * @measure:		Callback that performs the measurement (a single test)
  */
 struct resctrl_val_param {
 	char		*resctrl_val;
@@ -97,6 +98,9 @@ struct resctrl_val_param {
 	int		(*setup)(const struct resctrl_test *test,
 				 const struct user_params *uparams,
 				 struct resctrl_val_param *param);
+	int		(*measure)(const struct user_params *uparams,
+				   struct resctrl_val_param *param,
+				   pid_t bm_pid);
 };
 
 struct perf_event_read {
@@ -143,6 +147,8 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
+int measure_mem_bw(const struct user_params *uparams,
+		   struct resctrl_val_param *param, pid_t bm_pid);
 int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
 		const char * const *benchmark_cmd,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 80e5174df828..13d89d24474e 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -616,8 +616,8 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
  * @param:		parameters passed to resctrl_val()
  * @bm_pid:		PID that runs the benchmark
  */
-static int measure_mem_bw(const struct user_params *uparams,
-			  struct resctrl_val_param *param, pid_t bm_pid)
+int measure_mem_bw(const struct user_params *uparams,
+		   struct resctrl_val_param *param, pid_t bm_pid)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	float bw_imc;
@@ -870,17 +870,9 @@ int resctrl_val(const struct resctrl_test *test,
 		if (ret < 0)
 			break;
 
-		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
-		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_mem_bw(uparams, param, bm_pid);
-			if (ret)
-				break;
-		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-			sleep(1);
-			ret = measure_llc_resctrl(param->filename, bm_pid);
-			if (ret)
-				break;
-		}
+		ret = param->measure(uparams, param, bm_pid);
+		if (ret)
+			break;
 	}
 
 out:
-- 
2.39.2


