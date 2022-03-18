Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA924DD5AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiCRIAy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiCRIAx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 04:00:53 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C2917E37F;
        Fri, 18 Mar 2022 00:59:33 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="66311278"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; 
   d="scan'208";a="66311278"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 18 Mar 2022 16:59:32 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 50216E07E9;
        Fri, 18 Mar 2022 16:59:30 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 79181E6A67;
        Fri, 18 Mar 2022 16:59:29 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 2B257400C15EF;
        Fri, 18 Mar 2022 16:59:29 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v6 5/6] selftests/resctrl: Update README about using kselftest framework to build/run resctrl_tests
Date:   Fri, 18 Mar 2022 16:58:06 +0900
Message-Id: <20220318075807.2921063-6-tan.shaopeng@jp.fujitsu.com>
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

resctrl_tests can be built or run using kselftests framework.
Add description on how to do so in README.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/README | 39 +++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
index 3d2bbd4fa3aa..58d0cb4e6a16 100644
--- a/tools/testing/selftests/resctrl/README
+++ b/tools/testing/selftests/resctrl/README
@@ -12,24 +12,49 @@ Allocation test on Intel RDT hardware. More tests will be added in the future.
 And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
 as well.
 
+resctrl_tests can be run with or without kselftest framework.
+
+WITH KSELFTEST FRAMEWORK
+=======================
+
 BUILD
 -----
 
-Run "make" to build executable file "resctrl_tests".
+Build executable file "resctrl_tests" from top level directory of the kernel source:
+ $ make -C tools/testing/selftests TARGETS=resctrl
 
 RUN
 ---
 
-To use resctrl_tests, root or sudoer privileges are required. This is because
-the test needs to mount resctrl file system and change contents in the file
-system.
+Run resctrl_tests as sudo or root since the test needs to mount resctrl file
+system and change contents in the file system.
+Using kselftest framework will run all supported tests within resctrl_tests:
+
+ $ sudo make -C tools/testing/selftests TARGETS=resctrl run_tests
+
+More details about kselftest framework can be found in
+Documentation/dev-tools/kselftest.rst.
+
+WITHOUT KSELFTEST FRAMEWORK
+===========================
+
+BUILD
+-----
+
+Build executable file "resctrl_tests" from this directory(tools/testing/selftests/resctrl/):
+  $ make
+
+RUN
+---
 
+Run resctrl_tests as sudo or root since the test needs to mount resctrl file
+system and change contents in the file system.
 Executing the test without any parameter will run all supported tests:
 
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

