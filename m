Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC86E294599
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439412AbgJTXvm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:11167 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439403AbgJTXvk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:40 -0400
IronPort-SDR: nyB/k2MPyR/zKJZqhFLQUt3QbPLUPsHM7bXdzxP31r7MYN+dRAYqB57JCLqHw2/+J1XxJJ0RzK
 I9EbSsSaUxyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486371"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486371"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:33 -0700
IronPort-SDR: LiOgrtKtMvcQKftOATkPcQJHTmVGHP5zugz0N90o18SBcClqSmjcvi4lzTSCzGBrpIs8xqNe0d
 tjb1lQQvt3fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833901"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:33 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 20/21] selftests/resctrl: Fix unnecessary usage of global variables
Date:   Tue, 20 Oct 2020 23:51:25 +0000
Message-Id: <20201020235126.1871815-21-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reinette reported following compilation issue on Fedora 32, gcc version
10.1.1

/usr/bin/ld: cmt_test.o:<src_dir>/cmt_test.c:22: multiple definition of
`cache_size'; cat_test.o:<src_dir>/cat_test.c:23: first defined here

The same issue is reported for long_mask and count_of_bits variables as
well. Compiler isn't happy because these variables are defined globally in
two .c files namely cmt_test.c and cat_test.c and the compiler during
compilation finds that the variable is already defined (multiple definition
error).

Taking a closer look at the usage of these variables reveals that these
variables are used only locally to cmt_resctrl_val() (defined in
cmt_test.c) and cat_perf_miss_val() (defined in cat_test.c) functions.
These variables are not shared between the two functions. So, there is no
need for these variables to be global. Hence, fix this issue by making
them local variables to the functions where they are used.

Fixes: 78941183d1b15 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Fixes: 790bf585b0eee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 7 ++-----
 tools/testing/selftests/resctrl/cmt_test.c | 6 ++----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index a18a37ce626c..e518f8f7b4d8 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -17,10 +17,7 @@
 #define MAX_DIFF_PERCENT	4
 #define MAX_DIFF		1000000
 
-int count_of_bits;
 char cbm_mask[256];
-unsigned long long_mask;
-unsigned long cache_size;
 
 /*
  * Change schemata. Write schemata to specified
@@ -121,8 +118,8 @@ void cat_test_cleanup(void)
 
 int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
-	unsigned long l_mask, l_mask_1;
-	int ret, pipefd[2], sibling_cpu_no;
+	unsigned long l_mask, l_mask_1, long_mask, cache_size;
+	int ret, pipefd[2], sibling_cpu_no, count_of_bits;
 	char pipe_message;
 	pid_t bm_pid;
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 119ae65abec7..f0cb441cca9f 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -16,10 +16,7 @@
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
-int count_of_bits;
 char cbm_mask[256];
-unsigned long long_mask;
-unsigned long cache_size;
 
 static int cmt_setup(int num, ...)
 {
@@ -113,7 +110,8 @@ void cmt_test_cleanup(void)
 
 int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 {
-	int ret, mum_resctrlfs;
+	int ret, mum_resctrlfs, count_of_bits;
+	unsigned long long_mask, cache_size;
 
 	cache_size = 0;
 	mum_resctrlfs = 1;
-- 
2.29.0

