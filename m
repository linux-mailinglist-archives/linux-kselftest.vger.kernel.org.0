Return-Path: <linux-kselftest+bounces-303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B607F117F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3703D1F211AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835D913AD4;
	Mon, 20 Nov 2023 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YX0d1k+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B1119;
	Mon, 20 Nov 2023 03:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478910; x=1732014910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=88/iT8uzQwHja/O0ghL1HtAjGASYm7VOfvDL6LKmcpc=;
  b=YX0d1k+F/r/Llo4AiY6VY9m0aCTgrtACqBSTmZS+aKUjROEGCCFxUO6a
   pY5H/vykLxU9BlDbwLS04o8eb3GXGGi/rQnBVwazXorxWy6dXuYYjKpSb
   xv6wXofrq6BY8mFGWHDPyUCmRs1M4T8u/Ie+TJFeEVlJEugvNZemSzTnX
   DYRrLW/DX2PCdRNX5xO/6avFRj8RsHHHrE7AiXEfxQuU+OP/2P43EdlOr
   /TokPUGipQBq4FN2nZ54taEvDHF+Rz5BCXJcTP1VQ1DHxtd6I+I2WO10G
   LPrkK3U1dlTflw16qh/AFew2NqshN6cdu2pv8z5oVtI2RpsXdU1wlav6A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394447094"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394447094"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1013559147"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="1013559147"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 06/26] selftests/resctrl: Create cache_portion_size() helper
Date: Mon, 20 Nov 2023 13:13:20 +0200
Message-Id: <20231120111340.7805-7-ilpo.jarvinen@linux.intel.com>
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

CAT and CMT tests calculate size of the cache portion for the n-bits
cache allocation on their own.

Add cache_portion_size() helper that calculates size of the cache
portion for the given number of bits and use it to replace the existing
span calculations. This also prepares for the new CAT test that will
need to determine the size of the cache portion also during results
processing.

Rename also 'cache_size' local variables to 'cache_total_size' to
prevent misinterpretations.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 10 +++++-----
 tools/testing/selftests/resctrl/cmt_test.c |  8 ++++----
 tools/testing/selftests/resctrl/resctrl.h  | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 92f0f3ce90e5..cfcdb7bd600f 100644
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
@@ -102,10 +102,10 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return ret;
 
 	/* Get L3/L2 cache size */
-	ret = get_cache_size(cpu_no, cache_type, &cache_size);
+	ret = get_cache_size(cpu_no, cache_type, &cache_total_size);
 	if (ret)
 		return ret;
-	ksft_print_msg("Cache size :%lu\n", cache_size);
+	ksft_print_msg("Cache size :%lu\n", cache_total_size);
 
 	count_of_bits = count_bits(long_mask);
 
@@ -136,7 +136,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	/* Set param values for parent thread which will be allocated bitmask
 	 * with (max_bits - n) bits
 	 */
-	span = cache_size * (count_of_bits - n) / count_of_bits;
+	span = cache_portion_size(cache_total_size, l_mask, long_mask);
 	strcpy(param.ctrlgrp, "c2");
 	strcpy(param.mongrp, "m2");
 	strcpy(param.filename, RESULT_FILE_NAME2);
@@ -158,7 +158,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		param.mask = l_mask_1;
 		strcpy(param.ctrlgrp, "c1");
 		strcpy(param.mongrp, "m1");
-		span = cache_size * n / count_of_bits;
+		span = cache_portion_size(cache_total_size, l_mask_1, long_mask);
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index d6ddacfb4416..51cbfc392f66 100644
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
+	span = cache_portion_size(cache_total_size, param.mask, long_mask);
 
 	if (strcmp(cmd[0], "fill_buf") == 0) {
 		/* Duplicate the command to be able to replace span in it */
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 62bad95ea7d0..57fe42f4eda2 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -117,4 +117,19 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 		    unsigned long max_diff_percent, unsigned long num_of_runs,
 		    bool platform, bool cmt);
 
+/*
+ * cache_portion_size - Calculate the size of a cache portion
+ * @cache_size:		Total cache size in bytes
+ * @portion_mask:	Cache portion mask
+ * @full_cache_mask:	Full Cache Bit Mask (CBM) for the cache
+ *
+ * Return: The size of the cache portion in bytes.
+ */
+static inline int cache_portion_size(unsigned long cache_size,
+				     unsigned long portion_mask,
+				     unsigned long full_cache_mask)
+{
+	return cache_size * count_bits(portion_mask) / count_bits(full_cache_mask);
+}
+
 #endif /* RESCTRL_H */
-- 
2.30.2


