Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97A83D7D32
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhG0SM0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 14:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhG0SM0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 14:12:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 716CE60F8F;
        Tue, 27 Jul 2021 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627409546;
        bh=RCUI82H/4W6FmihK1AkpRMF/AXitVCXzKcuEuGl6Cws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfYrpzOFiclHXLc3NqAlAi8Tdy1qoaX7rF31MBTBvrdkj85EaPkrjgkECV8hYM6Xb
         fl2aN5G5U07MkK4XFeZbCK35uVcnacBpk7SYtCc4jL/0NNGZMPCNAh7VvUzRwsr96R
         En3cV0EkkGt+NFh4Ib4j+c9HO99q7kvWewwQaC8KCFf2y6AbB2/mva9Q05hdSy/xLY
         YW4C6jWKL0YXzw5H8mGBO/I1rttvqWQIie6s5EHYFumEjFLLWuxRha6vo4bpQZo4zg
         a1yD/kcWcW/D5UtMgUL3cTy+DQrwa6pVOILXYc95uM2R/lhwDMguWrFn/fEyuHfEWf
         UFxzb3u8rKAwg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/3] kselftest/arm64: Provide a helper binary and "library" for SVE RDVL
Date:   Tue, 27 Jul 2021 19:06:47 +0100
Message-Id: <20210727180649.12943-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727180649.12943-1-broonie@kernel.org>
References: <20210727180649.12943-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3690; h=from:subject; bh=RCUI82H/4W6FmihK1AkpRMF/AXitVCXzKcuEuGl6Cws=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAEs2Mq3zDnqSnFUJ1lvpDawfFS3yduzdzxjq60HD 0JBiBAOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQBLNgAKCRAk1otyXVSH0AFrB/ 0QCP3wT2npf1UclpRSCIYsykb431h/S27r0l1MJksGNS2ZweG+jA3q84D0POpHmjvWGVeSErJ8GDEn DJdxiO6of7P+aRLxFKSGUA/ZatOi2vhRUkXjHpjJNsI6NIqpiMpa51zw5QkpkqDwZO+3i0zN2gRuDy Y5UG9kx9Fl42R9TJ4jpzblZLiSbAtLaAm9ERFsGLbNAfmzXn/T0SVdTFbFPs+tVa0ilxguNJdyf+Vu 6HC26YU6LSJAtP18Xf8afCQtWl5Sv1n+tX2cd9Eba5EqXjmaTvSHRua5n/V2imZIucNYb2w5ilnqtd 3k9kOpHC6cCrBBDjm+ovr4UYp2C8gS
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SVE provides an instruction RDVL which reports the currently configured
vector length. In order to validate that our vector length configuration
interfaces are working correctly without having to build the C code for
our test programs with SVE enabled provide a trivial assembly library
with a C callable function that executes RDVL. Since these interfaces
also control behaviour on exec*() provide a trivial wrapper program which
reports the currently configured vector length on stdout, tests can use
this to verify that behaviour on exec*() is as expected.

In preparation for providing similar helper functionality for SME, the
Scalable Matrix Extension, which allows separately configured vector
lengths to be read back both the assembler function and wrapper binary
have SVE included in their name.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/.gitignore |  1 +
 tools/testing/selftests/arm64/fp/Makefile   |  6 +++++-
 tools/testing/selftests/arm64/fp/rdvl-sve.c | 14 ++++++++++++++
 tools/testing/selftests/arm64/fp/rdvl.S     |  9 +++++++++
 tools/testing/selftests/arm64/fp/rdvl.h     |  8 ++++++++
 5 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sve.c
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl.S
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl.h

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index d66f76d2a650..6b53a7b60fee 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -1,4 +1,5 @@
 fpsimd-test
+rdvl-sve
 sve-probe-vls
 sve-ptrace
 sve-test
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index a57009d3a0dc..ed62e7003b96 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -2,12 +2,16 @@
 
 CFLAGS += -I../../../../../usr/include/
 TEST_GEN_PROGS := sve-ptrace sve-probe-vls
-TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress sve-test sve-stress vlset
+TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress \
+	rdvl-sve \
+	sve-test sve-stress \
+	vlset
 
 all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
 
 fpsimd-test: fpsimd-test.o
 	$(CC) -nostdlib $^ -o $@
+rdvl-sve: rdvl-sve.o rdvl.o
 sve-ptrace: sve-ptrace.o sve-ptrace-asm.o
 sve-probe-vls: sve-probe-vls.o
 sve-test: sve-test.o
diff --git a/tools/testing/selftests/arm64/fp/rdvl-sve.c b/tools/testing/selftests/arm64/fp/rdvl-sve.c
new file mode 100644
index 000000000000..7f8a13a18f5d
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/rdvl-sve.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdio.h>
+
+#include "rdvl.h"
+
+int main(void)
+{
+	int vl = rdvl_sve();
+
+	printf("%d\n", vl);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/arm64/fp/rdvl.S b/tools/testing/selftests/arm64/fp/rdvl.S
new file mode 100644
index 000000000000..6e76dd720b87
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/rdvl.S
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2021 ARM Limited.
+
+.arch_extension sve
+
+.globl rdvl_sve
+rdvl_sve:
+	rdvl	x0, #1
+	ret
diff --git a/tools/testing/selftests/arm64/fp/rdvl.h b/tools/testing/selftests/arm64/fp/rdvl.h
new file mode 100644
index 000000000000..7c9d953fc9e7
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/rdvl.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef RDVL_H
+#define RDVL_H
+
+int rdvl_sve(void);
+
+#endif
-- 
2.20.1

