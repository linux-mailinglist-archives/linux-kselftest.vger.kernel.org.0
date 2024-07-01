Return-Path: <linux-kselftest+bounces-13010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CA91E238
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 16:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109331F2591A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AD6166303;
	Mon,  1 Jul 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYcA7wxJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96116089A;
	Mon,  1 Jul 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843534; cv=none; b=GRvGL8bdlfKnRjnJaVWqi4U9THoXYoh5dX2bT3XoqpWm6gYvkaXzjEEmjsFk+ohVA4SKkSdxCPMmxWJtpBTjuH07R3tfVx6OsxYBUZmVBFVOmbad56KdZEa+kyxHKqf88VXuKHg8DYrSJsmjtNNUgVqF/XaLD05ke/WqC9JZl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843534; c=relaxed/simple;
	bh=EZt86gKStA4pkyLkX+E2IbyiQEvDlNGUQ2FHGPVHax0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eofcx76kkTeabifQGo80Lyyplyvhy/FW+aVyN/CQPB+X2HMyotDGwFmPNhcG+R7ZYPJ3SPXDfAE4B9S5/TfKCph5SIkDj7Hqz9oMjrvemCt+ubtw5gOpkP783uAIuHGOpr6N58GFwXmTrptXkqXq4+AE3fWK5AavaiNsgvmj6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYcA7wxJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719843534; x=1751379534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EZt86gKStA4pkyLkX+E2IbyiQEvDlNGUQ2FHGPVHax0=;
  b=VYcA7wxJo9A2akq+e/wWoeRc1sycVwkd9fApsfddvp73qZvVKg4iLynn
   9b5SLF0Vz8DqPBAoDsbBV6x69IHnmmieWV5Gbn2C4XyVaSaey293p9PDL
   0BWtmjxsQsecvJZbc/KLzRqcJBBaITdga0qZbdMygYwuuvds8FCkjYoBB
   QBDaU5MJoIIZWWNp8QRJwGRiNQBgXVXmjoPVOi9gmqZa3CzxCEFkRdEIs
   Dq4KKs9ja1pG/rL/C1EKzTF5jH+O6vdeg8znIS0zff8eCqDYbRgV4+wWh
   ihrvDSTzJ6RMR7yexQc3t6No5AQP0vSC1jCVSlOWuAlrvkTCs5p2pf5dH
   A==;
X-CSE-ConnectionGUID: xngudnqdQfO3kU1Lk/zxhA==
X-CSE-MsgGUID: SHgfFZ2zRgKKVNhVBRxyzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28367012"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="28367012"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 07:18:51 -0700
X-CSE-ConnectionGUID: sHbWvgQxTeSos6DdEPqOcQ==
X-CSE-MsgGUID: Pft9tYHlTx+cbyR3nMt93w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45966253"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.21])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 07:18:49 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	reinette.chatre@intel.com,
	fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v3 1/2] selftests/resctrl: Adjust effective L3 cache size with SNC enabled
Date: Mon,  1 Jul 2024 16:18:04 +0200
Message-ID: <1e6ed2bbbc7716a1606865b8e890afdfcea7ca1d.1719842207.git.maciej.wieczor-retman@intel.com>
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

Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
nodes. Systems may support splitting into either two, three or four
nodes.

When SNC mode is enabled the effective amount of L3 cache available
for allocation is divided by the number of nodes per L3.

Detect which SNC mode is active by comparing the number of CPUs
that share a cache with CPU0, with the number of CPUs on node0.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Co-developed-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v3:
- Added comment to cache size modification to better explain why it is
  needed there. (Reinette)
- Fix facts in patch message. (Reinette)
- Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)

 tools/testing/selftests/resctrl/resctrl.h   |  4 ++
 tools/testing/selftests/resctrl/resctrlfs.c | 70 +++++++++++++++++++++
 2 files changed, 74 insertions(+)

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
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 250c320349a7..18a31a2ba7b3 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -156,6 +156,65 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
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
+int snc_nodes_per_l3_cache(void)
+{
+	int node_cpus, cache_cpus, i, ret = 1;
+
+	node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
+	cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
+
+	if (!node_cpus || !cache_cpus) {
+		ksft_print_msg("Could not determine Sub-NUMA Cluster mode!\n");
+		return 1;
+	}
+
+	for (i = 1; i <= MAX_SNC ; i++) {
+		if (i * node_cpus >= cache_cpus) {
+			ret = i;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 /*
  * get_cache_size - Get cache size for a specified CPU
  * @cpu_no:	CPU number
@@ -211,6 +270,17 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
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
2.45.2


