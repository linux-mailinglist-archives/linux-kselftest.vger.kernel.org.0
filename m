Return-Path: <linux-kselftest+bounces-1684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B74080EF60
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 15:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CBDB20D38
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC90745DE;
	Tue, 12 Dec 2023 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJkuiIcm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B585112;
	Tue, 12 Dec 2023 06:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702392811; x=1733928811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=droSSJvsZMJojwftguYS9wIBR3x3fBqsd4DUIwU6/UQ=;
  b=NJkuiIcmAncjnnRqTqHF/jajyQ9Y45km8kAxpC9Kt8q+UuVJbuHmJJ4t
   KBHduzhr0ddydD8m/usYLN2Sq8JKnB11db3ar6dL4pDez1YropNmiaUvf
   okrZZ9vzz+QS3iaOrwtcaHFi4y/nfqJ1L1i9YS0ixB2WbfBnzXhrwKLwu
   gj/XDs74DSMdDP8TcrmXl2riV4b5JzK9iXteR7/hnOm4RTuKhLJtaiJAj
   awM80OyIjs5QBvONwMwFzx3dXRa2d8fPo6FQ0bJHIkdKeIyAhX+4VHlKZ
   K65Ay9MRucqgf2w23kDJIOdybl9A/Z/gZmaVmi7+k+PETwybK5SOmWXZt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481014348"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="481014348"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:53:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="15023995"
Received: from mdabrows-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.5.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:53:28 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/4] selftests/resctrl: Split validate_resctrl_feature_request()
Date: Tue, 12 Dec 2023 15:52:53 +0100
Message-ID: <d6442103165be849d32585e861fc2850f7c4e8ea.1702392177.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

validate_resctrl_feature_request() is used to test both if a resource is
present in the info directory, and if a passed monitoring feature is
present in the mon_features file. There exists a different way to
represent feature support and that is by the presence of 0 or 1 in
single file in the info/resource directory. In this case the filename
represents what feature support is being indicated.

Split validate_resctrl_feature_request() into three smaller functions
that each accomplish one check:
- Resource directory presence in the /sys/fs/resctrl/info directory.
- Feature name presence in the /sys/fs/resctrl/info/RESOURCE/mon_features file.
- Feature file presence in a given /sys/fs/resctrl/info/RESOURCE directory.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Added this patch.

 tools/testing/selftests/resctrl/cat_test.c  |  2 -
 tools/testing/selftests/resctrl/cmt_test.c  |  4 +-
 tools/testing/selftests/resctrl/mba_test.c  |  5 +-
 tools/testing/selftests/resctrl/mbm_test.c  |  6 +--
 tools/testing/selftests/resctrl/resctrl.h   |  6 ++-
 tools/testing/selftests/resctrl/resctrlfs.c | 59 +++++++++++++++++----
 6 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 39fc9303b8e8..7dc7206b3b99 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Cache Allocation Technology (CAT) test
- *
  * Copyright (C) 2018 Intel Corporation
- *
  * Authors:
  *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
  *    Fenghua Yu <fenghua.yu@intel.com>
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index dd5ca343c469..7b63aec8e2c4 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -169,8 +169,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool cmt_feature_check(const struct resctrl_test *test)
 {
-	return test_resource_feature_check(test) &&
-	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
+	return resctrl_mon_feature_exists("L3_MON", "llc_occupancy") &&
+	       resctrl_resource_exists("L3");
 }
 
 struct resctrl_test cmt_test = {
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index da256d2dbe5c..ecf1c186448d 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -170,8 +170,9 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool mba_feature_check(const struct resctrl_test *test)
 {
-	return test_resource_feature_check(test) &&
-	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
+	return resctrl_resource_exists(test->resource) &&
+	       resctrl_mon_feature_exists("L3_MON",
+					  "mbm_local_bytes");
 }
 
 struct resctrl_test mba_test = {
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 34879e7b71a0..d67ffa3ec63a 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -97,7 +97,7 @@ static int mbm_setup(const struct resctrl_test *test,
 		return END_OF_TESTS;
 
 	/* Set up shemata with 100% allocation on the first run. */
-	if (p->num_of_runs == 0 && validate_resctrl_feature_request("MB", NULL))
+	if (p->num_of_runs == 0 && resctrl_resource_exists("MB"))
 		ret = write_schemata(p->ctrlgrp, "100", uparams->cpu, test->resource);
 
 	p->num_of_runs++;
@@ -140,8 +140,8 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool mbm_feature_check(const struct resctrl_test *test)
 {
-	return validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") &&
-	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
+	return resctrl_mon_feature_exists("L3_MON", "mbm_total_bytes") &&
+	       resctrl_mon_feature_exists("L3_MON", "mbm_local_bytes");
 }
 
 struct resctrl_test mbm_test = {
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 8f72d94b9cbe..74041a35d4ba 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -135,7 +135,11 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(const char *resource, const char *feature);
+bool resctrl_resource_exists(const char *resource);
+bool resctrl_mon_feature_exists(const char *resource,
+				const char *feature);
+bool resctrl_cache_feature_exists(const char *resource,
+				  const char *feature);
 bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 70333440ff2f..8546421f0940 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -697,20 +697,16 @@ char *fgrep(FILE *inf, const char *str)
 }
 
 /*
- * validate_resctrl_feature_request - Check if requested feature is valid.
- * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
- * @feature:	Required monitor feature (in mon_features file). Can only be
- *		set for L3_MON. Must be NULL for all other resources.
+ * resctrl_resource_exists - Check if a resource is supported.
+ * @resource:	Resctrl resource (e.g., MB, L3, L2, L3_MON, etc.)
  *
- * Return: True if the resource/feature is supported, else false. False is
+ * Return: True if the resource is supported, else false. False is
  *         also returned if resctrl FS is not mounted.
  */
-bool validate_resctrl_feature_request(const char *resource, const char *feature)
+bool resctrl_resource_exists(const char *resource)
 {
 	char res_path[PATH_MAX];
 	struct stat statbuf;
-	char *res;
-	FILE *inf;
 	int ret;
 
 	if (!resource)
@@ -725,6 +721,25 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
 	if (stat(res_path, &statbuf))
 		return false;
 
+	return true;
+}
+
+/*
+ * resctrl_mon_feature_exists - Check if requested feature is valid.
+ * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
+ * @feature:	Required monitor feature (in mon_features file). Can only be
+ *		set for L3_MON. Must be NULL for all other resources.
+ *
+ * Return: True if the resource/feature is supported, else false. False is
+ *         also returned if resctrl FS is not mounted.
+ */
+bool resctrl_mon_feature_exists(const char *resource,
+				const char *feature)
+{
+	char res_path[PATH_MAX];
+	char *res;
+	FILE *inf;
+
 	if (!feature)
 		return true;
 
@@ -740,9 +755,35 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
 	return !!res;
 }
 
+/*
+ * resctrl_cache_feature_exists - Check if a file that indicates a
+ * cache related feature support is present.
+ * @resource:	Required cache resource (L3 or L2)
+ * @feature:	Required cache feature.
+ *
+ * Return: True if the feature is supported, else false.
+ */
+bool resctrl_cache_feature_exists(const char *resource,
+				  const char *feature)
+{
+	char res_path[PATH_MAX];
+	struct stat statbuf;
+
+	if (!feature)
+		return true;
+
+	snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH, resource,
+		 feature);
+
+	if (stat(res_path, &statbuf))
+		return false;
+
+	return true;
+}
+
 bool test_resource_feature_check(const struct resctrl_test *test)
 {
-	return validate_resctrl_feature_request(test->resource, NULL);
+	return resctrl_resource_exists(test->resource);
 }
 
 int filter_dmesg(void)
-- 
2.43.0


