Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A186DF720
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDLNZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjDLNY5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:24:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADF8AD0C;
        Wed, 12 Apr 2023 06:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305872; x=1712841872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6fPERw8xx2Xr/bpeJtD31KQUvwWb31+w7KcyfDbeq3w=;
  b=KfwhK0iJrDd6vpWr5nn9lA6m8r0E7ZDSsogWCG8H1Yt8OMZWAUBdQjZs
   eBe/8aFZ6IR03IVNZhmG/XN625KzVubU1Bcl5pHy3+CtNka8vD4L/9mdM
   1NfhA3RNGD/YwbzdFOB297KpNf0JQH7p+VIv0G5vaSrfqgdabmREZvbUu
   Nppkz/ZeEtmCwsHcbleK+aW4QOn9ZasRmfuinV619Oma1GJcGMDWftSBp
   soLg2OwsJq5KKt9lya20jr6j0mz4FhVQDno0qH6AXoHIgl5KzaOeburYs
   ZUDBi85vj6zp+MyJiejuNyJGnUkEKiSUR3WLLL19jqaZhJy6BV+RE4mCf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590324"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590324"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230156"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230156"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:56 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 21/22] selftests/resctrl: Split show_cache_info() to test specific and generic parts
Date:   Wed, 12 Apr 2023 16:21:21 +0300
Message-Id: <20230412132122.29452-22-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

show_cache_info() attempts to do calculate the results and provide
generic cache information. It makes hard to alter the pass/fail
conditions.

Separate the the test specific checks into CAT and CMT test files and
leave only the generic information part into show_cache_info().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 40 ++++------------------
 tools/testing/selftests/resctrl/cat_test.c | 30 ++++++++++++++--
 tools/testing/selftests/resctrl/cmt_test.c | 32 +++++++++++++++--
 tools/testing/selftests/resctrl/resctrl.h  |  6 ++--
 4 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 225ba589d230..becca3ce4f9e 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -283,43 +283,17 @@ int cat_val(struct resctrl_val_param *param)
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
-		    unsigned long cache_span, unsigned long max_diff,
-		    unsigned long max_diff_percent, unsigned long num_of_runs,
-		    bool platform, bool cmt)
+void show_cache_info(int no_of_bits, unsigned long avg_llc_val,
+		     unsigned long cache_span, bool lines)
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
-	ksft_print_msg("%s Check cache miss rate within %d%%\n",
-		       ret ? "Fail:" : "Pass:", max_diff_percent);
-
-	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
 	ksft_print_msg("Number of bits: %d\n", no_of_bits);
 	ksft_print_msg("Average LLC val: %lu\n", avg_llc_val);
-	ksft_print_msg("Cache span (%s): %lu\n", cmt ? "bytes" : "lines",
+	ksft_print_msg("Cache span (%s): %lu\n", !lines ? "bytes" : "lines",
 		       cache_span);
-
-	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index cfad7e488340..d2b7369ad00e 100644
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
+	ksft_print_msg("%s Check cache miss rate within %d%%\n",
+		       ret ? "Fail:" : "Pass:", max_diff_percent);
+
+	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
+
+	show_cache_info(no_of_bits, avg_llc_val, cache_span, true);
+
+	return ret;
+}
+
 static int check_results(struct resctrl_val_param *param)
 {
 	char *token_array[8], temp[512];
@@ -76,9 +100,9 @@ static int check_results(struct resctrl_val_param *param)
 	fclose(fp);
 	no_of_bits = count_consecutive_bits(param->mask, NULL);
 
-	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
-			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
-			       get_vendor() == ARCH_INTEL, false);
+	return show_results_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
+				 MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
+				 get_vendor() == ARCH_INTEL);
 }
 
 void cat_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 8fda7fc4d159..6f06f70d81cf 100644
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
+	ksft_print_msg("%s Check cache miss rate within %d%%\n",
+		       ret ? "Fail:" : "Pass:", max_diff_percent);
+
+	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
+
+	show_cache_info(no_of_bits, avg_llc_val, cache_span, false);
+
+	return ret;
+}
+
 static int check_results(struct resctrl_val_param *param, int no_of_bits)
 {
 	char *token_array[8], temp[512];
@@ -58,9 +85,8 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	}
 	fclose(fp);
 
-	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span,
-			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
-			       true, true);
+	return show_results_info(sum_llc_occu_resc, no_of_bits, param->span,
+				 MAX_DIFF, MAX_DIFF_PERCENT, runs - 1, true);
 }
 
 void cmt_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 028b979c28fb..26061db0b9ea 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -125,9 +125,7 @@ unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
 int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid);
-int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
-		    unsigned long cache_span, unsigned long max_diff,
-		    unsigned long max_diff_percent, unsigned long num_of_runs,
-		    bool platform, bool cmt);
+void show_cache_info(int no_of_bits, unsigned long avg_llc_val,
+		     unsigned long cache_span, bool lines);
 
 #endif /* RESCTRL_H */
-- 
2.30.2

