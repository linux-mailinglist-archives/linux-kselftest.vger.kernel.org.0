Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DFC6E6052
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjDRLsO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjDRLsL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:48:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A230E4;
        Tue, 18 Apr 2023 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818458; x=1713354458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CvYgU7P/mUo+lerWgOGHrYSwnUvkU/Rq7wcifjwteuM=;
  b=aIuzDXFKUWLtyhtuY/BTiPJpb/R+Yobv4YnWkdOtTjgK3QwAGtQ6VYUE
   P4VMPM7BpXqUFm0dfyZHiLKgfzc90L/tbz8ICdGboxw5+pGwWWmgWJbvD
   ifqrwmVBtNIbrc3IqWiYIQUnm85QCvh/m1RU7PbyGLdL5A9AGf0Yjh3xq
   bVsbtQyXAvM6QsLFuASv2eNa2sCgHwOKpRwzCdcQjZQfauLl9lerQ4Glu
   ebUeM8FgSeGE4YmVgou5GmVh8VcGSGyI8fZKi80fOVl6euyD6gs6d3ahQ
   lIjsvjQ/73xdLR6L5ueEdn4whpYQYzyUiEIlp3oIeunMvFiIRAWFZSBUD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994469"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994469"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601834"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601834"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:22 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 19/24] selftests/resctrl: Pass the real number of tests to show_cache_info()
Date:   Tue, 18 Apr 2023 14:45:01 +0300
Message-Id: <20230418114506.46788-20-ilpo.jarvinen@linux.intel.com>
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

Some results include warm-up tests which are discarded before passing
the sum to show_cache_info(). Currently, show_cache_info() handles this
by subtracting one from the number of tests in divisor. It is a trappy
construct to have sum and number of tests parameters to disagree like
this.

A more logical place for subtracting the skipped tests is where the sum
is calculated so move it there. Pass the correct number of tests to
show_cache_info() soit can use directly as the divisor for calculating
the average.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 2 +-
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 tools/testing/selftests/resctrl/cmt_test.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index b983af394e33..c93f5d2bc66e 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -312,7 +312,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 	long avg_diff = 0;
 	int ret;
 
-	avg_llc_val = sum_llc_val / (num_of_runs - 1);
+	avg_llc_val = sum_llc_val / num_of_runs;
 	avg_diff = (long)abs(cache_span - avg_llc_val);
 	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
 
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index e2d10124cdb1..ae21e656cf6e 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -81,7 +81,7 @@ static int check_results(struct resctrl_val_param *param)
 	no_of_bits = count_consecutive_bits(param->mask, NULL);
 
 	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
-			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       get_vendor() == ARCH_INTEL, false);
 }
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 98e7d3accd73..087378a775ee 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -63,7 +63,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	fclose(fp);
 
 	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span,
-			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       true, true);
 }
 
-- 
2.30.2

