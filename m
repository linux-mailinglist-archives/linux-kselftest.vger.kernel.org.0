Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D140AA3C55
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfH3Qng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 12:43:36 -0400
Received: from foss.arm.com ([217.140.110.172]:34944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbfH3Qng (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 12:43:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC82360;
        Fri, 30 Aug 2019 09:43:35 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 528823F718;
        Fri, 30 Aug 2019 09:43:34 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com
Subject: [PATCH v4 01/11] kselftest: arm64: add skeleton Makefile
Date:   Fri, 30 Aug 2019 17:42:38 +0100
Message-Id: <20190830164248.16238-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830164248.16238-1-cristian.marussi@arm.com>
References: <20190830164248.16238-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new arm64-specific empty subsystem amongst TARGETS of KSFT build
framework; keep these new arm64 KSFT testcases separated into distinct
subdirs inside tools/testing/selftests/arm64/ depending on the specific
subsystem targeted.

Run the new KSFT TARGETS=arm64 related tests from the toplevel
KSFT Makefile in the usual ways.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3--->v4
- comment reword
- simplified documentation in README
- dropped README about standalone
---
 tools/testing/selftests/Makefile       |  1 +
 tools/testing/selftests/arm64/Makefile | 51 ++++++++++++++++++++++++++
 tools/testing/selftests/arm64/README   | 20 ++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100644 tools/testing/selftests/arm64/README

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 25b43a8c2b15..1722dae9381a 100644
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
new file mode 100644
index 000000000000..03a0d4f71218
--- /dev/null
+++ b/tools/testing/selftests/arm64/Makefile
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 ARM Limited
+
+# When ARCH not overridden for crosscompiling, lookup machine
+ARCH ?= $(shell uname -m)
+ARCH := $(shell echo $(ARCH) | sed -e s/aarch64/arm64/)
+
+ifeq ("x$(ARCH)", "xarm64")
+SUBDIRS :=
+else
+SUBDIRS :=
+endif
+
+CFLAGS := -Wall -O2 -g
+
+export CC
+export CFLAGS
+
+all:
+	@for DIR in $(SUBDIRS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		mkdir -p $$BUILD_TARGET;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+install: all
+	@for DIR in $(SUBDIRS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+run_tests: all
+	@for DIR in $(SUBDIRS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+# Avoid any output on non arm64 on emit_tests
+emit_tests: all
+	@for DIR in $(SUBDIRS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+clean:
+	@for DIR in $(SUBDIRS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+.PHONY: all clean install run_tests emit_tests
diff --git a/tools/testing/selftests/arm64/README b/tools/testing/selftests/arm64/README
new file mode 100644
index 000000000000..aca892e62a6c
--- /dev/null
+++ b/tools/testing/selftests/arm64/README
@@ -0,0 +1,20 @@
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
+   Further details on building and running KFST can be found in:
+     Documentation/dev-tools/kselftest.rst
-- 
2.17.1

