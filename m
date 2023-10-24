Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BC7D4C6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjJXJb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjJXJ2e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:28:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5564C198B;
        Tue, 24 Oct 2023 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139685; x=1729675685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xQ4Iamz+/JmjBX3VE4Wk06Rysb+pZgl6ZLrtubjENSo=;
  b=cEDWO9Wq6P+6UOptHf4mtm620h3vYsQOXc8JiHv+G4Q8iW+1k6yCVmdh
   dK/sW7vJyr36LhHC+7YHL2hcG6JAdnw3PqE1ZTamHWyKw/qZFuMCS57I3
   Vv7KF03slkuwO/1DikChzA7Os5AYPV874DE6/N1WbTD+bwuCCIwggYGJu
   BMM9M5w5CtVMzK18sULRcdRcKGiA7JWQlnnF5y1fSbZlncp/s1OxzHVUY
   uoOMwQbit90KxJd4hvViCohWcU3zIj36Sgn/n0VzotcwtUPZI/afDWLku
   KTdYeKklUOieN2d3CY1FAi9K5t2VIgEN933c93e8FYUuz6lN2qXZFGdoo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="451251781"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="451251781"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1089785972"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1089785972"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:00 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/24] selftests/resctrl: Remove unnecessary __u64 -> unsigned long conversion
Date:   Tue, 24 Oct 2023 12:26:19 +0300
Message-Id: <20231024092634.7122-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Perf counters are __u64 but the code converts them to unsigned long
before printing them out.

Remove unnecessary type conversion and the potential loss of meaningful
bits due to different sizes of types.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 21 ++++++++-------------
 tools/testing/selftests/resctrl/cat_test.c |  8 ++++----
 tools/testing/selftests/resctrl/resctrl.h  |  3 +--
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 95489d4b42b7..d39ef4eebc37 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -84,9 +84,8 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
  *
  * Return: =0 on success.  <0 on failure.
  */
-static int get_llc_perf(unsigned long *llc_perf_miss)
+static int get_llc_perf(__u64 *llc_perf_miss)
 {
-	__u64 total_misses;
 	int ret;
 
 	/* Stop counters after one span to get miss rate */
@@ -99,8 +98,7 @@ static int get_llc_perf(unsigned long *llc_perf_miss)
 		return -1;
 	}
 
-	total_misses = rf_cqm.values[0].value;
-	*llc_perf_miss = total_misses;
+	*llc_perf_miss = rf_cqm.values[0].value;
 
 	return 0;
 }
@@ -148,14 +146,12 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
  *
  * Return:		0 on success. non-zero on failure.
  */
-static int print_results_cache(char *filename, int bm_pid,
-			       unsigned long llc_value)
+static int print_results_cache(char *filename, int bm_pid, __u64 llc_value)
 {
 	FILE *fp;
 
 	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
-		printf("Pid: %d \t LLC_value: %lu\n", bm_pid,
-		       llc_value);
+		printf("Pid: %d \t LLC_value: %llu\n", bm_pid, llc_value);
 	} else {
 		fp = fopen(filename, "a");
 		if (!fp) {
@@ -163,7 +159,7 @@ static int print_results_cache(char *filename, int bm_pid,
 
 			return errno;
 		}
-		fprintf(fp, "Pid: %d \t llc_value: %lu\n", bm_pid, llc_value);
+		fprintf(fp, "Pid: %d \t llc_value: %llu\n", bm_pid, llc_value);
 		fclose(fp);
 	}
 
@@ -172,7 +168,7 @@ static int print_results_cache(char *filename, int bm_pid,
 
 static int measure_llc_perf(struct resctrl_val_param *param, int bm_pid)
 {
-	unsigned long llc_perf_miss = 0;
+	__u64 llc_perf_miss = 0;
 	int ret;
 
 	/*
@@ -273,11 +269,10 @@ int cat_val(struct resctrl_val_param *param, size_t span)
  * @cache_span:		cache span
  * @lines:		cache span in lines or bytes
  */
-void show_cache_info(int no_of_bits, unsigned long avg_llc_val,
-		     size_t cache_span, bool lines)
+void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool lines)
 {
 	ksft_print_msg("Number of bits: %d\n", no_of_bits);
-	ksft_print_msg("Average LLC val: %lu\n", avg_llc_val);
+	ksft_print_msg("Average LLC val: %llu\n", avg_llc_val);
 	ksft_print_msg("Cache span (%s): %zu\n", !lines ? "bytes" : "lines",
 		       cache_span);
 }
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 32f6d612a3e7..2106cc3601d9 100644
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
 
@@ -68,7 +68,7 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
 static int check_results(struct resctrl_val_param *param, size_t span)
 {
 	char *token_array[8], temp[512];
-	unsigned long sum_llc_perf_miss = 0;
+	__u64 sum_llc_perf_miss = 0;
 	int runs = 0, no_of_bits = 0;
 	FILE *fp;
 
@@ -93,7 +93,7 @@ static int check_results(struct resctrl_val_param *param, size_t span)
 		 * setup transition phase.
 		 */
 		if (runs > 0)
-			sum_llc_perf_miss += strtoul(token_array[3], NULL, 0);
+			sum_llc_perf_miss += strtoull(token_array[3], NULL, 0);
 		runs++;
 	}
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index c7655714b23f..033c49784581 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -115,8 +115,7 @@ unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
 int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid);
-void show_cache_info(int no_of_bits, unsigned long avg_llc_val,
-		     size_t cache_span, bool lines);
+void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool lines);
 
 /*
  * cache_size - Calculate the size of a cache portion
-- 
2.30.2

