Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF33C4DAA37
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 07:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiCPGDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 02:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353752AbiCPGDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 02:03:14 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D3B606D0;
        Tue, 15 Mar 2022 23:01:57 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="66002957"
X-IronPort-AV: E=Sophos;i="5.90,185,1643641200"; 
   d="scan'208";a="66002957"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Mar 2022 15:01:44 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7241CCA247;
        Wed, 16 Mar 2022 15:01:43 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8BD1A15837;
        Wed, 16 Mar 2022 15:01:42 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 76A9E403FA055;
        Wed, 16 Mar 2022 15:01:42 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v4 2/2] selftests/resctrl: Print a message if the result of MBM&CMT tests is failed on Intel cpu
Date:   Wed, 16 Mar 2022 14:59:40 +0900
Message-Id: <20220316055940.292550-3-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com>
References: <20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

According to "Intel Resource Director Technology (Intel RDT) on
2nd Generation Intel Xeon Scalable Processors Reference Manual",
When the Intel Sub-NUMA Clustering(SNC) feature is enabled,
Intel CMT and MBM counters may not be accurate.

However, there does not seem to be an architectural way to detect
if SNC is enabled.

If the result of MBM&CMT test fails on Intel CPU,
print a message to let users know a possible cause of failure.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index dc548d3e2454..97ad6cfee6ee 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -86,6 +86,8 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 		sprintf(benchmark_cmd[5], "%s", MBA_STR);
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
+	if ((get_vendor() == ARCH_INTEL) && res)
+		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 	mbm_test_cleanup();
 }
 
@@ -122,6 +124,8 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 		sprintf(benchmark_cmd[5], "%s", CMT_STR);
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 	ksft_test_result(!res, "CMT: test\n");
+	if ((get_vendor() == ARCH_INTEL) && res)
+		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 	cmt_test_cleanup();
 }
 
-- 
2.27.0

