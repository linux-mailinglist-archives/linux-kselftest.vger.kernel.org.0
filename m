Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C052C432750
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJRTN6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232759AbhJRTN6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:13:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17BC061351;
        Mon, 18 Oct 2021 19:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584306;
        bh=k6BvUGirM52x/foWi+puL13E7HidvCnYPfduWhzwbRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2gAXwyjQTUqIMxTMr6pgjsNVPQbu5OLdvty975KbZXtMg3EsipiGbZWPiOIapKmh
         imi+gnBNG8MYHg1XWNKUbuAvhoRagHC6ev14BV8guiJhA2yMkG/Kq8sNBqA1FWbRWY
         7OS/hLJ+72sHp/s1dB2h+nbWDYU4A1OC5oWi+n2Esk4xGvXlRnJW3Hd9VXDd04Qplj
         HVWYHgyM89yL4p6Tun6zOkv18msnIKFFewKs2c9VTlmlZMbyjccHD7PMjmZtTzDWOp
         ac7fjfUAz3lwozG1jTFbUaKgszy3G86l4vaUY91fQ33TJqEsSikAQKGsA/GZXoBxM8
         tgUGHevBRsExg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 37/42] kselftest/arm64: Extend vector configuration API tests to cover SME
Date:   Mon, 18 Oct 2021 20:08:53 +0100
Message-Id: <20211018190858.2119209-38-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3767; h=from:subject; bh=k6BvUGirM52x/foWi+puL13E7HidvCnYPfduWhzwbRc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcZEovcbhRdebnPOVngLtSAWvTo0sAmlDi97Pno4 ps1ONa+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GRAAKCRAk1otyXVSH0PclB/ 9Jr426NH8KtEiJMuc/W17ELC1SwhvQefJ3KPwXjwG4CuvyLyZ9aWCYo29DzhANI+hUIkYyhhuKVuHd MPEZ+ISO4OVaV7U0eMrXzpaxITwaA6Up79HhMPPdXFlpZwTCGSlVxD4qOyKEixmLLB9qFLyr8MynFm snxPwyisIKEEgxxIhwWvCVYD4oMXWvmoG0x73Ut5RqwM9m8WtPte0JxFaGH82880TlXYDzKbZWLvmY dAWz20TFeSYddSbXCcgMwBiuNqfE68d//mlb+O15ZnCcKpZxlmpvXwbtrCaEXebV7H9L3QP33lkyjh 4fCzaL+l2lJbEV+k2V8Y2qzk86PxWg
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Provide RDVL helpers for SME and extend the main vector configuration tests
to cover SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/.gitignore   |  1 +
 tools/testing/selftests/arm64/fp/Makefile     |  3 ++-
 tools/testing/selftests/arm64/fp/rdvl-sme.c   | 14 ++++++++++++++
 tools/testing/selftests/arm64/fp/rdvl.S       | 16 ++++++++++++++++
 tools/testing/selftests/arm64/fp/rdvl.h       |  1 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 10 ++++++++++
 6 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sme.c

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index b67395903b9b..885dd592807b 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -1,4 +1,5 @@
 fpsimd-test
+rdvl-sme
 rdvl-sve
 sve-probe-vls
 sve-ptrace
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 4367125b7c27..ff1c8fde3aed 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -3,7 +3,7 @@
 CFLAGS += -I../../../../../usr/include/
 TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
 TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress \
-	rdvl-sve \
+	rdvl-sme rdvl-sve \
 	sve-test sve-stress \
 	vlset
 
@@ -11,6 +11,7 @@ all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
 
 fpsimd-test: fpsimd-test.o
 	$(CC) -nostdlib $^ -o $@
+rdvl-sme: rdvl-sme.o rdvl.o
 rdvl-sve: rdvl-sve.o rdvl.o
 sve-ptrace: sve-ptrace.o
 sve-probe-vls: sve-probe-vls.o rdvl.o
diff --git a/tools/testing/selftests/arm64/fp/rdvl-sme.c b/tools/testing/selftests/arm64/fp/rdvl-sme.c
new file mode 100644
index 000000000000..49b0b2e08bac
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/rdvl-sme.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdio.h>
+
+#include "rdvl.h"
+
+int main(void)
+{
+	int vl = rdvl_sme();
+
+	printf("%d\n", vl);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/arm64/fp/rdvl.S b/tools/testing/selftests/arm64/fp/rdvl.S
index c916c1c9defd..a9a028ba1b79 100644
--- a/tools/testing/selftests/arm64/fp/rdvl.S
+++ b/tools/testing/selftests/arm64/fp/rdvl.S
@@ -8,3 +8,19 @@ rdvl_sve:
 	hint	34			// BTI C
 	rdvl	x0, #1
 	ret
+
+.globl rdvl_sme
+rdvl_sme:
+	hint	34			// BTI C
+
+	// Enter streaming mode
+	mov	x16, #1
+	msr	S3_3_C4_C2_2, x16
+
+	rdvl	x0, #1
+
+	// Leave streaming mode
+	mov	x16, #0
+	msr	S3_3_C4_C2_2, x16
+
+	ret
diff --git a/tools/testing/selftests/arm64/fp/rdvl.h b/tools/testing/selftests/arm64/fp/rdvl.h
index 7c9d953fc9e7..5d323679fbc9 100644
--- a/tools/testing/selftests/arm64/fp/rdvl.h
+++ b/tools/testing/selftests/arm64/fp/rdvl.h
@@ -3,6 +3,7 @@
 #ifndef RDVL_H
 #define RDVL_H
 
+int rdvl_sme(void);
 int rdvl_sve(void);
 
 #endif
diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index 272b888e018e..0b976eb1c1d1 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -53,6 +53,16 @@ static struct vec_data vec_data[] = {
 		.prctl_set = PR_SVE_SET_VL,
 		.default_vl_file = "/proc/sys/abi/sve_default_vector_length",
 	},
+	{
+		.name = "SME",
+		.hwcap_type = AT_HWCAP2,
+		.hwcap = HWCAP2_SME,
+		.rdvl = rdvl_sme,
+		.rdvl_binary = "./rdvl-sme",
+		.prctl_get = PR_SME_GET_VL,
+		.prctl_set = PR_SME_SET_VL,
+		.default_vl_file = "/proc/sys/abi/sme_default_vector_length",
+	},
 };
 
 static int stdio_read_integer(FILE *f, const char *what, int *val)
-- 
2.30.2

