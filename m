Return-Path: <linux-kselftest+bounces-302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E39907F1180
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D7DB209C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EA2134B0;
	Mon, 20 Nov 2023 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwpP46fr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB3D50;
	Mon, 20 Nov 2023 03:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478907; x=1732014907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wlc1yHtUNg5nZeWynJyWXWslqEGuM8uym9nNHVX6mDs=;
  b=BwpP46frdfqvTAoM9i1jaI2bjRbyn3SlVgNjq99xfYf99eBQt3ApCQX9
   4WjdGxyUKxhoYlKqhPTZb09bVWpcx8OpAspbHyky5+/HTeWxFrHcS1ggK
   oziJG1pbJ8FzcOMQCD2lbrNci542lsM5KlLah7vLDwpJHLI0gftlaxQzo
   EBs+D1jtuUpqKCYZoE/7lbFC+wbbnGWvwS/r0Thx+Z3A0AHxPk9b54lBq
   eGj8T1JpVIhl9GXWWTw4M99upU/S4Wy9ohYCukuAnYoZzm+pHb+8Xfq7R
   j/qqd9O6d7yXK+UnVKfSYFPStLkC8+AyRkzfG1/zuh2s9isu4t9/nXf/Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="477808938"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="477808938"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:15:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="7523257"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:15:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 09/26] selftests/resctrl: Split show_cache_info() to test specific and generic parts
Date: Mon, 20 Nov 2023 13:13:23 +0200
Message-Id: <20231120111340.7805-10-ilpo.jarvinen@linux.intel.com>
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

show_cache_info() calculates results and provides generic cache
information. This makes it hard to alter pass/fail conditions.

Separate the test specific checks into CAT and CMT test files and
leave only the generic information part into show_cache_info().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 42 +++++-----------------
 tools/testing/selftests/resctrl/cat_test.c | 30 ++++++++++++++--
 tools/testing/selftests/resctrl/cmt_test.c | 32 +++++++++++++++--
 tools/testing/selftests/resctrl/resctrl.h  |  6 ++--
 4 files changed, 66 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 129d1c293518..493e0e924123 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -281,43 +281,17 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 }
 
 /*
- * show_cache_info:	show cache test result information
- * @sum_llc_val:	sum of LLC cache result data
- * @no_of_bits:		number of bits
- * @cache_span:		cache span in bytes for CMT or in lines for CAT
- * @max_diff:		max difference
- * @max_diff_percent:	max difference percentage
- * @num_of_runs:	number of runs
- * @platform:		show test information on this platform
- * @cmt:		CMT test or CAT test
- *
- * Return:		0 on success. non-zero on failure.
+ * show_cache_info - Show generic cache test information
+ * @no_of_bits:		Number of bits
+ * @avg_llc_val:	Average of LLC cache result data
+ * @cache_span:		Cache span
+ * @lines:		@cache_span in lines or bytes
  */
-int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
-		    size_t cache_span, unsigned long max_diff,
-		    unsigned long max_diff_percent, unsigned long num_of_runs,
-		    bool platform, bool cmt)
+void show_cache_info(int no_of_bits, unsigned long avg_llc_val,
+		     size_t cache_span, bool lines)
 {
-	unsigned long avg_llc_val = 0;
-	float diff_percent;
-	long avg_diff = 0;
-	int ret;
-
-	avg_llc_val = sum_llc_val / num_of_runs;
-	avg_diff = (long)abs(cache_span - avg_llc_val);
-	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
-
-	ret = platform && abs((int)diff_percent) > max_diff_percent &&
-	      (cmt ? (abs(avg_diff) > max_diff) : true);
-
-	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
-		       ret ? "Fail:" : "Pass:", max_diff_percent);
-
-	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
 	ksft_print_msg("Number of bits: %d\n", no_of_bits);
 	ksft_print_msg("Average LLC val: %lu\n", avg_llc_val);
-	ksft_print_msg("Cache span (%s): %zu\n", cmt ? "bytes" : "lines",
+	ksft_print_msg("Cache span (%s): %zu\n", lines ? "lines" : "bytes",
 		       cache_span);
-
-	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 2c8b37c0a179..2842dff292f0 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -41,6 +41,30 @@ static int cat_setup(struct resctrl_val_param *p)
 	return ret;
 }
 
+static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
+			     unsigned long cache_span, unsigned long max_diff,
+			     unsigned long max_diff_percent, unsigned long num_of_runs,
+			     bool platform)
+{
+	unsigned long avg_llc_val = 0;
+	float diff_percent;
+	int ret;
+
+	avg_llc_val = sum_llc_val / num_of_runs;
+	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
+
+	ret = platform && abs((int)diff_percent) > max_diff_percent;
+
+	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
+		       ret ? "Fail:" : "Pass:", max_diff_percent);
+
+	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
+
+	show_cache_info(no_of_bits, avg_llc_val, cache_span, true);
+
+	return ret;
+}
+
 static int check_results(struct resctrl_val_param *param, size_t span)
 {
 	char *token_array[8], temp[512];
@@ -76,9 +100,9 @@ static int check_results(struct resctrl_val_param *param, size_t span)
 	fclose(fp);
 	no_of_bits = count_bits(param->mask);
 
-	return show_cache_info(sum_llc_perf_miss, no_of_bits, span / 64,
-			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
-			       get_vendor() == ARCH_INTEL, false);
+	return show_results_info(sum_llc_perf_miss, no_of_bits, span / 64,
+				 MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
+				 get_vendor() == ARCH_INTEL);
 }
 
 void cat_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 51cbfc392f66..4573a99d87b5 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -27,6 +27,33 @@ static int cmt_setup(struct resctrl_val_param *p)
 	return 0;
 }
 
+static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
+			     unsigned long cache_span, unsigned long max_diff,
+			     unsigned long max_diff_percent, unsigned long num_of_runs,
+			     bool platform)
+{
+	unsigned long avg_llc_val = 0;
+	float diff_percent;
+	long avg_diff = 0;
+	int ret;
+
+	avg_llc_val = sum_llc_val / num_of_runs;
+	avg_diff = (long)abs(cache_span - avg_llc_val);
+	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
+
+	ret = platform && abs((int)diff_percent) > max_diff_percent &&
+	      abs(avg_diff) > max_diff;
+
+	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
+		       ret ? "Fail:" : "Pass:", max_diff_percent);
+
+	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
+
+	show_cache_info(no_of_bits, avg_llc_val, cache_span, false);
+
+	return ret;
+}
+
 static int check_results(struct resctrl_val_param *param, size_t span, int no_of_bits)
 {
 	char *token_array[8], temp[512];
@@ -58,9 +85,8 @@ static int check_results(struct resctrl_val_param *param, size_t span, int no_of
 	}
 	fclose(fp);
 
-	return show_cache_info(sum_llc_occu_resc, no_of_bits, span,
-			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
-			       true, true);
+	return show_results_info(sum_llc_occu_resc, no_of_bits, span,
+				 MAX_DIFF, MAX_DIFF_PERCENT, runs - 1, true);
 }
 
 void cmt_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index d35e3ba4dfa2..4a05efccab35 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -115,10 +115,8 @@ unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
 int measure_llc_resctrl(const char *filename, int bm_pid);
-int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
-		    size_t cache_span, unsigned long max_diff,
-		    unsigned long max_diff_percent, unsigned long num_of_runs,
-		    bool platform, bool cmt);
+void show_cache_info(int no_of_bits, unsigned long avg_llc_val,
+		     size_t cache_span, bool lines);
 
 /*
  * cache_portion_size - Calculate the size of a cache portion
-- 
2.30.2


