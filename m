Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126E26E6059
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDRLsp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjDRLsl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:48:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B7E9742;
        Tue, 18 Apr 2023 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818491; x=1713354491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jaOCRYxcj3LDYMPNeQhfGhOtBkAd1hyZ1bFX0DhyAqk=;
  b=SwoAYpKtlRZsJdK6FWUQjAnHGP8hGPLGiyOlY7nbm1VkiyPzthQG03uQ
   mktMyp7auY/InfMFjCGfkl/uJAiPLMDOY04ypFYVlWPVgtMw36WuTDuKt
   wDVKWDPOgdGID6kZeqbsU7xI1+ZmKyCwXFGcej3HgaLXuqwS1X7SzLffc
   NkYnh3wYXhhhypBu19KRU8dKpUZdTu/mwe45xrzwY3Blg7YmWWUgHECww
   twSo8sLVf+RWPLXrjidg6BnFFtbBn1JaoyEBztI8bU4k5fztellRJT96B
   jJp6oatb7J9METL5KMLbfkSA/Y0tU/i73Zqtd/0PwtAZHhwechgYCDOc3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994497"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994497"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601877"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601877"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 22/24] selftests/resctrl: Split measure_cache_vals() function
Date:   Tue, 18 Apr 2023 14:45:04 +0300
Message-Id: <20230418114506.46788-23-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The measure_cache_vals() function does a different thing depending on
the test case that called it:
  - For CAT, it measures LLC perf misses 2.
  - For CMT, it measures LLC occupancy through resctrl.

Split these two functionalities such that CMT test calls a new function
called measure_llc_resctrl() to get LLC occupancy through resctrl and
CAT test directly calls get_llc_perf().

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c       | 37 ++++++++-----------
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index c93f5d2bc66e..a015ce2d0a3c 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -199,35 +199,20 @@ static int print_results_cache(char *filename, int bm_pid,
 	return 0;
 }
 
-int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
+int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)
 {
-	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
+	unsigned long llc_occu_resc = 0;
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
-
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
@@ -241,6 +226,7 @@ int cat_val(struct resctrl_val_param *param)
 {
 	int memflush = 1, operation = 0, ret = 0;
 	char *resctrl_val = param->resctrl_val;
+	unsigned long llc_perf_miss = 0;
 	pid_t bm_pid;
 
 	if (strcmp(param->filename, "") == 0)
@@ -281,7 +267,14 @@ int cat_val(struct resctrl_val_param *param)
 		}
 
 		sleep(1);
-		ret = measure_cache_vals(param, bm_pid);
+
+		/* Measure cache miss from perf */
+		ret = get_llc_perf(&llc_perf_miss);
+		if (ret)
+			break;
+
+		ret = print_results_cache(param->filename, bm_pid,
+					  llc_perf_miss);
 		if (ret)
 			break;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index be5a61e7fbcc..12754733126f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -124,7 +124,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
-int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
+int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid);
 int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 		    unsigned long cache_span, unsigned long max_diff,
 		    unsigned long max_diff_percent, unsigned long num_of_runs,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index f0f6c5f6e98b..0ffe4694bf47 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -774,7 +774,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
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

