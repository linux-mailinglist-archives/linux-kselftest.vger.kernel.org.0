Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813BF4D5C33
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 08:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347097AbiCKHY4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 02:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347112AbiCKHYv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 02:24:51 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C889E18A798;
        Thu, 10 Mar 2022 23:23:45 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="65736434"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="65736434"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 16:23:43 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E8017DB9F6;
        Fri, 11 Mar 2022 16:23:41 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 30E05DD746;
        Fri, 11 Mar 2022 16:23:41 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id E678F401110B2;
        Fri, 11 Mar 2022 16:23:40 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 3/6] selftests/resctrl: Fix resctrl_tests' return code to work with selftest framework
Date:   Fri, 11 Mar 2022 16:21:44 +0900
Message-Id: <20220311072147.3301525-4-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
References: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
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
index 973f09a66e1e..a44afb05b848 100644
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
+		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL and PROC_CPU_RESCTRL config options.\n");
 
 	filter_dmesg();
 
-- 
2.27.0

