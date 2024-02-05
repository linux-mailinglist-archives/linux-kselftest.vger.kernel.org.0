Return-Path: <linux-kselftest+bounces-4133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464808499C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4224B2709C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF71B972;
	Mon,  5 Feb 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bn1jQfNm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DC1CD1E;
	Mon,  5 Feb 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134913; cv=none; b=LZ2JfIPeedFPgkpr6zs0bS8HTMWBAJr4JVMclKEhjneWihOSfQjwTSp4A+Zw91zCkF3o3qundR3GEha6qcwR7dYHxIhmXYnv0XIWkW30v7Mb4dJY5CBU5mzz1xakenj4P2cOL2tfaPV0FUJaCqi40PJ86nCodIhssoxJoE7o2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134913; c=relaxed/simple;
	bh=YqIV/ZImnLY1o5nzB1hJEgYg0Be/kL6uZTzDdS8ujVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byufbbj2RSc8YddopHQU5eFK1xBJJ46qkDhsHuCvbwYzX04lttgaly8z+Mjzkf0AThYG8Mwr8GgO0nVmWWy8UpfruplQHZwm7lEAzs6rQchKluLDb/I0+H4v/9s3fVsgZBGrkJut8qL4yDYVd1ZIaGRScCapePUIabfYsPAaNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bn1jQfNm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707134911; x=1738670911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YqIV/ZImnLY1o5nzB1hJEgYg0Be/kL6uZTzDdS8ujVs=;
  b=Bn1jQfNmGjBEVTS1geqXL/DVzGozKcmwh8F2F1FTF8glljsOBvdq/nBU
   O7e4+FktlYQEON6Bn435IsaN4Vo/SfnBNgFHINAJM38aZLTQ7qus73+bG
   dNwKHmI9vTOwREAb35h9sTEBBfk7JDrvgm3BTb4DB/HPFHe7VtWWp60hl
   DyW4I6jrbJfhaxQIYMLUicyoAVDpcMerFWKYV7WIxvdfInmdnba40vJp8
   me83heqB7wF02Wzy7NUPlIJhZaVoT65oZiXuXw2Ur0F9E5/uzAxiUykhJ
   zeVbxWEfgR4wqmCdPfpIRW7xBS+wTwQdseWNKn3C3TGYioVNSoLxgdou3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="398500"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="398500"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="678238"
Received: from snestero-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.21.196])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:08:28 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 3/5] selftests/resctrl: Split validate_resctrl_feature_request()
Date: Mon,  5 Feb 2024 13:08:17 +0100
Message-ID: <e4b1887682e8262a3416dbd7bc63695af0d63ee0.1707130307.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
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
- Feature name presence in the /sys/fs/resctrl/info/L3_MON/mon_features
  file.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
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
 tools/testing/selftests/resctrl/resctrlfs.c | 33 +++++++++++++--------
 5 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index dd5ca343c469..c1157917a814 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -170,7 +170,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 static bool cmt_feature_check(const struct resctrl_test *test)
 {
 	return test_resource_feature_check(test) &&
-	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
+	       resctrl_resource_exists("L3");
 }
 
 struct resctrl_test cmt_test = {
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index da256d2dbe5c..fa99a91c8ab7 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -171,7 +171,7 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 static bool mba_feature_check(const struct resctrl_test *test)
 {
 	return test_resource_feature_check(test) &&
-	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
+	       resctrl_mon_feature_exists("mbm_local_bytes");
 }
 
 struct resctrl_test mba_test = {
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 34879e7b71a0..9c885bc427ca 100644
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
+	return resctrl_mon_feature_exists("mbm_total_bytes") &&
+	       resctrl_mon_feature_exists("mbm_local_bytes");
 }
 
 struct resctrl_test mbm_test = {
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 5116ea082d03..4603b215b97e 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -136,7 +136,8 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(const char *resource, const char *feature);
+bool resctrl_resource_exists(const char *resource);
+bool resctrl_mon_feature_exists(const char *feature);
 bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index e0fbc46a917a..0cfec8bb23fd 100644
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
@@ -736,11 +732,24 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
 	if (stat(res_path, &statbuf))
 		return false;
 
+	return true;
+}
+
+/*
+ * resctrl_mon_feature_exists - Check if requested monitoring L3_MON feature is valid.
+ * @feature:	Required monitor feature (in mon_features file).
+ *
+ * Return: True if the feature is supported, else false.
+ */
+bool resctrl_mon_feature_exists(const char *feature)
+{
+	char *res;
+	FILE *inf;
+
 	if (!feature)
-		return true;
+		return false;
 
-	snprintf(res_path, sizeof(res_path), "%s/%s/mon_features", INFO_PATH, resource);
-	inf = fopen(res_path, "r");
+	inf = fopen("/sys/fs/resctrl/info/L3_MON/mon_features", "r");
 	if (!inf)
 		return false;
 
@@ -753,7 +762,7 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
 
 bool test_resource_feature_check(const struct resctrl_test *test)
 {
-	return validate_resctrl_feature_request(test->resource, NULL);
+	return resctrl_resource_exists(test->resource);
 }
 
 int filter_dmesg(void)
-- 
2.43.0


