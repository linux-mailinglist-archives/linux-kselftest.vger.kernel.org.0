Return-Path: <linux-kselftest+bounces-5992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA9A873479
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 11:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808E61C208A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5371605B0;
	Wed,  6 Mar 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOvf1xpv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43A5FDDC;
	Wed,  6 Mar 2024 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721617; cv=none; b=hU01BQa4fmOko1yWPMxU7rmbBf0VVt39sZ04IG5dadyOSsRuBZG8sPhwWLiDF3yPZLNoPtXVOtimhBfPkz1VV2hrXsP6FzjBPawHhjeqUhT+m1pKs/ttuqUiksCS9GWub+cp2vgVZiV6cVNzY3xpDVhyy32kH9/sq4/9rwdyAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721617; c=relaxed/simple;
	bh=ytJVUPhnNOpLuteR3P9HW/TY0UWzPBgOZqqHRWr+b7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYgFXfHJ3tGHpW8nF0g+GC+Kt8SK6GdZdqMsfnMVGDAqzy+27Qo5sxfNAgFHycav3/N9hJMNIJAM16SccDJAquKl5JExQXM3dXHjy7Tj1OELC43sE13Lef/p2ZEJe1QGsFUGcLLhJk0q5uuxE2Gemyg3u7YAaIRmEA9Crp1Epsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOvf1xpv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709721616; x=1741257616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytJVUPhnNOpLuteR3P9HW/TY0UWzPBgOZqqHRWr+b7U=;
  b=LOvf1xpvBPnKtxkj93sGzS2u/48wszrZsVOc/Kwae74cgL0CXb06/oDC
   Ay/cIYt06Z9JntQaRuqW1g76NZk2GZdFHvvjLc7IHtInMpjE7r6VErPQ0
   Xr/MRbqyabUEJ1uk10WhTPGHtnzxrdzJj6SISLrvhPCL1+rymj3loX4KV
   rux4YryGaWF6cb6L6jPl0HoO75Lm3D6GTtKG1mB7OedlPtJ4KA3l/uRmk
   j5UjqNPxkArgE+M2ZKl1nRF6Hx/NUCHO15C+2PYIMNpqSsWkyPanzAoam
   EUvDIhNdVo7ffHLwNqb2Y5rMpOOe3mEvhBBHXTaFtSgvudrndHwlCwtA0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4497564"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4497564"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9803667"
Received: from ksznyce-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.25.14])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:39:45 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/4] selftests/resctrl: Adjust effective L3 cache size with SNC enabled
Date: Wed,  6 Mar 2024 11:39:18 +0100
Message-ID: <b143f7514b5302522b7c9fb09ae83ec8ec5799d4.1709721159.git.maciej.wieczor-retman@intel.com>
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
 tools/testing/selftests/resctrl/resctrl.h   |  4 ++
 tools/testing/selftests/resctrl/resctrlfs.c | 59 +++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 2051bd135e0d..41811e87f81c 100644
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
 #define PARENT_EXIT()				\
 	do {					\
 		kill(ppid, SIGKILL);		\
@@ -129,6 +132,7 @@ extern pid_t bm_pid, ppid;
 
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
2.44.0


