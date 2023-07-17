Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A882756431
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGQNRQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjGQNQ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:16:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15612D7B;
        Mon, 17 Jul 2023 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599781; x=1721135781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O3tFEgIPXRbZQkdAG/GRy4TC8Wl1EcsHY+cipqNpRuc=;
  b=N6Jb87YqmyGHlxUGL4Gehq5eZm0OamULvfeJB1L6wy+a9pZS+t9VzT23
   MviAnytgZKNmg4qgrAkRyd8bXt75OSIho0+ftVF9driwcpsJpGU41qzKx
   ks6pb1pvILzPPNT/iPM+IOcwz+FCv2n1rKp769qg5FoSaDtylJXwb3L/D
   h2Xbmbjrb+zwRtSMQ21T01YmzgxHeaK0S6hcvsTg9G0rB8H8G23z/q2v4
   /AebffM4Z80nGZG5yl9ISCmMzDBDyWJaPjX3Vs/tqUI08hr/GwwfE+KgC
   AqhtmIh28jb2nOF3vaS6iGK+VciYKI4phYIbTSodUM6QU2SB+e1fyXZcJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368569068"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368569068"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793247043"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793247043"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:17 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 10/19] selftests/resctrl: Express span internally in bytes
Date:   Mon, 17 Jul 2023 16:14:58 +0300
Message-Id: <20230717131507.32420-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MBA and MBM tests to use megabytes to represent span. CMT test uses
bytes. The difference requires run_benchmark() to size the buffer
differently based on the test name, which in turn requires passing the
test name into run_benchmark().

Convert MBA and MBM tests to use span internally in bytes like CMT test
to remove the internal inconsistency between the tests. Remove the test
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
index bae8f205fc3f..3a65dacb441e 100644
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
index 14fb85a7e526..6c00e79df033 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -303,9 +303,9 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
 void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
 	int operation, ret, malloc_and_init_memory, memflush;
-	size_t span, buffer_span;
 	char **benchmark_cmd;
 	char resctrl_val[64];
+	size_t span;
 	FILE *fp;
 
 	benchmark_cmd = info->si_ptr;
@@ -326,12 +326,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
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

