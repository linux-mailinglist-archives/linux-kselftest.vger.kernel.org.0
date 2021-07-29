Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F33DAA63
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 19:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhG2Rhc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 13:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhG2Rhb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 13:37:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7870460F46;
        Thu, 29 Jul 2021 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627580248;
        bh=CdGB4OG/NflCYBfXLsaKyb4ZgSAIM7cHqA6soZ5TczM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HECYJbEvLqRrnEgcWlTjesPjKXNC4PrUgjDuJEAdVBrxynwR+POSkw6I9ld0Hb2Ay
         JyK7ORlhe837TmBpLR8YAs7Vg8Xl66m22RQQpdTH+BOQteFYillAaC4Fgxr1JdYhy8
         O7hwTGrrlrfTYUEpUISTfGVkobniYZkFss21hQQpOBZxkTdisBTB/ToBM6tiXxsxBd
         H2SBhFddgnlABzTkpZP3sGPkA2NkCmzIC+3JD3koBfrtiIqn8hsdv4pubIP3Viu9Om
         J19zHZkdI3UUwNROJjh9et7A3u9CNXYgM0dwI93NiJ/CBMkeHE2f6f3hcQhPWSR46e
         7g4JsKufTJvgA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 1/4] kselftest/arm64: Provide a helper binary and "library" for SVE RDVL
Date:   Thu, 29 Jul 2021 18:37:10 +0100
Message-Id: <20210729173713.4534-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729173713.4534-1-broonie@kernel.org>
References: <20210729173713.4534-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3762; h=from:subject; bh=CdGB4OG/NflCYBfXLsaKyb4ZgSAIM7cHqA6soZ5TczM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAudFoc07YHrsOh1K2NDPohsDGoEt9Zt9fNhL16wI 3/ocqPOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQLnRQAKCRAk1otyXVSH0IjWB/ 4wPgAJAF3S5e5AUtVyklYBjA95dzxcSXrxIIS/AZPB3iMi/HuoHGlZnOIkesYJttFN0gJTsLXXScIJ xRXz7qzLsGMOH70ct8M1iCKjGA0udtjNQdsKqoV8V3xzlSRNTWOsYD1VH9jQ3/u/Iy/qFJSNzT963c WgeX8hEDK3jlZjX21tiMn4iaGZPPrOolB0ea3t6qRSlmlZfyKcwtFNdzxuYQIZaqsTBrP3EEFM34Q7 nWaxXnJVIJCEc1KUPzNjf6ov83lABYNL/P7dWxosbGogUhhitB461GKCY6XfLhfyn9VTJaGstF8+os j53qK5cHZzqh3NCkv/QS6ueAYMJHNy
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

