Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168047D4C36
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjJXJ2g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjJXJ2R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:28:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24896F9;
        Tue, 24 Oct 2023 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139668; x=1729675668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iXxHTqJrXVaGB5EYZWuORQMkSW5xHXnb5vc8EVQCUGk=;
  b=GpQsKIZDSX84wk77EYyplM8hYGyr78V8/4LoK7GW2Deentx1/VZCcqrN
   be7/yNYw8y5O7t1QMLWNKgXD+7+JEI/320JMPbpX2YmbPdpXpR2ICmRv2
   mNyC8H8/9jDRHe/WbLkFJbxnytSGqRDIbHytgAV/9PBIQfk4fO5bKCAvc
   l8/FOeWXysVo771qK8M6BDgkTzP+RxTPBuI4fNclUrebM1PmgfbYSHqQc
   M5TDSU2Wd0vUewxa4LGwf2wHBafmE2BgvXm0/Il6HKrGMtEZy3AM+1f8C
   Wi+isqo0zrrD7CxLOp2aSHudPupFfCiZlgzPNToc0LF2cvoQkJ+cLS7Lh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386829500"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="386829500"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751939155"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="751939155"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:27:43 -0700
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
Subject: [PATCH 07/24] selftests/resctrl: Split measure_cache_vals() function
Date:   Tue, 24 Oct 2023 12:26:17 +0300
Message-Id: <20231024092634.7122-8-ilpo.jarvinen@linux.intel.com>
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

The measure_cache_vals() function does a different thing depending on
the test case that called it:
  - For CAT, it measures LLC perf misses.
  - For CMT, it measures LLC occupancy through resctrl.

Split these two functionalities into own functions the CAT and CMT
tests can call directly.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c       | 37 ++++++++++---------
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index bcbca356d56a..299d9508221f 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -170,35 +170,36 @@ static int print_results_cache(char *filename, int bm_pid,
 	return 0;
 }
 
-int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
+static int measure_llc_perf(struct resctrl_val_param *param, int bm_pid)
 {
-	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
+	unsigned long llc_perf_miss = 0;
 	int ret;
 
 	/*
 	 * Measure cache miss from perf.
 	 */
-	if (!strncmp(param->resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-		ret = get_llc_perf(&llc_perf_miss);
-		if (ret < 0)
-			return ret;
-		llc_value = llc_perf_miss;
-	}
+	ret = get_llc_perf(&llc_perf_miss);
+	if (ret < 0)
+		return ret;
+
+	ret = print_results_cache(param->filename, bm_pid, llc_perf_miss);
+	return ret;
+}
+
+int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)
+{
+	unsigned long llc_occu_resc = 0;
+	int ret;
 
 	/*
 	 * Measure llc occupancy from resctrl.
 	 */
-	if (!strncmp(param->resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-		ret = get_llc_occu_resctrl(&llc_occu_resc);
-		if (ret < 0)
-			return ret;
-		llc_value = llc_occu_resc;
-	}
-	ret = print_results_cache(param->filename, bm_pid, llc_value);
-	if (ret)
+	ret = get_llc_occu_resctrl(&llc_occu_resc);
+	if (ret < 0)
 		return ret;
 
-	return 0;
+	ret = print_results_cache(param->filename, bm_pid, llc_occu_resc);
+	return ret;
 }
 
 /*
@@ -253,7 +254,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 		}
 
 		sleep(1);
-		ret = measure_cache_vals(param, bm_pid);
+		ret = measure_llc_perf(param, bm_pid);
 		if (ret)
 			goto pe_close;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 10fd3161e63a..56afdc190727 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -114,7 +114,7 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
-int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
+int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid);
 int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 		    size_t cache_span, unsigned long max_diff,
 		    unsigned long max_diff_percent, unsigned long num_of_runs,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 88789678917b..43ca026c6e0f 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -830,7 +830,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
 			sleep(1);
-			ret = measure_cache_vals(param, bm_pid);
+			ret = measure_llc_resctrl(param, bm_pid);
 			if (ret)
 				break;
 		}
-- 
2.30.2

