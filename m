Return-Path: <linux-kselftest+bounces-13666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A0F92F781
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 11:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C2AB231A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2721143732;
	Fri, 12 Jul 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlrrhI6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7B142904;
	Fri, 12 Jul 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775081; cv=none; b=nsDzoCLr7fJxEp0b78h9frZ5usvq1c6iVbMsrjBt7O8AkqGEeqTeR/V102x4wpbGT5MbOLUINvtByJQeKqMfaclZ+jkmhlg5toHjWefkmZIsqgKovzTQu+NVqRrbFJPFz830EgPzGCSdHWvhaUQPiKuaYdu1EayXwrJVp2zeagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775081; c=relaxed/simple;
	bh=n8wDLhA4ejEdHfETshwOXBqVJq9jOZ8GWwLER67r1y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGtOBbuasAelIBd5DPvYjuJ2i9q8mFtZUwlHBVRV8XtWRJBucESAw6fjgtby9LrZcFNAu1jkhMP/9t0+YLKQRMuhfpmdp5Eqq5qAuCrZk5Cvw7Y7fNqnGMPKVAqWGZ+M2QXapBBQDrPeRlPZFK4lUGFPSO+wPMSE4pb+pDgqoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlrrhI6a; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720775080; x=1752311080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8wDLhA4ejEdHfETshwOXBqVJq9jOZ8GWwLER67r1y0=;
  b=FlrrhI6aVok8hMg5SEJRB5rVS+i43k9ALHuYLpVUiunTDSnBTGVvqPw6
   KVXwS6ldVrQUzgnbTy54OY+ejtZmnYfujB77/vn37mqvV8akgT0dfda0v
   Dsn81o/JHGus2H2f7+nJZGw3smhrnunnyGA7fMxfwJ0Y3vk2j0ID6R4M0
   295kt7z5UvFK5SJc47w61buLMa+3VD8oDU5ZE/NPBXYSLyCK81MwxwWlo
   9n9+Ml/CT2PW9pr2GBW+g8Wm4Zx0KVQJzhEa/8u84kIv5Hl+S7IXgVYuE
   yp8u1HvaexDcWzSDuj610+XE3jgBO9fq/0phUoREk47eiCnkfKiFrKmX7
   g==;
X-CSE-ConnectionGUID: hbPph7roRwmfZrmQbZW/Ug==
X-CSE-MsgGUID: N5sauocGThqHrsfoJB03lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18072582"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18072582"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:04:39 -0700
X-CSE-ConnectionGUID: w+inbRseT6aJZ2ofBuzQIA==
X-CSE-MsgGUID: AxgRcOJpSsWiWkTxV4Q/yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48922688"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.74])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:04:37 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v4 1/2] selftests/resctrl: Adjust effective L3 cache size with SNC enabled
Date: Fri, 12 Jul 2024 11:04:23 +0200
Message-ID: <e5f2fbe4f492d37569c389aebcb91168f98783ba.1720774981.git.maciej.wieczor-retman@intel.com>
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

 tools/testing/selftests/resctrl/resctrl.h   |  4 ++
 tools/testing/selftests/resctrl/resctrlfs.c | 73 +++++++++++++++++++++
 2 files changed, 77 insertions(+)

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
index 250c320349a7..803dd415984c 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -156,6 +156,68 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
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
+	int node_cpus, cache_cpus, i;
+	static int snc_mode;
+
+	if (!snc_mode) {
+		node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
+		cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
+
+		if (!node_cpus || !cache_cpus) {
+			ksft_print_msg("Could not determine Sub-NUMA Cluster mode.\n");
+			return 1;
+		}
+
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
@@ -211,6 +273,17 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
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


