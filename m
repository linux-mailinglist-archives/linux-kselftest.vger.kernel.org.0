Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B482EE52BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2019 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfJYR6M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Oct 2019 13:58:12 -0400
Received: from foss.arm.com ([217.140.110.172]:43888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730363AbfJYR6M (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Oct 2019 13:58:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 434BE337;
        Fri, 25 Oct 2019 10:58:11 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 409DE3F6C4;
        Fri, 25 Oct 2019 10:58:10 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com,
        suzuki.poulose@arm.com
Subject: [PATCH v10 01/12] kselftest: arm64: extend toplevel skeleton Makefile
Date:   Fri, 25 Oct 2019 18:57:06 +0100
Message-Id: <20191025175717.15154-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025175717.15154-1-cristian.marussi@arm.com>
References: <20191025175717.15154-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Modify KSFT arm64 toplevel Makefile to maintain arm64 kselftests organized
by subsystem, keeping them into distinct subdirectories under arm64 custom
KSFT directory: tools/testing/selftests/arm64/

Add to such toplevel Makefile a mechanism to guess the effective location
of Kernel headers as installed by KSFT framework.

Fit existing arm64 tags kselftest into this new schema moving them into
their own subdirectory (arm64/tags).

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Based on:
commit 9ce1263033cd ("selftests, arm64: add a selftest for passing
		     tagged pointers to kernel")
---
v8 --> v9
- moved original tags test .gitignore to its own subdirectory
v6 --> v7
- renamed SUBTARGETS to ARM64_SUBTARGETS to avoid name clashes
- rebased on v5.4-rc2 accounting for further new patches on top of commit 9ce1263033cd
v5 --> v6
- using realpath to avoid passing down relative paths
- fix commit msg & Copyright
- removed unneded Makefile export
- added SUBTARGETS specification, to allow building specific only some
  arm64 test subsystems
v4 --> v5
- rebased on arm64/for-next/core
- merged this patch with KSFT arm64 tags patch, while moving the latter
  into its own subdir
- moved kernel header includes search mechanism from KSFT arm64
  SIGNAL Makefile
- export proper top_srcdir ENV for lib.mk
v3 --> v4
- comment reword
- simplified documentation in README
- dropped README about standalone
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/arm64/Makefile        | 64 +++++++++++++++++--
 tools/testing/selftests/arm64/README          | 25 ++++++++
 .../selftests/arm64/{ => tags}/.gitignore     |  0
 tools/testing/selftests/arm64/tags/Makefile   |  7 ++
 .../arm64/{ => tags}/run_tags_test.sh         |  0
 .../selftests/arm64/{ => tags}/tags_test.c    |  0
 7 files changed, 92 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/README
 rename tools/testing/selftests/arm64/{ => tags}/.gitignore (100%)
 create mode 100644 tools/testing/selftests/arm64/tags/Makefile
 rename tools/testing/selftests/arm64/{ => tags}/run_tags_test.sh (100%)
 rename tools/testing/selftests/arm64/{ => tags}/tags_test.c (100%)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 4cdbae6f4e61..a740198e07d7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TARGETS = android
+TARGETS += arm64
 TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += capabilities
diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index f9f79fb272f0..cd27ca689224 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -1,12 +1,66 @@
 # SPDX-License-Identifier: GPL-2.0
 
-# ARCH can be overridden by the user for cross compiling
+# When ARCH not overridden for crosscompiling, lookup machine
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-CFLAGS += -I../../../../usr/include/
-TEST_GEN_PROGS := tags_test
-TEST_PROGS := run_tags_test.sh
+ARM64_SUBTARGETS ?= tags
+else
+ARM64_SUBTARGETS :=
 endif
 
-include ../lib.mk
+CFLAGS := -Wall -O2 -g
+
+# A proper top_srcdir is needed by KSFT(lib.mk)
+top_srcdir = $(realpath ../../../../)
+
+# Additional include paths needed by kselftest.h and local headers
+CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
+
+# Guessing where the Kernel headers could have been installed
+# depending on ENV config
+ifeq ($(KBUILD_OUTPUT),)
+khdr_dir = $(top_srcdir)/usr/include
+else
+# the KSFT preferred location when KBUILD_OUTPUT is set
+khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
+endif
+
+CFLAGS += -I$(khdr_dir)
+
+export CFLAGS
+export top_srcdir
+
+all:
+	@for DIR in $(ARM64_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		mkdir -p $$BUILD_TARGET;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+install: all
+	@for DIR in $(ARM64_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+run_tests: all
+	@for DIR in $(ARM64_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+# Avoid any output on non arm64 on emit_tests
+emit_tests: all
+	@for DIR in $(ARM64_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+clean:
+	@for DIR in $(ARM64_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+.PHONY: all clean install run_tests emit_tests
diff --git a/tools/testing/selftests/arm64/README b/tools/testing/selftests/arm64/README
new file mode 100644
index 000000000000..a1badd882102
--- /dev/null
+++ b/tools/testing/selftests/arm64/README
@@ -0,0 +1,25 @@
+KSelfTest ARM64
+===============
+
+- These tests are arm64 specific and so not built or run but just skipped
+  completely when env-variable ARCH is found to be different than 'arm64'
+  and `uname -m` reports other than 'aarch64'.
+
+- Holding true the above, ARM64 KSFT tests can be run within the KSelfTest
+  framework using standard Linux top-level-makefile targets:
+
+      $ make TARGETS=arm64 kselftest-clean
+      $ make TARGETS=arm64 kselftest
+
+      or
+
+      $ make -C tools/testing/selftests TARGETS=arm64 \
+		INSTALL_PATH=<your-installation-path> install
+
+      or, alternatively, only specific arm64/ subtargets can be picked:
+
+      $ make -C tools/testing/selftests TARGETS=arm64 ARM64_SUBTARGETS="tags signal" \
+		INSTALL_PATH=<your-installation-path> install
+
+   Further details on building and running KFST can be found in:
+     Documentation/dev-tools/kselftest.rst
diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/tags/.gitignore
similarity index 100%
rename from tools/testing/selftests/arm64/.gitignore
rename to tools/testing/selftests/arm64/tags/.gitignore
diff --git a/tools/testing/selftests/arm64/tags/Makefile b/tools/testing/selftests/arm64/tags/Makefile
new file mode 100644
index 000000000000..41cb75070511
--- /dev/null
+++ b/tools/testing/selftests/arm64/tags/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I../../../../../usr/include/
+TEST_GEN_PROGS := tags_test
+TEST_PROGS := run_tags_test.sh
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/run_tags_test.sh b/tools/testing/selftests/arm64/tags/run_tags_test.sh
similarity index 100%
rename from tools/testing/selftests/arm64/run_tags_test.sh
rename to tools/testing/selftests/arm64/tags/run_tags_test.sh
diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
similarity index 100%
rename from tools/testing/selftests/arm64/tags_test.c
rename to tools/testing/selftests/arm64/tags/tags_test.c
-- 
2.17.1

