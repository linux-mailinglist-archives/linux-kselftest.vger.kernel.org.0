Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC49B6E604C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjDRLrm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDRLrk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:47:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA65F1BC0;
        Tue, 18 Apr 2023 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818430; x=1713354430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FadlcAYLzZZPP+wLU1eQDR/Sf3rZoeCx35VWKn+SAM4=;
  b=YYABdEFakR3339ALEyPEXxbTcdTTqMxiJVeiq/30OD13j9TAqUOWF0YG
   H0sLgYqJGNk5cXx9T5xEAhPMpqadnEXtzWAHrQUWo/7ODKcAAdRlTSmwB
   1sTdav5jbU9NXw7W34OmSXxCt6Bxs8ELpm8w6bllV39QVTLnfU5l+KPSD
   bt38jBWqAfDnM6u26gVL6J2eRXIwu8lbyJBB9+5IIM7l5YeBKrnYxy/v3
   4bpRwNDkOQWG+vBK+5UYs5VEdxBJBIFor5agONSFnmgIdmY3CSE1PzD9z
   YWjn3Ayvp3/Vaw/psI0/QsXAOdgqn0qrm8NE/FwMYkZK0vreQdJFKRsqu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994418"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994418"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601753"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601753"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 16/24] selftests/resctrl: Create cache_alloc_size() helper
Date:   Tue, 18 Apr 2023 14:44:58 +0300
Message-Id: <20230418114506.46788-17-ilpo.jarvinen@linux.intel.com>
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
index 6bc912de38be..b983af394e33 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -15,6 +15,33 @@ static struct read_format rf_cqm;
 static int fd_lm;
 char llc_occup_path[1024];
 
+/*
+ * cache_alloc_size - Calculate alloc size for given cache alloc mask
+ * @cpu_no:		CPU number
+ * @cache_type:		Cache level L2/L3
+ * @alloc_mask:		Cache alloc mask
+ * @alloc_size:		Alloc size returned on success
+ *
+ * Returns: 0 on success with @alloc_size filled, non-zero on error.
+ */
+int cache_alloc_size(int cpu_no, char *cache_type, unsigned long alloc_mask,
+		     unsigned long *alloc_size)
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
+	*alloc_size = cache_size * count_bits(alloc_mask) / count_bits(full_mask);
+	return 0;
+}
+
 static void initialize_perf_event_attr(void)
 {
 	pea_llc_miss.type = PERF_TYPE_HARDWARE;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 9bf5d05d9e74..d3fbd4de9f8a 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -140,7 +140,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
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
@@ -162,7 +164,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		param.mask = l_mask_1;
 		strcpy(param.ctrlgrp, "c1");
 		strcpy(param.mongrp, "m1");
-		param.span = cache_size * n / count_of_bits;
+		ret = cache_alloc_size(cpu_no, cache_type, l_mask_1, &param.span);
+		if (ret)
+			exit(-1);
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index ae54bbabbd91..efe77e0f1d4c 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -105,10 +105,12 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 		.cpu_no		= cpu_no,
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
index bcc95faa5b4e..65425d92684e 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -108,6 +108,8 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
 void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
+int cache_alloc_size(int cpu_no, char *cache_type, unsigned long alloc_mask,
+		     unsigned long *alloc_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
-- 
2.30.2

