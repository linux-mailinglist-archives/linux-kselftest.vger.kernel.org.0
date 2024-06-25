Return-Path: <linux-kselftest+bounces-12644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C79167CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8F51C250C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 12:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2F15F31D;
	Tue, 25 Jun 2024 12:25:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018E715B562;
	Tue, 25 Jun 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318322; cv=none; b=HGmQ0Hkw+MaBbUFz3l2uhRzAGQyk9PmbKU2LI9ofnPbt36IvCkcaWzHpwVxL59cGStkVYnWYwuT6U5KlwoqyqrAk458mwAkDNsylRBKGwY4auEj374H5u+I+KeIhpwXeqcKvvgedovVO1/S5jgEnyKBqb+JQRXN/+d5leYd8k3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318322; c=relaxed/simple;
	bh=Pm58IP1DolRyMTmvoQUmXN2JDiAxDZ2mg7rtbhnilnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSPMsXRortXNShd58fImVtl4k54eeh9xt92fZhBoJ5J0PLc8Au4yaAXHLAj9OHSP/RubMvEm1k+lkg+gCBNaThAFSEOregsNHnYvB3hRMvyd7fMQXoK4bBrpvz3NuX/CeK76qqpExRiu1AOgQpCDwGu15q011G4WokV06xL3bdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85D00339;
	Tue, 25 Jun 2024 05:25:45 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27F0C3F766;
	Tue, 25 Jun 2024 05:25:15 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin.Marinas@arm.com,
	will@kernel.org
Cc: broonie@kernel.org,
	ryan.roberts@arm.com,
	rob.herring@arm.com,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 9/9] selftests: Add build infrastructure along with README
Date: Tue, 25 Jun 2024 17:54:08 +0530
Message-Id: <20240625122408.1439097-10-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625122408.1439097-1-dev.jain@arm.com>
References: <20240625122408.1439097-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add arm target, individual Makefile targets, and instructions to build the
tests, along with .gitignore files. All the Makefiles are similar to
selftests/arm64, except abi: use TEST_CUSTOM_PROGS to override the make
rule from lib.mk. Also, do not build ptrace_64 if we are running a
32-bit kernel.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
v2->v3:
 - Add abi Makefile and .gitignore
 - Remove config file

v1->v2:
 - Add config file

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/arm/Makefile          | 56 +++++++++++++++++++
 tools/testing/selftests/arm/README            | 32 +++++++++++
 tools/testing/selftests/arm/abi/.gitignore    |  4 ++
 tools/testing/selftests/arm/abi/Makefile      | 26 +++++++++
 tools/testing/selftests/arm/elf/.gitignore    |  2 +
 tools/testing/selftests/arm/elf/Makefile      |  6 ++
 tools/testing/selftests/arm/mm/.gitignore     |  2 +
 tools/testing/selftests/arm/mm/Makefile       |  6 ++
 tools/testing/selftests/arm/signal/.gitignore |  3 +
 tools/testing/selftests/arm/signal/Makefile   | 30 ++++++++++
 11 files changed, 168 insertions(+)
 create mode 100644 tools/testing/selftests/arm/Makefile
 create mode 100644 tools/testing/selftests/arm/README
 create mode 100644 tools/testing/selftests/arm/abi/.gitignore
 create mode 100644 tools/testing/selftests/arm/abi/Makefile
 create mode 100644 tools/testing/selftests/arm/elf/.gitignore
 create mode 100644 tools/testing/selftests/arm/elf/Makefile
 create mode 100644 tools/testing/selftests/arm/mm/.gitignore
 create mode 100644 tools/testing/selftests/arm/mm/Makefile
 create mode 100644 tools/testing/selftests/arm/signal/.gitignore
 create mode 100644 tools/testing/selftests/arm/signal/Makefile

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9039f3709aff..d7420825f165 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 TARGETS += alsa
 TARGETS += amd-pstate
+TARGETS += arm
 TARGETS += arm64
 TARGETS += bpf
 TARGETS += breakpoints
diff --git a/tools/testing/selftests/arm/Makefile b/tools/testing/selftests/arm/Makefile
new file mode 100644
index 000000000000..54e44c4a62bf
--- /dev/null
+++ b/tools/testing/selftests/arm/Makefile
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
+ifneq (,$(filter $(ARCH),aarch64 arm64 arm armv7l armv8l))
+ARM_SUBTARGETS ?= abi elf mm signal
+else
+ARM_SUBTARGETS :=
+endif
+
+CFLAGS := -Wall -O2 -g -static
+
+# A proper top_srcdir is needed by KSFT(lib.mk)
+top_srcdir = $(realpath ../../../../)
+
+# Additional include paths needed by kselftest.h and local headers
+CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
+
+CFLAGS += -I$(top_srcdir)/tools/include
+
+export CFLAGS
+export top_srcdir
+
+all:
+	@for DIR in $(ARM_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		mkdir -p $$BUILD_TARGET;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+install: all
+	@for DIR in $(ARM_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+run_tests: all
+	@for DIR in $(ARM_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+# Avoid any output on non arm on emit_tests
+emit_tests:
+	@for DIR in $(ARM_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+clean:
+	@for DIR in $(ARM_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+.PHONY: all clean install run_tests emit_tests
diff --git a/tools/testing/selftests/arm/README b/tools/testing/selftests/arm/README
new file mode 100644
index 000000000000..75b7cf4baec3
--- /dev/null
+++ b/tools/testing/selftests/arm/README
@@ -0,0 +1,32 @@
+KSelfTest ARM
+===============
+
+- This is a series of compatibility tests, wherein the source files are
+  built statically into a 32 bit ELF; they should pass on both 32 and 64
+  bit kernels. They are not built or run but just skipped completely when
+  env-variable ARCH is found to be different than 'arm64' or 'arm' and
+  `uname -m` reports other than 'aarch64', 'armv7l' or 'armv8l'.
+
+- If building the tests on a 64-bit kernel, please ensure that the kernel is
+  built with CONFIG_COMPAT enabled.
+
+- Holding true the above, ARM KSFT tests can be run within the KSelfTest
+  framework using standard Linux top-level-makefile targets. Please set
+  $(CROSS_COMPILE) to 'arm-linux-gnueabi-' or 'arm-linux-gnueabihf-'.
+
+      $ make TARGETS=arm kselftest-clean
+      $ make $(CROSS_COMPILE) TARGETS=arm kselftest
+
+      or
+
+      $ make $(CROSS_COMPILE) -C tools/testing/selftests TARGETS=arm \
+		INSTALL_PATH=<your-installation-path> install
+
+      or, alternatively, only specific arm/ subtargets can be picked:
+
+      $ make $(CROSS_COMPILE) -C tools/testing/selftests TARGETS=arm \
+		ARM_SUBTARGETS="signal" INSTALL_PATH=<your-installation-path> \
+			install
+
+   Further details on building and running KFST can be found in:
+     Documentation/dev-tools/kselftest.rst
diff --git a/tools/testing/selftests/arm/abi/.gitignore b/tools/testing/selftests/arm/abi/.gitignore
new file mode 100644
index 000000000000..75af3c416fc3
--- /dev/null
+++ b/tools/testing/selftests/arm/abi/.gitignore
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+ptrace
+ptrace_64
+trivial_32bit_program
diff --git a/tools/testing/selftests/arm/abi/Makefile b/tools/testing/selftests/arm/abi/Makefile
new file mode 100644
index 000000000000..160b6aadb064
--- /dev/null
+++ b/tools/testing/selftests/arm/abi/Makefile
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2024 ARM Limited
+
+TEST_GEN_PROGS := ptrace
+
+include ../../lib.mk
+
+# Do not build 64-bit programs if running on a native 32-bit kernel
+UNAME_M := $(shell uname -m)
+ifneq (,$(filter $(UNAME_M),aarch64 arm64))
+TEST_CUSTOM_PROGS := $(OUTPUT)/ptrace_64
+
+TRIVIAL_32BIT := $(OUTPUT)/trivial_32bit_program
+
+all: $(TEST_CUSTOM_PROGS) $(TRIVIAL_32BIT)
+
+
+$(TRIVIAL_32BIT): $(OUTPUT)/%: %.c
+	$(CC) -o $@ $^ -static
+
+$(OUTPUT)/ptrace_64: ptrace_64.c ptrace.h
+	gcc -o $@ $^
+
+EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(TRIVIAL_32BIT)
+endif
+
diff --git a/tools/testing/selftests/arm/elf/.gitignore b/tools/testing/selftests/arm/elf/.gitignore
new file mode 100644
index 000000000000..41458ecbcd72
--- /dev/null
+++ b/tools/testing/selftests/arm/elf/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+parse_elf
diff --git a/tools/testing/selftests/arm/elf/Makefile b/tools/testing/selftests/arm/elf/Makefile
new file mode 100644
index 000000000000..86636fe02994
--- /dev/null
+++ b/tools/testing/selftests/arm/elf/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 ARM Limited
+
+TEST_GEN_PROGS := parse_elf
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/arm/mm/.gitignore b/tools/testing/selftests/arm/mm/.gitignore
new file mode 100644
index 000000000000..eb28169bb1b5
--- /dev/null
+++ b/tools/testing/selftests/arm/mm/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+compat_va
diff --git a/tools/testing/selftests/arm/mm/Makefile b/tools/testing/selftests/arm/mm/Makefile
new file mode 100644
index 000000000000..d8bfa45df98c
--- /dev/null
+++ b/tools/testing/selftests/arm/mm/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 ARM Limited
+
+TEST_GEN_PROGS := compat_va
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/arm/signal/.gitignore b/tools/testing/selftests/arm/signal/.gitignore
new file mode 100644
index 000000000000..85b81356bf41
--- /dev/null
+++ b/tools/testing/selftests/arm/signal/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+mangle_cpsr_invalid_aif_bits
+mangle_cpsr_invalid_compat_toggle
diff --git a/tools/testing/selftests/arm/signal/Makefile b/tools/testing/selftests/arm/signal/Makefile
new file mode 100644
index 000000000000..3540a25de75a
--- /dev/null
+++ b/tools/testing/selftests/arm/signal/Makefile
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 ARM Limited
+
+# Additional include paths needed by kselftest.h and local headers
+CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+
+SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
+PROGS := $(patsubst %.c,%,$(SRCS))
+
+# Generated binaries to be installed by top KSFT script
+TEST_GEN_PROGS := $(notdir $(PROGS))
+
+# Get Kernel headers installed and use them.
+
+# Including KSFT lib.mk here will also mangle the TEST_GEN_PROGS list
+# to account for any OUTPUT target-dirs optionally provided by
+# the toplevel makefile
+include ../../lib.mk
+
+$(TEST_GEN_PROGS): $(PROGS)
+	cp $(PROGS) $(OUTPUT)/
+
+# Common test-unit targets to build common-layout test-cases executables
+# Needs secondary expansion to properly include the testcase c-file in pre-reqs
+COMMON_SOURCES := test_signals.c test_signals_utils.c
+COMMON_HEADERS := test_signals.h test_signals_utils.h
+
+.SECONDEXPANSION:
+$(PROGS): $$@.c ${COMMON_SOURCES} ${COMMON_HEADERS}
+	$(CC) $(CFLAGS) ${@}.c ${COMMON_SOURCES} -o $@
-- 
2.39.2


