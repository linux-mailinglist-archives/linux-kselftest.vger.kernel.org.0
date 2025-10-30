Return-Path: <linux-kselftest+bounces-44426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE7CC2104B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAF9434F637
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B553655D8;
	Thu, 30 Oct 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA5G9/Pw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F53655D2;
	Thu, 30 Oct 2025 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839246; cv=none; b=I33Pm/dE4aRa5h1tl01aH7CtLnvbpqq2TBwyn90yOIEeGf/qjevY9xWp43/2pPSVEBsGlppPHDbfek5d6/Z8azypxnSKRq7hQlUOBw7519tsT32/LfZ3jbDjEtWSGnfrRoLsZ++E1k8Mp6EDy/RWXaXbwRNUx+IkEGXPxkVP8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839246; c=relaxed/simple;
	bh=RdNQKxgZm3NWUTfwaPWZhZgP0H44bwRSahfMp4ZPmWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Je0qxgaqYUo+B0XFwSxucHpCbrftyhOnJENFVWYgQUeN35banwXraVKjQrpA1PVf8X08l6UjbRDUpUD3aAhALb0pL9A0e9u23Heh1sk3oY5pWpDbrUSjMsv2yurRLHIUSvc8RgOmSr45pZVyRQzkNabaFe4SCyFJi5rQon5//Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA5G9/Pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBB2C113D0;
	Thu, 30 Oct 2025 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761839245;
	bh=RdNQKxgZm3NWUTfwaPWZhZgP0H44bwRSahfMp4ZPmWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DA5G9/Pw9cgz97DXNdIYP8VJ3q+DBW0IgNHCZ7t35zr0LDzFwDTJzsNJHrgXXnK8m
	 8Mt1oiUotucM+wBF27yrAb07N07VcozXDDbp+krp8g7087tVq63mPbqU9Dw7lgJy00
	 morVrrJi2tr+p60ZIYCwrWV50hlZKULV/brQP5iFhZELlyAvymblmqmxtjBfy5PgwP
	 VaZtx022N+OWckUBb4Xtc2w26MTHV9AcBIAW7Hna3yQlmfjAiK6eyHf/T2LANsMv9W
	 NcvUO70VrOzEyYi2FebFqa9+zJSCoDm9VG+aZteS3OCjXkZhPw2BplzyzLYKcjt+fu
	 B/l477g2zJs6g==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 30 Oct 2025 15:42:47 +0000
Subject: [PATCH 1/3] KVM: selftests: arm64: Report set_id_reg reads of test
 registers as tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-kvm-arm64-set-id-regs-aarch64-v1-1-96fe0d2b178e@kernel.org>
References: <20251030-kvm-arm64-set-id-regs-aarch64-v1-0-96fe0d2b178e@kernel.org>
In-Reply-To: <20251030-kvm-arm64-set-id-regs-aarch64-v1-0-96fe0d2b178e@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=4838; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RdNQKxgZm3NWUTfwaPWZhZgP0H44bwRSahfMp4ZPmWY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpA4iGOWQm7b1TevTko2QKgW79+FZJVEkb/pqxr
 eshNc7xXxCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaQOIhgAKCRAk1otyXVSH
 0HvNB/wOcrkcmEVW4UUKLbGwV2y0JWvcuhRiWfQH16TPBjMFmJo101hM913WPdnXLUxZLWN97po
 DuJ6i/Pb8TMy6ph8uggd/izFRaFCApdRYgwMOK1AwMa6LjLdsezjaLI/8gXYdzsxGuE7Qq+KMGf
 Ggog4vc/CC41m+Fxg1onaWDPc9xEsGjoBxPNM4GeoQ0Kkc9RZ+bB+hJsriyO0e6sxQTjuZPRfBp
 W1ZtITupDX7dbQeaK1nUAx3B4675bgHPX2avROkrpar2XSC9MBtr92ccbSZ/PdVHacvUTN7iDpt
 iX53RYCA9SNJpRIvTEh5kTeW7NgsL56FXsQQqoT26gzGPEIL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently when we run guest code to validate that the values we wrote to
the registers are seen by the guest we assert that these values match using
a KVM selftests level assert, resulting in unclear diagnostics if the test
fails. Replace this assert with reporting a kselftest test per register.

In order to support getting the names of the registers we repaint the array
of ID_ registers to store the names and open code the rest.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 74 +++++++++++++++++++------
 1 file changed, 57 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 5e24f77868b5..7a759e976c2c 100644
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
@@ -635,6 +665,8 @@ static void test_guest_reg_read(struct kvm_vcpu *vcpu)
 {
 	bool done = false;
 	struct ucall uc;
+	uint64_t reg_id, expected_val, guest_val;
+	bool match;
 
 	while (!done) {
 		vcpu_run(vcpu);
@@ -645,8 +677,16 @@ static void test_guest_reg_read(struct kvm_vcpu *vcpu)
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
@@ -786,7 +826,7 @@ int main(void)
 
 	ksft_print_header();
 
-	test_cnt = 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST;
+	test_cnt = 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST + GUEST_READ_TEST;
 	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
 		for (j = 0; test_regs[i].ftr_bits[j].type != FTR_END; j++)
 			test_cnt++;

-- 
2.47.2


