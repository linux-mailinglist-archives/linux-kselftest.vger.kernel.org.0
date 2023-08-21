Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF02F782702
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 12:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjHUKX6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 06:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjHUKX4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 06:23:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF2E7;
        Mon, 21 Aug 2023 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692613434; x=1724149434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l9pS7YFiyzHJi8MEqqDnasrU/2+vFW4sjLLaPtIHJaw=;
  b=g80MWmB4W6TZ7LBCccFTlPxAS/46OOZS3yVIkOdYDoGvS2sbkXvlkt/C
   dQjErE706a6K0J7W3j/0GO7RfcBPDjKAL7S9WbRtJz2kiF/Oy8pK0nkM5
   4konNsdewXo7LvyOIAVvdEYbKMTIrRcVY7CpbhV6tmsSmQ2ou5m//Ec5x
   cCOx+IUljKEFnyVIqePoXRK66cusA6kRUBoaevA7wxZVzP1U+Uj7Q64F5
   CjhP+DxbyUiyCwn2bV4PF6PjwJP2Bsj4gbeQfU5Z/nLZaCKyg1FD954Ab
   hG4CPJQ/syUPzSBzpjVeJqKz0sYdCyQERR3A1qKH2SlTmiLbndBCdMFt4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="358530453"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="358530453"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="735798153"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="735798153"
Received: from nsnaveen-mobl.gar.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.54.252])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:23:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 7/7] selftests/resctrl: Cleanup benchmark argument parsing
Date:   Mon, 21 Aug 2023 13:22:45 +0300
Message-Id: <20230821102245.14430-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230821102245.14430-1-ilpo.jarvinen@linux.intel.com>
References: <20230821102245.14430-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 .../testing/selftests/resctrl/resctrl_tests.c | 71 ++++++++++---------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index b440c4e3e153..c7b13eba3e60 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -173,28 +173,35 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 int main(int argc, char **argv)
 {
-	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
+	bool mbm_test = true, mba_test = true, cmt_test = true;
+	int c, cpu_no = 1, i, no_of_bits = 0;
 	const char *benchmark_cmd[BENCHMARK_ARGS];
-	int ben_ind, tests = 0;
 	char *span_str = NULL;
 	bool cat_test = true;
 	char *skip_reason;
+	int tests = 0;
 	int ret;
 
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
+			/*
+			 * First move optind back to the (first) optarg and
+			 * then build the benchmark command using the
+			 * remaining arguments.
+			 */
+			optind--;
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
 
@@ -244,6 +251,19 @@ int main(int argc, char **argv)
 		}
 	}
 
+	/* If no benchmark is given by "-b" argument, use fill_buf. */
+	benchmark_cmd[0] = "fill_buf";
+	ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
+	if (ret < 0)
+		ksft_exit_fail_msg("Out of memory!\n");
+	benchmark_cmd[1] = span_str;
+	benchmark_cmd[2] = "1";
+	benchmark_cmd[3] = "0";
+	benchmark_cmd[4] = "false";
+	benchmark_cmd[5] = NULL;
+
+last_arg:
+
 	ksft_print_header();
 
 	/*
@@ -251,28 +271,9 @@ int main(int argc, char **argv)
 	 * 1. We write to resctrl FS
 	 * 2. We execute perf commands
 	 */
-	if (geteuid() != 0)
-		return ksft_exit_skip("Not running as root. Skipping...\n");
-
-	if (has_ben) {
-		if (argc - ben_ind >= BENCHMARK_ARGS - 1)
-			ksft_exit_fail_msg("Too long benchmark command.\n");
-
-		/* Extract benchmark command from command line. */
-		for (i = 0; i < argc - ben_ind; i++)
-			benchmark_cmd[i] = argv[i + ben_ind];
-		benchmark_cmd[i] = NULL;
-	} else {
-		/* If no benchmark is given by "-b" argument, use fill_buf. */
-		benchmark_cmd[0] = "fill_buf";
-		ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
-		if (ret < 0)
-			ksft_exit_fail_msg("Out of memory!\n");
-		benchmark_cmd[1] = span_str;
-		benchmark_cmd[2] = "1";
-		benchmark_cmd[3] = "0";
-		benchmark_cmd[4] = "false";
-		benchmark_cmd[5] = NULL;
+	if (geteuid() != 0) {
+		skip_reason = "Not running as root. Skipping...\n";
+		goto free_span;
 	}
 
 	if (!check_resctrlfs_support()) {
-- 
2.30.2

