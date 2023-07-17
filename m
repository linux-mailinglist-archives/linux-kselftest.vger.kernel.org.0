Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836A8756448
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGQNSi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjGQNR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:17:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBA6270D;
        Mon, 17 Jul 2023 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599832; x=1721135832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8dyhHZxvUBvgzLfAW2CztItj+tdrTbfblHrZWtgClfw=;
  b=Uawry1mVlnijETfG+EIefpdDGDnB8XsIFzSMPr9tkBBRxpkRBL56nB52
   R+NgWtBxb4tS84QqJPCLn2Qm+NJxdp1YEjiPAsUgydJmfoS4lfU3aXMci
   QH7rGY7FPmlR7pQ9fFKKwt3JUKq0/wc8wPUDEvu179OBxpKvregHIVZuB
   JMCdbNLL9nN8kI0E28SCOF6avkHp0YP6nz4CiPMrD6yvQZNeLD/5aA2h7
   heGlB6igM/aLHzAJMwIS/QJhkQDIbO5cVSEI5wUWjKszILFC9EpXm23la
   YI8LnSgr/xCARnMV7/o4DqfNjCQkx/lNMYut8VwXZyNHqR++SIySExzU0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368569256"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368569256"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793247301"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793247301"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:51 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 17/19] selftests/resctrl: Move CAT/CMT test global vars to function they are used in
Date:   Mon, 17 Jul 2023 16:15:05 +0300
Message-Id: <20230717131507.32420-18-ilpo.jarvinen@linux.intel.com>
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

CAT and CMT tests have count_of_bits, long_mask, cbm_mask, and
cache_size global variables that can be moved into the sole using
function.

Make the global variables local variables of the relevant function to
scope them better.

While at it, move cache_size initialization into the declaration line.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 11 ++++-------
 tools/testing/selftests/resctrl/cmt_test.c | 11 ++++-------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 42e35269d8b6..ed6c8e64ad11 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -17,11 +17,6 @@
 #define MAX_DIFF_PERCENT	4
 #define MAX_DIFF		1000000
 
-static int count_of_bits;
-static char cbm_mask[256];
-static unsigned long long_mask;
-static unsigned long cache_size;
-
 /*
  * Change schemata. Write schemata to specified
  * con_mon grp, mon_grp in resctrl FS.
@@ -96,10 +91,12 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
 	unsigned long l_mask, l_mask_1;
 	int ret, pipefd[2], sibling_cpu_no;
+	unsigned long cache_size = 0;
+	unsigned long long_mask;
+	char cbm_mask[256];
+	int count_of_bits;
 	char pipe_message;
 
-	cache_size = 0;
-
 	/* Get default cbm mask for L3/L2 cache */
 	ret = get_cbm_mask(cache_type, cbm_mask);
 	if (ret)
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 7214aefb55ed..0ac9d6bbd13d 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -16,11 +16,6 @@
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
-static int count_of_bits;
-static char cbm_mask[256];
-static unsigned long long_mask;
-static unsigned long cache_size;
-
 static int cmt_setup(struct resctrl_val_param *p)
 {
 	/* Run NUM_OF_RUNS times */
@@ -75,10 +70,12 @@ void cmt_test_cleanup(void)
 
 int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 {
+	unsigned long cache_size = 0;
+	unsigned long long_mask;
+	char cbm_mask[256];
+	int count_of_bits;
 	int ret;
 
-	cache_size = 0;
-
 	if (!validate_resctrl_feature_request(CMT_STR))
 		return -1;
 
-- 
2.30.2

