Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58056E6055
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjDRLsS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjDRLsR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:48:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E387DB1;
        Tue, 18 Apr 2023 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818463; x=1713354463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KE5DE/VP3tizpaCKNJsP8NjVpWGqNNHqkbWqi0EEH4k=;
  b=kUjxbTiRA5OiKQ2QH9P2knJvnPYQgORMrM4PElcSYrrD6OY3oghUy1eC
   HCk2qenJTZdhh3wUQsrh4GoLa4D4yIcO6nMtHvwbTVUdQtVOZdjMUI/Kn
   UoFUy1wfAcqlaPwcTdBpGhCVw+DK36EFnLJXKCRqmGRPD+GthKCjwB1lb
   qEYVdraxi4EgdBLgZrvtvOBMIxustjCuMk0vXcYCOabqaBNt6DmAHXupZ
   lLozMX4qYv8ItjmJhKc6mIMd6YEK9btqJJ4Fgix+71z37jR9zXrY3/QnL
   7GnqQiwbyUMcMmoyVh8BTkjXRMbhOcgqWNSbQyUzKREAZqWx2tP9lY41t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994480"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994480"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601851"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601851"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:25 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 20/24] selftests/resctrl: Move CAT/CMT test global vars to func they are used
Date:   Tue, 18 Apr 2023 14:45:02 +0300
Message-Id: <20230418114506.46788-21-ilpo.jarvinen@linux.intel.com>
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

CAT and CMT tests have count_of_bits, long_mask, and cache_size global
variables that can be moved into the sole using function.

Make the global variables local variables of the relevant function to
scope them better.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 7 +++----
 tools/testing/selftests/resctrl/cmt_test.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index ae21e656cf6e..ef3ba22bdde5 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -17,10 +17,6 @@
 #define MAX_DIFF_PERCENT	4
 #define MAX_DIFF		1000000
 
-static int count_of_bits;
-static unsigned long long_mask;
-static unsigned long cache_size;
-
 /*
  * Change schemata. Write schemata to specified
  * con_mon grp, mon_grp in resctrl FS.
@@ -95,6 +91,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
 	unsigned long l_mask, l_mask_1;
 	int ret, pipefd[2], sibling_cpu_no;
+	unsigned long cache_size;
+	unsigned long long_mask;
+	int count_of_bits;
 	char pipe_message;
 
 	cache_size = 0;
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 087378a775ee..6adee08661e7 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -16,10 +16,6 @@
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
-static int count_of_bits;
-static unsigned long long_mask;
-static unsigned long cache_size;
-
 static int cmt_setup(struct resctrl_val_param *p)
 {
 	/* Run NUM_OF_RUNS times */
@@ -74,6 +70,9 @@ void cmt_test_cleanup(void)
 
 int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 {
+	unsigned long cache_size;
+	unsigned long long_mask;
+	int count_of_bits;
 	int ret;
 
 	cache_size = 0;
-- 
2.30.2

