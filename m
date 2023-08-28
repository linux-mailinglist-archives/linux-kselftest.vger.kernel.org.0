Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6378A969
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 11:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjH1J4n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjH1J4i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 05:56:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F67CA;
        Mon, 28 Aug 2023 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693216595; x=1724752595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H89TLv6wv6gErS1qZLGjMTMvbnqWuUsT01peqKrPBbI=;
  b=eSJvlS16cUKtj9ot1Kyuj3PN1riWii6EbcIj/FF+t4GARyn24LUfG9ap
   /UJ9ULoUHtuN7GmXBa5xQP0tCQSAdqTW4qHnOdPS3VxEghQ++4UG58kQ+
   SEjdvCoDo1Wti7d8kfw6HOT4ZOyDzqpxsh964F1Uc2C5bK/2BlrS/cbq5
   OqM5LnSpqA9U+9LSvQ6dvSsHwAk1QkGOgho0O1jPpJMoPoaUXW3whjeUJ
   ZhyPFefHzKNMOTMVfX3df549jQOKoQ+D5RJcJ/I1QlzPM695ji6CBpgtq
   tPFas4+vlYKQlXLxYEHHZgZxIqTqw3fBJQ3mpoe7A59QexubFbJLRoj+v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="365266315"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="365266315"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 02:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="803650171"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="803650171"
Received: from nwiklans-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 02:56:21 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com
Subject: [PATCH v2 2/2] selftests/resctrl: Move run_benchmark() to a more fitting file
Date:   Mon, 28 Aug 2023 11:56:08 +0200
Message-ID: <e527be8b871212823ff83f3800b6eecc2a75e455.1693213468.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693213468.git.maciej.wieczor-retman@intel.com>
References: <cover.1693213468.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Resctrlfs.c file contains mostly functions that interact in some way
with resctrl FS entries while functions inside resctrl_val.c deal with
measurements and benchmarking.

Run_benchmark() function is located in resctrlfs.c file even though it's
purpose is not interacting with the resctrl FS but to execute cache
checking logic.

Move run_benchmark() to resctrl_val.c just before resctrl_val() function
that makes use of run_benchmark().

Remove return comment from kernel-doc since the function is type void.

Changelog v2:
- Add dots at the end of patch msg sentences.
- Remove "Return: void" from run_benchmark() kernel-doc comment.

Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 50 ++++++++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 52 -------------------
 2 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index f0f6c5f6e98b..5c8dc0a7bab9 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -621,6 +621,56 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
 	return 0;
 }
 
+/*
+ * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
+ *		   in specified signal. Direct benchmark stdio to /dev/null.
+ * @signum:	signal number
+ * @info:	signal info
+ * @ucontext:	user context in signal handling
+ */
+void run_benchmark(int signum, siginfo_t *info, void *ucontext)
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
index 0f9644e5a25e..72dd8c3f655a 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -291,58 +291,6 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
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

