Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC26E791532
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352765AbjIDJy7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 05:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbjIDJy4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 05:54:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258EB10F9;
        Mon,  4 Sep 2023 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693821280; x=1725357280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Rhn2+fHD+XXS/KIfntEoduqIGiWHJuiqKeBPL6TEgM=;
  b=PjUBYFZ3O5HJTOggc4H5GUF8L2tySaC8NObhzEksQXXqn/icwAD6UvTH
   GgLjvvg6MyETWaQjHl/sgc/eRn8MdNs2ezhj9B6p7VwXdM3F5UAeXfOrV
   oIBVzwodaixIIrvGKp5c6pWYECOruZFjoh+YEpQ78LQkq2+EMqfb0S42S
   5lelYU0nNcU19hcCvh7vyHVVjVZf6Aws9HimWl8+s3nHo6wuvUPUb+B0m
   GWS3y8r4fiTElly65gCi0nTW/uNkPyHbDTF1JeXKiPHRaYcRifuU9Jbw/
   2O97bzJrQkM4Z9LwOPHM5eRInvos0s0hwCgASGBpPR96Kc3tP4pgj+w/J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="356880752"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356880752"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="740700712"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="740700712"
Received: from okozlyk-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.44.17])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:27 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 8/8] selftests/resctrl: Cleanup benchmark argument parsing
Date:   Mon,  4 Sep 2023 12:53:39 +0300
Message-Id: <20230904095339.11321-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
References: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Benchmark argument is handled by custom argument parsing code which is
more complicated than it needs to be.

Process benchmark argument within the normal getopt() handling and drop
unnecessary ben_ind and has_ben variables. When -b is given, terminate
the argument processing as -b consumes all remaining arguments.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
---
 .../testing/selftests/resctrl/resctrl_tests.c | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 48e5afb1530c..823672a20a43 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -169,27 +169,34 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 int main(int argc, char **argv)
 {
-	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
-	const char *benchmark_cmd[BENCHMARK_ARGS];
-	int ben_ind, tests = 0;
+	bool mbm_test = true, mba_test = true, cmt_test = true;
+	const char *benchmark_cmd[BENCHMARK_ARGS] = {};
+	int c, cpu_no = 1, i, no_of_bits = 0;
 	char *span_str = NULL;
 	bool cat_test = true;
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
+			if (argc - optind >= BENCHMARK_ARGS)
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
 
@@ -238,6 +245,7 @@ int main(int argc, char **argv)
 			return -1;
 		}
 	}
+last_arg:
 
 	ksft_print_header();
 
@@ -257,15 +265,7 @@ int main(int argc, char **argv)
 
 	filter_dmesg();
 
-	if (has_ben) {
-		if (argc - ben_ind >= BENCHMARK_ARGS)
-			ksft_exit_fail_msg("Too long benchmark command.\n");
-
-		/* Extract benchmark command from command line. */
-		for (i = 0; i < argc - ben_ind; i++)
-			benchmark_cmd[i] = argv[i + ben_ind];
-		benchmark_cmd[i] = NULL;
-	} else {
+	if (!benchmark_cmd[0]) {
 		/* If no benchmark is given by "-b" argument, use fill_buf. */
 		benchmark_cmd[0] = "fill_buf";
 		ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
-- 
2.30.2

