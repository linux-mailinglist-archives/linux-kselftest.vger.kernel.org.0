Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8595A6DF70C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDLNYS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDLNYB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:24:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA8AA250;
        Wed, 12 Apr 2023 06:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305810; x=1712841810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZuvpPwIjZPiLetCQtoHMhwPN9/lxJmyanSrjOhlo44=;
  b=Z7dvkGYdGxrgQh39nJf1qKKnpnaIs/eKUvq1bjWS3HoZfW4JZZzaqsLb
   kzGSi3OV1+YAu5kG0siLbHJaj2KoK//U4N3VmIH7TNX7L8VZu8+9nGPSi
   clzdLvDbsSVbEJebT6CCLJsnFgtcK/+0jquTtLmW3/PbGKkFEeVYjSZ5A
   O5xZyY/v4npxGzXIH7RbQEYI6pCPtdflz8n8xTOda4I7vb0bk1mc8vleS
   vP7m866tbUsDA+3wVIcfyT9GI32oW7DCe9NUviNWMVdaoht7JSemhQshh
   tw3XnUwwAl+iDkY18xkejca/wqK0+4AiTLe/5Rwyyz+ZA9e60eS5DPnEJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590225"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590225"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230099"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230099"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:37 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 15/22] selftests/resctrl: Replace count_bits with count_consecutive_bits()
Date:   Wed, 12 Apr 2023 16:21:15 +0300
Message-Id: <20230412132122.29452-16-ilpo.jarvinen@linux.intel.com>
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

CAT and CMT tests depends on masks being continuous.

Replace count_bits with more appropriate variant that counts
consecutive bits.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c  |  6 ++---
 tools/testing/selftests/resctrl/cmt_test.c  |  3 +--
 tools/testing/selftests/resctrl/resctrl.h   |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c | 30 +++++++++++++++++++++
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 1c736f3f3c05..ec73b2f1a82a 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -78,7 +78,7 @@ static int check_results(struct resctrl_val_param *param)
 	}
 
 	fclose(fp);
-	no_of_bits = count_bits(param->mask);
+	no_of_bits = count_consecutive_bits(param->mask, NULL);
 
 	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
 			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
@@ -108,6 +108,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	ret = get_cbm_mask(cache_type, &long_mask);
 	if (ret)
 		return ret;
+	count_of_bits = count_consecutive_bits(long_mask, NULL);
 
 	/* Get L3/L2 cache size */
 	ret = get_cache_size(cpu_no, cache_type, &cache_size);
@@ -115,9 +116,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_size);
 
-	/* Get max number of bits from default-cabm mask */
-	count_of_bits = count_bits(long_mask);
-
 	if (!n)
 		n = count_of_bits / 2;
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index b5071594aa76..15e824ada9b5 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -88,14 +88,13 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	ret = get_cbm_mask("L3", &long_mask);
 	if (ret)
 		return ret;
+	count_of_bits = count_consecutive_bits(long_mask, NULL);
 
 	ret = get_cache_size(cpu_no, "L3", &cache_size);
 	if (ret)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_size);
 
-	count_of_bits = count_bits(long_mask);
-
 	if (n < 1 || n > count_of_bits) {
 		ksft_print_msg("Invalid input value for numbr_of_bits n!\n");
 		ksft_print_msg("Please enter value in range 1 to %d\n", count_of_bits);
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 605b09d4538a..6d8ebdcec214 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -108,6 +108,7 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
 void mba_test_cleanup(void);
+unsigned int count_consecutive_bits(unsigned long val, unsigned int *start);
 int get_cbm_mask(char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 int cache_alloc_size(int cpu_no, char *cache_type, unsigned long slice_mask,
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 6216955291e6..28d6b594d8d9 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -10,6 +10,8 @@
  */
 #include "resctrl.h"
 
+#include <strings.h>
+
 static int find_resctrl_mount(char *buffer)
 {
 	FILE *mounts;
@@ -228,6 +230,34 @@ static int get_bit_mask(char *filename, unsigned long *mask)
 	return 0;
 }
 
+/*
+ * count_consecutive_bits - Returns the longest train of bits in a bit mask
+ * @val		A bit mask
+ * @start	The location of the least-significant bit of the longest train
+ *
+ * Return:	The length of the consecutive bits in the longest train of bits
+ */
+unsigned int count_consecutive_bits(unsigned long val, unsigned int *start)
+{
+	unsigned long last_val;
+	int count = 0;
+
+	while (val) {
+		last_val = val;
+		val &= (val >> 1);
+		count++;
+	}
+
+	if (start) {
+		if (count)
+			*start = ffsl(last_val) - 1;
+		else
+			*start = 0;
+	}
+
+	return count;
+}
+
 /*
  * get_cbm_bits - Get number of bits in cbm mask
  * @cache_type:		Cache level L2/L3
-- 
2.30.2

