Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9780F17CB9D
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 04:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCGDqS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 22:46:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:57584 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgCGDqS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 22:46:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 19:46:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,524,1574150400"; 
   d="scan'208";a="235036027"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2020 19:46:18 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V1 08/13] selftests/resctrl: Fix typos
Date:   Fri,  6 Mar 2020 19:40:49 -0800
Message-Id: <4800d93350b5bdfa52cc99f2420e0d629b1dec78.1583657204.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

No functional changes intended

1. Schemata is spelled wrongly in a comment in mbm_test, fix it.
2. Fix incorrect commenting style in cache.c, fill_buf.c
3. Remove extra space while initializing struct resctrl_val_param in
   mbm_test.c

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 10 +++-------
 tools/testing/selftests/resctrl/fill_buf.c |  3 ++-
 tools/testing/selftests/resctrl/mbm_test.c |  4 ++--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 1cbcd7fbe216..be60d7d3f066 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -179,9 +179,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
 	int ret;
 
-	/*
-	 * Measure cache miss from perf.
-	 */
+	/* Measure cache miss from perf */
 	if (!strcmp(param->resctrl_val, "cat")) {
 		ret = get_llc_perf(&llc_perf_miss);
 		if (ret < 0)
@@ -189,9 +187,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 		llc_value = llc_perf_miss;
 	}
 
-	/*
-	 * Measure llc occupancy from resctrl.
-	 */
+	/* Measure llc occupancy from resctrl */
 	if (!strcmp(param->resctrl_val, "cqm")) {
 		ret = get_llc_occu_resctrl(&llc_occu_resc);
 		if (ret < 0)
@@ -228,7 +224,7 @@ int cat_val(struct resctrl_val_param *param)
 	if (ret)
 		return ret;
 
-	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
+	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS */
 	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
 				      resctrl_val);
 	if (ret)
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 84d2a8b9657a..9ede7b63f059 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -54,7 +54,8 @@ static void mem_flush(void *p, size_t s)
 	char *cp = (char *)p;
 	size_t i = 0;
 
-	s = s / CL_SIZE; /* mem size in cache llines */
+	/* mem size in cache lines */
+	s = s / CL_SIZE;
 
 	for (i = 0; i < s; i++)
 		cl_flush(&cp[i * CL_SIZE]);
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 9e847641516a..b64906f1b34f 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -93,7 +93,7 @@ static int mbm_setup(struct resctrl_val_param *p)
 	if (num_of_runs++ >= NUM_OF_RUNS)
 		return -1;
 
-	/* Set up shemata with 100% allocation on the first run. */
+	/* Set up schemata with 100% allocation on the first run */
 	if (num_of_runs == 0)
 		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
 				     p->resctrl_val);
@@ -116,7 +116,7 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 		.cpu_no		= cpu_no,
 		.mum_resctrlfs	= 1,
 		.filename	= RESULT_FILE_NAME,
-		.bw_report	=  bw_report,
+		.bw_report	= bw_report,
 		.setup		= mbm_setup
 	};
 	int ret;
-- 
2.7.4

