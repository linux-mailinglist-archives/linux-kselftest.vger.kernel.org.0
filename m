Return-Path: <linux-kselftest+bounces-2065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBBB814B64
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1341C236A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ED136AE3;
	Fri, 15 Dec 2023 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0ovr8IU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B8747786;
	Fri, 15 Dec 2023 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702653004; x=1734189004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ywRDd44vKPDZAVx18BFxwm4wvIVelDye2XAYp2fu2Go=;
  b=h0ovr8IUWtsNlKhi2tyJnL/XXRiQiHBJclpzbM1MhV4Ncs6OzFYwewkl
   RvXEX+W2oPSjic/qGqw71dIOYK1wVyIPHOAAongbukPuhmEe7GSluThjc
   ajDHFta3RfO1ie6ND5mokB0eLgeYzpXe3LOpAKTrIYMI8jBuPchS4pEAS
   wAfMnmKKI6Hn9yJlEdajl10dbhkgwiRv4npo6ylMPeTnIsipLulxN80Lc
   dIK3BRwae0CrnoMX/tIiW3vW8JHe/69ehQmRLDSFooSas6isGj4XpgE/6
   aILrYRJ3fDJLuKFnUj/0ZG7dJYMGXs2T5hYRvc+ZS1CkEAKdcf+CctyR3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2454158"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2454158"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="809001718"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="809001718"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 29/29] selftests/resctrl: Get domain id from cache id
Date: Fri, 15 Dec 2023 17:05:15 +0200
Message-Id: <20231215150515.36983-30-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Domain id is acquired differently depending on CPU. AMD tests use id
from L3 cache, whereas CPUs from other vendors base the id on topology
package id. In order to support L2 CAT test, this has to be
generalized.

The driver side code seems to get the domain ids from cache ids so the
approach used by the AMD branch seems to match the kernel-side code. It
will also work with L2 domain IDs as long as the cache level is
generalized.

Using the topology id was always fragile due to mismatch with the
kernel-side way to acquire the domain id. It got incorrect domain id,
e.g., when Cluster-on-Die (CoD) is enabled for CPU (but CoD is not well
suited for resctrl in the first place so it has not been a big issue if
tests don't work correctly with it).

Taking all the above into account, generalize acquiring the domain id
by taking it from the cache id and do not hard-code the cache level.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 tools/testing/selftests/resctrl/resctrl_val.c |  4 +--
 tools/testing/selftests/resctrl/resctrlfs.c   | 27 ++++++++++++-------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index d4eef20723fc..c52eaf46f24d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -129,7 +129,7 @@ extern char llc_occup_path[1024];
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
-int get_domain_id(int cpu_no, int *domain_id);
+int get_domain_id(const char *resource, int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 631e5f055694..5a49f07a6c85 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -415,7 +415,7 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
 {
 	int domain_id;
 
-	if (get_domain_id(cpu_no, &domain_id) < 0) {
+	if (get_domain_id("MB", cpu_no, &domain_id) < 0) {
 		ksft_print_msg("Could not get domain ID\n");
 		return;
 	}
@@ -584,7 +584,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 {
 	int domain_id;
 
-	if (get_domain_id(cpu_no, &domain_id) < 0) {
+	if (get_domain_id("L3", cpu_no, &domain_id) < 0) {
 		ksft_print_msg("Could not get domain ID\n");
 		return;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index f29dc65d8b30..5750662cce57 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -111,28 +111,37 @@ static int get_cache_level(const char *cache_type)
 	return -1;
 }
 
+static int get_resource_cache_level(const char *resource)
+{
+	/* "MB" use L3 (LLC) as resource */
+	if (!strcmp(resource, "MB"))
+		return 3;
+	return get_cache_level(resource);
+}
+
 /*
  * get_domain_id - Get resctrl domain ID for a specified CPU
+ * @resource:	resource name
  * @cpu_no:	CPU number
  * @domain_id:	domain ID (cache ID; for MB, L3 cache ID)
  *
  * Return: >= 0 on success, < 0 on failure.
  */
-int get_domain_id(int cpu_no, int *domain_id)
+int get_domain_id(const char *resource, int cpu_no, int *domain_id)
 {
 	char phys_pkg_path[1024];
+	int cache_num;
 	FILE *fp;
 
-	if (get_vendor() == ARCH_AMD)
-		sprintf(phys_pkg_path, "%s%d/cache/index3/id",
-			PHYS_ID_PATH, cpu_no);
-	else
-		sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
-			PHYS_ID_PATH, cpu_no);
+	cache_num = get_resource_cache_level(resource);
+	if (cache_num < 0)
+		return cache_num;
+
+	sprintf(phys_pkg_path, "%s%d/cache/index%d/id", PHYS_ID_PATH, cpu_no, cache_num);
 
 	fp = fopen(phys_pkg_path, "r");
 	if (!fp) {
-		ksft_perror("Failed to open physical_package_id");
+		ksft_perror("Failed to open cache id file");
 
 		return -1;
 	}
@@ -559,7 +568,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resour
 		return -1;
 	}
 
-	if (get_domain_id(cpu_no, &domain_id) < 0) {
+	if (get_domain_id(resource, cpu_no, &domain_id) < 0) {
 		sprintf(reason, "Failed to get domain ID");
 		ret = -1;
 
-- 
2.30.2


