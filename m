Return-Path: <linux-kselftest+bounces-45656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 633B1C5E390
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 17:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E20F3C2157
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E4A32E137;
	Fri, 14 Nov 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiDWJd0v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907C32E126;
	Fri, 14 Nov 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134740; cv=none; b=EyNPib7Xo3ztOER6iu92EOuYAEftmsLqy94QJ6LjvzI8MDCb/aoIBC+LBeWdTczSECiXULndDgqYVCXbmMsTy/BoCHEMttCPpzk5940xvlbPG0VX5LTxxjyFvXycLy0q9Y5da0ADlBDEmnqtR0PV9jdn8GzPwwDQWgvDZMQaqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134740; c=relaxed/simple;
	bh=uNwDXUwlPyXEgttCCR2gAD/CSzRiWE8XchLoChLWNmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGl5vxHbwNGgvuxrP+rEFnsTBm/cfj7MtznIYaDkwjfZRuwAVcIslb+f1zM/OfVFutuLqTKnpg5Uu/oAQx3jYlPuOvLXRdbxUuJgFLhnP4e4bVpFYmY9bEbETMibcb8n8bEl58aH1ZPgErhK8pBzV1B1iYW8UHkmxAhP8V6xCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiDWJd0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAEEC4CEFB;
	Fri, 14 Nov 2025 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763134740;
	bh=uNwDXUwlPyXEgttCCR2gAD/CSzRiWE8XchLoChLWNmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eiDWJd0vyrOdBwR9stZ0zhpF0IHbzcqNEQgzkTwii3Bn/QOkTZ/vsmtawWqKTjz7e
	 rw9F8q8EydcaKFwjTIuHWbiHeRr/kjKqgwD06SAY/ynsS4hwXqfE0oCdQLPXh/RTCN
	 mLK0qZrsVaqMFqnhjGhmaT3CvwnJL9l1fYESDd5b4SjIOXTA9NIuIMlB862l0+/TuA
	 Li8d/XKemkVJCS0c+53xSv4wAWc4q88FUW/NapuRrDRh/m9n2mZR5R0m9TFFKsT0OI
	 QlZx1it3lbal3fMeC0uj1aITklUAsA0XxKiBQ8XwJ8tVnLOhQvYx/XWjuZOHR3HIog
	 jGd89XNcM97gQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Nov 2025 15:35:37 +0000
Subject: [PATCH v2 4/4] KVM: selftests: arm64: Skip all 32 bit IDs when
 set_id_regs is aarch64 only
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kvm-arm64-set-id-regs-aarch64-v2-4-672f214f41bf@kernel.org>
References: <20251114-kvm-arm64-set-id-regs-aarch64-v2-0-672f214f41bf@kernel.org>
In-Reply-To: <20251114-kvm-arm64-set-id-regs-aarch64-v2-0-672f214f41bf@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uNwDXUwlPyXEgttCCR2gAD/CSzRiWE8XchLoChLWNmw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpF00FlaR6CysOhNqJuXUWWXOCFqVSb6pOhNFeL
 HTvgq8VpbuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaRdNBQAKCRAk1otyXVSH
 0PHNB/9n9jGVcM3keHTaLahbLR+v1VCSDWfsgbzxVQB7r/YLwElPxt6CuWXXa527vbk0KqdY+1C
 h1vJRUn2ktLos+3q+obK/94l4yrbSV0OnbWLVVRPENUgwhX1AlLX5H6EIk6B8SUWMHArBmxqGOL
 O9CnniEyYaRZ2zT4g94IWXp6m8XfbAxMtluFZAlvUHFyOAJvFAO8Q7DXF1hV1OeZ7RmP6lEzmIl
 ZtoPLxR44pfes3ZEpZEYaoUiwBgyXj8UcoiId9VFNbKkjacMohBKs3abG7LsvDQEkxRYmajaERp
 H+lmh/A0KFRwz5u5Z9bzlJ7PrHX0A3iuVZIhfakK23tXlcGA
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
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 42 +++++++++++++++++--------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index abe97f9293c9..55e13aa758ff 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -671,7 +671,7 @@ static void test_user_set_mte_reg(struct kvm_vcpu *vcpu)
 		ksft_test_result_pass("ID_AA64PFR1_EL1.MTE_frac no longer 0xF\n");
 }
 
-static void test_guest_reg_read(struct kvm_vcpu *vcpu)
+static void test_guest_reg_read(struct kvm_vcpu *vcpu, bool aarch64_only)
 {
 	bool done = false;
 	struct ucall uc;
@@ -690,6 +690,13 @@ static void test_guest_reg_read(struct kvm_vcpu *vcpu)
 			reg_id = uc.args[2];
 			guest_val = uc.args[3];
 			expected_val = test_reg_vals[encoding_to_range_idx(reg_id)];
+
+			if (aarch64_only && sys_reg_CRm(reg_id) < 4) {
+				ksft_test_result_skip("%s value seen in guest\n",
+						      get_reg_name(reg_id));
+				break;
+			}
+
 			match = expected_val == guest_val;
 			if (!match)
 				ksft_print_msg("%lx != %lx\n",
@@ -781,12 +788,19 @@ static void test_vcpu_non_ftr_id_regs(struct kvm_vcpu *vcpu)
 	ksft_test_result_pass("%s\n", __func__);
 }
 
-static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encoding)
+static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encoding,
+					 bool aarch64_only)
 {
 	size_t idx = encoding_to_range_idx(encoding);
 	uint64_t observed;
 	bool pass;
 
+	if (aarch64_only && sys_reg_CRm(encoding) < 4) {
+		ksft_test_result_skip("%s unchanged by reset\n",
+				      get_reg_name(encoding));
+		return;
+	}
+
 	observed = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(encoding));
 	pass = test_reg_vals[idx] == observed;
 	if (!pass)
@@ -797,7 +811,8 @@ static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encodin
 
 #define ID_REG_RESET_UNCHANGED_TEST (ARRAY_SIZE(test_regs) + 6)
 
-static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
+static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu,
+					 bool aarch64_only)
 {
 	/*
 	 * Calls KVM_ARM_VCPU_INIT behind the scenes, which will do an
@@ -806,14 +821,15 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
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
@@ -855,9 +871,9 @@ int main(void)
 	test_user_set_mpam_reg(vcpu);
 	test_user_set_mte_reg(vcpu);
 
-	test_guest_reg_read(vcpu);
+	test_guest_reg_read(vcpu, aarch64_only);
 
-	test_reset_preserves_id_regs(vcpu);
+	test_reset_preserves_id_regs(vcpu, aarch64_only);
 
 	kvm_vm_free(vm);
 

-- 
2.47.2


