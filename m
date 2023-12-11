Return-Path: <linux-kselftest+bounces-1554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4EE80C99E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAD11F2110D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BAA3B291;
	Mon, 11 Dec 2023 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVNuc8mP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA33191;
	Mon, 11 Dec 2023 04:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297376; x=1733833376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ahxsxen/bwbGyz5iWJUzDCfp55UTGYIp2kjjWe5T9RY=;
  b=RVNuc8mPgxYymrW1CFxBHUbcGED2KXb6fpLSjl/yFvN+ojb1QurCcngf
   h5m1QA7pBvf2W+cOs8TWhNzsUkIACjAIMkPbZ6MPEpt6sGLxBejbdqID+
   bNAeeqd89izmyvOqfjypCjLzJC94oZl5bLFNBLkmWYB/D/WueYIwhh2FL
   LMJwtY9ci60X+6jLXg8TR32hX07CcGKz6Wui4i9/Kzrq6++Fnu1hr+fKQ
   RazjwPXbBW86G8TxOfcXwxvFbADk1Uo1j4ylChmCzN4tpDNKEBpPNZYwf
   PGFinSZbi4kS6YQMr472VZC6yZADs5BEqntOmJxSmtdljdKTx7x96KLWy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="458950009"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="458950009"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="807283304"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="807283304"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:22:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 28/29] selftests/resctrl: Rename resource ID to domain ID
Date: Mon, 11 Dec 2023 14:18:25 +0200
Message-Id: <20231211121826.14392-29-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
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
---
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 30 +++++++++----------
 tools/testing/selftests/resctrl/resctrlfs.c   | 18 +++++------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 8f5f56130d9f..4d8cd8535749 100644
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
index 0f06e6bbaf5a..47394e434c11 100644
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
index bb7d3f3bc43a..a00f512fb64f 100644
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


