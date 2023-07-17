Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0857C756447
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjGQNSh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGQNRz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:17:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067582700;
        Mon, 17 Jul 2023 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599831; x=1721135831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nMHFu8I/KBcO8tG+Kue5dvJUuon6szU2Yf05Mirxfqc=;
  b=bfacE8lPfwq5mIE3T+WFqeoNJ86VD5beHdEXzeifS5hP526OcLo/TVyW
   aLRuGpuSuAXILWydF51XPodDt8fmLBdtIGvnCrluT8oAdnAXbrNaGJqiu
   qjCfPlzkz+1dSsSqWjMRCTTGbtmO1bU4n+itjAM+iXRKrDIyYVYN4NYaO
   fzfPuAQwvudUCshUS5DQ3WmbxtVL/FDzjn1cpcmrYq+57XAJiF3dlEVuK
   Irze6q/c9L+CivxICzRx9TTUJZZFxzwk1rT4TG4HSWAa9+FSaeNr8ZAsq
   0YHwpHKcyP9FRTdOP7VDAbUDIaX226iz05f2TmjFzhH7k+4ya+ca9ojSS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368569234"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368569234"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793247287"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793247287"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:47 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 16/19] selftests/resctrl: Don't use variable argument list for ->setup()
Date:   Mon, 17 Jul 2023 16:15:04 +0300
Message-Id: <20230717131507.32420-17-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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
index 8ae9ac150fd3..9c0e4ce4f28e 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -236,7 +236,7 @@ int cat_val(struct resctrl_val_param *param)
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
 		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-			ret = param->setup(1, param);
+			ret = param->setup(param);
 			if (ret == END_OF_TESTS) {
 				ret = 0;
 				break;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 480db0dc4e0e..42e35269d8b6 100644
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
index beb0f0687c6d..7214aefb55ed 100644
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
index 2d58d4b8a918..c7de6f5977f6 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -86,16 +86,10 @@ static int check_results(size_t span)
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
index 645ad407bd8d..838d1a438f33 100644
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
@@ -68,7 +67,7 @@ struct resctrl_val_param {
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

