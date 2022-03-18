Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7C4DD5B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiCRIAr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 04:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiCRIAq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 04:00:46 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECB317DCB5;
        Fri, 18 Mar 2022 00:59:28 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="66595754"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; 
   d="scan'208";a="66595754"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 18 Mar 2022 16:59:26 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id DEE6BCA240;
        Fri, 18 Mar 2022 16:59:24 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 13FBFDA9E4;
        Fri, 18 Mar 2022 16:59:24 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id B3ED94006F185;
        Fri, 18 Mar 2022 16:59:23 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v6 3/6] selftests/resctrl: Fix resctrl_tests' return code to work with selftest framework
Date:   Fri, 18 Mar 2022 16:58:04 +0900
Message-Id: <20220318075807.2921063-4-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In kselftest framework, if a sub test can not run by some reasons,
the test result should be marked as SKIP rather than FAIL.
Return KSFT_SKIP(4) instead of KSFT_FAIL(1) if resctrl_tests is not run
as root or it is run on a test environment which does not support resctrl.

 - ksft_exit_fail_msg(): returns KSFT_FAIL(1)
 - ksft_exit_skip(): returns KSFT_SKIP(4)

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 973f09a66e1e..ed7e1a995b01 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -205,7 +205,7 @@ int main(int argc, char **argv)
 	 * 2. We execute perf commands
 	 */
 	if (geteuid() != 0)
-		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
+		return ksft_exit_skip("Not running as root. Skipping...\n");
 
 	/* Detect AMD vendor */
 	detect_amd();
@@ -235,7 +235,7 @@ int main(int argc, char **argv)
 	sprintf(bm_type, "fill_buf");
 
 	if (!check_resctrlfs_support())
-		return ksft_exit_fail_msg("resctrl FS does not exist\n");
+		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config options.\n");
 
 	filter_dmesg();
 
-- 
2.27.0

