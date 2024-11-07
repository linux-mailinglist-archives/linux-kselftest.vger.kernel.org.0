Return-Path: <linux-kselftest+bounces-21578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E89BFBC5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E6E283C92
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD465144D1A;
	Thu,  7 Nov 2024 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHMljWkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94740143C69;
	Thu,  7 Nov 2024 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943546; cv=none; b=j8PQaHY3y1LN+bvqAF/7Mj9EalC4PM6TyoJm0iZ1jmqd/FrMtro8PNIolKt0eAHp29hgl9LZ9J7w0RhTlbk7+XirZM350dNj6+CloZP0fzqa1ZuI8LJuUWjrM902HhuMJcGHtUifWvTlYTRABlNVRkO2dbAnaAPDVKOz6Mmr1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943546; c=relaxed/simple;
	bh=AvfdUHt4SQuoQ2J04ipwQPtmRhlm71W6ng8XXWEK82g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPfY4p4WBb7TnKIaOlgJ554t+ZIJbaKEarvANYdaDTI/g65jS4bKRyOJhmgMVA+B9cl9X56TpuGS2JhOMLNovodZIyencZmRSAbsNC8MugZ5zCsbHqGnJMqYCiU4hRa1mHeh5waX87klFFkCJV6h0g6cWnNMSfZznpePE0cIjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHMljWkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2541FC4CECC;
	Thu,  7 Nov 2024 01:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943546;
	bh=AvfdUHt4SQuoQ2J04ipwQPtmRhlm71W6ng8XXWEK82g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tHMljWkBPI2SCqvPL/EMb4S9H+DWsn6YMSzVcoi2SoMmIOdw0RrpgHDVSwvvI/Zhn
	 QGX+rGmnZ2HPv3dfKtqMN02YEBM553pZ54Fucevd1f/9nDZg2l3PRU6dx3saWf339R
	 DFF4I8o+92Ct3JkkxkQfMoupMNvNMlptQjnVZmNQRKzH04aawR5MCC3gbYPoWbSk/Q
	 UmSoxMXef/NHnV+VCOrByeE+pHzj2w4RBmRBH5zSoXO+dzVUS6hO5shq6hZb0cME13
	 UQomXyH29jpewNPFJAC628idZ+Mhha1lz3GVSVxJC3VO5O8uqa2XLXUmJuXaf6ajt4
	 ZeU/k0d+O7DlQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 07 Nov 2024 01:38:07 +0000
Subject: [PATCH 4/4] kselftest/arm64: Add FPMR coverage to fp-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-arm64-fp-ptrace-fpmr-v1-4-3e5e0b6e3be9@kernel.org>
References: <20241107-arm64-fp-ptrace-fpmr-v1-0-3e5e0b6e3be9@kernel.org>
In-Reply-To: <20241107-arm64-fp-ptrace-fpmr-v1-0-3e5e0b6e3be9@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=9267; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AvfdUHt4SQuoQ2J04ipwQPtmRhlm71W6ng8XXWEK82g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnLBovl35MBXeoYycpA4o04Wersh+02idNHyCXuSne
 65zpa+qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZywaLwAKCRAk1otyXVSH0M5/B/
 wIppYByRrA4iVVTVno97ME/7h9kZX7ztzmdd2zDga5nBAWwJNB34tg31nyZEK0hKv8HgA/mRvy789k
 LotZQhDDraEWN/i5SXWp11Y96VQvcUCR/nMCFlXPo0RyvAcR+fVVP968LiSCDJKJ9HjAK/J7QPIBM1
 xKrVSUUoVHNtMwL688K1TJRYoUnoHambmbsT/zOhOW05ZAzgrbuh7XDMcMdEdJ816Iw7wtdRZO8n8A
 FLtDUKr151rm1rg7WfUKSvMQnwmGl55GzlHdHPbCt8m6gB4hV2A6t34i+StV6XBQGVnY7dWD2UgjHe
 qIhDdi4bwf0xqlVOlB9Fa3J1FfDvoN
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
 tools/testing/selftests/arm64/fp/fp-ptrace.c     | 118 +++++++++++++++++++++++
 tools/testing/selftests/arm64/fp/fp-ptrace.h     |   2 +
 3 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S b/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
index 4a9242296ef75cf1a83ec561cda11a31e9f69bd4..5c4cf6da2a79702f424f4beaf2f91b2ee6067eff 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
@@ -76,14 +76,12 @@ check_sm_in:
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
@@ -148,6 +146,13 @@ load_sve:
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
@@ -171,6 +176,12 @@ wait_for_writes:
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
@@ -202,9 +213,7 @@ check_sm_out:
 	tbz	x7, #SVCR_SM_SHIFT, check_sve_out
 
 	// Do we have FA64 and FFR?
-	mov	x4, #0
-	tbz	x0, #HAVE_FA64_SHIFT, read_sve
-	mov	x4, #1
+	ubfx	x4, x0, #HAVE_FA64_SHIFT, #1
 	b	read_sve
 
 	// SVE?
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index a35dc6d8f82af47bf6adedba7e69a6577ee9f7de..14e88f867fb02784afe61a01873ae2676c869e8a 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -50,11 +50,22 @@
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
@@ -80,6 +91,8 @@ char zt_in[ZT_SIG_REG_BYTES];
 char zt_expected[ZT_SIG_REG_BYTES];
 char zt_out[ZT_SIG_REG_BYTES];
 
+uint64_t fpmr_in, fpmr_expected, fpmr_out;
+
 uint64_t sve_vl_out;
 uint64_t sme_vl_out;
 uint64_t svcr_in, svcr_expected, svcr_out;
@@ -130,6 +143,11 @@ static bool fa64_supported(void)
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
@@ -235,6 +253,8 @@ static void run_child(struct test_config *config)
 		flags |= HAVE_SME2;
 	if (fa64_supported())
 		flags |= HAVE_FA64;
+	if (fpmr_supported())
+		flags |= HAVE_FPMR;
 
 	load_and_save(flags);
 
@@ -323,6 +343,14 @@ static void read_child_regs(pid_t child)
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
@@ -597,6 +625,26 @@ static bool check_ptrace_values_zt(pid_t child, struct test_config *config)
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
@@ -631,6 +679,9 @@ static bool check_ptrace_values(pid_t child, struct test_config *config)
 	if (!check_ptrace_values_zt(child, config))
 		pass = false;
 
+	if (!check_ptrace_values_fpmr(child, config))
+		pass = false;
+
 	return pass;
 }
 
@@ -834,11 +885,18 @@ static void set_initial_values(struct test_config *config)
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
@@ -885,6 +943,21 @@ static void set_initial_values(struct test_config *config)
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
@@ -935,6 +1008,12 @@ static bool check_memory_values(struct test_config *config)
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
 
@@ -1012,6 +1091,36 @@ static void fpsimd_write(pid_t child, struct test_config *test_config)
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
@@ -1268,6 +1377,12 @@ static struct test_definition base_test_defs[] = {
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
@@ -1477,6 +1592,9 @@ int main(void)
 	if (fa64_supported())
 		ksft_print_msg("FA64 supported\n");
 
+	if (fpmr_supported())
+		ksft_print_msg("FPMR supported\n");
+
 	ksft_set_plan(tests);
 
 	/* Get signal handers ready before we start any children */
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.h b/tools/testing/selftests/arm64/fp/fp-ptrace.h
index a3849817cf4ee23879da835cb7f66821b5e09bd0..1234394841303affd9aaba5cfcba0fcef2b5d30e 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.h
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.h
@@ -10,10 +10,12 @@
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

-- 
2.39.2


