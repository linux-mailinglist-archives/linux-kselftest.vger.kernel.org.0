Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F277D4C68
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjJXJcA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjJXJa6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:30:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F442120;
        Tue, 24 Oct 2023 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139786; x=1729675786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dO957Gz95d7/4Jry4ZIpp1kdFHUE2wJg6pXZJbwLlmY=;
  b=Y8omNJPDWX/dyTJpI0/STA7GKxc92HMDZh6uBBEyqNLQPqkME/KM0i2U
   tOyNTYJYt38UXEbTTWRx/0+wQlLNLPG+DT96ZNFidBBEnbRYSgZ4u4jmM
   baJFsUeEZxk943otd5D477IFadYGV7AvOHg0sKXgdAlqcSGKbjL4f3H+/
   8tT8FP37e3bP4dBRFsM8kPyHMaquewkBpsQzAvc+0Pg7Vec7asgkEMb8z
   Uj409o97zwlpsUHKB1aC00Fb8uA2XXmpCCkiR+uiViixBHZawBwedIbzB
   wiPhgV4oF6ItQuelPvgImBAXFonexpOqwlsYyaybZQLtMoEnNNzu6FdKR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5644376"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5644376"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758410152"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="758410152"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:41 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 21/24] selftests/resctrl: Get resource id from cache id
Date:   Tue, 24 Oct 2023 12:26:31 +0300
Message-Id: <20231024092634.7122-22-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Resource id is acquired differently depending on CPU. AMD tests use id
from L3 cache, whereas CPUs from other vendors base the id on topology
package id. In order to support L2 CAT test, this has to be
generalized.

The driver side code seems to get the resource ids from cache ids so
the approach used by the AMD branch seems to match the kernel-side
code. It will also work with L2 resource IDs as long as the cache level
is generalized.

Using the topology id was always fragile due to mismatch with the
kernel-side way to acquire the resource id. It got incorrect resource
id, e.g., when Cluster-on-Die (CoD) is enabled for CPU (but CoD is not
well suited for resctrl in the first place so it has not been a big
issues if test don't work correctly with it).

Taking all the above into account, generalize the resource id
calculation by taking it from the cache id and do not hard-code the
cache level.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 tools/testing/selftests/resctrl/resctrl_val.c |  4 +--
 tools/testing/selftests/resctrl/resctrlfs.c   | 31 ++++++++++++-------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 99fbce4794bc..c148998bf6ad 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -121,7 +121,7 @@ extern char llc_occup_path[1024];
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
-int get_resource_id(int cpu_no, int *resource_id);
+int get_resource_id(const char *resource, int cpu_no, int *resource_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 43ca026c6e0f..d210daafc5af 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -415,7 +415,7 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
 {
 	int resource_id;
 
-	if (get_resource_id(cpu_no, &resource_id) < 0) {
+	if (get_resource_id("MB", cpu_no, &resource_id) < 0) {
 		perror("Could not get resource_id");
 		return;
 	}
@@ -584,7 +584,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 {
 	int resource_id;
 
-	if (get_resource_id(cpu_no, &resource_id) < 0) {
+	if (get_resource_id("L3", cpu_no, &resource_id) < 0) {
 		perror("# Unable to resource_id");
 		return;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index b98d88f7cbc4..8e79b646d7cb 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -111,24 +111,33 @@ static int get_cache_level(const char *cache_type)
 	return -1;
 }
 
+static int get_resource_cache_level(const char *resource)
+{
+	/* "MB" use L3 (LLC) resource id */
+	if (!strcmp(resource, "MB"))
+		return 3;
+	return get_cache_level(resource);
+}
+
 /*
- * get_resource_id - Get socket number/l3 id for a specified CPU
- * @cpu_no:	CPU number
- * @resource_id: Socket number or l3_id
+ * get_resource_id - Get resctrl resource id for a specified CPU
+ * @resource:		resource
+ * @cpu_no:		CPU number
+ * @resource_id:	resource id (cache id; for MB, L3 cache id)
  *
  * Return: >= 0 on success, < 0 on failure.
  */
-int get_resource_id(int cpu_no, int *resource_id)
+int get_resource_id(const char *resource, int cpu_no, int *resource_id)
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
@@ -526,7 +535,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resour
 		return -1;
 	}
 
-	if (get_resource_id(cpu_no, &resource_id) < 0) {
+	if (get_resource_id(resource, cpu_no, &resource_id) < 0) {
 		sprintf(reason, "Failed to get resource id");
 		ret = -1;
 
-- 
2.30.2

