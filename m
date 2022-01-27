Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26FF49E75D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbiA0QWA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 11:22:00 -0500
Received: from foss.arm.com ([217.140.110.172]:42108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238119AbiA0QWA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 11:22:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5516113E;
        Thu, 27 Jan 2022 08:21:59 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB6BD3F766;
        Thu, 27 Jan 2022 08:21:58 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        james.morse@arm.com
Subject: [PATCH 1/3] arm64: selftests: Generate all the possible logical immediates as a header
Date:   Thu, 27 Jan 2022 16:21:25 +0000
Message-Id: <20220127162127.2391947-2-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127162127.2391947-1-james.morse@arm.com>
References: <20220127162127.2391947-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Aarch64 has instructions to generate reasonably complicated 32 or 64
bit masks from only 13 bits of information. To test the in-kernel code
that spots the pattern to produce the instruction encoding a golden set
of values is needed.

A header file containing these is large. Instead, generate every possible
instruction encoding, and its decoded immediate, based on the arm-arm's
DecodeBitMasks() pseudocode. These are output in a format that can be used
in a header file for the test.

Having the golden values in a header file allows them to be inspected,
and checked against a trusted source. The generation program can be told
to pass each value through objdump and compared.

Unsat's jitterbug project has a python script that does this too, but
the license isn't clear from the github repository.

Link: https://lore.kernel.org/linux-arm-kernel/CAB-e3NRCJ_4+vkFPkMN67DwBBtO=sJw>
CC: Luke Nelson <luke.r.nels@gmail.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Makefile              |   1 +
 arch/arm64/tools/.gitignore      |   2 +
 arch/arm64/tools/Makefile        |  12 +-
 arch/arm64/tools/gen_logic_imm.c | 190 +++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/tools/.gitignore
 create mode 100644 arch/arm64/tools/gen_logic_imm.c

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2f1de88651e6..0bd590605416 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -176,6 +176,7 @@ vdso_install:
 
 archprepare:
 	$(Q)$(MAKE) $(build)=arch/arm64/tools kapi
+	$(Q)$(MAKE) $(build)=arch/arm64/tools tests
 ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
   ifneq ($(CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419),y)
 	@echo "warning: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum" >&2
diff --git a/arch/arm64/tools/.gitignore b/arch/arm64/tools/.gitignore
new file mode 100644
index 000000000000..6ee79cdac729
--- /dev/null
+++ b/arch/arm64/tools/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+gen_logic_imm
diff --git a/arch/arm64/tools/Makefile b/arch/arm64/tools/Makefile
index 932b4fe5c768..ce44b531fba7 100644
--- a/arch/arm64/tools/Makefile
+++ b/arch/arm64/tools/Makefile
@@ -4,10 +4,11 @@ gen := arch/$(ARCH)/include/generated
 kapi := $(gen)/asm
 
 kapi-hdrs-y := $(kapi)/cpucaps.h
+tests-hdrs-y := $(kapi)/test_logic_imm_generated.h
 
 targets += $(addprefix ../../../,$(gen-y) $(kapi-hdrs-y))
 
-PHONY += kapi
+PHONY += kapi tests
 
 kapi:   $(kapi-hdrs-y) $(gen-y)
 
@@ -20,3 +21,12 @@ quiet_cmd_gen_cpucaps = GEN     $@
 
 $(kapi)/cpucaps.h: $(src)/gen-cpucaps.awk $(src)/cpucaps FORCE
 	$(call if_changed,gen_cpucaps)
+
+tests:	$(tests-hdrs-y) $(gen-y)
+
+quiet_cmd_build_gen_logic_imm = GEN     $@
+      cmd_build_gen_logic_imm = $(obj)/gen_logic_imm > $@
+
+hostprogs := gen_logic_imm
+$(kapi)/test_logic_imm_generated.h: $(obj)/gen_logic_imm FORCE
+	$(call if_changed,build_gen_logic_imm)
diff --git a/arch/arm64/tools/gen_logic_imm.c b/arch/arm64/tools/gen_logic_imm.c
new file mode 100644
index 000000000000..42ac83a33823
--- /dev/null
+++ b/arch/arm64/tools/gen_logic_imm.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 ARM Limited */
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+typedef uint32_t u32;
+typedef uint64_t u64;
+
+static u64 gen_mask(u32 num_bits)
+{
+	if (num_bits == 64)
+		return ~0ULL;
+
+	return (1ULL<<num_bits) - 1;
+}
+
+static u64 ror(u64 bits, u64 count, u64 esize)
+{
+	u64 ret;
+	u64 bottom_bits = bits & gen_mask(count);
+
+	if (!count)
+		return bits;
+
+	ret = bottom_bits << (esize - count) | (bits >> count);
+
+	return ret;
+}
+
+static u64 replicate(u64 bits, u32 esize)
+{
+	int i;
+	u64 ret = 0;
+
+	bits &= gen_mask(esize);
+	for (i = 0; i < 64; i += esize)
+		ret |= (u64)bits << i;
+
+	return ret;
+}
+
+static u32 fls(u32 x)
+{
+	/* If x is 0, the result is undefined */
+	if (!x)
+		return 32;
+
+	return 32 - __builtin_clz(x);
+}
+
+#define PIPE_READ	0
+#define PIPE_WRITE	1
+/*
+ * Use objdump to decode the encoded instruction, and compare the immediate.
+ * On error, returns the bad instruction, otherwise returns 0.
+ */
+static int validate(u64 val, u32 immN, u32 imms, u32 immr, char *objdump)
+{
+	pid_t child;
+	char *immediate;
+	char val_str[32];
+	u32 insn = 0x12000000;
+	char output[1024] = {0};
+	int fd, pipefd[2], bytes;
+	char filename[] = "validate_gen_logic_imm.XXXXXX";
+
+	insn |= 1 << 31;
+	insn |= (immN & 0x1)<<22;
+	insn |= (immr & 0x3f)<<16;
+	insn |= (imms & 0x3f)<<10;
+
+	fd = mkstemp(filename);
+	if (fd < 0)
+		abort();
+
+	write(fd, &insn, sizeof(insn));
+	close(fd);
+
+	if (pipe(pipefd))
+		return 0;
+
+	child = vfork();
+	if (child) {
+		close(pipefd[PIPE_WRITE]);
+		waitpid(child, NULL, 0);
+
+		bytes = read(pipefd[PIPE_READ], output, sizeof(output));
+		close(pipefd[PIPE_READ]);
+		if (!bytes || bytes == sizeof(output))
+			return insn;
+
+		immediate = strstr(output, "x0, x0, #");
+		if (!immediate)
+			return insn;
+		immediate += strlen("x0, x0, #");
+
+		/*
+		 * strtoll() has its own ideas about overflow and underflow.
+		 * Do a string comparison. immediate ends in a newline.
+		 */
+		snprintf(val_str, sizeof(val_str), "0x%lx", val);
+		if (strncmp(val_str, immediate, strlen(val_str))) {
+			fprintf(stderr, "Unexpected decode from objdump: %s\n",
+				immediate);
+			return insn;
+		}
+	} else {
+		close(pipefd[PIPE_READ]);
+		close(1);
+		dup2(pipefd[PIPE_WRITE], 1);
+		execl(objdump, objdump, "-b", "binary", "-m", "aarch64", "-D",
+		      filename, (char *) NULL);
+		abort();
+	}
+
+	unlink(filename);
+	return 0;
+}
+
+static int decode_bit_masks(u32 immN, u32 imms, u32 immr, char *objdump)
+{
+	u32 esize, len, S, R;
+	u64 levels, welem, wmask;
+
+	imms &= 0x3f;
+	immr &= 0x3f;
+
+	len = fls((immN << 6) | (~imms & 0x3f));
+	if (!len || len > 7)
+		return 0;
+
+	esize = 1 << (len - 1);
+	levels = gen_mask(len);
+	S = imms & levels;
+	if (S + 1 >= esize)
+		return 0;
+	R = immr & levels;
+	if (immr >= esize)
+		return 0;
+
+	welem = gen_mask(S + 1);
+	wmask = replicate(ror(welem, R, esize), esize);
+
+	printf("\t{0x%.16lx, %u, %2u, %2u},\n", wmask, immN, immr, imms);
+
+	if (objdump) {
+		u32 bad_insn = validate(wmask, immN, imms, immr, objdump);
+
+		if (bad_insn) {
+			fprintf(stderr,
+				"Failed to validate encoding of 0x%.16lx as 0x%x\n",
+				wmask, bad_insn);
+			exit(1);
+		}
+	}
+
+	return 1;
+}
+
+int main(int argc, char **argv)
+{
+	u32 immN, imms, immr, count = 0;
+	char *objdump = NULL;
+
+	if (argc > 2) {
+		fprintf(stderr, "Usage: %s [/path/to/objdump]\n", argv[0]);
+		exit(0);
+	} else if (argc == 2) {
+		objdump = argv[1];
+	}
+
+	for (immN = 0; immN <= 1; immN++) {
+		for (imms = 0; imms <= 0x3f; imms++) {
+			for (immr = 0; immr <= 0x3f; immr++)
+				count += decode_bit_masks(immN, imms, immr, objdump);
+		}
+	}
+
+	if (count != 5334) {
+		printf("#error Wrong number of encodings generated.\n");
+		exit(1);
+	}
+
+	return 0;
+}
-- 
2.30.2

