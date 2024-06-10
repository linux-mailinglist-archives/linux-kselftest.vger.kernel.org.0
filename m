Return-Path: <linux-kselftest+bounces-11566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCADA90255F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5B3B26DAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52E142E7B;
	Mon, 10 Jun 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ucs0IFwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AEE13FD96;
	Mon, 10 Jun 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032591; cv=none; b=N96OgAQrkJdBu7LMaa1pHl70hQkqpfDYS0H//S/FVKuyjVrZj7sXNRk2oDuWyTjRoxA8KKdUSOu8uI480ClCb7KhuIjkRAdaI9RPmoMbzbaKEPh7DxkVqrLs9x5JPSBlWcJbbUFQFb0EHua+N0aP/Gw7Z6V215EGmuk5Ikw6CM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032591; c=relaxed/simple;
	bh=m5t8MxJ+I7n35w2ToGl4YgrZ29fG4mtxJkBP0WBT/wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbPGqVxJKMVwG5AFR+XyQMOqJtM+jurm3ug5yANTlh2UtO3cnh3mSHSjd7wBGoKo5IpW0QLBlvoLI8Y6MCkEN//9GeZImkFxLqPWeoNQMVqiF7OtTD8jvJfItOIxztiRQ1LW7WzNAH6ctrbu/rskc7dtYhnyOE3B5Z6q3iigZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ucs0IFwO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718032590; x=1749568590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m5t8MxJ+I7n35w2ToGl4YgrZ29fG4mtxJkBP0WBT/wQ=;
  b=Ucs0IFwOr2XIbEXywym9NNf32AWxsVA5np+dfxKt+o9gpTkCvNgnXJLa
   ro4OSxrCpe3lDgviZOJ4+wIy0gop9YF839ejyN80f91knj5eI0icXM/1x
   BbQWRqxk3VF80nkUxgq8QkrZHRsAzvSaalY8QAXSrtmhUsIf1lnNWkxp+
   zC3VTdA+d0FefbOIfxNbuK0X76nXjeUytF8pG0KECXnmeHPJSqQJC6siJ
   N83/352BeYba/JP9N+Xb7hvkRnhJLKH81mYMSF0+HLD47GmvzKRFlFxLm
   vcbHRa6hh3A7WdVhO4wsZwnqqqGPggfgugOKPhwNPveg3DBgdZ169PKGd
   A==;
X-CSE-ConnectionGUID: tJQIcZ1ZTzSXj0Acg1VNNg==
X-CSE-MsgGUID: t2ByfhZ6Rkyib1ZIQmnyoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25807797"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="25807797"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:16:30 -0700
X-CSE-ConnectionGUID: sCqeE4L0ScWRx1Layv2qwg==
X-CSE-MsgGUID: FbioOfdQTNyTgXty8FV1Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39016959"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:16:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 09/16] selftests/resctrl: Add ->measure() callback to resctrl_val_param
Date: Mon, 10 Jun 2024 18:14:50 +0300
Message-Id: <20240610151457.7305-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
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
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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
index a44e6fcd37b7..d8521386cd18 100644
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
index 5d6af9e8afed..de6e29faf214 100644
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
index 96d279b06377..59e26adf60bb 100644
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
 static void mbm_test_cleanup(void)
 {
 	remove(RESULT_FILE_NAME);
@@ -117,7 +123,8 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.ctrlgrp	= "c1",
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
-		.setup		= mbm_setup
+		.setup		= mbm_setup,
+		.measure	= mbm_measure,
 	};
 	int ret;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index e4b6dc672ecc..5dc3def70669 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -87,6 +87,7 @@ struct resctrl_test {
  * @filename:		Name of file to which the o/p should be written
  * @bw_report:		Bandwidth report type (reads vs writes)
  * @setup:		Call back function to setup test environment
+ * @measure:		Callback that performs the measurement (a single test)
  */
 struct resctrl_val_param {
 	char		*resctrl_val;
@@ -99,6 +100,9 @@ struct resctrl_val_param {
 	int		(*setup)(const struct resctrl_test *test,
 				 const struct user_params *uparams,
 				 struct resctrl_val_param *param);
+	int		(*measure)(const struct user_params *uparams,
+				   struct resctrl_val_param *param,
+				   pid_t bm_pid);
 };
 
 struct perf_event_read {
@@ -145,6 +149,8 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
+int measure_mem_bw(const struct user_params *uparams,
+		   struct resctrl_val_param *param, pid_t bm_pid);
 int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
 		const char * const *benchmark_cmd,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 277c13b7a4c5..590fc74cb88f 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -606,8 +606,8 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
  * available. Compare the two values to validate resctrl value. It takes
  * 1 sec to measure the data.
  */
-static int measure_mem_bw(const struct user_params *uparams,
-			  struct resctrl_val_param *param, pid_t bm_pid)
+int measure_mem_bw(const struct user_params *uparams,
+		   struct resctrl_val_param *param, pid_t bm_pid)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	FILE *mem_bw_fp;
@@ -868,17 +868,9 @@ int resctrl_val(const struct resctrl_test *test,
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


