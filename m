Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D39E4D5C3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 08:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347115AbiCKHY4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 02:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347091AbiCKHYz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 02:24:55 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6312618DA82;
        Thu, 10 Mar 2022 23:23:52 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="53848344"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="53848344"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 16:23:49 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 31943DB9F5;
        Fri, 11 Mar 2022 16:23:49 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E2840D95EC;
        Fri, 11 Mar 2022 16:23:47 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id AA1F4401110B3;
        Fri, 11 Mar 2022 16:23:47 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v5 5/6] selftests/resctrl: Update README about using kselftest framework to build/run resctrl_tests
Date:   Fri, 11 Mar 2022 16:21:46 +0900
Message-Id: <20220311072147.3301525-6-tan.shaopeng@jp.fujitsu.com>
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

resctrl_tests can be built or run using kselftests framework.
Add description on how to do so in README.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/README | 43 ++++++++++++++++++++------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
index 3d2bbd4fa3aa..c74b8246e6c9 100644
--- a/tools/testing/selftests/resctrl/README
+++ b/tools/testing/selftests/resctrl/README
@@ -12,24 +12,49 @@ Allocation test on Intel RDT hardware. More tests will be added in the future.
 And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
 as well.
 
+resctrl_tests can be run with or without kselftest framework.
+
+USE KSELFTEST FRAMEWORK
+=======================
+
+* BUILD
+-------
+
+Build executable file "resctrl_tests" at top level directory of the kernel source.
+ $ make -C tools/testing/selftests TARGETS=resctrl
+
+* RUN
+-----
+
+Run resctrl_tests as sudo or root since the test needs to mount resctrl file
+system and change contents in the file system.
+Using kselftest framework will run all supported tests of resctrl_tests.
+
+ $ sudo make -C tools/testing/selftests TARGETS=resctrl run_tests
+
+More details about kselftest framework as follow.
+Documentation/dev-tools/kselftest.rst
+
+NOT USE KSELFTEST FRAMEWORK
+===========================
+
 BUILD
 -----
 
-Run "make" to build executable file "resctrl_tests".
+Build executable file "resctrl_tests" at this directory(tools/testing/selftests/resctrl/).
+  $ make
 
 RUN
 ---
 
-To use resctrl_tests, root or sudoer privileges are required. This is because
-the test needs to mount resctrl file system and change contents in the file
-system.
-
-Executing the test without any parameter will run all supported tests:
+Run resctrl_tests as sudo or root since the test needs to mount resctrl file
+system and change contents in the file system.
+Executing the test without any parameter will run all supported tests.
 
-	sudo ./resctrl_tests
+ $ sudo ./resctrl_tests
 
 OVERVIEW OF EXECUTION
----------------------
+=====================
 
 A test case has four stages:
 
@@ -41,7 +66,7 @@ A test case has four stages:
   - teardown: umount resctrl and clear temporary files.
 
 ARGUMENTS
----------
+=========
 
 Parameter '-h' shows usage information.
 
-- 
2.27.0

