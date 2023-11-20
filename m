Return-Path: <linux-kselftest+bounces-320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8A7F11A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7E11C210E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F2314011;
	Mon, 20 Nov 2023 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeQqAG8W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD8E2693;
	Mon, 20 Nov 2023 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700479045; x=1732015045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hR5gJgV0ZBZxO4AEKML6ilHe9pb+YqoOmHoAundWL3c=;
  b=MeQqAG8WjGgcQGPbnTOrEU9rYjGX7+uq2SyaM/rnG59VWBxdUzLr0AWS
   Ekqwq3m113Ua0JX25Vg/HqZ3pBVGgiaCwsD7RTwoSaMipZjGEC+16yD8z
   6aZMpuMsRYFjEP1IxxiGVYb6TbBl3Inv/fBtseFA/AOA7m5OJRHzPq12q
   ntZt23sjcL/Nf6/bc5Bd3O7P4Otfa/FkeqlzktwzwCYrWTuE5rV5Oc6j4
   oT6VpqhQA1vUfzpSFhyysiO4TVXgHirVDR1AdC9sEJJNzKp0Trgh6JKFU
   /9jPJle1MqVIlxujDZ7imF22HjG6GNAgHR8m/WbP/obDtJA+50rVesxyY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="395527509"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="395527509"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:17:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="766248359"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="766248359"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:17:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 25/26] selftests/resctrl: Get domain id from cache id
Date: Mon, 20 Nov 2023 13:13:39 +0200
Message-Id: <20231120111340.7805-26-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
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
---
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 tools/testing/selftests/resctrl/resctrl_val.c |  4 +--
 tools/testing/selftests/resctrl/resctrlfs.c   | 27 ++++++++++++-------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 280ab6b6bd07..9b49065cc6da 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -124,7 +124,7 @@ extern char llc_occup_path[1024];
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
-int get_domain_id(int cpu_no, int *domain_id);
+int get_domain_id(const char *resource, int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index f278f5c9195c..5a072adfe8d6 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -415,7 +415,7 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
 {
 	int domain_id;
 
-	if (get_domain_id(cpu_no, &domain_id) < 0) {
+	if (get_domain_id("MB", cpu_no, &domain_id) < 0) {
 		perror("Could not get domain ID");
 		return;
 	}
@@ -584,7 +584,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 {
 	int domain_id;
 
-	if (get_domain_id(cpu_no, &domain_id) < 0) {
+	if (get_domain_id("L3", cpu_no, &domain_id) < 0) {
 		perror("# Could not get domain ID");
 		return;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index c173e0fa5c94..5ca3022d8aa6 100644
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
-		perror("Failed to open physical_package_id");
+		perror("Failed to open cache id file");
 
 		return -1;
 	}
@@ -532,7 +541,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resour
 		return -1;
 	}
 
-	if (get_domain_id(cpu_no, &domain_id) < 0) {
+	if (get_domain_id(resource, cpu_no, &domain_id) < 0) {
 		sprintf(reason, "Failed to get domain ID");
 		ret = -1;
 
-- 
2.30.2


