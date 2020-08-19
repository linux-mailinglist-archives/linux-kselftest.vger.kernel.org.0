Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B5F249C95
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgHSLwC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 07:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgHSLvW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 07:51:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A1D214F1;
        Wed, 19 Aug 2020 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837861;
        bh=JfaYARU500KyGKl83cNvc8e0a1tMUPdoCs7RvTwU3C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJlNet8U2Z539OMojT0wBSiTaD4w762RZPtuu7Ob/av4IJ1M1R+WLsmwtIrNNhAgL
         vtIjQVNP7iQ7uz0UzsLSasMrQ8W+M/a1jnKym/jrCTUZ3WghbgSf8Ocv+rD/YosP0g
         h6v8yhEiVuGLDh3bGUUB6NJgyDUbJA8dRN2RCHfY=
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 6/6] selftests: arm64: Add build and documentation for FP tests
Date:   Wed, 19 Aug 2020 12:48:37 +0100
Message-Id: <20200819114837.51466-7-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819114837.51466-1-broonie@kernel.org>
References: <20200819114837.51466-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Integrate the FP tests with the build system and add some documentation
for the ones run outside the kselftest infrastructure.  The content in
the README was largely written by Dave Martin with edits by me.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/Makefile      |   2 +-
 tools/testing/selftests/arm64/fp/.gitignore |   5 +
 tools/testing/selftests/arm64/fp/Makefile   |  17 ++++
 tools/testing/selftests/arm64/fp/README     | 100 ++++++++++++++++++++
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/fp/.gitignore
 create mode 100644 tools/testing/selftests/arm64/fp/Makefile
 create mode 100644 tools/testing/selftests/arm64/fp/README

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 93b567d23c8b..a28d4e7c9948 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal
+ARM64_SUBTARGETS ?= tags signal fp
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
new file mode 100644
index 000000000000..d66f76d2a650
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -0,0 +1,5 @@
+fpsimd-test
+sve-probe-vls
+sve-ptrace
+sve-test
+vlset
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
new file mode 100644
index 000000000000..a57009d3a0dc
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I../../../../../usr/include/
+TEST_GEN_PROGS := sve-ptrace sve-probe-vls
+TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress sve-test sve-stress vlset
+
+all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
+
+fpsimd-test: fpsimd-test.o
+	$(CC) -nostdlib $^ -o $@
+sve-ptrace: sve-ptrace.o sve-ptrace-asm.o
+sve-probe-vls: sve-probe-vls.o
+sve-test: sve-test.o
+	$(CC) -nostdlib $^ -o $@
+vlset: vlset.o
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/fp/README b/tools/testing/selftests/arm64/fp/README
new file mode 100644
index 000000000000..03e3dad865d8
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/README
@@ -0,0 +1,100 @@
+This directory contains a mix of tests integrated with kselftest and
+standalone stress tests.
+
+kselftest tests
+===============
+
+sve-probe-vls - Checks the SVE vector length enumeration interface
+sve-ptrace - Checks the SVE ptrace interface
+
+Running the non-kselftest tests
+===============================
+
+sve-stress performs an SVE context switch stress test, as described
+below.
+
+(The fpsimd-stress test works the same way; just substitute "fpsimd" for
+"sve" in the following commands.)
+
+
+The test runs until killed by the user.
+
+If no context switch error was detected, you will see output such as
+the following:
+
+$ ./sve-stress
+(wait for some time)
+^C
+Vector length:        512 bits
+PID:    1573
+Terminated by signal 15, no error, iterations=9467, signals=1014
+Vector length:  512 bits
+PID:    1575
+Terminated by signal 15, no error, iterations=9448, signals=1028
+Vector length:  512 bits
+PID:    1577
+Terminated by signal 15, no error, iterations=9436, signals=1039
+Vector length:  512 bits
+PID:    1579
+Terminated by signal 15, no error, iterations=9421, signals=1039
+Vector length:  512 bits
+PID:    1581
+Terminated by signal 15, no error, iterations=9403, signals=1039
+Vector length:  512 bits
+PID:    1583
+Terminated by signal 15, no error, iterations=9385, signals=1036
+Vector length:  512 bits
+PID:    1585
+Terminated by signal 15, no error, iterations=9376, signals=1039
+Vector length:  512 bits
+PID:    1587
+Terminated by signal 15, no error, iterations=9361, signals=1039
+Vector length:  512 bits
+PID:    1589
+Terminated by signal 15, no error, iterations=9350, signals=1039
+
+
+If an error was detected, details of the mismatch will be printed
+instead of "no error".
+
+Ideally, the test should be allowed to run for many minutes or hours
+to maximise test coverage.
+
+
+KVM stress testing
+==================
+
+To try to reproduce the bugs that we have been observing, sve-stress
+should be run in parallel in two KVM guests, while simultaneously
+running on the host.
+
+1) Start 2 guests, using the following command for each:
+
+$ lkvm run --console=virtio -pconsole=hvc0 --sve Image
+
+(Depending on the hardware GIC implementation, you may also need
+--irqchip=gicv3.  New kvmtool defaults to that if appropriate, but I
+can't remember whether my branch is new enough for that.  Try without
+the option first.)
+
+Kvmtool occupies the terminal until you kill it (Ctrl+A x),
+or until the guest terminates.  It is therefore recommended to run
+each instance in separate terminal (use screen or ssh etc.)  This
+allows multiple guests to be run in parallel while running other
+commands on the host.
+
+Within the guest, the host filesystem is accessible, mounted on /host.
+
+2) Run the sve-stress on *each* guest with the Vector-Length set to 32:
+guest$ ./vlset --inherit 32 ./sve-stress
+
+3) Run the sve-stress on the host with the maximum Vector-Length:
+host$ ./vlset --inherit --max ./sve-stress
+
+
+Again, the test should be allowed to run for many minutes or hours to
+maximise test coverage.
+
+If no error is detected, you will see output from each sve-stress
+instance similar to that illustrated above; otherwise details of the
+observed mismatches will be printed.
-- 
2.20.1

