Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CAB7A22D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 17:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjIOPpt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbjIOPpZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 11:45:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A02010E6;
        Fri, 15 Sep 2023 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694792720; x=1726328720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RnZumUDhM2YQNSLf8I2FgO5Jp9vigh6f97eD4zmNqxE=;
  b=jhfBNsBTUW03vZEB47v3gdCQi3/hmt/0oNUpmI4EWQiVnXbOZjalQOnL
   xR+ND+65Pps6K9lMUXftc7+JMwmjzCd2hfZy0/oZ0zdS9I9FdbZMIDQrB
   2CjVD4XqxO0twfXUjldw3FxfD38gTEb8/yd3lwWyo2YBPEh/DNDdxvGrg
   M5YzI45YZOhK7OIefd7BP45sMqm9Hd/QlUW0+//mlipWLZWB8/TnVQsOW
   qYmEbZAhmvcYXGelf0NfBjWNTY+fxGUvOVZnID/E2dUR+3++SESLMe5Xn
   Wad5aL64g0yyP6MwOo6RwTPRI2Jy888woylKc4UH6RZwjzeq5wBIFmC8J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="443338377"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="443338377"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="991879085"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="991879085"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:45:17 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 5/6] selftests/resctrl: Fix feature checks
Date:   Fri, 15 Sep 2023 18:44:37 +0300
Message-Id: <20230915154438.82931-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
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

The MBA and CMT tests expect support of other features to be able to
run.

When platform only supports MBA but not MBM, MBA test will fail with:
Failed to open total bw file: No such file or directory

When platform only supports CMT but not CAT, CMT test will fail with:
Failed to open bit mask file '/sys/fs/resctrl/info/L3/cbm_mask': No such file or directory

Extend feature checks to cover these two conditions.

Fixes: ee0415681eb6 ("selftests/resctrl: Use resctrl/info for feature detection")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org> # selftests/resctrl: Refactor feature check to use resource and feature name
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index b13aee5dffb9..836dfe5c0b4d 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -124,7 +124,9 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 	if (test_prepare())
 		return;
 
-	if (!validate_resctrl_feature_request("MB", NULL) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("MB", NULL) ||
+	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
+	    (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
 		goto cleanup;
 	}
@@ -145,7 +147,8 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 	if (test_prepare())
 		return;
 
-	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy")) {
+	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy") ||
+	    !validate_resctrl_feature_request("L3", NULL)) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
 		goto cleanup;
 	}
-- 
2.30.2

