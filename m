Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC5E6DF6F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjDLNWx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjDLNWj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:22:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB60EA255;
        Wed, 12 Apr 2023 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305735; x=1712841735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OLYZ9NVCKLzXKH4vmBFaOz5iIxtHpU0cehnEgNb0+A0=;
  b=mDZGCfHBFIrMy7Jge4iR9i4CIOE/r0r8THbmSOHE9N9I9nTEdSXG1Kng
   sRQmuXnbkKDEQS5KoNnZM1wE4aaHO3a04vhllFEWSi9qRjTwy5tyaIyza
   pjCS316L0LeHM+tU2x3q8JfhoRtwM+9CG2Bxilqjhu3sEMRBuVbQ3Hu6g
   J5m+6+L1f4QJHKf4RpGjgLAWRaxdMgwk0yHXSDynQLft73jtdNHEJ11AV
   xj7Lwys9c46tP2Is9qIkhOQyocMMvLzZQJbRDxt3W8NdSk9yQTujZeGsl
   YAR9f7/9uinonvS9FnTwIIf3m1hSGXRD4tSq3gT15WQI1z+eu70vI7tXi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590071"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590071"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230054"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230054"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/22] selftests/resctrl: Remove duplicated preparation for span arg
Date:   Wed, 12 Apr 2023 16:21:05 +0300
Message-Id: <20230412132122.29452-6-ilpo.jarvinen@linux.intel.com>
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

When no benchmark_cmd is given, benchmark_cmd[1] is set to span in
main(). There's no need to do it again in run_mba_test().

Remove the duplicated preparation for span argument into
benchmark_cmd[1] from run_mba_test(). It enables also removing has_ben
argument from run_mba_test() as unnecessary.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index a26fb4badde0..3ca6f09f5195 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -91,8 +91,8 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 	mbm_test_cleanup();
 }
 
-static void run_mba_test(bool has_ben, char **benchmark_cmd, unsigned long span,
-			 int cpu_no, char *bw_report)
+static void run_mba_test(char **benchmark_cmd, unsigned long span, int cpu_no,
+			 char *bw_report)
 {
 	int res;
 
@@ -103,8 +103,6 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 		return;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[1], "%lu", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 	mba_test_cleanup();
@@ -263,7 +261,7 @@ int main(int argc, char **argv)
 		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
 	if ((get_vendor() == ARCH_INTEL) && mba_test)
-		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
+		run_mba_test(benchmark_cmd, span, cpu_no, bw_report);
 
 	if (cmt_test)
 		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
-- 
2.30.2

