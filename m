Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E75752378
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjGMNVs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjGMNVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:21:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B13588;
        Thu, 13 Jul 2023 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254454; x=1720790454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Z6XtgfnkLNnOa77rczS1AMCmK7GDgGUepg6zaFzaNk=;
  b=Pqlk6al1iqtG4Ow/6f9hOBV8Dac7GyFkXb785AiKPKzmmgL07vEuoBmv
   1ffLIonQCyrE2NqBeUd0QSuGeuSsKfrDxfFrBvyJ1GkNcPYgrhfjjpW93
   WHvMZslJ0wYS+Jk2/8/fWls/rFWCNxuW509WcpBy8/OMewXMhJZ1BCuy6
   TXU+chg3ZO5PuracCywOYNWO5lT8UJiyxfcJ/E2GIDCBvuRvevZ6L3nI8
   W6wYAHcAoJHUqZGOaceua0J3OHPSwV+bghphzYg1SZ5gG6+MNVk9sRG22
   oh53BjuNF1FnGLz8RlfS986wQRkFLsDhD0JdRg4QRnkDR/OIWT8A16c9O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345496756"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345496756"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968615862"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968615862"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:49 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 10/19] selftests/resctrl: Express span internally in bytes
Date:   Thu, 13 Jul 2023 16:19:23 +0300
Message-Id: <20230713131932.133258-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MBA and MBM tests to use megabytes to represent span. CMT test uses
bytes. The difference requires run_benchmark() to size the buffer
differently based on the test name, which in turn requires passing the
test name into run_benchmark().

Convert MBA and MBM tests to use internally bytes like CMT test to
remove the internal inconsistency between the tests. Remove the test
dependent buffer sizing from run_benchmark().

This change eliminates one of the reasons why the test name has to be
passed around but there are still other users too so the test name
passing cannot yet be removed.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/mbm_test.c      | 2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c     | 9 ++-------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index fd116158d008..2d58d4b8a918 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -40,7 +40,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 	ksft_print_msg("%s Check MBM diff within %d%%\n",
 		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
 	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
-	ksft_print_msg("Span (MB): %zu\n", span);
+	ksft_print_msg("Span (MB): %zu\n", span / MB);
 	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 6b2ca1b4744f..5205a13ed250 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -185,8 +185,8 @@ int main(int argc, char **argv)
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
 	int ben_ind, ben_count, tests = 0;
+	size_t span = 250 * MB;
 	bool cat_test = true;
-	size_t span = 250;
 
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "-b") == 0) {
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 8be5b745226d..847e0a80c6cd 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -298,9 +298,9 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
 void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
 	int operation, ret, malloc_and_init_memory, memflush;
-	size_t span, buffer_span;
 	char **benchmark_cmd;
 	char resctrl_val[64];
+	size_t span;
 	FILE *fp;
 
 	benchmark_cmd = info->si_ptr;
@@ -321,12 +321,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
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

