Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F2C6DF709
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjDLNYI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjDLNXu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:23:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A83A5CF;
        Wed, 12 Apr 2023 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305804; x=1712841804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oWGgRRKeHyv6zU0ZMfJPuwQzr+qxzoidSwImSLLlptU=;
  b=YpRFYtfV1WHx3VMLmlkn+Bk9bsRqWoU/aHOJLJzJ1lIWkTYsdIFkXyaC
   87Oo4Z16F70JXBOJ7XacbGEnAPOr2O179a6BOrRu1a3JCIeAI6eBopoYj
   c8S+jTvNZcEho7Ty0NKIqZtHHK4oCUCWAcGOAwaFAublVTcUJW1hjA9iF
   gG2eMn0pv1YpVF2PxGUQX7q5j9uuRpvA2MKPty+uPKAiUEqz6TKE9FxVG
   94ad8lsILXxoqvTgNwNOF+vB/4rHCdRYyoIUFkxJj9ppe6U4N0q+dpym8
   v3ZvN60hcttBolckiy2YD15qKiEDyaSqJUXGe2u/fHFC/cpUG7+lC32T+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590206"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590206"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230091"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230091"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 14/22] selftests/resctrl: Create cache_alloc_size() helper
Date:   Wed, 12 Apr 2023 16:21:14 +0300
Message-Id: <20230412132122.29452-15-ilpo.jarvinen@linux.intel.com>
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

CAT and CMT tests calculate the span size from the n-bits cache
allocation on their own.

Add cache_alloc_size() helper which calculates size of the cache
allocation for the given number of bits to avoid duplicating code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 27 ++++++++++++++++++++++
 tools/testing/selftests/resctrl/cat_test.c |  8 +++++--
 tools/testing/selftests/resctrl/cmt_test.c |  4 +++-
 tools/testing/selftests/resctrl/resctrl.h  |  2 ++
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 6bc912de38be..5e59c239961c 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -15,6 +15,33 @@ static struct read_format rf_cqm;
 static int fd_lm;
 char llc_occup_path[1024];
 
+/*
+ * cache_alloc_size - Calculate slice size for given cache slice mask
+ * @cpu_no:		CPU number
+ * @cache_type:		Cache level L2/L3
+ * @slice_mask:		Cache slice mask
+ * @slice_size:		Slice size returned on success
+ *
+ * Returns: 0 on success with @slize_size filled, non-zero on error.
+ */
+int cache_alloc_size(int cpu_no, char *cache_type, unsigned long slice_mask,
+		     unsigned long *slice_size)
+{
+	unsigned long cache_size, full_mask;
+	int ret;
+
+	ret = get_cbm_mask(cache_type, &full_mask);
+	if (ret)
+		return ret;
+
+	ret = get_cache_size(cpu_no, cache_type, &cache_size);
+	if (ret)
+		return ret;
+
+	*slice_size = cache_size * count_bits(slice_mask) / count_bits(full_mask);
+	return 0;
+}
+
 static void initialize_perf_event_attr(void)
 {
 	pea_llc_miss.type = PERF_TYPE_HARDWARE;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 7fa693e4de8f..1c736f3f3c05 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -146,7 +146,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	/* Set param values for parent thread which will be allocated bitmask
 	 * with (max_bits - n) bits
 	 */
-	param.span = cache_size * (count_of_bits - n) / count_of_bits;
+	ret = cache_alloc_size(cpu_no, cache_type, l_mask, &param.span);
+	if (ret)
+		return ret;
 	strcpy(param.ctrlgrp, "c2");
 	strcpy(param.mongrp, "m2");
 	strcpy(param.filename, RESULT_FILE_NAME2);
@@ -167,7 +169,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		param.mask = l_mask_1;
 		strcpy(param.ctrlgrp, "c1");
 		strcpy(param.mongrp, "m1");
-		param.span = cache_size * n / count_of_bits;
+		ret = cache_alloc_size(cpu_no, cache_type, l_mask_1, &param.span);
+		if (ret)
+			return ret;
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 5026d9863c6f..b5071594aa76 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -110,10 +110,12 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 		.mum_resctrlfs	= false,
 		.filename	= RESULT_FILE_NAME,
 		.mask		= ~(long_mask << n) & long_mask,
-		.span		= cache_size * n / count_of_bits,
 		.num_of_runs	= 0,
 		.setup		= cmt_setup,
 	};
+	ret = cache_alloc_size(cpu_no, "L3", param.mask, &param.span);
+	if (ret)
+		return ret;
 
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
 		sprintf(benchmark_cmd[1], "%lu", param.span);
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 6c23ceff2a04..605b09d4538a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -110,6 +110,8 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
 void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
+int cache_alloc_size(int cpu_no, char *cache_type, unsigned long slice_mask,
+		     unsigned long *slice_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int cat_val(struct resctrl_val_param *param);
 void cat_test_cleanup(void);
-- 
2.30.2

