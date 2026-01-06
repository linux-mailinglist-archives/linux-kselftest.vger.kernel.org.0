Return-Path: <linux-kselftest+bounces-48310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 09029CF9688
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 17:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 303A3300FEDD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C839338586;
	Tue,  6 Jan 2026 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsDP2vAl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF698332ECD;
	Tue,  6 Jan 2026 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717668; cv=none; b=G7ntR3YZjXcpJVyj4hOefKjELztlPfEnGRZ6/bpp88dIYgjcdp9Vb/FSqLjICqPdnDlDfM+FRjS5Nq+f0PRQjx2IFlEjVjX8/scbado5we54loBtuFpkZbv7swtkIhy8VpM1jgzwZdbwst7In1bva757drX0B08olBszYnduvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717668; c=relaxed/simple;
	bh=xYgDOpclz3W8UTnTnuUmKAYjYLa7hYWNW1Pby+Iekzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qVcQ9/iBZtG9zVEhzJNo2SqfzeACafWZaNygMFYGRLyOLtZi08V+cHP5e8/Ez8HBVJzVow7umqGAgPta+7hV+aIqWO0L9WHoB0OiTR24VgM09kyaHj5MmPzXtAkcRlSydcPvPjG9Z6nKkRMDNWF7Dp29/Q3Xjt8pQodc9hK4USc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsDP2vAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FCCC19423;
	Tue,  6 Jan 2026 16:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717667;
	bh=xYgDOpclz3W8UTnTnuUmKAYjYLa7hYWNW1Pby+Iekzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RsDP2vAlKLrLPFnbQHwFQM6Ai+MlwF8cir6fcB0AGuGTC3gNURYdAHZCDSpA0yD8L
	 dQjhBLOYtVlviS/FDFdRybwQwAYmG2qBIHB8SPbJKW5+rF+rWnbs+TWSRHeIJE1J4Y
	 iFrFaQ4njFzKpvJ4kzA7vpJmKryRfSks3C6NXYq+5KqVM4QxNBhOdR6c71QUzD5Yrb
	 ROXLifp0hZYWERXwtorTSrdoN/2GUMb6f4axkbfJsXZ2TAs+RmyEe2lw+8iFUH0TPd
	 khjKUrYpolzQ2ip5tlk6SbtiUeJ7ty43Y1nIztuyZvLVhFm7cm5gzz7iv2xA6btyIB
	 EAQKM5Ni6HC7Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Jan 2026 16:35:41 +0000
Subject: [PATCH v4 1/5] KVM: selftests: arm64: Report set_id_reg reads of
 test registers as tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-kvm-arm64-set-id-regs-aarch64-v4-1-c7ef4551afb3@kernel.org>
References: <20260106-kvm-arm64-set-id-regs-aarch64-v4-0-c7ef4551afb3@kernel.org>
In-Reply-To: <20260106-kvm-arm64-set-id-regs-aarch64-v4-0-c7ef4551afb3@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Oliver Upton <oupton@kernel.org>
Cc: Ben Horgan <ben.horgan@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4884; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xYgDOpclz3W8UTnTnuUmKAYjYLa7hYWNW1Pby+Iekzk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpXTsa3uBncQmuH/EVport8g4bVtAGuwN4sTJ98
 LHiN+Mk3SOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaV07GgAKCRAk1otyXVSH
 0AvdB/9QUDq8aJpJ786zjEOu+J2GGOkItaleykX4xf+Cf9honMekP3VUs2PbtmxZkTD0sMhamlH
 rNEz+K8dh8ae9T+F1uY0Ch2LYJNRmdf6NAC4MpdGiyU8eCgNAiaX5TY+uOR/1OwdAkHuu2TXsaX
 1KukooUTNZlzc06/+/qbGPflxC1CXiIHkli3aeuWBt+fpPdZXoTRD3KxUnzlcKRimeimh2k6hFz
 8ZsVYg1J3Dz7xXgl9sx+JhGPByZlFIAp7Qk7pWfyRFNU11Ibq8ihvcUSK/71l6B2F1RIpm+CZVQ
 lqx9zLnPAxluGEuW4Z/0ISmv1XDqOLYf4185uvKOqqkU1LKt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently when we run guest code to validate that the values we wrote to
the registers are seen by the guest we assert that these values match using
a KVM selftests level assert, resulting in unclear diagnostics if the test
fails. Replace this assert with reporting a kselftest test per register.

In order to support getting the names of the registers we repaint the array
of ID_ registers to store the names and open code the rest.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 74 +++++++++++++++++++------
 1 file changed, 57 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index c4815d365816..84e9484a4899 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -40,6 +40,7 @@ struct reg_ftr_bits {
 };
 
 struct test_feature_reg {
+	const char *name;
 	uint32_t reg;
 	const struct reg_ftr_bits *ftr_bits;
 };
@@ -218,24 +219,25 @@ static const struct reg_ftr_bits ftr_id_aa64zfr0_el1[] = {
 
 #define TEST_REG(id, table)			\
 	{					\
-		.reg = id,			\
+		.name = #id,			\
+		.reg = SYS_ ## id,		\
 		.ftr_bits = &((table)[0]),	\
 	}
 
 static struct test_feature_reg test_regs[] = {
-	TEST_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0_el1),
-	TEST_REG(SYS_ID_DFR0_EL1, ftr_id_dfr0_el1),
-	TEST_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0_el1),
-	TEST_REG(SYS_ID_AA64ISAR1_EL1, ftr_id_aa64isar1_el1),
-	TEST_REG(SYS_ID_AA64ISAR2_EL1, ftr_id_aa64isar2_el1),
-	TEST_REG(SYS_ID_AA64ISAR3_EL1, ftr_id_aa64isar3_el1),
-	TEST_REG(SYS_ID_AA64PFR0_EL1, ftr_id_aa64pfr0_el1),
-	TEST_REG(SYS_ID_AA64PFR1_EL1, ftr_id_aa64pfr1_el1),
-	TEST_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0_el1),
-	TEST_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1_el1),
-	TEST_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2_el1),
-	TEST_REG(SYS_ID_AA64MMFR3_EL1, ftr_id_aa64mmfr3_el1),
-	TEST_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0_el1),
+	TEST_REG(ID_AA64DFR0_EL1, ftr_id_aa64dfr0_el1),
+	TEST_REG(ID_DFR0_EL1, ftr_id_dfr0_el1),
+	TEST_REG(ID_AA64ISAR0_EL1, ftr_id_aa64isar0_el1),
+	TEST_REG(ID_AA64ISAR1_EL1, ftr_id_aa64isar1_el1),
+	TEST_REG(ID_AA64ISAR2_EL1, ftr_id_aa64isar2_el1),
+	TEST_REG(ID_AA64ISAR3_EL1, ftr_id_aa64isar3_el1),
+	TEST_REG(ID_AA64PFR0_EL1, ftr_id_aa64pfr0_el1),
+	TEST_REG(ID_AA64PFR1_EL1, ftr_id_aa64pfr1_el1),
+	TEST_REG(ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0_el1),
+	TEST_REG(ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1_el1),
+	TEST_REG(ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2_el1),
+	TEST_REG(ID_AA64MMFR3_EL1, ftr_id_aa64mmfr3_el1),
+	TEST_REG(ID_AA64ZFR0_EL1, ftr_id_aa64zfr0_el1),
 };
 
 #define GUEST_REG_SYNC(id) GUEST_SYNC_ARGS(0, id, read_sysreg_s(id), 0, 0);
@@ -265,6 +267,34 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
+#define GUEST_READ_TEST (ARRAY_SIZE(test_regs) + 6)
+
+static const char *get_reg_name(u64 id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
+		if (test_regs[i].reg == id)
+			return test_regs[i].name;
+
+	switch (id) {
+	case SYS_MPIDR_EL1:
+		return "MPIDR_EL1";
+	case SYS_CLIDR_EL1:
+		return "CLIDR_EL1";
+	case SYS_CTR_EL0:
+		return "CTR_EL0";
+	case SYS_MIDR_EL1:
+		return "MIDR_EL1";
+	case SYS_REVIDR_EL1:
+		return "REVIDR_EL1";
+	case SYS_AIDR_EL1:
+		return "AIDR_EL1";
+	default:
+		TEST_FAIL("Unknown register");
+	}
+}
+
 /* Return a safe value to a given ftr_bits an ftr value */
 uint64_t get_safe_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr)
 {
@@ -639,6 +669,8 @@ static void test_guest_reg_read(struct kvm_vcpu *vcpu)
 {
 	bool done = false;
 	struct ucall uc;
+	uint64_t reg_id, expected_val, guest_val;
+	bool match;
 
 	while (!done) {
 		vcpu_run(vcpu);
@@ -649,8 +681,16 @@ static void test_guest_reg_read(struct kvm_vcpu *vcpu)
 			break;
 		case UCALL_SYNC:
 			/* Make sure the written values are seen by guest */
-			TEST_ASSERT_EQ(test_reg_vals[encoding_to_range_idx(uc.args[2])],
-				       uc.args[3]);
+			reg_id = uc.args[2];
+			guest_val = uc.args[3];
+			expected_val = test_reg_vals[encoding_to_range_idx(reg_id)];
+			match = expected_val == guest_val;
+			if (!match)
+				ksft_print_msg("%lx != %lx\n",
+					       expected_val, guest_val);
+			ksft_test_result(match,
+					 "%s value seen in guest\n",
+					 get_reg_name(reg_id));
 			break;
 		case UCALL_DONE:
 			done = true;
@@ -790,7 +830,7 @@ int main(void)
 
 	ksft_print_header();
 
-	test_cnt = 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST;
+	test_cnt = 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST + GUEST_READ_TEST;
 	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
 		for (j = 0; test_regs[i].ftr_bits[j].type != FTR_END; j++)
 			test_cnt++;

-- 
2.47.3


