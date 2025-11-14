Return-Path: <linux-kselftest+bounces-45654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DDAC5E501
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 17:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B5AC3C1DD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71032A3CF;
	Fri, 14 Nov 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSVTlQ+9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E282329E77;
	Fri, 14 Nov 2025 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134735; cv=none; b=UyGad1Mn5ZxgFzKPGlaTCrPfsFfq0Iqyu0AU856xXkb1mA9BtLceo/wVVdBLmmyA+vDxhG39enisNyr/vL9q5MfUo7eAv1FDrHweaAyuH98HEGJVyHeThkB5dhAfxR0+y3pt36R0NQNVJjc8WfGKxC+3TeUtRTxByQd/ZL/PmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134735; c=relaxed/simple;
	bh=NZCHWtWgDq5zz30CCAR3ifMlNJpsHOdaSLoln4mIKFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWJIW8RQ1TMNlsUOgGWOuNxaXm4aP7Ip6OLtTjsXykOrO64uEJ71850n8kvqc2jHN4eOnKDdKOVY6bGW+5U6BONvbATNKYDD2go1JRlWt00TLHN216y3KN3zuJ4h7K7ObjPpEqTqSogez/lt803fCixvuOMpCkXJFod0uX0Qd5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSVTlQ+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEB5C4CEF5;
	Fri, 14 Nov 2025 15:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763134734;
	bh=NZCHWtWgDq5zz30CCAR3ifMlNJpsHOdaSLoln4mIKFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OSVTlQ+9h/egrqSsK0XbaROTf3A/nVsW6z7prKM3nrFWBaobTHTyApPdryv/2YiHJ
	 Purg8c8/YJzbhwoHcrAtieVd5bt6N6s0Yr4yj4WPe59gOObxDF1/Q/NTqV5Tdq462h
	 oynnKKJzFeb2Gi72aGHeUfvMRQHtM87IUWaqs9R6MVUbOR+WS39zusVrMruiApRLxG
	 042m1QimEwKJCC7xPdPGvTlubkxVq6XAha4V+FWo9rCLMfGCW5mijV4ueq5xvTd1Ko
	 k3/CslX5i/Qhdcu3vhhlEzYbBvKFq9cijjyR+czlXd/29GfMQR+PCvH3E9n0PdjpD4
	 i2MSCPob91tnA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Nov 2025 15:35:35 +0000
Subject: [PATCH v2 2/4] KVM: selftests: arm64: Report register reset tests
 individually
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kvm-arm64-set-id-regs-aarch64-v2-2-672f214f41bf@kernel.org>
References: <20251114-kvm-arm64-set-id-regs-aarch64-v2-0-672f214f41bf@kernel.org>
In-Reply-To: <20251114-kvm-arm64-set-id-regs-aarch64-v2-0-672f214f41bf@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NZCHWtWgDq5zz30CCAR3ifMlNJpsHOdaSLoln4mIKFs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpF00ExUPPIhXLM4+RvYN6tmyihAwwDeNdhhodj
 HEMG3Kfn9CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaRdNBAAKCRAk1otyXVSH
 0K97B/4wbGfo6mAfnV2qQY5eFEv2JIQ9tDu2+ZycsJbISJBH8opD6Mt4UeTuWR0bm1ai2dGuUv4
 0RFTc02NiXVMfjj6USZQJbKB1zBGWH/q/Roke0TLUjh5t6tYa5qwb9mAnB0mOnBscPkw2PTe4ZZ
 xio7KVodWYg9NFr9lIU2NQ/ZV3rb7Cg0PyabkC09FrLvACAOlDRqFQMCvdZT3IuvLXVahPmV10/
 qq/fWJtBkW9VDTPQZV+SwzrMseHpUzq0SV8k7SYNQXV7ySnNYEDiDUMRCz3jCL0YeTN3jgqz7fT
 MeyMBGPF2Dq4nYUrDCYqMJp5ekcHNmnu0GNRjsgC1eTwOwZt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

set_id_regs tests that registers have their values preserved over reset.
Currently it reports all registers in a single test with an instantly fatal
assert which isn't great for diagnostics, it's hard to tell which register
failed or if it's just one register. Change this to report each register as
a separate test so that it's clear from the program output which registers
have problems.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 7a759e976c2c..1a53f3a4be8d 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -775,11 +775,18 @@ static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encodin
 {
 	size_t idx = encoding_to_range_idx(encoding);
 	uint64_t observed;
+	bool pass;
 
 	observed = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(encoding));
-	TEST_ASSERT_EQ(test_reg_vals[idx], observed);
+	pass = test_reg_vals[idx] == observed;
+	if (!pass)
+		ksft_print_msg("%lx != %lx\n", test_reg_vals[idx], observed);
+	ksft_test_result(pass, "%s unchanged by reset\n",
+			 get_reg_name(encoding));
 }
 
+#define ID_REG_RESET_UNCHANGED_TEST (ARRAY_SIZE(test_regs) + 6)
+
 static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -797,8 +804,6 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 	test_assert_id_reg_unchanged(vcpu, SYS_MIDR_EL1);
 	test_assert_id_reg_unchanged(vcpu, SYS_REVIDR_EL1);
 	test_assert_id_reg_unchanged(vcpu, SYS_AIDR_EL1);
-
-	ksft_test_result_pass("%s\n", __func__);
 }
 
 int main(void)
@@ -826,7 +831,8 @@ int main(void)
 
 	ksft_print_header();
 
-	test_cnt = 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST + GUEST_READ_TEST;
+	test_cnt = 2 + MPAM_IDREG_TEST + MTE_IDREG_TEST + GUEST_READ_TEST +
+		ID_REG_RESET_UNCHANGED_TEST;
 	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
 		for (j = 0; test_regs[i].ftr_bits[j].type != FTR_END; j++)
 			test_cnt++;

-- 
2.47.2


