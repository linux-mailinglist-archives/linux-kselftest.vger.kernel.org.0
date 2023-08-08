Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED926773F58
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjHHQqK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjHHQpN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:45:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA344440;
        Tue,  8 Aug 2023 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510176; x=1723046176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eS3xaEQETdnX0id0plDDqxuTUi6pNiapMx6PcVlFMtc=;
  b=H76t9h1XzxnuLIgpJ4HJbS40SyZN7Av/VsjN6/2CfZOSHQemyiNMlvuB
   ZwQz4zhLAPc7s2mKrEmPF4CfQ2SAfut+BkelM1GNAn5oy3PMFODz/XW0t
   +mikEuwlQBelPzSOsyk+HlsQM3e0S2ZbzZ08q6CGPP6xxG0kaeGJol9uW
   01XHUwwU8uajx8rusljptRylGIqN0gdaofh7EN7d9+QP6zY0WQtWicpP1
   enXBovuJYXuOYmQovWBMmdRNepBjBXp+NUqfoFVLNtNZBVEL1eFfT/rdZ
   P2dOGwOZn/+no8aG9xGwa8ochfEg7iYGm4DkTCJ6X1lfz58PTmANxrsbz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437097970"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437097970"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977776978"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="977776978"
Received: from mtofeni-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.48.21])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:17:08 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7/7] selftests/resctrl: Cleanup benchmark argument parsing
Date:   Tue,  8 Aug 2023 12:16:25 +0300
Message-Id: <20230808091625.12760-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Benchmark argument is handled by custom argument parsing code which is
more complicated than it needs to be.

Process benchmark argument within the normal getopt() handling and drop
entirely unnecessary ben_ind and has_ben variables. If -b is not given,
setup the default benchmark command right after the switch statement
and make -b to goto over it while it terminates the getopt() loop.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../testing/selftests/resctrl/resctrl_tests.c | 56 +++++++++----------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 81c2ed299e6f..a437aaa69cc5 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -173,25 +173,27 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 int main(int argc, char **argv)
 {
-	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
+	bool mbm_test = true, mba_test = true, cmt_test = true;
+	int c, cpu_no = 1, i, no_of_bits = 0;
 	const char *benchmark_cmd[BENCHMARK_ARGS];
-	int ben_ind, tests = 0;
 	bool cat_test = true;
+	int tests = 0;
 
-	for (i = 0; i < argc; i++) {
-		if (strcmp(argv[i], "-b") == 0) {
-			ben_ind = i + 1;
-			argc_new = ben_ind - 1;
-			has_ben = true;
-			break;
-		}
-	}
-
-	while ((c = getopt(argc_new, argv, "ht:b:n:p:")) != -1) {
+	while ((c = getopt(argc, argv, "ht:b:n:p:")) != -1) {
 		char *token;
 
 		switch (c) {
+		case 'b':
+			optind--;			/* Back to optarg */
+			if (argc - optind >= BENCHMARK_ARGS - 1)
+				ksft_exit_fail_msg("Too long benchmark command");
+
+			/* Extract benchmark command from command line. */
+			for (i = 0; i < argc - optind; i++)
+				benchmark_cmd[i] = argv[i + optind];
+			benchmark_cmd[i] = NULL;
+
+			goto last_arg;
 		case 't':
 			token = strtok(optarg, ",");
 
@@ -241,6 +243,16 @@ int main(int argc, char **argv)
 		}
 	}
 
+	/* If no benchmark is given by "-b" argument, use fill_buf. */
+	benchmark_cmd[0] = "fill_buf";
+	benchmark_cmd[1] = DEFAULT_SPAN_STR;
+	benchmark_cmd[2] = "1";
+	benchmark_cmd[3] = "0";
+	benchmark_cmd[4] = "false";
+	benchmark_cmd[5] = NULL;
+
+last_arg:
+
 	ksft_print_header();
 
 	/*
@@ -251,24 +263,6 @@ int main(int argc, char **argv)
 	if (geteuid() != 0)
 		return ksft_exit_skip("Not running as root. Skipping...\n");
 
-	if (has_ben) {
-		if (argc - ben_ind >= BENCHMARK_ARGS - 1)
-			ksft_exit_fail_msg("Too long benchmark command");
-
-		/* Extract benchmark command from command line. */
-		for (i = 0; i < argc - ben_ind; i++)
-			benchmark_cmd[i] = argv[i + ben_ind];
-		benchmark_cmd[i] = NULL;
-	} else {
-		/* If no benchmark is given by "-b" argument, use fill_buf. */
-		benchmark_cmd[0] = "fill_buf";
-		benchmark_cmd[1] = DEFAULT_SPAN_STR;
-		benchmark_cmd[2] = "1";
-		benchmark_cmd[3] = "0";
-		benchmark_cmd[4] = "false";
-		benchmark_cmd[5] = NULL;
-	}
-
 	if (!check_resctrlfs_support())
 		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
 
-- 
2.30.2

