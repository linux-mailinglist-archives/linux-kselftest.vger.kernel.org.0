Return-Path: <linux-kselftest+bounces-47745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F27EFCD1A1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 20:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CAD23036D9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226B3446A7;
	Fri, 19 Dec 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sitanXwI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65344242D79;
	Fri, 19 Dec 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172539; cv=none; b=NRIhfbQsd7RAS+c6FYyTGmDUwpBKEW3uuxH9+PttHPUTHnJiL+JV7j4okaFevcfQ4lxbVncc6J/FoY2QtLHlfXVrBNLYiYGFrtintJ/syiGqgRgS6N+vp2TOE4f04pp9kS0cHPu3sR5CMNMlp0k7DjlsoTFoJzR20wq9ef5KrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172539; c=relaxed/simple;
	bh=R1XVjsx+s/KecSNN14H7GIfYrgADmWPCYDfI6Vk/UQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjG078+v3oi7vM3DGYQ/BCA7VH6IpMEUcU1MxC47/6/tMj1PHRtTZOpo+aXII41DsYIQr9fMEQVT1uWKeNhb+D/LxkQuJ1hPw0LiQCbk6F+3rE1UEM6N0CLXD097/fjbLVFM3FLIrtYgxT6O+8Ef4i2SJ/6KEloENjSt0FVjks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sitanXwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C428C116D0;
	Fri, 19 Dec 2025 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766172538;
	bh=R1XVjsx+s/KecSNN14H7GIfYrgADmWPCYDfI6Vk/UQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sitanXwIdTD/Dug9t4KURCJ5jl85QmRf1lcW0mjgnpj61+mUgkrPqtnFo5jtjc9zY
	 I8iyCBlegKZpyel92aOisIJMtdp5UDQOa6iKFOdDYfyUZpQtBoQ9pWC2fCSKQq9GP1
	 SW4CLpgKMKumMNynSxHBE8Z/fduyTLy0o/jMjTXmKx4fKkwJ+qXUvB3TrJiLRHaMtB
	 J24rJPO5GRJZLeZkPR6a3t2GujnFkYOZcPEJvDitn6bKlR8ElqF3HQw07FHVBpTIoC
	 /FEz0QIwElaQhfwFYd5WrBLa1fldiszxdiZZs+amO/D84cqeppd7AEvMCyhX049Ejt
	 4dnQp+/trUS6w==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 19 Dec 2025 19:28:09 +0000
Subject: [PATCH v3 3/4] KVM: selftests: arm64: Make set_id_regs bitfield
 validatity checks non-fatal
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-kvm-arm64-set-id-regs-aarch64-v3-3-bfa474ec3218@kernel.org>
References: <20251219-kvm-arm64-set-id-regs-aarch64-v3-0-bfa474ec3218@kernel.org>
In-Reply-To: <20251219-kvm-arm64-set-id-regs-aarch64-v3-0-bfa474ec3218@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Oliver Upton <oupton@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3523; i=broonie@kernel.org;
 h=from:subject:message-id; bh=R1XVjsx+s/KecSNN14H7GIfYrgADmWPCYDfI6Vk/UQY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpRadu7NYbE7SpZdFkNyj36p+IgIXd65kXL032t
 AAq8N3LpZCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUWnbgAKCRAk1otyXVSH
 0MeFB/9XIf8ZqxWuzQp2vtHgFYSDQNCB+eFJxCnC40RRKQcjkPb8MfFX/B+FuOlGb5V6H2AwkGp
 HSkwuelsnfm1k44kOheMrcIT7ZvVQ4k7HQi1Pwq3J9OlvtY/7avFIK1hxoDxsQIIvjEyT4wt5ed
 KLTv+ifLkKQodIwiQ6NIUrybfNEMNN6rHWLs9T9/SZfS257JJdG9F9ydXDpH8dji7A3tCbvp2D8
 rc4vcSwEBERKbxMYSzwuNyv0uruaLtbH9o3Q+HNFmK6ewmHa1RsMvfGuZvSASQn+zhJW2yc+6YL
 KjA/uZ+++lKyKTXu1BqPC4xHeO8RgiRCcnK2BBjHYvc1xxnA
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


