Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F25722E47
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjFESEr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjFESES (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:04:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CCCFD;
        Mon,  5 Jun 2023 11:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988233; x=1717524233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WIWnJB3NculwQZQw1FR80Zi4TS+CrST66ZBC+3Ji4ag=;
  b=gkUCxu8kGHduqpOaksF+INZPWE6qEIiouRjBMDvc6uTUJ+HR+V83xXuL
   aDD0P9SMuzpsst7y7cOejGpUybdJVA8J8mvaCOV7dDeMcv4xhDKIUzkmi
   qZwRvJqgfNQg7kLEuDQhqU0ljB5o+PwvOMfRgVfI2hYsKX+fa43Y0jcWk
   sTV+td5oLlzQK2g3/e/OArhr6E1VLUABZBzFhAD6piOIbREbDYFXgh6zS
   6oHkl1ZJs30r0FAyOIAEJy/KKUJ1UBQRPOYgEuLibR5gdgKJQUGpk3vIF
   IqGeUjvIDucRHho6adf6ChY4xNTlqsJfAH0yMlJafYzWOZj48+T9ITiqB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442815454"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442815454"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:03:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821274321"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821274321"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:03:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 17/19] selftests/resctrl: Move CAT/CMT test global vars to function they are used in
Date:   Mon,  5 Jun 2023 21:01:43 +0300
Message-Id: <20230605180145.112924-18-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
References: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

