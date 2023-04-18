Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5F96E604A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjDRLrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjDRLra (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:47:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C79031;
        Tue, 18 Apr 2023 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818422; x=1713354422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M3QYJlujzdfz5vfq0+dLmr81y7Nf7gohRl1ZFTz21cI=;
  b=Vg478K9AKuNAJ41zmaZhEEOEy53oZPw526haAn5d3nZ/MrYhHXJlJrKs
   MTnFYt5oUNtlcKhWObcgCQrlf2QkFO5EB4XbziNwb8dO/N8pXLf6CHNWR
   Fp1zDeYardnnpYLfdO2csI6nDakBidyC1kCSuNtek+0V47is0Tfqlc/Gp
   fjrCT8/0AtiUzXW6j43GwglXAgbHaCdACyjPxZsvcLUFJfBWPCYmFHcgI
   RVoX2Sr44nM2RRawCh+lJkMb1ZC9WpUJ8mo/cV6JJMsGb46bvtAPi48j+
   p1mqlpbuOL43cMw2yg6QX+aEbLLDleMPo+NC4Bfwk+53HYGYcAJ72pS9z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994410"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994410"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601722"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601722"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 15/24] selftests/resctrl: Refactor get_cbm_mask()
Date:   Tue, 18 Apr 2023 14:44:57 +0300
Message-Id: <20230418114506.46788-16-ilpo.jarvinen@linux.intel.com>
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

Callers of get_cbm_mask() are required to pass a string into which
the CBM bit mask is read into. Neither CAT nor CMT tests need the
mask as string but just convert it into an unsigned long value.

The bit mask reader can only read .../cbm_mask files.

Generalize the bit mask reading function into get_bit_mask() such that
it can be used to handle other files besides the .../cbm_mask and
handle the unsigned long conversion within within get_bit_mask() using
fscanf(). Alter get_cbm_mask() to construct the filename for
get_bit_mask().

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c  |  5 +--
 tools/testing/selftests/resctrl/cmt_test.c  |  5 +--
 tools/testing/selftests/resctrl/resctrl.h   |  2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 50 +++++++++++++++------
 4 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index a998e6397518..9bf5d05d9e74 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -18,7 +18,6 @@
 #define MAX_DIFF		1000000
 
 static int count_of_bits;
-static char cbm_mask[256];
 static unsigned long long_mask;
 static unsigned long cache_size;
 
@@ -101,12 +100,10 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	cache_size = 0;
 
 	/* Get default cbm mask for L3/L2 cache */
-	ret = get_cbm_mask(cache_type, cbm_mask);
+	ret = get_cbm_mask(cache_type, &long_mask);
 	if (ret)
 		return ret;
 
-	long_mask = strtoul(cbm_mask, NULL, 16);
-
 	/* Get L3/L2 cache size */
 	ret = get_cache_size(cpu_no, cache_type, &cache_size);
 	if (ret)
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 2d434c03cbba..ae54bbabbd91 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -17,7 +17,6 @@
 #define MAX_DIFF_PERCENT	15
 
 static int count_of_bits;
-static char cbm_mask[256];
 static unsigned long long_mask;
 static unsigned long cache_size;
 
@@ -82,12 +81,10 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (!validate_resctrl_feature_request(CMT_STR))
 		return -1;
 
-	ret = get_cbm_mask("L3", cbm_mask);
+	ret = get_cbm_mask("L3", &long_mask);
 	if (ret)
 		return ret;
 
-	long_mask = strtoul(cbm_mask, NULL, 16);
-
 	ret = get_cache_size(cpu_no, "L3", &cache_size);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index ba36eb5fdf0d..bcc95faa5b4e 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -106,7 +106,7 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
 void mba_test_cleanup(void);
-int get_cbm_mask(char *cache_type, char *cbm_mask);
+int get_cbm_mask(char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 7fef9068d7fd..f01ecfa64063 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -186,30 +186,29 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
 #define CORE_SIBLINGS_PATH	"/sys/bus/cpu/devices/cpu"
 
 /*
- * get_cbm_mask - Get cbm mask for given cache
- * @cache_type:	Cache level L2/L3
- * @cbm_mask:	cbm_mask returned as a string
+ * get_bit_mask - Get bit mask from given file
+ * @filename:	File containing the mask
+ * @mask:	The bit mask returned as unsigned long
  *
  * Return: = 0 on success, < 0 on failure.
  */
-int get_cbm_mask(char *cache_type, char *cbm_mask)
+static int get_bit_mask(char *filename, unsigned long *mask)
 {
-	char cbm_mask_path[1024];
 	FILE *fp;
 
-	if (!cbm_mask)
+	if (!filename || !mask)
 		return -1;
 
-	sprintf(cbm_mask_path, "%s/%s/cbm_mask", INFO_PATH, cache_type);
-
-	fp = fopen(cbm_mask_path, "r");
+	fp = fopen(filename, "r");
 	if (!fp) {
-		perror("Failed to open cache level");
-
+		fprintf(stderr, "Failed to open bit mask file '%s': %s\n",
+			filename, strerror(errno));
 		return -1;
 	}
-	if (fscanf(fp, "%s", cbm_mask) <= 0) {
-		perror("Could not get max cbm_mask");
+
+	if (fscanf(fp, "%lx", mask) <= 0) {
+		fprintf(stderr, "Could not read bit mask file '%s': %s\n",
+			filename, strerror(errno));
 		fclose(fp);
 
 		return -1;
@@ -219,6 +218,31 @@ int get_cbm_mask(char *cache_type, char *cbm_mask)
 	return 0;
 }
 
+/*
+ * get_cbm_bits - Get number of bits in cbm mask
+ * @cache_type:		Cache level L2/L3
+ * @mask:		cbm_mask returned as unsigned long
+ *
+ * Return: = 0 on success, < 0 on failure.
+ */
+int get_cbm_mask(char *cache_type, unsigned long *mask)
+{
+	char cbm_mask_path[1024];
+	int ret;
+
+	if (!cache_type)
+		return -1;
+
+	snprintf(cbm_mask_path, sizeof(cbm_mask_path), "%s/%s/cbm_mask",
+		 INFO_PATH, cache_type);
+
+	ret = get_bit_mask(cbm_mask_path, mask);
+	if (ret)
+		return -1;
+
+	return 0;
+}
+
 /*
  * get_core_sibling - Get sibling core id from the same socket for given CPU
  * @cpu_no:	CPU number
-- 
2.30.2

