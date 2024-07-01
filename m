Return-Path: <linux-kselftest+bounces-13011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC7F91E23C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 16:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7331D288450
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6DF161337;
	Mon,  1 Jul 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETtuDGYY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45989161307;
	Mon,  1 Jul 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843556; cv=none; b=GA/a3tCyh2gOFIIGuNMtNkEGYaRZvZkKqrRXdJ6iSLB56U86PnDnQq78EiyzE5syscye1W7iSjHZZdKNma21SFWv16KpvogUzYfVdCGLdr/mTpHnuSXSWlJ5AcgBky1Y6vno5rCEr1LjHCQjgvt2t9PDQgegacEOH+PBtlGO2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843556; c=relaxed/simple;
	bh=OfYOQCOL9NdaootiA7HTTmURWMghZvVa12L5QuiI9w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIvqFaBlezkv/KBPB978YlVqgKvCkRxCAX+t9kVrvgEKKJ7dZDhmXVaueU5EFCAdINFxCDu5CG1Y9/vs3bLCDsZh5BTCkleFOBYdWVNmptuo1SUsWyn1CWRsDodaMGkdF6NIplI0UyaGd335HvfUZNv2aCffkpwDBAXjV636uH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETtuDGYY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719843555; x=1751379555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OfYOQCOL9NdaootiA7HTTmURWMghZvVa12L5QuiI9w4=;
  b=ETtuDGYYipvb7l5NhJMsdzB6MVNWFj13/b9doUGQ8V+WwrgSCM6OcX45
   y2nt7BKXUtJzsTSys5M4ubM+6a4om7WrB+FnCrmVtrZOUmzlOg9mlKbcO
   p+ajLktINNUo81qiHn2+FxEtZdPKmk9btydWJG0HrhHKF9D2YoFDEcYBu
   Z+5rOWOA3o+nt58MhIvCoLVPVE/aiOjYftQ7tDMV4sitvMsolcyyCObdp
   bB4C2rq2l8G1QgQWeb0YyvZtKJYphLNHLmuJgHOIYpOyVc/LCOaNxyLVj
   5bbZwkgvfa7ukq4tb9J7JluGuL0Gu+NFQvKjiTMpDdZ8fv85y/Merwlwd
   w==;
X-CSE-ConnectionGUID: KwWFwCzOT5y3C2BR2SDA/w==
X-CSE-MsgGUID: fwQ+ke/IQ7yfaE5zM8NhHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28367221"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="28367221"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 07:19:11 -0700
X-CSE-ConnectionGUID: RwqaLPTGSxiiT8O8FeNSqw==
X-CSE-MsgGUID: 6s3a+mhnSg6yqPoPnZhsjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45966322"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.21])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 07:19:08 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	reinette.chatre@intel.com,
	fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
Date: Mon,  1 Jul 2024 16:18:51 +0200
Message-ID: <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
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
others being whether the detected SNC mode is reliable and whether the
kernel supports SNC in resctrl.

When there is SNC support for kernel's resctrl subsystem and SNC is
enabled then sub node files are created for each node in the resctrlfs.
The sub node files exist in each regular node's L3 monitoring directory.
The reliable path to check for existence of sub node files is
/sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_00.

To check if SNC detection is reliable one can check the
/sys/devices/system/cpu/offline file. If it's empty, it means all cores
are operational and the ratio should be calculated correctly. If it has
any contents, it means the detected SNC mode can't be trusted and should
be disabled.

Add helpers for detecting SNC mode and checking its reliability.

Detect SNC mode once and let other tests inherit that information.

Add messages to alert the user when SNC detection could return incorrect
results.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v3:
- Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)
- Add printing the discovered SNC mode. (Reinette)
- Change method of kernel support discovery from cache sizes to
  existance of sub node files.
- Check if SNC detection is unreliable.
- Move SNC detection to only the first run_single_test() instead on
  error at the end of test runs.
- Add global value to remind user at the end of relevant tests if SNC
  detection was found to be unreliable.
- Redo the patch message after the changes.

Changelog v2:
- Move snc_ways() checks from individual tests into
  snc_kernel_support().
- Write better comment for snc_kernel_support().

 tools/testing/selftests/resctrl/cache.c       |  3 +
 tools/testing/selftests/resctrl/cmt_test.c    |  4 +-
 tools/testing/selftests/resctrl/mba_test.c    |  4 ++
 tools/testing/selftests/resctrl/mbm_test.c    |  6 +-
 tools/testing/selftests/resctrl/resctrl.h     |  4 ++
 .../testing/selftests/resctrl/resctrl_tests.c |  7 ++
 tools/testing/selftests/resctrl/resctrlfs.c   | 70 ++++++++++++++++++-
 7 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 1ff1104e6575..9885d64b8a21 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -186,4 +186,7 @@ void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool
 	ksft_print_msg("Average LLC val: %llu\n", avg_llc_val);
 	ksft_print_msg("Cache span (%s): %zu\n", lines ? "lines" : "bytes",
 		       cache_span);
+	if (snc_unreliable)
+		ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");
+
 }
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 0c045080d808..588543ae2654 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -175,8 +175,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 		goto out;
 
 	ret = check_results(&param, span, n);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
 
 out:
 	free(span_str);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index ab8496a4925b..c91e85f11285 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -108,6 +108,8 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 		ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
 		ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 		ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
+		if (snc_unreliable)
+			ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");
 		if (avg_diff_per > MAX_DIFF_PERCENT)
 			ret = true;
 	}
@@ -179,6 +181,8 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		return ret;
 
 	ret = check_results();
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 6b5a3b52d861..562b02118270 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -43,6 +43,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 	ksft_print_msg("Span (MB): %zu\n", span / MB);
 	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
+	if (snc_unreliable)
+		ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");
 
 	return ret;
 }
@@ -147,8 +149,8 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		return ret;
 
 	ret = check_results(DEFAULT_SPAN);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 851b37c9c38a..fa44e1cde21b 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -121,10 +121,13 @@ struct perf_event_read {
  */
 extern volatile int *value_sink;
 
+extern int snc_unreliable;
+
 extern char llc_occup_path[1024];
 
 int snc_nodes_per_l3_cache(void);
 int get_vendor(void);
+int get_snc_mode(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
 int get_domain_id(const char *resource, int cpu_no, int *domain_id);
@@ -167,6 +170,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(const struct resctrl_test *test);
 void signal_handler_unregister(void);
 unsigned int count_bits(unsigned long n);
+int snc_kernel_support(void);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index ecbb7605a981..b17560bbaf5c 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -12,6 +12,7 @@
 
 /* Volatile memory sink to prevent compiler optimizations */
 static volatile int sink_target;
+static int snc_mode;
 volatile int *value_sink = &sink_target;
 
 static struct resctrl_test *resctrl_tests[] = {
@@ -123,6 +124,12 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
 	if (test->disabled)
 		return;
 
+	if (!snc_mode) {
+		snc_mode = get_snc_mode();
+		if (snc_mode > 1)
+			ksft_print_msg("SNC-%d mode discovered!\n", snc_mode);
+	}
+
 	if (!test_vendor_specific_check(test)) {
 		ksft_test_result_skip("Hardware does not support %s\n", test->name);
 		return;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 18a31a2ba7b3..004fb6649789 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -13,6 +13,8 @@
 
 #include "resctrl.h"
 
+int snc_unreliable;
+
 static int find_resctrl_mount(char *buffer)
 {
 	FILE *mounts;
@@ -280,7 +282,7 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 	 * with a fully populated L3 mask in the schemata file.
 	 */
 	if (cache_num == 3)
-		*cache_size /= snc_nodes_per_l3_cache();
+		*cache_size /= get_snc_mode();
 	return 0;
 }
 
@@ -939,3 +941,69 @@ unsigned int count_bits(unsigned long n)
 
 	return count;
 }
+
+static bool cpus_offline_empty(void)
+{
+	char offline_cpus_str[64];
+	FILE *fp;
+
+	fp = fopen("/sys/devices/system/cpu/offline", "r");
+	if (fscanf(fp, "%s", offline_cpus_str) < 0) {
+		if (!errno) {
+			fclose(fp);
+			return 1;
+		}
+		ksft_perror("Could not read offline CPUs file!");
+	}
+
+	fclose(fp);
+
+	return 0;
+}
+
+int get_snc_mode(void)
+{
+	static int snc_mode;
+
+	if (!snc_mode) {
+		snc_mode = snc_nodes_per_l3_cache();
+		if (!cpus_offline_empty()) {
+			ksft_print_msg("Runtime SNC detection unreliable due to offline CPUs!\n");
+			ksft_print_msg("Setting SNC mode to disabled.\n");
+			snc_mode = 1;
+			snc_unreliable = 1;
+		}
+	}
+
+	return snc_mode;
+}
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
+	char node_path[PATH_MAX];
+	struct stat statbuf;
+	int ret;
+
+	ret = get_snc_mode();
+	/*
+	 * If SNC is disabled then its kernel support isn't important. If value
+	 * is smaller than 1 an error happened.
+	 */
+	if (ret <= 1)
+		return ret;
+
+	snprintf(node_path, sizeof(node_path), "%s/%s/%s", RESCTRL_PATH, "mon_data",
+		 "mon_L3_00/mon_sub_L3_00");
+
+	if (!stat(node_path, &statbuf))
+		return 1;
+
+	return 0;
+}
-- 
2.45.2


