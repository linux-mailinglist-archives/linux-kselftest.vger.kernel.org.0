Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB26E6032
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjDRLqP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjDRLqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:46:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCD5769F;
        Tue, 18 Apr 2023 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818347; x=1713354347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lvb0alft8tDAwmxKOkP23wdr8h3cPgxIKtA/80FlHYM=;
  b=fJmWGDkxQeYjHLIVJTGRSaPruP4HF1zs5sBZvHw3XOS8LK9v1AWqxyEa
   /CU/5OYE+EbY4BpN8Aw+CUCSAK6NSw8LllvBOc0rUFJkpInt4461Dk9fb
   1P/L4h7XhCBl6hdWUvzw6Fgsuh3X1aENOqF98dnh087BpdHJ6y+/gpa/V
   OdlHjfsT7R8mjAcAC22boJ9tzfyvkuXguE3CL5eOgjIIpBp91Yli7pAyv
   ACd7A3YFvekWKWapUuAl6vinjwXIFSfogc/G+rwLkpwD9cp+5Wr3++LzQ
   9HgscnCcAPYWGmZv1DDzWr0X7cYV07wf3Kfl6IuessAtcJeU29mt4bqNx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994324"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994324"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601583"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601583"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 06/24] selftests/resctrl: Express span in bytes
Date:   Tue, 18 Apr 2023 14:44:48 +0300
Message-Id: <20230418114506.46788-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 3c389ccfea41..ea2ea5721e76 100644
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
index 6bc0eda25e5d..f1ed2c89f228 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -185,7 +185,7 @@ int main(int argc, char **argv)
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
-	unsigned long span = 250;
+	unsigned long span = 250 * MB;
 	int ben_ind, ben_count, tests = 0;
 	bool cat_test = true;
 
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 45f785213143..09e0a69c81c4 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -296,7 +296,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
 void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
 	int operation, ret, malloc_and_init_memory, memflush;
-	unsigned long span, buffer_span;
+	unsigned long span;
 	char **benchmark_cmd;
 	char resctrl_val[64];
 	FILE *fp;
@@ -319,12 +319,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
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

