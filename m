Return-Path: <linux-kselftest+bounces-7258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887D789987A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4BC1C20AB1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BBF15FD0A;
	Fri,  5 Apr 2024 08:50:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEE215FCE5;
	Fri,  5 Apr 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307009; cv=none; b=KbonToAGYINBXgzLBEKl6rG5hzFiMUVXHf/UNXpddiBhrBwoL1WxQBDOc9TGidwxY90J6BWgyQ0XJQFCMmWFGBQXpCnGVD6doGWuXMxvrsGFcOyPjzj1qiNqpb7J5AAL2cnL0OUsonix5sDMWK29Dn5KeLEQFaiXDWH/sp9o9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307009; c=relaxed/simple;
	bh=9XmSaTIPqe9Pt3FDDTmsRHsZ/7wIjsNeFBiZvnO0NS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejfReHN5dsx0wgCKAyMMWaQiJhQhyvEnz0tgGfBfBwnrwerIQ7qzoh5x7iHYN+xelMOnrNyEnEYslczwxR1nfKyYdAwlxniSHVQ/AvST4rdLBj8QjzFDyNzqH1daOLvo4MtBOm3Vrq70C1twtLIeGp8gCb4qQW2ksadpWfPn8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B34F5FEC;
	Fri,  5 Apr 2024 01:50:36 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB4553F64C;
	Fri,  5 Apr 2024 01:50:01 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	suzuki.poulose@arm.com,
	ryan.roberts@arm.com,
	rob.herring@arm.com,
	Catalin.Marinas@arm.com,
	broonie@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 4/4] selftests: Add build infrastructure along with README
Date: Fri,  5 Apr 2024 14:14:10 +0530
Message-Id: <20240405084410.256788-5-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405084410.256788-1-dev.jain@arm.com>
References: <20240405084410.256788-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add arm target, individual Makefile targets, and instructions to build the
tests.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/Makefile            |  1 +
 tools/testing/selftests/arm/Makefile        | 57 +++++++++++++++++++++
 tools/testing/selftests/arm/README          | 31 +++++++++++
 tools/testing/selftests/arm/elf/Makefile    |  6 +++
 tools/testing/selftests/arm/mm/Makefile     |  6 +++
 tools/testing/selftests/arm/signal/Makefile | 30 +++++++++++
 6 files changed, 131 insertions(+)
 create mode 100644 tools/testing/selftests/arm/Makefile
 create mode 100644 tools/testing/selftests/arm/README
 create mode 100644 tools/testing/selftests/arm/elf/Makefile
 create mode 100644 tools/testing/selftests/arm/mm/Makefile
 create mode 100644 tools/testing/selftests/arm/signal/Makefile

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 15b6a111c3be..8478d94cda4c 100644
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
index 000000000000..039224bc006e
--- /dev/null
+++ b/tools/testing/selftests/arm/Makefile
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# When ARCH not overridden for crosscompiling, lookup machine
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
+ifneq (,$(filter $(ARCH),aarch64 arm64 arm armv7l armv8l))
+ARM_SUBTARGETS ?= mm signal elf
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
index 000000000000..1a05c043d7ee
--- /dev/null
+++ b/tools/testing/selftests/arm/README
@@ -0,0 +1,31 @@
+KSelfTest ARM
+===============
+
+- This is a series of compatibility tests, wherein the source files are
+  built statically into a 32 bit ELF; they should pass on both 32 and 64
+  bit kernels. They are not built or run but just skipped completely when
+  env-variable ARCH is found to be different than 'arm64' or 'arm' and
+  `uname -m` reports other than 'aarch64', 'armv7l' or 'armv8l'.
+
+- Please ensure that the test kernel is built with CONFIG_COMPAT enabled.
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


