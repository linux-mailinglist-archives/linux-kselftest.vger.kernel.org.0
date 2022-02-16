Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF054B7DE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 03:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbiBPC3w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 21:29:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiBPC3w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 21:29:52 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AC2F5426;
        Tue, 15 Feb 2022 18:29:39 -0800 (PST)
IronPort-SDR: 3qn+0Ks3jcTk0FvJSLbZBENPd8+dSBt7hBT+gYRdDUX4ggXHMMLIBoZPlmvJiSHuKmYDxzwvbP
 olgCGWngWCxq8CsotpyXciYP10wQdlvfFaT1PMjHnmmsKrd1goqjwq7D4CO9+uPzuKxgcBKCnO
 1FUf+nuxHo8JNIQkqL8tF2DkrnPbo/dbMFkSiUkwcafGbBzYq3L2252GWMswtcPT/pQ8laVcHO
 uIxKGmkeCpEJViM+po2Ml5mvWd9Xyse56XAHqQRzx5c3bI2mEG4EKvlVJcTwNK9un746hgKAb8
 lk7Hh7hkUXN11Qu8w79+CXI6
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="62683600"
X-IronPort-AV: E=Sophos;i="5.88,371,1635174000"; 
   d="scan'208";a="62683600"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Feb 2022 11:28:34 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id BB199E5B2D;
        Wed, 16 Feb 2022 11:28:32 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0AE04141A2;
        Wed, 16 Feb 2022 11:28:32 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id DAB0C4007EB18;
        Wed, 16 Feb 2022 11:28:31 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v3 2/5] selftests/resctrl: Make resctrl_tests run using kselftest framework
Date:   Wed, 16 Feb 2022 11:26:38 +0900
Message-Id: <20220216022641.2998318-3-tan.shaopeng@jp.fujitsu.com>
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

In kselftest framework, all tests can be build/run at a time,
and a sub test also can be build/run individually. As follows:
$ make -C tools/testing/selftests run_tests
$ make -C tools/testing/selftests TARGETS=ptrace run_tests

However, resctrl_tests cannot be run using kselftest framework,
users have to change directory to tools/testing/selftests/resctrl/,
run "make" to build executable file "resctrl_tests",
and run "sudo ./resctrl_tests" to execute the test.

To build/run resctrl_tests using kselftest framework.
Modify tools/testing/selftests/Makefile
and tools/testing/selftests/resctrl/Makefile.

Even after this change, users can still build/run resctrl_tests
without using framework as before.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Some important feedbacks from v1&v2 are addressed as follows:

- The changelog mentions that changes were made to the resctrl
  selftest Makefile but it does not describe what the change accomplish
  or why they are needed.
  => By changing the Makefile, resctrl_tests can use kselftest
     framework like other sub tests. I described this in changelog.

- The changelog did not describe how a user may use the kselftest
  framework to run the resctrl tests nor the requested information
  on how existing workflows are impacted.
  => I described how to build/run resctrl_tests with kselftest framework,
     and described the existing workflows are not impacted that users can
     build/run resctrl_tests without using kselftest framework as before.

- tools/testing/selftests/resctrl/README should be updated.
  => I separate the update of README to a new patch.[patch v3 3/5]

- Why is the meaning of "EXTRA_SOURCES" (i.e. what is "extra"?) and
  why is "SRCS" no longer sufficient?
  => I referred to other Makefiles, and found "SRCS" is better
     than "EXTRA_SOURCES". So, I updated it to use "SRCS".

 tools/testing/selftests/Makefile         |  1 +
 tools/testing/selftests/resctrl/Makefile | 20 ++++++--------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c852eb40c4f7..7df397c6893c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -51,6 +51,7 @@ TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
+TARGETS += resctrl
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 6bcee2ec91a9..de26638540ba 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,17 +1,9 @@
-CC = $(CROSS_COMPILE)gcc
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
-SRCS=$(wildcard *.c)
-OBJS=$(SRCS:.c=.o)
+CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
 
-all: resctrl_tests
+TEST_GEN_PROGS := resctrl_tests
+SRCS := $(wildcard *.c)
 
-$(OBJS): $(SRCS)
-	$(CC) $(CFLAGS) -c $(SRCS)
+all: $(TEST_GEN_PROGS)
 
-resctrl_tests: $(OBJS)
-	$(CC) $(CFLAGS) -o $@ $^
-
-.PHONY: clean
-
-clean:
-	$(RM) $(OBJS) resctrl_tests
+$(TEST_GEN_PROGS): $(SRCS)
+include ../lib.mk
-- 
2.27.0

