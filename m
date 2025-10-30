Return-Path: <linux-kselftest+bounces-44428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A93BFC21084
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56F874EF44D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D9365D3C;
	Thu, 30 Oct 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z462vBn/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33434365D38;
	Thu, 30 Oct 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839251; cv=none; b=plclE/ZLJuUaAX0Jc+jE+WX7eZQhu0ytDhSiiOxrBh45/JLCvF4J8HbkyySR/JHqP1mGpIaf/hTEKuEVaDyFZgolD+6falfQlGzo+jVZtTxHnrUOAh48PPc2SeWAHi8Z+EOYuq4BjNlUxT+Ttf7tnGsUOJi+lc2iSTJxshCLoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839251; c=relaxed/simple;
	bh=OOWNdlvS0e5zsqxUjtF1fvoktLBbLPB8K99I3mro3t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCQcdqCRa9PQeL59mAc/YhmCWW5qGAoV+vKPBOL2MZ/nE4VVI+3RAEmwBzyjOkIuQVEhQtLvqfXZpq0jtS1BSFVhsOskxjaPTikDlRDe1sv5y+1bY+E7Kj0nscYSYzA94cDR0Ic0bIHWY80ZxzyqwJH+3IcB37v3lYEvwt5zGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z462vBn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D954C4CEF8;
	Thu, 30 Oct 2025 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761839250;
	bh=OOWNdlvS0e5zsqxUjtF1fvoktLBbLPB8K99I3mro3t0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z462vBn/RLoPlxhd7s73he8E4WGDucxQzqbALxMU6rdKxBYIkwJNgRoA9SxAgMF+m
	 UTzeMswMREfTIsCmp9OkeBrR4QypyN8MLnUB90lRznZcUbjNIjODbtV4sv1DXRROOn
	 YVGYuMoxvtPDX8plp7gH8rAenc64CyRl1To8ybkCC6nBOb7ilPufyuOKBsIS8pCgO4
	 xYZADFOfTZQiHPPPVS6Nj7lCt3kf3oupx0OjH8n9npAoqGVdog9r9AC7Hl7L7dN6L7
	 rqawx5pL3oMAR8E2zUcohw+NEUTzTfLrPW/Y+MQa0aTC+xrKYR8H878NhFL+Fpk77z
	 cnJ+uyFJJYTRg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 30 Oct 2025 15:42:49 +0000
Subject: [PATCH 3/3] KVM: selftests: arm64: Make set_id_regs bitfield
 validatity checks non-fatal
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-kvm-arm64-set-id-regs-aarch64-v1-3-96fe0d2b178e@kernel.org>
References: <20251030-kvm-arm64-set-id-regs-aarch64-v1-0-96fe0d2b178e@kernel.org>
In-Reply-To: <20251030-kvm-arm64-set-id-regs-aarch64-v1-0-96fe0d2b178e@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=3523; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OOWNdlvS0e5zsqxUjtF1fvoktLBbLPB8K99I3mro3t0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpA4iH5fN2/5Tff1LcMsCzge14FRk/8Ks3KBfZ4
 yt+NPnAH4aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaQOIhwAKCRAk1otyXVSH
 0PTUB/4uSDubuCl1B4f68EVzEGnKq9mBneLwADJ3ffqD+fWz9cNQwtlSfdhONTTGLA6vlTJIkRO
 NhxPI1sfzazP7CZaiMWuR9Wsl9UqVQsbWSdMq+Y1ymue32Jca4wobaBqpeLeTa0p6RdE6jkk3Zf
 Tsjp2uMVnyGk9nyHiwdMhK4NRO6J6eGgV0SCVy8Fs+PcfQOLPOKFy4Dylfz5rmALisoY+95hYpA
 1uzMJLbMjtGCi9ycAiTcOvmFyCfFYzidA82BZuntLsz8v9pRIkYu3xON8eNYPsSqoZXUt/m1Y9o
 qsFdhrAf/UEkl/Wj7Ke39z4xTo/zZ2vTHVJWbUI08/KO9+Qa
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

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 1a53f3a4be8d..abe97f9293c9 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -405,6 +405,7 @@ static uint64_t test_reg_set_success(struct kvm_vcpu *vcpu, uint64_t reg,
 	uint8_t shift = ftr_bits->shift;
 	uint64_t mask = ftr_bits->mask;
 	uint64_t val, new_val, ftr;
+	bool match;
 
 	val = vcpu_get_reg(vcpu, reg);
 	ftr = (val & mask) >> shift;
@@ -417,7 +418,10 @@ static uint64_t test_reg_set_success(struct kvm_vcpu *vcpu, uint64_t reg,
 
 	vcpu_set_reg(vcpu, reg, val);
 	new_val = vcpu_get_reg(vcpu, reg);
-	TEST_ASSERT_EQ(new_val, val);
+	match = new_val == val;
+	if (!match)
+		ksft_print_msg("%lx != %lx\n", new_val, val);
+	ksft_test_result(match, "%s valid write succeeded\n", ftr_bits->name);
 
 	return new_val;
 }
@@ -429,6 +433,7 @@ static void test_reg_set_fail(struct kvm_vcpu *vcpu, uint64_t reg,
 	uint64_t mask = ftr_bits->mask;
 	uint64_t val, old_val, ftr;
 	int r;
+	bool match;
 
 	val = vcpu_get_reg(vcpu, reg);
 	ftr = (val & mask) >> shift;
@@ -445,7 +450,10 @@ static void test_reg_set_fail(struct kvm_vcpu *vcpu, uint64_t reg,
 		    "Unexpected KVM_SET_ONE_REG error: r=%d, errno=%d", r, errno);
 
 	val = vcpu_get_reg(vcpu, reg);
-	TEST_ASSERT_EQ(val, old_val);
+	match = val == old_val;
+	if (!match)
+		ksft_print_msg("%lx != %lx\n", val, old_val);
+	ksft_test_result(match, "%s invalid write rejected\n", ftr_bits->name);
 }
 
 static uint64_t test_reg_vals[KVM_ARM_FEATURE_ID_RANGE_SIZE];
@@ -485,7 +493,11 @@ static void test_vm_ftr_id_regs(struct kvm_vcpu *vcpu, bool aarch64_only)
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
@@ -497,8 +509,6 @@ static void test_vm_ftr_id_regs(struct kvm_vcpu *vcpu, bool aarch64_only)
 
 			test_reg_vals[idx] = test_reg_set_success(vcpu, reg,
 								  &ftr_bits[j]);
-
-			ksft_test_result_pass("%s\n", ftr_bits[j].name);
 		}
 	}
 }
@@ -835,7 +845,7 @@ int main(void)
 		ID_REG_RESET_UNCHANGED_TEST;
 	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
 		for (j = 0; test_regs[i].ftr_bits[j].type != FTR_END; j++)
-			test_cnt++;
+			test_cnt += 2;
 
 	ksft_set_plan(test_cnt);
 

-- 
2.47.2


