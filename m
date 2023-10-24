Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558387D4C31
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjJXJ2R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjJXJ1y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:27:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945281BC2;
        Tue, 24 Oct 2023 02:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139651; x=1729675651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+7gRKcJ0CvY7ckOs0uWSoDBGK4mY5SuoxJXfmAWuV8Y=;
  b=d+l5n9Ag8qFrCpMDIOF4melsBr1eveH9WegakHLJwwfAxoFkXAgRqVzG
   22D5h1q/PPEHLxKmNQfC2kNsHGkydJnJ2E1iiDAgRWG+ivaLZfqm/1TiD
   X3wyrVeEK1Du8FJF9sW9cM/H02kiht2fgGfxN9ngB4mDraBUW9MWcPfyS
   pKZoCZEaW3PzI2F0lcJECcvSIVF2ty+IJxCCS2tgXxqHe88hyIxqdENHB
   pUt4EmtGyE2yCkuANnViReOgs3tvPlPEMbpoO0HRCsGDlSx4BJk7XV4UA
   RAsWGtIGUKJ9/wQpTk2beu/NwmYHNC/5u3jVFMbwVIuOjCxYVQ/PU/X0x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386829480"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="386829480"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:27:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751939081"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="751939081"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:27:27 -0700
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
Subject: [PATCH 05/24] selftests/resctrl: Create cache_size() helper
Date:   Tue, 24 Oct 2023 12:26:15 +0300
Message-Id: <20231024092634.7122-6-ilpo.jarvinen@linux.intel.com>
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

CAT and CMT tests calculate the span size from the n-bits cache
allocation on their own.

Add cache_size() helper which calculates size of the cache portion for
the given number of bits and use it to replace the existing span
calculations. This also prepares for the new CAT test that will need to
determine the size of the cache portion also during results processing.

cache_size local variables were renamed out of the way to
cache_total_size.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 10 +++++-----
 tools/testing/selftests/resctrl/cmt_test.c |  8 ++++----
 tools/testing/selftests/resctrl/resctrl.h  | 14 ++++++++++++++
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 4852bbda2e71..80861c362a53 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -91,7 +91,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
 	unsigned long l_mask, l_mask_1;
 	int ret, pipefd[2], sibling_cpu_no;
-	unsigned long cache_size = 0;
+	unsigned long cache_total_size = 0;
 	unsigned long long_mask;
 	int count_of_bits;
 	char pipe_message;
@@ -103,10 +103,10 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return ret;
 
 	/* Get L3/L2 cache size */
-	ret = get_cache_size(cpu_no, cache_type, &cache_size);
+	ret = get_cache_size(cpu_no, cache_type, &cache_total_size);
 	if (ret)
 		return ret;
-	ksft_print_msg("Cache size :%lu\n", cache_size);
+	ksft_print_msg("Cache size :%lu\n", cache_total_size);
 
 	/* Get max number of bits from default-cabm mask */
 	count_of_bits = count_bits(long_mask);
@@ -138,7 +138,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	/* Set param values for parent thread which will be allocated bitmask
 	 * with (max_bits - n) bits
 	 */
-	span = cache_size * (count_of_bits - n) / count_of_bits;
+	span = cache_size(cache_total_size, l_mask, long_mask);
 	strcpy(param.ctrlgrp, "c2");
 	strcpy(param.mongrp, "m2");
 	strcpy(param.filename, RESULT_FILE_NAME2);
@@ -160,7 +160,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		param.mask = l_mask_1;
 		strcpy(param.ctrlgrp, "c1");
 		strcpy(param.mongrp, "m1");
-		span = cache_size * n / count_of_bits;
+		span = cache_size(cache_total_size, l_mask_1, long_mask);
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a6c79edc33cd..e8997ff5bc04 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -72,7 +72,7 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 {
 	const char * const *cmd = benchmark_cmd;
 	const char *new_cmd[BENCHMARK_ARGS];
-	unsigned long cache_size = 0;
+	unsigned long cache_total_size = 0;
 	unsigned long long_mask;
 	char *span_str = NULL;
 	int count_of_bits;
@@ -83,10 +83,10 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 	if (ret)
 		return ret;
 
-	ret = get_cache_size(cpu_no, "L3", &cache_size);
+	ret = get_cache_size(cpu_no, "L3", &cache_total_size);
 	if (ret)
 		return ret;
-	ksft_print_msg("Cache size :%lu\n", cache_size);
+	ksft_print_msg("Cache size :%lu\n", cache_total_size);
 
 	count_of_bits = count_bits(long_mask);
 
@@ -107,7 +107,7 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 		.setup		= cmt_setup,
 	};
 
-	span = cache_size * n / count_of_bits;
+	span = cache_size(cache_total_size, param.mask, long_mask);
 
 	if (strcmp(cmd[0], "fill_buf") == 0) {
 		/* Duplicate the command to be able to replace span in it */
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 2f3f0ee439d8..da06b2d492f9 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -117,4 +117,18 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 		    unsigned long max_diff_percent, unsigned long num_of_runs,
 		    bool platform, bool cmt);
 
+/*
+ * cache_size - Calculate the size of a cache portion
+ * @cache_size:	Cache size in bytes
+ * @mask:	Cache portion mask
+ * @cache_mask:	Full bitmask for the cache
+ *
+ * Return: The size of the cache portion in bytes.
+ */
+static inline int cache_size(unsigned long cache_size, unsigned long mask,
+			     unsigned long cache_mask)
+{
+	return cache_size * count_bits(mask) / count_bits(cache_mask);
+}
+
 #endif /* RESCTRL_H */
-- 
2.30.2

