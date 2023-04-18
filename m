Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFFC6E604E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDRLro (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjDRLrm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:47:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2633265BF;
        Tue, 18 Apr 2023 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818434; x=1713354434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dr2l2TxlFFiREWwatq8+29/dJHLAULNZVHaY9hHY5v4=;
  b=aVIIw4IA6Nwgvvw4j8dLZmZrP2G301kXP+dPzr5r1suQzeEDD/oFB6zz
   VAGFYfNarM5GgRDqzAuMdVHql9W2jco7ZYjY78qI/f62AslUbex2jLryr
   cifHvaCGgsCmvmY+YgsBBvgPePAJubN40ISTf5keaG5yJo+NLpDa4EhYk
   3wzpb3Mchy6S4cVRdXn3SO98qYap46G2sWTMDIKhb6hrAb5pPGD4qaHVa
   N8ZhnueX1S83fZCpodWxzMV6vCwhdtc5OjOBmp/RYn0NaPL1eu/0S1AhW
   jgDEstRHUbitJ4uFmsiPtcQ3ov8ZlaJ0KdvhUUFOeRDDcBfCod3u11Dj7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994436"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994436"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601795"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601795"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 17/24] selftests/resctrl: Replace count_bits with count_consecutive_bits()
Date:   Tue, 18 Apr 2023 14:44:59 +0300
Message-Id: <20230418114506.46788-18-ilpo.jarvinen@linux.intel.com>
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
index d3fbd4de9f8a..a1834dd5ad9a 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -78,7 +78,7 @@ static int check_results(struct resctrl_val_param *param)
 	}
 
 	fclose(fp);
-	no_of_bits = count_bits(param->mask);
+	no_of_bits = count_consecutive_bits(param->mask, NULL);
 
 	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
 			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
@@ -103,6 +103,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	ret = get_cbm_mask(cache_type, &long_mask);
 	if (ret)
 		return ret;
+	count_of_bits = count_consecutive_bits(long_mask, NULL);
 
 	/* Get L3/L2 cache size */
 	ret = get_cache_size(cpu_no, cache_type, &cache_size);
@@ -110,9 +111,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_size);
 
-	/* Get max number of bits from default-cabm mask */
-	count_of_bits = count_bits(long_mask);
-
 	if (!n)
 		n = count_of_bits / 2;
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index efe77e0f1d4c..98e7d3accd73 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -84,14 +84,13 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
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
index 65425d92684e..aa5dc8b95a06 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -106,6 +106,7 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
 void mba_test_cleanup(void);
+unsigned int count_consecutive_bits(unsigned long val, unsigned int *start);
 int get_cbm_mask(char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 int cache_alloc_size(int cpu_no, char *cache_type, unsigned long alloc_mask,
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index f01ecfa64063..4efaf69c8152 100644
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
@@ -218,6 +220,34 @@ static int get_bit_mask(char *filename, unsigned long *mask)
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

