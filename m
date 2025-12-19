Return-Path: <linux-kselftest+bounces-47744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6977CD1A1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 20:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A81C73033585
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B3C33AD9B;
	Fri, 19 Dec 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRS+LcaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4A2D29C7;
	Fri, 19 Dec 2025 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172537; cv=none; b=pTdKmwU8MMD06gBcmw5XMFvnJPx7TJZ2uFrWxCtHleGnn1jUcgKOeFWqS3t54MTPflGtp1D9mb8WO64zXGs5QSydOqR/IOtKSMWoaytVjtYB48AgllRJ+w5khFVKapkOfIQQajctzEtJXOP3f/2wu5jMq9GDLyheo52iiCRrdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172537; c=relaxed/simple;
	bh=SdYdUswJJiZaW0PkSaAFAoCdE/2lYRbBCPt0U91wSxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMlnm2obMPRFVynRePyyo9iHmLr3p/NzbZIs3T7atLpPa8fqW+Yn/D7ZQnJ3uFYmjahGgUyH3IDBGXBXTfJSYVvhAGFvc+bvvT/F1d9+gQbdWnLtoZy4zDZoh25L7euzsqLEqdStlLjZFY5m5Sd1q4nLedCaXVldq35c6Rzt0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRS+LcaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AD4C4CEF1;
	Fri, 19 Dec 2025 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766172536;
	bh=SdYdUswJJiZaW0PkSaAFAoCdE/2lYRbBCPt0U91wSxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nRS+LcaYKl/DMoBzXvuyOtROXvyzMXADsK6tPR1ihh0inlbly03MOGmPAxryDND5u
	 WIPuI5ER2sMzDFk+mdDuAkZ9jym+DxdyS4mgz+CEOARNGAgHqiMIgxVl99AXmpHr1g
	 O7btdXtKsB81g5n38iu6xKleTVB4MynnykbmdBhADd/474I+XWTr1DQleYpvL7vfEZ
	 WnqgMzgSWKrCjhHLsjRJhys/w6O81JX3sXYhZCe+pl/OUqN3xuflsIfQ2iIZneaKps
	 L3NXKUAyciHrtoU+Yi88uyej4+98LK/sMFea40E5p0XUH8yTJ5h5r5syxTBv+WTfX+
	 bbJzIL2khMf9w==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 19 Dec 2025 19:28:08 +0000
Subject: [PATCH v3 2/4] KVM: selftests: arm64: Report register reset tests
 individually
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-kvm-arm64-set-id-regs-aarch64-v3-2-bfa474ec3218@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SdYdUswJJiZaW0PkSaAFAoCdE/2lYRbBCPt0U91wSxc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpRaduyXOPQ7ybAubYxY5U6OC4+AhX+gS6mGJas
 FH+FffP8s2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUWnbgAKCRAk1otyXVSH
 0MCHB/9Qlhp2TdS0PikTLxu+Wv7EjxCICvVDUjybZ889JVmaaYKh1rQkTc696oeHE9Q4rESyyKk
 0agfINuguF0+oLxSxfEjbjwNGPotuosJLXWv6o7paIXtkuXTWHsAnHM4IcKW19FmCQz1AKIXrLy
 o64vKFk3kUvDaL4EvSB8OPmje/jvtqeZsXV8+WZ7Ka1BCFsnCVyMUjsuPUo8OAzfu2icqa2saLZ
 11UUJ4hHbWJAzniuL4yIat5ZaefYZSqErypFaSsjewSMmit5t16MwfHmyoM7ObzZK4PK1ks3Yeu
 LukLDeBzk/fijANyoqfhLTjsRwQ1Pl30UO51NiDPjPUPOEYR
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
index 84e9484a4899..b61942895808 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -779,11 +779,18 @@ static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encodin
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
@@ -801,8 +808,6 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 	test_assert_id_reg_unchanged(vcpu, SYS_MIDR_EL1);
 	test_assert_id_reg_unchanged(vcpu, SYS_REVIDR_EL1);
 	test_assert_id_reg_unchanged(vcpu, SYS_AIDR_EL1);
-
-	ksft_test_result_pass("%s\n", __func__);
 }
 
 int main(void)
@@ -830,7 +835,8 @@ int main(void)
 
 	ksft_print_header();
 
-	test_cnt = 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST + GUEST_READ_TEST;
+	test_cnt = 2 + MPAM_IDREG_TEST + MTE_IDREG_TEST + GUEST_READ_TEST +
+		ID_REG_RESET_UNCHANGED_TEST;
 	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
 		for (j = 0; test_regs[i].ftr_bits[j].type != FTR_END; j++)
 			test_cnt++;

-- 
2.47.3


