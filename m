Return-Path: <linux-kselftest+bounces-11009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 278418D6299
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA14B25706
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31193158DC3;
	Fri, 31 May 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8pScpBt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA652158DCA;
	Fri, 31 May 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161202; cv=none; b=ZITkJP/LUqiCvxDG/m0FL6MBhNffn8WTRyFHYYyrHshOX5/dzVejTzgQJtj6RcKytxDO6dYYFdmXYf0uo74PS6gsK14yBT+E+NFohDDFAgTQRI9BjHOTUJUn2eM4nVZNxBSNmtwC9k9Racx57LjKAXGVMl73qjW1UV82G2DQVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161202; c=relaxed/simple;
	bh=Bj8S4m0XKFOIwuWxInocQ1PvbOtBSv2Cq2AJMnftcp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ET5kBN4rM9R1mK4EqtYlFoZ3uq8vCtbeQinnqQcjiMCSMCIl/OPYj2Hb29TiXNx8GhqLA28hmYyYjiQIVMRn4Pv+CuiR9vjoG8DSCAL3+9zKINksdzejSqEaYmKUkLotgEUKAjrk/k8MPEv7zkUymJjzFKtGhu1WLrRmzZ9LH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8pScpBt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161201; x=1748697201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bj8S4m0XKFOIwuWxInocQ1PvbOtBSv2Cq2AJMnftcp0=;
  b=F8pScpBtjwqkLkEH1KHx4OocCbBLPm5iH2df8M/7Cn2QPCzZ0TJctgMW
   F0wxFqkLhLcsZIFnfux6anwY++aR5qAp8/oZTuZ++NJc5LrgPN8jVsCP5
   gLemCqbrLOjtTzTtfa26B67Ht2nM7q/wNtnPbRbymuO7jPKRWQcg+c3HD
   XGBYjR5oDcsXuaA1pIQAFl9rez8AlA4uLiH3u2ohWAElVl88TSToAyCZE
   rFLuSqXFnZx6NDPk3t+fICSNAn2E+pK6QXHneCQZ31OKo3zXeofviMPEp
   AIGIUOASdYWjW2jcjGMlppjHhjzFb145qkoosYWSofzqUS785JCxhVD8L
   w==;
X-CSE-ConnectionGUID: nVKOkH04QO2dNPtX7USjrg==
X-CSE-MsgGUID: mSiHcNz7T6+r8s+uDqYJGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24263295"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24263295"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:13:21 -0700
X-CSE-ConnectionGUID: KaXS+NlMTOODJMLiE1PJLw==
X-CSE-MsgGUID: iLHmKAoTTWeuyx4vDusWzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36098272"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:13:17 -0700
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
Subject: [PATCH v5 09/16] selftests/resctrl: Add ->measure() callback to resctrl_val_param
Date: Fri, 31 May 2024 16:11:35 +0300
Message-Id: <20240531131142.1716-10-ilpo.jarvinen@linux.intel.com>
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

The measurement done in resctrl_val() varies depending on test type.
The decision for how to measure is decided based on the string compare
to test name which is quite inflexible.

Add ->measure() callback into the struct resctrl_val_param to allow
each test to provide necessary code as a function which simplifies what
resctrl_val() has to do.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
index 2a10b50c9e2a..47d58c9aed28 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -607,8 +607,8 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
  * @param:		Parameters passed to resctrl_val()
  * @bm_pid:		PID that runs the benchmark
  */
-static int measure_mem_bw(const struct user_params *uparams,
-			  struct resctrl_val_param *param, pid_t bm_pid)
+int measure_mem_bw(const struct user_params *uparams,
+		   struct resctrl_val_param *param, pid_t bm_pid)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	FILE *mem_bw_fp;
@@ -873,17 +873,9 @@ int resctrl_val(const struct resctrl_test *test,
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


