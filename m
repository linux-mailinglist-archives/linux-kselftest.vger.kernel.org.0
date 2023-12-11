Return-Path: <linux-kselftest+bounces-1539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C91F80C97E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF621C20CBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534123B1AB;
	Mon, 11 Dec 2023 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuTWMfZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAA019D;
	Mon, 11 Dec 2023 04:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297239; x=1733833239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=drT+E/o/El2vDgHzkkOhJC/bVSBgtgETMlQmtMNfZUY=;
  b=YuTWMfZCQsPvnlQMpEUb2teffQGxE38+JPAwBppW9RgrU00imA8HCL4i
   BGuDumtIptVpVLA7hQDkLfxUXScBos76wWHcu36RMNmPCqK7D4Fy14B6U
   ZniPY3QiVVzi2mHakReE9XgZ0VSuiM9N+CbYxe3yIVn1NHMsnsRPHb8XU
   KAPpRxeiA+DFwoY3Itk2AX1cZtLZ5cxk+OluV2rYGkp9PiTa8nxQRZRmQ
   5S7o4U5MZ33BzCP+EPSZUI3AePnEzRo6TmsNawWptzBz/FjPcaYVyzqZk
   xK71O/4errO7PHRmYuk6yGauT7LH6oK63dCrZjG4TIoFXMbirSpauXuL7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1758015"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1758015"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104461363"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104461363"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 13/29] selftests/resctrl: Remove unnecessary __u64 -> unsigned long conversion
Date: Mon, 11 Dec 2023 14:18:10 +0200
Message-Id: <20231211121826.14392-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Perf counters are __u64 but the code converts them to unsigned long
before printing them out.

Remove unnecessary type conversion and retain the perf originating
value as __u64.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v3:
- Altered changelog and removed "the whole time" wording because
  llc occu results are still unsigned long
---
 tools/testing/selftests/resctrl/cache.c    | 21 ++++++++-------------
 tools/testing/selftests/resctrl/cat_test.c |  8 ++++----
 tools/testing/selftests/resctrl/resctrl.h  |  3 +--
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 32e262fa2a6c..11d1a6ce14c2 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -83,9 +83,8 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
  *
  * Return: =0 on success.  <0 on failure.
  */
-static int get_llc_perf(unsigned long *llc_perf_miss)
+static int get_llc_perf(__u64 *llc_perf_miss)
 {
-	__u64 total_misses;
 	int ret;
 
 	/* Stop counters after one span to get miss rate */
@@ -98,8 +97,7 @@ static int get_llc_perf(unsigned long *llc_perf_miss)
 		return -1;
 	}
 
-	total_misses = rf_cqm.values[0].value;
-	*llc_perf_miss = total_misses;
+	*llc_perf_miss = rf_cqm.values[0].value;
 
 	return 0;
 }
@@ -147,14 +145,12 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
  *
  * Return:		0 on success, < 0 on error.
  */
-static int print_results_cache(const char *filename, int bm_pid,
-			       unsigned long llc_value)
+static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value)
 {
 	FILE *fp;
 
 	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
-		printf("Pid: %d \t LLC_value: %lu\n", bm_pid,
-		       llc_value);
+		printf("Pid: %d \t LLC_value: %llu\n", bm_pid, llc_value);
 	} else {
 		fp = fopen(filename, "a");
 		if (!fp) {
@@ -162,7 +158,7 @@ static int print_results_cache(const char *filename, int bm_pid,
 
 			return -1;
 		}
-		fprintf(fp, "Pid: %d \t llc_value: %lu\n", bm_pid, llc_value);
+		fprintf(fp, "Pid: %d \t llc_value: %llu\n", bm_pid, llc_value);
 		fclose(fp);
 	}
 
@@ -182,7 +178,7 @@ static int print_results_cache(const char *filename, int bm_pid,
  */
 static int perf_event_measure(const char *filename, int bm_pid)
 {
-	unsigned long llc_perf_miss = 0;
+	__u64 llc_perf_miss = 0;
 	int ret;
 
 	ret = get_llc_perf(&llc_perf_miss);
@@ -285,11 +281,10 @@ int cat_val(struct resctrl_val_param *param, size_t span)
  * @cache_span:		Cache span
  * @lines:		@cache_span in lines or bytes
  */
-void show_cache_info(int no_of_bits, unsigned long avg_llc_val,
-		     size_t cache_span, bool lines)
+void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool lines)
 {
 	ksft_print_msg("Number of bits: %d\n", no_of_bits);
-	ksft_print_msg("Average LLC val: %lu\n", avg_llc_val);
+	ksft_print_msg("Average LLC val: %llu\n", avg_llc_val);
 	ksft_print_msg("Cache span (%s): %zu\n", lines ? "lines" : "bytes",
 		       cache_span);
 }
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 0955f819bd83..516eaa08e967 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -41,12 +41,12 @@ static int cat_setup(struct resctrl_val_param *p)
 	return ret;
 }
 
-static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
+static int show_results_info(__u64 sum_llc_val, int no_of_bits,
 			     unsigned long cache_span, unsigned long max_diff,
 			     unsigned long max_diff_percent, unsigned long num_of_runs,
 			     bool platform)
 {
-	unsigned long avg_llc_val = 0;
+	__u64 avg_llc_val = 0;
 	float diff_percent;
 	int ret;
 
@@ -68,8 +68,8 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
 static int check_results(struct resctrl_val_param *param, size_t span)
 {
 	char *token_array[8], temp[512];
-	unsigned long sum_llc_perf_miss = 0;
 	int runs = 0, no_of_bits = 0;
+	__u64 sum_llc_perf_miss = 0;
 	FILE *fp;
 
 	ksft_print_msg("Checking for pass/fail\n");
@@ -93,7 +93,7 @@ static int check_results(struct resctrl_val_param *param, size_t span)
 		 * setup transition phase.
 		 */
 		if (runs > 0)
-			sum_llc_perf_miss += strtoul(token_array[3], NULL, 0);
+			sum_llc_perf_miss += strtoull(token_array[3], NULL, 0);
 		runs++;
 	}
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 4186d61abd33..9aac7b66ada8 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -113,8 +113,7 @@ unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
 int measure_llc_resctrl(const char *filename, int bm_pid);
-void show_cache_info(int no_of_bits, unsigned long avg_llc_val,
-		     size_t cache_span, bool lines);
+void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool lines);
 
 /*
  * cache_portion_size - Calculate the size of a cache portion
-- 
2.30.2


