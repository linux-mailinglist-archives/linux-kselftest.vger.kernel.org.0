Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341A14E4DE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 09:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbiCWIPf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242452AbiCWIP2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 04:15:28 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564A85BE47;
        Wed, 23 Mar 2022 01:13:58 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="67218178"
X-IronPort-AV: E=Sophos;i="5.90,203,1643641200"; 
   d="scan'208";a="67218178"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 23 Mar 2022 17:13:56 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 762301062D;
        Wed, 23 Mar 2022 17:13:55 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C38DDD05F3;
        Wed, 23 Mar 2022 17:13:54 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 9F4FE405732E7;
        Wed, 23 Mar 2022 17:13:54 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v7 5/6] selftests/resctrl: Update README about using kselftest framework to build/run resctrl_tests
Date:   Wed, 23 Mar 2022 17:12:26 +0900
Message-Id: <20220323081227.1603991-6-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220323081227.1603991-1-tan.shaopeng@jp.fujitsu.com>
References: <20220323081227.1603991-1-tan.shaopeng@jp.fujitsu.com>
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

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/README | 39 +++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
index 3d2bbd4fa3aa..8d11ce7c2ee5 100644
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

