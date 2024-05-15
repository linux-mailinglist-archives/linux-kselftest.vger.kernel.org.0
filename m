Return-Path: <linux-kselftest+bounces-10255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39138C6567
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 13:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A491C21ADF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F736D1B9;
	Wed, 15 May 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsWEHLzq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742063511;
	Wed, 15 May 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715771920; cv=none; b=BvvybodZDp39+HtFGD2eGJ0pq12kgbPgiUxY3zKRf0y/8wadug6R99e5wNP9H+44RSn19k5d5U35/BGatjO7etIH2KeGL7OBHWWGgCrnq7wn4ihvrSAHdbaFXVINxuHTpJ+mElMnGx9hzOztrCeJLW1TyiwwQzKqBQOtgyRhq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715771920; c=relaxed/simple;
	bh=Y7IQI7PBVsR9dGS8sJ/7OWx+WCDZtYU57gfmCodVz58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCsvxj9/1CV6RJJ7QnyWcQEwNM2raQs69ODta72XGt+/akyj1DMcQLQAsmPCuTNLn0QB2LY+S/LHVkC5zXeJqohA+r29O3yCMMfwmX4y3c7HCF/dirW5UHxyqkrNGiPRJTPvXmyVv03Px8JAcJ2B/Vgudj4MeLleOscxN2PNp0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsWEHLzq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715771919; x=1747307919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y7IQI7PBVsR9dGS8sJ/7OWx+WCDZtYU57gfmCodVz58=;
  b=dsWEHLzqgfjEcqGM5QIlBTa1Qg1pkG6Ubn8chIi2dM7l1IY6a3lxU3sE
   x4NPVO0cRBKTmykiZF63/jkSCiHU0XmKvNHhEq0aLlMquef/Sq6Ve0D/C
   tfqBLUaSUuB2UjjwatH+h59slK/c4R3EtOLlfwZhhMjfCavsRLcHVAOky
   XkgxQZSjJ7qeab9SiDtHM616cx26EHaRgkdI1Kb7VmDgSieyccSgcL8sP
   9akI9IVWxTUeq8jscEBnjZsqEN3zjaq0NBzUN87nGSQTiTocdhsKAtZc2
   ux46Z6PG2mQ0rSFYzZe0QAgkyq3+ON/zImSMH+LjbrX+bB77AogPw4+qP
   Q==;
X-CSE-ConnectionGUID: wkGpTVpGSNSghXpjTGg1dA==
X-CSE-MsgGUID: n7q5KPUQRqm5pA7UalAAZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29305083"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="29305083"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 04:18:38 -0700
X-CSE-ConnectionGUID: 4ErXPwoCTV2ydBLR7sBCNw==
X-CSE-MsgGUID: 2fGtGfZfQ2evtbo0lrTxZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35900930"
Received: from unknown (HELO wieczorr-mobl1.intel.com) ([10.245.245.148])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 04:18:35 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	reinette.chatre@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size with SNC enabled
Date: Wed, 15 May 2024 13:18:23 +0200
Message-ID: <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
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

Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
nodes. Systems may support splitting into either two or four nodes.

When SNC mode is enabled the effective amount of L3 cache available
for allocation is divided by the number of nodes per L3.

Detect which SNC mode is active by comparing the number of CPUs
that share a cache with CPU0, with the number of CPUs on node0.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Co-developed-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   |  3 ++
 tools/testing/selftests/resctrl/resctrlfs.c | 59 +++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 00d51fa7531c..3dd5d6779786 100644
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
@@ -49,6 +50,7 @@
 		umount_resctrlfs();		\
 		exit(EXIT_FAILURE);		\
 	} while (0)
+#define MAX_SNC		4
 
 /*
  * user_params:		User supplied parameters
@@ -131,6 +133,7 @@ extern pid_t bm_pid, ppid;
 
 extern char llc_occup_path[1024];
 
+int snc_ways(void);
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 1cade75176eb..e4d3624a8817 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -156,6 +156,63 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
 	return 0;
 }
 
+/*
+ * Count number of CPUs in a /sys bit map
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
+/*
+ * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
+ * If some CPUs are offline the numbers may not be exact multiples of each
+ * other. Any offline CPUs on node0 will be also gone from shared_cpu_map of
+ * CPU0 but offline CPUs from other nodes will only make the cache_cpus value
+ * lower. Still try to get the ratio right by preventing the second possibility.
+ */
+int snc_ways(void)
+{
+	int node_cpus, cache_cpus, i;
+
+	node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
+	cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
+
+	if (!node_cpus || !cache_cpus) {
+		fprintf(stderr, "Warning could not determine Sub-NUMA Cluster mode\n");
+		return 1;
+	}
+
+	for (i = 1; i <= MAX_SNC ; i++) {
+		if (i * node_cpus >= cache_cpus)
+			return i;
+	}
+
+	return 1;
+}
+
 /*
  * get_cache_size - Get cache size for a specified CPU
  * @cpu_no:	CPU number
@@ -211,6 +268,8 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 			break;
 	}
 
+	if (cache_num == 3)
+		*cache_size /= snc_ways();
 	return 0;
 }
 
-- 
2.45.0


