Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF97D4C6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjJXJcJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjJXJbc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:31:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034BF1711;
        Tue, 24 Oct 2023 02:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139803; x=1729675803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ocn2/9r+kzf8EjPiilW7216EKf/6BlgU2VvF1iWWBGI=;
  b=jbyamRI21ZmtsbzyRrkw/oQTuNZMjZBjV9LvAv4l4DZJeRg3dY98S/ny
   fPkLCZDj16vsY3fkqLQfEfsIQ86jLnuYBjg50h5Y6OdJE0ln3wVpn+n8w
   BUcnBS5ZRYX6i4JY/sfE5TueHJcggKCDrPaS69+1FyXsY3On/aEf2q/c4
   LkUwR+Eq4jSybOgKr5Syv+Z4gedutRh3g77fpFKci7Ri+CH8mwSZ22lv5
   7TdB6ctUd1Rk46s8rKGt2bNmjU9x6sPtgkjxQ5ph+UmmkQLZocp4G0FyK
   2OKk9lCEIVYVbIAiIQlmv3cT9kr++prqYVgVlWfoZZiqO2mu0SI8uCQFl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5644406"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5644406"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758410209"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="758410209"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:58 -0700
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
Subject: [PATCH 23/24] selftests/resctrl: Add L2 CAT test
Date:   Tue, 24 Oct 2023 12:26:33 +0300
Message-Id: <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CAT selftests only cover L3 but some newer CPUs come also with L2 CAT
support.

Add L2 CAT selftest. As measuring L2 misses is not easily available
with perf, use L3 accesses as a proxy for L2 CAT working or not.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    | 68 +++++++++++++++++--
 tools/testing/selftests/resctrl/resctrl.h     |  1 +
 .../testing/selftests/resctrl/resctrl_tests.c |  1 +
 3 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 48a96acd9e31..a9c72022bb5a 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -131,8 +131,47 @@ void cat_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
+/*
+ * L2 CAT test measures L2 misses indirectly using L3 accesses as a proxy
+ * because perf cannot directly provide the number of L2 misses (there are
+ * only platform specific ways to get the number of L2 misses).
+ *
+ * This function sets up L3 CAT to reduce noise from other processes during
+ * L2 CAT test.
+ */
+int l3_proxy_prepare(const struct resctrl_test *test, struct resctrl_val_param *param, int cpu)
+{
+	unsigned long l3_mask, split_mask;
+	unsigned int start;
+	int count_of_bits;
+	char schemata[64];
+	int n, ret;
+
+	if (!validate_resctrl_feature_request("L3", NULL)) {
+		ksft_print_msg("%s test results may contain noise because L3 CAT is not available!\n",
+			       test->name);
+		return 0;
+	}
+
+	ret = get_mask_no_shareable("L3", &l3_mask);
+	if (ret)
+		return ret;
+	count_of_bits = count_contiguous_bits(l3_mask, &start);
+	n = count_of_bits / 2;
+	split_mask = create_bit_mask(start, n);
+
+	snprintf(schemata, sizeof(schemata), "%lx", l3_mask & ~split_mask);
+	ret = write_schemata("", schemata, cpu, "L3");
+	if (ret)
+		return ret;
+
+	snprintf(schemata, sizeof(schemata), "%lx", split_mask);
+	return write_schemata(param->ctrlgrp, schemata, cpu, "L3");
+}
+
 /*
  * cat_test:	execute CAT benchmark and measure LLC cache misses
+ * @test:	test information structure
  * @param:	parameters passed to cat_test()
  * @span:	buffer size for the benchmark
  * @current_mask	start mask for the first iteration
@@ -142,9 +181,10 @@ void cat_test_cleanup(void)
  *
  * Return:		0 on success. non-zero on failure.
  */
-static int cat_test(struct resctrl_val_param *param, const char *resource,
+static int cat_test(const struct resctrl_test *test, struct resctrl_val_param *param,
 		    size_t span, unsigned long current_mask)
 {
+	__u64 pea_config = PERF_COUNT_HW_CACHE_MISSES;
 	char *resctrl_val = param->resctrl_val;
 	static struct perf_event_read pe_read;
 	struct perf_event_attr pea;
@@ -169,20 +209,26 @@ static int cat_test(struct resctrl_val_param *param, const char *resource,
 	if (ret)
 		return ret;
 
+	if (!strcmp(test->resource, "L2")) {
+		ret = l3_proxy_prepare(test, param, param->cpu_no);
+		if (ret)
+			return ret;
+		pea_config = PERF_COUNT_HW_CACHE_REFERENCES;
+	}
+	perf_event_attr_initialize(&pea, pea_config);
+	perf_event_initialize_read_format(&pe_read);
+
 	buf = alloc_buffer(span, 1);
 	if (buf == NULL)
 		return -1;
 
-	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
-	perf_event_initialize_read_format(&pe_read);
-
 	while (current_mask) {
 		snprintf(schemata, sizeof(schemata), "%lx", param->mask & ~current_mask);
-		ret = write_schemata("", schemata, param->cpu_no, resource);
+		ret = write_schemata("", schemata, param->cpu_no, test->resource);
 		if (ret)
 			goto free_buf;
 		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
-		ret = write_schemata(param->ctrlgrp, schemata, param->cpu_no, resource);
+		ret = write_schemata(param->ctrlgrp, schemata, param->cpu_no, test->resource);
 		if (ret)
 			goto free_buf;
 
@@ -269,7 +315,7 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 	remove(param.filename);
 
-	ret = cat_test(&param, test->resource, span, start_mask);
+	ret = cat_test(test, &param, span, start_mask);
 	if (ret)
 		goto out;
 
@@ -288,3 +334,11 @@ struct resctrl_test l3_cat_test = {
 	.feature_check = test_resource_feature_check,
 	.run_test = cat_run_test,
 };
+
+struct resctrl_test l2_cat_test = {
+	.name = "L2_CAT",
+	.group = "CAT",
+	.resource = "L2",
+	.feature_check = test_resource_feature_check,
+	.run_test = cat_run_test,
+};
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f9a4cfd981f8..fffeb442c173 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -183,5 +183,6 @@ extern struct resctrl_test mbm_test;
 extern struct resctrl_test mba_test;
 extern struct resctrl_test cmt_test;
 extern struct resctrl_test l3_cat_test;
+extern struct resctrl_test l2_cat_test;
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index d89179541d7b..9e254bca6c25 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -15,6 +15,7 @@ static struct resctrl_test *resctrl_tests[] = {
 	&mba_test,
 	&cmt_test,
 	&l3_cat_test,
+	&l2_cat_test,
 };
 
 static int detect_vendor(void)
-- 
2.30.2

