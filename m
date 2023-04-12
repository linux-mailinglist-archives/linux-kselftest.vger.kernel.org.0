Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DBB6DF6F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjDLNXA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjDLNWm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:22:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A49D8A4C;
        Wed, 12 Apr 2023 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305743; x=1712841743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QClfBst6ynvkQDztp1yAKXadEnccw9KQZEBus3QCC+s=;
  b=VS+vmQLVHE/Q4EzSfUy2FnBnSpe6Y+GTzxokdq+gAr9tbOAFaymyny2B
   gdNqr4npPAxPjrS0d5OcuxHbTQzeuQx76Wdg92X6zV3Q2qLAg0zG7LDvy
   iCbQvaXfkd07xfInb3gg08pfb9o/s3eLBbZbANvEhymEoG6g/QK+2zawA
   w4O/eKOzisPEAVNt9i0Oy+AUJipNFSxDdiCpgQLeKeK/abD90qH3FoP4g
   ihFe4jD7vFYA9cnhzlHYPGi0jqyEYOcE4fdqaG4WK41z3nV6Bcmc6vmw+
   MkXdoN87I99tKTU1nDK+hVlNZF77AoZmsG7nqJfPoGn0d0BnwDVPvo9/J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590089"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590089"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230060"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230060"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:55 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/22] selftests/resctrl: Don't use variable argument list for ->setup()
Date:   Wed, 12 Apr 2023 16:21:06 +0300
Message-Id: <20230412132122.29452-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

struct resctrl_val_param has ->setup() function that accepts variable
argument list. All test cases use only 1 argument as input and it's
the struct resctrl_val_param pointer.

Instead of variable argument list, directly pass struct
resctrl_val_param pointer as the only parameter to ->setup().

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c       | 2 +-
 tools/testing/selftests/resctrl/cat_test.c    | 8 +-------
 tools/testing/selftests/resctrl/cmt_test.c    | 9 +--------
 tools/testing/selftests/resctrl/mba_test.c    | 8 +-------
 tools/testing/selftests/resctrl/mbm_test.c    | 8 +-------
 tools/testing/selftests/resctrl/resctrl.h     | 3 +--
 tools/testing/selftests/resctrl/resctrl_val.c | 2 +-
 7 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 8a4fe8693be6..11105ba30eff 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -238,7 +238,7 @@ int cat_val(struct resctrl_val_param *param)
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
 		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-			ret = param->setup(1, param);
+			ret = param->setup(param);
 			if (ret == END_OF_TESTS) {
 				ret = 0;
 				break;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index de2860bf5d80..90cbf86a0153 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -27,17 +27,11 @@ static unsigned long cache_size;
  * con_mon grp, mon_grp in resctrl FS.
  * Run 5 times in order to get average values.
  */
-static int cat_setup(int num, ...)
+static int cat_setup(struct resctrl_val_param *p)
 {
-	struct resctrl_val_param *p;
 	char schemata[64];
-	va_list param;
 	int ret = 0;
 
-	va_start(param, num);
-	p = va_arg(param, struct resctrl_val_param *);
-	va_end(param);
-
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
 		return END_OF_TESTS;
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 47cde5c02b7f..39fb869d57e6 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -21,15 +21,8 @@ static char cbm_mask[256];
 static unsigned long long_mask;
 static unsigned long cache_size;
 
-static int cmt_setup(int num, ...)
+static int cmt_setup(struct resctrl_val_param *p)
 {
-	struct resctrl_val_param *p;
-	va_list param;
-
-	va_start(param, num);
-	p = va_arg(param, struct resctrl_val_param *);
-	va_end(param);
-
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
 		return END_OF_TESTS;
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7defb32ad0de..bc4f32961e0e 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -22,18 +22,12 @@
  * con_mon grp, mon_grp in resctrl FS.
  * For each allocation, run 5 times in order to get average values.
  */
-static int mba_setup(int num, ...)
+static int mba_setup(struct resctrl_val_param *p)
 {
 	static int runs_per_allocation, allocation = 100;
-	struct resctrl_val_param *p;
 	char allocation_str[64];
-	va_list param;
 	int ret;
 
-	va_start(param, num);
-	p = va_arg(param, struct resctrl_val_param *);
-	va_end(param);
-
 	if (runs_per_allocation >= NUM_OF_RUNS)
 		runs_per_allocation = 0;
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d8bb18033bfb..7f6f44df9e66 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -86,21 +86,15 @@ static int check_results(unsigned long span)
 	return ret;
 }
 
-static int mbm_setup(int num, ...)
+static int mbm_setup(struct resctrl_val_param *p)
 {
-	struct resctrl_val_param *p;
 	static int num_of_runs;
-	va_list param;
 	int ret = 0;
 
 	/* Run NUM_OF_RUNS times */
 	if (num_of_runs++ >= NUM_OF_RUNS)
 		return END_OF_TESTS;
 
-	va_start(param, num);
-	p = va_arg(param, struct resctrl_val_param *);
-	va_end(param);
-
 	/* Set up shemata with 100% allocation on the first run. */
 	if (num_of_runs == 0)
 		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index ffa2d1e51c67..1d80cd76c24a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -3,7 +3,6 @@
 #ifndef RESCTRL_H
 #define RESCTRL_H
 #include <stdio.h>
-#include <stdarg.h>
 #include <math.h>
 #include <errno.h>
 #include <sched.h>
@@ -69,7 +68,7 @@ struct resctrl_val_param {
 	char		*bw_report;
 	unsigned long	mask;
 	int		num_of_runs;
-	int		(*setup)(int num, ...);
+	int		(*setup)(struct resctrl_val_param *param);
 };
 
 #define MBM_STR			"mbm"
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 00864242d76c..8ed6ce565b13 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -734,7 +734,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		ret = param->setup(1, param);
+		ret = param->setup(param);
 		if (ret == END_OF_TESTS) {
 			ret = 0;
 			break;
-- 
2.30.2

