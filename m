Return-Path: <linux-kselftest+bounces-48313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFB1CF9727
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 17:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26AF030B3714
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED133AD8E;
	Tue,  6 Jan 2026 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOeqmHh5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5D33A9FB;
	Tue,  6 Jan 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717676; cv=none; b=qdR+NtD5D7XjVGT8Z4Jir4h32bYr+yCW3FVeiCI/IfNozJFQOdDxpr0zEUHyMTBbw04j7ZeUDH2gvLLlQUWbukoArYVuyZRRk0A1VtTTh86bXfTBvwb1aH3SoD5SbeLWYf0o4fFBc5o3HOMZcw3midoaMNffzZa9/XFcDKEQx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717676; c=relaxed/simple;
	bh=sTI4+mDiSC7/2y47jsx14QL1e72vNJ3oFg2mDK4zgrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9uKzfTDKN8DhN6EIFfgcAqoqfxBFzXLE99qsvfYmwURzyFbBQ6oMjswJyhKkRvuGzhph8B1cXWXv8nVUy2cUBB4PtYOu8kihA9Dhy9mPArCJkfTfoBDZpvDNoRXstcdsSuOOxIbKeEexvm0G7enPWu7QPR6oR11a5zFXHRE6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOeqmHh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E691C19423;
	Tue,  6 Jan 2026 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717675;
	bh=sTI4+mDiSC7/2y47jsx14QL1e72vNJ3oFg2mDK4zgrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DOeqmHh5qiymWpTCrVA2PxPnTd8KXB22aioXLa4c43XOGpAb6j2oBBI6bJ5S5ZVb3
	 PY2m0KcCmM/XOAtJdzYBStw65Yt26RPTzTSqnV2zg/1cM0LMgiV77Boy9Vcm6OCe8f
	 1wwiteDwcvLzhF7VQqbaChbeKVEOuwi4hF2D+JcmsAvhA/VVP9ji3Y6F7E5R2/+RXh
	 ulS56GBFVN/Y/SANc3GjyJU298mAxrGv6rVGTH51+atPiCSPtJVnXhXF+XQ2A1oNax
	 g0uvq3vEXz8S6P6WQ/cG+TLkPQXpkm6I0IhKisLmIcERMzhsId0t5+P1Au/jRqPYxM
	 kZs+U0YHJrgng==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Jan 2026 16:35:44 +0000
Subject: [PATCH v4 4/5] KVM: selftests: arm64: Skip all 32 bit IDs when
 set_id_regs is aarch64 only
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-kvm-arm64-set-id-regs-aarch64-v4-4-c7ef4551afb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4946; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sTI4+mDiSC7/2y47jsx14QL1e72vNJ3oFg2mDK4zgrM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpXTscjujbBQ4lD3eAZdJBtGaLW+JKB+w+mLqc1
 BL5OwRwcLGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaV07HAAKCRAk1otyXVSH
 0C2zB/9kwog5FznVGbSBeBSliDGc/Nk7qhmjTv9pHOsb1lN9oTkLqK+6MXy5B7otEfU1pbler7C
 h23w7+3NMwmCsEAMFNG3uN20L/trsNzDk6AdwP1h+qUvjo2f1QBGx/e3HwaOnb649cf0IFMgz/f
 ZEYrEWYC7Gpo03drn31jy9mP+YAY+Hyi8Mtw4XLHyCsvL0vD4eFjm7WqURAD0FapXVQpVjzgXPZ
 uv95rsXZiLhCKlQn3CJzF5tMYyOUyi8KCKAf465bQYSvTD1nU02Ozo20+AGAXaexFgFPaCBybiw
 7tvxQLhMK6lwsGS37RDSiWXZ3uu07B84zPieS2waZWv3eZX3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On an aarch64 only system the 32 bit ID registers have UNDEFINED values.
As a result set_id_regs skips tests for setting fields in these registers
when testing an aarch64 only guest. This has the side effect of meaning
that we don't record an expected value for these registers, meaning that
when the subsequent tests for values being visible in guests and preserved
over reset check the value they can spuriously fail. This can be seen by
running on an emulated system with both NV and 32 bit enabled, NV will
result in the guests created by the test program being 64 bit only but
the 32 bit ID registers will have values.

Also skip those tests that use the values set in the field setting tests
for aarch64 only guests in order to avoid these spurious failures.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 49 ++++++++++++++++++-------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 5837da63e9b9..908b3c8947d9 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -295,6 +295,13 @@ static const char *get_reg_name(u64 id)
 	}
 }
 
+static inline bool is_aarch32_id_reg(u64 id)
+{
+	return (sys_reg_Op0(id) == 3 && sys_reg_Op1(id) == 0 &&
+		sys_reg_CRn(id) == 0 && sys_reg_CRm(id) >= 1 &&
+		sys_reg_CRm(id) <= 3);
+}
+
 /* Return a safe value to a given ftr_bits an ftr value */
 uint64_t get_safe_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr)
 {
@@ -675,7 +682,7 @@ static void test_user_set_mte_reg(struct kvm_vcpu *vcpu)
 		ksft_test_result_pass("ID_AA64PFR1_EL1.MTE_frac no longer 0xF\n");
 }
 
-static void test_guest_reg_read(struct kvm_vcpu *vcpu)
+static void test_guest_reg_read(struct kvm_vcpu *vcpu, bool aarch64_only)
 {
 	bool done = false;
 	struct ucall uc;
@@ -694,6 +701,13 @@ static void test_guest_reg_read(struct kvm_vcpu *vcpu)
 			reg_id = uc.args[2];
 			guest_val = uc.args[3];
 			expected_val = test_reg_vals[encoding_to_range_idx(reg_id)];
+
+			if (aarch64_only && is_aarch32_id_reg(reg_id)) {
+				ksft_test_result_skip("%s value seen in guest\n",
+						      get_reg_name(reg_id));
+				break;
+			}
+
 			match = expected_val == guest_val;
 			if (!match)
 				ksft_print_msg("%lx != %lx\n",
@@ -785,12 +799,19 @@ static void test_vcpu_non_ftr_id_regs(struct kvm_vcpu *vcpu)
 	ksft_test_result_pass("%s\n", __func__);
 }
 
-static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encoding)
+static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encoding,
+					 bool aarch64_only)
 {
 	size_t idx = encoding_to_range_idx(encoding);
 	uint64_t observed;
 	bool pass;
 
+	if (aarch64_only && is_aarch32_id_reg(encoding)) {
+		ksft_test_result_skip("%s unchanged by reset\n",
+				      get_reg_name(encoding));
+		return;
+	}
+
 	observed = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(encoding));
 	pass = test_reg_vals[idx] == observed;
 	if (!pass)
@@ -801,7 +822,8 @@ static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encodin
 
 #define ID_REG_RESET_UNCHANGED_TEST (ARRAY_SIZE(test_regs) + 6)
 
-static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
+static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu,
+					 bool aarch64_only)
 {
 	/*
 	 * Calls KVM_ARM_VCPU_INIT behind the scenes, which will do an
@@ -810,14 +832,15 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 	aarch64_vcpu_setup(vcpu, NULL);
 
 	for (int i = 0; i < ARRAY_SIZE(test_regs); i++)
-		test_assert_id_reg_unchanged(vcpu, test_regs[i].reg);
-
-	test_assert_id_reg_unchanged(vcpu, SYS_MPIDR_EL1);
-	test_assert_id_reg_unchanged(vcpu, SYS_CLIDR_EL1);
-	test_assert_id_reg_unchanged(vcpu, SYS_CTR_EL0);
-	test_assert_id_reg_unchanged(vcpu, SYS_MIDR_EL1);
-	test_assert_id_reg_unchanged(vcpu, SYS_REVIDR_EL1);
-	test_assert_id_reg_unchanged(vcpu, SYS_AIDR_EL1);
+		test_assert_id_reg_unchanged(vcpu, test_regs[i].reg,
+					     aarch64_only);
+
+	test_assert_id_reg_unchanged(vcpu, SYS_MPIDR_EL1, aarch64_only);
+	test_assert_id_reg_unchanged(vcpu, SYS_CLIDR_EL1, aarch64_only);
+	test_assert_id_reg_unchanged(vcpu, SYS_CTR_EL0, aarch64_only);
+	test_assert_id_reg_unchanged(vcpu, SYS_MIDR_EL1, aarch64_only);
+	test_assert_id_reg_unchanged(vcpu, SYS_REVIDR_EL1, aarch64_only);
+	test_assert_id_reg_unchanged(vcpu, SYS_AIDR_EL1, aarch64_only);
 }
 
 int main(void)
@@ -859,9 +882,9 @@ int main(void)
 	test_user_set_mpam_reg(vcpu);
 	test_user_set_mte_reg(vcpu);
 
-	test_guest_reg_read(vcpu);
+	test_guest_reg_read(vcpu, aarch64_only);
 
-	test_reset_preserves_id_regs(vcpu);
+	test_reset_preserves_id_regs(vcpu, aarch64_only);
 
 	kvm_vm_free(vm);
 

-- 
2.47.3


