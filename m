Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973234CD28B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 11:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiCDKke (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 05:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiCDKkd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 05:40:33 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D07D1AA07F;
        Fri,  4 Mar 2022 02:39:44 -0800 (PST)
IronPort-SDR: xF+BeZIf+xO7V5pKKVNI4Vlh4NJroVuqbkz5P8ukxusYbk0K/BghZEGw9SN962c9NCCMDy0mAd
 kK3r7eO8MBQjmRUliPHJFh+KnzPoPch9JzCSu3va5MpoegajUWmfbDo+yq+eNJumZu9KXtq6M6
 CzeKCKkrwj/F9pptb9sQYionIN6M014BUEC8oyaT4Mgd3GpytRu8Is190Y4ZTloD+TE5+A19+t
 I7boJ7rwqH6P9cZcFLsVSNzeo80VMgUvXjQ/zA+PKOtIxelI7WoHctuDizyh8SEgUQMImUdopS
 +/EQTt93V9dskUchMHNijHoy
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="65111056"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; 
   d="scan'208";a="65111056"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2022 19:39:40 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C7D1ACC141;
        Fri,  4 Mar 2022 19:39:38 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0EF10D9467;
        Fri,  4 Mar 2022 19:39:38 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id E692D40450F6A;
        Fri,  4 Mar 2022 19:39:37 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v4 4/6] selftests/resctrl: Make resctrl_tests run using kselftest framework
Date:   Fri,  4 Mar 2022 19:38:32 +0900
Message-Id: <20220304103834.486892-5-tan.shaopeng@jp.fujitsu.com>
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

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/Makefile         |  1 +
 tools/testing/selftests/resctrl/Makefile | 18 +++---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

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
index 6bcee2ec91a9..30af27b07d21 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,17 +1,5 @@
-CC = $(CROSS_COMPILE)gcc
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
-SRCS=$(wildcard *.c)
-OBJS=$(SRCS:.c=.o)
+TEST_GEN_PROGS := resctrl_tests
 
-all: resctrl_tests
+include ../lib.mk
 
-$(OBJS): $(SRCS)
-	$(CC) $(CFLAGS) -c $(SRCS)
-
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

