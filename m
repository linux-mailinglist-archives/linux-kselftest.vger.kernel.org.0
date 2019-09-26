Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1903BF7F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfIZRwu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 13:52:50 -0400
Received: from foss.arm.com ([217.140.110.172]:55954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfIZRwu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 13:52:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0D861570;
        Thu, 26 Sep 2019 10:52:49 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48AE3F67D;
        Thu, 26 Sep 2019 10:52:48 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com, Tim.Bird@sony.com
Subject: [PATCH v2 1/2] kselftest: add capability to skip chosen TARGETS
Date:   Thu, 26 Sep 2019 18:52:18 +0100
Message-Id: <20190926175219.29805-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175219.29805-1-cristian.marussi@arm.com>
References: <20190926175219.29805-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let the user specify an optional TARGETS skiplist through the new optional
SKIP_TARGETS Makefile variable.

It is easier to skip at will using a reduced and well defined list of
possibly problematic targets with SKIP_TARGETS than to provide a partially
stripped down list of good targets using the usual TARGETS variable.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- fixed commit msg
- added documentation fix
- added forced override to allow TARGETS= and SKIP_TARGETS
  being both passed on the cmdline
---
 Documentation/dev-tools/kselftest.rst | 16 ++++++++++++++++
 tools/testing/selftests/Makefile      |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 25604904fa6e..ecdfdc9d4b03 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -89,6 +89,22 @@ To build, save output files in a separate directory with KBUILD_OUTPUT ::
 
   $ export KBUILD_OUTPUT=/tmp/kselftest; make TARGETS="size timers" kselftest
 
+Additionally you can use the "SKIP_TARGETS" variable on the make command
+line to specify one or more targets to exclude from the TARGETS list.
+
+To run all tests but a single subsystem::
+
+  $ make -C tools/testing/selftests SKIP_TARGETS=ptrace run_tests
+
+You can specify multiple tests to skip::
+
+  $  make SKIP_TARGETS="size timers" kselftest
+
+You can also specify a restricted list of tests to run together with a
+dedicated skiplist::
+
+  $  make TARGETS="bpf breakpoints size timers" SKIP_TARGETS=bpf kselftest
+
 See the top-level tools/testing/selftests/Makefile for the list of all
 possible targets.
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 25b43a8c2b15..9621b26ee433 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -63,6 +63,13 @@ TARGETS += zram
 TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
+# User can optionally provide a TARGETS skiplist.
+SKIP_TARGETS ?=
+ifneq ($(SKIP_TARGETS),)
+	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
+	override TARGETS := $(TMP)
+endif
+
 # Clear LDFLAGS and MAKEFLAGS if called from main
 # Makefile to avoid test build failures when test
 # Makefile doesn't have explicit build rules.
-- 
2.17.1

