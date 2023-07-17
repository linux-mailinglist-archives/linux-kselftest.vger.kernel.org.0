Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D39756433
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjGQNRS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGQNRD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:17:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BE13E;
        Mon, 17 Jul 2023 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599784; x=1721135784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aK7jbebXRGb8FKB1MW4zoqRf8HpNU5bNcvdF3+o9RRw=;
  b=LIEiirHIdPsb+tXi8jtHvvqBxWIhrHpeBpM5jfaMuFBXxVrmAf2dKDLr
   L7mvoy520Diq83GH2duwbYc2k0Eg/DzaiLC2m3kOCgd1eG1g2qeoKoVGl
   AQ7gtyLN1yfT77HhIYxxDnp8lBvax5kLwc+JVGa4g4niIIMtkURrCfAKS
   6zbgz6qS0xsMgrzPQOs5CaJNJqWmLPySfEI0NrVS9Qbs0wGVmNr8NhwU9
   rM0u4UXJwHgWmZ1UY1Oyej7aEK27QFNjhSmRUlJCgpJ8+j2kbdvmgdGWs
   yc6YzK1MQ+yv4NSLSiC1NvqJlKMtARI06aSYHasJkDD9qXi8OujRwuCPC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368569089"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368569089"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793247073"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793247073"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:21 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 11/19] selftests/resctrl: Remove duplicated preparation for span arg
Date:   Mon, 17 Jul 2023 16:14:59 +0300
Message-Id: <20230717131507.32420-12-ilpo.jarvinen@linux.intel.com>
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

When no benchmark_cmd is given, benchmark_cmd[1] is set to span in
main(). There's no need to do it again in run_mba_test().

Remove the duplicated preparation for span argument into
benchmark_cmd[1] from run_mba_test(). After this, the has_ben and span
arguments to run_mba_test() can be removed.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3a65dacb441e..bf0cadab36b0 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -99,8 +99,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, size_t span,
 	umount_resctrlfs();
 }
 
-static void run_mba_test(bool has_ben, char **benchmark_cmd, size_t span,
-			 int cpu_no, char *bw_report)
+static void run_mba_test(char **benchmark_cmd, int cpu_no, char *bw_report)
 {
 	int res;
 
@@ -117,8 +116,6 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, size_t span,
 		goto umount;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[1], "%zu", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
@@ -299,7 +296,7 @@ int main(int argc, char **argv)
 		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
 	if (mba_test)
-		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
+		run_mba_test(benchmark_cmd, cpu_no, bw_report);
 
 	if (cmt_test)
 		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
-- 
2.30.2

