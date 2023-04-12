Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DF36DF6F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDLNWm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDLNW0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:22:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3C7EF4;
        Wed, 12 Apr 2023 06:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305731; x=1712841731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=logvC3cOqqnj5ht0OZHwu0oV7bpO4CGx105WtkMe5xI=;
  b=dZknNVZtt0D861FMGTy2eH2z3Ot0BRrDy1KUw4T0G1kC6yDBRFX0v1wN
   PsGwWwXn4ehPEHbP0godB//TaNZZRyghbFWq7yTGuvRhvJL46qqsU0GjW
   G7Vm2KMQ0xEMtoTAmvI8lSxMKqXqtXze4MOD691Tmja+O8YpF1Bh5mjUp
   eY0BpkBq8+M5O/D4YdbU9X8wLoEyqEgqf60YhLUrn6qI9Oq0cthOdQhVX
   7T1+238Lm6kpkj4kClgDG29piL8fZXIlKRe+s3Oa2pgj8KmumeioAo8uc
   PqKyZSZJDUUnmkXiC9RgIxviMc4gHqdUVYLdkBBgU1UWI9taSZ3W/SCvP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590053"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590053"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230051"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230051"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/22] selftests/resctrl: Express span in bytes
Date:   Wed, 12 Apr 2023 16:21:04 +0300
Message-Id: <20230412132122.29452-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make MBA and MBM tests to use megabytes to represent span. CMT test
uses bytes.

Convert MBA and MBM tests to use bytes like CMT test to remove the
inconsistency between the tests. This also allows removing test
dependent buffer sizing from run_benchmark().

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/mbm_test.c      | 2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c     | 9 ++-------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index b28e68ac5fea..d8bb18033bfb 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -40,7 +40,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, unsigned long span)
 	ksft_print_msg("%s Check MBM diff within %d%%\n",
 		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
 	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
-	ksft_print_msg("Span (MB): %lu\n", span);
+	ksft_print_msg("Span in bytes: %lu\n", span);
 	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 60b225e15cff..a26fb4badde0 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -151,7 +151,7 @@ int main(int argc, char **argv)
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
-	unsigned long span = 250;
+	unsigned long span = 250 * MB;
 	int ben_ind, ben_count, tests = 0;
 	bool cat_test = true;
 
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index cc6cf49e3129..9a58db077be6 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -306,7 +306,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
 void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
 	int operation, ret, malloc_and_init_memory, memflush;
-	unsigned long span, buffer_span;
+	unsigned long span;
 	char **benchmark_cmd;
 	char resctrl_val[64];
 	FILE *fp;
@@ -329,12 +329,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		operation = atoi(benchmark_cmd[4]);
 		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
 
-		if (strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-			buffer_span = span * MB;
-		else
-			buffer_span = span;
-
-		if (run_fill_buf(buffer_span, malloc_and_init_memory, memflush,
+		if (run_fill_buf(span, malloc_and_init_memory, memflush,
 				 operation, resctrl_val))
 			fprintf(stderr, "Error in running fill buffer\n");
 	} else {
-- 
2.30.2

