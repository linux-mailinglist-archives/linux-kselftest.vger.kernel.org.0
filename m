Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0532D4E4DE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 09:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbiCWIPh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 04:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242489AbiCWIP3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 04:15:29 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF151CFCD;
        Wed, 23 Mar 2022 01:13:58 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="67187806"
X-IronPort-AV: E=Sophos;i="5.90,203,1643641200"; 
   d="scan'208";a="67187806"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 23 Mar 2022 17:13:56 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 51CD2C68A4;
        Wed, 23 Mar 2022 17:13:55 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 97E91D9742;
        Wed, 23 Mar 2022 17:13:54 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 8D91E4057331C;
        Wed, 23 Mar 2022 17:13:53 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v7 4/6] selftests/resctrl: Make resctrl_tests run using kselftest framework
Date:   Wed, 23 Mar 2022 17:12:25 +0900
Message-Id: <20220323081227.1603991-5-tan.shaopeng@jp.fujitsu.com>
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

In kselftest framework, all tests can be build/run at a time,
and a sub test also can be build/run individually. As follows:
$ make kselftest-all TARGETS=resctrl
$ make -C tools/testing/selftests run_tests
$ make -C tools/testing/selftests TARGETS=resctrl run_tests

However, resctrl_tests cannot be run using kselftest framework,
users have to change directory to tools/testing/selftests/resctrl/,
run "make" to build executable file "resctrl_tests",
and run "sudo ./resctrl_tests" to execute the test.

To build/run resctrl_tests using kselftest framework.
Modify tools/testing/selftests/Makefile
and tools/testing/selftests/resctrl/Makefile.

Even after this change, users can still build/run resctrl_tests
without using framework as before.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com> # resctrl changes
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/Makefile         |  1 +
 tools/testing/selftests/resctrl/Makefile | 17 ++++-------------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d08fe4cfe811..6138354b3760 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -52,6 +52,7 @@ TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
+TARGETS += resctrl
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 6bcee2ec91a9..bee5fa8f1ac9 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,17 +1,8 @@
-CC = $(CROSS_COMPILE)gcc
 CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
-SRCS=$(wildcard *.c)
-OBJS=$(SRCS:.c=.o)
+CFLAGS += $(KHDR_INCLUDES)
 
-all: resctrl_tests
+TEST_GEN_PROGS := resctrl_tests
 
-$(OBJS): $(SRCS)
-	$(CC) $(CFLAGS) -c $(SRCS)
+include ../lib.mk
 
-resctrl_tests: $(OBJS)
-	$(CC) $(CFLAGS) -o $@ $^
-
-.PHONY: clean
-
-clean:
-	$(RM) $(OBJS) resctrl_tests
+$(OUTPUT)/resctrl_tests: $(wildcard *.c)
-- 
2.27.0

