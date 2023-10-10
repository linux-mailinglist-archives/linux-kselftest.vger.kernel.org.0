Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381D7BF500
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442514AbjJJH5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 03:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442622AbjJJH5D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 03:57:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785BAB0;
        Tue, 10 Oct 2023 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696924620; x=1728460620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SBKJbfScbC8O7PragttfsiK5GsA19YlgI7tsRkSnlbg=;
  b=AYm+qt0GMQhQvPf7aED2cegVV8PNYhoq6wGmD6VJKJgo4YVUuZqK3RG7
   AM/hC7SM/cvuMp+mmYzWqYtY1wDJtb4uBT/lCNY+6HmbGUntDaJ4KFrJJ
   whFCni3fS/5xZRXUUcv1cu+x8KWJz/4LMfHzaR7w24QaBqz18gZGe71vg
   Cv+FkUsFTu+G7qcO1GOip0z7vrsBpOBpMqDfWEkgA5/Cl7qs9irul7qta
   cKzSJFA4QCXj5TzPPWG2NuVEzMxyswCX/2ZOph4fA8tSXlDHQ6W6iBxpA
   KOhaBPuwS5hPgdWp8K7x2oR0tyFJQ/eu8jnf9wLgaV0hLIn3Y65NuvJdv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="448527801"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="448527801"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 00:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="782788196"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="782788196"
Received: from asalaman-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.16.145])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 00:56:57 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 2/2] selftests/resctrl: Move run_benchmark() to a more fitting file
Date:   Tue, 10 Oct 2023 09:56:12 +0200
Message-ID: <6b1def8917a0718a34c38fea4c4e81f3117e7572.1696923907.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696923907.git.maciej.wieczor-retman@intel.com>
References: <cover.1696923907.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

resctrlfs.c contains mostly functions that interact in some way with
resctrl FS entries while functions inside resctrl_val.c deal with
measurements and benchmarking.

run_benchmark() is located in resctrlfs.c even though it's purpose
is not interacting with the resctrl FS but to execute cache checking
logic.

Move run_benchmark() to resctrl_val.c just before resctrl_val() that
makes use of run_benchmark(). Make run_benchmark() static since it's
not used between multiple files anymore.

Remove return comment from kernel-doc since the function is type void.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v4:
- Reword patch message very slightly. (Reinette)

Changelog v3:
- Make run_benchmark() static and remove it from the header. (Reinette)
- Remove return void kernel-doc comment. (Ilpo)
- Added Ilpo's reviewed-by tag.

 tools/testing/selftests/resctrl/resctrl.h     |  1 -
 tools/testing/selftests/resctrl/resctrl_val.c | 50 ++++++++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 52 -------------------
 3 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 8578a8b4e145..a33f414f6019 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -86,7 +86,6 @@ int validate_bw_report_request(char *bw_report);
 bool validate_resctrl_feature_request(const char *resource, const char *feature);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
-void run_benchmark(int signum, siginfo_t *info, void *ucontext);
 int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
 		   char *resctrl_val);
 int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index a9fe61133119..0577e983067a 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -625,6 +625,56 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
 	return 0;
 }
 
+/*
+ * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
+ *		   in specified signal. Direct benchmark stdio to /dev/null.
+ * @signum:	signal number
+ * @info:	signal info
+ * @ucontext:	user context in signal handling
+ */
+static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
+{
+	int operation, ret, memflush;
+	char **benchmark_cmd;
+	size_t span;
+	bool once;
+	FILE *fp;
+
+	benchmark_cmd = info->si_ptr;
+
+	/*
+	 * Direct stdio of child to /dev/null, so that only parent writes to
+	 * stdio (console)
+	 */
+	fp = freopen("/dev/null", "w", stdout);
+	if (!fp)
+		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
+
+	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
+		/* Execute default fill_buf benchmark */
+		span = strtoul(benchmark_cmd[1], NULL, 10);
+		memflush =  atoi(benchmark_cmd[2]);
+		operation = atoi(benchmark_cmd[3]);
+		if (!strcmp(benchmark_cmd[4], "true"))
+			once = true;
+		else if (!strcmp(benchmark_cmd[4], "false"))
+			once = false;
+		else
+			PARENT_EXIT("Invalid once parameter");
+
+		if (run_fill_buf(span, memflush, operation, once))
+			fprintf(stderr, "Error in running fill buffer\n");
+	} else {
+		/* Execute specified benchmark */
+		ret = execvp(benchmark_cmd[0], benchmark_cmd);
+		if (ret)
+			perror("wrong\n");
+	}
+
+	fclose(stdout);
+	PARENT_EXIT("Unable to run specified benchmark");
+}
+
 /*
  * resctrl_val:	execute benchmark and measure memory bandwidth on
  *			the benchmark
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 05390afd4d6f..5ebd43683876 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -294,58 +294,6 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
 	return 0;
 }
 
-/*
- * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
- *		   in specified signal. Direct benchmark stdio to /dev/null.
- * @signum:	signal number
- * @info:	signal info
- * @ucontext:	user context in signal handling
- *
- * Return: void
- */
-void run_benchmark(int signum, siginfo_t *info, void *ucontext)
-{
-	int operation, ret, memflush;
-	char **benchmark_cmd;
-	size_t span;
-	bool once;
-	FILE *fp;
-
-	benchmark_cmd = info->si_ptr;
-
-	/*
-	 * Direct stdio of child to /dev/null, so that only parent writes to
-	 * stdio (console)
-	 */
-	fp = freopen("/dev/null", "w", stdout);
-	if (!fp)
-		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
-
-	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
-		/* Execute default fill_buf benchmark */
-		span = strtoul(benchmark_cmd[1], NULL, 10);
-		memflush =  atoi(benchmark_cmd[2]);
-		operation = atoi(benchmark_cmd[3]);
-		if (!strcmp(benchmark_cmd[4], "true"))
-			once = true;
-		else if (!strcmp(benchmark_cmd[4], "false"))
-			once = false;
-		else
-			PARENT_EXIT("Invalid once parameter");
-
-		if (run_fill_buf(span, memflush, operation, once))
-			fprintf(stderr, "Error in running fill buffer\n");
-	} else {
-		/* Execute specified benchmark */
-		ret = execvp(benchmark_cmd[0], benchmark_cmd);
-		if (ret)
-			perror("wrong\n");
-	}
-
-	fclose(stdout);
-	PARENT_EXIT("Unable to run specified benchmark");
-}
-
 /*
  * create_grp - Create a group only if one doesn't exist
  * @grp_name:	Name of the group
-- 
2.42.0

