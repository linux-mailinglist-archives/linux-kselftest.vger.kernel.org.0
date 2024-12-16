Return-Path: <linux-kselftest+bounces-23422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED2E9F3450
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 16:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DC118825A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2287A1474D3;
	Mon, 16 Dec 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRKQhOZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B265647F;
	Mon, 16 Dec 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362403; cv=none; b=QM2ncxAFiGZ14fR3rZPlMZCYyGJwMVSMOgt5Fbn4wMgKdPBQbILC0cgWhusiTQGuQ04Ru1ipv8fxL9MX02Jyz9gYT6YhkEcB5fPiM6jvZAlr1Uo4nFFCkMl80Ad6LAaegdB0ZbiiNN28y0oj5gcJX9oc8mpAYcVlMsVimEqjolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362403; c=relaxed/simple;
	bh=aa5G3Hl9axFs9t6oSOMmumgeDbFb/Jii00sD1Tcm+00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT44fjhgpbbjOFL6wwM/Dcet8XTelpFE/oZiRQzgpv0+13vKJ5oS6DbK7vL5kny83XHec8Q7ebH/Xies/AnexUEGzHtPiQQuTucW6Meok6k3AzzPVMrktptlrIYov3DKZfuvs3Ho9NqvHILyDRMj7v9d5r9Tp38hiXVYiONNSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRKQhOZS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734362398; x=1765898398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aa5G3Hl9axFs9t6oSOMmumgeDbFb/Jii00sD1Tcm+00=;
  b=FRKQhOZSwL8I+2cwNfjrC6+jsS6/zZ3xD8UZyef/nLBm8Hq+r9s5+PkT
   NYzdqYCLEcfkO0ioqemkW9zhYK7Z17tAVvMEiJ3YzSbx95pxmElFaXV/w
   pjKA+/cPCQo2JQ/G0tw/mJnCMK3IzJK0BQbzYkaR7k5AKX1tLr6rK6zLI
   xgxbk8xSDIHOcV66O3FLBjsFYCnNq8/hTHViATWy2+cQegRhpLyKWzvX3
   JyxPa/xSG8Ocrht1/RrfYmBAYhDzsgJ2llDD4RKnezzu88L7Eqh7uc960
   Sgvp/JaQAA9u5dHvtfaeOfNiUDX2qNOdUYajk5mHutpKcDie44uFd4rFi
   g==;
X-CSE-ConnectionGUID: Qul/NwsyTtGH4mxaaKm4DQ==
X-CSE-MsgGUID: lkSdX8cnTO29Csqzhc0qng==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52272206"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="52272206"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:19:27 -0800
X-CSE-ConnectionGUID: 08MA9GY+QaGgeORialJnsQ==
X-CSE-MsgGUID: tvcnscnQRr6ALweqazrWGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101375783"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:19:25 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	fenghua.yu@intel.com,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	maciej.wieczor-retman@intel.com
Subject: [PATCH v8 1/2] selftests/resctrl: Adjust effective L3 cache size with SNC enabled
Date: Mon, 16 Dec 2024 16:18:53 +0100
Message-ID: <83dcba6a462ec010a3c80bd8c6d66f49502b75ae.1734361935.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
References: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
nodes. Systems may support splitting into either two, three, four or six
nodes. When SNC mode is enabled the effective amount of L3 cache
available for allocation is divided by the number of nodes per L3.

It's possible to detect which SNC mode is active by comparing the number
of CPUs that share a cache with CPU0, with the number of CPUs on node0.

Detect SNC mode once and let other tests inherit that information.

Update CFLAGS after including lib.mk in the Makefile so that fallthrough
macro can be used.

To check if SNC detection is reliable one can check the
/sys/devices/system/cpu/offline file. If it's empty, it means all cores
are operational and the ratio should be calculated correctly. If it has
any contents, it means the detected SNC mode can't be trusted and should
be disabled.

Check if detection was not reliable due to offline cpus. If it was skip
running tests since the results couldn't be trusted.

Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v8:
- Fix Makefile changes by only modifying CFLAGS after including lib.mk.

Changelog v7:
- Check return value when opening empty cpus file.
- Add protection against overflow when reading string into buffer from
  empty cpus file.
- Include fallthrough macro into resctrl selftests and use it in the bit
  counting function.
- Remove function usage suggestion from comment.

Changelog v6:
- Redo snc_nodes_per_l3_cache() by removing old logic and taking into
  account existance of cpus_offline_empty().
- Remove MAX_SNC since now we just divide cache cpus by node cpus
  instead of trying to estimate the ratio.
- Skip tests if snc_unreliable was set and get_vendor() returns
  ARCH_INTEL.
- Move extern int snc_unreliable; from the next patch to this one since
  it's needed here already.
- Set snc_unreliable if node or cache cpus cannot be counted for some
  reason.
- Redo patch message after code changes.

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

 tools/testing/selftests/resctrl/Makefile      |   1 +
 tools/testing/selftests/resctrl/resctrl.h     |   5 +
 .../testing/selftests/resctrl/resctrl_tests.c |   9 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 105 ++++++++++++++++++
 4 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index f408bd6bfc3d..984534cfbf1b 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -8,5 +8,6 @@ TEST_GEN_PROGS := resctrl_tests
 LOCAL_HDRS += $(wildcard *.h)
 
 include ../lib.mk
+CFLAGS += -I$(top_srcdir)/tools/include
 
 $(OUTPUT)/resctrl_tests: $(wildcard *.c)
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index dab1953fc7a0..35fa3afee9c3 100644
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
@@ -21,6 +22,7 @@
 #include <sys/eventfd.h>
 #include <asm/unistd.h>
 #include <linux/perf_event.h>
+#include <linux/compiler.h>
 #include "../kselftest.h"
 
 #define MB			(1024 * 1024)
@@ -156,8 +158,11 @@ struct perf_event_read {
  */
 extern volatile int *value_sink;
 
+extern int snc_unreliable;
+
 extern char llc_occup_path[1024];
 
+int snc_nodes_per_l3_cache(void);
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3335af815b21..5154ffd821c4 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -118,7 +118,7 @@ static bool test_vendor_specific_check(const struct resctrl_test *test)
 
 static void run_single_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
-	int ret;
+	int ret, snc_mode;
 
 	if (test->disabled)
 		return;
@@ -128,8 +128,15 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
 		return;
 	}
 
+	snc_mode = snc_nodes_per_l3_cache();
+
 	ksft_print_msg("Starting %s test ...\n", test->name);
 
+	if (snc_mode == 1 && snc_unreliable && get_vendor() == ARCH_INTEL) {
+		ksft_test_result_skip("SNC detection unreliable due to offline CPUs. Test results may not be accurate if SNC enabled.\n");
+		return;
+	}
+
 	if (test_prepare(test)) {
 		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index d38d6dd90be4..dc7ce3cbdb27 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -13,6 +13,8 @@
 
 #include "resctrl.h"
 
+int snc_unreliable;
+
 static int find_resctrl_mount(char *buffer)
 {
 	FILE *mounts;
@@ -156,6 +158,98 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
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
+			fallthrough;
+		case '7': case 'b': case 'd': case 'e':
+			count++;
+			fallthrough;
+		case '3': case '5': case '6': case '9': case 'a': case 'c':
+			count++;
+			fallthrough;
+		case '1': case '2': case '4': case '8':
+			count++;
+			break;
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
+	if (!fp) {
+		ksft_perror("Could not open /sys/devices/system/cpu/offline");
+		return 0;
+	}
+
+	if (fscanf(fp, "%63s", offline_cpus_str) < 0) {
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
+ * If any CPUs are offline declare the detection as unreliable.
+ */
+int snc_nodes_per_l3_cache(void)
+{
+	int node_cpus, cache_cpus;
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
+			snc_unreliable = 1;
+			return snc_mode;
+		}
+		snc_mode = cache_cpus / node_cpus;
+
+		if (snc_mode > 1)
+			ksft_print_msg("SNC-%d mode discovered.\n", snc_mode);
+	}
+
+	return snc_mode;
+}
+
 /*
  * get_cache_size - Get cache size for a specified CPU
  * @cpu_no:	CPU number
@@ -211,6 +305,17 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
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
 
-- 
2.47.1


