Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EBD3D9346
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhG1QeM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 12:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhG1QeL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 12:34:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A58961019;
        Wed, 28 Jul 2021 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627490049;
        bh=RCUI82H/4W6FmihK1AkpRMF/AXitVCXzKcuEuGl6Cws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AOQUiF1JWUO7NK2AQzN8gpwtfYmLeeMCV6WdOhKq7W7UZaJi2REKrbA/Inwrqv6ut
         AV9bQQEGnQuLt8fTUkcLrJl0nyg2XzxsFb19b/oidNbmQLWnCT0d9H16DW97oDuJ09
         rb3wbC00pK/XbpLx+crSh2e8TVmKqwLmRlApu6ZKMRlkjLugsmiJ5Oq5/sAjfcWUZJ
         QxSPU75Ki2Rgf5yiPevoNhA6HcCkCgdek62ElHTnPB8NJhKMF+V2pTa7JQsSrQ6HPq
         vr8zITlM8mp2UafT77IiPEaqko4LqtH3W2HibdoD0bnp38fP5hMEa7diHN71lisdRv
         /vH6Uzcb4z22g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/4] kselftest/arm64: Provide a helper binary and "library" for SVE RDVL
Date:   Wed, 28 Jul 2021 17:33:15 +0100
Message-Id: <20210728163318.51492-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728163318.51492-1-broonie@kernel.org>
References: <20210728163318.51492-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3690; h=from:subject; bh=RCUI82H/4W6FmihK1AkpRMF/AXitVCXzKcuEuGl6Cws=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAYbJMq3zDnqSnFUJ1lvpDawfFS3yduzdzxjq60HD 0JBiBAOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQGGyQAKCRAk1otyXVSH0GFMB/ 4kheASFmEw33ww3jo6pF7GQdVH6TLvOo+Ji9hhnfkHt0LS5GM6jXGTNtXj0jtbfqnGGCtU01omJnTo t0cGvNAL6lBAhgPv/iOUzW4w1EfmAsJHfnEHyjAfgxZhW2mKXHYlF1USx+Svo6of0OaM5nSAB2HhvG ruDd9jTaGkaNxSwyhKPRG/8q0w1D3npORzW0YWJMP2PDzMsPddF6yVN1xCs1Xnr78tSUhR8nlfQ4xm G9g8R+klEfivWN7aqZtgc5GhOh8P1fMla0ixppl0BDhqgeXNPwJTmJ3YS6daH3fcKFM2OXIAL6KgSd n/L9Hu8P1VExqkPJDJWyIPBlrQ09m+
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

