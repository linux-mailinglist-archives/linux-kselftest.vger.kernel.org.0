Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A65749E75E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 17:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbiA0QWC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 11:22:02 -0500
Received: from foss.arm.com ([217.140.110.172]:42116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238119AbiA0QWC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 11:22:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33D971063;
        Thu, 27 Jan 2022 08:22:02 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18E133F766;
        Thu, 27 Jan 2022 08:22:00 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        james.morse@arm.com
Subject: [PATCH 2/3] arm64: insn: Add tests for aarch64_insn_gen_logical_immediate()
Date:   Thu, 27 Jan 2022 16:21:26 +0000
Message-Id: <20220127162127.2391947-3-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127162127.2391947-1-james.morse@arm.com>
References: <20220127162127.2391947-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Aarch64 has instructions to generate reasonably complicated 32 or 64
bit masks from only 13 bits of information.
aarch64_insn_gen_logical_immediate() has to created the immediate
encoding by spotting the patterns in the 32 or 64 bit immediate.

Despite attempts to validate or model this code, or use it as-is outside
the kernel tree, bugs still exist.

Add a self test module that tests this code in place against a golden
set of values.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig.debug                   |  3 +
 arch/arm64/Makefile                        |  2 +
 arch/arm64/lib/Makefile                    |  2 +
 arch/arm64/lib/insn.c                      |  3 +
 arch/arm64/lib/test_insn.c                 | 90 ++++++++++++++++++++++
 tools/testing/selftests/arm64/Makefile     |  2 +-
 tools/testing/selftests/arm64/lib/Makefile |  6 ++
 tools/testing/selftests/arm64/lib/config   |  1 +
 tools/testing/selftests/arm64/lib/insn.sh  |  5 ++
 9 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/lib/test_insn.c
 create mode 100644 tools/testing/selftests/arm64/lib/Makefile
 create mode 100644 tools/testing/selftests/arm64/lib/config
 create mode 100755 tools/testing/selftests/arm64/lib/insn.sh

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 265c4461031f..10df6056db3e 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -20,4 +20,7 @@ config ARM64_RELOC_TEST
 	depends on m
 	tristate "Relocation testing module"
 
+config TEST_INSN
+	tristate "Test functions located in the aarch64 instruction encoder at runtime"
+
 source "drivers/hwtracing/coresight/Kconfig"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 0bd590605416..4930a2b077b8 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -176,7 +176,9 @@ vdso_install:
 
 archprepare:
 	$(Q)$(MAKE) $(build)=arch/arm64/tools kapi
+#ifdef CONFIG_TEST_INSN
 	$(Q)$(MAKE) $(build)=arch/arm64/tools tests
+#endif
 ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
   ifneq ($(CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419),y)
 	@echo "warning: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum" >&2
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 29490be2546b..d180945ecc22 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -22,3 +22,5 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 obj-$(CONFIG_ARM64_MTE) += mte.o
 
 obj-$(CONFIG_KASAN_SW_TAGS) += kasan_sw_tags.o
+
+obj-$(CONFIG_TEST_INSN) += test_insn.o
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index fccfe363e567..8888e407032f 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -193,6 +193,7 @@ u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn)
 
 	return (insn >> shift) & mask;
 }
+EXPORT_SYMBOL_GPL(aarch64_insn_decode_immediate);
 
 u32 __kprobes aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 				  u32 insn, u64 imm)
@@ -256,6 +257,7 @@ u32 aarch64_insn_decode_register(enum aarch64_insn_register_type type,
 
 	return (insn >> shift) & GENMASK(4, 0);
 }
+EXPORT_SYMBOL_GPL(aarch64_insn_decode_register);
 
 static u32 aarch64_insn_encode_register(enum aarch64_insn_register_type type,
 					u32 insn,
@@ -1424,6 +1426,7 @@ u32 aarch64_insn_gen_logical_immediate(enum aarch64_insn_logic_type type,
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, Rn);
 	return aarch64_encode_immediate(imm, variant, insn);
 }
+EXPORT_SYMBOL_GPL(aarch64_insn_gen_logical_immediate);
 
 u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
 			  enum aarch64_insn_register Rm,
diff --git a/arch/arm64/lib/test_insn.c b/arch/arm64/lib/test_insn.c
new file mode 100644
index 000000000000..41466f61c6c0
--- /dev/null
+++ b/arch/arm64/lib/test_insn.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test cases for the aarch64 insn encoder.
+ *
+ * Copyright (C) 2021 ARM Limited.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+#include <asm/debug-monitors.h>
+#include <asm/insn.h>
+
+#include "../../../tools/testing/selftests/kselftest_module.h"
+
+struct bitmask_test_case {
+	/* input */
+	u64 imm;
+
+	/* expected output */
+	u64 n, immr, imms;
+};
+struct bitmask_test_case aarch64_logic_imm_test[] = {
+#include <asm/test_logic_imm_generated.h>
+};
+
+KSTM_MODULE_GLOBALS();
+
+static void __init test_logic_imm(void)
+{
+	int i;
+	u8 rd, rn;
+	u32 insn;
+
+	for (i = 0; i < ARRAY_SIZE(aarch64_logic_imm_test); i++) {
+		total_tests++;
+
+		rd = i % 30;
+		rn = (i + 1) % 30;
+
+		insn = aarch64_insn_gen_logical_immediate(AARCH64_INSN_LOGIC_AND,
+							  AARCH64_INSN_VARIANT_64BIT,
+							  rn, rd, aarch64_logic_imm_test[i].imm);
+
+		if (!aarch64_insn_is_and_imm(insn) ||
+		    rd != aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn) ||
+		    rn != aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn) ||
+		    aarch64_logic_imm_test[i].imms != aarch64_insn_decode_immediate(AARCH64_INSN_IMM_S, insn) ||
+		    aarch64_logic_imm_test[i].immr != aarch64_insn_decode_immediate(AARCH64_INSN_IMM_R, insn) ||
+		    aarch64_logic_imm_test[i].n != aarch64_insn_decode_immediate(AARCH64_INSN_IMM_N, insn)) {
+			failed_tests++;
+			pr_warn_once("[%s:%u] Failed to encode immediate 0x%llx (got insn 0x%x))\n",
+				     __FILE__, __LINE__, aarch64_logic_imm_test[i].imm, insn);
+			continue;
+		}
+	}
+}
+
+static void __init do_test_bad_logic_imm(u64 imm, enum aarch64_insn_variant var)
+{
+	u32 insn;
+
+	total_tests++;
+	insn = aarch64_insn_gen_logical_immediate(AARCH64_INSN_LOGIC_AND,
+						  var, 0, 0, imm);
+	if (insn != AARCH64_BREAK_FAULT)
+		failed_tests++;
+}
+
+static void __init test_bad_logic_imm(void)
+{
+	do_test_bad_logic_imm(0, AARCH64_INSN_VARIANT_64BIT);
+	do_test_bad_logic_imm(0x1234, AARCH64_INSN_VARIANT_64BIT);
+	do_test_bad_logic_imm(0xffffffffffffffff, AARCH64_INSN_VARIANT_64BIT);
+	do_test_bad_logic_imm((1ULL<<32), AARCH64_INSN_VARIANT_32BIT);
+}
+
+static void __init selftest(void)
+{
+	test_logic_imm();
+	test_bad_logic_imm();
+}
+
+KSTM_MODULE_LOADERS(test_insn);
+MODULE_AUTHOR("James Morse <james.morse@arm.com>");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 1e8d9a8f59df..2c59e7d40524 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
+ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi lib
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/lib/Makefile b/tools/testing/selftests/arm64/lib/Makefile
new file mode 100644
index 000000000000..5ed92a5135ce
--- /dev/null
+++ b/tools/testing/selftests/arm64/lib/Makefile
@@ -0,0 +1,6 @@
+# Copyright (C) 2022 ARM Limited
+# Makefile for arm64/lib/ function selftests
+
+TEST_PROGS := insn.sh
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/lib/config b/tools/testing/selftests/arm64/lib/config
new file mode 100644
index 000000000000..cb982478782b
--- /dev/null
+++ b/tools/testing/selftests/arm64/lib/config
@@ -0,0 +1 @@
+CONFIG_TEST_INSN=m
diff --git a/tools/testing/selftests/arm64/lib/insn.sh b/tools/testing/selftests/arm64/lib/insn.sh
new file mode 100755
index 000000000000..3d893b1a0069
--- /dev/null
+++ b/tools/testing/selftests/arm64/lib/insn.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Tests the aarch64 instruction generation infrastructure using test_insn
+# kernel module.
+$(dirname $0)/../../kselftest/module.sh "insn" test_insn
-- 
2.30.2

