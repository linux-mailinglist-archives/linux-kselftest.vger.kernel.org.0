Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F130568EB71
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 10:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjBHJbn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 04:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjBHJbQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 04:31:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D804608B;
        Wed,  8 Feb 2023 01:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675848638; x=1707384638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GSxLLsk3gISJ3/oHPl1UpUk/MN38+zv/LARL2weDoeU=;
  b=lO4gPbSf8daPffF/0S/XmLMvuMwYOBxdDkrc+/x6uGxZCrFQAEIt0poN
   4B4m41JKtnk739EeV68F5coB+PfilwHZjMY7KFAXk27prnSWLrzPvRReJ
   bNKnYBnsVZHLTxNFYISNvwVI6XT3Zf9o7bE/Jx4/bghu7jHNjCc86J8+/
   /iYoaurH0htpfTdgKjiVcjx9kWGoclH1rpDRuTRL5FCjiKnXaMnyM4M8+
   nTXK0VYIMjgjpi+vDHhbfxMxLV8ufWum5PRKPadLfxrSQkmqPkHCAXLxz
   Rgxo9pS2qd6SoJclatxQw/y23mFjvxJZsQy77pZrWnt6lYNwUYgq+rdGr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415974545"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="415974545"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:30:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="697613935"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="697613935"
Received: from jstelter-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.38.39])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:30:34 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/4] selftests/resctrl: Allow ->setup() to return errors
Date:   Wed,  8 Feb 2023 11:30:15 +0200
Message-Id: <20230208093016.20670-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208093016.20670-1-ilpo.jarvinen@linux.intel.com>
References: <20230208093016.20670-1-ilpo.jarvinen@linux.intel.com>
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

Currently resctrl_val() assumes ->setup() always returns either 0 to
continue tests or < 0 in case of the normal termination of tests after
x runs. The latter overlaps with normal error returns.

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

