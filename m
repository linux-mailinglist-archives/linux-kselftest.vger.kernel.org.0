Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD37C6DF710
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDLNY5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjDLNYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:24:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F90A11F;
        Wed, 12 Apr 2023 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305841; x=1712841841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ebdXidzBx8ukmQbmqV0mJkPdftvdgbL2UAGjJbnNt3Y=;
  b=jVZVICw/+v0TvKzjNrBsVH7lnpnq7M578plA9/y8whLnNiYbZdnjht9z
   yMlt36JfFJMBvSQHSyqeo/3CaoAYsVoM3WMvBgwglnZHghgD1Y3yxSMGU
   aqXqpeI1StDu77cKsU8NDhAsl13wrqx3WNbRNYqBBgC/zY+LHvbxcS1ii
   bCapJ3OLQfoJPTEJXCaPWzR2Yow/9k+bvAhdIA6WLatuB2jP145hf91+g
   yDvdSIree6cyVbvN7ULb/aHHwlKxHXRuVkOM+am9C7z/7A2HQ38M+Ux4y
   n8ZX4A4KAn+v8kDzCXgAG9vSdEEK13s8rhpkesqLluWlPro32u9LM+PO3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590279"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590279"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230123"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230123"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:46 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 18/22] selftests/resctrl: Move CAT/CMT test global vars to func they are used
Date:   Wed, 12 Apr 2023 16:21:18 +0300
Message-Id: <20230412132122.29452-19-ilpo.jarvinen@linux.intel.com>
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
index edcc340744d7..cfad7e488340 100644
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
 	pid_t bm_pid;
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 70c656581686..8fda7fc4d159 100644
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

