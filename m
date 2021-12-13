Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10AD4727EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 11:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhLMKGK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 05:06:10 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:6505 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237325AbhLMKEI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:08 -0500
IronPort-SDR: 2I6qqPeUxZp7WvyJX0ll1H9MELDyVx13PSy9pWk8fjGJ9zOD8SUWuaopYLGabe4fv1F/YlCtrA
 z7qYbrBJxRSa5LXwImMURjmBodPx06NlYqqi/bdbDTP47fCNzGUD+6R8tsXYja3k0/mZBh7sf4
 xzs/bcWt68m5/ojgD9xFfyJPT8oDBxeicg48CgPHOvQILc8wzXxXem2fiPxCibaZ4/BJZD95qr
 tj8UdpowbGJKtPvqrDYPZtr4YPmIGK6PB5jBamkHqdqeUOGBVMPuSNwXdEnUkCK1MnG6DCYTqT
 t/j+xy4qFjo9z4hoxML/7big
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="56174873"
X-IronPort-AV: E=Sophos;i="5.88,202,1635174000"; 
   d="scan'208";a="56174873"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Dec 2021 19:04:05 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E50871FA82C;
        Mon, 13 Dec 2021 19:04:03 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3C68B123094C;
        Mon, 13 Dec 2021 19:04:03 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 27B46404398A2;
        Mon, 13 Dec 2021 19:04:03 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v2 2/5] selftests/resctrl: Make resctrl_tests run using kselftest framework
Date:   Mon, 13 Dec 2021 19:01:51 +0900
Message-Id: <20211213100154.180599-3-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit enables resctrl_tests to be built/run in kselftest framework.
Build/run resctrl_tests by building/running all tests of kselftest, or by using
the "TARGETS" variable on the make command line to specify resctrl_tests.
This commit modified the Makefile of kernel kselftest set and
the Makefile of resctrl_tests.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
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
index 6bcee2ec91a9..c9e8540fc594 100644
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
+EXTRA_SOURCES := $(wildcard *.c)
 
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
+$(TEST_GEN_PROGS): $(EXTRA_SOURCES)
+include ../lib.mk
-- 
2.27.0

