Return-Path: <linux-kselftest+bounces-1535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB6580C976
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2F8281CF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E281F3AC29;
	Mon, 11 Dec 2023 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEVQ1icz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5EA18D;
	Mon, 11 Dec 2023 04:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297204; x=1733833204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NviBydXIehb8k6mjTqN4kQVTwpJ5zdXEYrNU9xsRc0E=;
  b=PEVQ1iczJkzk6Lyv50Fr+Q4wh1ea+c9Tn0a8r6SO7VG/Rz7eHK5hzGsY
   nAVF26s1wDmZGCLL4q7S4IwVf97AJgUxubPHYq5rFJ0s/enolUZppctQM
   I7YRv98D5qD2uq71C+JC1FmnerMj9YTd3rtJWp7EW7Jpqp3+JWhUVGp5u
   oTK/UIIGYX69GCUNJ3UV/inCpZa0+HMUXxXsnr3kUnfRfHCFEYEeHNfVI
   9rYpjuxWVjtTplUBqZB7l8RVb0ciYnRKhvelBnjo4oQ5yXKG00kk99gg6
   +ncRadgcTXrEzIqShArCrPEuJbDg8+dBWRzreuD3IW94t+8/z7B7LoBIE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1708234"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1708234"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="896441019"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="896441019"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:58 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 09/29] selftests/resctrl: Create cache_portion_size() helper
Date: Mon, 11 Dec 2023 14:18:06 +0200
Message-Id: <20231211121826.14392-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
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
 tools/testing/selftests/resctrl/cat_test.c | 10 +++++-----
 tools/testing/selftests/resctrl/cmt_test.c |  8 ++++----
 tools/testing/selftests/resctrl/resctrl.h  | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 9 deletions(-)

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
index 9e5777e1eee3..0e3a4da5f6ec 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -116,4 +116,19 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
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


