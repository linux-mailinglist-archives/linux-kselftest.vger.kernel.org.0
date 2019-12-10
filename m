Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A175D1186E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2019 12:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLJLpP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Dec 2019 06:45:15 -0500
Received: from foss.arm.com ([217.140.110.172]:41044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfLJLpO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Dec 2019 06:45:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A8BB1FB;
        Tue, 10 Dec 2019 03:45:14 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B5A93F6CF;
        Tue, 10 Dec 2019 03:45:13 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Subject: [PATCH v2] selftests: fix build behaviour on targets' failures
Date:   Tue, 10 Dec 2019 11:44:59 +0000
Message-Id: <20191210114459.11405-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, when some of the KSFT subsystems fails to build, the toplevel
KSFT Makefile just keeps carrying on with the build process.

This behaviour is expected and desirable especially in the context of a CI
system running KSelfTest, since it is not always easy to guarantee that the
most recent and esoteric dependencies are respected across all KSFT TARGETS
in a timely manner.

Unfortunately, as of now, this holds true only if the very last of the
built subsystems could have been successfully compiled: if the last of
those subsystem instead failed to build, such failure is taken as the whole
outcome of the Makefile target and the complete build/install process halts
even though many other preceding subsytems were in fact already built
successfully.

Fix the KSFT Makefile behaviour related to all/install targets in order
to fail as a whole only when the all/install targets have failed for all
of the requested TARGETS, while succeeding when at least one of TARGETS
has been successfully built.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
This patch is based on ksft/fixes branch from:

git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git

on top of commit (~5.5-rc1):

99e51aa8f701 Documentation: kunit: add documentation for kunit_tool

Building with either:

make kselftest-install \
	     KSFT_INSTALL_PATH=/tmp/KSFT \
	     TARGETS="exec arm64 bpf"

make -C tools/testing/selftests  install \
	     KSFT_INSTALL_PATH=/tmp/KSFT \
	     TARGETS="exec arm64 bpf"

(with 'bpf' not building clean on my setup in the above case)

and veryfying that build/install completes if at least one of TARGETS can
be successfully built, and any successfully built subsystem is installed.

Changes:
-------
V1 --> V2
- rebased on 5.5-rc1
- rewording commit message
- dropped RFC tag
---
 tools/testing/selftests/Makefile | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b001c602414b..86b2a3fca04d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -143,11 +143,13 @@ else
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
@@ -196,10 +198,12 @@ ifdef INSTALL_PATH
 	install -m 744 kselftest/module.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
-	@for TARGET in $(TARGETS); do \
+	@ret=1;	\
+	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
-	done;
+		ret=$$((ret * $$?));		\
+	done; exit $$ret;
 
 	@# Ask all targets to emit their test scripts
 	echo "#!/bin/sh" > $(ALL_SCRIPT)
-- 
2.17.1

