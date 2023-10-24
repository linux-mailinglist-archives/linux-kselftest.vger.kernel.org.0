Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B577D4C5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjJXJbA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjJXJaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:30:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3843E171B;
        Tue, 24 Oct 2023 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139770; x=1729675770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1dKoblTeQO3QQEOUxi7HkAa6k1k7lIw733imvwKBgio=;
  b=VPJvU8tveLQl7rvkAnFy5PMVNuPCJbUYyyROnFIhp80DJ8LmVSfY9Oud
   MaCFcvrVkfUEzmE+3mlDKYcL184blhwtdum4zQsbpRkyU3Dq5/P3Kq/a5
   /Vq2QiW5VWrXhY+3m4snj5o61UHychoHnPDwh6Pz1fLkzwKjPzqqyWFbm
   Hx9WVwFVP321ZnZrZBJ1KUkVJe+cndob5BqOk7vKWJJR4ssht3aM8j/SP
   YD34NWGU9A5MJXZJOee7uiaCxhb1Y+S/Z8J7jmhM1FjUVrI4BMCH6yrBc
   hyVjkWw7oUSo4rwlV5kl37DLJ4V19cYT6aTkI1GILRCawze9yUICNkmVG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="418145199"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="418145199"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="734972643"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="734972643"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:24 -0700
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
Subject: [PATCH 19/24] selftests/resctrl: Pass write_schemata() resource instead of test name
Date:   Tue, 24 Oct 2023 12:26:29 +0300
Message-Id: <20231024092634.7122-20-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

write_schemata() currently takes the test name as an argument and
determines the relevant resource based on the test name. L2 CAT test
needs to set schemata for both L3 and L2 CAT which would get
complicated using the current approach.

Pass a resource instead of test name to write_schemata() to allow more
than one resource be set per test name.

While touching the sprintf(), move the unnecessary %c that is always
'=' directly into the format string.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c  |  9 +++++----
 tools/testing/selftests/resctrl/cmt_test.c  |  1 +
 tools/testing/selftests/resctrl/mba_test.c  |  4 ++--
 tools/testing/selftests/resctrl/mbm_test.c  |  4 ++--
 tools/testing/selftests/resctrl/resctrl.h   |  5 +++--
 tools/testing/selftests/resctrl/resctrlfs.c | 22 +++++----------------
 6 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index aa16fb36d0d4..1ef047cadf4c 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -142,7 +142,8 @@ void cat_test_cleanup(void)
  *
  * Return:		0 on success. non-zero on failure.
  */
-static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long current_mask)
+static int cat_test(struct resctrl_val_param *param, const char *resource,
+		    size_t span, unsigned long current_mask)
 {
 	char *resctrl_val = param->resctrl_val;
 	static struct perf_event_read pe_read;
@@ -177,11 +178,11 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 
 	while (current_mask) {
 		snprintf(schemata, sizeof(schemata), "%lx", param->mask & ~current_mask);
-		ret = write_schemata("", schemata, param->cpu_no, param->resctrl_val);
+		ret = write_schemata("", schemata, param->cpu_no, resource);
 		if (ret)
 			goto free_buf;
 		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
-		ret = write_schemata(param->ctrlgrp, schemata, param->cpu_no, param->resctrl_val);
+		ret = write_schemata(param->ctrlgrp, schemata, param->cpu_no, resource);
 		if (ret)
 			goto free_buf;
 
@@ -268,7 +269,7 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 	remove(param.filename);
 
-	ret = cat_test(&param, span, start_mask);
+	ret = cat_test(&param, test->resource, span, start_mask);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 353c4bae2cfe..b0825d654dcf 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -125,6 +125,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 
 	struct resctrl_val_param param = {
 		.resctrl_val	= CMT_STR,
+		.resource	= "L3",
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= uparams->cpu,
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 722f94013cb9..a14b7f4466e5 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -40,8 +40,7 @@ static int mba_setup(struct resctrl_val_param *p)
 
 	sprintf(allocation_str, "%d", allocation);
 
-	ret = write_schemata(p->ctrlgrp, allocation_str, p->cpu_no,
-			     p->resctrl_val);
+	ret = write_schemata(p->ctrlgrp, allocation_str, p->cpu_no, p->resource);
 	if (ret < 0)
 		return ret;
 
@@ -145,6 +144,7 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBA_STR,
+		.resource	= "MB",
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= uparams->cpu,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 943f4f14a499..1ad2c1a7fddb 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -96,8 +96,7 @@ static int mbm_setup(struct resctrl_val_param *p)
 
 	/* Set up shemata with 100% allocation on the first run. */
 	if (p->num_of_runs == 0 && validate_resctrl_feature_request("MB", NULL))
-		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
-				     p->resctrl_val);
+		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no, p->resource);
 
 	p->num_of_runs++;
 
@@ -113,6 +112,7 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
+		.resource	= "MB",
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= uparams->cpu,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index e017adf1390d..99fbce4794bc 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -81,6 +81,7 @@ struct resctrl_test {
 /*
  * resctrl_val_param:	resctrl test parameters
  * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ * @resource:		Resource to test (e.g., MB, L3, L2, etc.)
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
  * @cpu_no:		CPU number to which the benchmark would be binded
@@ -90,6 +91,7 @@ struct resctrl_test {
  */
 struct resctrl_val_param {
 	char		*resctrl_val;
+	char		*resource;
 	char		ctrlgrp[64];
 	char		mongrp[64];
 	int		cpu_no;
@@ -127,8 +129,7 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
 bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
-int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
-		   char *resctrl_val);
+int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resource);
 int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 2851ffe64b56..7d72bea3ed58 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -496,23 +496,17 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
  * @ctrlgrp:		Name of the con_mon grp
  * @schemata:		Schemata that should be updated to
  * @cpu_no:		CPU number that the benchmark PID is binded to
- * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ * @resource:		Resctrl resource (Eg: MB, L3, L2, etc.)
  *
  * Update schemata of a con_mon grp *only* if requested resctrl feature is
  * allocation type
  *
  * Return: 0 on success, non-zero on failure
  */
-int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
+int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resource)
 {
 	char controlgroup[1024], reason[128], schema[1024] = {};
-	int resource_id, fd, schema_len = -1, ret = 0;
-
-	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
-	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
-	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) &&
-	    strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		return -ENOENT;
+	int resource_id, fd, schema_len, ret = 0;
 
 	if (!schemata) {
 		ksft_print_msg("Skipping empty schemata update\n");
@@ -532,14 +526,8 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
-	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
-	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
-				      "L3:", resource_id, '=', schemata);
-	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
-	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
-		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
-				      "MB:", resource_id, '=', schemata);
+	schema_len = snprintf(schema, sizeof(schema), "%s:%d=%s\n",
+			      resource, resource_id, schemata);
 	if (schema_len < 0 || schema_len >= sizeof(schema)) {
 		snprintf(reason, sizeof(reason),
 			 "snprintf() failed with return value : %d", schema_len);
-- 
2.30.2

