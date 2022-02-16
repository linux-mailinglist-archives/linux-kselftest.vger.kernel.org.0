Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6747C4B7DB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 03:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbiBPCaC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 21:30:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiBPCaB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 21:30:01 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 18:29:50 PST
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E066F5437;
        Tue, 15 Feb 2022 18:29:50 -0800 (PST)
IronPort-SDR: 57nfTPdI84U20D21PecGXc83Y9mI9d7w9oCCr6K4Geh5Eah3T+d1o5emFfxlCJrb3u+rwYbmM5
 XPWHeIa2xEe2BY+LzYtxEZ0xDTWvb+YVE9SML/iHrWEjCvMSWEzV+FRCiiHawRZrA8vfqMpGws
 5AAYOGsm2tkZMo0o19+d5uTGOaNBlnIpfVDh8eEEJtQS+MuiFmAr2PBcrUDbxlq4MXpbre6L7S
 Pa+ZLhqPyLBeuu9bvbDIpCQLbeFBE3qMqnWB01GnUXSM0Ph/fVQNzsQ2n+mYWKg1vmv/tQokhd
 Gw0dihpB8ebcy+suG4dgn9Ww
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="42653835"
X-IronPort-AV: E=Sophos;i="5.88,371,1635174000"; 
   d="scan'208";a="42653835"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Feb 2022 11:28:44 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 63097F030A;
        Wed, 16 Feb 2022 11:28:43 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C7F0D69CC;
        Wed, 16 Feb 2022 11:28:42 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id E942E40078D9D;
        Wed, 16 Feb 2022 11:28:41 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v3 3/5] selftests/resctrl: Update README about using kselftest framework to build/run resctrl_tests
Date:   Wed, 16 Feb 2022 11:26:39 +0900
Message-Id: <20220216022641.2998318-4-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
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

In this patch series, I make restrl_tests build/run using kselftest
framework, but some users do not known how to build/run resctrl_tests
using kseltest framework.

Add manual of how to make resctrl_tests build/run
using kselftest framework into README.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/README | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
index 3d2bbd4fa3aa..a0dd459049b7 100644
--- a/tools/testing/selftests/resctrl/README
+++ b/tools/testing/selftests/resctrl/README
@@ -12,9 +12,43 @@ Allocation test on Intel RDT hardware. More tests will be added in the future.
 And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
 as well.
 
+resctrl_tests can be run with or without kselftest framework.
+
+USE KSELFTEST FRAMEWORK
+-----------------------
+
+BUILD
+-----
+
+Execute the following command in top level directory of the kernel source.
+
+Build resctrl:
+ $ make -C tools/testing/selftests TARGETS=resctrl
+
+Build all self tests:
+ $ make -C tools/testing/selftests
+
+RUN
+---
+
+Run resctrl:
+ $ make -C tools/testing/selftests TARGETS=resctrl run_tests
+
+Run all self tests:
+ $ make -C tools/testing/selftests run_tests
+
+Using kselftest framework, the ./resctrl_tests will be run without any parameters.
+
+More details about kselftest framework as follow.
+Documentation/dev-tools/kselftest.rst
+
+NOT USE KSELFTEST FRAMEWORK
+---------------------------
+
 BUILD
 -----
 
+Execute the following command in this directory(tools/testing/selftests/resctrl/).
 Run "make" to build executable file "resctrl_tests".
 
 RUN
-- 
2.27.0

