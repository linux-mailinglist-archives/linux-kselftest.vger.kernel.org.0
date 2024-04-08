Return-Path: <linux-kselftest+bounces-7420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9825789C9A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87C5B27E45
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002EA143C4E;
	Mon,  8 Apr 2024 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RE02mwzb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BE143867;
	Mon,  8 Apr 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594071; cv=none; b=lv8/JhKqVEBl7wG1LSRcAWws3vfXPnTP7299P8SSTHMHP4BXTD9+QjZzEuB8qUm1l1WezZbINy7xF5X6U5It7LsvC2qfXfI45l8bJW3TtBHMYSSvRxHgIGyavxn0VMHELwg7Ae0/raEK0lNa9+WWfOWeYG5N7Qj7/77FTthniIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594071; c=relaxed/simple;
	bh=sd+UWMBUD1go7uGvWVLMqLFM6s7Hi1DdydnFYfzCGMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFgnVXfn8o4gmdlNU911z14TenZMf2L7/J3z6jaCOBmwhsdMTw/CyPUI1kcjcRQmDuIoo+OdHiMstyQl9141yhaaxJYOuAMgHTTBzUsmPGAEXnr4SQ7H6blqerKlAZUQecDE9w7jv1TggxUT8vLWL8ve3Oi3oGzq6Yz/dRTGiM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RE02mwzb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594070; x=1744130070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sd+UWMBUD1go7uGvWVLMqLFM6s7Hi1DdydnFYfzCGMs=;
  b=RE02mwzbq8SYXgjYB2woQsVNPSJASMWlJ/MDsjzb2iH6rzIPFKvmd0Um
   laQRu/ZlMTosQA/BE9aghQN8BPnx2SGYACdKSl41U//v61PJvfm8DjeWO
   JOdSN/N/o2UeGNLrQQLAvJXLsVM7yysojad7pY9QVl2Gbxw0Zui2a+d9M
   x+QfZQ4g/IY9d5Xy61dQE/CwsgxMeg/eNKcisPEc9kwjXqYXKp7/qI2V0
   pUeR9h7MaESvdvL86cjA6wfMcuhXpdc7b3YyPfZmMESYnaRLZfVyFjdMD
   uJKE3A2BNGxIbMNw4m3Z/vKUjEvd4afjV29/UCO4Y/1ExMpi2iRCjLbwy
   Q==;
X-CSE-ConnectionGUID: x1sZu1aCQ9aGnG2WRY5OUA==
X-CSE-MsgGUID: 0KJZdj9TR7KOCMToPswh5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7750046"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7750046"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:34:29 -0700
X-CSE-ConnectionGUID: AA8YnXt7S46HRnOtBCkfdg==
X-CSE-MsgGUID: Ynt99UfrQjuGXofDzRROUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="57396648"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:34:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 10/16] selftests/resctrl: Add ->measure() callback to resctrl_val_param
Date: Mon,  8 Apr 2024 19:32:41 +0300
Message-Id: <20240408163247.3224-11-ilpo.jarvinen@linux.intel.com>
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
index 3059ccc51a5a..b88762c4228a 100644
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
index e8e5c0f7f20b..990648bcc366 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -598,8 +598,8 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
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
@@ -851,17 +851,9 @@ int resctrl_val(const struct resctrl_test *test,
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


