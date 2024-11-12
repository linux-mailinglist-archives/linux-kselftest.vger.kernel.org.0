Return-Path: <linux-kselftest+bounces-21859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F18F9C58A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C82281A20
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D5E156C40;
	Tue, 12 Nov 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajKAAbaG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919E15688C;
	Tue, 12 Nov 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416915; cv=none; b=HkH8odAqiwdWnh7ZNnW12t8t4MOtGA8SXf7TT4ora704miK6hU78lqThbXybaUc3xDU+heKt8RZfVjvbRZtHYOEEr/zuieGmfpibQWGquFTQSZEALxnD8FgjECJnODs4P9e625KdjtL0XajFn2lsiD+wrc/H80T7te/Gav7hoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416915; c=relaxed/simple;
	bh=2gOyKvJrNoYV0gN7FdPkeZjJPBPgvem/G1SB7ge5K6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQG2b8spmyKdciGR0CBYhriadY86WQByhh2P6eTQDxt/2l15wgPyweaz3G6bNLf59N6wQD3w5ptdSEoJowGpKpyl9XzXpPo4EBsGYj/OdlRA9iNlBooWEOTcUi7Ea4nANnZkayAc65QcsWALcNPO0NBFkcZADlE5nZvqUvbDCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajKAAbaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5660CC4CED5;
	Tue, 12 Nov 2024 13:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731416915;
	bh=2gOyKvJrNoYV0gN7FdPkeZjJPBPgvem/G1SB7ge5K6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ajKAAbaGACkuXbjxxM/BfBLYXC5Tp5e6wBb7l5bnUvefFXCy4TYc6cweeCOi/yFX+
	 8XW3JveVgQS2/tpg2VFon/Aj2KuXiVQGrrvcEsF7dcb6JXbNJewBl/QF3zIfD3pRY9
	 IE/eMVE9bdYRAmgr7UeT2BdGCa0wc2uOea0rZlrCE4ufNpxl8EleqUUAh5CENxAV6P
	 urMCauDxqWEL8EWEeWZug2vqZ9XCFPpmfQkoL+yNHxiNLUsclIVrDmOyFFxqhaMtLu
	 Km1nj1qJOXz8L3BDaTNcMSaV2RHdRkTuPu4nimOpufA4h/gkZcvOK/lzAhAbNxRmXt
	 jiDquzO6wd+Qg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 12 Nov 2024 13:08:16 +0000
Subject: [PATCH v2 3/3] kselftest/arm64: Add FPMR coverage to fp-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-arm64-fp-ptrace-fpmr-v2-3-250b57c61254@kernel.org>
References: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
In-Reply-To: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10366; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2gOyKvJrNoYV0gN7FdPkeZjJPBPgvem/G1SB7ge5K6k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnM1NJ7n/1qslnTpDexD783I3N0/3CJa25iJGYW
 ivh4g53yOKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzNTSQAKCRAk1otyXVSH
 0HdOB/9a1iojXt1HYxTYJI2eZB+j1/TYSVtduAxbeAEpZlyjooXtVleKcpGe0gNbXyb1qTCch+o
 Asgi8impochJFSc7sntVXsxQDNREmvRvtDoY2MibLJ6QPVkHOEYiAc/Z4/N07SFkfyUthm4pQIs
 5i8NhEcj3pdDldhpPQejcASa3wgwlvZ4MUhU4uQpCk7hPhjUUeQMwVoNFiNVYWFwuSNjLXY4BIV
 e/SRVzvUP+DSXymmEMRcvXVirUgINpnYGNXQPnlCn9HRtc9Xx/cH/clh8ZpPrm/ush5M+/GcwPW
 rkhBvuNbzd4W89JWI/TpfMBzmSau+TcF4xg4ATyTaAsS5QCD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage for FPMR to fp-ptrace. FPMR can be available independently of
SVE and SME, if SME is supported then FPMR is cleared by entering and
exiting streaming mode. As with other registers we generate random values
to load into the register, we restrict these to bitfields which are always
defined. We also leave bitfields where the valid values are affected by
the set of supported FP8 formats zero to reduce complexity, it is unlikely
that specific bitfields will be affected by ptrace issues.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-ptrace-asm.S |  23 +++--
 tools/testing/selftests/arm64/fp/fp-ptrace.c     | 126 +++++++++++++++++++++++
 tools/testing/selftests/arm64/fp/fp-ptrace.h     |   2 +
 tools/testing/selftests/arm64/fp/sme-inst.h      |   2 +
 4 files changed, 146 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S b/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
index 5e7e9c878f2ce797e3ba5f4033a42526830393e6..6195b9969d67e15d46ca71f1d273b2d43ef4ae7a 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
@@ -71,14 +71,12 @@ check_sm_in:
 	tbz	x7, #SVCR_SM_SHIFT, check_sve_in
 
 	// Load FFR if we have FA64
-	mov	x4, #0
-	tbz	x0, #HAVE_FA64_SHIFT, load_sve
-	mov	x4, #1
+	ubfx	x4, x0, #HAVE_FA64_SHIFT, #1
 	b	load_sve
 
 	// SVE?
 check_sve_in:
-	tbz	x0, #HAVE_SVE_SHIFT, wait_for_writes
+	tbz	x0, #HAVE_SVE_SHIFT, check_fpmr_in
 	mov	x4, #1
 
 load_sve:
@@ -143,6 +141,13 @@ load_sve:
 	ldr	p14, [x7, #14, MUL VL]
 	ldr	p15, [x7, #15, MUL VL]
 
+	// This has to come after we set PSTATE.SM
+check_fpmr_in:
+	tbz	x0, #HAVE_FPMR_SHIFT, wait_for_writes
+	adrp	x7, fpmr_in
+	ldr	x7, [x7, :lo12:fpmr_in]
+	msr	FPMR, x7
+
 wait_for_writes:
 	// Wait for the parent
 	brk #0
@@ -166,6 +171,12 @@ wait_for_writes:
 	stp	q28, q29, [x7, #16 * 28]
 	stp	q30, q31, [x7, #16 * 30]
 
+	tbz	x0, #HAVE_FPMR_SHIFT, check_sme_out
+	mrs	x7, REG_FPMR
+	adrp	x6, fpmr_out
+	str	x7, [x6, :lo12:fpmr_out]
+
+check_sme_out:
 	tbz	x0, #HAVE_SME_SHIFT, check_sve_out
 
 	rdsvl	11, 1
@@ -197,9 +208,7 @@ check_sm_out:
 	tbz	x7, #SVCR_SM_SHIFT, check_sve_out
 
 	// Do we have FA64 and FFR?
-	mov	x4, #0
-	tbz	x0, #HAVE_FA64_SHIFT, read_sve
-	mov	x4, #1
+	ubfx	x4, x0, #HAVE_FA64_SHIFT, #1
 	b	read_sve
 
 	// SVE?
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index 56cf6e02c535b5c1cf1134c5b1973605c96024ee..4930e03a7b9903eab85a1e004354939f6a9fe9d4 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -31,6 +31,14 @@
 
 #include "fp-ptrace.h"
 
+#include <linux/bits.h>
+
+#define FPMR_LSCALE2_MASK                               GENMASK(37, 32)
+#define FPMR_NSCALE_MASK                                GENMASK(31, 24)
+#define FPMR_LSCALE_MASK                                GENMASK(22, 16)
+#define FPMR_OSC_MASK                                   GENMASK(15, 15)
+#define FPMR_OSM_MASK                                   GENMASK(14, 14)
+
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_SVE
 #define NT_ARM_SVE 0x405
@@ -48,11 +56,22 @@
 #define NT_ARM_ZT 0x40d
 #endif
 
+#ifndef NT_ARM_FPMR
+#define NT_ARM_FPMR 0x40e
+#endif
+
 #define ARCH_VQ_MAX 256
 
 /* VL 128..2048 in powers of 2 */
 #define MAX_NUM_VLS 5
 
+/*
+ * FPMR bits we can set without doing feature checks to see if values
+ * are valid.
+ */
+#define FPMR_SAFE_BITS (FPMR_LSCALE2_MASK | FPMR_NSCALE_MASK | \
+			FPMR_LSCALE_MASK | FPMR_OSC_MASK | FPMR_OSM_MASK)
+
 #define NUM_FPR 32
 __uint128_t v_in[NUM_FPR];
 __uint128_t v_expected[NUM_FPR];
@@ -78,6 +97,8 @@ char zt_in[ZT_SIG_REG_BYTES];
 char zt_expected[ZT_SIG_REG_BYTES];
 char zt_out[ZT_SIG_REG_BYTES];
 
+uint64_t fpmr_in, fpmr_expected, fpmr_out;
+
 uint64_t sve_vl_out;
 uint64_t sme_vl_out;
 uint64_t svcr_in, svcr_expected, svcr_out;
@@ -128,6 +149,11 @@ static bool fa64_supported(void)
 	return getauxval(AT_HWCAP2) & HWCAP2_SME_FA64;
 }
 
+static bool fpmr_supported(void)
+{
+	return getauxval(AT_HWCAP2) & HWCAP2_FPMR;
+}
+
 static bool compare_buffer(const char *name, void *out,
 			   void *expected, size_t size)
 {
@@ -233,6 +259,8 @@ static void run_child(struct test_config *config)
 		flags |= HAVE_SME2;
 	if (fa64_supported())
 		flags |= HAVE_FA64;
+	if (fpmr_supported())
+		flags |= HAVE_FPMR;
 
 	load_and_save(flags);
 
@@ -321,6 +349,14 @@ static void read_child_regs(pid_t child)
 		iov_child.iov_len = sizeof(zt_out);
 		read_one_child_regs(child, "ZT", &iov_parent, &iov_child);
 	}
+
+	if (fpmr_supported()) {
+		iov_parent.iov_base = &fpmr_out;
+		iov_parent.iov_len = sizeof(fpmr_out);
+		iov_child.iov_base = &fpmr_out;
+		iov_child.iov_len = sizeof(fpmr_out);
+		read_one_child_regs(child, "FPMR", &iov_parent, &iov_child);
+	}
 }
 
 static bool continue_breakpoint(pid_t child,
@@ -595,6 +631,26 @@ static bool check_ptrace_values_zt(pid_t child, struct test_config *config)
 	return compare_buffer("initial ZT", buf, zt_in, ZT_SIG_REG_BYTES);
 }
 
+static bool check_ptrace_values_fpmr(pid_t child, struct test_config *config)
+{
+	uint64_t val;
+	struct iovec iov;
+	int ret;
+
+	if (!fpmr_supported())
+		return true;
+
+	iov.iov_base = &val;
+	iov.iov_len = sizeof(val);
+	ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_FPMR, &iov);
+	if (ret != 0) {
+		ksft_print_msg("Failed to read initial FPMR: %s (%d)\n",
+			       strerror(errno), errno);
+		return false;
+	}
+
+	return compare_buffer("initial FPMR", &val, &fpmr_in, sizeof(val));
+}
 
 static bool check_ptrace_values(pid_t child, struct test_config *config)
 {
@@ -629,6 +685,9 @@ static bool check_ptrace_values(pid_t child, struct test_config *config)
 	if (!check_ptrace_values_zt(child, config))
 		pass = false;
 
+	if (!check_ptrace_values_fpmr(child, config))
+		pass = false;
+
 	return pass;
 }
 
@@ -832,11 +891,18 @@ static void set_initial_values(struct test_config *config)
 {
 	int vq = __sve_vq_from_vl(vl_in(config));
 	int sme_vq = __sve_vq_from_vl(config->sme_vl_in);
+	bool sm_change;
 
 	svcr_in = config->svcr_in;
 	svcr_expected = config->svcr_expected;
 	svcr_out = 0;
 
+	if (sme_supported() &&
+	    (svcr_in & SVCR_SM) != (svcr_expected & SVCR_SM))
+		sm_change = true;
+	else
+		sm_change = false;
+
 	fill_random(&v_in, sizeof(v_in));
 	memcpy(v_expected, v_in, sizeof(v_in));
 	memset(v_out, 0, sizeof(v_out));
@@ -883,6 +949,21 @@ static void set_initial_values(struct test_config *config)
 			memset(zt_expected, 0, ZT_SIG_REG_BYTES);
 		memset(zt_out, 0, sizeof(zt_out));
 	}
+
+	if (fpmr_supported()) {
+		fill_random(&fpmr_in, sizeof(fpmr_in));
+		fpmr_in &= FPMR_SAFE_BITS;
+
+		/* Entering or exiting streaming mode clears FPMR */
+		if (sm_change)
+			fpmr_expected = 0;
+		else
+			fpmr_expected = fpmr_in;
+	} else {
+		fpmr_in = 0;
+		fpmr_expected = 0;
+		fpmr_out = 0;
+	}
 }
 
 static bool check_memory_values(struct test_config *config)
@@ -933,6 +1014,12 @@ static bool check_memory_values(struct test_config *config)
 	if (!compare_buffer("saved ZT", zt_out, zt_expected, ZT_SIG_REG_BYTES))
 		pass = false;
 
+	if (fpmr_out != fpmr_expected) {
+		ksft_print_msg("Mismatch in saved FPMR: %lx != %lx\n",
+			       fpmr_out, fpmr_expected);
+		pass = false;
+	}
+
 	return pass;
 }
 
@@ -1010,6 +1097,36 @@ static void fpsimd_write(pid_t child, struct test_config *test_config)
 			       strerror(errno), errno);
 }
 
+static bool fpmr_write_supported(struct test_config *config)
+{
+	if (!fpmr_supported())
+		return false;
+
+	if (!sve_sme_same(config))
+		return false;
+
+	return true;
+}
+
+static void fpmr_write_expected(struct test_config *config)
+{
+	fill_random(&fpmr_expected, sizeof(fpmr_expected));
+	fpmr_expected &= FPMR_SAFE_BITS;
+}
+
+static void fpmr_write(pid_t child, struct test_config *config)
+{
+	struct iovec iov;
+	int ret;
+
+	iov.iov_len = sizeof(fpmr_expected);
+	iov.iov_base = &fpmr_expected;
+	ret = ptrace(PTRACE_SETREGSET, child, NT_ARM_FPMR, &iov);
+	if (ret != 0)
+		ksft_print_msg("Failed to write FPMR: %s (%d)\n",
+			       strerror(errno), errno);
+}
+
 static void sve_write_expected(struct test_config *config)
 {
 	int vl = vl_expected(config);
@@ -1266,6 +1383,12 @@ static struct test_definition base_test_defs[] = {
 		.set_expected_values = fpsimd_write_expected,
 		.modify_values = fpsimd_write,
 	},
+	{
+		.name = "FPMR write",
+		.supported = fpmr_write_supported,
+		.set_expected_values = fpmr_write_expected,
+		.modify_values = fpmr_write,
+	},
 };
 
 static struct test_definition sve_test_defs[] = {
@@ -1475,6 +1598,9 @@ int main(void)
 	if (fa64_supported())
 		ksft_print_msg("FA64 supported\n");
 
+	if (fpmr_supported())
+		ksft_print_msg("FPMR supported\n");
+
 	ksft_set_plan(tests);
 
 	/* Get signal handers ready before we start any children */
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.h b/tools/testing/selftests/arm64/fp/fp-ptrace.h
index 36ca627e1980f6a384d9ed0f2e9d4bd32d90f893..c06919aaf1f70bee4b607f71e3213ef2ddf8b97d 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.h
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.h
@@ -14,10 +14,12 @@
 #define HAVE_SME_SHIFT		1
 #define HAVE_SME2_SHIFT		2
 #define HAVE_FA64_SHIFT		3
+#define HAVE_FPMR_SHIFT		4
 
 #define HAVE_SVE	(1 << HAVE_SVE_SHIFT)
 #define HAVE_SME	(1 << HAVE_SME_SHIFT)
 #define HAVE_SME2	(1 << HAVE_SME2_SHIFT)
 #define HAVE_FA64	(1 << HAVE_FA64_SHIFT)
+#define HAVE_FPMR	(1 << HAVE_FPMR_SHIFT)
 
 #endif
diff --git a/tools/testing/selftests/arm64/fp/sme-inst.h b/tools/testing/selftests/arm64/fp/sme-inst.h
index 9292bba5400bb81b8e34769fa3eb70811746d8b8..85b9184e0835c59dbd5674b0210e6b9a43c1be4c 100644
--- a/tools/testing/selftests/arm64/fp/sme-inst.h
+++ b/tools/testing/selftests/arm64/fp/sme-inst.h
@@ -5,6 +5,8 @@
 #ifndef SME_INST_H
 #define SME_INST_H
 
+#define REG_FPMR                                        S3_3_C4_C4_2
+
 /*
  * RDSVL X\nx, #\imm
  */

-- 
2.39.5


