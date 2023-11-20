Return-Path: <linux-kselftest+bounces-306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706077F118A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF4F281DBA
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48213AFA;
	Mon, 20 Nov 2023 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQX+PiQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B65D119;
	Mon, 20 Nov 2023 03:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478931; x=1732014931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfMJCb5YpSuuahqqeQzJDceet+atUjOdl8ZAzSVu4hQ=;
  b=RQX+PiQwWwqY01WIn/sgnsTlBzm+jsaJio7K7LCDQbJvuiIyiwfRhpMS
   zA6ICHNdDPmEqeonRY7CMGRUIY+H7ef1XNDvgtwFe+Vn4AXzssbHEoxQz
   +JzvVM90PSzhO+KDg7V2HZIjjdz981GgVJqGhj/51w5ynSnPaGLo9wlPX
   MZbEbX03wOGdv2WArxUqcA86bbkPDHt4vcmmJfqlEdOnEH3isKqfplQ6/
   at7hYf8PhRzZm00yOAALyH6pfwzBGHHsu4WZm0jL96WeCPhM7zDzIyKx6
   2bBbw1r8CGX76ens5y8uMdkA0FZxUXKJ20/LWvjM3yDRjEvdC4a0Edlkq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="477808965"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="477808965"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:15:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="7523272"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:15:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 10/26] selftests/resctrl: Remove unnecessary __u64 -> unsigned long conversion
Date: Mon, 20 Nov 2023 13:13:24 +0200
Message-Id: <20231120111340.7805-11-ilpo.jarvinen@linux.intel.com>
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

Perf counters are __u64 but the code converts them to unsigned long
before printing them out.

Remove unnecessary type conversion and retain the value as __u64 whole
the time.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 21 ++++++++-------------
 tools/testing/selftests/resctrl/cat_test.c |  8 ++++----
 tools/testing/selftests/resctrl/resctrl.h  |  3 +--
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 493e0e924123..6a754ea376c9 100644
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
  * Return:		0 on success. non-zero on failure.
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
 
 			return errno;
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
@@ -287,11 +283,10 @@ int cat_val(struct resctrl_val_param *param, size_t span)
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
index 2842dff292f0..ca2dd46ec733 100644
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
index 4a05efccab35..e5a7b02a6a54 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -115,8 +115,7 @@ unsigned int count_bits(unsigned long n);
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


