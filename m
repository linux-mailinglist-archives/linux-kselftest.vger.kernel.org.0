Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B224D7D4C3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjJXJ3E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjJXJ2c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:28:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C726E173C;
        Tue, 24 Oct 2023 02:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139682; x=1729675682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zx+TTV+xgsnirHp9g41dGRTJTzQ2ajkH0rygD6gjLLQ=;
  b=CUdQfvRX2X/hItp7G/jF7owiQcQKb96rCkatcicBTFVAtxypO4I7Pk/J
   QR7xqImYymBHIwjLFjbiPk2MmYvJjgHdZ4Xm/XFG/DIc/vj67/pseSIK7
   c/s91MfSFMTx9C7rqejc3G4JjjDxArpv0xbEGnyK1uhEWSDwrrL2mCwdY
   BKFwGlxt9l3miUoziXWeR6Bw6CtLh5GicGT6ZaSsffy6pguIU697jCiM3
   aWP9HDgl4xgyFuy+NGK5MS7Qa9+X1GYfbjvbH8ou9VwmZTxa1V3x8qYVa
   cFp0Yg0sceRCZo8C7HM9ZgJf43YXP3cDJfwRCLDrU1bjGYSPJCNYHYgTc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8570184"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="8570184"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6112288"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:26:35 -0700
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
Subject: [PATCH 08/24] selftests/resctrl: Split show_cache_info() to test specific and generic parts
Date:   Tue, 24 Oct 2023 12:26:18 +0300
Message-Id: <20231024092634.7122-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

show_cache_info() calculates results and provides generic cache
information. This makes it hard to alter pass/fail conditions.

Separate the test specific checks into CAT and CMT test files and
leave only the generic information part into show_cache_info().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 40 ++++------------------
 tools/testing/selftests/resctrl/cat_test.c | 30 ++++++++++++++--
 tools/testing/selftests/resctrl/cmt_test.c | 32 +++++++++++++++--
 tools/testing/selftests/resctrl/resctrl.h  |  6 ++--
 4 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 299d9508221f..95489d4b42b7 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -267,43 +267,17 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 }
 
 /*
- * show_cache_info:	show cache test result information
- * @sum_llc_val:	sum of LLC cache result data
+ * show_cache_info:	show generic cache test information
  * @no_of_bits:		number of bits
- * @cache_span:		cache span in bytes for CMT or in lines for CAT
- * @max_diff:		max difference
- * @max_diff_percent:	max difference percentage
- * @num_of_runs:	number of runs
- * @platform:		show test information on this platform
- * @cmt:		CMT test or CAT test
- *
- * Return:		0 on success. non-zero on failure.
+ * @avg_llc_val:	avg of LLC cache result data
+ * @cache_span:		cache span
+ * @lines:		cache span in lines or bytes
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
+	ksft_print_msg("Cache span (%s): %zu\n", !lines ? "bytes" : "lines",
 		       cache_span);
-
-	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index e5861e7cba7e..32f6d612a3e7 100644
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
index e8997ff5bc04..702ea87cd473 100644
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
index 56afdc190727..c7655714b23f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -115,10 +115,8 @@ unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
 int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid);
-int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
-		    size_t cache_span, unsigned long max_diff,
-		    unsigned long max_diff_percent, unsigned long num_of_runs,
-		    bool platform, bool cmt);
+void show_cache_info(int no_of_bits, unsigned long avg_llc_val,
+		     size_t cache_span, bool lines);
 
 /*
  * cache_size - Calculate the size of a cache portion
-- 
2.30.2

