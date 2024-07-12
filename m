Return-Path: <linux-kselftest+bounces-13667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BEB92F785
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 11:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76952284A19
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF93143732;
	Fri, 12 Jul 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLJSCWoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F3143C5C;
	Fri, 12 Jul 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775093; cv=none; b=OyUZwRBeXwiXt/3sTuNhAga4N5NYGadfI1K6LGzL9yEDSAj43Z4OTbmHCfGGSS+I1NTK6BnISBd/JctuCAAKzj14lr5zLNMrdBch8UM/qLAuobAJ7a83RX6v/QIVA1TbsB5h4tGunmFn2aNqahzgWLhtP5YIo/6rV225JnH9gDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775093; c=relaxed/simple;
	bh=0+fgMifr0gmoYZFNccD7HXPgEjE1eR0vEQY840VBkrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxxIvSKj3KmGmlWv2H3zClLHjWDSQtHTtr4bsvIEafbZvgbeIDX7lckPj8P+HE8/GzeuQiuRauNHGpEJ9VPflgt0M9PoEYrHKihzU/3RW8iljXuxfApZGwF9xpkdBdegAS7v/nFDEB8eEEtsIye7hf2wdSG7bMbjvek1qn8msMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLJSCWoP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720775092; x=1752311092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0+fgMifr0gmoYZFNccD7HXPgEjE1eR0vEQY840VBkrA=;
  b=PLJSCWoPgjLMRIUnhSxl/Zc7V9lQXSFP1/4+ZKhA/yKkC6ktxXP+ApOK
   l1j+BqZWGFL0LWjnd3G5Ch7KBaVOL5NfdMIxxX5UnEJoBndUuawmkyYzE
   JPjbtqy1BoR6kJrLofwA5oHuZfwNHLpTxhFDXHoAy5M9BLgkJB1dTe1r4
   SHSrYksTQ6+hOWkFdWfhNf8S71Qr6DitlxdNLXQRbZUEJ9aD7H6B3DP/p
   +oEppNLNMsupb6SqnM3FjlWk+1d9NvHalNZLD9JhPGJfP3YWxYZ38YPH+
   pqdjrFM1fwOrMzmKt5xrznF7AqK7IK9aZSG36et1AEQcgYCtFbQ6bJ5K1
   A==;
X-CSE-ConnectionGUID: zw7aEuPbTPa3HIcmHrGQ1Q==
X-CSE-MsgGUID: W2R9rlrKRWeCuQOqD/z1wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="40731109"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="40731109"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:04:51 -0700
X-CSE-ConnectionGUID: RzlN50l+TNOLzcz41glhxQ==
X-CSE-MsgGUID: GNFnqbqlRH+ndREu5422Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53686650"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.74])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:04:49 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v4 2/2] selftests/resctrl: Adjust SNC support messages
Date: Fri, 12 Jul 2024 11:04:39 +0200
Message-ID: <1fb2703ee27a0dfa13a7aa501b81439c433521ea.1720774981.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720774981.git.maciej.wieczor-retman@intel.com>
References: <cover.1720774981.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl selftest prints a message on test failure that Sub-Numa
Clustering (SNC) could be enabled and points the user to check their BIOS
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

Add helpers for all operations mentioned above.

Detect SNC mode once and let other tests inherit that information.

Add messages to alert the user when SNC detection could return incorrect
results. Correct old messages to account for kernel support of SNC in
resctrl.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v4:
- Change messages at the end of tests and at the start of
  run_single_test. (Reinette)
- Add messages at the end of CAT since it can also fail due to enabled
  SNC + lack of kernel support.
- Remove snc_mode global variable. (Reinette)
- Fix wrong description of snc_kernel_support(). (Reinette)
- Move call to cpus_offline_empty() into snc_nodes_per_l3_cache() so the
  whole detection flow is in one place as discussed. (Reinette)

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

 tools/testing/selftests/resctrl/cat_test.c    |  8 +++
 tools/testing/selftests/resctrl/cmt_test.c    | 10 +++-
 tools/testing/selftests/resctrl/mba_test.c    |  7 +++
 tools/testing/selftests/resctrl/mbm_test.c    |  9 ++-
 tools/testing/selftests/resctrl/resctrl.h     |  3 +
 .../testing/selftests/resctrl/resctrl_tests.c |  8 ++-
 tools/testing/selftests/resctrl/resctrlfs.c   | 57 +++++++++++++++++++
 7 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index d4dffc934bc3..a8bb49f56755 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -285,6 +285,14 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 	ret = check_results(&param, test->resource,
 			    cache_total_size, full_cache_mask, start_mask);
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
+
+	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
+		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
+		ksft_print_msg("Intel CAT may be inaccurate.\n");
+	}
+
 	return ret;
 }
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 0c045080d808..471e134face0 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -175,8 +175,14 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 		goto out;
 
 	ret = check_results(&param, span, n);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
+
+	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
+		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
+		ksft_print_msg("Intel CMT may be inaccurate.\n");
+	}
+
 
 out:
 	free(span_str);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index ab8496a4925b..a805c14fe04b 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -179,6 +179,13 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		return ret;
 
 	ret = check_results();
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
+
+	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
+		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
+		ksft_print_msg("Intel MBA may be inaccurate.\n");
+	}
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 6b5a3b52d861..ce3c86989f8b 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -147,8 +147,13 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		return ret;
 
 	ret = check_results(DEFAULT_SPAN);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
+
+	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
+		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
+		ksft_print_msg("Intel MBM may be inaccurate.\n");
+	}
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 851b37c9c38a..488bdca01e4f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -121,6 +121,8 @@ struct perf_event_read {
  */
 extern volatile int *value_sink;
 
+extern int snc_unreliable;
+
 extern char llc_occup_path[1024];
 
 int snc_nodes_per_l3_cache(void);
@@ -167,6 +169,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(const struct resctrl_test *test);
 void signal_handler_unregister(void);
 unsigned int count_bits(unsigned long n);
+int snc_kernel_support(void);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index ecbb7605a981..4b84d6199a36 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -118,11 +118,17 @@ static bool test_vendor_specific_check(const struct resctrl_test *test)
 
 static void run_single_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
-	int ret;
+	int ret, snc_mode;
 
 	if (test->disabled)
 		return;
 
+	snc_mode = snc_nodes_per_l3_cache();
+	if (snc_mode > 1)
+		ksft_print_msg("SNC-%d mode discovered.\n", snc_mode);
+	else if (snc_unreliable)
+		ksft_print_msg("SNC detection unreliable due to offline CPUs. Test results may not be accurate if SNC enabled.\n");
+
 	if (!test_vendor_specific_check(test)) {
 		ksft_test_result_skip("Hardware does not support %s\n", test->name);
 		return;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 803dd415984c..4d0dbb332b8f 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -13,6 +13,8 @@
 
 #include "resctrl.h"
 
+int snc_unreliable;
+
 static int find_resctrl_mount(char *buffer)
 {
 	FILE *mounts;
@@ -186,6 +188,25 @@ static unsigned int count_sys_bitmap_bits(char *name)
 	return count;
 }
 
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
 /*
  * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
  * If some CPUs are offline the numbers may not be exact multiples of each
@@ -199,6 +220,13 @@ int snc_nodes_per_l3_cache(void)
 	static int snc_mode;
 
 	if (!snc_mode) {
+		if (!cpus_offline_empty()) {
+			ksft_print_msg("Runtime SNC detection unreliable due to offline CPUs.\n");
+			ksft_print_msg("Setting SNC mode to disabled.\n");
+			snc_mode = 1;
+			snc_unreliable = 1;
+			return snc_mode;
+		}
 		node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
 		cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
 
@@ -942,3 +970,32 @@ unsigned int count_bits(unsigned long n)
 
 	return count;
 }
+
+/**
+ * snc_kernel_support - Check for existence of mon_sub_L3_00 file that indicates
+ * SNC resctrl support on the kernel side.
+ *
+ * Return: 0 if not supported, 1 if SNC is disabled or SNC is both enabled and
+ * supported.
+ */
+int snc_kernel_support(void)
+{
+	char node_path[PATH_MAX];
+	struct stat statbuf;
+	int ret;
+
+	ret = snc_nodes_per_l3_cache();
+	/*
+	 * If SNC is disabled then its kernel support isn't important.
+	 */
+	if (ret == 1)
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


