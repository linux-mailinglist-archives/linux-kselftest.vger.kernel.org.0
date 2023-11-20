Return-Path: <linux-kselftest+bounces-301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65787F117D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A567281997
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F9913AC9;
	Mon, 20 Nov 2023 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goHGwo8o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA50E8;
	Mon, 20 Nov 2023 03:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478899; x=1732014899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qJR3Yh1PCea2cKAo8n0ASNwzadHfHGi8AqwYXStWT1o=;
  b=goHGwo8oyJbPpNVFLIit4A8frys/wFErYMjByfgDNKMXb0rvutavFEfL
   260alfSJJPIJfxxMzmgQIZegLF1kmhC14meZtCBK08iOdmsPrY4995npp
   aXMwvCRQfVnKmRPCEr3kO8gFIlDlQtyj53fmS1eaHGQZYvZZQ2am6ci8Q
   92EuyvwkOu4dvTF2VY6WD4cFqI7iNfmOy2rVfRifpj0PZBBk17qBeIUJ8
   6iIoFo7wOe8dAanwu0zSSNhpXHq76fYAbsN3HscITfNTMTqcK1SxU26cH
   wcxZVSOrCGwwVpcRb6OnWvsVaHyVYcpDwyxrTyz3rQFKQq8RXrQQBy7xq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="477808916"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="477808916"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="7523246"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/26] selftests/resctrl: Split measure_cache_vals()
Date: Mon, 20 Nov 2023 13:13:22 +0200
Message-Id: <20231120111340.7805-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

measure_cache_vals() does a different thing depending on the test case
that called it:
  - For CAT, it measures LLC misses through perf.
  - For CMT, it measures LLC occupancy through resctrl.

Split these two functionalities into own functions the CAT and CMT
tests can call directly. Replace passing the struct resctrl_val_param
parameter with the filename because it's more generic and all those
functions need out of resctrl_val.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c       | 66 ++++++++++++-------
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 8aa6d67db978..129d1c293518 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -147,7 +147,7 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
  *
  * Return:		0 on success. non-zero on failure.
  */
-static int print_results_cache(char *filename, int bm_pid,
+static int print_results_cache(const char *filename, int bm_pid,
 			       unsigned long llc_value)
 {
 	FILE *fp;
@@ -169,35 +169,51 @@ static int print_results_cache(char *filename, int bm_pid,
 	return 0;
 }
 
-int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
+/*
+ * perf_event_measure - Measure perf events
+ * @filename:	Filename for writing the results
+ * @bm_pid:	PID that runs the benchmark
+ *
+ * Measures perf events (e.g., cache misses) and writes the results into
+ * @filename. @bm_pid is written to the results file along with the measured
+ * value.
+ *
+ * Return: =0 on success. <0 on failure.
+ */
+static int perf_event_measure(const char *filename, int bm_pid)
 {
-	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
+	unsigned long llc_perf_miss = 0;
 	int ret;
 
-	/*
-	 * Measure cache miss from perf.
-	 */
-	if (!strncmp(param->resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-		ret = get_llc_perf(&llc_perf_miss);
-		if (ret < 0)
-			return ret;
-		llc_value = llc_perf_miss;
-	}
+	ret = get_llc_perf(&llc_perf_miss);
+	if (ret < 0)
+		return ret;
 
-	/*
-	 * Measure llc occupancy from resctrl.
-	 */
-	if (!strncmp(param->resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-		ret = get_llc_occu_resctrl(&llc_occu_resc);
-		if (ret < 0)
-			return ret;
-		llc_value = llc_occu_resc;
-	}
-	ret = print_results_cache(param->filename, bm_pid, llc_value);
-	if (ret)
+	ret = print_results_cache(filename, bm_pid, llc_perf_miss);
+	return ret;
+}
+
+/*
+ * measure_llc_resctrl - Measure resctrl llc value from resctrl
+ * @filename:	Filename for writing the results
+ * @bm_pid:	PID that runs the benchmark
+ *
+ * Measures llc occupancy from resctrl and writes the results into @filename.
+ * @bm_pid is written to the results file along with the measured value.
+ *
+ * Return: =0 on success. <0 on failure.
+ */
+int measure_llc_resctrl(const char *filename, int bm_pid)
+{
+	unsigned long llc_occu_resc = 0;
+	int ret;
+
+	ret = get_llc_occu_resctrl(&llc_occu_resc);
+	if (ret < 0)
 		return ret;
 
-	return 0;
+	ret = print_results_cache(filename, bm_pid, llc_occu_resc);
+	return ret;
 }
 
 /*
@@ -252,7 +268,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 		}
 
 		sleep(1);
-		ret = measure_cache_vals(param, bm_pid);
+		ret = perf_event_measure(param->filename, bm_pid);
 		if (ret)
 			goto pe_close;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index a911b08fa595..d35e3ba4dfa2 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -114,7 +114,7 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
-int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
+int measure_llc_resctrl(const char *filename, int bm_pid);
 int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 		    size_t cache_span, unsigned long max_diff,
 		    unsigned long max_diff_percent, unsigned long num_of_runs,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 88789678917b..a07ba336db48 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -830,7 +830,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
 			sleep(1);
-			ret = measure_cache_vals(param, bm_pid);
+			ret = measure_llc_resctrl(param->filename, bm_pid);
 			if (ret)
 				break;
 		}
-- 
2.30.2


