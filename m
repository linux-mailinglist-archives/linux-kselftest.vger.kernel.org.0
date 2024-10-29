Return-Path: <linux-kselftest+bounces-20953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E619B4A6B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 14:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986F71F22DC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 13:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B5E206066;
	Tue, 29 Oct 2024 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZlKiDfP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830C206060;
	Tue, 29 Oct 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206832; cv=none; b=q1fS7/dlN3l3C+X0D6wWfMvtatPBZAbisI5NyO1eti8iHyowcHDpltma/itV2aBu9ysTQt7b5k8LAbpmRvU+CfIosVodfqGatsEmyGMcl4SLJrIGZ3k+WnVRV8nY/gR4/MM9OBzt2B++RzBXj1qXmhgDf/TTlbrEwNrxKAFWTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206832; c=relaxed/simple;
	bh=+HHj6G0f2BQQwdnwye133T9EZjZFFbrl8cBEAvNykjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sY8BAzhe5U3KkQQLSfx/SNHaN3QbwY/pARFBUgpznRJuZUNDqOSRiy/C8WwYRKB/vQyq7ePcTKZVZZ1J+n5uQFjboDxiLYqzd96CdQHk5/xPgVcY/1fvN9DtJTx3xg7W38yHoo8MWVi/0Xh9NrPzGl8PalP0XJ+Sp3T6ygkRC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZlKiDfP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730206829; x=1761742829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HHj6G0f2BQQwdnwye133T9EZjZFFbrl8cBEAvNykjY=;
  b=NZlKiDfPskguUtbYwiJciAzyO7Q91L/6gyIKJkn5NC1QhyrlZSfWmzSu
   QxACEOu21WtrHFWZmV6z0hEZ8AouYXqp55YuDGKSaeABGN7XAzqGQ9d+5
   CS6RomZvsdXK1DRqqjU87F6JdTZt3A8jffNgVf696/+yHmJF2F8/wTCgw
   hni0T4BgtTMa1mggQHFx8/CuIwZ6KfQ6XKnNureVpM8NPYKXO5u+Jw3ym
   mKL5o7hqWB7O7CPweWOXt/vtkx96X6PDY9oUlKJj97sR3/YsQmv0l0TIr
   /+Px9SzyjKat7iXwrZ35x3PRrqt+Ixt/E2jcc2DXP4nrOZZ/TeiLQTWAp
   g==;
X-CSE-ConnectionGUID: 7AEAcKzVRKmY7sbJEB1Vvg==
X-CSE-MsgGUID: b2I/TZihT46Ur43rUPZuwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29952475"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29952475"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 06:00:29 -0700
X-CSE-ConnectionGUID: 9F8Xxb86SHSsaTKA/2EMew==
X-CSE-MsgGUID: Ttw3OeNNQKi56/GuCbG1pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81584675"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.38])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 06:00:26 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v5 1/2] selftests/resctrl: Adjust effective L3 cache size with SNC enabled
Date: Tue, 29 Oct 2024 14:00:18 +0100
Message-ID: <06c8f3e64b8e59e031fc16a919373a0dfaa9516a.1730206468.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730206468.git.maciej.wieczor-retman@intel.com>
References: <cover.1730206468.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
nodes. Systems may support splitting into either two, three or four
nodes.

When SNC mode is enabled the effective amount of L3 cache available
for allocation is divided by the number of nodes per L3.

Detect which SNC mode is active by comparing the number of CPUs
that share a cache with CPU0, with the number of CPUs on node0.

Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v5:
- Set snc_mode to 1 at the start of if(!snc_mode) block.
- Move all resctrlfs.c code from patch 2/2 to this one. (Reinette)
- Fix Co-developed-by tag.
- Update SNC discovery comments for the case where it gets disabled by
  being unreliable.
- Remove exclamation mark from ksft_perror() and add full file path
  instead of "offline CPUs file".
- bit map -> bitmap.
- Remove unnecessary empty line.

Changelog v4:
- Make returned value a static local variable so the function only runs
  the logic once. (Reinette)

Changelog v3:
- Add comparison between present and online cpus to test if the
  calculated SNC mode is credible. (Reinette)
- Added comment to cache size modification to better explain why it is
  needed there. (Reinette)
- Fix facts in patch message. (Reinette)
- Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)

 tools/testing/selftests/resctrl/resctrl.h     |   4 +
 .../testing/selftests/resctrl/resctrl_tests.c |   8 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 132 ++++++++++++++++++
 3 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 2dda56084588..851b37c9c38a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -11,6 +11,7 @@
 #include <signal.h>
 #include <dirent.h>
 #include <stdbool.h>
+#include <ctype.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/mount.h>
@@ -43,6 +44,8 @@
 
 #define DEFAULT_SPAN		(250 * MB)
 
+#define MAX_SNC		4
+
 /*
  * user_params:		User supplied parameters
  * @cpu:		CPU number to which the benchmark will be bound to
@@ -120,6 +123,7 @@ extern volatile int *value_sink;
 
 extern char llc_occup_path[1024];
 
+int snc_nodes_per_l3_cache(void);
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
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
index 250c320349a7..d6384f404d95 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -13,6 +13,8 @@
 
 #include "resctrl.h"
 
+int snc_unreliable;
+
 static int find_resctrl_mount(char *buffer)
 {
 	FILE *mounts;
@@ -156,6 +158,93 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
 	return 0;
 }
 
+/*
+ * Count number of CPUs in a /sys bitmap
+ */
+static unsigned int count_sys_bitmap_bits(char *name)
+{
+	FILE *fp = fopen(name, "r");
+	int count = 0, c;
+
+	if (!fp)
+		return 0;
+
+	while ((c = fgetc(fp)) != EOF) {
+		if (!isxdigit(c))
+			continue;
+		switch (c) {
+		case 'f':
+			count++;
+		case '7': case 'b': case 'd': case 'e':
+			count++;
+		case '3': case '5': case '6': case '9': case 'a': case 'c':
+			count++;
+		case '1': case '2': case '4': case '8':
+			count++;
+		}
+	}
+	fclose(fp);
+
+	return count;
+}
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
+		ksft_perror("Could not read /sys/devices/system/cpu/offline");
+	}
+
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
+ * If some CPUs are offline the numbers may not be exact multiples of each
+ * other. Any offline CPUs on node0 will be also gone from shared_cpu_map of
+ * CPU0 but offline CPUs from other nodes will only make the cache_cpus value
+ * lower. Still try to get the ratio right by preventing the second possibility.
+ */
+int snc_nodes_per_l3_cache(void)
+{
+	int node_cpus, cache_cpus, i;
+	static int snc_mode;
+
+	if (!snc_mode) {
+		snc_mode = 1;
+		if (!cpus_offline_empty()) {
+			ksft_print_msg("Runtime SNC detection unreliable due to offline CPUs.\n");
+			ksft_print_msg("Setting SNC mode to disabled.\n");
+			snc_unreliable = 1;
+			return snc_mode;
+		}
+		node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
+		cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
+
+		if (!node_cpus || !cache_cpus) {
+			ksft_print_msg("Could not determine Sub-NUMA Cluster mode.\n");
+			return 1;
+		}
+		for (i = 1; i <= MAX_SNC ; i++) {
+			if (i * node_cpus >= cache_cpus) {
+				snc_mode = i;
+				break;
+			}
+		}
+	}
+
+	return snc_mode;
+}
+
 /*
  * get_cache_size - Get cache size for a specified CPU
  * @cpu_no:	CPU number
@@ -211,6 +300,17 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 			break;
 	}
 
+	/*
+	 * The amount of cache represented by each bit in the masks
+	 * in the schemata file is reduced by a factor equal to SNC
+	 * nodes per L3 cache.
+	 * E.g. on a SNC-2 system with a 100MB L3 cache a test that
+	 * allocates memory from its local SNC node (default behavior
+	 * without using libnuma) will only see 50 MB llc_occupancy
+	 * with a fully populated L3 mask in the schemata file.
+	 */
+	if (cache_num == 3)
+		*cache_size /= snc_nodes_per_l3_cache();
 	return 0;
 }
 
@@ -869,3 +969,35 @@ unsigned int count_bits(unsigned long n)
 
 	return count;
 }
+
+/**
+ * snc_kernel_support - Check for existence of mon_sub_L3_00 file that indicates
+ * SNC resctrl support on the kernel side.
+ *
+ * Return: 0 if not supported, 1 if SNC is disabled or SNC discovery is
+ * unreliable or SNC is both enabled and supported.
+ */
+int snc_kernel_support(void)
+{
+	char node_path[PATH_MAX];
+	struct stat statbuf;
+	int ret;
+
+	ret = snc_nodes_per_l3_cache();
+	/*
+	 * If SNC is disabled then its kernel support isn't important. If SNC
+	 * got disabled because the discovery process was unreliable the
+	 * snc_unreliable variable was set. It can be used to verify the SNC
+	 * discovery reliability elsewhere in the selftest.
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
2.46.2


