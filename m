Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0362CDD14
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 10:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJGITo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 04:19:44 -0400
Received: from foss.arm.com ([217.140.110.172]:57368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfJGITo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 04:19:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74FFC1570;
        Mon,  7 Oct 2019 01:19:43 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (unknown [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD17F3F68E;
        Mon,  7 Oct 2019 01:19:42 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Subject: [RFC PATCH] selftests: fix build targets behaviour on failures
Date:   Mon,  7 Oct 2019 09:19:17 +0100
Message-Id: <20191007081917.13242-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, when some of the KSFT subsystems specified in TARGETS fails to
build, the toplevel Makefile just keeps carrying on with the build process.

This behaviour is expected and desirable especially in the context of a CI
system running KSelfTest where is not always easy to guarantee that the
most recent and esoteric toolchain's dependencies are respected across all
KSFT TARGETS in a timely manner.

Unfortunately, as of now, this holds true only if the very last of the
subsystems listed in TARGETS happened to be one that could be successfully
built: if the last listed TARGETS fails, it is taken as the whole outcome
of the Makefile target and the complete build/install halts even though
many other preceding subsytems were in fact already successfully built.

Fix the KSFT Makefile behaviour related to all/install targets in order
to fail as a whole only when the all/install targets have failed for all
of the requested TARGETS, while succeeding when at least one of TARGETS
has been successfully built.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
This patch is based on ksft/fixes branch from:

git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git

on top of commit:

ce3a67780212 selftests: watchdog: Add command line option to show watchdog_info
---
 tools/testing/selftests/Makefile | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 4cdbae6f4e61..d907b050e929 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -140,11 +140,13 @@ else
 endif
 
 all: khdr
-	@for TARGET in $(TARGETS); do		\
-		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		mkdir $$BUILD_TARGET  -p;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;\
-	done;
+	@ret=1;							\
+	for TARGET in $(TARGETS); do				\
+		BUILD_TARGET=$$BUILD/$$TARGET;			\
+		mkdir $$BUILD_TARGET  -p;			\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;	\
+		ret=$$((ret * $$?));				\
+	done; exit $$ret;
 
 run_tests: all
 	@for TARGET in $(TARGETS); do \
@@ -192,10 +194,12 @@ ifdef INSTALL_PATH
 	mkdir -p $(INSTALL_PATH)/kselftest
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
-	@for TARGET in $(TARGETS); do \
+	@ret=1;	\
+	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
-	done;
+		ret=$$((ret * $$?));		\
+	done; exit $$ret
 
 	@# Ask all targets to emit their test scripts
 	echo "#!/bin/sh" > $(ALL_SCRIPT)
-- 
2.17.1

