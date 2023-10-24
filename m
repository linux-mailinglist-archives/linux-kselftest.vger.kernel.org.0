Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5877D4C69
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjJXJcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbjJXJbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:31:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC12A1BC7;
        Tue, 24 Oct 2023 02:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139812; x=1729675812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1rS7dOlEZmpZ+PuUamvzhE47459WoiCsJ336xs2d7Tc=;
  b=A07DuuYp1ggXcBt3Sbsggr9IqcL2L/E53wJvPzeguo/eRpFsSCwpUjZg
   xV3tYbujAHQ6UTvxQr547FlmlhyXCTsQQ8PSF12rGpGcZa3aT2YeMaKfH
   BZuqLe1zGuFvqD9yd0TjaiIPR/YYfkP7DmoLiE85tuEXqtFEdkYLc6HWr
   n2gXRfhbjsZ0Hoqm5171TDPUWhavfQtx0pOMnve3nXCg4k2XFLLNddijF
   ebfBVw7rNmwQryYSrJJrP0Krb0ptI1hq4+2XXvKaYsblDeddlo4dkTxs7
   R33DSU76lef2v1Csffvns6mijYPijr9rv+I3OUtiqW65e8RanY+6AVMCH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366364219"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="366364219"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="849076026"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="849076026"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:30:07 -0700
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
Subject: [PATCH 24/24] selftests/resctrl: Ignore failures from L2 CAT test with <= 2 bits
Date:   Tue, 24 Oct 2023 12:26:34 +0300
Message-Id: <20231024092634.7122-25-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

L2 CAT test with low number of bits tends to occasionally fail because
of what seems random variation. The margin is quite small to begin with
for <= 2 bits in CBM. At times, the result can even become negative.
While it would be possible to allow negative values for those cases, it
would be more confusing to user.

Ignore failures from the tests where <= 2 were used to avoid false
negative results.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index a9c72022bb5a..bc88eb891f35 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -28,7 +28,7 @@
  */
 #define MIN_DIFF_PERCENT_PER_BIT	1
 
-static int show_results_info(__u64 sum_llc_val, int no_of_bits,
+static int show_results_info(__u64 sum_llc_val, int no_of_bits, bool ignore_fail,
 			     unsigned long cache_span, long min_diff_percent,
 			     unsigned long num_of_runs, bool platform,
 			     __s64 *prev_avg_llc_val)
@@ -40,12 +40,18 @@ static int show_results_info(__u64 sum_llc_val, int no_of_bits,
 	avg_llc_val = sum_llc_val / num_of_runs;
 	if (*prev_avg_llc_val) {
 		float delta = (__s64)(avg_llc_val - *prev_avg_llc_val);
+		char *res_str;
 
 		avg_diff = delta / *prev_avg_llc_val;
 		ret = platform && (avg_diff * 100) < (float)min_diff_percent;
 
+		res_str = ret ? "Fail:" : "Pass:";
+		if (ret && ignore_fail) {
+			res_str = "Pass (failure ignored):";
+			ret = 0;
+		}
 		ksft_print_msg("%s Check cache miss rate changed more than %.1f%%\n",
-			       ret ? "Fail:" : "Pass:", (float)min_diff_percent);
+			       res_str, (float)min_diff_percent);
 
 		ksft_print_msg("Percent diff=%.1f\n", avg_diff * 100);
 	}
@@ -85,6 +91,7 @@ static int check_results(struct resctrl_val_param *param, const char *cache_type
 
 	while (fgets(temp, sizeof(temp), fp)) {
 		char *token = strtok(temp, ":\t");
+		bool ignore_fail = false;
 		int fields = 0;
 		int bits;
 
@@ -108,7 +115,15 @@ static int check_results(struct resctrl_val_param *param, const char *cache_type
 
 		bits = count_bits(current_mask);
 
-		ret = show_results_info(sum_llc_perf_miss, bits,
+		/*
+		 * L2 CAT test with low number of bits has too small margin to
+		 * always remain positive. As negative values would be confusing
+		 * for the user, ignore failure instead.
+		 */
+		if (bits <= 2 && !strcmp(cache_type, "L2"))
+			ignore_fail = true;
+
+		ret = show_results_info(sum_llc_perf_miss, bits, ignore_fail,
 					alloc_size / 64,
 					MIN_DIFF_PERCENT_PER_BIT * (bits - 1), runs,
 					get_vendor() == ARCH_INTEL,
-- 
2.30.2

