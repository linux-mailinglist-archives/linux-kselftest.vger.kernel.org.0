Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3986E6037
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjDRLqX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjDRLqQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:46:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35336AD1A;
        Tue, 18 Apr 2023 04:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818352; x=1713354352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9In+I9Z9X5Iz5xEzsu53yNiUH7AWd3qUitVjPSQ+pLU=;
  b=iJQSg1eL88KtXt6r4UTiaesFT/fgDWc3/WCvu4SiVyUeq48RmwG5dhSb
   ZZ8AUzwUKswVKH+B1ukewcNFBwBzVQMAqaHxgDtYP3TFEWNjbOfng7rvg
   NKYXqI7hSdtxLhcp5vh40Nfhjl/eKvcqz9Hs7H/vYqaEDvfwhVwO9KDbn
   LKgHpLdvNlglPm5DUyb9uvgj3UpgDENpHdwo1ef07yFosb9R6vcszQJEG
   sPzJ8+PcUzXq+toz0W+2PBkN117xuFfShyCowHQ5GR/z7vRp7/iQvFffP
   ZdXTKTDhDzubzP7ZC0kuGUysGXukKPCly7T3/CouR1erwDV5x9o7QtJnV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994338"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994338"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601622"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601622"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:49 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/24] selftests/resctrl: Don't use variable argument list for ->setup()
Date:   Tue, 18 Apr 2023 14:44:50 +0300
Message-Id: <20230418114506.46788-9-ilpo.jarvinen@linux.intel.com>
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
index 86c62dfd8e78..a998e6397518 100644
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
index d31e28416bb7..2d434c03cbba 100644
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
index 3d53c6c9b9ce..4d2f145804b8 100644
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
index ea2ea5721e76..90ee57e5b94b 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -86,16 +86,10 @@ static int check_results(unsigned long span)
 	return ret;
 }
 
-static int mbm_setup(int num, ...)
+static int mbm_setup(struct resctrl_val_param *p)
 {
-	struct resctrl_val_param *p;
-	va_list param;
 	int ret = 0;
 
-	va_start(param, num);
-	p = va_arg(param, struct resctrl_val_param *);
-	va_end(param);
-
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
 		return END_OF_TESTS;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index fe54c2b4f014..4fd2eaf641e0 100644
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
@@ -67,7 +66,7 @@ struct resctrl_val_param {
 	char		*bw_report;
 	unsigned long	mask;
 	int		num_of_runs;
-	int		(*setup)(int num, ...);
+	int		(*setup)(struct resctrl_val_param *param);
 };
 
 #define MBM_STR			"mbm"
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index e8f1e6a59f4a..f0f6c5f6e98b 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -759,7 +759,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		ret = param->setup(1, param);
+		ret = param->setup(param);
 		if (ret == END_OF_TESTS) {
 			ret = 0;
 			break;
-- 
2.30.2

