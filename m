Return-Path: <linux-kselftest+bounces-4841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4A8577BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 09:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E223C1C2119D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEFC17BCC;
	Fri, 16 Feb 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQcJ/v8h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6BE1A58E;
	Fri, 16 Feb 2024 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072543; cv=none; b=OKhDIh0QhFPk7k6o0DyA6ihJywqxcPq9GgzevUZRLEJBwjoad4fcjSctmEc54xePBNQp21JvftSsmfsLRGy6D0oFYULDWNryxVfAcss/+q5gVjZGVJ28NgVAv1LlytluxNpn7iyGUwoBpuVrKFvl6JG5ZuK45rVbr7CxrTIm0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072543; c=relaxed/simple;
	bh=omA7aICzIfjeZZ/s3T0y5LKQ46k3cUG3K+oal/Sp80k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4EgMtzTl769ZwANgd2n08G5xRAaOrXSNx5AIM118AdnUfXzEO1GotbOFwCXUp/3yYC+OOX/hTF+bsRx5QDyjZ6Kq7k1v5NxOXkH3eQnB2PzYzMDLDnLpFC9Ynt9wrSk3b9apCO9JzCvaCd5Id5P69k+NDMVzSB+cAhAekP9hao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQcJ/v8h; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708072542; x=1739608542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=omA7aICzIfjeZZ/s3T0y5LKQ46k3cUG3K+oal/Sp80k=;
  b=HQcJ/v8hOk68yjsYOaDKwwPBM/EZO1oJGspV3tQgV+D0ROMPqPrNX1GE
   CvdISR4DNXhOV5MtcTFSEEaVi5vCtWq2UpKkXs3HVqNVVd3xiXiRFlLdE
   X/+kDaI0AtlknieV5bfYOoWrbPGWSSg8IxJBePdozBU9YNBnaR7coqWPn
   gvc/4JwaGe5AAu+fmhDvpfo+A74nVUDrWHwTWrIlxyMO92gewHy1cBnjp
   RcDbPc/7gwrJt/YBlyccsXf5lBC3kdWAbuRIT765VKjxutUnSTqoFOpoI
   NZBkRH5goYe+hRRxaML6aBF6U7PkQZDFGSwmso2Dgg5VnpbfSU/Cv2HqZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2067404"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2067404"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3801512"
Received: from zprzybys-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.138])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:35:38 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 3/5] selftests/resctrl: Split validate_resctrl_feature_request()
Date: Fri, 16 Feb 2024 09:35:28 +0100
Message-ID: <79e6f4b5bcaf36214289e56167fe1d5657cb4d24.1708072203.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

validate_resctrl_feature_request() is used to test both if a resource is
present in the info directory, and if a passed monitoring feature is
present in the mon_features file.

Refactor validate_resctrl_feature_request() into two smaller functions
that each accomplish one check to give feature checking more
granularity:
- Resource directory presence in the /sys/fs/resctrl/info directory.
- Feature name presence in the /sys/fs/resctrl/info/<RESOURCE>/mon_features
  file.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v6:
- Remove function header that sneaked into this patch from the next one
  in the series.
- Add resource pointer check after adding it back as a function
  argument.

Changelog v5:
- Move back to using resource parameter in mon_feature handling
  function. (Ilpo)

Changelog v4:
- Roll back to using test_resource_feature_check() for CMT and MBA.
  (Ilpo).

Changelog v3:
- Move new function to a separate patch. (Reinette)
- Rewrite resctrl_mon_feature_exists() only for L3_MON.

Changelog v2:
- Add this patch.

 tools/testing/selftests/resctrl/cmt_test.c  |  2 +-
 tools/testing/selftests/resctrl/mba_test.c  |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c  |  6 ++--
 tools/testing/selftests/resctrl/resctrl.h   |  3 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 35 ++++++++++++++-------
 5 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index dd5ca343c469..a81f91222a89 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -170,7 +170,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 static bool cmt_feature_check(const struct resctrl_test *test)
 {
 	return test_resource_feature_check(test) &&
-	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
+	       resctrl_mon_feature_exists("L3_MON", "llc_occupancy");
 }
 
 struct resctrl_test cmt_test = {
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index da256d2dbe5c..7946e32e85c8 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -171,7 +171,7 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 static bool mba_feature_check(const struct resctrl_test *test)
 {
 	return test_resource_feature_check(test) &&
-	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
+	       resctrl_mon_feature_exists("L3_MON", "mbm_local_bytes");
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
index 5116ea082d03..6d99ed44ec60 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -136,7 +136,8 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(const char *resource, const char *feature);
+bool resctrl_resource_exists(const char *resource);
+bool resctrl_mon_feature_exists(const char *resource, const char *feature);
 bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 8a183c73bc23..1273e55c4a9d 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -708,20 +708,16 @@ char *fgrep(FILE *inf, const char *str)
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
@@ -736,8 +732,25 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
 	if (stat(res_path, &statbuf))
 		return false;
 
-	if (!feature)
-		return true;
+	return true;
+}
+
+/*
+ * resctrl_mon_feature_exists - Check if requested monitoring feature is valid.
+ * @resource:	Resource that uses the mon_features file. Currently only L3_MON
+ *		is valid.
+ * @feature:	Required monitor feature (in mon_features file).
+ *
+ * Return: True if the feature is supported, else false.
+ */
+bool resctrl_mon_feature_exists(const char *resource, const char *feature)
+{
+	char res_path[PATH_MAX];
+	char *res;
+	FILE *inf;
+
+	if (!feature || !resource)
+		return false;
 
 	snprintf(res_path, sizeof(res_path), "%s/%s/mon_features", INFO_PATH, resource);
 	inf = fopen(res_path, "r");
@@ -753,7 +766,7 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
 
 bool test_resource_feature_check(const struct resctrl_test *test)
 {
-	return validate_resctrl_feature_request(test->resource, NULL);
+	return resctrl_resource_exists(test->resource);
 }
 
 int filter_dmesg(void)
-- 
2.43.0


