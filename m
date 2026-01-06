Return-Path: <linux-kselftest+bounces-48312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8435CF9721
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 17:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D43D309352C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87AE339879;
	Tue,  6 Jan 2026 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3ORLSG7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F393370F2;
	Tue,  6 Jan 2026 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717673; cv=none; b=p4ZfWkLdL+r1QVDmHqmXChtWdgZJdMPTdqjjtitBRiKY/xHN6F1FhE8sxf42pgZu9gYm2d9VfAk9cd0CCOT2hokNmSLjVYsHcPwKyadsW9MGdKH6VJglNWsq7krZtY8CPq7t6UTleH3yTJweZqF5dmy1YGkuIjrq8VduoiOeyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717673; c=relaxed/simple;
	bh=vQwUfvI6XJk7lLf5MWlbiQC9X9/qXYABnqN9jIpJqAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LkDY0g8+D6C05sBZhVF0Zn7d9xoAY9mK6r8nHfZPDQdhTxnyEaG5edCSrrXJ17S2DPNjrq8UOZh+9nm+9knx4E52qDODNmyrsjyMvU+UFHnJ6z6mgx8GC2iz+WBm+XECe+LtHrstkD/h0dkBQcOTRbPQgZleJXwKNmEMs8YCZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3ORLSG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE22C16AAE;
	Tue,  6 Jan 2026 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717673;
	bh=vQwUfvI6XJk7lLf5MWlbiQC9X9/qXYABnqN9jIpJqAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j3ORLSG7A4BqhpswDYY/TRN+gY+ryF65XLYSIZCDbpJcMgvayG6S4aD154Em3+sFT
	 83HrEtN2Mo7PK3bGzGSR/KPNpodO8lZy+lT6nNiFvOTqi/fhajkRK9bBBdWiOWOl9x
	 gwRhjHqhUO7OXVuU1ou0iDCY5ShJ5tTEeESaOAztLYIWzf8qkIiTGIxlv8RqkTKxeu
	 5s2E8eQRFb+ywmB88MxZOBEVW01qM41LC5pFJ2DY3Gd232A7wAh4nm9x2pqRY2rCdn
	 jLXABpoJjASgp8bk60bDoHDmlBTeg+JiuQI89wiYh+NT0T7ehhuz3JyBaz1Bn6VyBa
	 DVH4DDJHAmUUQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Jan 2026 16:35:43 +0000
Subject: [PATCH v4 3/5] KVM: selftests: arm64: Make set_id_regs bitfield
 validatity checks non-fatal
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-kvm-arm64-set-id-regs-aarch64-v4-3-c7ef4551afb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3569; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vQwUfvI6XJk7lLf5MWlbiQC9X9/qXYABnqN9jIpJqAc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpXTsbXQiYc4EG7OfsfGydUeV3e3kU3WjEtqHrR
 nLZODyD+JSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaV07GwAKCRAk1otyXVSH
 0HXeB/4yXr2++OUpaf7D+SElAM4rdRCoBYNhM6EeeipcCPJdoXaqu00e+5IetILU2+BKjG/Ob8j
 zUOoW5yyBdRS8xet5p8lVGO4ZfgaV0q2jQwFl9YYeGxqIOF5jmdnmcsAH/qTNbwDdKjUN7oUMsY
 W/TKqebetnTLaulUEOJ4iio9oofwMxVCWgb/WzGs9XlUKDaSMAbpKlHD2XXrCHjXWwMy2R6kr08
 TqCLoRXJAYj/5fSHhlkDWZPuomaNidZNMbakV/c0NoRBsToCGhF42l47YlWFzHaMnta72Qn8c8N
 EBNAqTGhP+ZLcoC/hXIvVfciwclrJxO5uTUG/VQZCjtabAAE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently when set_id_regs encounters a problem checking validation of
writes to feature registers it uses an immediately fatal assert to report
the problem. This is not idiomatic for kselftest, and it is also not great
for usability. The affected bitfield is not clearly reported and further
tests do not have their results reported.

Switch to using standard kselftest result reporting for the two asserts
we do, these are non-fatal asserts so allow the program to continue and the
test names include the affected field.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index b61942895808..5837da63e9b9 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -409,6 +409,7 @@ static uint64_t test_reg_set_success(struct kvm_vcpu *vcpu, uint64_t reg,
 	uint8_t shift = ftr_bits->shift;
 	uint64_t mask = ftr_bits->mask;
 	uint64_t val, new_val, ftr;
+	bool match;
 
 	val = vcpu_get_reg(vcpu, reg);
 	ftr = (val & mask) >> shift;
@@ -421,7 +422,10 @@ static uint64_t test_reg_set_success(struct kvm_vcpu *vcpu, uint64_t reg,
 
 	vcpu_set_reg(vcpu, reg, val);
 	new_val = vcpu_get_reg(vcpu, reg);
-	TEST_ASSERT_EQ(new_val, val);
+	match = new_val == val;
+	if (!match)
+		ksft_print_msg("%lx != %lx\n", new_val, val);
+	ksft_test_result(match, "%s valid write succeeded\n", ftr_bits->name);
 
 	return new_val;
 }
@@ -433,6 +437,7 @@ static void test_reg_set_fail(struct kvm_vcpu *vcpu, uint64_t reg,
 	uint64_t mask = ftr_bits->mask;
 	uint64_t val, old_val, ftr;
 	int r;
+	bool match;
 
 	val = vcpu_get_reg(vcpu, reg);
 	ftr = (val & mask) >> shift;
@@ -449,7 +454,10 @@ static void test_reg_set_fail(struct kvm_vcpu *vcpu, uint64_t reg,
 		    "Unexpected KVM_SET_ONE_REG error: r=%d, errno=%d", r, errno);
 
 	val = vcpu_get_reg(vcpu, reg);
-	TEST_ASSERT_EQ(val, old_val);
+	match = val == old_val;
+	if (!match)
+		ksft_print_msg("%lx != %lx\n", val, old_val);
+	ksft_test_result(match, "%s invalid write rejected\n", ftr_bits->name);
 }
 
 static uint64_t test_reg_vals[KVM_ARM_FEATURE_ID_RANGE_SIZE];
@@ -489,7 +497,11 @@ static void test_vm_ftr_id_regs(struct kvm_vcpu *vcpu, bool aarch64_only)
 		for (int j = 0;  ftr_bits[j].type != FTR_END; j++) {
 			/* Skip aarch32 reg on aarch64 only system, since they are RAZ/WI. */
 			if (aarch64_only && sys_reg_CRm(reg_id) < 4) {
-				ksft_test_result_skip("%s on AARCH64 only system\n",
+				ksft_print_msg("%s on AARCH64 only system\n",
+					       ftr_bits[j].name);
+				ksft_test_result_skip("%s invalid write rejected\n",
+						      ftr_bits[j].name);
+				ksft_test_result_skip("%s valid write succeeded\n",
 						      ftr_bits[j].name);
 				continue;
 			}
@@ -501,8 +513,6 @@ static void test_vm_ftr_id_regs(struct kvm_vcpu *vcpu, bool aarch64_only)
 
 			test_reg_vals[idx] = test_reg_set_success(vcpu, reg,
 								  &ftr_bits[j]);
-
-			ksft_test_result_pass("%s\n", ftr_bits[j].name);
 		}
 	}
 }
@@ -839,7 +849,7 @@ int main(void)
 		ID_REG_RESET_UNCHANGED_TEST;
 	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
 		for (j = 0; test_regs[i].ftr_bits[j].type != FTR_END; j++)
-			test_cnt++;
+			test_cnt += 2;
 
 	ksft_set_plan(test_cnt);
 

-- 
2.47.3


