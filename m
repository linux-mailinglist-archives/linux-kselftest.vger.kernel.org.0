Return-Path: <linux-kselftest+bounces-3559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC53783C095
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 12:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15B41C20A9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFC145033;
	Thu, 25 Jan 2024 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLO/kufr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647EE45949;
	Thu, 25 Jan 2024 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181155; cv=none; b=JPem8cLQ3v2gfqw88c2pnYwI7N5uQf7UY1VWF4QtE130bciZoWt2fOCVu7+zKOsJ7wK+xC8n2V6SEx8BG3TgvWJ64lhwKD7YcpxLP8mttJDzMAl3AdR5O/ij9v7DP3asf5CdIGSIX6Dh0gQBV5OdbyVbFAUq6gZSlzr7VTQ8Lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181155; c=relaxed/simple;
	bh=kZQi7qRqgWMe3fx6XtYYh/qZ7SHVk5oDrPpzUONn+7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqiR6cQ4LJT9KY8UBvLl7P4rPPKVVU7eDaUXBTI5/nwwe+j1OCd0dYR0lt+aYctSLApznIvlhUaLcGKDzgrqFKjFxlcONeW9RhTiNahpkbJ+Wo2Ww8zDE5Ec8aAnelH+VYKqGujeiDRHcggZsl0x0jtw3kPmbakRMt1LIwqgAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLO/kufr; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706181153; x=1737717153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZQi7qRqgWMe3fx6XtYYh/qZ7SHVk5oDrPpzUONn+7g=;
  b=bLO/kufrVAXPe7mC9x2hHXAr9nCuFqRWNyGd1ElrTixS19LxUpZ8ZFIT
   mjzRtvkAPFWt49cIOjaF7DkgK+u/oYzaW4X8r9ETekpED7eTICsL5GB/M
   tjmqDsl+muWDn/V0/4rvqZ6BxjOTa/mnI2HNura5ut0X9kex4Ch0a31uX
   TuUot7++GDJNn1CMGnaeHivi3JlFxx9H1t17mSgpopoPFhiFjg1uiW9/u
   O3o+tszkeCEemSjKQINm3YH+2zuxlQjb6NrZ49SKWhLyymQ4xIxpYoo12
   E/v2hyqzC3Xneb1WIDPllxFhw9BGJVyOREqLsUQWBcn4dOIIZpyxng4SM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405881002"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="405881002"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:12:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="877017521"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="877017521"
Received: from apejovix-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.239])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:12:29 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 3/5] selftests/resctrl: Split validate_resctrl_feature_request()
Date: Thu, 25 Jan 2024 12:12:11 +0100
Message-ID: <415cc65c113143c833ca2eaacd3a03c285c2e841.1706180726.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
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
Changelog v3:
- Move new function to a separate patch. (Reinette)
- Rewrite resctrl_mon_feature_exists() only for L3_MON.

Changelog v2:
- Add this patch.

 tools/testing/selftests/resctrl/cmt_test.c  |  4 +--
 tools/testing/selftests/resctrl/mba_test.c  |  4 +--
 tools/testing/selftests/resctrl/mbm_test.c  |  6 ++--
 tools/testing/selftests/resctrl/resctrl.h   |  3 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 33 +++++++++++++--------
 5 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index dd5ca343c469..428de9df81c8 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -169,8 +169,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool cmt_feature_check(const struct resctrl_test *test)
 {
-	return test_resource_feature_check(test) &&
-	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
+	return resctrl_mon_feature_exists("llc_occupancy") &&
+	       resctrl_resource_exists("L3");
 }
 
 struct resctrl_test cmt_test = {
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index da256d2dbe5c..e22285b80e37 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -170,8 +170,8 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool mba_feature_check(const struct resctrl_test *test)
 {
-	return test_resource_feature_check(test) &&
-	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
+	return resctrl_resource_exists(test->resource) &&
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
index cb5147c5f9a9..e4ba8614fb7b 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -711,20 +711,16 @@ char *fgrep(FILE *inf, const char *str)
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
@@ -739,11 +735,24 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
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
 
@@ -756,7 +765,7 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
 
 bool test_resource_feature_check(const struct resctrl_test *test)
 {
-	return validate_resctrl_feature_request(test->resource, NULL);
+	return resctrl_resource_exists(test->resource);
 }
 
 int filter_dmesg(void)
-- 
2.43.0


