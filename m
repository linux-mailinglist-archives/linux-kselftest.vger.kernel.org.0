Return-Path: <linux-kselftest+bounces-5995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764D87347F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 11:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9E01C2347A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5A60B91;
	Wed,  6 Mar 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8M6s2aK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4278E60884;
	Wed,  6 Mar 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721623; cv=none; b=CmCfXgbSE7rXoubYey5HbSQPFGEhPuZv8SO2vp5QxsWKdopkw1litETUx0Y5vwPyJA32lKwmepHw5+pzUijNry27KiqnrKctmo4Rhf181mz8dqnNxI6gX79UAd6hTh0uWO+g5uR4jkHy7dqjnP8KBeDOi4rtNIYU27FS22iJjX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721623; c=relaxed/simple;
	bh=l02LUWZ0uZyyld4Sn9bjwcmqKToiN7adxC+/gtNEed8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWoBXkiF63pUcZ3/zuXX21z4cqBVqLYXTMakVq5aYX3ZFUsZr38RhY728nbLt4jDasEsqpKVMxqyjtGqET3s5EC6siu4jZutmqU14AW59mbA2Q3pOGq7GCiX+Zctz9Y1XKFeZICmVPvbQMcOWohodZiakK/gdFinCVgYQrJs4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8M6s2aK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709721621; x=1741257621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l02LUWZ0uZyyld4Sn9bjwcmqKToiN7adxC+/gtNEed8=;
  b=Y8M6s2aKNQNcYXbzqgjcxECufv6pKGIIyJrqkkkRvfOQkfNdo3hnehlA
   jhnb622en5R3QEfu5/M7Vgz/hxBrP2lwONY0ZR68fXi2CkqVoMugwB+gk
   i7T5LhM99v93CmJERbhQR2cdXZtH/1GASA+s2lAMjKKQZvgK0Rc5F6BtL
   tCHRUoJrJrrviffjggFvPVX5xglOw4502CBUzxdTsvAbjoqDvbfxsWHKG
   OLIlNEePl700OVUw1LRzawktWnnlDAPxpOo5XGADDTtKkpjr6+/aqqTz7
   ls9dS3h2r86mZzHwyqsk0NIbVN1apmuvKVRoZsgIspPhcsUsG25vA8rhz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4497610"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4497610"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:40:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9803790"
Received: from ksznyce-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.25.14])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:40:10 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Date: Wed,  6 Mar 2024 11:39:21 +0100
Message-ID: <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
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
 tools/testing/selftests/resctrl/cat_test.c  |  2 +-
 tools/testing/selftests/resctrl/cmt_test.c  |  6 +-
 tools/testing/selftests/resctrl/mba_test.c  |  2 +
 tools/testing/selftests/resctrl/mbm_test.c  |  4 +-
 tools/testing/selftests/resctrl/resctrl.h   |  5 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 69 ++++++++++++++++++++-
 6 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 4cb991be8e31..1cdaadf35f03 100644
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
index a81f91222a89..b7cada602484 100644
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
+	if (ret && (get_vendor() == ARCH_INTEL) && snc_ways() > 1 && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
 
 out:
 	cmt_test_cleanup();
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index fc31a61dab0c..89fe3ecbf497 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -160,6 +160,8 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		goto out;
 
 	ret = check_results();
+	if (ret && (get_vendor() == ARCH_INTEL) && snc_ways() > 1 && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
 
 out:
 	mba_test_cleanup();
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d67ffa3ec63a..e12b4b06f6d5 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -129,8 +129,8 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		goto out;
 
 	ret = check_results(DEFAULT_SPAN);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && snc_ways() > 1 && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
 
 out:
 	mbm_test_cleanup();
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 178fb2eab13a..038e1269a3fc 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -28,6 +28,7 @@
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 #define INFO_PATH		"/sys/fs/resctrl/info"
+#define SIZE_PATH		"/sys/fs/resctrl/size"
 
 /*
  * CPU vendor IDs
@@ -168,14 +169,16 @@ unsigned long create_bit_mask(unsigned int start, unsigned int len);
 unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
 int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
-int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
 int resource_info_unsigned_get(const char *resource, const char *filename, unsigned int *val);
+int get_sys_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
+int get_resctrl_cache_size(const char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
 void cat_test_cleanup(void);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
+int snc_kernel_support(void);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index e4d3624a8817..dbd10cb7abf5 100644
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
@@ -935,3 +973,30 @@ unsigned int count_bits(unsigned long n)
 
 	return count;
 }
+
+/**
+ * snc_kernel_support - Compare system reported cache size and resctrl
+ * reported cache size to get an idea if SNC is supported on the kernel side.
+ * If SNC is enabled and the kernel does support it the value should be equal.
+ * If the kernel doesn't support SNC the.
+ *
+ * Return: 0 if not supported, 1 if supported, < 0 on failure.
+ */
+int snc_kernel_support(void)
+{
+	unsigned long resctrl_cache_size, node_cache_size;
+	int ret;
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
2.44.0


