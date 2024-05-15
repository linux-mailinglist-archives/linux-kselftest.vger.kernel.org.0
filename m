Return-Path: <linux-kselftest+bounces-10256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D998C6569
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 13:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA5F1F23DBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAC36D1B2;
	Wed, 15 May 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1Lhsq6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF56EB4C;
	Wed, 15 May 2024 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715771934; cv=none; b=NVD9/HQrH/EyP4DzPDEXBDM/uYqL2H2p0sNYCUBHgWEvS7ZXBOqm4zbLGKpbweaWa3IJ2Rj18XomUzoI69yL78YkzG8UdiHeYC+78ZWlDg0U6dv2byf+LOzK+ipf9Z8K45BRlIs7UcJNqdCn8G4evJQRVMElSwsaPPrqwPW0heo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715771934; c=relaxed/simple;
	bh=ypmQgTTVuA6yQFrlp0e3Jm4SgrVCOEzrzTi78+uItIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoqUtjodN/JdWmUzlZNspl4x8MX80UUx32sEogWNnqH2n2+ghOpq8Fxk9Fe8bsv46Te6enYbx7IgvrNoXGl0igv9vY1k8z5Givunbnc/bbDY47g9olNbsUNr4cIrowTRjHnuRXdp0vbppBhhgVvbHFWdXMgOQn1VKaz5PwPfU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1Lhsq6u; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715771934; x=1747307934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ypmQgTTVuA6yQFrlp0e3Jm4SgrVCOEzrzTi78+uItIs=;
  b=D1Lhsq6uxOvKL/kyu1bEIiQZaRAnCchCOariTxK8B/3EzewyTMOFPKc7
   4BLsB03Pq+pEV24rUcsxkWjZtvxjJSpA00HJQfmjFlkaJJMEDqe0l171S
   jzZWrW7b3uWPVQYbNugfSxcpr3+hVePu5ewl1I6VeZIcLpPBKN21+mwsp
   sP8RRjRqdguMW/4pgqOQZNFuTMm8vskeF136DMNYWbXEwJrwXVqeqEDQF
   cTtuSMMU4x3A/TjchPhuwJBFRTvuMEMVGzKFT4EHbr/PUUHJnTtHs3P3k
   kpy59WianpV/tnSvQ7SRYq3V/kCJizXe0mJEfAqkfOthzlbHaxsY8qgeg
   A==;
X-CSE-ConnectionGUID: nLyMdaVTR0uSGvIUFRHqBQ==
X-CSE-MsgGUID: 99tsPHlWSw+BkIFwj07noA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22399428"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="22399428"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 04:18:53 -0700
X-CSE-ConnectionGUID: n7DBne7AT+GRpJ1utQrarQ==
X-CSE-MsgGUID: wFklm+3eSeisovWVteQwhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31609018"
Received: from unknown (HELO wieczorr-mobl1.intel.com) ([10.245.245.148])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 04:18:49 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	reinette.chatre@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v2 2/2] selftests/resctrl: Adjust SNC support messages
Date: Wed, 15 May 2024 13:18:38 +0200
Message-ID: <16764746e8f9f42cbd45d61210764a9b67085cbf.1715769576.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl selftest prints a message on test failure that Sub-Numa
Clustering (SNC) could be enabled and points the user to check theirs BIOS
settings. No actual check is performed before printing that message so
it is not very accurate in pinpointing a problem.

Figuring out if SNC is enabled is only one part of the problem, the
other being whether the kernel supports it. As there is no easy
interface that simply states SNC support in the kernel one can find that
information by comparing L3 cache sizes from different sources. Cache
size reported by /sys/devices/system/node/node0/cpu0/cache/index3/size
will always show the full cache size even if it's split by enabled SNC.
On the other hand /sys/fs/resctrl/size has information about L3 size,
that with kernel support is adjusted for enabled SNC.

Add a function to find a cache size from /sys/fs/resctrl/size since
finding that information from the other source is already implemented.

Add a function that compares the two cache sizes and use it to make the
SNC support message more meaningful.

Add the SNC support message just after MBA's check_results() since MBA
shares code with MBM and also can suffer from enabled SNC if there is no
support in the kernel.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Move snc_ways() checks from individual tests into
  snc_kernel_support().
- Write better comment for snc_kernel_support().

 tools/testing/selftests/resctrl/cat_test.c  |  2 +-
 tools/testing/selftests/resctrl/cmt_test.c  |  6 +-
 tools/testing/selftests/resctrl/mba_test.c  |  2 +
 tools/testing/selftests/resctrl/mbm_test.c  |  4 +-
 tools/testing/selftests/resctrl/resctrl.h   |  5 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 72 ++++++++++++++++++++-
 6 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index c7686fb6641a..722b4fcaf788 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -253,7 +253,7 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 		return ret;
 
 	/* Get L3/L2 cache size */
-	ret = get_cache_size(uparams->cpu, test->resource, &cache_total_size);
+	ret = get_sys_cache_size(uparams->cpu, test->resource, &cache_total_size);
 	if (ret)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_total_size);
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a44e6fcd37b7..0ff232d38c26 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -112,7 +112,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 	if (ret)
 		return ret;
 
-	ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
+	ret = get_sys_cache_size(uparams->cpu, "L3", &cache_total_size);
 	if (ret)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_total_size);
@@ -157,8 +157,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 		goto out;
 
 	ret = check_results(&param, span, n);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
 
 out:
 	free(span_str);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 5d6af9e8afed..74e1ebb14904 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -161,6 +161,8 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		return ret;
 
 	ret = check_results();
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 3059ccc51a5a..e542938272f9 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -129,8 +129,8 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		return ret;
 
 	ret = check_results(DEFAULT_SPAN);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 3dd5d6779786..2bd7c3f71733 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -28,6 +28,7 @@
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 #define INFO_PATH		"/sys/fs/resctrl/info"
+#define SIZE_PATH		"/sys/fs/resctrl/size"
 
 /*
  * CPU vendor IDs
@@ -165,12 +166,14 @@ unsigned long create_bit_mask(unsigned int start, unsigned int len);
 unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
 int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
-int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
 int resource_info_unsigned_get(const char *resource, const char *filename, unsigned int *val);
+int get_sys_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
+int get_resctrl_cache_size(const char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(const struct resctrl_test *test);
 void signal_handler_unregister(void);
 unsigned int count_bits(unsigned long n);
+int snc_kernel_support(void);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index e4d3624a8817..88f97db72246 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -214,14 +214,14 @@ int snc_ways(void)
 }
 
 /*
- * get_cache_size - Get cache size for a specified CPU
+ * get_sys_cache_size - Get cache size for a specified CPU
  * @cpu_no:	CPU number
  * @cache_type:	Cache level L2/L3
  * @cache_size:	pointer to cache_size
  *
  * Return: = 0 on success, < 0 on failure.
  */
-int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size)
+int get_sys_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size)
 {
 	char cache_path[1024], cache_str[64];
 	int length, i, cache_num;
@@ -273,6 +273,44 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 	return 0;
 }
 
+/*
+ * get_resctrl_cache_size - Get cache size as reported by resctrl
+ * @cache_type:	Cache level L2/L3
+ * @cache_size:	pointer to cache_size
+ *
+ * Return: = 0 on success, < 0 on failure.
+ */
+int get_resctrl_cache_size(const char *cache_type, unsigned long *cache_size)
+{
+	char line[256], cache_prefix[16], *stripped_line, *token;
+	size_t len;
+	FILE *fp;
+
+	strcpy(cache_prefix, cache_type);
+	strncat(cache_prefix, ":", 1);
+
+	fp = fopen(SIZE_PATH, "r");
+	if (!fp) {
+		ksft_print_msg("Failed to open %s : '%s'\n",
+			       SIZE_PATH, strerror(errno));
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		stripped_line = strstr(line, cache_prefix);
+
+		if (stripped_line) {
+			len = strlen(cache_prefix);
+			stripped_line += len;
+			token = strtok(stripped_line, ";");
+			if (sscanf(token, "0=%lu", cache_size) <= 0)
+				return -1;
+		}
+	}
+	fclose(fp);
+	return 0;
+}
+
 #define CORE_SIBLINGS_PATH	"/sys/bus/cpu/devices/cpu"
 
 /*
@@ -935,3 +973,33 @@ unsigned int count_bits(unsigned long n)
 
 	return count;
 }
+
+/**
+ * snc_kernel_support - Compare system reported cache size and resctrl
+ * reported cache size to get an idea if SNC is supported on the kernel side.
+ *
+ * Return: 0 if not supported, 1 if SNC is disabled or SNC is both enabled and
+ * supported, < 0 on failure.
+ */
+int snc_kernel_support(void)
+{
+	unsigned long resctrl_cache_size, node_cache_size;
+	int ret;
+
+	/* If SNC is disabled then its kernel support isn't important. */
+	if (snc_ways() == 1)
+		return 1;
+
+	ret = get_sys_cache_size(0, "L3", &node_cache_size);
+	if (ret < 0)
+		return ret;
+
+	ret = get_resctrl_cache_size("L3", &resctrl_cache_size);
+	if (ret < 0)
+		return ret;
+
+	if (resctrl_cache_size == node_cache_size)
+		return 1;
+
+	return 0;
+}
-- 
2.45.0


