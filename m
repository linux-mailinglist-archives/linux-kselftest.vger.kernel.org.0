Return-Path: <linux-kselftest+bounces-2066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01293814B66
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2DEB24097
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A414A3EA60;
	Fri, 15 Dec 2023 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6iwAH7y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44DD47778;
	Fri, 15 Dec 2023 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702653003; x=1734189003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EqoWnnJ4g+/6VuEW0z8a4ewZgUxcQO3pwl6WjqoLpmM=;
  b=g6iwAH7yPTr7pwJfT7degbMipXhLqOA1NPNBGUCrhvYUkbx9ZtuZCnQI
   6wxdp91ScptWOi9kBRiJn6tv+vb7xyQbqJrUbmCTf+6QcTQb3/j4mZRxi
   UPEBUGbJKDKCcrymm3DbMYyqj+yM1kwU3zPrAt+UFqbJVWIuRVpkwqPfT
   halgpDQ/peVBrVnUXYW3i+3Z8QFhqs3ErZ2I6OAXEWoh/flwo13yF9VqR
   jiGqSjtUhXUmlw4//1a7vWQGYXBq/4vAHWptpjE0p6/2r4WlfKFtS2tfq
   R3g8RXM3LLyGe0CdHcLxVIknSv/gM4VUbRBEM+ocojx6MV0yO79HYPso+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2454144"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2454144"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="809001711"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="809001711"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 28/29] selftests/resctrl: Rename resource ID to domain ID
Date: Fri, 15 Dec 2023 17:05:14 +0200
Message-Id: <20231215150515.36983-29-ilpo.jarvinen@linux.intel.com>
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

Kernel-side calls the instances of a resource domains.

Change the resource_id naming in the selftest code to domain_id to
match the kernel side better.

Suggested-by: Maciej Wieczór-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 30 +++++++++----------
 tools/testing/selftests/resctrl/resctrlfs.c   | 18 +++++------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 97d16daf8190..d4eef20723fc 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -129,7 +129,7 @@ extern char llc_occup_path[1024];
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
-int get_resource_id(int cpu_no, int *resource_id);
+int get_domain_id(int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 16ad91ccbcd3..631e5f055694 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -387,20 +387,20 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 	return 0;
 }
 
-void set_mbm_path(const char *ctrlgrp, const char *mongrp, int resource_id)
+void set_mbm_path(const char *ctrlgrp, const char *mongrp, int domain_id)
 {
 	if (ctrlgrp && mongrp)
 		sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
-			RESCTRL_PATH, ctrlgrp, mongrp, resource_id);
+			RESCTRL_PATH, ctrlgrp, mongrp, domain_id);
 	else if (!ctrlgrp && mongrp)
 		sprintf(mbm_total_path, MON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			mongrp, resource_id);
+			mongrp, domain_id);
 	else if (ctrlgrp && !mongrp)
 		sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			ctrlgrp, resource_id);
+			ctrlgrp, domain_id);
 	else if (!ctrlgrp && !mongrp)
 		sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			resource_id);
+			domain_id);
 }
 
 /*
@@ -413,23 +413,23 @@ void set_mbm_path(const char *ctrlgrp, const char *mongrp, int resource_id)
 static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
 				      int cpu_no, char *resctrl_val)
 {
-	int resource_id;
+	int domain_id;
 
-	if (get_resource_id(cpu_no, &resource_id) < 0) {
-		ksft_print_msg("Could not get resource_id\n");
+	if (get_domain_id(cpu_no, &domain_id) < 0) {
+		ksft_print_msg("Could not get domain ID\n");
 		return;
 	}
 
 	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
-		set_mbm_path(ctrlgrp, mongrp, resource_id);
+		set_mbm_path(ctrlgrp, mongrp, domain_id);
 
 	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 		if (ctrlgrp)
 			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
-				RESCTRL_PATH, ctrlgrp, resource_id);
+				RESCTRL_PATH, ctrlgrp, domain_id);
 		else
 			sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
-				RESCTRL_PATH, resource_id);
+				RESCTRL_PATH, domain_id);
 	}
 }
 
@@ -582,15 +582,15 @@ static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
 static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 					int cpu_no, char *resctrl_val)
 {
-	int resource_id;
+	int domain_id;
 
-	if (get_resource_id(cpu_no, &resource_id) < 0) {
-		ksft_print_msg("Could not get resource_id\n");
+	if (get_domain_id(cpu_no, &domain_id) < 0) {
+		ksft_print_msg("Could not get domain ID\n");
 		return;
 	}
 
 	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		set_cmt_path(ctrlgrp, mongrp, resource_id);
+		set_cmt_path(ctrlgrp, mongrp, domain_id);
 }
 
 static int measure_vals(const struct user_params *uparams,
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index eab928c46f98..f29dc65d8b30 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -112,13 +112,13 @@ static int get_cache_level(const char *cache_type)
 }
 
 /*
- * get_resource_id - Get socket number/l3 id for a specified CPU
+ * get_domain_id - Get resctrl domain ID for a specified CPU
  * @cpu_no:	CPU number
- * @resource_id: Socket number or l3_id
+ * @domain_id:	domain ID (cache ID; for MB, L3 cache ID)
  *
  * Return: >= 0 on success, < 0 on failure.
  */
-int get_resource_id(int cpu_no, int *resource_id)
+int get_domain_id(int cpu_no, int *domain_id)
 {
 	char phys_pkg_path[1024];
 	FILE *fp;
@@ -136,8 +136,8 @@ int get_resource_id(int cpu_no, int *resource_id)
 
 		return -1;
 	}
-	if (fscanf(fp, "%d", resource_id) <= 0) {
-		ksft_perror("Could not get socket number or l3 id");
+	if (fscanf(fp, "%d", domain_id) <= 0) {
+		ksft_perror("Could not get domain ID");
 		fclose(fp);
 
 		return -1;
@@ -551,7 +551,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resource)
 {
 	char controlgroup[1024], reason[128], schema[1024] = {};
-	int resource_id, fd, schema_len, ret = 0;
+	int domain_id, fd, schema_len, ret = 0;
 
 	if (!schemata) {
 		ksft_print_msg("Skipping empty schemata update\n");
@@ -559,8 +559,8 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resour
 		return -1;
 	}
 
-	if (get_resource_id(cpu_no, &resource_id) < 0) {
-		sprintf(reason, "Failed to get resource id");
+	if (get_domain_id(cpu_no, &domain_id) < 0) {
+		sprintf(reason, "Failed to get domain ID");
 		ret = -1;
 
 		goto out;
@@ -572,7 +572,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resour
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
 	schema_len = snprintf(schema, sizeof(schema), "%s:%d=%s\n",
-			      resource, resource_id, schemata);
+			      resource, domain_id, schemata);
 	if (schema_len < 0 || schema_len >= sizeof(schema)) {
 		snprintf(reason, sizeof(reason),
 			 "snprintf() failed with return value : %d", schema_len);
-- 
2.30.2


