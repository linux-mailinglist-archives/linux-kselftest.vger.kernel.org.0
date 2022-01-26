Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA3B49CE75
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbiAZPcY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:32:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51512 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbiAZPcX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:32:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9758D618E2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BE0C340E9;
        Wed, 26 Jan 2022 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211143;
        bh=3il89y80lqKSeBlP8c8K13FChN+0Rfp1qjkKOqCKgPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0VDcd2LXh9I7ONbFZiinsosF+IHw+ygjG5bM29ymGzfqURhZkN9S8gVTLaVRfe9P
         IOdIj6DH6q4tlTo4mYFM3oz+k6BbyYqRl0c6LZAqiV8/+ZA/qcvznrXxzLGfbi/l42
         MX0uW1jGWbButC7+sXn0ALgO6nlTX7sgNzwGhJDgF4gAoGiliKuXhl4PJqHGvjnITz
         jhPhzilxzHDAIu+4h4YbC4UDqPZpsogzrT75a4D7RSujZ4NLXDLzvZ21NTbyaDcgpx
         /Btdl3WMOjguy8e2C4+AhFIj1u2g+/n0tbTEQ4Y2CLMyTsam3rteDaA3T2ABHZQ3vY
         lo8tnJkrBS5KA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v10 31/39] kselftest/arm64: Extend vector configuration API tests to cover SME
Date:   Wed, 26 Jan 2022 15:27:41 +0000
Message-Id: <20220126152749.233712-32-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3696; h=from:subject; bh=3il89y80lqKSeBlP8c8K13FChN+0Rfp1qjkKOqCKgPI=; b=owGbwMvMwMWocq27KDak/QLjabUkhsSPGbnm7YHvWwy+bD4wdVubLDN38qUJ8U90fGrV414pJQXt 1DzYyWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBMpGQD+/+s9F+WIedWstw+IGe/v7 ZF492FKIlXuidYdaSV/Iq6vdhn8QZsPyGk9kV5Ver7Pz5XnNakSm5w0VYvitxneMFlb7rts8P2y/a7 TGhhsJkuWHUjJftJTZKB9bc3jjKWIYs9ayfbuBsq2u6LP8TSKZ3Z/bOZ80b00qPTZF7VXMxXr9sQ/m exuvaett/7vPs0I/lqXhwJ4jv0aHeMmKruvKdvBc8xmPwKsPz14oWuV5ZUCKP7Y+s9y0TaOps9xMRZ lVZ/asgPPt6eXLK5epHbcoO3RutMLv+eyuwQledsrttlfFl5ynYR6/Np3LMsLnkoPLgZ5Hj+4MWj7b k3T568K+r6Z5HU1hLlOK9kkUhmAA==
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
 tools/testing/selftests/arm64/fp/rdvl.S       |  8 ++++++++
 tools/testing/selftests/arm64/fp/rdvl.h       |  1 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 10 ++++++++++
 6 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sme.c

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index c50d86331ed2..6e9a610c5e5d 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -1,5 +1,6 @@
 fp-pidbench
 fpsimd-test
+rdvl-sme
 rdvl-sve
 sve-probe-vls
 sve-ptrace
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 95f0b877a060..a224fff8082b 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -3,7 +3,7 @@
 CFLAGS += -I../../../../../usr/include/
 TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
 TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
-	rdvl-sve \
+	rdvl-sme rdvl-sve \
 	sve-test sve-stress \
 	vlset
 
@@ -13,6 +13,7 @@ fp-pidbench: fp-pidbench.S asm-utils.o
 	$(CC) -nostdlib $^ -o $@
 fpsimd-test: fpsimd-test.o asm-utils.o
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
index c916c1c9defd..1a2ebf07a20c 100644
--- a/tools/testing/selftests/arm64/fp/rdvl.S
+++ b/tools/testing/selftests/arm64/fp/rdvl.S
@@ -8,3 +8,11 @@ rdvl_sve:
 	hint	34			// BTI C
 	rdvl	x0, #1
 	ret
+
+.globl rdvl_sme
+rdvl_sme:
+	hint	34			// BTI C
+
+	.inst	0x4bf5820		// RDSVL x0, #1
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
index c90658811a83..9bcfcdc34ee9 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -51,6 +51,16 @@ static struct vec_data vec_data[] = {
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

