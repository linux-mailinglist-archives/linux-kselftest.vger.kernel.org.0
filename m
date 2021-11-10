Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12CB44BDF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 10:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhKJJnx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 04:43:53 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130]:15192 "EHLO
        esa5.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhKJJns (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 04:43:48 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 04:43:47 EST
IronPort-SDR: ig52yG2K8H7lMwcikA4iNUuzt97U2zeAQZx1K8GafHLgy9Kr8StrAiGGno7wlYwE7DJ18JyT/C
 r6i8TEOluupVBvL9z5COUG/jFsKUj7Ozj/A7A8yiwvByNYmy8UZNiszc86bVGBpmDljn6yk8Fa
 /bM4CH47OgoH6eyOheEi9LEpkGXtw+eXoJOQhXsiNczZqM8sLciYKtyH4ZhOp2EyJCXjU4nSRh
 H68EPwi592o7GfQB4NWsPRcmk2THFyknLnN04dgBIbfCOGgLwsywdOgNLz12d3C6SS+gK+BhmO
 6CzxwoIOi8IjJ5DdQsTtOmHn
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="51705404"
X-IronPort-AV: E=Sophos;i="5.87,223,1631545200"; 
   d="scan'208";a="51705404"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 10 Nov 2021 18:33:50 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4921D14C4A6;
        Wed, 10 Nov 2021 18:33:48 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7BBCDAD00E;
        Wed, 10 Nov 2021 18:33:47 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 81D1F4006B62C;
        Wed, 10 Nov 2021 18:33:46 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using kselftest framework
Date:   Wed, 10 Nov 2021 18:33:13 +0900
Message-Id: <20211110093315.3219191-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>

This commit enables kselftest to be built/run in resctrl framework.
Build/run resctrl_tests by build/run all tests of kselftest, or by using
the "TARGETS" variable on the make command line to specify resctrl_tests.
To make resctrl_tests run using kselftest framework, this commit modified
the Makefile of kernel kselftest set and the Makefile of resctrl_tests.
To ensure the resctrl_tests finish in limited time, this commit changed
the default limited time(45s) to 120 seconds for resctrl_tests by adding
"setting" file.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/Makefile         |  1 +
 tools/testing/selftests/resctrl/Makefile | 21 +++++++++------------
 tools/testing/selftests/resctrl/settings |  1 +
 3 files changed, 11 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/settings

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c852eb4..7df397c 100644
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
index 6bcee2e..3786cbb 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,17 +1,14 @@
-CC = $(CROSS_COMPILE)gcc
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
-SRCS=$(wildcard *.c)
-OBJS=$(SRCS:.c=.o)
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for resctrl selftests
 
-all: resctrl_tests
+CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
+LDLIBS += -lnuma
 
-$(OBJS): $(SRCS)
-	$(CC) $(CFLAGS) -c $(SRCS)
+TEST_GEN_PROGS := resctrl_tests
+EXTRA_SOURCES := $(wildcard *.c)
 
-resctrl_tests: $(OBJS)
-	$(CC) $(CFLAGS) -o $@ $^
+all: $(TEST_GEN_PROGS)
 
-.PHONY: clean
+$(TEST_GEN_PROGS): $(EXTRA_SOURCES)
 
-clean:
-	$(RM) $(OBJS) resctrl_tests
+include ../lib.mk
diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
new file mode 100644
index 0000000..6091b45
--- /dev/null
+++ b/tools/testing/selftests/resctrl/settings
@@ -0,0 +1 @@
+timeout=120
-- 
1.8.3.1

