Return-Path: <linux-kselftest+bounces-2063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13C7814B5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E621C234C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A941875;
	Fri, 15 Dec 2023 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9le/O9M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE23A8F9;
	Fri, 15 Dec 2023 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652977; x=1734188977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JTkwuFbRZQrXR38NHLmU+i9Z3Oo5wxvF2aKPpbcmqtY=;
  b=W9le/O9M5QzWIrv+6UoM325wf/3VrtjMMK1AmfPw1XIoTgM1o0pqfB+3
   JCabZJ2AneTh32HPwjkQ1O2YFtAd622Lm43dIHu7Sk6eLlBBhl+IjXQlU
   ZoZleOr6CISrmcVTGbp1zC4OeyVhfSrOv5BM0zINCAliAPXReI9QRj1a/
   fZcAhHxEOkykRO/S5xujlPJhdC05mzxOFlX+A0rVvkZrhLFpowfFsPitH
   k12/WKSxZ2FLsw8PVrArY1QgbfKn8jrees9NcR/svSM2oyGdSD8YAgV0q
   O2//15/Ce83li4ECcCvY1SnbFxWKasFfvUlZXACwIS6xwMc8Jitut4eJT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394160736"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="394160736"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:06:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803735007"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="803735007"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:06:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 07/29] selftests/resctrl: Refactor get_cbm_mask() and rename to get_full_cbm()
Date: Fri, 15 Dec 2023 17:04:53 +0200
Message-Id: <20231215150515.36983-8-ilpo.jarvinen@linux.intel.com>
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

Callers of get_cbm_mask() are required to pass a string into which the
capacity bitmask (CBM) is read. Neither CAT nor CMT tests need the
bitmask as string but just convert it into an unsigned long value.

Another limitation is that the bit mask reader can only read
.../cbm_mask files.

Generalize the bit mask reading function into get_bit_mask() such that
it can be used to handle other files besides the .../cbm_mask and
handles the unsigned long conversion within get_bit_mask() using
fscanf(). Change get_cbm_mask() to use get_bit_mask() and rename it to
get_full_cbm() to better indicate what the function does.

Return error from get_full_cbm() if the bitmask is zero for some reason
because it makes the code more robust as the selftests naturally assume
the bitmask has some bits.

Also mark cache_type const while at it and remove useless comments that
are related to processing of CBM bits.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v4:
- Convert from fprintf() to ksft_print_msg()

v3:
- Grammar fix changelog
- Zero bit mask returns error
---
 tools/testing/selftests/resctrl/cat_test.c  |  7 +--
 tools/testing/selftests/resctrl/cmt_test.c  |  5 +-
 tools/testing/selftests/resctrl/resctrl.h   |  2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 51 +++++++++++++++------
 4 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index fabb56ff68d1..242c4c6200aa 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -93,25 +93,20 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	int ret, pipefd[2], sibling_cpu_no;
 	unsigned long cache_size = 0;
 	unsigned long long_mask;
-	char cbm_mask[256];
 	int count_of_bits;
 	char pipe_message;
 	size_t span;
 
-	/* Get default cbm mask for L3/L2 cache */
-	ret = get_cbm_mask(cache_type, cbm_mask);
+	ret = get_full_cbm(cache_type, &long_mask);
 	if (ret)
 		return ret;
 
-	long_mask = strtoul(cbm_mask, NULL, 16);
-
 	/* Get L3/L2 cache size */
 	ret = get_cache_size(cpu_no, cache_type, &cache_size);
 	if (ret)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_size);
 
-	/* Get max number of bits from default-cabm mask */
 	count_of_bits = count_bits(long_mask);
 
 	if (!n)
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index ffd302bd5c73..a18c6825802c 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -75,17 +75,14 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 	unsigned long cache_size = 0;
 	unsigned long long_mask;
 	char *span_str = NULL;
-	char cbm_mask[256];
 	int count_of_bits;
 	size_t span;
 	int ret, i;
 
-	ret = get_cbm_mask("L3", cbm_mask);
+	ret = get_full_cbm("L3", &long_mask);
 	if (ret)
 		return ret;
 
-	long_mask = strtoul(cbm_mask, NULL, 16);
-
 	ret = get_cache_size(cpu_no, "L3", &cache_size);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index a848e9c75578..89cd89507891 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -98,7 +98,7 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd);
 void mba_test_cleanup(void);
-int get_cbm_mask(char *cache_type, char *cbm_mask);
+int get_full_cbm(const char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 81d1e043e17a..a74be17eaa4e 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -196,30 +196,29 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
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
+static int get_bit_mask(const char *filename, unsigned long *mask)
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
-		ksft_perror("Failed to open cache level");
-
+		ksft_print_msg("Failed to open bit mask file '%s': %s\n",
+			       filename, strerror(errno));
 		return -1;
 	}
-	if (fscanf(fp, "%s", cbm_mask) <= 0) {
-		ksft_perror("Could not get max cbm_mask");
+
+	if (fscanf(fp, "%lx", mask) <= 0) {
+		ksft_print_msg("Could not read bit mask file '%s': %s\n",
+			       filename, strerror(errno));
 		fclose(fp);
 
 		return -1;
@@ -229,6 +228,32 @@ int get_cbm_mask(char *cache_type, char *cbm_mask)
 	return 0;
 }
 
+/*
+ * get_full_cbm - Get full Cache Bit Mask (CBM)
+ * @cache_type:	Cache type as "L2" or "L3"
+ * @mask:	Full cache bit mask representing the maximal portion of cache
+ *		available for allocation, returned as unsigned long.
+ *
+ * Return: = 0 on success, < 0 on failure.
+ */
+int get_full_cbm(const char *cache_type, unsigned long *mask)
+{
+	char cbm_path[PATH_MAX];
+	int ret;
+
+	if (!cache_type)
+		return -1;
+
+	snprintf(cbm_path, sizeof(cbm_path), "%s/%s/cbm_mask",
+		 INFO_PATH, cache_type);
+
+	ret = get_bit_mask(cbm_path, mask);
+	if (ret || !*mask)
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


