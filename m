Return-Path: <linux-kselftest+bounces-4428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F284F664
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0381F217A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F704F896;
	Fri,  9 Feb 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oI9coJTo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E067E86;
	Fri,  9 Feb 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487323; cv=none; b=MWxj5cfCoWbu0GoHMtf+NYnjruJ5XPzJohfKVk71ljGcKgy8PtKo4Dy+MT6Z5T7z7HHrzwj0Brof3EvM/ohd8Fw+BIecZdwYQAXRi86RKOgJjtIIss6oCwtQ5phfg9bBSyuPTrRdn2ELD4rQA/aawlIjRM/TtF6FUA8HlBSVS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487323; c=relaxed/simple;
	bh=FIQ9fq48KDISYrnkBp58xIkJcuO5BR3cZnh2mpxZfSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpYOXfSem8Fo0jYxQC1hIufftYff8blcbKsdkf6km83S8dgOe6A1/oR74Xxzuome/WVf0wR7U/hq3mxlFxlxez49fsTv6p49fCS1ntBvHXzF8Pd8Q3eFFfMGLDxL5dMPgrWSVk4MRuf8KimQbUmb1qT0kT9ACUWVUeS0Dhiu2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oI9coJTo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487322; x=1739023322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FIQ9fq48KDISYrnkBp58xIkJcuO5BR3cZnh2mpxZfSs=;
  b=oI9coJTo/eFcqo+O5vranBW55IZx5ncUhL9XAUdN8pRuzt7Pij9/JM62
   2Dr9ALr7HFdwC6t8KaEmNsL2bpfxC6Fv8ysmF5EfMtq/Wo5fCjTukiuME
   op7IvWq6WhosCMr0WXD0sHLle3xcazt24r/3AjIN3pLMcg8NGz4lfiF1O
   HCs49J3c12tXkES9p3AMsac8YE35YBD6NMzsmsf+V5ISidLTRo44NTC37
   mXG22S25eXw/LRgM1DKzHlh1GMkgz198QX9xPBsqPTWE1ckAfVRaHPM+H
   wd9U12Qmvpf0SDPaDZC3/5e3jmD/f2MvBoXUCrOYIwPh/dAC8iAVoO4Zg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12080132"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12080132"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934430883"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934430883"
Received: from ldziemin-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.2.218])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:01:58 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 3/5] selftests/resctrl: Split validate_resctrl_feature_request()
Date: Fri,  9 Feb 2024 15:01:43 +0100
Message-ID: <f914c55b9b9f635cff082b0b4a8b636598580821.1707487039.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
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
 tools/testing/selftests/resctrl/resctrl.h   |  4 ++-
 tools/testing/selftests/resctrl/resctrlfs.c | 33 ++++++++++++++-------
 5 files changed, 31 insertions(+), 16 deletions(-)

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
index 5116ea082d03..f434a6543b4f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -136,7 +136,9 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(const char *resource, const char *feature);
+bool resctrl_resource_exists(const char *resource);
+bool resctrl_mon_feature_exists(const char *resource, const char *feature);
+bool resource_info_file_exists(const char *resource, const char *file);
 bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 8a183c73bc23..af4f800ab23d 100644
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
 	if (!feature)
-		return true;
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


