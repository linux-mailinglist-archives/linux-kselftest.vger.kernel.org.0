Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2B752391
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjGMNXg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjGMNWr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:22:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1C3ABF;
        Thu, 13 Jul 2023 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254500; x=1720790500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tlqcBuGsxOSKA74bKjbrp+jQUh7f0hcz1UsL+nprPCM=;
  b=AgXVSRmU6wLzAsdt0IuhWfXR0zwIKmyYZUVnrRVrIcC9a9YrF1RoBYWU
   buP4ki8u0M3zBgEEt9Za3U4h7z3EJejkHTt97jXyy76X/a6uk35d3R+qa
   ar5qyzX87cMiugj0H/aEVezjgNLOsYRSCOBMh/qU1Ugvs5gtrX5QuZsAF
   1bdODwE5QswBscO+ox+g3zXJlcjbFs8XXmey/bsfafXB7m/YnK79nEsdV
   K54XCLw/KiVCUbZLExqNEqhiU9u2v9EWbaAKhO6LrZPAHCWkSRKMzrzAE
   7DAVnGzzWoK+ugpJKWjhIv8SWUpL9xR/zpJdDnxgPnoWp4fTavCfSjzMG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345497119"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345497119"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968616058"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968616058"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:21:15 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 18/19] selftests/resctrl: Pass the real number of tests to show_cache_info()
Date:   Thu, 13 Jul 2023 16:19:31 +0300
Message-Id: <20230713131932.133258-19-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Results include warm-up test which is discarded before passing the sum
to show_cache_info(). show_cache_info() handles this by subtracting one
from the number of tests in divisor. It is a trappy construct to have
sum and number of tests parameters to disagree like this.

A more logical place for subtracting the skipped tests is where the sum
is calculated so move it there. Pass the correct number of tests to
show_cache_info() so it can be used directly as the divisor for
calculating the average.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 2 +-
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 tools/testing/selftests/resctrl/cmt_test.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 385c01dd3ec6..5aa112e5fdd3 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -290,7 +290,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 	long avg_diff = 0;
 	int ret;
 
-	avg_llc_val = sum_llc_val / (num_of_runs - 1);
+	avg_llc_val = sum_llc_val / num_of_runs;
 	avg_diff = (long)abs(cache_span - avg_llc_val);
 	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
 
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index ed6c8e64ad11..3848dfb46aba 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -77,7 +77,7 @@ static int check_results(struct resctrl_val_param *param)
 	no_of_bits = count_bits(param->mask);
 
 	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
-			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       get_vendor() == ARCH_INTEL, false);
 }
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 0ac9d6bbd13d..cb2197647c6c 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -59,7 +59,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	fclose(fp);
 
 	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span,
-			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       true, true);
 }
 
-- 
2.30.2

