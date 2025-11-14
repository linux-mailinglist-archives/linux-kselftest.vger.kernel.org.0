Return-Path: <linux-kselftest+bounces-45653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E81C5E0AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 16:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25B33BE06C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32C329C72;
	Fri, 14 Nov 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAKIiGmL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D4329C56;
	Fri, 14 Nov 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134733; cv=none; b=kMatPBnBbdkcSJAn4sIdrD3iixoBEDfZa2y8+NFdaXHSiCybNO9WbrYeeYnBZkNhuMerFF989IRdR0SvrAmRslzwJKgdsFl8zzA122B7iX34Xwof9kY4HUDSmQ4deGA8ftod/ioBn1rOcAIm/Upvb8NCNyghhyGVRCGtjETDdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134733; c=relaxed/simple;
	bh=RdNQKxgZm3NWUTfwaPWZhZgP0H44bwRSahfMp4ZPmWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cDF5DQIsP+TDWxPWnMtE9dDFZzSLiw6Z0Q9NAmiiPfk9p0KMvbLogIwkMryV9i2r7smoXkkLbrJocnCgso4tAHBIwGu5jSmAYXT65XZ9FFmjV0eDsSlmm58GJwZ/+q5zs/fd79wBrQDUl9iRtcIADHhQRwsE54QFc3Vyi8LLr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAKIiGmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07A8C4CEF8;
	Fri, 14 Nov 2025 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763134732;
	bh=RdNQKxgZm3NWUTfwaPWZhZgP0H44bwRSahfMp4ZPmWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dAKIiGmLR5NXD624H9jsEUkpObc2dqs5DvTJsFF8O+hgynx5WxltE40k5Yt4ordg5
	 SKGr3f+U0tybO2QVZff+fEx8xZ/uojk/WbsIrBXu0qPhMtA1lTmymoju4V2+adzVIo
	 IkYWJ0OPsuta8oH/03jAx5LEWaWkxms16lYOF2uO8ItMVTCi1efHVtNsPMbKR1pmFF
	 JG2k2UL3oy0VmJkwzwnczGZxhXvCiPAw7n4I0KZTfbRYQVNV0tuS3MtoIga1BKLWgm
	 GT+BFDQUk5Lr8hAIN/TAVQZrERvRykXLO3HtWpUY53subFDghSsVWB5c5kB7vtfwGZ
	 XTGGWEX6piqQQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Nov 2025 15:35:34 +0000
Subject: [PATCH v2 1/4] KVM: selftests: arm64: Report set_id_reg reads of
 test registers as tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kvm-arm64-set-id-regs-aarch64-v2-1-672f214f41bf@kernel.org>
References: <20251114-kvm-arm64-set-id-regs-aarch64-v2-0-672f214f41bf@kernel.org>
In-Reply-To: <20251114-kvm-arm64-set-id-regs-aarch64-v2-0-672f214f41bf@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=4838; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RdNQKxgZm3NWUTfwaPWZhZgP0H44bwRSahfMp4ZPmWY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpF00DPaiz6v63rB7oygsadzrmHcsa6RWXbc75A
 SXhJr81cu6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaRdNAwAKCRAk1otyXVSH
 0Mi8CACDDWBh8r+sr0FccV8LeR4kZbJ7pwxaznHaM1w5YwjFkbiMSqnc2wJP8znj/EJahtQSzwj
 Xr3bwuvDPahqRJHbrvqAUhBweXxA4eOxCICjNpLX8iiPpDID/ZUe8FEhfwoWeKyZ7G+6i7DgO9I
 ed018gXi188CQ97oTDJctlKT4SANHJVdi93i/MN7v+1cjAhVw3fNXqOob51oeJ7hxuZUEAahacX
 RQPzkmtLZd81Ae6EpzdfvLfib3ikrTrMAUYmko/OzgLv3QJSeAYjYEk/GqAWATH4/NCMzR5GKQk
 Mq9ku0Rkje+e0QUMnpk4RJ3AcughUmNG4Ltqo+y2nDvRLkc3
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


