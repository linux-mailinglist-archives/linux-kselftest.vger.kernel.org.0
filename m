Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44624697CBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjBONGh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 08:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjBONGb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 08:06:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3126037F15;
        Wed, 15 Feb 2023 05:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676466390; x=1708002390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ieANzC0mnbQoL6/kg9W09orFIHLECukxmo5j4g9LCd4=;
  b=aLgFa97Kwe2G9VpMAki3jLoKgK1XQEO8dXWAX2DoKvTJShe7doYwH9c8
   FL3B25WPrOgPy9Y4PbpFRLxdBfQ4jzAmYfxM3yKtL+pQxIzQoyFBDS+xE
   mxh4GgEF2dev7PtEnUA/VqTB1XNfsGzLoaIrZ/t2nS6aSBoJTu4h5VEFt
   ODnmgHWW9LRz0t7RXiD5LFRd2oy2lXjaNPuqc3imv0uU2awe0Ia7n0ddN
   R9buz7MgimAqBC7U4cFq6BUqZbSJdCH4sISAJs7sFxUgfCyGZIMTuM1le
   WElYPNRqtsGmtdxRQk6efxcxHQOC+wy/ffxuIOvmwqMizuW/aUsJXjIdu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319456258"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319456258"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812436045"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="812436045"
Received: from hshannan-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:27 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/9] selftests/resctrl: Allow ->setup() to return errors
Date:   Wed, 15 Feb 2023 15:05:59 +0200
Message-Id: <20230215130605.31583-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

resctrl_val() assumes ->setup() always returns either 0 to continue
tests or < 0 in case of the normal termination of tests after x runs.
The latter overlaps with normal error returns.

Define END_OF_TESTS (=1) to differentiate the normal termination of
tests and return errors as negative values. Alter callers of ->setup()
to handle errors properly.

Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c       | 4 +++-
 tools/testing/selftests/resctrl/cat_test.c    | 2 +-
 tools/testing/selftests/resctrl/cmt_test.c    | 2 +-
 tools/testing/selftests/resctrl/mba_test.c    | 2 +-
 tools/testing/selftests/resctrl/mbm_test.c    | 2 +-
 tools/testing/selftests/resctrl/resctrl.h     | 2 ++
 tools/testing/selftests/resctrl/resctrl_val.c | 4 +++-
 7 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 68ff856d36f0..0485863a169f 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -244,10 +244,12 @@ int cat_val(struct resctrl_val_param *param)
 	while (1) {
 		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
 			ret = param->setup(1, param);
-			if (ret) {
+			if (ret == END_OF_TESTS) {
 				ret = 0;
 				break;
 			}
+			if (ret < 0)
+				break;
 			ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
 			if (ret)
 				break;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 1c5e90c63254..2d3c7c77ab6c 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -40,7 +40,7 @@ static int cat_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	if (p->num_of_runs == 0) {
 		sprintf(schemata, "%lx", p->mask);
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 8968e36db99d..3b0454e7fc82 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -32,7 +32,7 @@ static int cmt_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	p->num_of_runs++;
 
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 1a1bdb6180cf..f32289ae17ae 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -41,7 +41,7 @@ static int mba_setup(int num, ...)
 		return 0;
 
 	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
-		return -1;
+		return END_OF_TESTS;
 
 	sprintf(allocation_str, "%d", allocation);
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 8392e5c55ed0..280187628054 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -95,7 +95,7 @@ static int mbm_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (num_of_runs++ >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	va_start(param, num);
 	p = va_arg(param, struct resctrl_val_param *);
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f0ded31fb3c7..f44fa2de4d98 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -37,6 +37,8 @@
 #define ARCH_INTEL     1
 #define ARCH_AMD       2
 
+#define END_OF_TESTS	1
+
 #define PARENT_EXIT(err_msg)			\
 	do {					\
 		perror(err_msg);		\
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 787546a52849..00864242d76c 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -735,10 +735,12 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
 		ret = param->setup(1, param);
-		if (ret) {
+		if (ret == END_OF_TESTS) {
 			ret = 0;
 			break;
 		}
+		if (ret < 0)
+			break;
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-- 
2.30.2

