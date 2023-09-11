Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328C579B923
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbjIKVTm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbjIKLUD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 07:20:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108CFCDD;
        Mon, 11 Sep 2023 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694431199; x=1725967199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eIbMDqgI1VdHnVLRbKO7jTB1Ubvov6e0AspTTuCSqIU=;
  b=YWpbo5ef7TbIDBzbOR6eZkQ8BYvDHzUyQ9qvRFX9ymqAk1u5+WgRNYtw
   f6jY3mKj3JvRt3Gjp4bNBX1YApKO99nDkHCyvZx3HroM5noJvELR8x9Va
   9N/19sxkBiFIzaDH21Pbee8TcgO2J8DSaqzJ/zFxKLSaiWi9XzuVa3n5Y
   3EgX1JVmwgfqvi6J4YGuUpLzZ2+XYIPrGk6RfRYIPp9/DVABBTI6nfYQ5
   3sHXU3L8Nwa1VP64O+1T7NsCcYuq8qpvtnTvY8opz3GTt+AkxAFAwvmJ/
   oOBVaCqfWD4lB2b1dldoym1wQNLolQZNUmi2D13jrfkKECv0uRrvNRpbJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="464428629"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="464428629"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:19:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="916990571"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="916990571"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:19:56 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/5] selftests/resctrl: Fix feature checks
Date:   Mon, 11 Sep 2023 14:19:29 +0300
Message-Id: <20230911111930.16088-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Cc: <stable@vger.kernel.org> # selftests/resctrl: Refactor feature check to use resource and feature name
Cc: <stable@vger.kernel.org> # selftests/resctrl: Remove duplicate feature check from CMT test
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3052394ca884..4e9b392d28dc 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -118,7 +118,9 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request("MB", NULL) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("MB", NULL) ||
+	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
+	    (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
 		goto umount;
 	}
@@ -148,7 +150,8 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy")) {
+	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy") ||
+	    !validate_resctrl_feature_request("L3", NULL)) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
 		goto umount;
 	}
-- 
2.30.2

