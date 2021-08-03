Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2B3DEFB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Aug 2021 16:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhHCOHP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 10:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236045AbhHCOHP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 10:07:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A033560F58;
        Tue,  3 Aug 2021 14:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627999624;
        bh=CdGB4OG/NflCYBfXLsaKyb4ZgSAIM7cHqA6soZ5TczM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZAhL0lhMdOqPuhfqFJHm3YdHK4fZBPYMZkj4rmwIKJ+izfLJMzu3AqRLy18x/UEQ
         /HA0wO4QkSIfqpYpHEQ6fa1kzDKCg/1s094CpHBX09ahOZjKBPvKGsLdvnsdYXAuEO
         ckxv+AHzXUdTjYBz/AOpWirtfR7xdqaJ/DJn06oBHWWNfvcNaxajt4Sd55P6N1baAv
         r4PptcjzYGswwXnxX/GqB45Z5e0q8bCICw2C9TM8AUhrvR143agcGSdBbFUQxsUeqw
         qZUo9jTQ+YWuOPvvMMAvUFf9IjbkBLkQKY7VFJzUlsP+A4wJCIu0ph4MzVBC/rIpYb
         mzyPhQkilS0jg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 1/4] kselftest/arm64: Provide a helper binary and "library" for SVE RDVL
Date:   Tue,  3 Aug 2021 15:04:47 +0100
Message-Id: <20210803140450.46624-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803140450.46624-1-broonie@kernel.org>
References: <20210803140450.46624-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3762; h=from:subject; bh=CdGB4OG/NflCYBfXLsaKyb4ZgSAIM7cHqA6soZ5TczM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhCUz+oc07YHrsOh1K2NDPohsDGoEt9Zt9fNhL16wI 3/ocqPOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQlM/gAKCRAk1otyXVSH0HsPB/ 9Rs0XhQPDNJzZfvm1QLSriYUIJODU/HJz4lREPzuB2LvrBJzf++WiUAzQA6BcKvdV7WZ1CygkCxLLD Gw+hejl1/TClEZQ7VOMg93o65dS1ftAJEwdUFvHBIC8ugMoYNGeF/dFFbDDP3Y2NzzVPWfy3WrgCN+ Ho9Y0RnjqvU8fnC6HpLL9spP3yvAHNCUghM+2kFWfaJy8u4bfGlVwq1BGF951HsCEiu8UOUbP85toV U5kD+0BcIE91nPAPt8KO524zn79bS0MO3K+NqKOweFnVv4yUuqJ2EnSXVo8sp2vfs1Ca+0uCpOIgan So5Xo3dmTIfVKZl2ccKvMv9UAmwHwm
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
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 tools/testing/selftests/arm64/fp/.gitignore |  1 +
 tools/testing/selftests/arm64/fp/Makefile   |  6 +++++-
 tools/testing/selftests/arm64/fp/rdvl-sve.c | 14 ++++++++++++++
 tools/testing/selftests/arm64/fp/rdvl.S     | 10 ++++++++++
 tools/testing/selftests/arm64/fp/rdvl.h     |  8 ++++++++
 5 files changed, 38 insertions(+), 1 deletion(-)
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
index 000000000000..c916c1c9defd
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/rdvl.S
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2021 ARM Limited.
+
+.arch_extension sve
+
+.globl rdvl_sve
+rdvl_sve:
+	hint	34			// BTI C
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

