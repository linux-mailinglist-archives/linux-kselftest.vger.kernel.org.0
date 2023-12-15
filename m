Return-Path: <linux-kselftest+bounces-2044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5D7814B34
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C991C23BDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07AA364CD;
	Fri, 15 Dec 2023 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSmBSKNf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FDD37153;
	Fri, 15 Dec 2023 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652812; x=1734188812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IlhQml1sdCh4qC+ylgqtmLnXuT5UIH8CGMKrCZvaguw=;
  b=cSmBSKNfWfvJXrZkWU0djjwelS3G4LOAS5TDjTTd9JWp4luE9lnEjeQ6
   C3klRzAOzyHtiUzrbks8QBYSM5gf8SPNB2Ck0Fp1EHxzO7mDeW008P3VS
   nibJfubTKW1oW5ScjDAadtjyx/DnHcOgDnKDB941xUmvHOLKK3m+KwYY3
   /+6TtV+HTP2UHctOfmmvFEVd+ChjmZU9qIYJmaVtshNBpmjvZdvwUXU4a
   gBEQL51aQztzVi7IK+vpAjJ5+9IcIs7RWyYvMnC2aq5UCTHX5FLQ69s/5
   /3jnQHFEAIPzRJ+GxESudUmKwcAjKQd9Hf+KD/47OJrNDZZ6s+DOz6rLU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2453592"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2453592"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:06:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="809000848"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="809000848"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:06:47 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 09/29] selftests/resctrl: Create cache_portion_size() helper
Date: Fri, 15 Dec 2023 17:04:55 +0200
Message-Id: <20231215150515.36983-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v4:
- Correct return type
- Don't allow div-by-zero
---
 tools/testing/selftests/resctrl/cat_test.c | 10 ++++-----
 tools/testing/selftests/resctrl/cmt_test.c |  8 ++++----
 tools/testing/selftests/resctrl/resctrl.h  | 24 ++++++++++++++++++++++
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 242c4c6200aa..f18c95dda5d3 100644
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
index a18c6825802c..a14d46353865 100644
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
index 9e5777e1eee3..08647f2c07f5 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -116,4 +116,28 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
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
+static inline unsigned long cache_portion_size(unsigned long cache_size,
+					       unsigned long portion_mask,
+					       unsigned long full_cache_mask)
+{
+	unsigned int bits = count_bits(full_cache_mask);
+
+	/*
+	 * With no bits the full CBM, assume cache cannot be split into
+	 * smaller portions. To avoid divide by zero, return cache_size.
+	 */
+	if (!bits)
+		return cache_size;
+
+	return cache_size * count_bits(portion_mask) / bits;
+}
+
 #endif /* RESCTRL_H */
-- 
2.30.2


