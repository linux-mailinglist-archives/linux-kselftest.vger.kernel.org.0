Return-Path: <linux-kselftest+bounces-35056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB6FADAB2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 10:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BDE188842D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D21026E149;
	Mon, 16 Jun 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcWf700r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247F1DF982;
	Mon, 16 Jun 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064069; cv=none; b=AGR3XjFBk4duRh58trVLOp2odeBnxj8xD6egHjJOtvw5xROXwGuPbRFMJWkiN4scl+lP47bsbAYYZHyCBE7btNTMF84lVvPtgewBzRTDTTrKur8bme/RWzMhql5+hT3NrNOpTY2YXty0SieVIMKmKuilBMB3cQAaHdBTxBgkBII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064069; c=relaxed/simple;
	bh=0sK2IqIUF90Xkw+eg8fHYE2r+HmIedr0OxTN7qBf0IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKep4xazQxxiYOQ5/2RtDIWAzw6Z7QSq1O4uYGi/fHM0pxNEm4jY4NnjRgH6/uvYqZmBK15Sqhw+Q4nyHh9JLz23tEJFgEtit7a30KdCH29PtEDlHldGvlQOvQxnA42KgB2cHLPdEMIPXXrDEu52R1+jXZhBzBEdM8Prr19nonc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcWf700r; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750064068; x=1781600068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0sK2IqIUF90Xkw+eg8fHYE2r+HmIedr0OxTN7qBf0IQ=;
  b=FcWf700r+zTcbVUzUvz8mF4YZz6BY1FUErW11drwSdEBNzMTjOo8aQ/7
   KRvsRySlXiAvjLSKoB7oi2Nl1PmcM5/joB/xmEKVdwCDbWpmCH6W9fVKs
   GMRGQKhVDISXA+28eyd96VcCHWCaRq7RpGgq0Vlxi9GUi9PMz2zWa0N5P
   ZvPMPs7rnWcD5MkOitTA1oHlu0GbSqi4DrOoHHMkHpPyJl1/K/olZSFQ2
   cjIwDtfzepudz33z8fYaty8PsFydYCMJulnNMcTg7TA2SutPkFpL0YLlh
   6ldQTPrHhRAbAbB7s+VLhkcmLfkQOJBOZX6m46589/Kz12uox77KJ7Fs+
   A==;
X-CSE-ConnectionGUID: UJnARSh+QO6C1hVuawim3A==
X-CSE-MsgGUID: 1Wk4PcXIRqyK1Ha/wHQIqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52344527"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52344527"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:54:27 -0700
X-CSE-ConnectionGUID: l12QMg5bSt69F5k63wQc2w==
X-CSE-MsgGUID: 5PiU8XmyS1C8z5MdYYM5hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148245544"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:54:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 1/2] kselftest/resctrl: L3 CAT resctrl FS functional tests
Date: Mon, 16 Jun 2025 11:24:52 +0300
Message-Id: <20250616082453.3725-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250616082453.3725-1-ilpo.jarvinen@linux.intel.com>
References: <20250616082453.3725-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Resctrl CAT selftests have been limited to mainly testing performance.
In order to validate the kernel side behavior better, add a functional
test that validates .../tasks file content while performing moves of
the task to different control groups.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    | 84 +++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h     |  2 +
 .../testing/selftests/resctrl/resctrl_tests.c |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c   | 48 +++++++++++
 4 files changed, 135 insertions(+)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 94cfdba5308d..78cb9ac90bb1 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -376,6 +376,82 @@ static bool noncont_cat_feature_check(const struct resctrl_test *test)
 	return resource_info_file_exists(test->resource, "sparse_masks");
 }
 
+static int cat_ctrlgrp_tasks_test(const struct resctrl_test *test,
+				  const struct user_params *uparams)
+{
+	cpu_set_t old_affinity;
+	pid_t bm_pid;
+	int ret;
+
+	bm_pid = getpid();
+
+	ret = resctrl_grp_has_task(NULL, bm_pid);
+	if (ret < 0)
+		return ret;
+	if (!ret) {
+		ksft_print_msg("PID not found in the root group\n");
+		return 1;
+	}
+
+	/* Taskset benchmark to specified CPU */
+	ret = taskset_benchmark(bm_pid, uparams->cpu, &old_affinity);
+	if (ret)
+		return ret;
+	ret = resctrl_grp_has_task(NULL, bm_pid);
+	if (ret < 0)
+		goto reset_affinity;
+	if (!ret) {
+		ksft_print_msg("PID not found in the root group\n");
+		ret = 1;
+		goto reset_affinity;
+	}
+
+	ret = write_bm_pid_to_resctrl(bm_pid, "c1", NULL);
+	if (ret)
+		goto reset_affinity;
+	ret = resctrl_grp_has_task("c1", bm_pid);
+	if (ret < 0)
+		goto reset_affinity;
+	if (!ret) {
+		ksft_print_msg("PID not found in the control group\n");
+		ret = 1;
+		goto reset_affinity;
+	}
+	ret = resctrl_grp_has_task(NULL, bm_pid);
+	if (ret < 0)
+		goto reset_affinity;
+	if (ret) {
+		ksft_print_msg("PID duplicate remains in the root group\n");
+		ret = 1;
+		goto reset_affinity;
+	}
+
+	ret = write_bm_pid_to_resctrl(bm_pid, "c2", NULL);
+	if (ret)
+		goto reset_affinity;
+	ret = resctrl_grp_has_task("c2", bm_pid);
+	if (ret < 0)
+		goto reset_affinity;
+	if (!ret) {
+		ksft_print_msg("PID not found in the new control group\n");
+		ret = 1;
+		goto reset_affinity;
+	}
+	ret = resctrl_grp_has_task("c1", bm_pid);
+	if (ret < 0)
+		goto reset_affinity;
+	if (ret) {
+		ksft_print_msg("PID duplicate remains in the old control group\n");
+		ret = 1;
+		goto reset_affinity;
+	}
+
+reset_affinity:
+	taskset_restore(bm_pid, &old_affinity);
+
+	return ret;
+}
+
 struct resctrl_test l3_cat_test = {
 	.name = "L3_CAT",
 	.group = "CAT",
@@ -400,3 +476,11 @@ struct resctrl_test l2_noncont_cat_test = {
 	.feature_check = noncont_cat_feature_check,
 	.run_test = noncont_cat_run_test,
 };
+
+struct resctrl_test cat_grp_tasks_test = {
+	.name = "CAT_GROUP_TASKS",
+	.group = "CAT",
+	.resource = "L3",
+	.feature_check = test_resource_feature_check,
+	.run_test = cat_ctrlgrp_tasks_test,
+};
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index cd3adfc14969..d25f83d0a54d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -174,6 +174,7 @@ bool resctrl_mon_feature_exists(const char *resource, const char *feature);
 bool resource_info_file_exists(const char *resource, const char *file);
 bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
+int resctrl_grp_has_task(const char *grp, pid_t bm_pid);
 int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
 int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity);
 int write_schemata(const char *ctrlgrp, char *schemata, int cpu_no,
@@ -241,6 +242,7 @@ static inline unsigned long cache_portion_size(unsigned long cache_size,
 extern struct resctrl_test mbm_test;
 extern struct resctrl_test mba_test;
 extern struct resctrl_test cmt_test;
+extern struct resctrl_test cat_grp_tasks_test;
 extern struct resctrl_test l3_cat_test;
 extern struct resctrl_test l3_noncont_cat_test;
 extern struct resctrl_test l2_noncont_cat_test;
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 5154ffd821c4..71b7cd846dc1 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -18,6 +18,7 @@ static struct resctrl_test *resctrl_tests[] = {
 	&mbm_test,
 	&mba_test,
 	&cmt_test,
+	&cat_grp_tasks_test,
 	&l3_cat_test,
 	&l3_noncont_cat_test,
 	&l2_noncont_cat_test,
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 195f04c4d158..0bc92eee0080 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -601,6 +601,54 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 	return 0;
 }
 
+/*
+ * resctrl_grp_has_task - Check if group tasks include a PID
+ * @grp:	Name of the group (use NULL for root group)
+ * @bm_id:	PID that should be checked
+ *
+ * Return: 1 if PID is a task in @grp, 0 if not, and <0 on error.
+ */
+int resctrl_grp_has_task(const char *grp, pid_t bm_pid)
+{
+	unsigned long tasks_pid;
+	char tasks[PATH_MAX];
+	int ret = 0;
+	FILE *fp;
+
+	if (grp)
+		snprintf(tasks, sizeof(tasks), "%s/%s/tasks", RESCTRL_PATH, grp);
+	else
+		snprintf(tasks, sizeof(tasks), "%s/tasks", RESCTRL_PATH);
+
+	fp = fopen(tasks, "r");
+	if (!fp) {
+		ksft_print_msg("Error opening %s: %m\n", tasks);
+		return -EIO;
+	}
+	while (1) {
+		ret = fscanf(fp, "%lu", &tasks_pid);
+		if (ret == EOF) {
+			if (errno) {
+				ksft_print_msg("Error reading %s: %m\n", tasks);
+				ret = -EIO;
+			} else {
+				ret = 0;
+			}
+			break;
+		}
+		if (!ret)
+			break;
+
+		if (tasks_pid == bm_pid) {
+			ret = 1;
+			break;
+		}
+	}
+
+	fclose(fp);
+	return ret;
+}
+
 static int write_pid_to_tasks(char *tasks, pid_t pid)
 {
 	FILE *fp;
-- 
2.39.5


