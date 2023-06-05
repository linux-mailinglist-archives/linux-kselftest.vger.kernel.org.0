Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7570722E4A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjFESFL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjFESEm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:04:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B8171A;
        Mon,  5 Jun 2023 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988245; x=1717524245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B1zmj95tGIdII2SZaOFKFZ8yIm0cMc8pTOJH7ndgiGQ=;
  b=dzYxMN3cphfYJDWpZM+cEhM81ybrkF/UufQDDSjivZvNSrZpCEGsZkjb
   ARUQ+ArnXL4lfrm1TR9FRETctnyfCoojv+Pe9trbggHIKQysGyHKGqB17
   tPI7hEoWfMW0/g7LUvcZTvmtzAafTfiBqPs+r0a/bvh2eqSLdYTHDhK3q
   Zh70GbNOUOY66ug9iFFfYcDxNQ9X4GTwFZmYmNrp0lpd8VjBhUTqQJetd
   jz5VQEppIZUrj09Bdq0AwEoPy2I80O71HK5l7NikDoKBsJ5zP2zdcSjCq
   EIM7cILBiVOOkoAnQyMbNtb0Brv62l2k9ntjSKnDRx/DOWf3ECkcWSFuj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442815469"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442815469"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821274331"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821274331"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:03:39 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 19/19] selftests/resctrl: Remove test type checks from cat_val()
Date:   Mon,  5 Jun 2023 21:01:45 +0300
Message-Id: <20230605180145.112924-20-ilpo.jarvinen@linux.intel.com>
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

cat_val() is only used during CAT test but it checks for test type.

Remove test type checks and the unused else branch from cat_val().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 47 +++++++++++--------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 5aa112e5fdd3..2758e1a3b255 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -231,37 +231,32 @@ int cat_val(struct resctrl_val_param *param)
 	if (ret)
 		return ret;
 
-	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
-		initialize_llc_perf();
+	initialize_llc_perf();
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-			ret = param->setup(param);
-			if (ret == END_OF_TESTS) {
-				ret = 0;
-				break;
-			}
-			if (ret < 0)
-				break;
-			ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
-			if (ret)
-				break;
-
-			if (run_fill_buf(param->span, memflush, operation, true)) {
-				fprintf(stderr, "Error-running fill buffer\n");
-				ret = -1;
-				close(fd_lm);
-				break;
-			}
-
-			sleep(1);
-			ret = measure_cache_vals(param, bm_pid);
-			if (ret)
-				break;
-		} else {
+		ret = param->setup(param);
+		if (ret == END_OF_TESTS) {
+			ret = 0;
 			break;
 		}
+		if (ret < 0)
+			break;
+		ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
+		if (ret)
+			break;
+
+		if (run_fill_buf(param->span, memflush, operation, true)) {
+			fprintf(stderr, "Error-running fill buffer\n");
+			ret = -1;
+			close(fd_lm);
+			break;
+		}
+
+		sleep(1);
+		ret = measure_cache_vals(param, bm_pid);
+		if (ret)
+			break;
 	}
 
 	return ret;
-- 
2.30.2

