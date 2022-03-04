Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8429D4CD28D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 11:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiCDKkk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 05:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiCDKkh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 05:40:37 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CA1AA07F;
        Fri,  4 Mar 2022 02:39:49 -0800 (PST)
IronPort-SDR: 4JRLpRH0MTmQaM76LzZ93iR5poDRcfLHQbVY8aFCw6bEhjDY2G5A6dcTHW5UutfqH90PftWJQv
 pd3wZrvouXQLBK8nGp0UuHf8OqjeCqhHUnk3ywdZAWSSRI95p9KGP3CLf04WqK+ddP2pOOW2bO
 c3EXm6P+2X2y3HI7zuSWwFVIyRjIedHsHWmUyahF2RqvcoARUhWEU+5eauKBm+yoAyCFxv435k
 GdYbpdSbbLzQZQCq11Bz4DQLNmNjh+Ac95p4gQHt11vmhE+HCeYztLv5xeLbEIgW6d2LdwFCCC
 g9Xn+FnX1NykpL0JQtOTAYRg
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="65486340"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; 
   d="scan'208";a="65486340"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2022 19:39:47 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 84351E0550;
        Fri,  4 Mar 2022 19:39:45 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id BB30CDCCF2;
        Fri,  4 Mar 2022 19:39:44 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 9EFDD40451C6F;
        Fri,  4 Mar 2022 19:39:44 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v4 5/6] selftests/resctrl: Update README about using kselftest framework to build/run resctrl_tests
Date:   Fri,  4 Mar 2022 19:38:33 +0900
Message-Id: <20220304103834.486892-6-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220304103834.486892-1-tan.shaopeng@jp.fujitsu.com>
References: <20220304103834.486892-1-tan.shaopeng@jp.fujitsu.com>
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
 tools/testing/selftests/resctrl/README | 31 +++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
index 3d2bbd4fa3aa..268cf3f95bd5 100644
--- a/tools/testing/selftests/resctrl/README
+++ b/tools/testing/selftests/resctrl/README
@@ -12,9 +12,37 @@ Allocation test on Intel RDT hardware. More tests will be added in the future.
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
+RUN
+---
+
+Run resctrl:
+ $ make -C tools/testing/selftests TARGETS=resctrl run_tests
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
@@ -24,7 +52,8 @@ To use resctrl_tests, root or sudoer privileges are required. This is because
 the test needs to mount resctrl file system and change contents in the file
 system.
 
-Executing the test without any parameter will run all supported tests:
+Executing the test without any parameter will run all supported tests.
+It takes about 68 seconds on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz.
 
 	sudo ./resctrl_tests
 
-- 
2.27.0

